module 0xc41f3056b81d328b8ba567e48b490709554c37d7916959a1e469665921779f59::Bbay {
    use std::signer;
    use std::vector;
    use std::option::{Self, Option};
    use std::string::String;
    use std::bcs;
    use std::error;
    // use std::debug;                              //for testing only//....

    use aptos_std::table::{Self, Table};
    use aptos_std::type_info::{Self, TypeInfo};
    use aptos_std::aptos_hash;

    use aptos_framework::account;
    use aptos_framework::event::{Self, EventHandle};
    use aptos_framework::coin;
    use aptos_framework::timestamp;
    use aptos_framework::aptos_coin::AptosCoin;



   

    struct Owner has key {
        owner_address: address,
        user_count:u64,
        inventory_volume:u64,
        resource_account:Table<address,address>,
    }

    struct ResourceAccountSignerCap has key {
        signer_cap: account::SignerCapability,
    }
    // add timestamp 
    struct Products has key {
        sr_number:Table<u64,u64>,
        item_id:Table<u64,u64>,
        item_name: Table<u64,vector<u64>>,
        item_sold: Table<u64,bool>,
        item_price: Table<u64,u64>,
    }
    
    // add timestamp
    struct User has key{
        user_id:u64,
        orders: vector<u64>,
        order_status: vector<u64>,
        payment_status: vector<u64>,
    }

    // payment uints.
    const PAYMENT_PENDING:u64 = 1;
    const PREPAID_ORDER :u64 = 2;
    const PAID_ON_DELIVERY:u64 = 3;

    // order status.
    const ORDER_PLACED:u64 = 1;
    const ORDER_ACCEPTED:u64 = 2;
    const ORDER_SHIPPED:u64 = 3;
    const ORDER_DELIVERED:u64 = 4;


    //error codes
    const EUSER_ID_ENTERED_IS_WRONG:u64 = 100;


    fun init_module(account:&signer) {
        
        move_to(account, Owner {
            owner_address: signer::address_of(account),
            user_count: 0,
            inventory_volume:0,
            resource_account : table::new(),
        });

        move_to(account, Products {
            sr_number:table::new(),
        item_id:table::new(),
        item_name: table::new(),
        item_sold:table::new(),
        item_price: table::new(),
        });
    }

    public entry fun register_account(account:&signer, seed:vector<u8>)acquires Owner {
        let owner_data = borrow_global_mut<Owner>(@admin);
        owner_data.user_count = owner_data.user_count +1;
        // let num:u8 = 12;
        // let seed = vector::empty();
        // vector::push_back(&mut seed,num);
        let (resource_account, resource_account_signer_cap) = account::create_resource_account(account, seed);
        move_to(&resource_account,User{
            user_id: owner_data.user_count,
            orders: vector::empty(),
            order_status: vector::empty(),
            payment_status: vector::empty(),
        });

        coin::register<AptosCoin>(&resource_account);
        move_to(&resource_account, ResourceAccountSignerCap{
            signer_cap: resource_account_signer_cap,
        });
        
    }


    public entry fun add_items(
        account:&signer,
        item_id:u64,
        item_name:vector<u64>,
        item_quantity:u64,
        item_price:u64,
    )acquires Products, Owner{
        let i = 0;
        let owner_data = borrow_global_mut<Owner>(signer::address_of(account));
        let resource_account = *table::borrow(&owner_data.resource_account,signer::address_of(account)) ;
        let product_data = borrow_global_mut<Products>(resource_account);
        let num_of_products = &mut owner_data.inventory_volume;
        while(i <= *num_of_products + item_quantity && i > *num_of_products) {
            while(i > *num_of_products){
            table::add(&mut product_data.sr_number,i,item_id);
            table::add(&mut product_data.item_price,i,item_price);
            table::add(&mut product_data.item_id, i,item_id);
            table::add(&mut product_data.item_sold,i,false);
            if(i > *num_of_products + item_quantity) {
                break
            }
            };
            *num_of_products = *num_of_products + 1;
            i = i+1;

        };
        table::add(&mut product_data.item_name, item_id, item_name);

    }


    public entry fun order<CoinType>(
        account:&signer,
        sr_no:u64,
        prepaid:bool)acquires Owner,User,Products,ResourceAccountSignerCap {
        let resource_account = get_resource_account(signer::address_of(account));
        let signer_cap = borrow_global<ResourceAccountSignerCap>(resource_account);
        let resource_account_signer = account::create_signer_with_capability(&signer_cap.signer_cap);
        let user_data = borrow_global_mut<User>(resource_account);
        let product_data = borrow_global<Products>(@admin);
        vector::push_back(&mut user_data.orders,sr_no);
        vector::push_back(&mut user_data.order_status,ORDER_PLACED);
        if(prepaid == true){
            coin::transfer<CoinType>(&resource_account_signer,@admin,*table::borrow(&product_data.item_price,sr_no));
            vector::push_back(&mut user_data.payment_status,PREPAID_ORDER);
        }else{
            vector::push_back(&mut user_data.payment_status,PAYMENT_PENDING);
        };

    } 

// if admin is adding 1 product with 'n' number of quantity, eg nike jordan with 100 quantity Sr.no. 1010, then the serial number (1010 + n) ahead of this item's serial number will also be its own serial but product id will be same for 'n' number of Sr.numbers.
    public entry fun trigger_delivery(
        account:&signer,
        user_id:u64,
        user_resource_account:address,
        order_id:u64,
    )acquires User,Products,Owner{
        let admin_resource_account = get_resource_account(signer::address_of(account));
        let user_data = borrow_global_mut<User>(user_resource_account);
        assert!(user_id == user_data.user_id,error::invalid_argument(EUSER_ID_ENTERED_IS_WRONG));
        let i = 0;
        let _order = 0;
        while (i> 0){
            if(*vector::borrow(&user_data.orders, i) == order_id){
                _order = *vector::borrow(&user_data.orders, i);
                break
            };
            i = i+1;
        };
        let _status = *vector::borrow_mut(&mut user_data.order_status,i);
        _status = ORDER_SHIPPED;

        let products_data = borrow_global_mut<Products>(admin_resource_account);
        let _item_sold = *table::borrow_mut(&mut products_data.item_sold , i);
        _item_sold = true;
    }

    public entry fun update_devliery_done<CoinType>(
        account:&signer,
        user_id:u64,
        user_resource_account:address,
        order_id:u64,
    )acquires User,Products,ResourceAccountSignerCap{
        let user_data = borrow_global_mut<User>(user_resource_account);
        let product_data = borrow_global<Products>(signer::address_of(account));
        let signer_cap = borrow_global<ResourceAccountSignerCap>(signer::address_of(account));
        assert!(user_id == user_data.user_id,error::invalid_argument(EUSER_ID_ENTERED_IS_WRONG));
        let resource_account_signer = account::create_signer_with_capability(&signer_cap.signer_cap);
        let payment_status = vector::borrow_mut(&mut user_data.payment_status,order_id);
        if(*payment_status == PAYMENT_PENDING) {
            coin::transfer<CoinType>(&resource_account_signer,@admin,*table::borrow(&product_data.item_price,order_id));
            *payment_status = PAID_ON_DELIVERY;
        };
        let _status = *vector::borrow_mut(&mut user_data.order_status, order_id);
        _status = ORDER_DELIVERED;
    }



    #[view]
    public fun get_resource_account(addr: address): address acquires Owner {
        let account_info = borrow_global<Owner>(@admin);
        *table::borrow(&account_info.resource_account, addr)
    }



}