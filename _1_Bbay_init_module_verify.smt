(set-option :print-success false)
(set-info :smt-lib-version 2.6)
(set-option :produce-models true)
(set-option :model_validate true)
(set-option :smt.QI.EAGER_THRESHOLD 100)
(set-option :smt.QI.LAZY_THRESHOLD 100)
(set-option :trace true)
(set-option :trace_file_name z3.trace)
(set-option :smt.random_seed 1)
(set-option :smt.mbqi false)
(set-option :model.compact false)
(set-option :model.v2 true)
(set-option :pp.bv_literals false)
; done setting options


(declare-fun tickleBool (Bool) Bool)
(assert (and (tickleBool true) (tickleBool false)))
(declare-sort |T@#0| 0)
(declare-sort |T@[Int]#0| 0)
(declare-sort |T@[Int]Int| 0)
(declare-sort |T@[Int]$1_aggregator_Aggregator| 0)
(declare-sort |T@[Int]$1_optional_aggregator_Integer| 0)
(declare-sort |T@[Int]$1_optional_aggregator_OptionalAggregator| 0)
(declare-sort |T@[Int](_ BitVec 64)| 0)
(declare-sort |T@[Int](_ BitVec 8)| 0)
(declare-sort |T@[Int]Bool| 0)
(declare-sort |T@[Int]Vec_6673| 0)
(declare-sort |T@[Int]$1_account_Account| 0)
(declare-sort |T@[Int]$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| 0)
(declare-sort |T@[Int]$1_coin_CoinInfo'#0'| 0)
(declare-sort |T@[Int]$1_coin_CoinStore'$1_aptos_coin_AptosCoin'| 0)
(declare-sort |T@[Int]$1_coin_CoinStore'#0'| 0)
(declare-sort |T@[Int]$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'| 0)
(declare-sort |T@[Int]$1_coin_Ghost$supply'#0'| 0)
(declare-sort |T@[Int]$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'| 0)
(declare-sort |T@[Int]$1_coin_Ghost$aggregate_supply'#0'| 0)
(declare-sort |T@[Int]$1_aptos_coin_AptosCoin| 0)
(declare-sort |T@[Int]$1_Bbay_Owner| 0)
(declare-sort |T@[Int]$1_Bbay_Products| 0)
(declare-sort |T@[Int]$1_Bbay_ResourceAccountSignerCap| 0)
(declare-sort |T@[Int]$1_Bbay_User| 0)
(declare-datatypes ((T@$Memory_132314 0)) ((($Memory_132314 (|domain#$Memory_132314| |T@[Int]Bool|) (|contents#$Memory_132314| |T@[Int]#0|) ) ) ))
(declare-datatypes ((T@Vec_68162 0)) (((Vec_68162 (|v#Vec_68162| |T@[Int](_ BitVec 8)|) (|l#Vec_68162| Int) ) ) ))
(declare-datatypes ((T@Vec_67815 0)) (((Vec_67815 (|v#Vec_67815| |T@[Int](_ BitVec 64)|) (|l#Vec_67815| Int) ) ) ))
(declare-datatypes ((T@Vec_85428 0)) (((Vec_85428 (|v#Vec_85428| |T@[Int]#0|) (|l#Vec_85428| Int) ) ) ))
(declare-datatypes ((T@Table_35290_35291 0)) (((Table_35290_35291 (|v#Table_35290_35291| |T@[Int]Bool|) (|e#Table_35290_35291| |T@[Int]Bool|) (|l#Table_35290_35291| Int) ) ) ))
(declare-datatypes ((T@Table_36177_36178 0)) (((Table_36177_36178 (|v#Table_36177_36178| |T@[Int]Int|) (|e#Table_36177_36178| |T@[Int]Bool|) (|l#Table_36177_36178| Int) ) ) ))
(declare-datatypes ((T@$1_Bbay_Owner 0)) ((($1_Bbay_Owner (|$owner_address#$1_Bbay_Owner| Int) (|$user_count#$1_Bbay_Owner| Int) (|$num_of_products_added#$1_Bbay_Owner| Int) (|$resource_account#$1_Bbay_Owner| T@Table_36177_36178) ) ) ))
(declare-datatypes ((T@$Memory_158769 0)) ((($Memory_158769 (|domain#$Memory_158769| |T@[Int]Bool|) (|contents#$Memory_158769| |T@[Int]$1_Bbay_Owner|) ) ) ))
(declare-datatypes ((T@$1_aptos_coin_AptosCoin 0)) ((($1_aptos_coin_AptosCoin (|$dummy_field#$1_aptos_coin_AptosCoin| Bool) ) ) ))
(declare-datatypes ((T@$Memory_158560 0)) ((($Memory_158560 (|domain#$Memory_158560| |T@[Int]Bool|) (|contents#$Memory_158560| |T@[Int]$1_aptos_coin_AptosCoin|) ) ) ))
(declare-datatypes ((|T@$1_coin_Ghost$aggregate_supply'#0'| 0)) (((|$1_coin_Ghost$aggregate_supply'#0'| (|$v#$1_coin_Ghost$aggregate_supply'#0'| Int) ) ) ))
(declare-datatypes ((T@$Memory_152511 0)) ((($Memory_152511 (|domain#$Memory_152511| |T@[Int]Bool|) (|contents#$Memory_152511| |T@[Int]$1_coin_Ghost$aggregate_supply'#0'|) ) ) ))
(declare-datatypes ((|T@$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'| 0)) (((|$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'| (|$v#$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'| Int) ) ) ))
(declare-datatypes ((T@$Memory_152450 0)) ((($Memory_152450 (|domain#$Memory_152450| |T@[Int]Bool|) (|contents#$Memory_152450| |T@[Int]$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'|) ) ) ))
(declare-datatypes ((|T@$1_coin_Ghost$supply'#0'| 0)) (((|$1_coin_Ghost$supply'#0'| (|$v#$1_coin_Ghost$supply'#0'| Int) ) ) ))
(declare-datatypes ((T@$Memory_152389 0)) ((($Memory_152389 (|domain#$Memory_152389| |T@[Int]Bool|) (|contents#$Memory_152389| |T@[Int]$1_coin_Ghost$supply'#0'|) ) ) ))
(declare-datatypes ((|T@$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'| 0)) (((|$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'| (|$v#$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'| Int) ) ) ))
(declare-datatypes ((T@$Memory_152328 0)) ((($Memory_152328 (|domain#$Memory_152328| |T@[Int]Bool|) (|contents#$Memory_152328| |T@[Int]$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'|) ) ) ))
(declare-datatypes ((T@$1_coin_WithdrawEvent 0)) ((($1_coin_WithdrawEvent (|$amount#$1_coin_WithdrawEvent| Int) ) ) ))
(declare-datatypes ((T@$1_coin_DepositEvent 0)) ((($1_coin_DepositEvent (|$amount#$1_coin_DepositEvent| Int) ) ) ))
(declare-datatypes ((|T@$1_coin_Coin'#0'| 0)) (((|$1_coin_Coin'#0'| (|$value#$1_coin_Coin'#0'| Int) ) ) ))
(declare-datatypes ((|T@$1_coin_Coin'$1_aptos_coin_AptosCoin'| 0)) (((|$1_coin_Coin'$1_aptos_coin_AptosCoin'| (|$value#$1_coin_Coin'$1_aptos_coin_AptosCoin'| Int) ) ) ))
(declare-datatypes ((T@$1_account_SignerCapability 0)) ((($1_account_SignerCapability (|$account#$1_account_SignerCapability| Int) ) ) ))
(declare-datatypes ((T@$1_Bbay_ResourceAccountSignerCap 0)) ((($1_Bbay_ResourceAccountSignerCap (|$signer_cap#$1_Bbay_ResourceAccountSignerCap| T@$1_account_SignerCapability) ) ) ))
(declare-datatypes ((T@$Memory_159333 0)) ((($Memory_159333 (|domain#$Memory_159333| |T@[Int]Bool|) (|contents#$Memory_159333| |T@[Int]$1_Bbay_ResourceAccountSignerCap|) ) ) ))
(declare-datatypes ((T@$1_account_RotationCapability 0)) ((($1_account_RotationCapability (|$account#$1_account_RotationCapability| Int) ) ) ))
(declare-datatypes ((T@$1_guid_ID 0)) ((($1_guid_ID (|$creation_num#$1_guid_ID| Int) (|$addr#$1_guid_ID| Int) ) ) ))
(declare-datatypes ((T@$1_guid_GUID 0)) ((($1_guid_GUID (|$id#$1_guid_GUID| T@$1_guid_ID) ) ) ))
(declare-datatypes ((|T@$1_event_EventHandle'$1_coin_WithdrawEvent'| 0)) (((|$1_event_EventHandle'$1_coin_WithdrawEvent'| (|$counter#$1_event_EventHandle'$1_coin_WithdrawEvent'| Int) (|$guid#$1_event_EventHandle'$1_coin_WithdrawEvent'| T@$1_guid_GUID) ) ) ))
(declare-datatypes ((|T@$1_event_EventHandle'$1_coin_DepositEvent'| 0)) (((|$1_event_EventHandle'$1_coin_DepositEvent'| (|$counter#$1_event_EventHandle'$1_coin_DepositEvent'| Int) (|$guid#$1_event_EventHandle'$1_coin_DepositEvent'| T@$1_guid_GUID) ) ) ))
(declare-datatypes ((|T@$1_coin_CoinStore'#0'| 0)) (((|$1_coin_CoinStore'#0'| (|$coin#$1_coin_CoinStore'#0'| |T@$1_coin_Coin'#0'|) (|$frozen#$1_coin_CoinStore'#0'| Bool) (|$deposit_events#$1_coin_CoinStore'#0'| |T@$1_event_EventHandle'$1_coin_DepositEvent'|) (|$withdraw_events#$1_coin_CoinStore'#0'| |T@$1_event_EventHandle'$1_coin_WithdrawEvent'|) ) ) ))
(declare-datatypes ((T@$Memory_152181 0)) ((($Memory_152181 (|domain#$Memory_152181| |T@[Int]Bool|) (|contents#$Memory_152181| |T@[Int]$1_coin_CoinStore'#0'|) ) ) ))
(declare-datatypes ((|T@$1_coin_CoinStore'$1_aptos_coin_AptosCoin'| 0)) (((|$1_coin_CoinStore'$1_aptos_coin_AptosCoin'| (|$coin#$1_coin_CoinStore'$1_aptos_coin_AptosCoin'| |T@$1_coin_Coin'$1_aptos_coin_AptosCoin'|) (|$frozen#$1_coin_CoinStore'$1_aptos_coin_AptosCoin'| Bool) (|$deposit_events#$1_coin_CoinStore'$1_aptos_coin_AptosCoin'| |T@$1_event_EventHandle'$1_coin_DepositEvent'|) (|$withdraw_events#$1_coin_CoinStore'$1_aptos_coin_AptosCoin'| |T@$1_event_EventHandle'$1_coin_WithdrawEvent'|) ) ) ))
(declare-datatypes ((T@$Memory_151955 0)) ((($Memory_151955 (|domain#$Memory_151955| |T@[Int]Bool|) (|contents#$Memory_151955| |T@[Int]$1_coin_CoinStore'$1_aptos_coin_AptosCoin'|) ) ) ))
(declare-datatypes ((|T@$1_event_EventHandle'$1_account_KeyRotationEvent'| 0)) (((|$1_event_EventHandle'$1_account_KeyRotationEvent'| (|$counter#$1_event_EventHandle'$1_account_KeyRotationEvent'| Int) (|$guid#$1_event_EventHandle'$1_account_KeyRotationEvent'| T@$1_guid_GUID) ) ) ))
(declare-datatypes ((|T@$1_event_EventHandle'$1_account_CoinRegisterEvent'| 0)) (((|$1_event_EventHandle'$1_account_CoinRegisterEvent'| (|$counter#$1_event_EventHandle'$1_account_CoinRegisterEvent'| Int) (|$guid#$1_event_EventHandle'$1_account_CoinRegisterEvent'| T@$1_guid_GUID) ) ) ))
(declare-datatypes ((T@$1_optional_aggregator_Integer 0)) ((($1_optional_aggregator_Integer (|$value#$1_optional_aggregator_Integer| Int) (|$limit#$1_optional_aggregator_Integer| Int) ) ) ))
(declare-datatypes ((T@Vec_95276 0)) (((Vec_95276 (|v#Vec_95276| |T@[Int]$1_optional_aggregator_Integer|) (|l#Vec_95276| Int) ) ) ))
(declare-datatypes ((|T@$1_option_Option'$1_optional_aggregator_Integer'| 0)) (((|$1_option_Option'$1_optional_aggregator_Integer'| (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| T@Vec_95276) ) ) ))
(declare-datatypes ((T@Vec_6673 0)) (((Vec_6673 (|v#Vec_6673| |T@[Int]Int|) (|l#Vec_6673| Int) ) ) ))
(declare-datatypes ((T@Table_37064_126051 0)) (((Table_37064_126051 (|v#Table_37064_126051| |T@[Int]Vec_6673|) (|e#Table_37064_126051| |T@[Int]Bool|) (|l#Table_37064_126051| Int) ) ) ))
(declare-datatypes ((T@$1_Bbay_User 0)) ((($1_Bbay_User (|$user_id#$1_Bbay_User| Int) (|$orders#$1_Bbay_User| T@Vec_6673) (|$order_status#$1_Bbay_User| T@Vec_6673) (|$payment_status#$1_Bbay_User| T@Vec_6673) ) ) ))
(declare-datatypes ((T@$Memory_159573 0)) ((($Memory_159573 (|domain#$Memory_159573| |T@[Int]Bool|) (|contents#$Memory_159573| |T@[Int]$1_Bbay_User|) ) ) ))
(declare-datatypes ((T@$1_Bbay_Products 0)) ((($1_Bbay_Products (|$sr_number#$1_Bbay_Products| T@Table_36177_36178) (|$item_id#$1_Bbay_Products| T@Vec_6673) (|$item_name#$1_Bbay_Products| T@Table_37064_126051) (|$item_sold#$1_Bbay_Products| T@Table_35290_35291) (|$item_price#$1_Bbay_Products| T@Table_36177_36178) (|$item_on_selling#$1_Bbay_Products| T@Table_35290_35291) ) ) ))
(declare-datatypes ((T@$Memory_159266 0)) ((($Memory_159266 (|domain#$Memory_159266| |T@[Int]Bool|) (|contents#$Memory_159266| |T@[Int]$1_Bbay_Products|) ) ) ))
(declare-datatypes ((T@$1_account_KeyRotationEvent 0)) ((($1_account_KeyRotationEvent (|$old_authentication_key#$1_account_KeyRotationEvent| T@Vec_6673) (|$new_authentication_key#$1_account_KeyRotationEvent| T@Vec_6673) ) ) ))
(declare-datatypes ((T@$1_type_info_TypeInfo 0)) ((($1_type_info_TypeInfo (|$account_address#$1_type_info_TypeInfo| Int) (|$module_name#$1_type_info_TypeInfo| T@Vec_6673) (|$struct_name#$1_type_info_TypeInfo| T@Vec_6673) ) ) ))
(declare-datatypes ((T@$1_account_CoinRegisterEvent 0)) ((($1_account_CoinRegisterEvent (|$type_info#$1_account_CoinRegisterEvent| T@$1_type_info_TypeInfo) ) ) ))
(declare-datatypes ((T@$1_string_String 0)) ((($1_string_String (|$bytes#$1_string_String| T@Vec_6673) ) ) ))
(declare-datatypes ((|T@$1_option_Option'address'| 0)) (((|$1_option_Option'address'| (|$vec#$1_option_Option'address'| T@Vec_6673) ) ) ))
(declare-datatypes ((|T@$1_account_CapabilityOffer'$1_account_SignerCapability'| 0)) (((|$1_account_CapabilityOffer'$1_account_SignerCapability'| (|$for#$1_account_CapabilityOffer'$1_account_SignerCapability'| |T@$1_option_Option'address'|) ) ) ))
(declare-datatypes ((|T@$1_account_CapabilityOffer'$1_account_RotationCapability'| 0)) (((|$1_account_CapabilityOffer'$1_account_RotationCapability'| (|$for#$1_account_CapabilityOffer'$1_account_RotationCapability'| |T@$1_option_Option'address'|) ) ) ))
(declare-datatypes ((T@$1_account_Account 0)) ((($1_account_Account (|$authentication_key#$1_account_Account| T@Vec_6673) (|$sequence_number#$1_account_Account| Int) (|$guid_creation_num#$1_account_Account| Int) (|$coin_register_events#$1_account_Account| |T@$1_event_EventHandle'$1_account_CoinRegisterEvent'|) (|$key_rotation_events#$1_account_Account| |T@$1_event_EventHandle'$1_account_KeyRotationEvent'|) (|$rotation_capability_offer#$1_account_Account| |T@$1_account_CapabilityOffer'$1_account_RotationCapability'|) (|$signer_capability_offer#$1_account_Account| |T@$1_account_CapabilityOffer'$1_account_SignerCapability'|) ) ) ))
(declare-datatypes ((T@$Memory_145744 0)) ((($Memory_145744 (|domain#$Memory_145744| |T@[Int]Bool|) (|contents#$Memory_145744| |T@[Int]$1_account_Account|) ) ) ))
(declare-datatypes ((T@$TypeParamInfo 0)) ((($TypeParamBool ) ($TypeParamU8 ) ($TypeParamU16 ) ($TypeParamU32 ) ($TypeParamU64 ) ($TypeParamU128 ) ($TypeParamU256 ) ($TypeParamAddress ) ($TypeParamSigner ) ($TypeParamVector (|e#$TypeParamVector| T@$TypeParamInfo) ) ($TypeParamStruct (|a#$TypeParamStruct| Int) (|m#$TypeParamStruct| T@Vec_6673) (|s#$TypeParamStruct| T@Vec_6673) ) ) ))
(declare-datatypes ((T@$signer 0)) ((($signer (|$addr#$signer| Int) ) ) ))
(declare-datatypes ((T@$Location 0)) ((($Global (|a#$Global| Int) ) ($Local (|i#$Local| Int) ) ($Param (|i#$Param| Int) ) ($Uninitialized ) ) ))
(declare-datatypes ((T@$Mutation_163035 0)) ((($Mutation_163035 (|l#$Mutation_163035| T@$Location) (|p#$Mutation_163035| T@Vec_6673) (|v#$Mutation_163035| T@$1_Bbay_User) ) ) ))
(declare-datatypes ((T@$Mutation_159617 0)) ((($Mutation_159617 (|l#$Mutation_159617| T@$Location) (|p#$Mutation_159617| T@Vec_6673) (|v#$Mutation_159617| T@$1_Bbay_Products) ) ) ))
(declare-datatypes ((T@$Mutation_159596 0)) ((($Mutation_159596 (|l#$Mutation_159596| T@$Location) (|p#$Mutation_159596| T@Vec_6673) (|v#$Mutation_159596| T@$1_Bbay_Owner) ) ) ))
(declare-datatypes ((T@$Mutation_157471 0)) ((($Mutation_157471 (|l#$Mutation_157471| T@$Location) (|p#$Mutation_157471| T@Vec_6673) (|v#$Mutation_157471| |T@$1_event_EventHandle'$1_coin_WithdrawEvent'|) ) ) ))
(declare-datatypes ((T@$Mutation_153706 0)) ((($Mutation_153706 (|l#$Mutation_153706| T@$Location) (|p#$Mutation_153706| T@Vec_6673) (|v#$Mutation_153706| |T@$1_event_EventHandle'$1_coin_DepositEvent'|) ) ) ))
(declare-datatypes ((T@$Mutation_153678 0)) ((($Mutation_153678 (|l#$Mutation_153678| T@$Location) (|p#$Mutation_153678| T@Vec_6673) (|v#$Mutation_153678| |T@$1_coin_CoinStore'#0'|) ) ) ))
(declare-datatypes ((T@$Mutation_152557 0)) ((($Mutation_152557 (|l#$Mutation_152557| T@$Location) (|p#$Mutation_152557| T@Vec_6673) (|v#$Mutation_152557| |T@$1_coin_Ghost$supply'#0'|) ) ) ))
(declare-datatypes ((T@$Mutation_152529 0)) ((($Mutation_152529 (|l#$Mutation_152529| T@$Location) (|p#$Mutation_152529| T@Vec_6673) (|v#$Mutation_152529| |T@$1_coin_Coin'#0'|) ) ) ))
(declare-datatypes ((T@$Mutation_149976 0)) ((($Mutation_149976 (|l#$Mutation_149976| T@$Location) (|p#$Mutation_149976| T@Vec_6673) (|v#$Mutation_149976| |T@$1_event_EventHandle'$1_account_CoinRegisterEvent'|) ) ) ))
(declare-datatypes ((T@$Mutation_148229 0)) ((($Mutation_148229 (|l#$Mutation_148229| T@$Location) (|p#$Mutation_148229| T@Vec_6673) (|v#$Mutation_148229| |T@$1_option_Option'address'|) ) ) ))
(declare-datatypes ((T@$Mutation_148208 0)) ((($Mutation_148208 (|l#$Mutation_148208| T@$Location) (|p#$Mutation_148208| T@Vec_6673) (|v#$Mutation_148208| |T@$1_account_CapabilityOffer'$1_account_SignerCapability'|) ) ) ))
(declare-datatypes ((T@$Mutation_147502 0)) ((($Mutation_147502 (|l#$Mutation_147502| T@$Location) (|p#$Mutation_147502| T@Vec_6673) (|v#$Mutation_147502| T@$1_account_Account) ) ) ))
(declare-datatypes ((T@$Mutation_126518 0)) ((($Mutation_126518 (|l#$Mutation_126518| T@$Location) (|p#$Mutation_126518| T@Vec_6673) (|v#$Mutation_126518| T@Table_37064_126051) ) ) ))
(declare-datatypes ((T@$Mutation_124844 0)) ((($Mutation_124844 (|l#$Mutation_124844| T@$Location) (|p#$Mutation_124844| T@Vec_6673) (|v#$Mutation_124844| T@Table_36177_36178) ) ) ))
(declare-datatypes ((T@$Mutation_35848 0)) ((($Mutation_35848 (|l#$Mutation_35848| T@$Location) (|p#$Mutation_35848| T@Vec_6673) (|v#$Mutation_35848| Bool) ) ) ))
(declare-datatypes ((T@$Mutation_123244 0)) ((($Mutation_123244 (|l#$Mutation_123244| T@$Location) (|p#$Mutation_123244| T@Vec_6673) (|v#$Mutation_123244| T@Table_35290_35291) ) ) ))
(declare-datatypes ((T@$Mutation_68425 0)) ((($Mutation_68425 (|l#$Mutation_68425| T@$Location) (|p#$Mutation_68425| T@Vec_6673) (|v#$Mutation_68425| (_ BitVec 8)) ) ) ))
(declare-datatypes ((T@$Mutation_119685 0)) ((($Mutation_119685 (|l#$Mutation_119685| T@$Location) (|p#$Mutation_119685| T@Vec_6673) (|v#$Mutation_119685| T@Vec_68162) ) ) ))
(declare-datatypes ((T@$Mutation_68078 0)) ((($Mutation_68078 (|l#$Mutation_68078| T@$Location) (|p#$Mutation_68078| T@Vec_6673) (|v#$Mutation_68078| (_ BitVec 64)) ) ) ))
(declare-datatypes ((T@$Mutation_115844 0)) ((($Mutation_115844 (|l#$Mutation_115844| T@$Location) (|p#$Mutation_115844| T@Vec_6673) (|v#$Mutation_115844| T@Vec_67815) ) ) ))
(declare-datatypes ((T@$Mutation_26543 0)) ((($Mutation_26543 (|l#$Mutation_26543| T@$Location) (|p#$Mutation_26543| T@Vec_6673) (|v#$Mutation_26543| Int) ) ) ))
(declare-datatypes ((T@$Mutation_105895 0)) ((($Mutation_105895 (|l#$Mutation_105895| T@$Location) (|p#$Mutation_105895| T@Vec_6673) (|v#$Mutation_105895| T@Vec_6673) ) ) ))
(declare-datatypes ((T@$Mutation_99099 0)) ((($Mutation_99099 (|l#$Mutation_99099| T@$Location) (|p#$Mutation_99099| T@Vec_6673) (|v#$Mutation_99099| T@$1_optional_aggregator_Integer) ) ) ))
(declare-datatypes ((T@$Mutation_96128 0)) ((($Mutation_96128 (|l#$Mutation_96128| T@$Location) (|p#$Mutation_96128| T@Vec_6673) (|v#$Mutation_96128| T@Vec_95276) ) ) ))
(declare-datatypes ((T@$Mutation_89266 0)) ((($Mutation_89266 (|l#$Mutation_89266| T@$Location) (|p#$Mutation_89266| T@Vec_6673) (|v#$Mutation_89266| |T@#0|) ) ) ))
(declare-datatypes ((T@$Mutation_86282 0)) ((($Mutation_86282 (|l#$Mutation_86282| T@$Location) (|p#$Mutation_86282| T@Vec_6673) (|v#$Mutation_86282| T@Vec_85428) ) ) ))
(declare-datatypes ((T@$Range 0)) ((($Range (|lb#$Range| Int) (|ub#$Range| Int) ) ) ))
(declare-datatypes ((T@$1_aggregator_Aggregator 0)) ((($1_aggregator_Aggregator (|$handle#$1_aggregator_Aggregator| Int) (|$key#$1_aggregator_Aggregator| Int) (|$limit#$1_aggregator_Aggregator| Int) (|$val#$1_aggregator_Aggregator| Int) ) ) ))
(declare-datatypes ((T@$Mutation_94200 0)) ((($Mutation_94200 (|l#$Mutation_94200| T@$Location) (|p#$Mutation_94200| T@Vec_6673) (|v#$Mutation_94200| T@$1_aggregator_Aggregator) ) ) ))
(declare-datatypes ((T@Vec_90390 0)) (((Vec_90390 (|v#Vec_90390| |T@[Int]$1_aggregator_Aggregator|) (|l#Vec_90390| Int) ) ) ))
(declare-datatypes ((T@$Mutation_91229 0)) ((($Mutation_91229 (|l#$Mutation_91229| T@$Location) (|p#$Mutation_91229| T@Vec_6673) (|v#$Mutation_91229| T@Vec_90390) ) ) ))
(declare-datatypes ((|T@$1_option_Option'$1_aggregator_Aggregator'| 0)) (((|$1_option_Option'$1_aggregator_Aggregator'| (|$vec#$1_option_Option'$1_aggregator_Aggregator'| T@Vec_90390) ) ) ))
(declare-datatypes ((T@$1_optional_aggregator_OptionalAggregator 0)) ((($1_optional_aggregator_OptionalAggregator (|$aggregator#$1_optional_aggregator_OptionalAggregator| |T@$1_option_Option'$1_aggregator_Aggregator'|) (|$integer#$1_optional_aggregator_OptionalAggregator| |T@$1_option_Option'$1_optional_aggregator_Integer'|) ) ) ))
(declare-datatypes ((T@$Mutation_104095 0)) ((($Mutation_104095 (|l#$Mutation_104095| T@$Location) (|p#$Mutation_104095| T@Vec_6673) (|v#$Mutation_104095| T@$1_optional_aggregator_OptionalAggregator) ) ) ))
(declare-datatypes ((T@Vec_100175 0)) (((Vec_100175 (|v#Vec_100175| |T@[Int]$1_optional_aggregator_OptionalAggregator|) (|l#Vec_100175| Int) ) ) ))
(declare-datatypes ((T@$Mutation_101124 0)) ((($Mutation_101124 (|l#$Mutation_101124| T@$Location) (|p#$Mutation_101124| T@Vec_6673) (|v#$Mutation_101124| T@Vec_100175) ) ) ))
(declare-datatypes ((|T@$1_option_Option'$1_optional_aggregator_OptionalAggregator'| 0)) (((|$1_option_Option'$1_optional_aggregator_OptionalAggregator'| (|$vec#$1_option_Option'$1_optional_aggregator_OptionalAggregator'| T@Vec_100175) ) ) ))
(declare-datatypes ((|T@$1_coin_CoinInfo'#0'| 0)) (((|$1_coin_CoinInfo'#0'| (|$name#$1_coin_CoinInfo'#0'| T@$1_string_String) (|$symbol#$1_coin_CoinInfo'#0'| T@$1_string_String) (|$decimals#$1_coin_CoinInfo'#0'| Int) (|$supply#$1_coin_CoinInfo'#0'| |T@$1_option_Option'$1_optional_aggregator_OptionalAggregator'|) ) ) ))
(declare-datatypes ((T@$Memory_151729 0)) ((($Memory_151729 (|domain#$Memory_151729| |T@[Int]Bool|) (|contents#$Memory_151729| |T@[Int]$1_coin_CoinInfo'#0'|) ) ) ))
(declare-datatypes ((|T@$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| 0)) (((|$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| (|$name#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| T@$1_string_String) (|$symbol#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| T@$1_string_String) (|$decimals#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| Int) (|$supply#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| |T@$1_option_Option'$1_optional_aggregator_OptionalAggregator'|) ) ) ))
(declare-datatypes ((T@$Memory_151507 0)) ((($Memory_151507 (|domain#$Memory_151507| |T@[Int]Bool|) (|contents#$Memory_151507| |T@[Int]$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'|) ) ) ))
(declare-fun $MAX_U128 () Int)
(declare-fun $shlU256 (Int Int) Int)
(declare-fun $pow (Int Int) Int)
(declare-fun $TypeName (T@$TypeParamInfo) T@Vec_6673)
(declare-fun |$IsEqual'vec'u8''| (T@Vec_6673 T@Vec_6673) Bool)
(declare-fun |Store__T@[Int]Int_| (|T@[Int]Int| Int Int) |T@[Int]Int|)
(declare-fun |Select__T@[Int]Int_| (|T@[Int]Int| Int) Int)
(assert (forall ( ( ?x0 |T@[Int]Int|) ( ?x1 Int) ( ?x2 Int)) (! (= (|Select__T@[Int]Int_| (|Store__T@[Int]Int_| ?x0 ?x1 ?x2) ?x1)  ?x2) :weight 0)))
(assert (forall ( ( ?x0 |T@[Int]Int|) ( ?x1 Int) ( ?y1 Int) ( ?x2 Int)) (! (=>  (not (= ?x1 ?y1)) (= (|Select__T@[Int]Int_| (|Store__T@[Int]Int_| ?x0 ?x1 ?x2) ?y1) (|Select__T@[Int]Int_| ?x0 ?y1))) :weight 0)))
(declare-fun MapConstVec_25347 (Int) |T@[Int]Int|)
(declare-fun DefaultVecElem_25347 () Int)
(declare-fun |Select__T@[Int]#0_| (|T@[Int]#0| Int) |T@#0|)
(declare-fun |lambda#1| (Int Int |T@[Int]#0| Int Int |T@#0|) |T@[Int]#0|)
(declare-fun |Select__T@[Int]$1_aggregator_Aggregator_| (|T@[Int]$1_aggregator_Aggregator| Int) T@$1_aggregator_Aggregator)
(declare-fun |lambda#5| (Int Int |T@[Int]$1_aggregator_Aggregator| Int Int T@$1_aggregator_Aggregator) |T@[Int]$1_aggregator_Aggregator|)
(declare-fun |Select__T@[Int]$1_optional_aggregator_Integer_| (|T@[Int]$1_optional_aggregator_Integer| Int) T@$1_optional_aggregator_Integer)
(declare-fun |lambda#9| (Int Int |T@[Int]$1_optional_aggregator_Integer| Int Int T@$1_optional_aggregator_Integer) |T@[Int]$1_optional_aggregator_Integer|)
(declare-fun |Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|T@[Int]$1_optional_aggregator_OptionalAggregator| Int) T@$1_optional_aggregator_OptionalAggregator)
(declare-fun |lambda#13| (Int Int |T@[Int]$1_optional_aggregator_OptionalAggregator| Int Int T@$1_optional_aggregator_OptionalAggregator) |T@[Int]$1_optional_aggregator_OptionalAggregator|)
(declare-fun |lambda#17| (Int Int |T@[Int]Int| Int Int Int) |T@[Int]Int|)
(declare-fun |Select__T@[Int](_ BitVec 64)_| (|T@[Int](_ BitVec 64)| Int) (_ BitVec 64))
(declare-fun |lambda#21| (Int Int |T@[Int](_ BitVec 64)| Int Int (_ BitVec 64)) |T@[Int](_ BitVec 64)|)
(declare-fun |Select__T@[Int](_ BitVec 8)_| (|T@[Int](_ BitVec 8)| Int) (_ BitVec 8))
(declare-fun |lambda#25| (Int Int |T@[Int](_ BitVec 8)| Int Int (_ BitVec 8)) |T@[Int](_ BitVec 8)|)
(declare-fun $shr (Int Int) Int)
(declare-fun |$IsValid'$1_aggregator_Aggregator'| (T@$1_aggregator_Aggregator) Bool)
(declare-fun |$IsValid'address'| (Int) Bool)
(declare-fun |$IsValid'u128'| (Int) Bool)
(declare-fun |$IsValid'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| (|T@$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'|) Bool)
(declare-fun |$IsValid'$1_string_String'| (T@$1_string_String) Bool)
(declare-fun |$IsValid'u8'| (Int) Bool)
(declare-fun |$IsValid'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| (|T@$1_option_Option'$1_optional_aggregator_OptionalAggregator'|) Bool)
(declare-fun |$IsValid'$1_coin_CoinInfo'#0''| (|T@$1_coin_CoinInfo'#0'|) Bool)
(declare-fun |$IsValid'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''| (|T@$1_coin_CoinStore'$1_aptos_coin_AptosCoin'|) Bool)
(declare-fun |$IsValid'$1_coin_Coin'$1_aptos_coin_AptosCoin''| (|T@$1_coin_Coin'$1_aptos_coin_AptosCoin'|) Bool)
(declare-fun |$IsValid'$1_event_EventHandle'$1_coin_DepositEvent''| (|T@$1_event_EventHandle'$1_coin_DepositEvent'|) Bool)
(declare-fun |$IsValid'$1_event_EventHandle'$1_coin_WithdrawEvent''| (|T@$1_event_EventHandle'$1_coin_WithdrawEvent'|) Bool)
(declare-fun |$IsValid'$1_coin_CoinStore'#0''| (|T@$1_coin_CoinStore'#0'|) Bool)
(declare-fun |$IsValid'$1_coin_Coin'#0''| (|T@$1_coin_Coin'#0'|) Bool)
(declare-fun |$IsValid'$1_Bbay_Owner'| (T@$1_Bbay_Owner) Bool)
(declare-fun |$IsValid'u64'| (Int) Bool)
(declare-fun |$IsValid'$1_table_Table'address_address''| (T@Table_36177_36178) Bool)
(declare-fun |$IsValid'$1_Bbay_User'| (T@$1_Bbay_User) Bool)
(declare-fun |$IsValid'vec'u64''| (T@Vec_6673) Bool)
(declare-fun $ConstMemoryDomain (Bool) |T@[Int]Bool|)
(declare-fun |lambda#28| (Bool) |T@[Int]Bool|)
(declare-fun |$IsValid'$1_optional_aggregator_Integer'| (T@$1_optional_aggregator_Integer) Bool)
(declare-fun |$IsValid'$1_optional_aggregator_OptionalAggregator'| (T@$1_optional_aggregator_OptionalAggregator) Bool)
(declare-fun |$IsValid'$1_option_Option'$1_aggregator_Aggregator''| (|T@$1_option_Option'$1_aggregator_Aggregator'|) Bool)
(declare-fun |$IsValid'$1_option_Option'$1_optional_aggregator_Integer''| (|T@$1_option_Option'$1_optional_aggregator_Integer'|) Bool)
(declare-fun |$IsValid'$1_guid_ID'| (T@$1_guid_ID) Bool)
(declare-fun |$IsValid'$1_event_EventHandle'$1_account_CoinRegisterEvent''| (|T@$1_event_EventHandle'$1_account_CoinRegisterEvent'|) Bool)
(declare-fun |$IsValid'$1_guid_GUID'| (T@$1_guid_GUID) Bool)
(declare-fun |$IsValid'$1_event_EventHandle'$1_account_KeyRotationEvent''| (|T@$1_event_EventHandle'$1_account_KeyRotationEvent'|) Bool)
(declare-fun |$IsValid'$1_account_KeyRotationEvent'| (T@$1_account_KeyRotationEvent) Bool)
(declare-fun |$IsValid'vec'u8''| (T@Vec_6673) Bool)
(declare-fun |$IsEqual'vec'#0''| (T@Vec_85428 T@Vec_85428) Bool)
(declare-fun InRangeVec_65852 (T@Vec_85428 Int) Bool)
(declare-fun |$IsEqual'vec'$1_aggregator_Aggregator''| (T@Vec_90390 T@Vec_90390) Bool)
(declare-fun InRangeVec_66199 (T@Vec_90390 Int) Bool)
(declare-fun |$IsEqual'vec'$1_optional_aggregator_Integer''| (T@Vec_95276 T@Vec_95276) Bool)
(declare-fun InRangeVec_66546 (T@Vec_95276 Int) Bool)
(declare-fun |$IsEqual'vec'$1_optional_aggregator_OptionalAggregator''| (T@Vec_100175 T@Vec_100175) Bool)
(declare-fun InRangeVec_66893 (T@Vec_100175 Int) Bool)
(declare-fun |$IsEqual'vec'address''| (T@Vec_6673 T@Vec_6673) Bool)
(declare-fun InRangeVec_25002 (T@Vec_6673 Int) Bool)
(declare-fun |$IsEqual'vec'u64''| (T@Vec_6673 T@Vec_6673) Bool)
(declare-fun |$IsEqual'vec'bv64''| (T@Vec_67815 T@Vec_67815) Bool)
(declare-fun InRangeVec_67819 (T@Vec_67815 Int) Bool)
(declare-fun |$IsEqual'vec'bv8''| (T@Vec_68162 T@Vec_68162) Bool)
(declare-fun InRangeVec_68166 (T@Vec_68162 Int) Bool)
(declare-fun |$IsPrefix'vec'#0''| (T@Vec_85428 T@Vec_85428) Bool)
(declare-fun |$IsPrefix'vec'$1_aggregator_Aggregator''| (T@Vec_90390 T@Vec_90390) Bool)
(declare-fun |$IsPrefix'vec'$1_optional_aggregator_Integer''| (T@Vec_95276 T@Vec_95276) Bool)
(declare-fun |$IsPrefix'vec'$1_optional_aggregator_OptionalAggregator''| (T@Vec_100175 T@Vec_100175) Bool)
(declare-fun |$IsPrefix'vec'address''| (T@Vec_6673 T@Vec_6673) Bool)
(declare-fun |$IsPrefix'vec'u64''| (T@Vec_6673 T@Vec_6673) Bool)
(declare-fun |$IsPrefix'vec'u8''| (T@Vec_6673 T@Vec_6673) Bool)
(declare-fun |$IsPrefix'vec'bv64''| (T@Vec_67815 T@Vec_67815) Bool)
(declare-fun |$IsPrefix'vec'bv8''| (T@Vec_68162 T@Vec_68162) Bool)
(declare-fun |$IsEqual'$1_table_Table'u64_bool''| (T@Table_35290_35291 T@Table_35290_35291) Bool)
(declare-fun |Select__T@[Int]Bool_| (|T@[Int]Bool| Int) Bool)
(declare-fun DefaultTableKeyExistsArray_990 () |T@[Int]Bool|)
(declare-fun IndexOfVec_68162 (T@Vec_68162 (_ BitVec 8)) Int)
(declare-fun IndexOfVec_67815 (T@Vec_67815 (_ BitVec 64)) Int)
(declare-fun IndexOfVec_100175 (T@Vec_100175 T@$1_optional_aggregator_OptionalAggregator) Int)
(declare-fun IndexOfVec_95276 (T@Vec_95276 T@$1_optional_aggregator_Integer) Int)
(declare-fun IndexOfVec_90390 (T@Vec_90390 T@$1_aggregator_Aggregator) Int)
(declare-fun IndexOfVec_6673 (T@Vec_6673 Int) Int)
(declare-fun IndexOfVec_85428 (T@Vec_85428 |T@#0|) Int)
(declare-fun $1_Signature_$ed25519_verify (T@Vec_6673 T@Vec_6673 T@Vec_6673) Bool)
(declare-fun |lambda#0| (Int Int Int |T@[Int]#0| |T@[Int]#0| Int |T@#0|) |T@[Int]#0|)
(declare-fun |lambda#4| (Int Int Int |T@[Int]$1_aggregator_Aggregator| |T@[Int]$1_aggregator_Aggregator| Int T@$1_aggregator_Aggregator) |T@[Int]$1_aggregator_Aggregator|)
(declare-fun |lambda#8| (Int Int Int |T@[Int]$1_optional_aggregator_Integer| |T@[Int]$1_optional_aggregator_Integer| Int T@$1_optional_aggregator_Integer) |T@[Int]$1_optional_aggregator_Integer|)
(declare-fun |lambda#12| (Int Int Int |T@[Int]$1_optional_aggregator_OptionalAggregator| |T@[Int]$1_optional_aggregator_OptionalAggregator| Int T@$1_optional_aggregator_OptionalAggregator) |T@[Int]$1_optional_aggregator_OptionalAggregator|)
(declare-fun |lambda#16| (Int Int Int |T@[Int]Int| |T@[Int]Int| Int Int) |T@[Int]Int|)
(declare-fun |lambda#20| (Int Int Int |T@[Int](_ BitVec 64)| |T@[Int](_ BitVec 64)| Int (_ BitVec 64)) |T@[Int](_ BitVec 64)|)
(declare-fun |lambda#24| (Int Int Int |T@[Int](_ BitVec 8)| |T@[Int](_ BitVec 8)| Int (_ BitVec 8)) |T@[Int](_ BitVec 8)|)
(declare-fun |lambda#3| (Int Int Int |T@[Int]#0| |T@[Int]#0| Int |T@#0|) |T@[Int]#0|)
(declare-fun |lambda#7| (Int Int Int |T@[Int]$1_aggregator_Aggregator| |T@[Int]$1_aggregator_Aggregator| Int T@$1_aggregator_Aggregator) |T@[Int]$1_aggregator_Aggregator|)
(declare-fun |lambda#11| (Int Int Int |T@[Int]$1_optional_aggregator_Integer| |T@[Int]$1_optional_aggregator_Integer| Int T@$1_optional_aggregator_Integer) |T@[Int]$1_optional_aggregator_Integer|)
(declare-fun |lambda#15| (Int Int Int |T@[Int]$1_optional_aggregator_OptionalAggregator| |T@[Int]$1_optional_aggregator_OptionalAggregator| Int T@$1_optional_aggregator_OptionalAggregator) |T@[Int]$1_optional_aggregator_OptionalAggregator|)
(declare-fun |lambda#19| (Int Int Int |T@[Int]Int| |T@[Int]Int| Int Int) |T@[Int]Int|)
(declare-fun |lambda#23| (Int Int Int |T@[Int](_ BitVec 64)| |T@[Int](_ BitVec 64)| Int (_ BitVec 64)) |T@[Int](_ BitVec 64)|)
(declare-fun |lambda#27| (Int Int Int |T@[Int](_ BitVec 8)| |T@[Int](_ BitVec 8)| Int (_ BitVec 8)) |T@[Int](_ BitVec 8)|)
(declare-fun |$IsValid'bv32'| ((_ BitVec 32)) Bool)
(declare-fun |$1_bcs_serialize'address'| (Int) T@Vec_6673)
(declare-fun $1_aptos_hash_spec_keccak256 (T@Vec_6673) T@Vec_6673)
(declare-fun $1_aptos_hash_spec_sha2_512_internal (T@Vec_6673) T@Vec_6673)
(declare-fun $1_aptos_hash_spec_sha3_512_internal (T@Vec_6673) T@Vec_6673)
(declare-fun $1_aptos_hash_spec_ripemd160_internal (T@Vec_6673) T@Vec_6673)
(declare-fun $1_aptos_hash_spec_blake2b_256_internal (T@Vec_6673) T@Vec_6673)
(declare-fun |$IsSuffix'vec'#0''| (T@Vec_85428 T@Vec_85428) Bool)
(declare-fun |$IsSuffix'vec'$1_aggregator_Aggregator''| (T@Vec_90390 T@Vec_90390) Bool)
(declare-fun |$IsSuffix'vec'$1_optional_aggregator_Integer''| (T@Vec_95276 T@Vec_95276) Bool)
(declare-fun |$IsSuffix'vec'$1_optional_aggregator_OptionalAggregator''| (T@Vec_100175 T@Vec_100175) Bool)
(declare-fun |$IsSuffix'vec'address''| (T@Vec_6673 T@Vec_6673) Bool)
(declare-fun |$IsSuffix'vec'u64''| (T@Vec_6673 T@Vec_6673) Bool)
(declare-fun |$IsSuffix'vec'u8''| (T@Vec_6673 T@Vec_6673) Bool)
(declare-fun |$IsSuffix'vec'bv64''| (T@Vec_67815 T@Vec_67815) Bool)
(declare-fun |$IsSuffix'vec'bv8''| (T@Vec_68162 T@Vec_68162) Bool)
(declare-fun |lambda#2| (Int Int |T@[Int]#0| Int |T@#0|) |T@[Int]#0|)
(declare-fun |lambda#6| (Int Int |T@[Int]$1_aggregator_Aggregator| Int T@$1_aggregator_Aggregator) |T@[Int]$1_aggregator_Aggregator|)
(declare-fun |lambda#10| (Int Int |T@[Int]$1_optional_aggregator_Integer| Int T@$1_optional_aggregator_Integer) |T@[Int]$1_optional_aggregator_Integer|)
(declare-fun |lambda#14| (Int Int |T@[Int]$1_optional_aggregator_OptionalAggregator| Int T@$1_optional_aggregator_OptionalAggregator) |T@[Int]$1_optional_aggregator_OptionalAggregator|)
(declare-fun |lambda#18| (Int Int |T@[Int]Int| Int Int) |T@[Int]Int|)
(declare-fun |lambda#22| (Int Int |T@[Int](_ BitVec 64)| Int (_ BitVec 64)) |T@[Int](_ BitVec 64)|)
(declare-fun |lambda#26| (Int Int |T@[Int](_ BitVec 8)| Int (_ BitVec 8)) |T@[Int](_ BitVec 8)|)
(declare-fun $1_account_spec_create_resource_address (Int T@Vec_6673) Int)
(declare-fun |$1_from_bcs_deserializable'bool'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'u8'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'u64'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'u128'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'u256'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'address'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'signer'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'vec'u8''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'vec'u64''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'vec'address''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'vec'$1_aggregator_Aggregator''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'vec'$1_optional_aggregator_Integer''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'vec'$1_optional_aggregator_OptionalAggregator''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'vec'#0''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_table_Table'u64_bool''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_table_Table'u64_u64''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_table_Table'u64_vec'u64'''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_table_Table'address_address''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_option_Option'address''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_option_Option'$1_aggregator_Aggregator''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_option_Option'$1_optional_aggregator_Integer''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_string_String'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_type_info_TypeInfo'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_aggregator_Aggregator'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_optional_aggregator_Integer'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_optional_aggregator_OptionalAggregator'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_guid_GUID'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_guid_ID'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_event_EventHandle'$1_account_CoinRegisterEvent''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_event_EventHandle'$1_account_KeyRotationEvent''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_event_EventHandle'$1_coin_DepositEvent''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_event_EventHandle'$1_coin_WithdrawEvent''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_account_Account'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_account_CapabilityOffer'$1_account_RotationCapability''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_account_CapabilityOffer'$1_account_SignerCapability''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_account_CoinRegisterEvent'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_account_SignerCapability'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_Coin'$1_aptos_coin_AptosCoin''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_Coin'#0''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_CoinInfo'#0''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_CoinStore'#0''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_DepositEvent'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_WithdrawEvent'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_Ghost$supply'#0''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_Ghost$aggregate_supply'#0''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_aptos_coin_AptosCoin'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_Bbay_Owner'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_Bbay_Products'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_Bbay_ResourceAccountSignerCap'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_Bbay_User'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'#0'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserialize'bool'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserialize'u8'| (T@Vec_6673) Int)
(declare-fun |$1_from_bcs_deserialize'u64'| (T@Vec_6673) Int)
(declare-fun |$1_from_bcs_deserialize'u128'| (T@Vec_6673) Int)
(declare-fun |$1_from_bcs_deserialize'u256'| (T@Vec_6673) Int)
(declare-fun |$1_from_bcs_deserialize'address'| (T@Vec_6673) Int)
(declare-fun |$1_from_bcs_deserialize'signer'| (T@Vec_6673) T@$signer)
(declare-fun |$1_from_bcs_deserialize'vec'u8''| (T@Vec_6673) T@Vec_6673)
(declare-fun |$1_from_bcs_deserialize'vec'u64''| (T@Vec_6673) T@Vec_6673)
(declare-fun |$1_from_bcs_deserialize'vec'address''| (T@Vec_6673) T@Vec_6673)
(declare-fun |$1_from_bcs_deserialize'vec'$1_aggregator_Aggregator''| (T@Vec_6673) T@Vec_90390)
(declare-fun |$1_from_bcs_deserialize'vec'$1_optional_aggregator_Integer''| (T@Vec_6673) T@Vec_95276)
(declare-fun |$1_from_bcs_deserialize'vec'$1_optional_aggregator_OptionalAggregator''| (T@Vec_6673) T@Vec_100175)
(declare-fun |$1_from_bcs_deserialize'vec'#0''| (T@Vec_6673) T@Vec_85428)
(declare-fun |$1_from_bcs_deserialize'$1_table_Table'u64_bool''| (T@Vec_6673) T@Table_35290_35291)
(declare-fun |$IsEqual'$1_table_Table'u64_u64''| (T@Table_36177_36178 T@Table_36177_36178) Bool)
(declare-fun |$1_from_bcs_deserialize'$1_table_Table'u64_u64''| (T@Vec_6673) T@Table_36177_36178)
(declare-fun |$IsEqual'$1_table_Table'u64_vec'u64'''| (T@Table_37064_126051 T@Table_37064_126051) Bool)
(declare-fun |$1_from_bcs_deserialize'$1_table_Table'u64_vec'u64'''| (T@Vec_6673) T@Table_37064_126051)
(declare-fun |$IsEqual'$1_table_Table'address_address''| (T@Table_36177_36178 T@Table_36177_36178) Bool)
(declare-fun |$1_from_bcs_deserialize'$1_table_Table'address_address''| (T@Vec_6673) T@Table_36177_36178)
(declare-fun |$1_from_bcs_deserialize'$1_option_Option'address''| (T@Vec_6673) |T@$1_option_Option'address'|)
(declare-fun |$1_from_bcs_deserialize'$1_option_Option'$1_aggregator_Aggregator''| (T@Vec_6673) |T@$1_option_Option'$1_aggregator_Aggregator'|)
(declare-fun |$1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_Integer''| (T@Vec_6673) |T@$1_option_Option'$1_optional_aggregator_Integer'|)
(declare-fun |$1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| (T@Vec_6673) |T@$1_option_Option'$1_optional_aggregator_OptionalAggregator'|)
(declare-fun |$1_from_bcs_deserialize'$1_string_String'| (T@Vec_6673) T@$1_string_String)
(declare-fun |$1_from_bcs_deserialize'$1_type_info_TypeInfo'| (T@Vec_6673) T@$1_type_info_TypeInfo)
(declare-fun |$1_from_bcs_deserialize'$1_aggregator_Aggregator'| (T@Vec_6673) T@$1_aggregator_Aggregator)
(declare-fun |$1_from_bcs_deserialize'$1_optional_aggregator_Integer'| (T@Vec_6673) T@$1_optional_aggregator_Integer)
(declare-fun |$1_from_bcs_deserialize'$1_optional_aggregator_OptionalAggregator'| (T@Vec_6673) T@$1_optional_aggregator_OptionalAggregator)
(declare-fun |$1_from_bcs_deserialize'$1_guid_GUID'| (T@Vec_6673) T@$1_guid_GUID)
(declare-fun |$1_from_bcs_deserialize'$1_guid_ID'| (T@Vec_6673) T@$1_guid_ID)
(declare-fun |$1_from_bcs_deserialize'$1_event_EventHandle'$1_account_CoinRegisterEvent''| (T@Vec_6673) |T@$1_event_EventHandle'$1_account_CoinRegisterEvent'|)
(declare-fun |$1_from_bcs_deserialize'$1_event_EventHandle'$1_account_KeyRotationEvent''| (T@Vec_6673) |T@$1_event_EventHandle'$1_account_KeyRotationEvent'|)
(declare-fun |$1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_DepositEvent''| (T@Vec_6673) |T@$1_event_EventHandle'$1_coin_DepositEvent'|)
(declare-fun |$1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_WithdrawEvent''| (T@Vec_6673) |T@$1_event_EventHandle'$1_coin_WithdrawEvent'|)
(declare-fun |$1_from_bcs_deserialize'$1_account_Account'| (T@Vec_6673) T@$1_account_Account)
(declare-fun |$1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_RotationCapability''| (T@Vec_6673) |T@$1_account_CapabilityOffer'$1_account_RotationCapability'|)
(declare-fun |$1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_SignerCapability''| (T@Vec_6673) |T@$1_account_CapabilityOffer'$1_account_SignerCapability'|)
(declare-fun |$1_from_bcs_deserialize'$1_account_CoinRegisterEvent'| (T@Vec_6673) T@$1_account_CoinRegisterEvent)
(declare-fun |$1_from_bcs_deserialize'$1_account_SignerCapability'| (T@Vec_6673) T@$1_account_SignerCapability)
(declare-fun |$1_from_bcs_deserialize'$1_coin_Coin'$1_aptos_coin_AptosCoin''| (T@Vec_6673) |T@$1_coin_Coin'$1_aptos_coin_AptosCoin'|)
(declare-fun |$1_from_bcs_deserialize'$1_coin_Coin'#0''| (T@Vec_6673) |T@$1_coin_Coin'#0'|)
(declare-fun |$1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| (T@Vec_6673) |T@$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'|)
(declare-fun |$1_from_bcs_deserialize'$1_coin_CoinInfo'#0''| (T@Vec_6673) |T@$1_coin_CoinInfo'#0'|)
(declare-fun |$1_from_bcs_deserialize'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''| (T@Vec_6673) |T@$1_coin_CoinStore'$1_aptos_coin_AptosCoin'|)
(declare-fun |$1_from_bcs_deserialize'$1_coin_CoinStore'#0''| (T@Vec_6673) |T@$1_coin_CoinStore'#0'|)
(declare-fun |$1_from_bcs_deserialize'$1_coin_DepositEvent'| (T@Vec_6673) T@$1_coin_DepositEvent)
(declare-fun |$1_from_bcs_deserialize'$1_coin_WithdrawEvent'| (T@Vec_6673) T@$1_coin_WithdrawEvent)
(declare-fun |$1_from_bcs_deserialize'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''| (T@Vec_6673) |T@$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'|)
(declare-fun |$1_from_bcs_deserialize'$1_coin_Ghost$supply'#0''| (T@Vec_6673) |T@$1_coin_Ghost$supply'#0'|)
(declare-fun |$1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''| (T@Vec_6673) |T@$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'|)
(declare-fun |$1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'#0''| (T@Vec_6673) |T@$1_coin_Ghost$aggregate_supply'#0'|)
(declare-fun |$1_from_bcs_deserialize'$1_aptos_coin_AptosCoin'| (T@Vec_6673) T@$1_aptos_coin_AptosCoin)
(declare-fun |$1_from_bcs_deserialize'$1_Bbay_Owner'| (T@Vec_6673) T@$1_Bbay_Owner)
(declare-fun |$1_from_bcs_deserialize'$1_Bbay_Products'| (T@Vec_6673) T@$1_Bbay_Products)
(declare-fun |$1_from_bcs_deserialize'$1_Bbay_ResourceAccountSignerCap'| (T@Vec_6673) T@$1_Bbay_ResourceAccountSignerCap)
(declare-fun |$1_from_bcs_deserialize'$1_Bbay_User'| (T@Vec_6673) T@$1_Bbay_User)
(declare-fun |$1_from_bcs_deserialize'#0'| (T@Vec_6673) |T@#0|)
(declare-fun $shl (Int Int) Int)
(declare-fun |$IsValid'u256'| (Int) Bool)
(declare-fun |$IsValid'vec'address''| (T@Vec_6673) Bool)
(declare-fun |$IsValid'vec'$1_aggregator_Aggregator''| (T@Vec_90390) Bool)
(declare-fun |$IsValid'vec'$1_optional_aggregator_Integer''| (T@Vec_95276) Bool)
(declare-fun |$IsValid'vec'$1_optional_aggregator_OptionalAggregator''| (T@Vec_100175) Bool)
(declare-fun |$IsValid'vec'#0''| (T@Vec_85428) Bool)
(declare-fun |$IsValid'$1_table_Table'u64_bool''| (T@Table_35290_35291) Bool)
(declare-fun |$IsValid'$1_table_Table'u64_u64''| (T@Table_36177_36178) Bool)
(declare-fun |$IsValid'$1_table_Table'u64_vec'u64'''| (T@Table_37064_126051) Bool)
(declare-fun |$IsValid'$1_option_Option'address''| (|T@$1_option_Option'address'|) Bool)
(declare-fun |$IsValid'$1_type_info_TypeInfo'| (T@$1_type_info_TypeInfo) Bool)
(declare-fun |$IsValid'$1_account_Account'| (T@$1_account_Account) Bool)
(declare-fun |$IsValid'$1_account_CapabilityOffer'$1_account_RotationCapability''| (|T@$1_account_CapabilityOffer'$1_account_RotationCapability'|) Bool)
(declare-fun |$IsValid'$1_account_CapabilityOffer'$1_account_SignerCapability''| (|T@$1_account_CapabilityOffer'$1_account_SignerCapability'|) Bool)
(declare-fun |$IsValid'$1_account_CoinRegisterEvent'| (T@$1_account_CoinRegisterEvent) Bool)
(declare-fun |$IsValid'$1_account_SignerCapability'| (T@$1_account_SignerCapability) Bool)
(declare-fun |$IsValid'$1_coin_DepositEvent'| (T@$1_coin_DepositEvent) Bool)
(declare-fun |$IsValid'$1_coin_WithdrawEvent'| (T@$1_coin_WithdrawEvent) Bool)
(declare-fun |$IsValid'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''| (|T@$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'|) Bool)
(declare-fun |$IsValid'$1_coin_Ghost$supply'#0''| (|T@$1_coin_Ghost$supply'#0'|) Bool)
(declare-fun |$IsValid'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''| (|T@$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'|) Bool)
(declare-fun |$IsValid'$1_coin_Ghost$aggregate_supply'#0''| (|T@$1_coin_Ghost$aggregate_supply'#0'|) Bool)
(declare-fun |$IsValid'$1_aptos_coin_AptosCoin'| (T@$1_aptos_coin_AptosCoin) Bool)
(declare-fun |$IsValid'$1_Bbay_Products'| (T@$1_Bbay_Products) Bool)
(declare-fun |$IsValid'$1_Bbay_ResourceAccountSignerCap'| (T@$1_Bbay_ResourceAccountSignerCap) Bool)
(declare-fun |$EncodeKey'u64'| (Int) Int)
(declare-fun |$EncodeKey'address'| (Int) Int)
(declare-fun $shlBv8From16 ((_ BitVec 8) (_ BitVec 16)) (_ BitVec 8))
(declare-fun $shrBv8From16 ((_ BitVec 8) (_ BitVec 16)) (_ BitVec 8))
(declare-fun $shlBv8From32 ((_ BitVec 8) (_ BitVec 32)) (_ BitVec 8))
(declare-fun $shrBv8From32 ((_ BitVec 8) (_ BitVec 32)) (_ BitVec 8))
(declare-fun $shlBv8From64 ((_ BitVec 8) (_ BitVec 64)) (_ BitVec 8))
(declare-fun $shrBv8From64 ((_ BitVec 8) (_ BitVec 64)) (_ BitVec 8))
(declare-fun $shlBv8From128 ((_ BitVec 8) (_ BitVec 128)) (_ BitVec 8))
(declare-fun $shrBv8From128 ((_ BitVec 8) (_ BitVec 128)) (_ BitVec 8))
(declare-fun $shlBv8From256 ((_ BitVec 8) (_ BitVec 256)) (_ BitVec 8))
(declare-fun $shrBv8From256 ((_ BitVec 8) (_ BitVec 256)) (_ BitVec 8))
(declare-fun $shlBv16From32 ((_ BitVec 16) (_ BitVec 32)) (_ BitVec 16))
(declare-fun $shrBv16From32 ((_ BitVec 16) (_ BitVec 32)) (_ BitVec 16))
(declare-fun $shlBv16From64 ((_ BitVec 16) (_ BitVec 64)) (_ BitVec 16))
(declare-fun $shrBv16From64 ((_ BitVec 16) (_ BitVec 64)) (_ BitVec 16))
(declare-fun $shlBv16From128 ((_ BitVec 16) (_ BitVec 128)) (_ BitVec 16))
(declare-fun $shrBv16From128 ((_ BitVec 16) (_ BitVec 128)) (_ BitVec 16))
(declare-fun $shlBv16From256 ((_ BitVec 16) (_ BitVec 256)) (_ BitVec 16))
(declare-fun $shrBv16From256 ((_ BitVec 16) (_ BitVec 256)) (_ BitVec 16))
(declare-fun $shlBv32From64 ((_ BitVec 32) (_ BitVec 64)) (_ BitVec 32))
(declare-fun $shrBv32From64 ((_ BitVec 32) (_ BitVec 64)) (_ BitVec 32))
(declare-fun $shlBv32From128 ((_ BitVec 32) (_ BitVec 128)) (_ BitVec 32))
(declare-fun $shrBv32From128 ((_ BitVec 32) (_ BitVec 128)) (_ BitVec 32))
(declare-fun $shlBv32From256 ((_ BitVec 32) (_ BitVec 256)) (_ BitVec 32))
(declare-fun $shrBv32From256 ((_ BitVec 32) (_ BitVec 256)) (_ BitVec 32))
(declare-fun $shlBv64From128 ((_ BitVec 64) (_ BitVec 128)) (_ BitVec 64))
(declare-fun $shrBv64From128 ((_ BitVec 64) (_ BitVec 128)) (_ BitVec 64))
(declare-fun $shlBv64From256 ((_ BitVec 64) (_ BitVec 256)) (_ BitVec 64))
(declare-fun $shrBv64From256 ((_ BitVec 64) (_ BitVec 256)) (_ BitVec 64))
(declare-fun $shlBv128From256 ((_ BitVec 128) (_ BitVec 256)) (_ BitVec 128))
(declare-fun $shrBv128From256 ((_ BitVec 128) (_ BitVec 256)) (_ BitVec 128))
(declare-fun $shlU8 (Int Int) Int)
(declare-fun $shlU32 (Int Int) Int)
(declare-fun $shlU16 (Int Int) Int)
(declare-fun $shlU64 (Int Int) Int)
(declare-fun |$IsValid'vec'bv64''| (T@Vec_67815) Bool)
(declare-fun |$IsValid'bv64'| ((_ BitVec 64)) Bool)
(declare-fun |$IsValid'vec'bv8''| (T@Vec_68162) Bool)
(declare-fun |$IsValid'bv8'| ((_ BitVec 8)) Bool)
(declare-fun |Select__T@[Int]Vec_6673_| (|T@[Int]Vec_6673| Int) T@Vec_6673)
(declare-fun |$IsValid'num'| (Int) Bool)
(declare-fun $shlU128 (Int Int) Int)
(declare-fun $undefined_int () Int)
(declare-fun |$IsValid'$1_account_RotationCapability'| (T@$1_account_RotationCapability) Bool)
(declare-fun $shlBv16From8 ((_ BitVec 16) (_ BitVec 8)) (_ BitVec 16))
(declare-fun $shrBv16From8 ((_ BitVec 16) (_ BitVec 8)) (_ BitVec 16))
(declare-fun $shlBv32From16 ((_ BitVec 32) (_ BitVec 16)) (_ BitVec 32))
(declare-fun $shrBv32From16 ((_ BitVec 32) (_ BitVec 16)) (_ BitVec 32))
(declare-fun $shlBv32From8 ((_ BitVec 32) (_ BitVec 8)) (_ BitVec 32))
(declare-fun $shrBv32From8 ((_ BitVec 32) (_ BitVec 8)) (_ BitVec 32))
(declare-fun $shlBv64From32 ((_ BitVec 64) (_ BitVec 32)) (_ BitVec 64))
(declare-fun $shrBv64From32 ((_ BitVec 64) (_ BitVec 32)) (_ BitVec 64))
(declare-fun $shlBv64From16 ((_ BitVec 64) (_ BitVec 16)) (_ BitVec 64))
(declare-fun $shrBv64From16 ((_ BitVec 64) (_ BitVec 16)) (_ BitVec 64))
(declare-fun $shlBv64From8 ((_ BitVec 64) (_ BitVec 8)) (_ BitVec 64))
(declare-fun $shrBv64From8 ((_ BitVec 64) (_ BitVec 8)) (_ BitVec 64))
(declare-fun $shlBv128From64 ((_ BitVec 128) (_ BitVec 64)) (_ BitVec 128))
(declare-fun $shrBv128From64 ((_ BitVec 128) (_ BitVec 64)) (_ BitVec 128))
(declare-fun $shlBv128From32 ((_ BitVec 128) (_ BitVec 32)) (_ BitVec 128))
(declare-fun $shrBv128From32 ((_ BitVec 128) (_ BitVec 32)) (_ BitVec 128))
(declare-fun $shlBv128From16 ((_ BitVec 128) (_ BitVec 16)) (_ BitVec 128))
(declare-fun $shrBv128From16 ((_ BitVec 128) (_ BitVec 16)) (_ BitVec 128))
(declare-fun $shlBv128From8 ((_ BitVec 128) (_ BitVec 8)) (_ BitVec 128))
(declare-fun $shrBv128From8 ((_ BitVec 128) (_ BitVec 8)) (_ BitVec 128))
(declare-fun $shlBv256From128 ((_ BitVec 256) (_ BitVec 128)) (_ BitVec 256))
(declare-fun $shrBv256From128 ((_ BitVec 256) (_ BitVec 128)) (_ BitVec 256))
(declare-fun $shlBv256From64 ((_ BitVec 256) (_ BitVec 64)) (_ BitVec 256))
(declare-fun $shrBv256From64 ((_ BitVec 256) (_ BitVec 64)) (_ BitVec 256))
(declare-fun $shlBv256From32 ((_ BitVec 256) (_ BitVec 32)) (_ BitVec 256))
(declare-fun $shrBv256From32 ((_ BitVec 256) (_ BitVec 32)) (_ BitVec 256))
(declare-fun $shlBv256From16 ((_ BitVec 256) (_ BitVec 16)) (_ BitVec 256))
(declare-fun $shrBv256From16 ((_ BitVec 256) (_ BitVec 16)) (_ BitVec 256))
(declare-fun $shlBv256From8 ((_ BitVec 256) (_ BitVec 8)) (_ BitVec 256))
(declare-fun $shrBv256From8 ((_ BitVec 256) (_ BitVec 8)) (_ BitVec 256))
(declare-fun $1_aggregator_spec_aggregator_set_val (T@$1_aggregator_Aggregator Int) T@$1_aggregator_Aggregator)
(declare-fun $shlBv8From8 ((_ BitVec 8) (_ BitVec 8)) (_ BitVec 8))
(declare-fun $shrBv8From8 ((_ BitVec 8) (_ BitVec 8)) (_ BitVec 8))
(declare-fun $shlBv16From16 ((_ BitVec 16) (_ BitVec 16)) (_ BitVec 16))
(declare-fun $shrBv16From16 ((_ BitVec 16) (_ BitVec 16)) (_ BitVec 16))
(declare-fun $shlBv32From32 ((_ BitVec 32) (_ BitVec 32)) (_ BitVec 32))
(declare-fun $shrBv32From32 ((_ BitVec 32) (_ BitVec 32)) (_ BitVec 32))
(declare-fun $shlBv64From64 ((_ BitVec 64) (_ BitVec 64)) (_ BitVec 64))
(declare-fun $shrBv64From64 ((_ BitVec 64) (_ BitVec 64)) (_ BitVec 64))
(declare-fun $shlBv128From128 ((_ BitVec 128) (_ BitVec 128)) (_ BitVec 128))
(declare-fun $shrBv128From128 ((_ BitVec 128) (_ BitVec 128)) (_ BitVec 128))
(declare-fun $shlBv256From256 ((_ BitVec 256) (_ BitVec 256)) (_ BitVec 256))
(declare-fun $shrBv256From256 ((_ BitVec 256) (_ BitVec 256)) (_ BitVec 256))
(declare-fun $1_Signature_$ed25519_validate_pubkey (T@Vec_6673) Bool)
(declare-fun |$IsValid'bv16'| ((_ BitVec 16)) Bool)
(declare-fun |$IsValid'bv256'| ((_ BitVec 256)) Bool)
(declare-fun |$IndexOfVec'#0'| (T@Vec_85428 |T@#0|) Int)
(declare-fun |$IndexOfVec'$1_aggregator_Aggregator'| (T@Vec_90390 T@$1_aggregator_Aggregator) Int)
(declare-fun |$IndexOfVec'$1_optional_aggregator_Integer'| (T@Vec_95276 T@$1_optional_aggregator_Integer) Int)
(declare-fun |$IndexOfVec'$1_optional_aggregator_OptionalAggregator'| (T@Vec_100175 T@$1_optional_aggregator_OptionalAggregator) Int)
(declare-fun |$IndexOfVec'address'| (T@Vec_6673 Int) Int)
(declare-fun |$IndexOfVec'u64'| (T@Vec_6673 Int) Int)
(declare-fun |$IndexOfVec'u8'| (T@Vec_6673 Int) Int)
(declare-fun |$IndexOfVec'bv64'| (T@Vec_67815 (_ BitVec 64)) Int)
(declare-fun |$IndexOfVec'bv8'| (T@Vec_68162 (_ BitVec 8)) Int)
(declare-fun $1_aggregator_spec_read (T@$1_aggregator_Aggregator) Int)
(declare-fun $1_aggregator_spec_aggregator_get_val (T@$1_aggregator_Aggregator) Int)
(declare-fun |$IsValid'bv128'| ((_ BitVec 128)) Bool)
(declare-fun $1_hash_sha2 (T@Vec_6673) T@Vec_6673)
(declare-fun $1_hash_sha3 (T@Vec_6673) T@Vec_6673)
(declare-fun $MAX_U8 () Int)
(declare-fun |$IsValid'u16'| (Int) Bool)
(declare-fun $MAX_U16 () Int)
(declare-fun |$IsValid'u32'| (Int) Bool)
(declare-fun $MAX_U32 () Int)
(declare-fun $MAX_U64 () Int)
(declare-fun $MAX_U256 () Int)
(declare-fun $1_aggregator_factory_spec_new_aggregator (Int) T@$1_aggregator_Aggregator)
(declare-fun $serialized_address_len () Int)
(declare-fun $InRange (T@$Range Int) Bool)
(declare-fun $EXEC_FAILURE_CODE () Int)
(assert (= $MAX_U128 340282366920938463463374607431768211455))
(assert (forall ((src1 Int) (p Int) ) (! (= ($shlU256 src1 p) (mod (* src1 ($pow 2 p)) 115792089237316195423570985008687907853269984665640564039457584007913129639936))
 :qid |boogiebpl.1515:19|
 :skolemid |39|
 :pattern ( ($shlU256 src1 p))
)))
(assert (forall ((t T@$TypeParamInfo) ) (!  (=> (is-$TypeParamU128 t) (|$IsEqual'vec'u8''| ($TypeName t) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 49) 2 50) 3 56) 4)))
 :qid |boogiebpl.6531:15|
 :skolemid |255|
 :pattern ( ($TypeName t))
)))
(assert (forall ((t@@0 T@$TypeParamInfo) ) (!  (=> (is-$TypeParamU256 t@@0) (|$IsEqual'vec'u8''| ($TypeName t@@0) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 50) 2 53) 3 54) 4)))
 :qid |boogiebpl.6533:15|
 :skolemid |257|
 :pattern ( ($TypeName t@@0))
)))
(assert (forall ((|l#0| Int) (|l#1| Int) (|l#2| |T@[Int]#0|) (|l#3| Int) (|l#4| Int) (|l#5| |T@#0|) (i Int) ) (! (= (|Select__T@[Int]#0_| (|lambda#1| |l#0| |l#1| |l#2| |l#3| |l#4| |l#5|) i) (ite  (and (<= |l#0| i) (< i |l#1|)) (|Select__T@[Int]#0_| |l#2| (- (- |l#3| i) |l#4|)) |l#5|))
 :qid |boogiebpl.83:30|
 :skolemid |563|
 :pattern ( (|Select__T@[Int]#0_| (|lambda#1| |l#0| |l#1| |l#2| |l#3| |l#4| |l#5|) i))
)))
(assert (forall ((|l#0@@0| Int) (|l#1@@0| Int) (|l#2@@0| |T@[Int]$1_aggregator_Aggregator|) (|l#3@@0| Int) (|l#4@@0| Int) (|l#5@@0| T@$1_aggregator_Aggregator) (i@@0 Int) ) (! (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|lambda#5| |l#0@@0| |l#1@@0| |l#2@@0| |l#3@@0| |l#4@@0| |l#5@@0|) i@@0) (ite  (and (<= |l#0@@0| i@@0) (< i@@0 |l#1@@0|)) (|Select__T@[Int]$1_aggregator_Aggregator_| |l#2@@0| (- (- |l#3@@0| i@@0) |l#4@@0|)) |l#5@@0|))
 :qid |boogiebpl.83:30|
 :skolemid |567|
 :pattern ( (|Select__T@[Int]$1_aggregator_Aggregator_| (|lambda#5| |l#0@@0| |l#1@@0| |l#2@@0| |l#3@@0| |l#4@@0| |l#5@@0|) i@@0))
)))
(assert (forall ((|l#0@@1| Int) (|l#1@@1| Int) (|l#2@@1| |T@[Int]$1_optional_aggregator_Integer|) (|l#3@@1| Int) (|l#4@@1| Int) (|l#5@@1| T@$1_optional_aggregator_Integer) (i@@1 Int) ) (! (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|lambda#9| |l#0@@1| |l#1@@1| |l#2@@1| |l#3@@1| |l#4@@1| |l#5@@1|) i@@1) (ite  (and (<= |l#0@@1| i@@1) (< i@@1 |l#1@@1|)) (|Select__T@[Int]$1_optional_aggregator_Integer_| |l#2@@1| (- (- |l#3@@1| i@@1) |l#4@@1|)) |l#5@@1|))
 :qid |boogiebpl.83:30|
 :skolemid |571|
 :pattern ( (|Select__T@[Int]$1_optional_aggregator_Integer_| (|lambda#9| |l#0@@1| |l#1@@1| |l#2@@1| |l#3@@1| |l#4@@1| |l#5@@1|) i@@1))
)))
(assert (forall ((|l#0@@2| Int) (|l#1@@2| Int) (|l#2@@2| |T@[Int]$1_optional_aggregator_OptionalAggregator|) (|l#3@@2| Int) (|l#4@@2| Int) (|l#5@@2| T@$1_optional_aggregator_OptionalAggregator) (i@@2 Int) ) (! (= (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|lambda#13| |l#0@@2| |l#1@@2| |l#2@@2| |l#3@@2| |l#4@@2| |l#5@@2|) i@@2) (ite  (and (<= |l#0@@2| i@@2) (< i@@2 |l#1@@2|)) (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| |l#2@@2| (- (- |l#3@@2| i@@2) |l#4@@2|)) |l#5@@2|))
 :qid |boogiebpl.83:30|
 :skolemid |575|
 :pattern ( (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|lambda#13| |l#0@@2| |l#1@@2| |l#2@@2| |l#3@@2| |l#4@@2| |l#5@@2|) i@@2))
)))
(assert (forall ((|l#0@@3| Int) (|l#1@@3| Int) (|l#2@@3| |T@[Int]Int|) (|l#3@@3| Int) (|l#4@@3| Int) (|l#5@@3| Int) (i@@3 Int) ) (! (= (|Select__T@[Int]Int_| (|lambda#17| |l#0@@3| |l#1@@3| |l#2@@3| |l#3@@3| |l#4@@3| |l#5@@3|) i@@3) (ite  (and (<= |l#0@@3| i@@3) (< i@@3 |l#1@@3|)) (|Select__T@[Int]Int_| |l#2@@3| (- (- |l#3@@3| i@@3) |l#4@@3|)) |l#5@@3|))
 :qid |boogiebpl.83:30|
 :skolemid |579|
 :pattern ( (|Select__T@[Int]Int_| (|lambda#17| |l#0@@3| |l#1@@3| |l#2@@3| |l#3@@3| |l#4@@3| |l#5@@3|) i@@3))
)))
(assert (forall ((|l#0@@4| Int) (|l#1@@4| Int) (|l#2@@4| |T@[Int](_ BitVec 64)|) (|l#3@@4| Int) (|l#4@@4| Int) (|l#5@@4| (_ BitVec 64)) (i@@4 Int) ) (! (= (|Select__T@[Int](_ BitVec 64)_| (|lambda#21| |l#0@@4| |l#1@@4| |l#2@@4| |l#3@@4| |l#4@@4| |l#5@@4|) i@@4) (ite  (and (<= |l#0@@4| i@@4) (< i@@4 |l#1@@4|)) (|Select__T@[Int](_ BitVec 64)_| |l#2@@4| (- (- |l#3@@4| i@@4) |l#4@@4|)) |l#5@@4|))
 :qid |boogiebpl.83:30|
 :skolemid |583|
 :pattern ( (|Select__T@[Int](_ BitVec 64)_| (|lambda#21| |l#0@@4| |l#1@@4| |l#2@@4| |l#3@@4| |l#4@@4| |l#5@@4|) i@@4))
)))
(assert (forall ((|l#0@@5| Int) (|l#1@@5| Int) (|l#2@@5| |T@[Int](_ BitVec 8)|) (|l#3@@5| Int) (|l#4@@5| Int) (|l#5@@5| (_ BitVec 8)) (i@@5 Int) ) (! (= (|Select__T@[Int](_ BitVec 8)_| (|lambda#25| |l#0@@5| |l#1@@5| |l#2@@5| |l#3@@5| |l#4@@5| |l#5@@5|) i@@5) (ite  (and (<= |l#0@@5| i@@5) (< i@@5 |l#1@@5|)) (|Select__T@[Int](_ BitVec 8)_| |l#2@@5| (- (- |l#3@@5| i@@5) |l#4@@5|)) |l#5@@5|))
 :qid |boogiebpl.83:30|
 :skolemid |587|
 :pattern ( (|Select__T@[Int](_ BitVec 8)_| (|lambda#25| |l#0@@5| |l#1@@5| |l#2@@5| |l#3@@5| |l#4@@5| |l#5@@5|) i@@5))
)))
(assert (forall ((src1@@0 Int) (p@@0 Int) ) (! (= ($shr src1@@0 p@@0) (div src1@@0 ($pow 2 p@@0)))
 :qid |boogiebpl.1519:15|
 :skolemid |40|
 :pattern ( ($shr src1@@0 p@@0))
)))
(assert (forall ((s T@$1_aggregator_Aggregator) ) (! (= (|$IsValid'$1_aggregator_Aggregator'| s)  (and (and (and (|$IsValid'address'| (|$handle#$1_aggregator_Aggregator| s)) (|$IsValid'address'| (|$key#$1_aggregator_Aggregator| s))) (|$IsValid'u128'| (|$limit#$1_aggregator_Aggregator| s))) (|$IsValid'u128'| (|$val#$1_aggregator_Aggregator| s))))
 :qid |boogiebpl.260:45|
 :skolemid |8|
 :pattern ( (|$IsValid'$1_aggregator_Aggregator'| s))
)))
(assert (forall ((s@@0 |T@$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'|) ) (! (= (|$IsValid'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| s@@0)  (and (and (and (|$IsValid'$1_string_String'| (|$name#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| s@@0)) (|$IsValid'$1_string_String'| (|$symbol#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| s@@0))) (|$IsValid'u8'| (|$decimals#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| s@@0))) (|$IsValid'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| (|$supply#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| s@@0))))
 :qid |boogiebpl.10044:62|
 :skolemid |520|
 :pattern ( (|$IsValid'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| s@@0))
)))
(assert (forall ((s@@1 |T@$1_coin_CoinInfo'#0'|) ) (! (= (|$IsValid'$1_coin_CoinInfo'#0''| s@@1)  (and (and (and (|$IsValid'$1_string_String'| (|$name#$1_coin_CoinInfo'#0'| s@@1)) (|$IsValid'$1_string_String'| (|$symbol#$1_coin_CoinInfo'#0'| s@@1))) (|$IsValid'u8'| (|$decimals#$1_coin_CoinInfo'#0'| s@@1))) (|$IsValid'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| (|$supply#$1_coin_CoinInfo'#0'| s@@1))))
 :qid |boogiebpl.10073:41|
 :skolemid |521|
 :pattern ( (|$IsValid'$1_coin_CoinInfo'#0''| s@@1))
)))
(assert (forall ((s@@2 |T@$1_coin_CoinStore'$1_aptos_coin_AptosCoin'|) ) (! (= (|$IsValid'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''| s@@2)  (and (and (and (|$IsValid'$1_coin_Coin'$1_aptos_coin_AptosCoin''| (|$coin#$1_coin_CoinStore'$1_aptos_coin_AptosCoin'| s@@2)) true) (|$IsValid'$1_event_EventHandle'$1_coin_DepositEvent''| (|$deposit_events#$1_coin_CoinStore'$1_aptos_coin_AptosCoin'| s@@2))) (|$IsValid'$1_event_EventHandle'$1_coin_WithdrawEvent''| (|$withdraw_events#$1_coin_CoinStore'$1_aptos_coin_AptosCoin'| s@@2))))
 :qid |boogiebpl.10102:63|
 :skolemid |522|
 :pattern ( (|$IsValid'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''| s@@2))
)))
(assert (forall ((s@@3 |T@$1_coin_CoinStore'#0'|) ) (! (= (|$IsValid'$1_coin_CoinStore'#0''| s@@3)  (and (and (and (|$IsValid'$1_coin_Coin'#0''| (|$coin#$1_coin_CoinStore'#0'| s@@3)) true) (|$IsValid'$1_event_EventHandle'$1_coin_DepositEvent''| (|$deposit_events#$1_coin_CoinStore'#0'| s@@3))) (|$IsValid'$1_event_EventHandle'$1_coin_WithdrawEvent''| (|$withdraw_events#$1_coin_CoinStore'#0'| s@@3))))
 :qid |boogiebpl.10129:42|
 :skolemid |523|
 :pattern ( (|$IsValid'$1_coin_CoinStore'#0''| s@@3))
)))
(assert (forall ((s@@4 T@$1_Bbay_Owner) ) (! (= (|$IsValid'$1_Bbay_Owner'| s@@4)  (and (and (and (|$IsValid'address'| (|$owner_address#$1_Bbay_Owner| s@@4)) (|$IsValid'u64'| (|$user_count#$1_Bbay_Owner| s@@4))) (|$IsValid'u64'| (|$num_of_products_added#$1_Bbay_Owner| s@@4))) (|$IsValid'$1_table_Table'address_address''| (|$resource_account#$1_Bbay_Owner| s@@4))))
 :qid |boogiebpl.11505:34|
 :skolemid |531|
 :pattern ( (|$IsValid'$1_Bbay_Owner'| s@@4))
)))
(assert (forall ((s@@5 T@$1_Bbay_User) ) (! (= (|$IsValid'$1_Bbay_User'| s@@5)  (and (and (and (|$IsValid'u64'| (|$user_id#$1_Bbay_User| s@@5)) (|$IsValid'vec'u64''| (|$orders#$1_Bbay_User| s@@5))) (|$IsValid'vec'u64''| (|$order_status#$1_Bbay_User| s@@5))) (|$IsValid'vec'u64''| (|$payment_status#$1_Bbay_User| s@@5))))
 :qid |boogiebpl.11586:33|
 :skolemid |534|
 :pattern ( (|$IsValid'$1_Bbay_User'| s@@5))
)))
(assert (= ($ConstMemoryDomain false) (|lambda#28| false)))
(assert (= ($ConstMemoryDomain true) (|lambda#28| true)))
(assert (forall ((s@@6 T@$1_optional_aggregator_Integer) ) (! (= (|$IsValid'$1_optional_aggregator_Integer'| s@@6)  (and (|$IsValid'u128'| (|$value#$1_optional_aggregator_Integer| s@@6)) (|$IsValid'u128'| (|$limit#$1_optional_aggregator_Integer| s@@6))))
 :qid |boogiebpl.7404:51|
 :skolemid |390|
 :pattern ( (|$IsValid'$1_optional_aggregator_Integer'| s@@6))
)))
(assert (forall ((s@@7 T@$1_optional_aggregator_OptionalAggregator) ) (! (= (|$IsValid'$1_optional_aggregator_OptionalAggregator'| s@@7)  (and (|$IsValid'$1_option_Option'$1_aggregator_Aggregator''| (|$aggregator#$1_optional_aggregator_OptionalAggregator| s@@7)) (|$IsValid'$1_option_Option'$1_optional_aggregator_Integer''| (|$integer#$1_optional_aggregator_OptionalAggregator| s@@7))))
 :qid |boogiebpl.7422:62|
 :skolemid |391|
 :pattern ( (|$IsValid'$1_optional_aggregator_OptionalAggregator'| s@@7))
)))
(assert (forall ((s@@8 T@$1_guid_ID) ) (! (= (|$IsValid'$1_guid_ID'| s@@8)  (and (|$IsValid'u64'| (|$creation_num#$1_guid_ID| s@@8)) (|$IsValid'address'| (|$addr#$1_guid_ID| s@@8))))
 :qid |boogiebpl.7454:31|
 :skolemid |393|
 :pattern ( (|$IsValid'$1_guid_ID'| s@@8))
)))
(assert (forall ((s@@9 |T@$1_event_EventHandle'$1_account_CoinRegisterEvent'|) ) (! (= (|$IsValid'$1_event_EventHandle'$1_account_CoinRegisterEvent''| s@@9)  (and (|$IsValid'u64'| (|$counter#$1_event_EventHandle'$1_account_CoinRegisterEvent'| s@@9)) (|$IsValid'$1_guid_GUID'| (|$guid#$1_event_EventHandle'$1_account_CoinRegisterEvent'| s@@9))))
 :qid |boogiebpl.7560:71|
 :skolemid |394|
 :pattern ( (|$IsValid'$1_event_EventHandle'$1_account_CoinRegisterEvent''| s@@9))
)))
(assert (forall ((s@@10 |T@$1_event_EventHandle'$1_account_KeyRotationEvent'|) ) (! (= (|$IsValid'$1_event_EventHandle'$1_account_KeyRotationEvent''| s@@10)  (and (|$IsValid'u64'| (|$counter#$1_event_EventHandle'$1_account_KeyRotationEvent'| s@@10)) (|$IsValid'$1_guid_GUID'| (|$guid#$1_event_EventHandle'$1_account_KeyRotationEvent'| s@@10))))
 :qid |boogiebpl.7578:70|
 :skolemid |395|
 :pattern ( (|$IsValid'$1_event_EventHandle'$1_account_KeyRotationEvent''| s@@10))
)))
(assert (forall ((s@@11 |T@$1_event_EventHandle'$1_coin_DepositEvent'|) ) (! (= (|$IsValid'$1_event_EventHandle'$1_coin_DepositEvent''| s@@11)  (and (|$IsValid'u64'| (|$counter#$1_event_EventHandle'$1_coin_DepositEvent'| s@@11)) (|$IsValid'$1_guid_GUID'| (|$guid#$1_event_EventHandle'$1_coin_DepositEvent'| s@@11))))
 :qid |boogiebpl.7596:63|
 :skolemid |396|
 :pattern ( (|$IsValid'$1_event_EventHandle'$1_coin_DepositEvent''| s@@11))
)))
(assert (forall ((s@@12 |T@$1_event_EventHandle'$1_coin_WithdrawEvent'|) ) (! (= (|$IsValid'$1_event_EventHandle'$1_coin_WithdrawEvent''| s@@12)  (and (|$IsValid'u64'| (|$counter#$1_event_EventHandle'$1_coin_WithdrawEvent'| s@@12)) (|$IsValid'$1_guid_GUID'| (|$guid#$1_event_EventHandle'$1_coin_WithdrawEvent'| s@@12))))
 :qid |boogiebpl.7614:64|
 :skolemid |397|
 :pattern ( (|$IsValid'$1_event_EventHandle'$1_coin_WithdrawEvent''| s@@12))
)))
(assert (forall ((s@@13 T@$1_account_KeyRotationEvent) ) (! (= (|$IsValid'$1_account_KeyRotationEvent'| s@@13)  (and (|$IsValid'vec'u8''| (|$old_authentication_key#$1_account_KeyRotationEvent| s@@13)) (|$IsValid'vec'u8''| (|$new_authentication_key#$1_account_KeyRotationEvent| s@@13))))
 :qid |boogiebpl.8549:48|
 :skolemid |515|
 :pattern ( (|$IsValid'$1_account_KeyRotationEvent'| s@@13))
)))
(assert (forall ((v1 T@Vec_85428) (v2 T@Vec_85428) ) (! (= (|$IsEqual'vec'#0''| v1 v2)  (and (= (|l#Vec_85428| v1) (|l#Vec_85428| v2)) (forall ((i@@6 Int) ) (!  (=> (InRangeVec_65852 v1 i@@6) (= (|Select__T@[Int]#0_| (|v#Vec_85428| v1) i@@6) (|Select__T@[Int]#0_| (|v#Vec_85428| v2) i@@6)))
 :qid |boogiebpl.3080:13|
 :skolemid |113|
))))
 :qid |boogiebpl.3078:28|
 :skolemid |114|
 :pattern ( (|$IsEqual'vec'#0''| v1 v2))
)))
(assert (forall ((v1@@0 T@Vec_90390) (v2@@0 T@Vec_90390) ) (! (= (|$IsEqual'vec'$1_aggregator_Aggregator''| v1@@0 v2@@0)  (and (= (|l#Vec_90390| v1@@0) (|l#Vec_90390| v2@@0)) (forall ((i@@7 Int) ) (!  (=> (InRangeVec_66199 v1@@0 i@@7) (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| v1@@0) i@@7) (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| v2@@0) i@@7)))
 :qid |boogiebpl.3384:13|
 :skolemid |124|
))))
 :qid |boogiebpl.3382:50|
 :skolemid |125|
 :pattern ( (|$IsEqual'vec'$1_aggregator_Aggregator''| v1@@0 v2@@0))
)))
(assert (forall ((v1@@1 T@Vec_95276) (v2@@1 T@Vec_95276) ) (! (= (|$IsEqual'vec'$1_optional_aggregator_Integer''| v1@@1 v2@@1)  (and (= (|l#Vec_95276| v1@@1) (|l#Vec_95276| v2@@1)) (forall ((i@@8 Int) ) (!  (=> (InRangeVec_66546 v1@@1 i@@8) (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| v1@@1) i@@8) (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| v2@@1) i@@8)))
 :qid |boogiebpl.3688:13|
 :skolemid |135|
))))
 :qid |boogiebpl.3686:56|
 :skolemid |136|
 :pattern ( (|$IsEqual'vec'$1_optional_aggregator_Integer''| v1@@1 v2@@1))
)))
(assert (forall ((v1@@2 T@Vec_100175) (v2@@2 T@Vec_100175) ) (! (= (|$IsEqual'vec'$1_optional_aggregator_OptionalAggregator''| v1@@2 v2@@2)  (and (= (|l#Vec_100175| v1@@2) (|l#Vec_100175| v2@@2)) (forall ((i@@9 Int) ) (!  (=> (InRangeVec_66893 v1@@2 i@@9) (and (|$IsEqual'vec'$1_aggregator_Aggregator''| (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v1@@2) i@@9))) (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v2@@2) i@@9)))) (|$IsEqual'vec'$1_optional_aggregator_Integer''| (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v1@@2) i@@9))) (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v2@@2) i@@9))))))
 :qid |boogiebpl.3992:13|
 :skolemid |146|
))))
 :qid |boogiebpl.3990:67|
 :skolemid |147|
 :pattern ( (|$IsEqual'vec'$1_optional_aggregator_OptionalAggregator''| v1@@2 v2@@2))
)))
(assert (forall ((v1@@3 T@Vec_6673) (v2@@3 T@Vec_6673) ) (! (= (|$IsEqual'vec'address''| v1@@3 v2@@3)  (and (= (|l#Vec_6673| v1@@3) (|l#Vec_6673| v2@@3)) (forall ((i@@10 Int) ) (!  (=> (InRangeVec_25002 v1@@3 i@@10) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v1@@3) i@@10) (|Select__T@[Int]Int_| (|v#Vec_6673| v2@@3) i@@10)))
 :qid |boogiebpl.4296:13|
 :skolemid |157|
))))
 :qid |boogiebpl.4294:33|
 :skolemid |158|
 :pattern ( (|$IsEqual'vec'address''| v1@@3 v2@@3))
)))
(assert (forall ((v1@@4 T@Vec_6673) (v2@@4 T@Vec_6673) ) (! (= (|$IsEqual'vec'u64''| v1@@4 v2@@4)  (and (= (|l#Vec_6673| v1@@4) (|l#Vec_6673| v2@@4)) (forall ((i@@11 Int) ) (!  (=> (InRangeVec_25002 v1@@4 i@@11) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v1@@4) i@@11) (|Select__T@[Int]Int_| (|v#Vec_6673| v2@@4) i@@11)))
 :qid |boogiebpl.4600:13|
 :skolemid |168|
))))
 :qid |boogiebpl.4598:29|
 :skolemid |169|
 :pattern ( (|$IsEqual'vec'u64''| v1@@4 v2@@4))
)))
(assert (forall ((v1@@5 T@Vec_6673) (v2@@5 T@Vec_6673) ) (! (= (|$IsEqual'vec'u8''| v1@@5 v2@@5)  (and (= (|l#Vec_6673| v1@@5) (|l#Vec_6673| v2@@5)) (forall ((i@@12 Int) ) (!  (=> (InRangeVec_25002 v1@@5 i@@12) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v1@@5) i@@12) (|Select__T@[Int]Int_| (|v#Vec_6673| v2@@5) i@@12)))
 :qid |boogiebpl.4904:13|
 :skolemid |179|
))))
 :qid |boogiebpl.4902:28|
 :skolemid |180|
 :pattern ( (|$IsEqual'vec'u8''| v1@@5 v2@@5))
)))
(assert (forall ((v1@@6 T@Vec_67815) (v2@@6 T@Vec_67815) ) (! (= (|$IsEqual'vec'bv64''| v1@@6 v2@@6)  (and (= (|l#Vec_67815| v1@@6) (|l#Vec_67815| v2@@6)) (forall ((i@@13 Int) ) (!  (=> (InRangeVec_67819 v1@@6 i@@13) (= (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| v1@@6) i@@13) (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| v2@@6) i@@13)))
 :qid |boogiebpl.5208:13|
 :skolemid |190|
))))
 :qid |boogiebpl.5206:30|
 :skolemid |191|
 :pattern ( (|$IsEqual'vec'bv64''| v1@@6 v2@@6))
)))
(assert (forall ((v1@@7 T@Vec_68162) (v2@@7 T@Vec_68162) ) (! (= (|$IsEqual'vec'bv8''| v1@@7 v2@@7)  (and (= (|l#Vec_68162| v1@@7) (|l#Vec_68162| v2@@7)) (forall ((i@@14 Int) ) (!  (=> (InRangeVec_68166 v1@@7 i@@14) (= (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| v1@@7) i@@14) (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| v2@@7) i@@14)))
 :qid |boogiebpl.5512:13|
 :skolemid |201|
))))
 :qid |boogiebpl.5510:29|
 :skolemid |202|
 :pattern ( (|$IsEqual'vec'bv8''| v1@@7 v2@@7))
)))
(assert (forall ((v T@Vec_85428) (prefix T@Vec_85428) ) (! (= (|$IsPrefix'vec'#0''| v prefix)  (and (>= (|l#Vec_85428| v) (|l#Vec_85428| prefix)) (forall ((i@@15 Int) ) (!  (=> (InRangeVec_65852 prefix i@@15) (= (|Select__T@[Int]#0_| (|v#Vec_85428| v) i@@15) (|Select__T@[Int]#0_| (|v#Vec_85428| prefix) i@@15)))
 :qid |boogiebpl.3086:13|
 :skolemid |115|
))))
 :qid |boogiebpl.3084:29|
 :skolemid |116|
 :pattern ( (|$IsPrefix'vec'#0''| v prefix))
)))
(assert (forall ((v@@0 T@Vec_90390) (prefix@@0 T@Vec_90390) ) (! (= (|$IsPrefix'vec'$1_aggregator_Aggregator''| v@@0 prefix@@0)  (and (>= (|l#Vec_90390| v@@0) (|l#Vec_90390| prefix@@0)) (forall ((i@@16 Int) ) (!  (=> (InRangeVec_66199 prefix@@0 i@@16) (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| v@@0) i@@16) (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| prefix@@0) i@@16)))
 :qid |boogiebpl.3390:13|
 :skolemid |126|
))))
 :qid |boogiebpl.3388:51|
 :skolemid |127|
 :pattern ( (|$IsPrefix'vec'$1_aggregator_Aggregator''| v@@0 prefix@@0))
)))
(assert (forall ((v@@1 T@Vec_95276) (prefix@@1 T@Vec_95276) ) (! (= (|$IsPrefix'vec'$1_optional_aggregator_Integer''| v@@1 prefix@@1)  (and (>= (|l#Vec_95276| v@@1) (|l#Vec_95276| prefix@@1)) (forall ((i@@17 Int) ) (!  (=> (InRangeVec_66546 prefix@@1 i@@17) (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| v@@1) i@@17) (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| prefix@@1) i@@17)))
 :qid |boogiebpl.3694:13|
 :skolemid |137|
))))
 :qid |boogiebpl.3692:57|
 :skolemid |138|
 :pattern ( (|$IsPrefix'vec'$1_optional_aggregator_Integer''| v@@1 prefix@@1))
)))
(assert (forall ((v@@2 T@Vec_100175) (prefix@@2 T@Vec_100175) ) (! (= (|$IsPrefix'vec'$1_optional_aggregator_OptionalAggregator''| v@@2 prefix@@2)  (and (>= (|l#Vec_100175| v@@2) (|l#Vec_100175| prefix@@2)) (forall ((i@@18 Int) ) (!  (=> (InRangeVec_66893 prefix@@2 i@@18) (and (|$IsEqual'vec'$1_aggregator_Aggregator''| (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@2) i@@18))) (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| prefix@@2) i@@18)))) (|$IsEqual'vec'$1_optional_aggregator_Integer''| (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@2) i@@18))) (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| prefix@@2) i@@18))))))
 :qid |boogiebpl.3998:13|
 :skolemid |148|
))))
 :qid |boogiebpl.3996:68|
 :skolemid |149|
 :pattern ( (|$IsPrefix'vec'$1_optional_aggregator_OptionalAggregator''| v@@2 prefix@@2))
)))
(assert (forall ((v@@3 T@Vec_6673) (prefix@@3 T@Vec_6673) ) (! (= (|$IsPrefix'vec'address''| v@@3 prefix@@3)  (and (>= (|l#Vec_6673| v@@3) (|l#Vec_6673| prefix@@3)) (forall ((i@@19 Int) ) (!  (=> (InRangeVec_25002 prefix@@3 i@@19) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@3) i@@19) (|Select__T@[Int]Int_| (|v#Vec_6673| prefix@@3) i@@19)))
 :qid |boogiebpl.4302:13|
 :skolemid |159|
))))
 :qid |boogiebpl.4300:34|
 :skolemid |160|
 :pattern ( (|$IsPrefix'vec'address''| v@@3 prefix@@3))
)))
(assert (forall ((v@@4 T@Vec_6673) (prefix@@4 T@Vec_6673) ) (! (= (|$IsPrefix'vec'u64''| v@@4 prefix@@4)  (and (>= (|l#Vec_6673| v@@4) (|l#Vec_6673| prefix@@4)) (forall ((i@@20 Int) ) (!  (=> (InRangeVec_25002 prefix@@4 i@@20) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@4) i@@20) (|Select__T@[Int]Int_| (|v#Vec_6673| prefix@@4) i@@20)))
 :qid |boogiebpl.4606:13|
 :skolemid |170|
))))
 :qid |boogiebpl.4604:30|
 :skolemid |171|
 :pattern ( (|$IsPrefix'vec'u64''| v@@4 prefix@@4))
)))
(assert (forall ((v@@5 T@Vec_6673) (prefix@@5 T@Vec_6673) ) (! (= (|$IsPrefix'vec'u8''| v@@5 prefix@@5)  (and (>= (|l#Vec_6673| v@@5) (|l#Vec_6673| prefix@@5)) (forall ((i@@21 Int) ) (!  (=> (InRangeVec_25002 prefix@@5 i@@21) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@5) i@@21) (|Select__T@[Int]Int_| (|v#Vec_6673| prefix@@5) i@@21)))
 :qid |boogiebpl.4910:13|
 :skolemid |181|
))))
 :qid |boogiebpl.4908:29|
 :skolemid |182|
 :pattern ( (|$IsPrefix'vec'u8''| v@@5 prefix@@5))
)))
(assert (forall ((v@@6 T@Vec_67815) (prefix@@6 T@Vec_67815) ) (! (= (|$IsPrefix'vec'bv64''| v@@6 prefix@@6)  (and (>= (|l#Vec_67815| v@@6) (|l#Vec_67815| prefix@@6)) (forall ((i@@22 Int) ) (!  (=> (InRangeVec_67819 prefix@@6 i@@22) (= (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| v@@6) i@@22) (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| prefix@@6) i@@22)))
 :qid |boogiebpl.5214:13|
 :skolemid |192|
))))
 :qid |boogiebpl.5212:31|
 :skolemid |193|
 :pattern ( (|$IsPrefix'vec'bv64''| v@@6 prefix@@6))
)))
(assert (forall ((v@@7 T@Vec_68162) (prefix@@7 T@Vec_68162) ) (! (= (|$IsPrefix'vec'bv8''| v@@7 prefix@@7)  (and (>= (|l#Vec_68162| v@@7) (|l#Vec_68162| prefix@@7)) (forall ((i@@23 Int) ) (!  (=> (InRangeVec_68166 prefix@@7 i@@23) (= (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| v@@7) i@@23) (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| prefix@@7) i@@23)))
 :qid |boogiebpl.5518:13|
 :skolemid |203|
))))
 :qid |boogiebpl.5516:30|
 :skolemid |204|
 :pattern ( (|$IsPrefix'vec'bv8''| v@@7 prefix@@7))
)))
(assert (forall ((t1 T@Table_35290_35291) (t2 T@Table_35290_35291) ) (! (= (|$IsEqual'$1_table_Table'u64_bool''| t1 t2)  (and (and (and (= (|l#Table_35290_35291| t1) (|l#Table_35290_35291| t2)) (forall ((k Int) ) (! (= (|Select__T@[Int]Bool_| (|e#Table_35290_35291| t1) k) (|Select__T@[Int]Bool_| (|e#Table_35290_35291| t2) k))
 :qid |boogiebpl.5838:13|
 :skolemid |214|
))) (forall ((k@@0 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_35290_35291| t1) k@@0) (= (|Select__T@[Int]Bool_| (|v#Table_35290_35291| t1) k@@0) (|Select__T@[Int]Bool_| (|v#Table_35290_35291| t2) k@@0)))
 :qid |boogiebpl.5839:13|
 :skolemid |215|
))) (forall ((k@@1 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_35290_35291| t2) k@@1) (= (|Select__T@[Int]Bool_| (|v#Table_35290_35291| t1) k@@1) (|Select__T@[Int]Bool_| (|v#Table_35290_35291| t2) k@@1)))
 :qid |boogiebpl.5840:13|
 :skolemid |216|
))))
 :qid |boogiebpl.5836:45|
 :skolemid |217|
 :pattern ( (|$IsEqual'$1_table_Table'u64_bool''| t1 t2))
)))
(assert (= DefaultTableKeyExistsArray_990 (|lambda#28| false)))
(assert (forall ((v@@8 T@Vec_68162) (e (_ BitVec 8)) ) (! (let ((i@@24 (IndexOfVec_68162 v@@8 e)))
(ite  (not (exists ((i@@25 Int) ) (!  (and (InRangeVec_68166 v@@8 i@@25) (= (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| v@@8) i@@25) e))
 :qid |boogiebpl.110:13|
 :skolemid |0|
))) (= i@@24 (- 0 1))  (and (and (InRangeVec_68166 v@@8 i@@24) (= (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| v@@8) i@@24) e)) (forall ((j Int) ) (!  (=> (and (>= j 0) (< j i@@24)) (not (= (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| v@@8) j) e)))
 :qid |boogiebpl.118:17|
 :skolemid |1|
)))))
 :qid |boogiebpl.114:32|
 :skolemid |2|
 :pattern ( (IndexOfVec_68162 v@@8 e))
)))
(assert (forall ((v@@9 T@Vec_67815) (e@@0 (_ BitVec 64)) ) (! (let ((i@@26 (IndexOfVec_67815 v@@9 e@@0)))
(ite  (not (exists ((i@@27 Int) ) (!  (and (InRangeVec_67819 v@@9 i@@27) (= (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| v@@9) i@@27) e@@0))
 :qid |boogiebpl.110:13|
 :skolemid |0|
))) (= i@@26 (- 0 1))  (and (and (InRangeVec_67819 v@@9 i@@26) (= (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| v@@9) i@@26) e@@0)) (forall ((j@@0 Int) ) (!  (=> (and (>= j@@0 0) (< j@@0 i@@26)) (not (= (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| v@@9) j@@0) e@@0)))
 :qid |boogiebpl.118:17|
 :skolemid |1|
)))))
 :qid |boogiebpl.114:32|
 :skolemid |2|
 :pattern ( (IndexOfVec_67815 v@@9 e@@0))
)))
(assert (forall ((v@@10 T@Vec_100175) (e@@1 T@$1_optional_aggregator_OptionalAggregator) ) (! (let ((i@@28 (IndexOfVec_100175 v@@10 e@@1)))
(ite  (not (exists ((i@@29 Int) ) (!  (and (InRangeVec_66893 v@@10 i@@29) (= (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@10) i@@29) e@@1))
 :qid |boogiebpl.110:13|
 :skolemid |0|
))) (= i@@28 (- 0 1))  (and (and (InRangeVec_66893 v@@10 i@@28) (= (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@10) i@@28) e@@1)) (forall ((j@@1 Int) ) (!  (=> (and (>= j@@1 0) (< j@@1 i@@28)) (not (= (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@10) j@@1) e@@1)))
 :qid |boogiebpl.118:17|
 :skolemid |1|
)))))
 :qid |boogiebpl.114:32|
 :skolemid |2|
 :pattern ( (IndexOfVec_100175 v@@10 e@@1))
)))
(assert (forall ((v@@11 T@Vec_95276) (e@@2 T@$1_optional_aggregator_Integer) ) (! (let ((i@@30 (IndexOfVec_95276 v@@11 e@@2)))
(ite  (not (exists ((i@@31 Int) ) (!  (and (InRangeVec_66546 v@@11 i@@31) (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| v@@11) i@@31) e@@2))
 :qid |boogiebpl.110:13|
 :skolemid |0|
))) (= i@@30 (- 0 1))  (and (and (InRangeVec_66546 v@@11 i@@30) (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| v@@11) i@@30) e@@2)) (forall ((j@@2 Int) ) (!  (=> (and (>= j@@2 0) (< j@@2 i@@30)) (not (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| v@@11) j@@2) e@@2)))
 :qid |boogiebpl.118:17|
 :skolemid |1|
)))))
 :qid |boogiebpl.114:32|
 :skolemid |2|
 :pattern ( (IndexOfVec_95276 v@@11 e@@2))
)))
(assert (forall ((v@@12 T@Vec_90390) (e@@3 T@$1_aggregator_Aggregator) ) (! (let ((i@@32 (IndexOfVec_90390 v@@12 e@@3)))
(ite  (not (exists ((i@@33 Int) ) (!  (and (InRangeVec_66199 v@@12 i@@33) (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| v@@12) i@@33) e@@3))
 :qid |boogiebpl.110:13|
 :skolemid |0|
))) (= i@@32 (- 0 1))  (and (and (InRangeVec_66199 v@@12 i@@32) (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| v@@12) i@@32) e@@3)) (forall ((j@@3 Int) ) (!  (=> (and (>= j@@3 0) (< j@@3 i@@32)) (not (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| v@@12) j@@3) e@@3)))
 :qid |boogiebpl.118:17|
 :skolemid |1|
)))))
 :qid |boogiebpl.114:32|
 :skolemid |2|
 :pattern ( (IndexOfVec_90390 v@@12 e@@3))
)))
(assert (forall ((v@@13 T@Vec_6673) (e@@4 Int) ) (! (let ((i@@34 (IndexOfVec_6673 v@@13 e@@4)))
(ite  (not (exists ((i@@35 Int) ) (!  (and (InRangeVec_25002 v@@13 i@@35) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@13) i@@35) e@@4))
 :qid |boogiebpl.110:13|
 :skolemid |0|
))) (= i@@34 (- 0 1))  (and (and (InRangeVec_25002 v@@13 i@@34) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@13) i@@34) e@@4)) (forall ((j@@4 Int) ) (!  (=> (and (>= j@@4 0) (< j@@4 i@@34)) (not (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@13) j@@4) e@@4)))
 :qid |boogiebpl.118:17|
 :skolemid |1|
)))))
 :qid |boogiebpl.114:32|
 :skolemid |2|
 :pattern ( (IndexOfVec_6673 v@@13 e@@4))
)))
(assert (forall ((v@@14 T@Vec_85428) (e@@5 |T@#0|) ) (! (let ((i@@36 (IndexOfVec_85428 v@@14 e@@5)))
(ite  (not (exists ((i@@37 Int) ) (!  (and (InRangeVec_65852 v@@14 i@@37) (= (|Select__T@[Int]#0_| (|v#Vec_85428| v@@14) i@@37) e@@5))
 :qid |boogiebpl.110:13|
 :skolemid |0|
))) (= i@@36 (- 0 1))  (and (and (InRangeVec_65852 v@@14 i@@36) (= (|Select__T@[Int]#0_| (|v#Vec_85428| v@@14) i@@36) e@@5)) (forall ((j@@5 Int) ) (!  (=> (and (>= j@@5 0) (< j@@5 i@@36)) (not (= (|Select__T@[Int]#0_| (|v#Vec_85428| v@@14) j@@5) e@@5)))
 :qid |boogiebpl.118:17|
 :skolemid |1|
)))))
 :qid |boogiebpl.114:32|
 :skolemid |2|
 :pattern ( (IndexOfVec_85428 v@@14 e@@5))
)))
(assert (forall ((s1 T@Vec_6673) (s2 T@Vec_6673) (k1 T@Vec_6673) (k2 T@Vec_6673) (m1 T@Vec_6673) (m2 T@Vec_6673) ) (!  (=> (and (and (|$IsEqual'vec'u8''| s1 s2) (|$IsEqual'vec'u8''| k1 k2)) (|$IsEqual'vec'u8''| m1 m2)) (= ($1_Signature_$ed25519_verify s1 k1 m1) ($1_Signature_$ed25519_verify s2 k2 m2)))
 :qid |boogiebpl.6438:15|
 :skolemid |241|
 :pattern ( ($1_Signature_$ed25519_verify s1 k1 m1) ($1_Signature_$ed25519_verify s2 k2 m2))
)))
(assert (forall ((|l#0@@6| Int) (|l#1@@6| Int) (|l#2@@6| Int) (|l#3@@6| |T@[Int]#0|) (|l#4@@6| |T@[Int]#0|) (|l#5@@6| Int) (|l#6| |T@#0|) (i@@38 Int) ) (! (= (|Select__T@[Int]#0_| (|lambda#0| |l#0@@6| |l#1@@6| |l#2@@6| |l#3@@6| |l#4@@6| |l#5@@6| |l#6|) i@@38) (ite  (and (>= i@@38 |l#0@@6|) (< i@@38 |l#1@@6|)) (ite (< i@@38 |l#2@@6|) (|Select__T@[Int]#0_| |l#3@@6| i@@38) (|Select__T@[Int]#0_| |l#4@@6| (- i@@38 |l#5@@6|))) |l#6|))
 :qid |boogiebpl.74:19|
 :skolemid |562|
 :pattern ( (|Select__T@[Int]#0_| (|lambda#0| |l#0@@6| |l#1@@6| |l#2@@6| |l#3@@6| |l#4@@6| |l#5@@6| |l#6|) i@@38))
)))
(assert (forall ((|l#0@@7| Int) (|l#1@@7| Int) (|l#2@@7| Int) (|l#3@@7| |T@[Int]$1_aggregator_Aggregator|) (|l#4@@7| |T@[Int]$1_aggregator_Aggregator|) (|l#5@@7| Int) (|l#6@@0| T@$1_aggregator_Aggregator) (i@@39 Int) ) (! (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|lambda#4| |l#0@@7| |l#1@@7| |l#2@@7| |l#3@@7| |l#4@@7| |l#5@@7| |l#6@@0|) i@@39) (ite  (and (>= i@@39 |l#0@@7|) (< i@@39 |l#1@@7|)) (ite (< i@@39 |l#2@@7|) (|Select__T@[Int]$1_aggregator_Aggregator_| |l#3@@7| i@@39) (|Select__T@[Int]$1_aggregator_Aggregator_| |l#4@@7| (- i@@39 |l#5@@7|))) |l#6@@0|))
 :qid |boogiebpl.74:19|
 :skolemid |566|
 :pattern ( (|Select__T@[Int]$1_aggregator_Aggregator_| (|lambda#4| |l#0@@7| |l#1@@7| |l#2@@7| |l#3@@7| |l#4@@7| |l#5@@7| |l#6@@0|) i@@39))
)))
(assert (forall ((|l#0@@8| Int) (|l#1@@8| Int) (|l#2@@8| Int) (|l#3@@8| |T@[Int]$1_optional_aggregator_Integer|) (|l#4@@8| |T@[Int]$1_optional_aggregator_Integer|) (|l#5@@8| Int) (|l#6@@1| T@$1_optional_aggregator_Integer) (i@@40 Int) ) (! (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|lambda#8| |l#0@@8| |l#1@@8| |l#2@@8| |l#3@@8| |l#4@@8| |l#5@@8| |l#6@@1|) i@@40) (ite  (and (>= i@@40 |l#0@@8|) (< i@@40 |l#1@@8|)) (ite (< i@@40 |l#2@@8|) (|Select__T@[Int]$1_optional_aggregator_Integer_| |l#3@@8| i@@40) (|Select__T@[Int]$1_optional_aggregator_Integer_| |l#4@@8| (- i@@40 |l#5@@8|))) |l#6@@1|))
 :qid |boogiebpl.74:19|
 :skolemid |570|
 :pattern ( (|Select__T@[Int]$1_optional_aggregator_Integer_| (|lambda#8| |l#0@@8| |l#1@@8| |l#2@@8| |l#3@@8| |l#4@@8| |l#5@@8| |l#6@@1|) i@@40))
)))
(assert (forall ((|l#0@@9| Int) (|l#1@@9| Int) (|l#2@@9| Int) (|l#3@@9| |T@[Int]$1_optional_aggregator_OptionalAggregator|) (|l#4@@9| |T@[Int]$1_optional_aggregator_OptionalAggregator|) (|l#5@@9| Int) (|l#6@@2| T@$1_optional_aggregator_OptionalAggregator) (i@@41 Int) ) (! (= (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|lambda#12| |l#0@@9| |l#1@@9| |l#2@@9| |l#3@@9| |l#4@@9| |l#5@@9| |l#6@@2|) i@@41) (ite  (and (>= i@@41 |l#0@@9|) (< i@@41 |l#1@@9|)) (ite (< i@@41 |l#2@@9|) (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| |l#3@@9| i@@41) (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| |l#4@@9| (- i@@41 |l#5@@9|))) |l#6@@2|))
 :qid |boogiebpl.74:19|
 :skolemid |574|
 :pattern ( (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|lambda#12| |l#0@@9| |l#1@@9| |l#2@@9| |l#3@@9| |l#4@@9| |l#5@@9| |l#6@@2|) i@@41))
)))
(assert (forall ((|l#0@@10| Int) (|l#1@@10| Int) (|l#2@@10| Int) (|l#3@@10| |T@[Int]Int|) (|l#4@@10| |T@[Int]Int|) (|l#5@@10| Int) (|l#6@@3| Int) (i@@42 Int) ) (! (= (|Select__T@[Int]Int_| (|lambda#16| |l#0@@10| |l#1@@10| |l#2@@10| |l#3@@10| |l#4@@10| |l#5@@10| |l#6@@3|) i@@42) (ite  (and (>= i@@42 |l#0@@10|) (< i@@42 |l#1@@10|)) (ite (< i@@42 |l#2@@10|) (|Select__T@[Int]Int_| |l#3@@10| i@@42) (|Select__T@[Int]Int_| |l#4@@10| (- i@@42 |l#5@@10|))) |l#6@@3|))
 :qid |boogiebpl.74:19|
 :skolemid |578|
 :pattern ( (|Select__T@[Int]Int_| (|lambda#16| |l#0@@10| |l#1@@10| |l#2@@10| |l#3@@10| |l#4@@10| |l#5@@10| |l#6@@3|) i@@42))
)))
(assert (forall ((|l#0@@11| Int) (|l#1@@11| Int) (|l#2@@11| Int) (|l#3@@11| |T@[Int](_ BitVec 64)|) (|l#4@@11| |T@[Int](_ BitVec 64)|) (|l#5@@11| Int) (|l#6@@4| (_ BitVec 64)) (i@@43 Int) ) (! (= (|Select__T@[Int](_ BitVec 64)_| (|lambda#20| |l#0@@11| |l#1@@11| |l#2@@11| |l#3@@11| |l#4@@11| |l#5@@11| |l#6@@4|) i@@43) (ite  (and (>= i@@43 |l#0@@11|) (< i@@43 |l#1@@11|)) (ite (< i@@43 |l#2@@11|) (|Select__T@[Int](_ BitVec 64)_| |l#3@@11| i@@43) (|Select__T@[Int](_ BitVec 64)_| |l#4@@11| (- i@@43 |l#5@@11|))) |l#6@@4|))
 :qid |boogiebpl.74:19|
 :skolemid |582|
 :pattern ( (|Select__T@[Int](_ BitVec 64)_| (|lambda#20| |l#0@@11| |l#1@@11| |l#2@@11| |l#3@@11| |l#4@@11| |l#5@@11| |l#6@@4|) i@@43))
)))
(assert (forall ((|l#0@@12| Int) (|l#1@@12| Int) (|l#2@@12| Int) (|l#3@@12| |T@[Int](_ BitVec 8)|) (|l#4@@12| |T@[Int](_ BitVec 8)|) (|l#5@@12| Int) (|l#6@@5| (_ BitVec 8)) (i@@44 Int) ) (! (= (|Select__T@[Int](_ BitVec 8)_| (|lambda#24| |l#0@@12| |l#1@@12| |l#2@@12| |l#3@@12| |l#4@@12| |l#5@@12| |l#6@@5|) i@@44) (ite  (and (>= i@@44 |l#0@@12|) (< i@@44 |l#1@@12|)) (ite (< i@@44 |l#2@@12|) (|Select__T@[Int](_ BitVec 8)_| |l#3@@12| i@@44) (|Select__T@[Int](_ BitVec 8)_| |l#4@@12| (- i@@44 |l#5@@12|))) |l#6@@5|))
 :qid |boogiebpl.74:19|
 :skolemid |586|
 :pattern ( (|Select__T@[Int](_ BitVec 8)_| (|lambda#24| |l#0@@12| |l#1@@12| |l#2@@12| |l#3@@12| |l#4@@12| |l#5@@12| |l#6@@5|) i@@44))
)))
(assert (forall ((|l#0@@13| Int) (|l#1@@13| Int) (|l#2@@13| Int) (|l#3@@13| |T@[Int]#0|) (|l#4@@13| |T@[Int]#0|) (|l#5@@13| Int) (|l#6@@6| |T@#0|) (j@@6 Int) ) (! (= (|Select__T@[Int]#0_| (|lambda#3| |l#0@@13| |l#1@@13| |l#2@@13| |l#3@@13| |l#4@@13| |l#5@@13| |l#6@@6|) j@@6) (ite  (and (>= j@@6 |l#0@@13|) (< j@@6 |l#1@@13|)) (ite (< j@@6 |l#2@@13|) (|Select__T@[Int]#0_| |l#3@@13| j@@6) (|Select__T@[Int]#0_| |l#4@@13| (+ j@@6 |l#5@@13|))) |l#6@@6|))
 :qid |boogiebpl.64:20|
 :skolemid |565|
 :pattern ( (|Select__T@[Int]#0_| (|lambda#3| |l#0@@13| |l#1@@13| |l#2@@13| |l#3@@13| |l#4@@13| |l#5@@13| |l#6@@6|) j@@6))
)))
(assert (forall ((|l#0@@14| Int) (|l#1@@14| Int) (|l#2@@14| Int) (|l#3@@14| |T@[Int]$1_aggregator_Aggregator|) (|l#4@@14| |T@[Int]$1_aggregator_Aggregator|) (|l#5@@14| Int) (|l#6@@7| T@$1_aggregator_Aggregator) (j@@7 Int) ) (! (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|lambda#7| |l#0@@14| |l#1@@14| |l#2@@14| |l#3@@14| |l#4@@14| |l#5@@14| |l#6@@7|) j@@7) (ite  (and (>= j@@7 |l#0@@14|) (< j@@7 |l#1@@14|)) (ite (< j@@7 |l#2@@14|) (|Select__T@[Int]$1_aggregator_Aggregator_| |l#3@@14| j@@7) (|Select__T@[Int]$1_aggregator_Aggregator_| |l#4@@14| (+ j@@7 |l#5@@14|))) |l#6@@7|))
 :qid |boogiebpl.64:20|
 :skolemid |569|
 :pattern ( (|Select__T@[Int]$1_aggregator_Aggregator_| (|lambda#7| |l#0@@14| |l#1@@14| |l#2@@14| |l#3@@14| |l#4@@14| |l#5@@14| |l#6@@7|) j@@7))
)))
(assert (forall ((|l#0@@15| Int) (|l#1@@15| Int) (|l#2@@15| Int) (|l#3@@15| |T@[Int]$1_optional_aggregator_Integer|) (|l#4@@15| |T@[Int]$1_optional_aggregator_Integer|) (|l#5@@15| Int) (|l#6@@8| T@$1_optional_aggregator_Integer) (j@@8 Int) ) (! (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|lambda#11| |l#0@@15| |l#1@@15| |l#2@@15| |l#3@@15| |l#4@@15| |l#5@@15| |l#6@@8|) j@@8) (ite  (and (>= j@@8 |l#0@@15|) (< j@@8 |l#1@@15|)) (ite (< j@@8 |l#2@@15|) (|Select__T@[Int]$1_optional_aggregator_Integer_| |l#3@@15| j@@8) (|Select__T@[Int]$1_optional_aggregator_Integer_| |l#4@@15| (+ j@@8 |l#5@@15|))) |l#6@@8|))
 :qid |boogiebpl.64:20|
 :skolemid |573|
 :pattern ( (|Select__T@[Int]$1_optional_aggregator_Integer_| (|lambda#11| |l#0@@15| |l#1@@15| |l#2@@15| |l#3@@15| |l#4@@15| |l#5@@15| |l#6@@8|) j@@8))
)))
(assert (forall ((|l#0@@16| Int) (|l#1@@16| Int) (|l#2@@16| Int) (|l#3@@16| |T@[Int]$1_optional_aggregator_OptionalAggregator|) (|l#4@@16| |T@[Int]$1_optional_aggregator_OptionalAggregator|) (|l#5@@16| Int) (|l#6@@9| T@$1_optional_aggregator_OptionalAggregator) (j@@9 Int) ) (! (= (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|lambda#15| |l#0@@16| |l#1@@16| |l#2@@16| |l#3@@16| |l#4@@16| |l#5@@16| |l#6@@9|) j@@9) (ite  (and (>= j@@9 |l#0@@16|) (< j@@9 |l#1@@16|)) (ite (< j@@9 |l#2@@16|) (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| |l#3@@16| j@@9) (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| |l#4@@16| (+ j@@9 |l#5@@16|))) |l#6@@9|))
 :qid |boogiebpl.64:20|
 :skolemid |577|
 :pattern ( (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|lambda#15| |l#0@@16| |l#1@@16| |l#2@@16| |l#3@@16| |l#4@@16| |l#5@@16| |l#6@@9|) j@@9))
)))
(assert (forall ((|l#0@@17| Int) (|l#1@@17| Int) (|l#2@@17| Int) (|l#3@@17| |T@[Int]Int|) (|l#4@@17| |T@[Int]Int|) (|l#5@@17| Int) (|l#6@@10| Int) (j@@10 Int) ) (! (= (|Select__T@[Int]Int_| (|lambda#19| |l#0@@17| |l#1@@17| |l#2@@17| |l#3@@17| |l#4@@17| |l#5@@17| |l#6@@10|) j@@10) (ite  (and (>= j@@10 |l#0@@17|) (< j@@10 |l#1@@17|)) (ite (< j@@10 |l#2@@17|) (|Select__T@[Int]Int_| |l#3@@17| j@@10) (|Select__T@[Int]Int_| |l#4@@17| (+ j@@10 |l#5@@17|))) |l#6@@10|))
 :qid |boogiebpl.64:20|
 :skolemid |581|
 :pattern ( (|Select__T@[Int]Int_| (|lambda#19| |l#0@@17| |l#1@@17| |l#2@@17| |l#3@@17| |l#4@@17| |l#5@@17| |l#6@@10|) j@@10))
)))
(assert (forall ((|l#0@@18| Int) (|l#1@@18| Int) (|l#2@@18| Int) (|l#3@@18| |T@[Int](_ BitVec 64)|) (|l#4@@18| |T@[Int](_ BitVec 64)|) (|l#5@@18| Int) (|l#6@@11| (_ BitVec 64)) (j@@11 Int) ) (! (= (|Select__T@[Int](_ BitVec 64)_| (|lambda#23| |l#0@@18| |l#1@@18| |l#2@@18| |l#3@@18| |l#4@@18| |l#5@@18| |l#6@@11|) j@@11) (ite  (and (>= j@@11 |l#0@@18|) (< j@@11 |l#1@@18|)) (ite (< j@@11 |l#2@@18|) (|Select__T@[Int](_ BitVec 64)_| |l#3@@18| j@@11) (|Select__T@[Int](_ BitVec 64)_| |l#4@@18| (+ j@@11 |l#5@@18|))) |l#6@@11|))
 :qid |boogiebpl.64:20|
 :skolemid |585|
 :pattern ( (|Select__T@[Int](_ BitVec 64)_| (|lambda#23| |l#0@@18| |l#1@@18| |l#2@@18| |l#3@@18| |l#4@@18| |l#5@@18| |l#6@@11|) j@@11))
)))
(assert (forall ((|l#0@@19| Int) (|l#1@@19| Int) (|l#2@@19| Int) (|l#3@@19| |T@[Int](_ BitVec 8)|) (|l#4@@19| |T@[Int](_ BitVec 8)|) (|l#5@@19| Int) (|l#6@@12| (_ BitVec 8)) (j@@12 Int) ) (! (= (|Select__T@[Int](_ BitVec 8)_| (|lambda#27| |l#0@@19| |l#1@@19| |l#2@@19| |l#3@@19| |l#4@@19| |l#5@@19| |l#6@@12|) j@@12) (ite  (and (>= j@@12 |l#0@@19|) (< j@@12 |l#1@@19|)) (ite (< j@@12 |l#2@@19|) (|Select__T@[Int](_ BitVec 8)_| |l#3@@19| j@@12) (|Select__T@[Int](_ BitVec 8)_| |l#4@@19| (+ j@@12 |l#5@@19|))) |l#6@@12|))
 :qid |boogiebpl.64:20|
 :skolemid |589|
 :pattern ( (|Select__T@[Int](_ BitVec 8)_| (|lambda#27| |l#0@@19| |l#1@@19| |l#2@@19| |l#3@@19| |l#4@@19| |l#5@@19| |l#6@@12|) j@@12))
)))
(assert (forall ((v@@15 (_ BitVec 32)) ) (! (= (|$IsValid'bv32'| v@@15)  (and (bvuge v@@15 #x00000000) (bvule v@@15 #x7fffffff)))
 :qid |boogiebpl.673:25|
 :skolemid |16|
 :pattern ( (|$IsValid'bv32'| v@@15))
)))
(assert (forall ((v@@16 Int) ) (! (let ((r (|$1_bcs_serialize'address'| v@@16)))
 (and (|$IsValid'vec'u8''| r) (> (|l#Vec_6673| r) 0)))
 :qid |boogiebpl.6470:15|
 :skolemid |243|
 :pattern ( (|$1_bcs_serialize'address'| v@@16))
)))
(assert (forall ((b1 T@Vec_6673) (b2 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1) (=> (|$IsValid'vec'u8''| b2) (=> (|$IsEqual'vec'u8''| ($1_aptos_hash_spec_keccak256 b1) ($1_aptos_hash_spec_keccak256 b2)) (|$IsEqual'vec'u8''| b1 b2))))
 :qid |boogiebpl.6890:15|
 :skolemid |379|
)))
(assert (forall ((b1@@0 T@Vec_6673) (b2@@0 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@0) (=> (|$IsValid'vec'u8''| b2@@0) (=> (|$IsEqual'vec'u8''| ($1_aptos_hash_spec_sha2_512_internal b1@@0) ($1_aptos_hash_spec_sha2_512_internal b2@@0)) (|$IsEqual'vec'u8''| b1@@0 b2@@0))))
 :qid |boogiebpl.6893:15|
 :skolemid |380|
)))
(assert (forall ((b1@@1 T@Vec_6673) (b2@@1 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@1) (=> (|$IsValid'vec'u8''| b2@@1) (=> (|$IsEqual'vec'u8''| ($1_aptos_hash_spec_sha3_512_internal b1@@1) ($1_aptos_hash_spec_sha3_512_internal b2@@1)) (|$IsEqual'vec'u8''| b1@@1 b2@@1))))
 :qid |boogiebpl.6896:15|
 :skolemid |381|
)))
(assert (forall ((b1@@2 T@Vec_6673) (b2@@2 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@2) (=> (|$IsValid'vec'u8''| b2@@2) (=> (|$IsEqual'vec'u8''| ($1_aptos_hash_spec_ripemd160_internal b1@@2) ($1_aptos_hash_spec_ripemd160_internal b2@@2)) (|$IsEqual'vec'u8''| b1@@2 b2@@2))))
 :qid |boogiebpl.6899:15|
 :skolemid |382|
)))
(assert (forall ((b1@@3 T@Vec_6673) (b2@@3 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@3) (=> (|$IsValid'vec'u8''| b2@@3) (=> (|$IsEqual'vec'u8''| ($1_aptos_hash_spec_blake2b_256_internal b1@@3) ($1_aptos_hash_spec_blake2b_256_internal b2@@3)) (|$IsEqual'vec'u8''| b1@@3 b2@@3))))
 :qid |boogiebpl.6902:15|
 :skolemid |383|
)))
(assert (forall ((v@@17 Int) ) (! (= (|$IsValid'address'| v@@17) (>= v@@17 0))
 :qid |boogiebpl.1109:28|
 :skolemid |27|
 :pattern ( (|$IsValid'address'| v@@17))
)))
(assert (forall ((t@@1 T@$TypeParamInfo) ) (!  (=> (is-$TypeParamSigner t@@1) (|$IsEqual'vec'u8''| ($TypeName t@@1) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 115) 1 105) 2 103) 3 110) 4 101) 5 114) 6)))
 :qid |boogiebpl.6537:15|
 :skolemid |261|
 :pattern ( ($TypeName t@@1))
)))
(assert (forall ((v@@18 T@Vec_85428) (suffix T@Vec_85428) ) (! (= (|$IsSuffix'vec'#0''| v@@18 suffix)  (and (>= (|l#Vec_85428| v@@18) (|l#Vec_85428| suffix)) (forall ((i@@45 Int) ) (!  (=> (InRangeVec_65852 suffix i@@45) (= (|Select__T@[Int]#0_| (|v#Vec_85428| v@@18) (+ (- (|l#Vec_85428| v@@18) (|l#Vec_85428| suffix)) i@@45)) (|Select__T@[Int]#0_| (|v#Vec_85428| suffix) i@@45)))
 :qid |boogiebpl.3092:13|
 :skolemid |117|
))))
 :qid |boogiebpl.3090:29|
 :skolemid |118|
 :pattern ( (|$IsSuffix'vec'#0''| v@@18 suffix))
)))
(assert (forall ((v@@19 T@Vec_90390) (suffix@@0 T@Vec_90390) ) (! (= (|$IsSuffix'vec'$1_aggregator_Aggregator''| v@@19 suffix@@0)  (and (>= (|l#Vec_90390| v@@19) (|l#Vec_90390| suffix@@0)) (forall ((i@@46 Int) ) (!  (=> (InRangeVec_66199 suffix@@0 i@@46) (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| v@@19) (+ (- (|l#Vec_90390| v@@19) (|l#Vec_90390| suffix@@0)) i@@46)) (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| suffix@@0) i@@46)))
 :qid |boogiebpl.3396:13|
 :skolemid |128|
))))
 :qid |boogiebpl.3394:51|
 :skolemid |129|
 :pattern ( (|$IsSuffix'vec'$1_aggregator_Aggregator''| v@@19 suffix@@0))
)))
(assert (forall ((v@@20 T@Vec_95276) (suffix@@1 T@Vec_95276) ) (! (= (|$IsSuffix'vec'$1_optional_aggregator_Integer''| v@@20 suffix@@1)  (and (>= (|l#Vec_95276| v@@20) (|l#Vec_95276| suffix@@1)) (forall ((i@@47 Int) ) (!  (=> (InRangeVec_66546 suffix@@1 i@@47) (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| v@@20) (+ (- (|l#Vec_95276| v@@20) (|l#Vec_95276| suffix@@1)) i@@47)) (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| suffix@@1) i@@47)))
 :qid |boogiebpl.3700:13|
 :skolemid |139|
))))
 :qid |boogiebpl.3698:57|
 :skolemid |140|
 :pattern ( (|$IsSuffix'vec'$1_optional_aggregator_Integer''| v@@20 suffix@@1))
)))
(assert (forall ((v@@21 T@Vec_100175) (suffix@@2 T@Vec_100175) ) (! (= (|$IsSuffix'vec'$1_optional_aggregator_OptionalAggregator''| v@@21 suffix@@2)  (and (>= (|l#Vec_100175| v@@21) (|l#Vec_100175| suffix@@2)) (forall ((i@@48 Int) ) (!  (=> (InRangeVec_66893 suffix@@2 i@@48) (and (|$IsEqual'vec'$1_aggregator_Aggregator''| (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@21) (+ (- (|l#Vec_100175| v@@21) (|l#Vec_100175| suffix@@2)) i@@48)))) (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| suffix@@2) i@@48)))) (|$IsEqual'vec'$1_optional_aggregator_Integer''| (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@21) (+ (- (|l#Vec_100175| v@@21) (|l#Vec_100175| suffix@@2)) i@@48)))) (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| suffix@@2) i@@48))))))
 :qid |boogiebpl.4004:13|
 :skolemid |150|
))))
 :qid |boogiebpl.4002:68|
 :skolemid |151|
 :pattern ( (|$IsSuffix'vec'$1_optional_aggregator_OptionalAggregator''| v@@21 suffix@@2))
)))
(assert (forall ((v@@22 T@Vec_6673) (suffix@@3 T@Vec_6673) ) (! (= (|$IsSuffix'vec'address''| v@@22 suffix@@3)  (and (>= (|l#Vec_6673| v@@22) (|l#Vec_6673| suffix@@3)) (forall ((i@@49 Int) ) (!  (=> (InRangeVec_25002 suffix@@3 i@@49) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@22) (+ (- (|l#Vec_6673| v@@22) (|l#Vec_6673| suffix@@3)) i@@49)) (|Select__T@[Int]Int_| (|v#Vec_6673| suffix@@3) i@@49)))
 :qid |boogiebpl.4308:13|
 :skolemid |161|
))))
 :qid |boogiebpl.4306:34|
 :skolemid |162|
 :pattern ( (|$IsSuffix'vec'address''| v@@22 suffix@@3))
)))
(assert (forall ((v@@23 T@Vec_6673) (suffix@@4 T@Vec_6673) ) (! (= (|$IsSuffix'vec'u64''| v@@23 suffix@@4)  (and (>= (|l#Vec_6673| v@@23) (|l#Vec_6673| suffix@@4)) (forall ((i@@50 Int) ) (!  (=> (InRangeVec_25002 suffix@@4 i@@50) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@23) (+ (- (|l#Vec_6673| v@@23) (|l#Vec_6673| suffix@@4)) i@@50)) (|Select__T@[Int]Int_| (|v#Vec_6673| suffix@@4) i@@50)))
 :qid |boogiebpl.4612:13|
 :skolemid |172|
))))
 :qid |boogiebpl.4610:30|
 :skolemid |173|
 :pattern ( (|$IsSuffix'vec'u64''| v@@23 suffix@@4))
)))
(assert (forall ((v@@24 T@Vec_6673) (suffix@@5 T@Vec_6673) ) (! (= (|$IsSuffix'vec'u8''| v@@24 suffix@@5)  (and (>= (|l#Vec_6673| v@@24) (|l#Vec_6673| suffix@@5)) (forall ((i@@51 Int) ) (!  (=> (InRangeVec_25002 suffix@@5 i@@51) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@24) (+ (- (|l#Vec_6673| v@@24) (|l#Vec_6673| suffix@@5)) i@@51)) (|Select__T@[Int]Int_| (|v#Vec_6673| suffix@@5) i@@51)))
 :qid |boogiebpl.4916:13|
 :skolemid |183|
))))
 :qid |boogiebpl.4914:29|
 :skolemid |184|
 :pattern ( (|$IsSuffix'vec'u8''| v@@24 suffix@@5))
)))
(assert (forall ((v@@25 T@Vec_67815) (suffix@@6 T@Vec_67815) ) (! (= (|$IsSuffix'vec'bv64''| v@@25 suffix@@6)  (and (>= (|l#Vec_67815| v@@25) (|l#Vec_67815| suffix@@6)) (forall ((i@@52 Int) ) (!  (=> (InRangeVec_67819 suffix@@6 i@@52) (= (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| v@@25) (+ (- (|l#Vec_67815| v@@25) (|l#Vec_67815| suffix@@6)) i@@52)) (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| suffix@@6) i@@52)))
 :qid |boogiebpl.5220:13|
 :skolemid |194|
))))
 :qid |boogiebpl.5218:31|
 :skolemid |195|
 :pattern ( (|$IsSuffix'vec'bv64''| v@@25 suffix@@6))
)))
(assert (forall ((v@@26 T@Vec_68162) (suffix@@7 T@Vec_68162) ) (! (= (|$IsSuffix'vec'bv8''| v@@26 suffix@@7)  (and (>= (|l#Vec_68162| v@@26) (|l#Vec_68162| suffix@@7)) (forall ((i@@53 Int) ) (!  (=> (InRangeVec_68166 suffix@@7 i@@53) (= (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| v@@26) (+ (- (|l#Vec_68162| v@@26) (|l#Vec_68162| suffix@@7)) i@@53)) (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| suffix@@7) i@@53)))
 :qid |boogiebpl.5524:13|
 :skolemid |205|
))))
 :qid |boogiebpl.5522:30|
 :skolemid |206|
 :pattern ( (|$IsSuffix'vec'bv8''| v@@26 suffix@@7))
)))
(assert (forall ((|l#0@@20| Int) (|l#1@@20| Int) (|l#2@@20| |T@[Int]#0|) (|l#3@@20| Int) (|l#4@@20| |T@#0|) (k@@2 Int) ) (! (= (|Select__T@[Int]#0_| (|lambda#2| |l#0@@20| |l#1@@20| |l#2@@20| |l#3@@20| |l#4@@20|) k@@2) (ite  (and (<= |l#0@@20| k@@2) (< k@@2 |l#1@@20|)) (|Select__T@[Int]#0_| |l#2@@20| (+ |l#3@@20| k@@2)) |l#4@@20|))
 :qid |boogiebpl.91:14|
 :skolemid |564|
 :pattern ( (|Select__T@[Int]#0_| (|lambda#2| |l#0@@20| |l#1@@20| |l#2@@20| |l#3@@20| |l#4@@20|) k@@2))
)))
(assert (forall ((|l#0@@21| Int) (|l#1@@21| Int) (|l#2@@21| |T@[Int]$1_aggregator_Aggregator|) (|l#3@@21| Int) (|l#4@@21| T@$1_aggregator_Aggregator) (k@@3 Int) ) (! (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|lambda#6| |l#0@@21| |l#1@@21| |l#2@@21| |l#3@@21| |l#4@@21|) k@@3) (ite  (and (<= |l#0@@21| k@@3) (< k@@3 |l#1@@21|)) (|Select__T@[Int]$1_aggregator_Aggregator_| |l#2@@21| (+ |l#3@@21| k@@3)) |l#4@@21|))
 :qid |boogiebpl.91:14|
 :skolemid |568|
 :pattern ( (|Select__T@[Int]$1_aggregator_Aggregator_| (|lambda#6| |l#0@@21| |l#1@@21| |l#2@@21| |l#3@@21| |l#4@@21|) k@@3))
)))
(assert (forall ((|l#0@@22| Int) (|l#1@@22| Int) (|l#2@@22| |T@[Int]$1_optional_aggregator_Integer|) (|l#3@@22| Int) (|l#4@@22| T@$1_optional_aggregator_Integer) (k@@4 Int) ) (! (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|lambda#10| |l#0@@22| |l#1@@22| |l#2@@22| |l#3@@22| |l#4@@22|) k@@4) (ite  (and (<= |l#0@@22| k@@4) (< k@@4 |l#1@@22|)) (|Select__T@[Int]$1_optional_aggregator_Integer_| |l#2@@22| (+ |l#3@@22| k@@4)) |l#4@@22|))
 :qid |boogiebpl.91:14|
 :skolemid |572|
 :pattern ( (|Select__T@[Int]$1_optional_aggregator_Integer_| (|lambda#10| |l#0@@22| |l#1@@22| |l#2@@22| |l#3@@22| |l#4@@22|) k@@4))
)))
(assert (forall ((|l#0@@23| Int) (|l#1@@23| Int) (|l#2@@23| |T@[Int]$1_optional_aggregator_OptionalAggregator|) (|l#3@@23| Int) (|l#4@@23| T@$1_optional_aggregator_OptionalAggregator) (k@@5 Int) ) (! (= (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|lambda#14| |l#0@@23| |l#1@@23| |l#2@@23| |l#3@@23| |l#4@@23|) k@@5) (ite  (and (<= |l#0@@23| k@@5) (< k@@5 |l#1@@23|)) (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| |l#2@@23| (+ |l#3@@23| k@@5)) |l#4@@23|))
 :qid |boogiebpl.91:14|
 :skolemid |576|
 :pattern ( (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|lambda#14| |l#0@@23| |l#1@@23| |l#2@@23| |l#3@@23| |l#4@@23|) k@@5))
)))
(assert (forall ((|l#0@@24| Int) (|l#1@@24| Int) (|l#2@@24| |T@[Int]Int|) (|l#3@@24| Int) (|l#4@@24| Int) (k@@6 Int) ) (! (= (|Select__T@[Int]Int_| (|lambda#18| |l#0@@24| |l#1@@24| |l#2@@24| |l#3@@24| |l#4@@24|) k@@6) (ite  (and (<= |l#0@@24| k@@6) (< k@@6 |l#1@@24|)) (|Select__T@[Int]Int_| |l#2@@24| (+ |l#3@@24| k@@6)) |l#4@@24|))
 :qid |boogiebpl.91:14|
 :skolemid |580|
 :pattern ( (|Select__T@[Int]Int_| (|lambda#18| |l#0@@24| |l#1@@24| |l#2@@24| |l#3@@24| |l#4@@24|) k@@6))
)))
(assert (forall ((|l#0@@25| Int) (|l#1@@25| Int) (|l#2@@25| |T@[Int](_ BitVec 64)|) (|l#3@@25| Int) (|l#4@@25| (_ BitVec 64)) (k@@7 Int) ) (! (= (|Select__T@[Int](_ BitVec 64)_| (|lambda#22| |l#0@@25| |l#1@@25| |l#2@@25| |l#3@@25| |l#4@@25|) k@@7) (ite  (and (<= |l#0@@25| k@@7) (< k@@7 |l#1@@25|)) (|Select__T@[Int](_ BitVec 64)_| |l#2@@25| (+ |l#3@@25| k@@7)) |l#4@@25|))
 :qid |boogiebpl.91:14|
 :skolemid |584|
 :pattern ( (|Select__T@[Int](_ BitVec 64)_| (|lambda#22| |l#0@@25| |l#1@@25| |l#2@@25| |l#3@@25| |l#4@@25|) k@@7))
)))
(assert (forall ((|l#0@@26| Int) (|l#1@@26| Int) (|l#2@@26| |T@[Int](_ BitVec 8)|) (|l#3@@26| Int) (|l#4@@26| (_ BitVec 8)) (k@@8 Int) ) (! (= (|Select__T@[Int](_ BitVec 8)_| (|lambda#26| |l#0@@26| |l#1@@26| |l#2@@26| |l#3@@26| |l#4@@26|) k@@8) (ite  (and (<= |l#0@@26| k@@8) (< k@@8 |l#1@@26|)) (|Select__T@[Int](_ BitVec 8)_| |l#2@@26| (+ |l#3@@26| k@@8)) |l#4@@26|))
 :qid |boogiebpl.91:14|
 :skolemid |588|
 :pattern ( (|Select__T@[Int](_ BitVec 8)_| (|lambda#26| |l#0@@26| |l#1@@26| |l#2@@26| |l#3@@26| |l#4@@26|) k@@8))
)))
(assert (forall ((source Int) (seed T@Vec_6673) ) (! (let (($$res ($1_account_spec_create_resource_address source seed)))
(|$IsValid'address'| $$res))
 :qid |boogiebpl.8452:15|
 :skolemid |510|
)))
(assert (forall ((b1@@4 T@Vec_6673) (b2@@4 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@4) (=> (|$IsValid'vec'u8''| b2@@4) (=> (|$IsEqual'vec'u8''| b1@@4 b2@@4) (= (|$1_from_bcs_deserializable'bool'| b1@@4) (|$1_from_bcs_deserializable'bool'| b2@@4)))))
 :qid |boogiebpl.6554:15|
 :skolemid |267|
)))
(assert (forall ((b1@@5 T@Vec_6673) (b2@@5 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@5) (=> (|$IsValid'vec'u8''| b2@@5) (=> (|$IsEqual'vec'u8''| b1@@5 b2@@5) (= (|$1_from_bcs_deserializable'u8'| b1@@5) (|$1_from_bcs_deserializable'u8'| b2@@5)))))
 :qid |boogiebpl.6557:15|
 :skolemid |268|
)))
(assert (forall ((b1@@6 T@Vec_6673) (b2@@6 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@6) (=> (|$IsValid'vec'u8''| b2@@6) (=> (|$IsEqual'vec'u8''| b1@@6 b2@@6) (= (|$1_from_bcs_deserializable'u64'| b1@@6) (|$1_from_bcs_deserializable'u64'| b2@@6)))))
 :qid |boogiebpl.6560:15|
 :skolemid |269|
)))
(assert (forall ((b1@@7 T@Vec_6673) (b2@@7 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@7) (=> (|$IsValid'vec'u8''| b2@@7) (=> (|$IsEqual'vec'u8''| b1@@7 b2@@7) (= (|$1_from_bcs_deserializable'u128'| b1@@7) (|$1_from_bcs_deserializable'u128'| b2@@7)))))
 :qid |boogiebpl.6563:15|
 :skolemid |270|
)))
(assert (forall ((b1@@8 T@Vec_6673) (b2@@8 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@8) (=> (|$IsValid'vec'u8''| b2@@8) (=> (|$IsEqual'vec'u8''| b1@@8 b2@@8) (= (|$1_from_bcs_deserializable'u256'| b1@@8) (|$1_from_bcs_deserializable'u256'| b2@@8)))))
 :qid |boogiebpl.6566:15|
 :skolemid |271|
)))
(assert (forall ((b1@@9 T@Vec_6673) (b2@@9 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@9) (=> (|$IsValid'vec'u8''| b2@@9) (=> (|$IsEqual'vec'u8''| b1@@9 b2@@9) (= (|$1_from_bcs_deserializable'address'| b1@@9) (|$1_from_bcs_deserializable'address'| b2@@9)))))
 :qid |boogiebpl.6569:15|
 :skolemid |272|
)))
(assert (forall ((b1@@10 T@Vec_6673) (b2@@10 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@10) (=> (|$IsValid'vec'u8''| b2@@10) (=> (|$IsEqual'vec'u8''| b1@@10 b2@@10) (= (|$1_from_bcs_deserializable'signer'| b1@@10) (|$1_from_bcs_deserializable'signer'| b2@@10)))))
 :qid |boogiebpl.6572:15|
 :skolemid |273|
)))
(assert (forall ((b1@@11 T@Vec_6673) (b2@@11 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@11) (=> (|$IsValid'vec'u8''| b2@@11) (=> (|$IsEqual'vec'u8''| b1@@11 b2@@11) (= (|$1_from_bcs_deserializable'vec'u8''| b1@@11) (|$1_from_bcs_deserializable'vec'u8''| b2@@11)))))
 :qid |boogiebpl.6575:15|
 :skolemid |274|
)))
(assert (forall ((b1@@12 T@Vec_6673) (b2@@12 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@12) (=> (|$IsValid'vec'u8''| b2@@12) (=> (|$IsEqual'vec'u8''| b1@@12 b2@@12) (= (|$1_from_bcs_deserializable'vec'u64''| b1@@12) (|$1_from_bcs_deserializable'vec'u64''| b2@@12)))))
 :qid |boogiebpl.6578:15|
 :skolemid |275|
)))
(assert (forall ((b1@@13 T@Vec_6673) (b2@@13 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@13) (=> (|$IsValid'vec'u8''| b2@@13) (=> (|$IsEqual'vec'u8''| b1@@13 b2@@13) (= (|$1_from_bcs_deserializable'vec'address''| b1@@13) (|$1_from_bcs_deserializable'vec'address''| b2@@13)))))
 :qid |boogiebpl.6581:15|
 :skolemid |276|
)))
(assert (forall ((b1@@14 T@Vec_6673) (b2@@14 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@14) (=> (|$IsValid'vec'u8''| b2@@14) (=> (|$IsEqual'vec'u8''| b1@@14 b2@@14) (= (|$1_from_bcs_deserializable'vec'$1_aggregator_Aggregator''| b1@@14) (|$1_from_bcs_deserializable'vec'$1_aggregator_Aggregator''| b2@@14)))))
 :qid |boogiebpl.6584:15|
 :skolemid |277|
)))
(assert (forall ((b1@@15 T@Vec_6673) (b2@@15 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@15) (=> (|$IsValid'vec'u8''| b2@@15) (=> (|$IsEqual'vec'u8''| b1@@15 b2@@15) (= (|$1_from_bcs_deserializable'vec'$1_optional_aggregator_Integer''| b1@@15) (|$1_from_bcs_deserializable'vec'$1_optional_aggregator_Integer''| b2@@15)))))
 :qid |boogiebpl.6587:15|
 :skolemid |278|
)))
(assert (forall ((b1@@16 T@Vec_6673) (b2@@16 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@16) (=> (|$IsValid'vec'u8''| b2@@16) (=> (|$IsEqual'vec'u8''| b1@@16 b2@@16) (= (|$1_from_bcs_deserializable'vec'$1_optional_aggregator_OptionalAggregator''| b1@@16) (|$1_from_bcs_deserializable'vec'$1_optional_aggregator_OptionalAggregator''| b2@@16)))))
 :qid |boogiebpl.6590:15|
 :skolemid |279|
)))
(assert (forall ((b1@@17 T@Vec_6673) (b2@@17 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@17) (=> (|$IsValid'vec'u8''| b2@@17) (=> (|$IsEqual'vec'u8''| b1@@17 b2@@17) (= (|$1_from_bcs_deserializable'vec'#0''| b1@@17) (|$1_from_bcs_deserializable'vec'#0''| b2@@17)))))
 :qid |boogiebpl.6593:15|
 :skolemid |280|
)))
(assert (forall ((b1@@18 T@Vec_6673) (b2@@18 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@18) (=> (|$IsValid'vec'u8''| b2@@18) (=> (|$IsEqual'vec'u8''| b1@@18 b2@@18) (= (|$1_from_bcs_deserializable'$1_table_Table'u64_bool''| b1@@18) (|$1_from_bcs_deserializable'$1_table_Table'u64_bool''| b2@@18)))))
 :qid |boogiebpl.6596:15|
 :skolemid |281|
)))
(assert (forall ((b1@@19 T@Vec_6673) (b2@@19 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@19) (=> (|$IsValid'vec'u8''| b2@@19) (=> (|$IsEqual'vec'u8''| b1@@19 b2@@19) (= (|$1_from_bcs_deserializable'$1_table_Table'u64_u64''| b1@@19) (|$1_from_bcs_deserializable'$1_table_Table'u64_u64''| b2@@19)))))
 :qid |boogiebpl.6599:15|
 :skolemid |282|
)))
(assert (forall ((b1@@20 T@Vec_6673) (b2@@20 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@20) (=> (|$IsValid'vec'u8''| b2@@20) (=> (|$IsEqual'vec'u8''| b1@@20 b2@@20) (= (|$1_from_bcs_deserializable'$1_table_Table'u64_vec'u64'''| b1@@20) (|$1_from_bcs_deserializable'$1_table_Table'u64_vec'u64'''| b2@@20)))))
 :qid |boogiebpl.6602:15|
 :skolemid |283|
)))
(assert (forall ((b1@@21 T@Vec_6673) (b2@@21 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@21) (=> (|$IsValid'vec'u8''| b2@@21) (=> (|$IsEqual'vec'u8''| b1@@21 b2@@21) (= (|$1_from_bcs_deserializable'$1_table_Table'address_address''| b1@@21) (|$1_from_bcs_deserializable'$1_table_Table'address_address''| b2@@21)))))
 :qid |boogiebpl.6605:15|
 :skolemid |284|
)))
(assert (forall ((b1@@22 T@Vec_6673) (b2@@22 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@22) (=> (|$IsValid'vec'u8''| b2@@22) (=> (|$IsEqual'vec'u8''| b1@@22 b2@@22) (= (|$1_from_bcs_deserializable'$1_option_Option'address''| b1@@22) (|$1_from_bcs_deserializable'$1_option_Option'address''| b2@@22)))))
 :qid |boogiebpl.6608:15|
 :skolemid |285|
)))
(assert (forall ((b1@@23 T@Vec_6673) (b2@@23 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@23) (=> (|$IsValid'vec'u8''| b2@@23) (=> (|$IsEqual'vec'u8''| b1@@23 b2@@23) (= (|$1_from_bcs_deserializable'$1_option_Option'$1_aggregator_Aggregator''| b1@@23) (|$1_from_bcs_deserializable'$1_option_Option'$1_aggregator_Aggregator''| b2@@23)))))
 :qid |boogiebpl.6611:15|
 :skolemid |286|
)))
(assert (forall ((b1@@24 T@Vec_6673) (b2@@24 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@24) (=> (|$IsValid'vec'u8''| b2@@24) (=> (|$IsEqual'vec'u8''| b1@@24 b2@@24) (= (|$1_from_bcs_deserializable'$1_option_Option'$1_optional_aggregator_Integer''| b1@@24) (|$1_from_bcs_deserializable'$1_option_Option'$1_optional_aggregator_Integer''| b2@@24)))))
 :qid |boogiebpl.6614:15|
 :skolemid |287|
)))
(assert (forall ((b1@@25 T@Vec_6673) (b2@@25 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@25) (=> (|$IsValid'vec'u8''| b2@@25) (=> (|$IsEqual'vec'u8''| b1@@25 b2@@25) (= (|$1_from_bcs_deserializable'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| b1@@25) (|$1_from_bcs_deserializable'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| b2@@25)))))
 :qid |boogiebpl.6617:15|
 :skolemid |288|
)))
(assert (forall ((b1@@26 T@Vec_6673) (b2@@26 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@26) (=> (|$IsValid'vec'u8''| b2@@26) (=> (|$IsEqual'vec'u8''| b1@@26 b2@@26) (= (|$1_from_bcs_deserializable'$1_string_String'| b1@@26) (|$1_from_bcs_deserializable'$1_string_String'| b2@@26)))))
 :qid |boogiebpl.6620:15|
 :skolemid |289|
)))
(assert (forall ((b1@@27 T@Vec_6673) (b2@@27 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@27) (=> (|$IsValid'vec'u8''| b2@@27) (=> (|$IsEqual'vec'u8''| b1@@27 b2@@27) (= (|$1_from_bcs_deserializable'$1_type_info_TypeInfo'| b1@@27) (|$1_from_bcs_deserializable'$1_type_info_TypeInfo'| b2@@27)))))
 :qid |boogiebpl.6623:15|
 :skolemid |290|
)))
(assert (forall ((b1@@28 T@Vec_6673) (b2@@28 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@28) (=> (|$IsValid'vec'u8''| b2@@28) (=> (|$IsEqual'vec'u8''| b1@@28 b2@@28) (= (|$1_from_bcs_deserializable'$1_aggregator_Aggregator'| b1@@28) (|$1_from_bcs_deserializable'$1_aggregator_Aggregator'| b2@@28)))))
 :qid |boogiebpl.6626:15|
 :skolemid |291|
)))
(assert (forall ((b1@@29 T@Vec_6673) (b2@@29 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@29) (=> (|$IsValid'vec'u8''| b2@@29) (=> (|$IsEqual'vec'u8''| b1@@29 b2@@29) (= (|$1_from_bcs_deserializable'$1_optional_aggregator_Integer'| b1@@29) (|$1_from_bcs_deserializable'$1_optional_aggregator_Integer'| b2@@29)))))
 :qid |boogiebpl.6629:15|
 :skolemid |292|
)))
(assert (forall ((b1@@30 T@Vec_6673) (b2@@30 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@30) (=> (|$IsValid'vec'u8''| b2@@30) (=> (|$IsEqual'vec'u8''| b1@@30 b2@@30) (= (|$1_from_bcs_deserializable'$1_optional_aggregator_OptionalAggregator'| b1@@30) (|$1_from_bcs_deserializable'$1_optional_aggregator_OptionalAggregator'| b2@@30)))))
 :qid |boogiebpl.6632:15|
 :skolemid |293|
)))
(assert (forall ((b1@@31 T@Vec_6673) (b2@@31 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@31) (=> (|$IsValid'vec'u8''| b2@@31) (=> (|$IsEqual'vec'u8''| b1@@31 b2@@31) (= (|$1_from_bcs_deserializable'$1_guid_GUID'| b1@@31) (|$1_from_bcs_deserializable'$1_guid_GUID'| b2@@31)))))
 :qid |boogiebpl.6635:15|
 :skolemid |294|
)))
(assert (forall ((b1@@32 T@Vec_6673) (b2@@32 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@32) (=> (|$IsValid'vec'u8''| b2@@32) (=> (|$IsEqual'vec'u8''| b1@@32 b2@@32) (= (|$1_from_bcs_deserializable'$1_guid_ID'| b1@@32) (|$1_from_bcs_deserializable'$1_guid_ID'| b2@@32)))))
 :qid |boogiebpl.6638:15|
 :skolemid |295|
)))
(assert (forall ((b1@@33 T@Vec_6673) (b2@@33 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@33) (=> (|$IsValid'vec'u8''| b2@@33) (=> (|$IsEqual'vec'u8''| b1@@33 b2@@33) (= (|$1_from_bcs_deserializable'$1_event_EventHandle'$1_account_CoinRegisterEvent''| b1@@33) (|$1_from_bcs_deserializable'$1_event_EventHandle'$1_account_CoinRegisterEvent''| b2@@33)))))
 :qid |boogiebpl.6641:15|
 :skolemid |296|
)))
(assert (forall ((b1@@34 T@Vec_6673) (b2@@34 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@34) (=> (|$IsValid'vec'u8''| b2@@34) (=> (|$IsEqual'vec'u8''| b1@@34 b2@@34) (= (|$1_from_bcs_deserializable'$1_event_EventHandle'$1_account_KeyRotationEvent''| b1@@34) (|$1_from_bcs_deserializable'$1_event_EventHandle'$1_account_KeyRotationEvent''| b2@@34)))))
 :qid |boogiebpl.6644:15|
 :skolemid |297|
)))
(assert (forall ((b1@@35 T@Vec_6673) (b2@@35 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@35) (=> (|$IsValid'vec'u8''| b2@@35) (=> (|$IsEqual'vec'u8''| b1@@35 b2@@35) (= (|$1_from_bcs_deserializable'$1_event_EventHandle'$1_coin_DepositEvent''| b1@@35) (|$1_from_bcs_deserializable'$1_event_EventHandle'$1_coin_DepositEvent''| b2@@35)))))
 :qid |boogiebpl.6647:15|
 :skolemid |298|
)))
(assert (forall ((b1@@36 T@Vec_6673) (b2@@36 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@36) (=> (|$IsValid'vec'u8''| b2@@36) (=> (|$IsEqual'vec'u8''| b1@@36 b2@@36) (= (|$1_from_bcs_deserializable'$1_event_EventHandle'$1_coin_WithdrawEvent''| b1@@36) (|$1_from_bcs_deserializable'$1_event_EventHandle'$1_coin_WithdrawEvent''| b2@@36)))))
 :qid |boogiebpl.6650:15|
 :skolemid |299|
)))
(assert (forall ((b1@@37 T@Vec_6673) (b2@@37 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@37) (=> (|$IsValid'vec'u8''| b2@@37) (=> (|$IsEqual'vec'u8''| b1@@37 b2@@37) (= (|$1_from_bcs_deserializable'$1_account_Account'| b1@@37) (|$1_from_bcs_deserializable'$1_account_Account'| b2@@37)))))
 :qid |boogiebpl.6653:15|
 :skolemid |300|
)))
(assert (forall ((b1@@38 T@Vec_6673) (b2@@38 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@38) (=> (|$IsValid'vec'u8''| b2@@38) (=> (|$IsEqual'vec'u8''| b1@@38 b2@@38) (= (|$1_from_bcs_deserializable'$1_account_CapabilityOffer'$1_account_RotationCapability''| b1@@38) (|$1_from_bcs_deserializable'$1_account_CapabilityOffer'$1_account_RotationCapability''| b2@@38)))))
 :qid |boogiebpl.6656:15|
 :skolemid |301|
)))
(assert (forall ((b1@@39 T@Vec_6673) (b2@@39 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@39) (=> (|$IsValid'vec'u8''| b2@@39) (=> (|$IsEqual'vec'u8''| b1@@39 b2@@39) (= (|$1_from_bcs_deserializable'$1_account_CapabilityOffer'$1_account_SignerCapability''| b1@@39) (|$1_from_bcs_deserializable'$1_account_CapabilityOffer'$1_account_SignerCapability''| b2@@39)))))
 :qid |boogiebpl.6659:15|
 :skolemid |302|
)))
(assert (forall ((b1@@40 T@Vec_6673) (b2@@40 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@40) (=> (|$IsValid'vec'u8''| b2@@40) (=> (|$IsEqual'vec'u8''| b1@@40 b2@@40) (= (|$1_from_bcs_deserializable'$1_account_CoinRegisterEvent'| b1@@40) (|$1_from_bcs_deserializable'$1_account_CoinRegisterEvent'| b2@@40)))))
 :qid |boogiebpl.6662:15|
 :skolemid |303|
)))
(assert (forall ((b1@@41 T@Vec_6673) (b2@@41 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@41) (=> (|$IsValid'vec'u8''| b2@@41) (=> (|$IsEqual'vec'u8''| b1@@41 b2@@41) (= (|$1_from_bcs_deserializable'$1_account_SignerCapability'| b1@@41) (|$1_from_bcs_deserializable'$1_account_SignerCapability'| b2@@41)))))
 :qid |boogiebpl.6665:15|
 :skolemid |304|
)))
(assert (forall ((b1@@42 T@Vec_6673) (b2@@42 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@42) (=> (|$IsValid'vec'u8''| b2@@42) (=> (|$IsEqual'vec'u8''| b1@@42 b2@@42) (= (|$1_from_bcs_deserializable'$1_coin_Coin'$1_aptos_coin_AptosCoin''| b1@@42) (|$1_from_bcs_deserializable'$1_coin_Coin'$1_aptos_coin_AptosCoin''| b2@@42)))))
 :qid |boogiebpl.6668:15|
 :skolemid |305|
)))
(assert (forall ((b1@@43 T@Vec_6673) (b2@@43 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@43) (=> (|$IsValid'vec'u8''| b2@@43) (=> (|$IsEqual'vec'u8''| b1@@43 b2@@43) (= (|$1_from_bcs_deserializable'$1_coin_Coin'#0''| b1@@43) (|$1_from_bcs_deserializable'$1_coin_Coin'#0''| b2@@43)))))
 :qid |boogiebpl.6671:15|
 :skolemid |306|
)))
(assert (forall ((b1@@44 T@Vec_6673) (b2@@44 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@44) (=> (|$IsValid'vec'u8''| b2@@44) (=> (|$IsEqual'vec'u8''| b1@@44 b2@@44) (= (|$1_from_bcs_deserializable'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| b1@@44) (|$1_from_bcs_deserializable'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| b2@@44)))))
 :qid |boogiebpl.6674:15|
 :skolemid |307|
)))
(assert (forall ((b1@@45 T@Vec_6673) (b2@@45 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@45) (=> (|$IsValid'vec'u8''| b2@@45) (=> (|$IsEqual'vec'u8''| b1@@45 b2@@45) (= (|$1_from_bcs_deserializable'$1_coin_CoinInfo'#0''| b1@@45) (|$1_from_bcs_deserializable'$1_coin_CoinInfo'#0''| b2@@45)))))
 :qid |boogiebpl.6677:15|
 :skolemid |308|
)))
(assert (forall ((b1@@46 T@Vec_6673) (b2@@46 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@46) (=> (|$IsValid'vec'u8''| b2@@46) (=> (|$IsEqual'vec'u8''| b1@@46 b2@@46) (= (|$1_from_bcs_deserializable'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''| b1@@46) (|$1_from_bcs_deserializable'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''| b2@@46)))))
 :qid |boogiebpl.6680:15|
 :skolemid |309|
)))
(assert (forall ((b1@@47 T@Vec_6673) (b2@@47 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@47) (=> (|$IsValid'vec'u8''| b2@@47) (=> (|$IsEqual'vec'u8''| b1@@47 b2@@47) (= (|$1_from_bcs_deserializable'$1_coin_CoinStore'#0''| b1@@47) (|$1_from_bcs_deserializable'$1_coin_CoinStore'#0''| b2@@47)))))
 :qid |boogiebpl.6683:15|
 :skolemid |310|
)))
(assert (forall ((b1@@48 T@Vec_6673) (b2@@48 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@48) (=> (|$IsValid'vec'u8''| b2@@48) (=> (|$IsEqual'vec'u8''| b1@@48 b2@@48) (= (|$1_from_bcs_deserializable'$1_coin_DepositEvent'| b1@@48) (|$1_from_bcs_deserializable'$1_coin_DepositEvent'| b2@@48)))))
 :qid |boogiebpl.6686:15|
 :skolemid |311|
)))
(assert (forall ((b1@@49 T@Vec_6673) (b2@@49 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@49) (=> (|$IsValid'vec'u8''| b2@@49) (=> (|$IsEqual'vec'u8''| b1@@49 b2@@49) (= (|$1_from_bcs_deserializable'$1_coin_WithdrawEvent'| b1@@49) (|$1_from_bcs_deserializable'$1_coin_WithdrawEvent'| b2@@49)))))
 :qid |boogiebpl.6689:15|
 :skolemid |312|
)))
(assert (forall ((b1@@50 T@Vec_6673) (b2@@50 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@50) (=> (|$IsValid'vec'u8''| b2@@50) (=> (|$IsEqual'vec'u8''| b1@@50 b2@@50) (= (|$1_from_bcs_deserializable'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''| b1@@50) (|$1_from_bcs_deserializable'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''| b2@@50)))))
 :qid |boogiebpl.6692:15|
 :skolemid |313|
)))
(assert (forall ((b1@@51 T@Vec_6673) (b2@@51 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@51) (=> (|$IsValid'vec'u8''| b2@@51) (=> (|$IsEqual'vec'u8''| b1@@51 b2@@51) (= (|$1_from_bcs_deserializable'$1_coin_Ghost$supply'#0''| b1@@51) (|$1_from_bcs_deserializable'$1_coin_Ghost$supply'#0''| b2@@51)))))
 :qid |boogiebpl.6695:15|
 :skolemid |314|
)))
(assert (forall ((b1@@52 T@Vec_6673) (b2@@52 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@52) (=> (|$IsValid'vec'u8''| b2@@52) (=> (|$IsEqual'vec'u8''| b1@@52 b2@@52) (= (|$1_from_bcs_deserializable'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''| b1@@52) (|$1_from_bcs_deserializable'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''| b2@@52)))))
 :qid |boogiebpl.6698:15|
 :skolemid |315|
)))
(assert (forall ((b1@@53 T@Vec_6673) (b2@@53 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@53) (=> (|$IsValid'vec'u8''| b2@@53) (=> (|$IsEqual'vec'u8''| b1@@53 b2@@53) (= (|$1_from_bcs_deserializable'$1_coin_Ghost$aggregate_supply'#0''| b1@@53) (|$1_from_bcs_deserializable'$1_coin_Ghost$aggregate_supply'#0''| b2@@53)))))
 :qid |boogiebpl.6701:15|
 :skolemid |316|
)))
(assert (forall ((b1@@54 T@Vec_6673) (b2@@54 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@54) (=> (|$IsValid'vec'u8''| b2@@54) (=> (|$IsEqual'vec'u8''| b1@@54 b2@@54) (= (|$1_from_bcs_deserializable'$1_aptos_coin_AptosCoin'| b1@@54) (|$1_from_bcs_deserializable'$1_aptos_coin_AptosCoin'| b2@@54)))))
 :qid |boogiebpl.6704:15|
 :skolemid |317|
)))
(assert (forall ((b1@@55 T@Vec_6673) (b2@@55 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@55) (=> (|$IsValid'vec'u8''| b2@@55) (=> (|$IsEqual'vec'u8''| b1@@55 b2@@55) (= (|$1_from_bcs_deserializable'$1_Bbay_Owner'| b1@@55) (|$1_from_bcs_deserializable'$1_Bbay_Owner'| b2@@55)))))
 :qid |boogiebpl.6707:15|
 :skolemid |318|
)))
(assert (forall ((b1@@56 T@Vec_6673) (b2@@56 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@56) (=> (|$IsValid'vec'u8''| b2@@56) (=> (|$IsEqual'vec'u8''| b1@@56 b2@@56) (= (|$1_from_bcs_deserializable'$1_Bbay_Products'| b1@@56) (|$1_from_bcs_deserializable'$1_Bbay_Products'| b2@@56)))))
 :qid |boogiebpl.6710:15|
 :skolemid |319|
)))
(assert (forall ((b1@@57 T@Vec_6673) (b2@@57 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@57) (=> (|$IsValid'vec'u8''| b2@@57) (=> (|$IsEqual'vec'u8''| b1@@57 b2@@57) (= (|$1_from_bcs_deserializable'$1_Bbay_ResourceAccountSignerCap'| b1@@57) (|$1_from_bcs_deserializable'$1_Bbay_ResourceAccountSignerCap'| b2@@57)))))
 :qid |boogiebpl.6713:15|
 :skolemid |320|
)))
(assert (forall ((b1@@58 T@Vec_6673) (b2@@58 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@58) (=> (|$IsValid'vec'u8''| b2@@58) (=> (|$IsEqual'vec'u8''| b1@@58 b2@@58) (= (|$1_from_bcs_deserializable'$1_Bbay_User'| b1@@58) (|$1_from_bcs_deserializable'$1_Bbay_User'| b2@@58)))))
 :qid |boogiebpl.6716:15|
 :skolemid |321|
)))
(assert (forall ((b1@@59 T@Vec_6673) (b2@@59 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@59) (=> (|$IsValid'vec'u8''| b2@@59) (=> (|$IsEqual'vec'u8''| b1@@59 b2@@59) (= (|$1_from_bcs_deserializable'#0'| b1@@59) (|$1_from_bcs_deserializable'#0'| b2@@59)))))
 :qid |boogiebpl.6719:15|
 :skolemid |322|
)))
(assert (forall ((b1@@60 T@Vec_6673) (b2@@60 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@60) (=> (|$IsValid'vec'u8''| b2@@60) (=> (|$IsEqual'vec'u8''| b1@@60 b2@@60) (= (|$1_from_bcs_deserialize'bool'| b1@@60) (|$1_from_bcs_deserialize'bool'| b2@@60)))))
 :qid |boogiebpl.6722:15|
 :skolemid |323|
)))
(assert (forall ((b1@@61 T@Vec_6673) (b2@@61 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@61) (=> (|$IsValid'vec'u8''| b2@@61) (=> (|$IsEqual'vec'u8''| b1@@61 b2@@61) (= (|$1_from_bcs_deserialize'u8'| b1@@61) (|$1_from_bcs_deserialize'u8'| b2@@61)))))
 :qid |boogiebpl.6725:15|
 :skolemid |324|
)))
(assert (forall ((b1@@62 T@Vec_6673) (b2@@62 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@62) (=> (|$IsValid'vec'u8''| b2@@62) (=> (|$IsEqual'vec'u8''| b1@@62 b2@@62) (= (|$1_from_bcs_deserialize'u64'| b1@@62) (|$1_from_bcs_deserialize'u64'| b2@@62)))))
 :qid |boogiebpl.6728:15|
 :skolemid |325|
)))
(assert (forall ((b1@@63 T@Vec_6673) (b2@@63 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@63) (=> (|$IsValid'vec'u8''| b2@@63) (=> (|$IsEqual'vec'u8''| b1@@63 b2@@63) (= (|$1_from_bcs_deserialize'u128'| b1@@63) (|$1_from_bcs_deserialize'u128'| b2@@63)))))
 :qid |boogiebpl.6731:15|
 :skolemid |326|
)))
(assert (forall ((b1@@64 T@Vec_6673) (b2@@64 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@64) (=> (|$IsValid'vec'u8''| b2@@64) (=> (|$IsEqual'vec'u8''| b1@@64 b2@@64) (= (|$1_from_bcs_deserialize'u256'| b1@@64) (|$1_from_bcs_deserialize'u256'| b2@@64)))))
 :qid |boogiebpl.6734:15|
 :skolemid |327|
)))
(assert (forall ((b1@@65 T@Vec_6673) (b2@@65 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@65) (=> (|$IsValid'vec'u8''| b2@@65) (=> (|$IsEqual'vec'u8''| b1@@65 b2@@65) (= (|$1_from_bcs_deserialize'address'| b1@@65) (|$1_from_bcs_deserialize'address'| b2@@65)))))
 :qid |boogiebpl.6737:15|
 :skolemid |328|
)))
(assert (forall ((b1@@66 T@Vec_6673) (b2@@66 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@66) (=> (|$IsValid'vec'u8''| b2@@66) (=> (|$IsEqual'vec'u8''| b1@@66 b2@@66) (= (|$1_from_bcs_deserialize'signer'| b1@@66) (|$1_from_bcs_deserialize'signer'| b2@@66)))))
 :qid |boogiebpl.6740:15|
 :skolemid |329|
)))
(assert (forall ((b1@@67 T@Vec_6673) (b2@@67 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@67) (=> (|$IsValid'vec'u8''| b2@@67) (=> (|$IsEqual'vec'u8''| b1@@67 b2@@67) (|$IsEqual'vec'u8''| (|$1_from_bcs_deserialize'vec'u8''| b1@@67) (|$1_from_bcs_deserialize'vec'u8''| b2@@67)))))
 :qid |boogiebpl.6743:15|
 :skolemid |330|
)))
(assert (forall ((b1@@68 T@Vec_6673) (b2@@68 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@68) (=> (|$IsValid'vec'u8''| b2@@68) (=> (|$IsEqual'vec'u8''| b1@@68 b2@@68) (|$IsEqual'vec'u64''| (|$1_from_bcs_deserialize'vec'u64''| b1@@68) (|$1_from_bcs_deserialize'vec'u64''| b2@@68)))))
 :qid |boogiebpl.6746:15|
 :skolemid |331|
)))
(assert (forall ((b1@@69 T@Vec_6673) (b2@@69 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@69) (=> (|$IsValid'vec'u8''| b2@@69) (=> (|$IsEqual'vec'u8''| b1@@69 b2@@69) (|$IsEqual'vec'address''| (|$1_from_bcs_deserialize'vec'address''| b1@@69) (|$1_from_bcs_deserialize'vec'address''| b2@@69)))))
 :qid |boogiebpl.6749:15|
 :skolemid |332|
)))
(assert (forall ((b1@@70 T@Vec_6673) (b2@@70 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@70) (=> (|$IsValid'vec'u8''| b2@@70) (=> (|$IsEqual'vec'u8''| b1@@70 b2@@70) (|$IsEqual'vec'$1_aggregator_Aggregator''| (|$1_from_bcs_deserialize'vec'$1_aggregator_Aggregator''| b1@@70) (|$1_from_bcs_deserialize'vec'$1_aggregator_Aggregator''| b2@@70)))))
 :qid |boogiebpl.6752:15|
 :skolemid |333|
)))
(assert (forall ((b1@@71 T@Vec_6673) (b2@@71 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@71) (=> (|$IsValid'vec'u8''| b2@@71) (=> (|$IsEqual'vec'u8''| b1@@71 b2@@71) (|$IsEqual'vec'$1_optional_aggregator_Integer''| (|$1_from_bcs_deserialize'vec'$1_optional_aggregator_Integer''| b1@@71) (|$1_from_bcs_deserialize'vec'$1_optional_aggregator_Integer''| b2@@71)))))
 :qid |boogiebpl.6755:15|
 :skolemid |334|
)))
(assert (forall ((b1@@72 T@Vec_6673) (b2@@72 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@72) (=> (|$IsValid'vec'u8''| b2@@72) (=> (|$IsEqual'vec'u8''| b1@@72 b2@@72) (|$IsEqual'vec'$1_optional_aggregator_OptionalAggregator''| (|$1_from_bcs_deserialize'vec'$1_optional_aggregator_OptionalAggregator''| b1@@72) (|$1_from_bcs_deserialize'vec'$1_optional_aggregator_OptionalAggregator''| b2@@72)))))
 :qid |boogiebpl.6758:15|
 :skolemid |335|
)))
(assert (forall ((b1@@73 T@Vec_6673) (b2@@73 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@73) (=> (|$IsValid'vec'u8''| b2@@73) (=> (|$IsEqual'vec'u8''| b1@@73 b2@@73) (|$IsEqual'vec'#0''| (|$1_from_bcs_deserialize'vec'#0''| b1@@73) (|$1_from_bcs_deserialize'vec'#0''| b2@@73)))))
 :qid |boogiebpl.6761:15|
 :skolemid |336|
)))
(assert (forall ((b1@@74 T@Vec_6673) (b2@@74 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@74) (=> (|$IsValid'vec'u8''| b2@@74) (=> (|$IsEqual'vec'u8''| b1@@74 b2@@74) (|$IsEqual'$1_table_Table'u64_bool''| (|$1_from_bcs_deserialize'$1_table_Table'u64_bool''| b1@@74) (|$1_from_bcs_deserialize'$1_table_Table'u64_bool''| b2@@74)))))
 :qid |boogiebpl.6764:15|
 :skolemid |337|
)))
(assert (forall ((b1@@75 T@Vec_6673) (b2@@75 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@75) (=> (|$IsValid'vec'u8''| b2@@75) (=> (|$IsEqual'vec'u8''| b1@@75 b2@@75) (|$IsEqual'$1_table_Table'u64_u64''| (|$1_from_bcs_deserialize'$1_table_Table'u64_u64''| b1@@75) (|$1_from_bcs_deserialize'$1_table_Table'u64_u64''| b2@@75)))))
 :qid |boogiebpl.6767:15|
 :skolemid |338|
)))
(assert (forall ((b1@@76 T@Vec_6673) (b2@@76 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@76) (=> (|$IsValid'vec'u8''| b2@@76) (=> (|$IsEqual'vec'u8''| b1@@76 b2@@76) (|$IsEqual'$1_table_Table'u64_vec'u64'''| (|$1_from_bcs_deserialize'$1_table_Table'u64_vec'u64'''| b1@@76) (|$1_from_bcs_deserialize'$1_table_Table'u64_vec'u64'''| b2@@76)))))
 :qid |boogiebpl.6770:15|
 :skolemid |339|
)))
(assert (forall ((b1@@77 T@Vec_6673) (b2@@77 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@77) (=> (|$IsValid'vec'u8''| b2@@77) (=> (|$IsEqual'vec'u8''| b1@@77 b2@@77) (|$IsEqual'$1_table_Table'address_address''| (|$1_from_bcs_deserialize'$1_table_Table'address_address''| b1@@77) (|$1_from_bcs_deserialize'$1_table_Table'address_address''| b2@@77)))))
 :qid |boogiebpl.6773:15|
 :skolemid |340|
)))
(assert (forall ((b1@@78 T@Vec_6673) (b2@@78 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@78) (=> (|$IsValid'vec'u8''| b2@@78) (=> (|$IsEqual'vec'u8''| b1@@78 b2@@78) (|$IsEqual'vec'address''| (|$vec#$1_option_Option'address'| (|$1_from_bcs_deserialize'$1_option_Option'address''| b1@@78)) (|$vec#$1_option_Option'address'| (|$1_from_bcs_deserialize'$1_option_Option'address''| b2@@78))))))
 :qid |boogiebpl.6776:15|
 :skolemid |341|
)))
(assert (forall ((b1@@79 T@Vec_6673) (b2@@79 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@79) (=> (|$IsValid'vec'u8''| b2@@79) (=> (|$IsEqual'vec'u8''| b1@@79 b2@@79) (|$IsEqual'vec'$1_aggregator_Aggregator''| (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$1_from_bcs_deserialize'$1_option_Option'$1_aggregator_Aggregator''| b1@@79)) (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$1_from_bcs_deserialize'$1_option_Option'$1_aggregator_Aggregator''| b2@@79))))))
 :qid |boogiebpl.6779:15|
 :skolemid |342|
)))
(assert (forall ((b1@@80 T@Vec_6673) (b2@@80 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@80) (=> (|$IsValid'vec'u8''| b2@@80) (=> (|$IsEqual'vec'u8''| b1@@80 b2@@80) (|$IsEqual'vec'$1_optional_aggregator_Integer''| (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_Integer''| b1@@80)) (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_Integer''| b2@@80))))))
 :qid |boogiebpl.6782:15|
 :skolemid |343|
)))
(assert (forall ((b1@@81 T@Vec_6673) (b2@@81 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@81) (=> (|$IsValid'vec'u8''| b2@@81) (=> (|$IsEqual'vec'u8''| b1@@81 b2@@81) (|$IsEqual'vec'$1_optional_aggregator_OptionalAggregator''| (|$vec#$1_option_Option'$1_optional_aggregator_OptionalAggregator'| (|$1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| b1@@81)) (|$vec#$1_option_Option'$1_optional_aggregator_OptionalAggregator'| (|$1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| b2@@81))))))
 :qid |boogiebpl.6785:15|
 :skolemid |344|
)))
(assert (forall ((b1@@82 T@Vec_6673) (b2@@82 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@82) (=> (|$IsValid'vec'u8''| b2@@82) (=> (|$IsEqual'vec'u8''| b1@@82 b2@@82) (|$IsEqual'vec'u8''| (|$bytes#$1_string_String| (|$1_from_bcs_deserialize'$1_string_String'| b1@@82)) (|$bytes#$1_string_String| (|$1_from_bcs_deserialize'$1_string_String'| b2@@82))))))
 :qid |boogiebpl.6788:15|
 :skolemid |345|
)))
(assert (forall ((b1@@83 T@Vec_6673) (b2@@83 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@83) (=> (|$IsValid'vec'u8''| b2@@83) (=> (|$IsEqual'vec'u8''| b1@@83 b2@@83) (and (and (= (|$account_address#$1_type_info_TypeInfo| (|$1_from_bcs_deserialize'$1_type_info_TypeInfo'| b1@@83)) (|$account_address#$1_type_info_TypeInfo| (|$1_from_bcs_deserialize'$1_type_info_TypeInfo'| b2@@83))) (|$IsEqual'vec'u8''| (|$module_name#$1_type_info_TypeInfo| (|$1_from_bcs_deserialize'$1_type_info_TypeInfo'| b1@@83)) (|$module_name#$1_type_info_TypeInfo| (|$1_from_bcs_deserialize'$1_type_info_TypeInfo'| b2@@83)))) (|$IsEqual'vec'u8''| (|$struct_name#$1_type_info_TypeInfo| (|$1_from_bcs_deserialize'$1_type_info_TypeInfo'| b1@@83)) (|$struct_name#$1_type_info_TypeInfo| (|$1_from_bcs_deserialize'$1_type_info_TypeInfo'| b2@@83)))))))
 :qid |boogiebpl.6791:15|
 :skolemid |346|
)))
(assert (forall ((b1@@84 T@Vec_6673) (b2@@84 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@84) (=> (|$IsValid'vec'u8''| b2@@84) (=> (|$IsEqual'vec'u8''| b1@@84 b2@@84) (= (|$1_from_bcs_deserialize'$1_aggregator_Aggregator'| b1@@84) (|$1_from_bcs_deserialize'$1_aggregator_Aggregator'| b2@@84)))))
 :qid |boogiebpl.6794:15|
 :skolemid |347|
)))
(assert (forall ((b1@@85 T@Vec_6673) (b2@@85 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@85) (=> (|$IsValid'vec'u8''| b2@@85) (=> (|$IsEqual'vec'u8''| b1@@85 b2@@85) (= (|$1_from_bcs_deserialize'$1_optional_aggregator_Integer'| b1@@85) (|$1_from_bcs_deserialize'$1_optional_aggregator_Integer'| b2@@85)))))
 :qid |boogiebpl.6797:15|
 :skolemid |348|
)))
(assert (forall ((b1@@86 T@Vec_6673) (b2@@86 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@86) (=> (|$IsValid'vec'u8''| b2@@86) (=> (|$IsEqual'vec'u8''| b1@@86 b2@@86) (and (|$IsEqual'vec'$1_aggregator_Aggregator''| (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| (|$1_from_bcs_deserialize'$1_optional_aggregator_OptionalAggregator'| b1@@86))) (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| (|$1_from_bcs_deserialize'$1_optional_aggregator_OptionalAggregator'| b2@@86)))) (|$IsEqual'vec'$1_optional_aggregator_Integer''| (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| (|$1_from_bcs_deserialize'$1_optional_aggregator_OptionalAggregator'| b1@@86))) (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| (|$1_from_bcs_deserialize'$1_optional_aggregator_OptionalAggregator'| b2@@86))))))))
 :qid |boogiebpl.6800:15|
 :skolemid |349|
)))
(assert (forall ((b1@@87 T@Vec_6673) (b2@@87 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@87) (=> (|$IsValid'vec'u8''| b2@@87) (=> (|$IsEqual'vec'u8''| b1@@87 b2@@87) (= (|$1_from_bcs_deserialize'$1_guid_GUID'| b1@@87) (|$1_from_bcs_deserialize'$1_guid_GUID'| b2@@87)))))
 :qid |boogiebpl.6803:15|
 :skolemid |350|
)))
(assert (forall ((b1@@88 T@Vec_6673) (b2@@88 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@88) (=> (|$IsValid'vec'u8''| b2@@88) (=> (|$IsEqual'vec'u8''| b1@@88 b2@@88) (= (|$1_from_bcs_deserialize'$1_guid_ID'| b1@@88) (|$1_from_bcs_deserialize'$1_guid_ID'| b2@@88)))))
 :qid |boogiebpl.6806:15|
 :skolemid |351|
)))
(assert (forall ((b1@@89 T@Vec_6673) (b2@@89 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@89) (=> (|$IsValid'vec'u8''| b2@@89) (=> (|$IsEqual'vec'u8''| b1@@89 b2@@89) (= (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_account_CoinRegisterEvent''| b1@@89) (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_account_CoinRegisterEvent''| b2@@89)))))
 :qid |boogiebpl.6809:15|
 :skolemid |352|
)))
(assert (forall ((b1@@90 T@Vec_6673) (b2@@90 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@90) (=> (|$IsValid'vec'u8''| b2@@90) (=> (|$IsEqual'vec'u8''| b1@@90 b2@@90) (= (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_account_KeyRotationEvent''| b1@@90) (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_account_KeyRotationEvent''| b2@@90)))))
 :qid |boogiebpl.6812:15|
 :skolemid |353|
)))
(assert (forall ((b1@@91 T@Vec_6673) (b2@@91 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@91) (=> (|$IsValid'vec'u8''| b2@@91) (=> (|$IsEqual'vec'u8''| b1@@91 b2@@91) (= (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_DepositEvent''| b1@@91) (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_DepositEvent''| b2@@91)))))
 :qid |boogiebpl.6815:15|
 :skolemid |354|
)))
(assert (forall ((b1@@92 T@Vec_6673) (b2@@92 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@92) (=> (|$IsValid'vec'u8''| b2@@92) (=> (|$IsEqual'vec'u8''| b1@@92 b2@@92) (= (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_WithdrawEvent''| b1@@92) (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_WithdrawEvent''| b2@@92)))))
 :qid |boogiebpl.6818:15|
 :skolemid |355|
)))
(assert (forall ((b1@@93 T@Vec_6673) (b2@@93 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@93) (=> (|$IsValid'vec'u8''| b2@@93) (=> (|$IsEqual'vec'u8''| b1@@93 b2@@93) (and (and (and (and (and (and (|$IsEqual'vec'u8''| (|$authentication_key#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b1@@93)) (|$authentication_key#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b2@@93))) (= (|$sequence_number#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b1@@93)) (|$sequence_number#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b2@@93)))) (= (|$guid_creation_num#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b1@@93)) (|$guid_creation_num#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b2@@93)))) (= (|$coin_register_events#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b1@@93)) (|$coin_register_events#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b2@@93)))) (= (|$key_rotation_events#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b1@@93)) (|$key_rotation_events#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b2@@93)))) (|$IsEqual'vec'address''| (|$vec#$1_option_Option'address'| (|$for#$1_account_CapabilityOffer'$1_account_RotationCapability'| (|$rotation_capability_offer#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b1@@93)))) (|$vec#$1_option_Option'address'| (|$for#$1_account_CapabilityOffer'$1_account_RotationCapability'| (|$rotation_capability_offer#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b2@@93)))))) (|$IsEqual'vec'address''| (|$vec#$1_option_Option'address'| (|$for#$1_account_CapabilityOffer'$1_account_SignerCapability'| (|$signer_capability_offer#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b1@@93)))) (|$vec#$1_option_Option'address'| (|$for#$1_account_CapabilityOffer'$1_account_SignerCapability'| (|$signer_capability_offer#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b2@@93)))))))))
 :qid |boogiebpl.6821:15|
 :skolemid |356|
)))
(assert (forall ((b1@@94 T@Vec_6673) (b2@@94 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@94) (=> (|$IsValid'vec'u8''| b2@@94) (=> (|$IsEqual'vec'u8''| b1@@94 b2@@94) (|$IsEqual'vec'address''| (|$vec#$1_option_Option'address'| (|$for#$1_account_CapabilityOffer'$1_account_RotationCapability'| (|$1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_RotationCapability''| b1@@94))) (|$vec#$1_option_Option'address'| (|$for#$1_account_CapabilityOffer'$1_account_RotationCapability'| (|$1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_RotationCapability''| b2@@94)))))))
 :qid |boogiebpl.6824:15|
 :skolemid |357|
)))
(assert (forall ((b1@@95 T@Vec_6673) (b2@@95 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@95) (=> (|$IsValid'vec'u8''| b2@@95) (=> (|$IsEqual'vec'u8''| b1@@95 b2@@95) (|$IsEqual'vec'address''| (|$vec#$1_option_Option'address'| (|$for#$1_account_CapabilityOffer'$1_account_SignerCapability'| (|$1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_SignerCapability''| b1@@95))) (|$vec#$1_option_Option'address'| (|$for#$1_account_CapabilityOffer'$1_account_SignerCapability'| (|$1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_SignerCapability''| b2@@95)))))))
 :qid |boogiebpl.6827:15|
 :skolemid |358|
)))
(assert (forall ((b1@@96 T@Vec_6673) (b2@@96 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@96) (=> (|$IsValid'vec'u8''| b2@@96) (=> (|$IsEqual'vec'u8''| b1@@96 b2@@96) (and (and (= (|$account_address#$1_type_info_TypeInfo| (|$type_info#$1_account_CoinRegisterEvent| (|$1_from_bcs_deserialize'$1_account_CoinRegisterEvent'| b1@@96))) (|$account_address#$1_type_info_TypeInfo| (|$type_info#$1_account_CoinRegisterEvent| (|$1_from_bcs_deserialize'$1_account_CoinRegisterEvent'| b2@@96)))) (|$IsEqual'vec'u8''| (|$module_name#$1_type_info_TypeInfo| (|$type_info#$1_account_CoinRegisterEvent| (|$1_from_bcs_deserialize'$1_account_CoinRegisterEvent'| b1@@96))) (|$module_name#$1_type_info_TypeInfo| (|$type_info#$1_account_CoinRegisterEvent| (|$1_from_bcs_deserialize'$1_account_CoinRegisterEvent'| b2@@96))))) (|$IsEqual'vec'u8''| (|$struct_name#$1_type_info_TypeInfo| (|$type_info#$1_account_CoinRegisterEvent| (|$1_from_bcs_deserialize'$1_account_CoinRegisterEvent'| b1@@96))) (|$struct_name#$1_type_info_TypeInfo| (|$type_info#$1_account_CoinRegisterEvent| (|$1_from_bcs_deserialize'$1_account_CoinRegisterEvent'| b2@@96))))))))
 :qid |boogiebpl.6830:15|
 :skolemid |359|
)))
(assert (forall ((b1@@97 T@Vec_6673) (b2@@97 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@97) (=> (|$IsValid'vec'u8''| b2@@97) (=> (|$IsEqual'vec'u8''| b1@@97 b2@@97) (= (|$1_from_bcs_deserialize'$1_account_SignerCapability'| b1@@97) (|$1_from_bcs_deserialize'$1_account_SignerCapability'| b2@@97)))))
 :qid |boogiebpl.6833:15|
 :skolemid |360|
)))
(assert (forall ((b1@@98 T@Vec_6673) (b2@@98 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@98) (=> (|$IsValid'vec'u8''| b2@@98) (=> (|$IsEqual'vec'u8''| b1@@98 b2@@98) (= (|$1_from_bcs_deserialize'$1_coin_Coin'$1_aptos_coin_AptosCoin''| b1@@98) (|$1_from_bcs_deserialize'$1_coin_Coin'$1_aptos_coin_AptosCoin''| b2@@98)))))
 :qid |boogiebpl.6836:15|
 :skolemid |361|
)))
(assert (forall ((b1@@99 T@Vec_6673) (b2@@99 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@99) (=> (|$IsValid'vec'u8''| b2@@99) (=> (|$IsEqual'vec'u8''| b1@@99 b2@@99) (= (|$1_from_bcs_deserialize'$1_coin_Coin'#0''| b1@@99) (|$1_from_bcs_deserialize'$1_coin_Coin'#0''| b2@@99)))))
 :qid |boogiebpl.6839:15|
 :skolemid |362|
)))
(assert (forall ((b1@@100 T@Vec_6673) (b2@@100 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@100) (=> (|$IsValid'vec'u8''| b2@@100) (=> (|$IsEqual'vec'u8''| b1@@100 b2@@100) (and (and (and (|$IsEqual'vec'u8''| (|$bytes#$1_string_String| (|$name#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| b1@@100))) (|$bytes#$1_string_String| (|$name#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| b2@@100)))) (|$IsEqual'vec'u8''| (|$bytes#$1_string_String| (|$symbol#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| b1@@100))) (|$bytes#$1_string_String| (|$symbol#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| b2@@100))))) (= (|$decimals#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| b1@@100)) (|$decimals#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| b2@@100)))) (|$IsEqual'vec'$1_optional_aggregator_OptionalAggregator''| (|$vec#$1_option_Option'$1_optional_aggregator_OptionalAggregator'| (|$supply#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| b1@@100))) (|$vec#$1_option_Option'$1_optional_aggregator_OptionalAggregator'| (|$supply#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| b2@@100))))))))
 :qid |boogiebpl.6842:15|
 :skolemid |363|
)))
(assert (forall ((b1@@101 T@Vec_6673) (b2@@101 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@101) (=> (|$IsValid'vec'u8''| b2@@101) (=> (|$IsEqual'vec'u8''| b1@@101 b2@@101) (and (and (and (|$IsEqual'vec'u8''| (|$bytes#$1_string_String| (|$name#$1_coin_CoinInfo'#0'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'#0''| b1@@101))) (|$bytes#$1_string_String| (|$name#$1_coin_CoinInfo'#0'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'#0''| b2@@101)))) (|$IsEqual'vec'u8''| (|$bytes#$1_string_String| (|$symbol#$1_coin_CoinInfo'#0'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'#0''| b1@@101))) (|$bytes#$1_string_String| (|$symbol#$1_coin_CoinInfo'#0'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'#0''| b2@@101))))) (= (|$decimals#$1_coin_CoinInfo'#0'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'#0''| b1@@101)) (|$decimals#$1_coin_CoinInfo'#0'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'#0''| b2@@101)))) (|$IsEqual'vec'$1_optional_aggregator_OptionalAggregator''| (|$vec#$1_option_Option'$1_optional_aggregator_OptionalAggregator'| (|$supply#$1_coin_CoinInfo'#0'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'#0''| b1@@101))) (|$vec#$1_option_Option'$1_optional_aggregator_OptionalAggregator'| (|$supply#$1_coin_CoinInfo'#0'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'#0''| b2@@101))))))))
 :qid |boogiebpl.6845:15|
 :skolemid |364|
)))
(assert (forall ((b1@@102 T@Vec_6673) (b2@@102 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@102) (=> (|$IsValid'vec'u8''| b2@@102) (=> (|$IsEqual'vec'u8''| b1@@102 b2@@102) (= (|$1_from_bcs_deserialize'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''| b1@@102) (|$1_from_bcs_deserialize'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''| b2@@102)))))
 :qid |boogiebpl.6848:15|
 :skolemid |365|
)))
(assert (forall ((b1@@103 T@Vec_6673) (b2@@103 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@103) (=> (|$IsValid'vec'u8''| b2@@103) (=> (|$IsEqual'vec'u8''| b1@@103 b2@@103) (= (|$1_from_bcs_deserialize'$1_coin_CoinStore'#0''| b1@@103) (|$1_from_bcs_deserialize'$1_coin_CoinStore'#0''| b2@@103)))))
 :qid |boogiebpl.6851:15|
 :skolemid |366|
)))
(assert (forall ((b1@@104 T@Vec_6673) (b2@@104 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@104) (=> (|$IsValid'vec'u8''| b2@@104) (=> (|$IsEqual'vec'u8''| b1@@104 b2@@104) (= (|$1_from_bcs_deserialize'$1_coin_DepositEvent'| b1@@104) (|$1_from_bcs_deserialize'$1_coin_DepositEvent'| b2@@104)))))
 :qid |boogiebpl.6854:15|
 :skolemid |367|
)))
(assert (forall ((b1@@105 T@Vec_6673) (b2@@105 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@105) (=> (|$IsValid'vec'u8''| b2@@105) (=> (|$IsEqual'vec'u8''| b1@@105 b2@@105) (= (|$1_from_bcs_deserialize'$1_coin_WithdrawEvent'| b1@@105) (|$1_from_bcs_deserialize'$1_coin_WithdrawEvent'| b2@@105)))))
 :qid |boogiebpl.6857:15|
 :skolemid |368|
)))
(assert (forall ((b1@@106 T@Vec_6673) (b2@@106 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@106) (=> (|$IsValid'vec'u8''| b2@@106) (=> (|$IsEqual'vec'u8''| b1@@106 b2@@106) (= (|$1_from_bcs_deserialize'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''| b1@@106) (|$1_from_bcs_deserialize'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''| b2@@106)))))
 :qid |boogiebpl.6860:15|
 :skolemid |369|
)))
(assert (forall ((b1@@107 T@Vec_6673) (b2@@107 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@107) (=> (|$IsValid'vec'u8''| b2@@107) (=> (|$IsEqual'vec'u8''| b1@@107 b2@@107) (= (|$1_from_bcs_deserialize'$1_coin_Ghost$supply'#0''| b1@@107) (|$1_from_bcs_deserialize'$1_coin_Ghost$supply'#0''| b2@@107)))))
 :qid |boogiebpl.6863:15|
 :skolemid |370|
)))
(assert (forall ((b1@@108 T@Vec_6673) (b2@@108 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@108) (=> (|$IsValid'vec'u8''| b2@@108) (=> (|$IsEqual'vec'u8''| b1@@108 b2@@108) (= (|$1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''| b1@@108) (|$1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''| b2@@108)))))
 :qid |boogiebpl.6866:15|
 :skolemid |371|
)))
(assert (forall ((b1@@109 T@Vec_6673) (b2@@109 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@109) (=> (|$IsValid'vec'u8''| b2@@109) (=> (|$IsEqual'vec'u8''| b1@@109 b2@@109) (= (|$1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'#0''| b1@@109) (|$1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'#0''| b2@@109)))))
 :qid |boogiebpl.6869:15|
 :skolemid |372|
)))
(assert (forall ((b1@@110 T@Vec_6673) (b2@@110 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@110) (=> (|$IsValid'vec'u8''| b2@@110) (=> (|$IsEqual'vec'u8''| b1@@110 b2@@110) (= (|$1_from_bcs_deserialize'$1_aptos_coin_AptosCoin'| b1@@110) (|$1_from_bcs_deserialize'$1_aptos_coin_AptosCoin'| b2@@110)))))
 :qid |boogiebpl.6872:15|
 :skolemid |373|
)))
(assert (forall ((b1@@111 T@Vec_6673) (b2@@111 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@111) (=> (|$IsValid'vec'u8''| b2@@111) (=> (|$IsEqual'vec'u8''| b1@@111 b2@@111) (= (|$1_from_bcs_deserialize'$1_Bbay_Owner'| b1@@111) (|$1_from_bcs_deserialize'$1_Bbay_Owner'| b2@@111)))))
 :qid |boogiebpl.6875:15|
 :skolemid |374|
)))
(assert (forall ((b1@@112 T@Vec_6673) (b2@@112 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@112) (=> (|$IsValid'vec'u8''| b2@@112) (=> (|$IsEqual'vec'u8''| b1@@112 b2@@112) (and (and (and (and (and (|$IsEqual'$1_table_Table'u64_u64''| (|$sr_number#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b1@@112)) (|$sr_number#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b2@@112))) (|$IsEqual'vec'u64''| (|$item_id#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b1@@112)) (|$item_id#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b2@@112)))) (|$IsEqual'$1_table_Table'u64_vec'u64'''| (|$item_name#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b1@@112)) (|$item_name#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b2@@112)))) (|$IsEqual'$1_table_Table'u64_bool''| (|$item_sold#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b1@@112)) (|$item_sold#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b2@@112)))) (|$IsEqual'$1_table_Table'u64_u64''| (|$item_price#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b1@@112)) (|$item_price#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b2@@112)))) (|$IsEqual'$1_table_Table'u64_bool''| (|$item_on_selling#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b1@@112)) (|$item_on_selling#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b2@@112)))))))
 :qid |boogiebpl.6878:15|
 :skolemid |375|
)))
(assert (forall ((b1@@113 T@Vec_6673) (b2@@113 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@113) (=> (|$IsValid'vec'u8''| b2@@113) (=> (|$IsEqual'vec'u8''| b1@@113 b2@@113) (= (|$1_from_bcs_deserialize'$1_Bbay_ResourceAccountSignerCap'| b1@@113) (|$1_from_bcs_deserialize'$1_Bbay_ResourceAccountSignerCap'| b2@@113)))))
 :qid |boogiebpl.6881:15|
 :skolemid |376|
)))
(assert (forall ((b1@@114 T@Vec_6673) (b2@@114 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@114) (=> (|$IsValid'vec'u8''| b2@@114) (=> (|$IsEqual'vec'u8''| b1@@114 b2@@114) (and (and (and (= (|$user_id#$1_Bbay_User| (|$1_from_bcs_deserialize'$1_Bbay_User'| b1@@114)) (|$user_id#$1_Bbay_User| (|$1_from_bcs_deserialize'$1_Bbay_User'| b2@@114))) (|$IsEqual'vec'u64''| (|$orders#$1_Bbay_User| (|$1_from_bcs_deserialize'$1_Bbay_User'| b1@@114)) (|$orders#$1_Bbay_User| (|$1_from_bcs_deserialize'$1_Bbay_User'| b2@@114)))) (|$IsEqual'vec'u64''| (|$order_status#$1_Bbay_User| (|$1_from_bcs_deserialize'$1_Bbay_User'| b1@@114)) (|$order_status#$1_Bbay_User| (|$1_from_bcs_deserialize'$1_Bbay_User'| b2@@114)))) (|$IsEqual'vec'u64''| (|$payment_status#$1_Bbay_User| (|$1_from_bcs_deserialize'$1_Bbay_User'| b1@@114)) (|$payment_status#$1_Bbay_User| (|$1_from_bcs_deserialize'$1_Bbay_User'| b2@@114)))))))
 :qid |boogiebpl.6884:15|
 :skolemid |377|
)))
(assert (forall ((b1@@115 T@Vec_6673) (b2@@115 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@115) (=> (|$IsValid'vec'u8''| b2@@115) (=> (|$IsEqual'vec'u8''| b1@@115 b2@@115) (= (|$1_from_bcs_deserialize'#0'| b1@@115) (|$1_from_bcs_deserialize'#0'| b2@@115)))))
 :qid |boogiebpl.6887:15|
 :skolemid |378|
)))
(assert (forall ((src1@@1 Int) (p@@1 Int) ) (! (= ($shl src1@@1 p@@1) (* src1@@1 ($pow 2 p@@1)))
 :qid |boogiebpl.1491:15|
 :skolemid |33|
 :pattern ( ($shl src1@@1 p@@1))
)))
(assert (forall ((t@@2 T@$TypeParamInfo) ) (!  (=> (|$IsEqual'vec'u8''| ($TypeName t@@2) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 49) 2 54) 3)) (is-$TypeParamU16 t@@2))
 :qid |boogiebpl.6526:15|
 :skolemid |250|
 :pattern ( ($TypeName t@@2))
)))
(assert (forall ((t@@3 T@$TypeParamInfo) ) (!  (=> (|$IsEqual'vec'u8''| ($TypeName t@@3) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 51) 2 50) 3)) (is-$TypeParamU32 t@@3))
 :qid |boogiebpl.6528:15|
 :skolemid |252|
 :pattern ( ($TypeName t@@3))
)))
(assert (forall ((t@@4 T@$TypeParamInfo) ) (!  (=> (|$IsEqual'vec'u8''| ($TypeName t@@4) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 54) 2 52) 3)) (is-$TypeParamU64 t@@4))
 :qid |boogiebpl.6530:15|
 :skolemid |254|
 :pattern ( ($TypeName t@@4))
)))
(assert (forall ((bytes T@Vec_6673) ) (! true
 :qid |boogiebpl.7780:15|
 :skolemid |398|
)))
(assert (forall ((bytes@@0 T@Vec_6673) ) (! (let (($$res@@0 (|$1_from_bcs_deserialize'u8'| bytes@@0)))
(|$IsValid'u8'| $$res@@0))
 :qid |boogiebpl.7786:15|
 :skolemid |399|
)))
(assert (forall ((bytes@@1 T@Vec_6673) ) (! (let (($$res@@1 (|$1_from_bcs_deserialize'u64'| bytes@@1)))
(|$IsValid'u64'| $$res@@1))
 :qid |boogiebpl.7792:15|
 :skolemid |400|
)))
(assert (forall ((bytes@@2 T@Vec_6673) ) (! (let (($$res@@2 (|$1_from_bcs_deserialize'u128'| bytes@@2)))
(|$IsValid'u128'| $$res@@2))
 :qid |boogiebpl.7798:15|
 :skolemid |401|
)))
(assert (forall ((bytes@@3 T@Vec_6673) ) (! (let (($$res@@3 (|$1_from_bcs_deserialize'u256'| bytes@@3)))
(|$IsValid'u256'| $$res@@3))
 :qid |boogiebpl.7804:15|
 :skolemid |402|
)))
(assert (forall ((bytes@@4 T@Vec_6673) ) (! (let (($$res@@4 (|$1_from_bcs_deserialize'address'| bytes@@4)))
(|$IsValid'address'| $$res@@4))
 :qid |boogiebpl.7810:15|
 :skolemid |403|
)))
(assert (forall ((bytes@@5 T@Vec_6673) ) (! (let (($$res@@5 (|$1_from_bcs_deserialize'signer'| bytes@@5)))
(|$IsValid'address'| (|$addr#$signer| $$res@@5)))
 :qid |boogiebpl.7816:15|
 :skolemid |404|
)))
(assert (forall ((bytes@@6 T@Vec_6673) ) (! (let (($$res@@6 (|$1_from_bcs_deserialize'vec'u8''| bytes@@6)))
(|$IsValid'vec'u8''| $$res@@6))
 :qid |boogiebpl.7822:15|
 :skolemid |405|
)))
(assert (forall ((bytes@@7 T@Vec_6673) ) (! (let (($$res@@7 (|$1_from_bcs_deserialize'vec'u64''| bytes@@7)))
(|$IsValid'vec'u64''| $$res@@7))
 :qid |boogiebpl.7828:15|
 :skolemid |406|
)))
(assert (forall ((bytes@@8 T@Vec_6673) ) (! (let (($$res@@8 (|$1_from_bcs_deserialize'vec'address''| bytes@@8)))
(|$IsValid'vec'address''| $$res@@8))
 :qid |boogiebpl.7834:15|
 :skolemid |407|
)))
(assert (forall ((bytes@@9 T@Vec_6673) ) (! (let (($$res@@9 (|$1_from_bcs_deserialize'vec'$1_aggregator_Aggregator''| bytes@@9)))
(|$IsValid'vec'$1_aggregator_Aggregator''| $$res@@9))
 :qid |boogiebpl.7840:15|
 :skolemid |408|
)))
(assert (forall ((bytes@@10 T@Vec_6673) ) (! (let (($$res@@10 (|$1_from_bcs_deserialize'vec'$1_optional_aggregator_Integer''| bytes@@10)))
(|$IsValid'vec'$1_optional_aggregator_Integer''| $$res@@10))
 :qid |boogiebpl.7846:15|
 :skolemid |409|
)))
(assert (forall ((bytes@@11 T@Vec_6673) ) (! (let (($$res@@11 (|$1_from_bcs_deserialize'vec'$1_optional_aggregator_OptionalAggregator''| bytes@@11)))
(|$IsValid'vec'$1_optional_aggregator_OptionalAggregator''| $$res@@11))
 :qid |boogiebpl.7852:15|
 :skolemid |410|
)))
(assert (forall ((bytes@@12 T@Vec_6673) ) (! (let (($$res@@12 (|$1_from_bcs_deserialize'vec'#0''| bytes@@12)))
(|$IsValid'vec'#0''| $$res@@12))
 :qid |boogiebpl.7858:15|
 :skolemid |411|
)))
(assert (forall ((bytes@@13 T@Vec_6673) ) (! (let (($$res@@13 (|$1_from_bcs_deserialize'$1_table_Table'u64_bool''| bytes@@13)))
(|$IsValid'$1_table_Table'u64_bool''| $$res@@13))
 :qid |boogiebpl.7864:15|
 :skolemid |412|
)))
(assert (forall ((bytes@@14 T@Vec_6673) ) (! (let (($$res@@14 (|$1_from_bcs_deserialize'$1_table_Table'u64_u64''| bytes@@14)))
(|$IsValid'$1_table_Table'u64_u64''| $$res@@14))
 :qid |boogiebpl.7870:15|
 :skolemid |413|
)))
(assert (forall ((bytes@@15 T@Vec_6673) ) (! (let (($$res@@15 (|$1_from_bcs_deserialize'$1_table_Table'u64_vec'u64'''| bytes@@15)))
(|$IsValid'$1_table_Table'u64_vec'u64'''| $$res@@15))
 :qid |boogiebpl.7876:15|
 :skolemid |414|
)))
(assert (forall ((bytes@@16 T@Vec_6673) ) (! (let (($$res@@16 (|$1_from_bcs_deserialize'$1_table_Table'address_address''| bytes@@16)))
(|$IsValid'$1_table_Table'address_address''| $$res@@16))
 :qid |boogiebpl.7882:15|
 :skolemid |415|
)))
(assert (forall ((bytes@@17 T@Vec_6673) ) (! (let (($$res@@17 (|$1_from_bcs_deserialize'$1_option_Option'address''| bytes@@17)))
(|$IsValid'$1_option_Option'address''| $$res@@17))
 :qid |boogiebpl.7888:15|
 :skolemid |416|
)))
(assert (forall ((bytes@@18 T@Vec_6673) ) (! (let (($$res@@18 (|$1_from_bcs_deserialize'$1_option_Option'$1_aggregator_Aggregator''| bytes@@18)))
(|$IsValid'$1_option_Option'$1_aggregator_Aggregator''| $$res@@18))
 :qid |boogiebpl.7894:15|
 :skolemid |417|
)))
(assert (forall ((bytes@@19 T@Vec_6673) ) (! (let (($$res@@19 (|$1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_Integer''| bytes@@19)))
(|$IsValid'$1_option_Option'$1_optional_aggregator_Integer''| $$res@@19))
 :qid |boogiebpl.7900:15|
 :skolemid |418|
)))
(assert (forall ((bytes@@20 T@Vec_6673) ) (! (let (($$res@@20 (|$1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| bytes@@20)))
(|$IsValid'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| $$res@@20))
 :qid |boogiebpl.7906:15|
 :skolemid |419|
)))
(assert (forall ((bytes@@21 T@Vec_6673) ) (! (let (($$res@@21 (|$1_from_bcs_deserialize'$1_string_String'| bytes@@21)))
(|$IsValid'$1_string_String'| $$res@@21))
 :qid |boogiebpl.7912:15|
 :skolemid |420|
)))
(assert (forall ((bytes@@22 T@Vec_6673) ) (! (let (($$res@@22 (|$1_from_bcs_deserialize'$1_type_info_TypeInfo'| bytes@@22)))
(|$IsValid'$1_type_info_TypeInfo'| $$res@@22))
 :qid |boogiebpl.7918:15|
 :skolemid |421|
)))
(assert (forall ((bytes@@23 T@Vec_6673) ) (! (let (($$res@@23 (|$1_from_bcs_deserialize'$1_aggregator_Aggregator'| bytes@@23)))
(|$IsValid'$1_aggregator_Aggregator'| $$res@@23))
 :qid |boogiebpl.7924:15|
 :skolemid |422|
)))
(assert (forall ((bytes@@24 T@Vec_6673) ) (! (let (($$res@@24 (|$1_from_bcs_deserialize'$1_optional_aggregator_Integer'| bytes@@24)))
(|$IsValid'$1_optional_aggregator_Integer'| $$res@@24))
 :qid |boogiebpl.7930:15|
 :skolemid |423|
)))
(assert (forall ((bytes@@25 T@Vec_6673) ) (! (let (($$res@@25 (|$1_from_bcs_deserialize'$1_optional_aggregator_OptionalAggregator'| bytes@@25)))
(|$IsValid'$1_optional_aggregator_OptionalAggregator'| $$res@@25))
 :qid |boogiebpl.7936:15|
 :skolemid |424|
)))
(assert (forall ((bytes@@26 T@Vec_6673) ) (! (let (($$res@@26 (|$1_from_bcs_deserialize'$1_guid_GUID'| bytes@@26)))
(|$IsValid'$1_guid_GUID'| $$res@@26))
 :qid |boogiebpl.7942:15|
 :skolemid |425|
)))
(assert (forall ((bytes@@27 T@Vec_6673) ) (! (let (($$res@@27 (|$1_from_bcs_deserialize'$1_guid_ID'| bytes@@27)))
(|$IsValid'$1_guid_ID'| $$res@@27))
 :qid |boogiebpl.7948:15|
 :skolemid |426|
)))
(assert (forall ((bytes@@28 T@Vec_6673) ) (! (let (($$res@@28 (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_account_CoinRegisterEvent''| bytes@@28)))
(|$IsValid'$1_event_EventHandle'$1_account_CoinRegisterEvent''| $$res@@28))
 :qid |boogiebpl.7954:15|
 :skolemid |427|
)))
(assert (forall ((bytes@@29 T@Vec_6673) ) (! (let (($$res@@29 (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_account_KeyRotationEvent''| bytes@@29)))
(|$IsValid'$1_event_EventHandle'$1_account_KeyRotationEvent''| $$res@@29))
 :qid |boogiebpl.7960:15|
 :skolemid |428|
)))
(assert (forall ((bytes@@30 T@Vec_6673) ) (! (let (($$res@@30 (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_DepositEvent''| bytes@@30)))
(|$IsValid'$1_event_EventHandle'$1_coin_DepositEvent''| $$res@@30))
 :qid |boogiebpl.7966:15|
 :skolemid |429|
)))
(assert (forall ((bytes@@31 T@Vec_6673) ) (! (let (($$res@@31 (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_WithdrawEvent''| bytes@@31)))
(|$IsValid'$1_event_EventHandle'$1_coin_WithdrawEvent''| $$res@@31))
 :qid |boogiebpl.7972:15|
 :skolemid |430|
)))
(assert (forall ((bytes@@32 T@Vec_6673) ) (! (let (($$res@@32 (|$1_from_bcs_deserialize'$1_account_Account'| bytes@@32)))
(|$IsValid'$1_account_Account'| $$res@@32))
 :qid |boogiebpl.7978:15|
 :skolemid |431|
)))
(assert (forall ((bytes@@33 T@Vec_6673) ) (! (let (($$res@@33 (|$1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_RotationCapability''| bytes@@33)))
(|$IsValid'$1_account_CapabilityOffer'$1_account_RotationCapability''| $$res@@33))
 :qid |boogiebpl.7984:15|
 :skolemid |432|
)))
(assert (forall ((bytes@@34 T@Vec_6673) ) (! (let (($$res@@34 (|$1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_SignerCapability''| bytes@@34)))
(|$IsValid'$1_account_CapabilityOffer'$1_account_SignerCapability''| $$res@@34))
 :qid |boogiebpl.7990:15|
 :skolemid |433|
)))
(assert (forall ((bytes@@35 T@Vec_6673) ) (! (let (($$res@@35 (|$1_from_bcs_deserialize'$1_account_CoinRegisterEvent'| bytes@@35)))
(|$IsValid'$1_account_CoinRegisterEvent'| $$res@@35))
 :qid |boogiebpl.7996:15|
 :skolemid |434|
)))
(assert (forall ((bytes@@36 T@Vec_6673) ) (! (let (($$res@@36 (|$1_from_bcs_deserialize'$1_account_SignerCapability'| bytes@@36)))
(|$IsValid'$1_account_SignerCapability'| $$res@@36))
 :qid |boogiebpl.8002:15|
 :skolemid |435|
)))
(assert (forall ((bytes@@37 T@Vec_6673) ) (! (let (($$res@@37 (|$1_from_bcs_deserialize'$1_coin_Coin'$1_aptos_coin_AptosCoin''| bytes@@37)))
(|$IsValid'$1_coin_Coin'$1_aptos_coin_AptosCoin''| $$res@@37))
 :qid |boogiebpl.8008:15|
 :skolemid |436|
)))
(assert (forall ((bytes@@38 T@Vec_6673) ) (! (let (($$res@@38 (|$1_from_bcs_deserialize'$1_coin_Coin'#0''| bytes@@38)))
(|$IsValid'$1_coin_Coin'#0''| $$res@@38))
 :qid |boogiebpl.8014:15|
 :skolemid |437|
)))
(assert (forall ((bytes@@39 T@Vec_6673) ) (! (let (($$res@@39 (|$1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| bytes@@39)))
(|$IsValid'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| $$res@@39))
 :qid |boogiebpl.8020:15|
 :skolemid |438|
)))
(assert (forall ((bytes@@40 T@Vec_6673) ) (! (let (($$res@@40 (|$1_from_bcs_deserialize'$1_coin_CoinInfo'#0''| bytes@@40)))
(|$IsValid'$1_coin_CoinInfo'#0''| $$res@@40))
 :qid |boogiebpl.8026:15|
 :skolemid |439|
)))
(assert (forall ((bytes@@41 T@Vec_6673) ) (! (let (($$res@@41 (|$1_from_bcs_deserialize'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''| bytes@@41)))
(|$IsValid'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''| $$res@@41))
 :qid |boogiebpl.8032:15|
 :skolemid |440|
)))
(assert (forall ((bytes@@42 T@Vec_6673) ) (! (let (($$res@@42 (|$1_from_bcs_deserialize'$1_coin_CoinStore'#0''| bytes@@42)))
(|$IsValid'$1_coin_CoinStore'#0''| $$res@@42))
 :qid |boogiebpl.8038:15|
 :skolemid |441|
)))
(assert (forall ((bytes@@43 T@Vec_6673) ) (! (let (($$res@@43 (|$1_from_bcs_deserialize'$1_coin_DepositEvent'| bytes@@43)))
(|$IsValid'$1_coin_DepositEvent'| $$res@@43))
 :qid |boogiebpl.8044:15|
 :skolemid |442|
)))
(assert (forall ((bytes@@44 T@Vec_6673) ) (! (let (($$res@@44 (|$1_from_bcs_deserialize'$1_coin_WithdrawEvent'| bytes@@44)))
(|$IsValid'$1_coin_WithdrawEvent'| $$res@@44))
 :qid |boogiebpl.8050:15|
 :skolemid |443|
)))
(assert (forall ((bytes@@45 T@Vec_6673) ) (! (let (($$res@@45 (|$1_from_bcs_deserialize'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''| bytes@@45)))
(|$IsValid'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''| $$res@@45))
 :qid |boogiebpl.8056:15|
 :skolemid |444|
)))
(assert (forall ((bytes@@46 T@Vec_6673) ) (! (let (($$res@@46 (|$1_from_bcs_deserialize'$1_coin_Ghost$supply'#0''| bytes@@46)))
(|$IsValid'$1_coin_Ghost$supply'#0''| $$res@@46))
 :qid |boogiebpl.8062:15|
 :skolemid |445|
)))
(assert (forall ((bytes@@47 T@Vec_6673) ) (! (let (($$res@@47 (|$1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''| bytes@@47)))
(|$IsValid'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''| $$res@@47))
 :qid |boogiebpl.8068:15|
 :skolemid |446|
)))
(assert (forall ((bytes@@48 T@Vec_6673) ) (! (let (($$res@@48 (|$1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'#0''| bytes@@48)))
(|$IsValid'$1_coin_Ghost$aggregate_supply'#0''| $$res@@48))
 :qid |boogiebpl.8074:15|
 :skolemid |447|
)))
(assert (forall ((bytes@@49 T@Vec_6673) ) (! (let (($$res@@49 (|$1_from_bcs_deserialize'$1_aptos_coin_AptosCoin'| bytes@@49)))
(|$IsValid'$1_aptos_coin_AptosCoin'| $$res@@49))
 :qid |boogiebpl.8080:15|
 :skolemid |448|
)))
(assert (forall ((bytes@@50 T@Vec_6673) ) (! (let (($$res@@50 (|$1_from_bcs_deserialize'$1_Bbay_Owner'| bytes@@50)))
(|$IsValid'$1_Bbay_Owner'| $$res@@50))
 :qid |boogiebpl.8086:15|
 :skolemid |449|
)))
(assert (forall ((bytes@@51 T@Vec_6673) ) (! (let (($$res@@51 (|$1_from_bcs_deserialize'$1_Bbay_Products'| bytes@@51)))
(|$IsValid'$1_Bbay_Products'| $$res@@51))
 :qid |boogiebpl.8092:15|
 :skolemid |450|
)))
(assert (forall ((bytes@@52 T@Vec_6673) ) (! (let (($$res@@52 (|$1_from_bcs_deserialize'$1_Bbay_ResourceAccountSignerCap'| bytes@@52)))
(|$IsValid'$1_Bbay_ResourceAccountSignerCap'| $$res@@52))
 :qid |boogiebpl.8098:15|
 :skolemid |451|
)))
(assert (forall ((bytes@@53 T@Vec_6673) ) (! (let (($$res@@53 (|$1_from_bcs_deserialize'$1_Bbay_User'| bytes@@53)))
(|$IsValid'$1_Bbay_User'| $$res@@53))
 :qid |boogiebpl.8104:15|
 :skolemid |452|
)))
(assert (forall ((bytes@@54 T@Vec_6673) ) (! true
 :qid |boogiebpl.8110:15|
 :skolemid |453|
)))
(assert (forall ((bytes@@55 T@Vec_6673) ) (! true
 :qid |boogiebpl.8116:15|
 :skolemid |454|
)))
(assert (forall ((bytes@@56 T@Vec_6673) ) (! true
 :qid |boogiebpl.8122:15|
 :skolemid |455|
)))
(assert (forall ((bytes@@57 T@Vec_6673) ) (! true
 :qid |boogiebpl.8128:15|
 :skolemid |456|
)))
(assert (forall ((bytes@@58 T@Vec_6673) ) (! true
 :qid |boogiebpl.8134:15|
 :skolemid |457|
)))
(assert (forall ((bytes@@59 T@Vec_6673) ) (! true
 :qid |boogiebpl.8140:15|
 :skolemid |458|
)))
(assert (forall ((bytes@@60 T@Vec_6673) ) (! true
 :qid |boogiebpl.8146:15|
 :skolemid |459|
)))
(assert (forall ((bytes@@61 T@Vec_6673) ) (! true
 :qid |boogiebpl.8152:15|
 :skolemid |460|
)))
(assert (forall ((bytes@@62 T@Vec_6673) ) (! true
 :qid |boogiebpl.8158:15|
 :skolemid |461|
)))
(assert (forall ((bytes@@63 T@Vec_6673) ) (! true
 :qid |boogiebpl.8164:15|
 :skolemid |462|
)))
(assert (forall ((bytes@@64 T@Vec_6673) ) (! true
 :qid |boogiebpl.8170:15|
 :skolemid |463|
)))
(assert (forall ((bytes@@65 T@Vec_6673) ) (! true
 :qid |boogiebpl.8176:15|
 :skolemid |464|
)))
(assert (forall ((bytes@@66 T@Vec_6673) ) (! true
 :qid |boogiebpl.8182:15|
 :skolemid |465|
)))
(assert (forall ((bytes@@67 T@Vec_6673) ) (! true
 :qid |boogiebpl.8188:15|
 :skolemid |466|
)))
(assert (forall ((bytes@@68 T@Vec_6673) ) (! true
 :qid |boogiebpl.8194:15|
 :skolemid |467|
)))
(assert (forall ((bytes@@69 T@Vec_6673) ) (! true
 :qid |boogiebpl.8200:15|
 :skolemid |468|
)))
(assert (forall ((bytes@@70 T@Vec_6673) ) (! true
 :qid |boogiebpl.8206:15|
 :skolemid |469|
)))
(assert (forall ((bytes@@71 T@Vec_6673) ) (! true
 :qid |boogiebpl.8212:15|
 :skolemid |470|
)))
(assert (forall ((bytes@@72 T@Vec_6673) ) (! true
 :qid |boogiebpl.8218:15|
 :skolemid |471|
)))
(assert (forall ((bytes@@73 T@Vec_6673) ) (! true
 :qid |boogiebpl.8224:15|
 :skolemid |472|
)))
(assert (forall ((bytes@@74 T@Vec_6673) ) (! true
 :qid |boogiebpl.8230:15|
 :skolemid |473|
)))
(assert (forall ((bytes@@75 T@Vec_6673) ) (! true
 :qid |boogiebpl.8236:15|
 :skolemid |474|
)))
(assert (forall ((bytes@@76 T@Vec_6673) ) (! true
 :qid |boogiebpl.8242:15|
 :skolemid |475|
)))
(assert (forall ((bytes@@77 T@Vec_6673) ) (! true
 :qid |boogiebpl.8248:15|
 :skolemid |476|
)))
(assert (forall ((bytes@@78 T@Vec_6673) ) (! true
 :qid |boogiebpl.8254:15|
 :skolemid |477|
)))
(assert (forall ((bytes@@79 T@Vec_6673) ) (! true
 :qid |boogiebpl.8260:15|
 :skolemid |478|
)))
(assert (forall ((bytes@@80 T@Vec_6673) ) (! true
 :qid |boogiebpl.8266:15|
 :skolemid |479|
)))
(assert (forall ((bytes@@81 T@Vec_6673) ) (! true
 :qid |boogiebpl.8272:15|
 :skolemid |480|
)))
(assert (forall ((bytes@@82 T@Vec_6673) ) (! true
 :qid |boogiebpl.8278:15|
 :skolemid |481|
)))
(assert (forall ((bytes@@83 T@Vec_6673) ) (! true
 :qid |boogiebpl.8284:15|
 :skolemid |482|
)))
(assert (forall ((bytes@@84 T@Vec_6673) ) (! true
 :qid |boogiebpl.8290:15|
 :skolemid |483|
)))
(assert (forall ((bytes@@85 T@Vec_6673) ) (! true
 :qid |boogiebpl.8296:15|
 :skolemid |484|
)))
(assert (forall ((bytes@@86 T@Vec_6673) ) (! true
 :qid |boogiebpl.8302:15|
 :skolemid |485|
)))
(assert (forall ((bytes@@87 T@Vec_6673) ) (! true
 :qid |boogiebpl.8308:15|
 :skolemid |486|
)))
(assert (forall ((bytes@@88 T@Vec_6673) ) (! true
 :qid |boogiebpl.8314:15|
 :skolemid |487|
)))
(assert (forall ((bytes@@89 T@Vec_6673) ) (! true
 :qid |boogiebpl.8320:15|
 :skolemid |488|
)))
(assert (forall ((bytes@@90 T@Vec_6673) ) (! true
 :qid |boogiebpl.8326:15|
 :skolemid |489|
)))
(assert (forall ((bytes@@91 T@Vec_6673) ) (! true
 :qid |boogiebpl.8332:15|
 :skolemid |490|
)))
(assert (forall ((bytes@@92 T@Vec_6673) ) (! true
 :qid |boogiebpl.8338:15|
 :skolemid |491|
)))
(assert (forall ((bytes@@93 T@Vec_6673) ) (! true
 :qid |boogiebpl.8344:15|
 :skolemid |492|
)))
(assert (forall ((bytes@@94 T@Vec_6673) ) (! true
 :qid |boogiebpl.8350:15|
 :skolemid |493|
)))
(assert (forall ((bytes@@95 T@Vec_6673) ) (! true
 :qid |boogiebpl.8356:15|
 :skolemid |494|
)))
(assert (forall ((bytes@@96 T@Vec_6673) ) (! true
 :qid |boogiebpl.8362:15|
 :skolemid |495|
)))
(assert (forall ((bytes@@97 T@Vec_6673) ) (! true
 :qid |boogiebpl.8368:15|
 :skolemid |496|
)))
(assert (forall ((bytes@@98 T@Vec_6673) ) (! true
 :qid |boogiebpl.8374:15|
 :skolemid |497|
)))
(assert (forall ((bytes@@99 T@Vec_6673) ) (! true
 :qid |boogiebpl.8380:15|
 :skolemid |498|
)))
(assert (forall ((bytes@@100 T@Vec_6673) ) (! true
 :qid |boogiebpl.8386:15|
 :skolemid |499|
)))
(assert (forall ((bytes@@101 T@Vec_6673) ) (! true
 :qid |boogiebpl.8392:15|
 :skolemid |500|
)))
(assert (forall ((bytes@@102 T@Vec_6673) ) (! true
 :qid |boogiebpl.8398:15|
 :skolemid |501|
)))
(assert (forall ((bytes@@103 T@Vec_6673) ) (! true
 :qid |boogiebpl.8404:15|
 :skolemid |502|
)))
(assert (forall ((bytes@@104 T@Vec_6673) ) (! true
 :qid |boogiebpl.8410:15|
 :skolemid |503|
)))
(assert (forall ((bytes@@105 T@Vec_6673) ) (! true
 :qid |boogiebpl.8416:15|
 :skolemid |504|
)))
(assert (forall ((bytes@@106 T@Vec_6673) ) (! true
 :qid |boogiebpl.8422:15|
 :skolemid |505|
)))
(assert (forall ((bytes@@107 T@Vec_6673) ) (! true
 :qid |boogiebpl.8428:15|
 :skolemid |506|
)))
(assert (forall ((bytes@@108 T@Vec_6673) ) (! true
 :qid |boogiebpl.8434:15|
 :skolemid |507|
)))
(assert (forall ((bytes@@109 T@Vec_6673) ) (! true
 :qid |boogiebpl.8440:15|
 :skolemid |508|
)))
(assert (forall ((bytes@@110 T@Vec_6673) ) (! true
 :qid |boogiebpl.8446:15|
 :skolemid |509|
)))
(assert (forall ((bytes@@111 T@Vec_6673) ) (! (let (($$res@@54 ($1_aptos_hash_spec_keccak256 bytes@@111)))
(|$IsValid'vec'u8''| $$res@@54))
 :qid |boogiebpl.13087:15|
 :skolemid |557|
)))
(assert (forall ((bytes@@112 T@Vec_6673) ) (! (let (($$res@@55 ($1_aptos_hash_spec_sha2_512_internal bytes@@112)))
(|$IsValid'vec'u8''| $$res@@55))
 :qid |boogiebpl.13093:15|
 :skolemid |558|
)))
(assert (forall ((bytes@@113 T@Vec_6673) ) (! (let (($$res@@56 ($1_aptos_hash_spec_sha3_512_internal bytes@@113)))
(|$IsValid'vec'u8''| $$res@@56))
 :qid |boogiebpl.13099:15|
 :skolemid |559|
)))
(assert (forall ((bytes@@114 T@Vec_6673) ) (! (let (($$res@@57 ($1_aptos_hash_spec_ripemd160_internal bytes@@114)))
(|$IsValid'vec'u8''| $$res@@57))
 :qid |boogiebpl.13105:15|
 :skolemid |560|
)))
(assert (forall ((bytes@@115 T@Vec_6673) ) (! (let (($$res@@58 ($1_aptos_hash_spec_blake2b_256_internal bytes@@115)))
(|$IsValid'vec'u8''| $$res@@58))
 :qid |boogiebpl.13111:15|
 :skolemid |561|
)))
(assert (forall ((t@@5 T@$TypeParamInfo) ) (!  (=> (is-$TypeParamAddress t@@5) (|$IsEqual'vec'u8''| ($TypeName t@@5) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 97) 1 100) 2 100) 3 114) 4 101) 5 115) 6 115) 7)))
 :qid |boogiebpl.6535:15|
 :skolemid |259|
 :pattern ( ($TypeName t@@5))
)))
(assert (forall ((k1@@0 Int) (k2@@0 Int) ) (! (= (= k1@@0 k2@@0) (= (|$EncodeKey'u64'| k1@@0) (|$EncodeKey'u64'| k2@@0)))
 :qid |boogiebpl.5818:10|
 :skolemid |212|
 :pattern ( (|$EncodeKey'u64'| k1@@0) (|$EncodeKey'u64'| k2@@0))
)))
(assert (forall ((k1@@1 Int) (k2@@1 Int) ) (! (= (= k1@@1 k2@@1) (= (|$EncodeKey'address'| k1@@1) (|$EncodeKey'address'| k2@@1)))
 :qid |boogiebpl.5828:10|
 :skolemid |213|
 :pattern ( (|$EncodeKey'address'| k1@@1) (|$EncodeKey'address'| k2@@1))
)))
(assert (forall ((t@@6 T@$TypeParamInfo) ) (!  (=> (is-$TypeParamVector t@@6) (|$IsEqual'vec'u8''| ($TypeName t@@6) (let ((m2@@0 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 62) 1))))
(let ((l2 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 62) 1))))
(let ((m1@@0 (|v#Vec_6673| (let ((m2@@1 (|v#Vec_6673| ($TypeName (|e#$TypeParamVector| t@@6)))))
(let ((l2@@0 (|l#Vec_6673| ($TypeName (|e#$TypeParamVector| t@@6)))))
(let ((m1@@1 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 118) 1 101) 2 99) 3 116) 4 111) 5 114) 6 60) 7))))
(let ((l1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 118) 1 101) 2 99) 3 116) 4 111) 5 114) 6 60) 7))))
(Vec_6673 (|lambda#16| 0 (+ l1 l2@@0) l1 m1@@1 m2@@1 l1 DefaultVecElem_25347) (+ l1 l2@@0)))))))))
(let ((l1@@0 (|l#Vec_6673| (let ((m2@@1 (|v#Vec_6673| ($TypeName (|e#$TypeParamVector| t@@6)))))
(let ((l2@@0 (|l#Vec_6673| ($TypeName (|e#$TypeParamVector| t@@6)))))
(let ((m1@@1 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 118) 1 101) 2 99) 3 116) 4 111) 5 114) 6 60) 7))))
(let ((l1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 118) 1 101) 2 99) 3 116) 4 111) 5 114) 6 60) 7))))
(Vec_6673 (|lambda#16| 0 (+ l1 l2@@0) l1 m1@@1 m2@@1 l1 DefaultVecElem_25347) (+ l1 l2@@0)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@0 l2) l1@@0 m1@@0 m2@@0 l1@@0 DefaultVecElem_25347) (+ l1@@0 l2))))))))
 :qid |boogiebpl.6539:15|
 :skolemid |263|
 :pattern ( ($TypeName t@@6))
)))
(assert (forall ((t@@7 T@Table_37064_126051) ) (!  (=> (exists ((k@@9 Int) ) (! (|Select__T@[Int]Bool_| (|e#Table_37064_126051| t@@7) k@@9)
 :qid |boogiebpl.231:13|
 :skolemid |6|
 :pattern ( (|Select__T@[Int]Bool_| (|e#Table_37064_126051| t@@7) k@@9))
)) (>= (|l#Table_37064_126051| t@@7) 1))
 :qid |boogiebpl.230:36|
 :skolemid |7|
 :pattern ( (|l#Table_37064_126051| t@@7))
)))
(assert (forall ((t@@8 T@Table_36177_36178) ) (!  (=> (exists ((k@@10 Int) ) (! (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t@@8) k@@10)
 :qid |boogiebpl.231:13|
 :skolemid |6|
 :pattern ( (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t@@8) k@@10))
)) (>= (|l#Table_36177_36178| t@@8) 1))
 :qid |boogiebpl.230:36|
 :skolemid |7|
 :pattern ( (|l#Table_36177_36178| t@@8))
)))
(assert (forall ((t@@9 T@Table_35290_35291) ) (!  (=> (exists ((k@@11 Int) ) (! (|Select__T@[Int]Bool_| (|e#Table_35290_35291| t@@9) k@@11)
 :qid |boogiebpl.231:13|
 :skolemid |6|
 :pattern ( (|Select__T@[Int]Bool_| (|e#Table_35290_35291| t@@9) k@@11))
)) (>= (|l#Table_35290_35291| t@@9) 1))
 :qid |boogiebpl.230:36|
 :skolemid |7|
 :pattern ( (|l#Table_35290_35291| t@@9))
)))
(assert (forall ((t@@10 T@$TypeParamInfo) ) (!  (=> (|$IsEqual'vec'u8''| ($TypeName t@@10) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 98) 1 111) 2 111) 3 108) 4)) (is-$TypeParamBool t@@10))
 :qid |boogiebpl.6522:15|
 :skolemid |246|
 :pattern ( ($TypeName t@@10))
)))
(assert (forall ((src1@@2 (_ BitVec 8)) (src2 (_ BitVec 16)) ) (! (= ($shlBv8From16 src1@@2 src2) (bvshl src1@@2 ((_ extract 7 0) src2)))
 :qid |boogiebpl.1583:24|
 :skolemid |43|
 :pattern ( ($shlBv8From16 src1@@2 src2))
)))
(assert (forall ((src1@@3 (_ BitVec 8)) (src2@@0 (_ BitVec 16)) ) (! (= ($shrBv8From16 src1@@3 src2@@0) (bvlshr src1@@3 ((_ extract 7 0) src2@@0)))
 :qid |boogiebpl.1597:24|
 :skolemid |44|
 :pattern ( ($shrBv8From16 src1@@3 src2@@0))
)))
(assert (forall ((src1@@4 (_ BitVec 8)) (src2@@1 (_ BitVec 32)) ) (! (= ($shlBv8From32 src1@@4 src2@@1) (bvshl src1@@4 ((_ extract 7 0) src2@@1)))
 :qid |boogiebpl.1621:24|
 :skolemid |45|
 :pattern ( ($shlBv8From32 src1@@4 src2@@1))
)))
(assert (forall ((src1@@5 (_ BitVec 8)) (src2@@2 (_ BitVec 32)) ) (! (= ($shrBv8From32 src1@@5 src2@@2) (bvlshr src1@@5 ((_ extract 7 0) src2@@2)))
 :qid |boogiebpl.1635:24|
 :skolemid |46|
 :pattern ( ($shrBv8From32 src1@@5 src2@@2))
)))
(assert (forall ((src1@@6 (_ BitVec 8)) (src2@@3 (_ BitVec 64)) ) (! (= ($shlBv8From64 src1@@6 src2@@3) (bvshl src1@@6 ((_ extract 7 0) src2@@3)))
 :qid |boogiebpl.1659:24|
 :skolemid |47|
 :pattern ( ($shlBv8From64 src1@@6 src2@@3))
)))
(assert (forall ((src1@@7 (_ BitVec 8)) (src2@@4 (_ BitVec 64)) ) (! (= ($shrBv8From64 src1@@7 src2@@4) (bvlshr src1@@7 ((_ extract 7 0) src2@@4)))
 :qid |boogiebpl.1673:24|
 :skolemid |48|
 :pattern ( ($shrBv8From64 src1@@7 src2@@4))
)))
(assert (forall ((src1@@8 (_ BitVec 8)) (src2@@5 (_ BitVec 128)) ) (! (= ($shlBv8From128 src1@@8 src2@@5) (bvshl src1@@8 ((_ extract 7 0) src2@@5)))
 :qid |boogiebpl.1697:25|
 :skolemid |49|
 :pattern ( ($shlBv8From128 src1@@8 src2@@5))
)))
(assert (forall ((src1@@9 (_ BitVec 8)) (src2@@6 (_ BitVec 128)) ) (! (= ($shrBv8From128 src1@@9 src2@@6) (bvlshr src1@@9 ((_ extract 7 0) src2@@6)))
 :qid |boogiebpl.1711:25|
 :skolemid |50|
 :pattern ( ($shrBv8From128 src1@@9 src2@@6))
)))
(assert (forall ((src1@@10 (_ BitVec 8)) (src2@@7 (_ BitVec 256)) ) (! (= ($shlBv8From256 src1@@10 src2@@7) (bvshl src1@@10 ((_ extract 7 0) src2@@7)))
 :qid |boogiebpl.1735:25|
 :skolemid |51|
 :pattern ( ($shlBv8From256 src1@@10 src2@@7))
)))
(assert (forall ((src1@@11 (_ BitVec 8)) (src2@@8 (_ BitVec 256)) ) (! (= ($shrBv8From256 src1@@11 src2@@8) (bvlshr src1@@11 ((_ extract 7 0) src2@@8)))
 :qid |boogiebpl.1749:25|
 :skolemid |52|
 :pattern ( ($shrBv8From256 src1@@11 src2@@8))
)))
(assert (forall ((src1@@12 (_ BitVec 16)) (src2@@9 (_ BitVec 32)) ) (! (= ($shlBv16From32 src1@@12 src2@@9) (bvshl src1@@12 ((_ extract 15 0) src2@@9)))
 :qid |boogiebpl.1841:25|
 :skolemid |57|
 :pattern ( ($shlBv16From32 src1@@12 src2@@9))
)))
(assert (forall ((src1@@13 (_ BitVec 16)) (src2@@10 (_ BitVec 32)) ) (! (= ($shrBv16From32 src1@@13 src2@@10) (bvlshr src1@@13 ((_ extract 15 0) src2@@10)))
 :qid |boogiebpl.1855:25|
 :skolemid |58|
 :pattern ( ($shrBv16From32 src1@@13 src2@@10))
)))
(assert (forall ((src1@@14 (_ BitVec 16)) (src2@@11 (_ BitVec 64)) ) (! (= ($shlBv16From64 src1@@14 src2@@11) (bvshl src1@@14 ((_ extract 15 0) src2@@11)))
 :qid |boogiebpl.1879:25|
 :skolemid |59|
 :pattern ( ($shlBv16From64 src1@@14 src2@@11))
)))
(assert (forall ((src1@@15 (_ BitVec 16)) (src2@@12 (_ BitVec 64)) ) (! (= ($shrBv16From64 src1@@15 src2@@12) (bvlshr src1@@15 ((_ extract 15 0) src2@@12)))
 :qid |boogiebpl.1893:25|
 :skolemid |60|
 :pattern ( ($shrBv16From64 src1@@15 src2@@12))
)))
(assert (forall ((src1@@16 (_ BitVec 16)) (src2@@13 (_ BitVec 128)) ) (! (= ($shlBv16From128 src1@@16 src2@@13) (bvshl src1@@16 ((_ extract 15 0) src2@@13)))
 :qid |boogiebpl.1917:26|
 :skolemid |61|
 :pattern ( ($shlBv16From128 src1@@16 src2@@13))
)))
(assert (forall ((src1@@17 (_ BitVec 16)) (src2@@14 (_ BitVec 128)) ) (! (= ($shrBv16From128 src1@@17 src2@@14) (bvlshr src1@@17 ((_ extract 15 0) src2@@14)))
 :qid |boogiebpl.1931:26|
 :skolemid |62|
 :pattern ( ($shrBv16From128 src1@@17 src2@@14))
)))
(assert (forall ((src1@@18 (_ BitVec 16)) (src2@@15 (_ BitVec 256)) ) (! (= ($shlBv16From256 src1@@18 src2@@15) (bvshl src1@@18 ((_ extract 15 0) src2@@15)))
 :qid |boogiebpl.1955:26|
 :skolemid |63|
 :pattern ( ($shlBv16From256 src1@@18 src2@@15))
)))
(assert (forall ((src1@@19 (_ BitVec 16)) (src2@@16 (_ BitVec 256)) ) (! (= ($shrBv16From256 src1@@19 src2@@16) (bvlshr src1@@19 ((_ extract 15 0) src2@@16)))
 :qid |boogiebpl.1969:26|
 :skolemid |64|
 :pattern ( ($shrBv16From256 src1@@19 src2@@16))
)))
(assert (forall ((src1@@20 (_ BitVec 32)) (src2@@17 (_ BitVec 64)) ) (! (= ($shlBv32From64 src1@@20 src2@@17) (bvshl src1@@20 ((_ extract 31 0) src2@@17)))
 :qid |boogiebpl.2095:25|
 :skolemid |71|
 :pattern ( ($shlBv32From64 src1@@20 src2@@17))
)))
(assert (forall ((src1@@21 (_ BitVec 32)) (src2@@18 (_ BitVec 64)) ) (! (= ($shrBv32From64 src1@@21 src2@@18) (bvlshr src1@@21 ((_ extract 31 0) src2@@18)))
 :qid |boogiebpl.2109:25|
 :skolemid |72|
 :pattern ( ($shrBv32From64 src1@@21 src2@@18))
)))
(assert (forall ((src1@@22 (_ BitVec 32)) (src2@@19 (_ BitVec 128)) ) (! (= ($shlBv32From128 src1@@22 src2@@19) (bvshl src1@@22 ((_ extract 31 0) src2@@19)))
 :qid |boogiebpl.2133:26|
 :skolemid |73|
 :pattern ( ($shlBv32From128 src1@@22 src2@@19))
)))
(assert (forall ((src1@@23 (_ BitVec 32)) (src2@@20 (_ BitVec 128)) ) (! (= ($shrBv32From128 src1@@23 src2@@20) (bvlshr src1@@23 ((_ extract 31 0) src2@@20)))
 :qid |boogiebpl.2147:26|
 :skolemid |74|
 :pattern ( ($shrBv32From128 src1@@23 src2@@20))
)))
(assert (forall ((src1@@24 (_ BitVec 32)) (src2@@21 (_ BitVec 256)) ) (! (= ($shlBv32From256 src1@@24 src2@@21) (bvshl src1@@24 ((_ extract 31 0) src2@@21)))
 :qid |boogiebpl.2171:26|
 :skolemid |75|
 :pattern ( ($shlBv32From256 src1@@24 src2@@21))
)))
(assert (forall ((src1@@25 (_ BitVec 32)) (src2@@22 (_ BitVec 256)) ) (! (= ($shrBv32From256 src1@@25 src2@@22) (bvlshr src1@@25 ((_ extract 31 0) src2@@22)))
 :qid |boogiebpl.2185:26|
 :skolemid |76|
 :pattern ( ($shrBv32From256 src1@@25 src2@@22))
)))
(assert (forall ((src1@@26 (_ BitVec 64)) (src2@@23 (_ BitVec 128)) ) (! (= ($shlBv64From128 src1@@26 src2@@23) (bvshl src1@@26 ((_ extract 63 0) src2@@23)))
 :qid |boogiebpl.2345:26|
 :skolemid |85|
 :pattern ( ($shlBv64From128 src1@@26 src2@@23))
)))
(assert (forall ((src1@@27 (_ BitVec 64)) (src2@@24 (_ BitVec 128)) ) (! (= ($shrBv64From128 src1@@27 src2@@24) (bvlshr src1@@27 ((_ extract 63 0) src2@@24)))
 :qid |boogiebpl.2359:26|
 :skolemid |86|
 :pattern ( ($shrBv64From128 src1@@27 src2@@24))
)))
(assert (forall ((src1@@28 (_ BitVec 64)) (src2@@25 (_ BitVec 256)) ) (! (= ($shlBv64From256 src1@@28 src2@@25) (bvshl src1@@28 ((_ extract 63 0) src2@@25)))
 :qid |boogiebpl.2383:26|
 :skolemid |87|
 :pattern ( ($shlBv64From256 src1@@28 src2@@25))
)))
(assert (forall ((src1@@29 (_ BitVec 64)) (src2@@26 (_ BitVec 256)) ) (! (= ($shrBv64From256 src1@@29 src2@@26) (bvlshr src1@@29 ((_ extract 63 0) src2@@26)))
 :qid |boogiebpl.2397:26|
 :skolemid |88|
 :pattern ( ($shrBv64From256 src1@@29 src2@@26))
)))
(assert (forall ((src1@@30 (_ BitVec 128)) (src2@@27 (_ BitVec 256)) ) (! (= ($shlBv128From256 src1@@30 src2@@27) (bvshl src1@@30 ((_ extract 127 0) src2@@27)))
 :qid |boogiebpl.2591:27|
 :skolemid |99|
 :pattern ( ($shlBv128From256 src1@@30 src2@@27))
)))
(assert (forall ((src1@@31 (_ BitVec 128)) (src2@@28 (_ BitVec 256)) ) (! (= ($shrBv128From256 src1@@31 src2@@28) (bvlshr src1@@31 ((_ extract 127 0) src2@@28)))
 :qid |boogiebpl.2605:27|
 :skolemid |100|
 :pattern ( ($shrBv128From256 src1@@31 src2@@28))
)))
(assert (forall ((src1@@32 Int) (p@@2 Int) ) (! (= ($shlU8 src1@@32 p@@2) (mod (* src1@@32 ($pow 2 p@@2)) 256))
 :qid |boogiebpl.1495:17|
 :skolemid |34|
 :pattern ( ($shlU8 src1@@32 p@@2))
)))
(assert (forall ((src1@@33 Int) (p@@3 Int) ) (! (= ($shlU32 src1@@33 p@@3) (mod (* src1@@33 ($pow 2 p@@3)) 4294967296))
 :qid |boogiebpl.1503:18|
 :skolemid |36|
 :pattern ( ($shlU32 src1@@33 p@@3))
)))
(assert (forall ((src1@@34 Int) (p@@4 Int) ) (! (= ($shlU16 src1@@34 p@@4) (mod (* src1@@34 ($pow 2 p@@4)) 65536))
 :qid |boogiebpl.1499:18|
 :skolemid |35|
 :pattern ( ($shlU16 src1@@34 p@@4))
)))
(assert (forall ((src1@@35 Int) (p@@5 Int) ) (! (= ($shlU64 src1@@35 p@@5) (mod (* src1@@35 ($pow 2 p@@5)) 18446744073709551616))
 :qid |boogiebpl.1507:18|
 :skolemid |37|
 :pattern ( ($shlU64 src1@@35 p@@5))
)))
(assert (forall ((s@@14 T@$1_Bbay_Products) ) (! (= (|$IsValid'$1_Bbay_Products'| s@@14)  (and (and (and (and (and (|$IsValid'$1_table_Table'u64_u64''| (|$sr_number#$1_Bbay_Products| s@@14)) (|$IsValid'vec'u64''| (|$item_id#$1_Bbay_Products| s@@14))) (|$IsValid'$1_table_Table'u64_vec'u64'''| (|$item_name#$1_Bbay_Products| s@@14))) (|$IsValid'$1_table_Table'u64_bool''| (|$item_sold#$1_Bbay_Products| s@@14))) (|$IsValid'$1_table_Table'u64_u64''| (|$item_price#$1_Bbay_Products| s@@14))) (|$IsValid'$1_table_Table'u64_bool''| (|$item_on_selling#$1_Bbay_Products| s@@14))))
 :qid |boogiebpl.11538:37|
 :skolemid |532|
 :pattern ( (|$IsValid'$1_Bbay_Products'| s@@14))
)))
(assert (forall ((t@@11 T@$TypeParamInfo) ) (!  (=> (and (|$IsPrefix'vec'u8''| ($TypeName t@@11) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 118) 1 101) 2 99) 3 116) 4 111) 5 114) 6 60) 7)) (|$IsSuffix'vec'u8''| ($TypeName t@@11) (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 62) 1))) (is-$TypeParamVector t@@11))
 :qid |boogiebpl.6540:15|
 :skolemid |264|
 :pattern ( ($TypeName t@@11))
)))
(assert (forall ((t@@12 T@$TypeParamInfo) ) (!  (=> (|$IsEqual'vec'u8''| ($TypeName t@@12) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 115) 1 105) 2 103) 3 110) 4 101) 5 114) 6)) (is-$TypeParamSigner t@@12))
 :qid |boogiebpl.6538:15|
 :skolemid |262|
 :pattern ( ($TypeName t@@12))
)))
(assert (forall ((v@@27 T@Vec_85428) ) (! (= (|$IsValid'vec'#0''| v@@27)  (and (|$IsValid'u64'| (|l#Vec_85428| v@@27)) (forall ((i@@54 Int) ) (!  (=> (InRangeVec_65852 v@@27 i@@54) true)
 :qid |boogiebpl.3098:13|
 :skolemid |119|
))))
 :qid |boogiebpl.3096:28|
 :skolemid |120|
 :pattern ( (|$IsValid'vec'#0''| v@@27))
)))
(assert (forall ((v@@28 T@Vec_90390) ) (! (= (|$IsValid'vec'$1_aggregator_Aggregator''| v@@28)  (and (|$IsValid'u64'| (|l#Vec_90390| v@@28)) (forall ((i@@55 Int) ) (!  (=> (InRangeVec_66199 v@@28 i@@55) (|$IsValid'$1_aggregator_Aggregator'| (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| v@@28) i@@55)))
 :qid |boogiebpl.3402:13|
 :skolemid |130|
))))
 :qid |boogiebpl.3400:50|
 :skolemid |131|
 :pattern ( (|$IsValid'vec'$1_aggregator_Aggregator''| v@@28))
)))
(assert (forall ((v@@29 T@Vec_95276) ) (! (= (|$IsValid'vec'$1_optional_aggregator_Integer''| v@@29)  (and (|$IsValid'u64'| (|l#Vec_95276| v@@29)) (forall ((i@@56 Int) ) (!  (=> (InRangeVec_66546 v@@29 i@@56) (|$IsValid'$1_optional_aggregator_Integer'| (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| v@@29) i@@56)))
 :qid |boogiebpl.3706:13|
 :skolemid |141|
))))
 :qid |boogiebpl.3704:56|
 :skolemid |142|
 :pattern ( (|$IsValid'vec'$1_optional_aggregator_Integer''| v@@29))
)))
(assert (forall ((v@@30 T@Vec_100175) ) (! (= (|$IsValid'vec'$1_optional_aggregator_OptionalAggregator''| v@@30)  (and (|$IsValid'u64'| (|l#Vec_100175| v@@30)) (forall ((i@@57 Int) ) (!  (=> (InRangeVec_66893 v@@30 i@@57) (|$IsValid'$1_optional_aggregator_OptionalAggregator'| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@30) i@@57)))
 :qid |boogiebpl.4010:13|
 :skolemid |152|
))))
 :qid |boogiebpl.4008:67|
 :skolemid |153|
 :pattern ( (|$IsValid'vec'$1_optional_aggregator_OptionalAggregator''| v@@30))
)))
(assert (forall ((v@@31 T@Vec_6673) ) (! (= (|$IsValid'vec'address''| v@@31)  (and (|$IsValid'u64'| (|l#Vec_6673| v@@31)) (forall ((i@@58 Int) ) (!  (=> (InRangeVec_25002 v@@31 i@@58) (|$IsValid'address'| (|Select__T@[Int]Int_| (|v#Vec_6673| v@@31) i@@58)))
 :qid |boogiebpl.4314:13|
 :skolemid |163|
))))
 :qid |boogiebpl.4312:33|
 :skolemid |164|
 :pattern ( (|$IsValid'vec'address''| v@@31))
)))
(assert (forall ((v@@32 T@Vec_6673) ) (! (= (|$IsValid'vec'u64''| v@@32)  (and (|$IsValid'u64'| (|l#Vec_6673| v@@32)) (forall ((i@@59 Int) ) (!  (=> (InRangeVec_25002 v@@32 i@@59) (|$IsValid'u64'| (|Select__T@[Int]Int_| (|v#Vec_6673| v@@32) i@@59)))
 :qid |boogiebpl.4618:13|
 :skolemid |174|
))))
 :qid |boogiebpl.4616:29|
 :skolemid |175|
 :pattern ( (|$IsValid'vec'u64''| v@@32))
)))
(assert (forall ((v@@33 T@Vec_6673) ) (! (= (|$IsValid'vec'u8''| v@@33)  (and (|$IsValid'u64'| (|l#Vec_6673| v@@33)) (forall ((i@@60 Int) ) (!  (=> (InRangeVec_25002 v@@33 i@@60) (|$IsValid'u8'| (|Select__T@[Int]Int_| (|v#Vec_6673| v@@33) i@@60)))
 :qid |boogiebpl.4922:13|
 :skolemid |185|
))))
 :qid |boogiebpl.4920:28|
 :skolemid |186|
 :pattern ( (|$IsValid'vec'u8''| v@@33))
)))
(assert (forall ((v@@34 T@Vec_67815) ) (! (= (|$IsValid'vec'bv64''| v@@34)  (and (|$IsValid'u64'| (|l#Vec_67815| v@@34)) (forall ((i@@61 Int) ) (!  (=> (InRangeVec_67819 v@@34 i@@61) (|$IsValid'bv64'| (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| v@@34) i@@61)))
 :qid |boogiebpl.5226:13|
 :skolemid |196|
))))
 :qid |boogiebpl.5224:30|
 :skolemid |197|
 :pattern ( (|$IsValid'vec'bv64''| v@@34))
)))
(assert (forall ((v@@35 T@Vec_68162) ) (! (= (|$IsValid'vec'bv8''| v@@35)  (and (|$IsValid'u64'| (|l#Vec_68162| v@@35)) (forall ((i@@62 Int) ) (!  (=> (InRangeVec_68166 v@@35 i@@62) (|$IsValid'bv8'| (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| v@@35) i@@62)))
 :qid |boogiebpl.5530:13|
 :skolemid |207|
))))
 :qid |boogiebpl.5528:29|
 :skolemid |208|
 :pattern ( (|$IsValid'vec'bv8''| v@@35))
)))
(assert (forall ((t@@13 T@Table_35290_35291) ) (! (= (|$IsValid'$1_table_Table'u64_bool''| t@@13)  (and (|$IsValid'u64'| (|l#Table_35290_35291| t@@13)) (forall ((i@@63 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_35290_35291| t@@13) i@@63) true)
 :qid |boogiebpl.5846:13|
 :skolemid |218|
))))
 :qid |boogiebpl.5844:45|
 :skolemid |219|
 :pattern ( (|$IsValid'$1_table_Table'u64_bool''| t@@13))
)))
(assert (forall ((t@@14 T@Table_36177_36178) ) (! (= (|$IsValid'$1_table_Table'u64_u64''| t@@14)  (and (|$IsValid'u64'| (|l#Table_36177_36178| t@@14)) (forall ((i@@64 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t@@14) i@@64) (|$IsValid'u64'| (|Select__T@[Int]Int_| (|v#Table_36177_36178| t@@14) i@@64)))
 :qid |boogiebpl.5964:13|
 :skolemid |224|
))))
 :qid |boogiebpl.5962:44|
 :skolemid |225|
 :pattern ( (|$IsValid'$1_table_Table'u64_u64''| t@@14))
)))
(assert (forall ((t@@15 T@Table_37064_126051) ) (! (= (|$IsValid'$1_table_Table'u64_vec'u64'''| t@@15)  (and (|$IsValid'u64'| (|l#Table_37064_126051| t@@15)) (forall ((i@@65 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_37064_126051| t@@15) i@@65) (|$IsValid'vec'u64''| (|Select__T@[Int]Vec_6673_| (|v#Table_37064_126051| t@@15) i@@65)))
 :qid |boogiebpl.6082:13|
 :skolemid |230|
))))
 :qid |boogiebpl.6080:49|
 :skolemid |231|
 :pattern ( (|$IsValid'$1_table_Table'u64_vec'u64'''| t@@15))
)))
(assert (forall ((t@@16 T@Table_36177_36178) ) (! (= (|$IsValid'$1_table_Table'address_address''| t@@16)  (and (|$IsValid'u64'| (|l#Table_36177_36178| t@@16)) (forall ((i@@66 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t@@16) i@@66) (|$IsValid'address'| (|Select__T@[Int]Int_| (|v#Table_36177_36178| t@@16) i@@66)))
 :qid |boogiebpl.6200:13|
 :skolemid |236|
))))
 :qid |boogiebpl.6198:52|
 :skolemid |237|
 :pattern ( (|$IsValid'$1_table_Table'address_address''| t@@16))
)))
(assert (forall ((|l#0@@27| Bool) (i@@67 Int) ) (! (= (|Select__T@[Int]Bool_| (|lambda#28| |l#0@@27|) i@@67) |l#0@@27|)
 :qid |boogiebpl.194:57|
 :skolemid |590|
 :pattern ( (|Select__T@[Int]Bool_| (|lambda#28| |l#0@@27|) i@@67))
)))
(assert (forall ((v@@36 Int) ) (! (= (|$IsValid'num'| v@@36) true)
 :qid |boogiebpl.1105:24|
 :skolemid |26|
 :pattern ( (|$IsValid'num'| v@@36))
)))
(assert (forall ((t@@17 T@$TypeParamInfo) ) (!  (=> (is-$TypeParamU8 t@@17) (|$IsEqual'vec'u8''| ($TypeName t@@17) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 56) 2)))
 :qid |boogiebpl.6523:15|
 :skolemid |247|
 :pattern ( ($TypeName t@@17))
)))
(assert (forall ((src1@@36 Int) (p@@6 Int) ) (! (= ($shlU128 src1@@36 p@@6) (mod (* src1@@36 ($pow 2 p@@6)) 340282366920938463463374607431768211456))
 :qid |boogiebpl.1511:19|
 :skolemid |38|
 :pattern ( ($shlU128 src1@@36 p@@6))
)))
(assert (forall ((n Int) (e@@6 Int) ) (! (= ($pow n e@@6) (ite  (and (not (= n 0)) (= e@@6 0)) 1 (ite (> e@@6 0) (* n ($pow n (- e@@6 1))) $undefined_int)))
 :qid |boogiebpl.1485:15|
 :skolemid |32|
 :pattern ( ($pow n e@@6))
)))
(assert (forall ((t@@18 T@$TypeParamInfo) ) (!  (=> (|$IsPrefix'vec'u8''| ($TypeName t@@18) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2)) (is-$TypeParamVector t@@18))
 :qid |boogiebpl.6542:15|
 :skolemid |266|
 :pattern ( ($TypeName t@@18))
)))
(assert (forall ((t@@19 T@$TypeParamInfo) ) (!  (=> (|$IsEqual'vec'u8''| ($TypeName t@@19) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 56) 2)) (is-$TypeParamU8 t@@19))
 :qid |boogiebpl.6524:15|
 :skolemid |248|
 :pattern ( ($TypeName t@@19))
)))
(assert (forall ((s@@15 |T@$1_option_Option'address'|) ) (! (= (|$IsValid'$1_option_Option'address''| s@@15) (|$IsValid'vec'address''| (|$vec#$1_option_Option'address'| s@@15)))
 :qid |boogiebpl.7025:46|
 :skolemid |384|
 :pattern ( (|$IsValid'$1_option_Option'address''| s@@15))
)))
(assert (forall ((s@@16 |T@$1_option_Option'$1_aggregator_Aggregator'|) ) (! (= (|$IsValid'$1_option_Option'$1_aggregator_Aggregator''| s@@16) (|$IsValid'vec'$1_aggregator_Aggregator''| (|$vec#$1_option_Option'$1_aggregator_Aggregator'| s@@16)))
 :qid |boogiebpl.7038:63|
 :skolemid |385|
 :pattern ( (|$IsValid'$1_option_Option'$1_aggregator_Aggregator''| s@@16))
)))
(assert (forall ((s@@17 |T@$1_option_Option'$1_optional_aggregator_Integer'|) ) (! (= (|$IsValid'$1_option_Option'$1_optional_aggregator_Integer''| s@@17) (|$IsValid'vec'$1_optional_aggregator_Integer''| (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| s@@17)))
 :qid |boogiebpl.7051:69|
 :skolemid |386|
 :pattern ( (|$IsValid'$1_option_Option'$1_optional_aggregator_Integer''| s@@17))
)))
(assert (forall ((s@@18 |T@$1_option_Option'$1_optional_aggregator_OptionalAggregator'|) ) (! (= (|$IsValid'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| s@@18) (|$IsValid'vec'$1_optional_aggregator_OptionalAggregator''| (|$vec#$1_option_Option'$1_optional_aggregator_OptionalAggregator'| s@@18)))
 :qid |boogiebpl.7064:80|
 :skolemid |387|
 :pattern ( (|$IsValid'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| s@@18))
)))
(assert (forall ((s@@19 T@$1_string_String) ) (! (= (|$IsValid'$1_string_String'| s@@19) (|$IsValid'vec'u8''| (|$bytes#$1_string_String| s@@19)))
 :qid |boogiebpl.7077:37|
 :skolemid |388|
 :pattern ( (|$IsValid'$1_string_String'| s@@19))
)))
(assert (forall ((s@@20 T@$1_guid_GUID) ) (! (= (|$IsValid'$1_guid_GUID'| s@@20) (|$IsValid'$1_guid_ID'| (|$id#$1_guid_GUID| s@@20)))
 :qid |boogiebpl.7437:33|
 :skolemid |392|
 :pattern ( (|$IsValid'$1_guid_GUID'| s@@20))
)))
(assert (forall ((s@@21 |T@$1_account_CapabilityOffer'$1_account_RotationCapability'|) ) (! (= (|$IsValid'$1_account_CapabilityOffer'$1_account_RotationCapability''| s@@21) (|$IsValid'$1_option_Option'address''| (|$for#$1_account_CapabilityOffer'$1_account_RotationCapability'| s@@21)))
 :qid |boogiebpl.8507:78|
 :skolemid |512|
 :pattern ( (|$IsValid'$1_account_CapabilityOffer'$1_account_RotationCapability''| s@@21))
)))
(assert (forall ((s@@22 |T@$1_account_CapabilityOffer'$1_account_SignerCapability'|) ) (! (= (|$IsValid'$1_account_CapabilityOffer'$1_account_SignerCapability''| s@@22) (|$IsValid'$1_option_Option'address''| (|$for#$1_account_CapabilityOffer'$1_account_SignerCapability'| s@@22)))
 :qid |boogiebpl.8520:76|
 :skolemid |513|
 :pattern ( (|$IsValid'$1_account_CapabilityOffer'$1_account_SignerCapability''| s@@22))
)))
(assert (forall ((s@@23 T@$1_account_CoinRegisterEvent) ) (! (= (|$IsValid'$1_account_CoinRegisterEvent'| s@@23) (|$IsValid'$1_type_info_TypeInfo'| (|$type_info#$1_account_CoinRegisterEvent| s@@23)))
 :qid |boogiebpl.8533:49|
 :skolemid |514|
 :pattern ( (|$IsValid'$1_account_CoinRegisterEvent'| s@@23))
)))
(assert (forall ((s@@24 T@$1_account_RotationCapability) ) (! (= (|$IsValid'$1_account_RotationCapability'| s@@24) (|$IsValid'address'| (|$account#$1_account_RotationCapability| s@@24)))
 :qid |boogiebpl.8564:50|
 :skolemid |516|
 :pattern ( (|$IsValid'$1_account_RotationCapability'| s@@24))
)))
(assert (forall ((s@@25 T@$1_account_SignerCapability) ) (! (= (|$IsValid'$1_account_SignerCapability'| s@@25) (|$IsValid'address'| (|$account#$1_account_SignerCapability| s@@25)))
 :qid |boogiebpl.8578:48|
 :skolemid |517|
 :pattern ( (|$IsValid'$1_account_SignerCapability'| s@@25))
)))
(assert (forall ((s@@26 |T@$1_coin_Coin'$1_aptos_coin_AptosCoin'|) ) (! (= (|$IsValid'$1_coin_Coin'$1_aptos_coin_AptosCoin''| s@@26) (|$IsValid'u64'| (|$value#$1_coin_Coin'$1_aptos_coin_AptosCoin'| s@@26)))
 :qid |boogiebpl.10007:58|
 :skolemid |518|
 :pattern ( (|$IsValid'$1_coin_Coin'$1_aptos_coin_AptosCoin''| s@@26))
)))
(assert (forall ((s@@27 |T@$1_coin_Coin'#0'|) ) (! (= (|$IsValid'$1_coin_Coin'#0''| s@@27) (|$IsValid'u64'| (|$value#$1_coin_Coin'#0'| s@@27)))
 :qid |boogiebpl.10021:37|
 :skolemid |519|
 :pattern ( (|$IsValid'$1_coin_Coin'#0''| s@@27))
)))
(assert (forall ((s@@28 T@$1_coin_DepositEvent) ) (! (= (|$IsValid'$1_coin_DepositEvent'| s@@28) (|$IsValid'u64'| (|$amount#$1_coin_DepositEvent| s@@28)))
 :qid |boogiebpl.10147:41|
 :skolemid |524|
 :pattern ( (|$IsValid'$1_coin_DepositEvent'| s@@28))
)))
(assert (forall ((s@@29 T@$1_coin_WithdrawEvent) ) (! (= (|$IsValid'$1_coin_WithdrawEvent'| s@@29) (|$IsValid'u64'| (|$amount#$1_coin_WithdrawEvent| s@@29)))
 :qid |boogiebpl.10161:42|
 :skolemid |525|
 :pattern ( (|$IsValid'$1_coin_WithdrawEvent'| s@@29))
)))
(assert (forall ((s@@30 |T@$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'|) ) (! (= (|$IsValid'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''| s@@30) (|$IsValid'num'| (|$v#$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'| s@@30)))
 :qid |boogiebpl.10175:66|
 :skolemid |526|
 :pattern ( (|$IsValid'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''| s@@30))
)))
(assert (forall ((s@@31 |T@$1_coin_Ghost$supply'#0'|) ) (! (= (|$IsValid'$1_coin_Ghost$supply'#0''| s@@31) (|$IsValid'num'| (|$v#$1_coin_Ghost$supply'#0'| s@@31)))
 :qid |boogiebpl.10190:45|
 :skolemid |527|
 :pattern ( (|$IsValid'$1_coin_Ghost$supply'#0''| s@@31))
)))
(assert (forall ((s@@32 |T@$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'|) ) (! (= (|$IsValid'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''| s@@32) (|$IsValid'num'| (|$v#$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'| s@@32)))
 :qid |boogiebpl.10205:76|
 :skolemid |528|
 :pattern ( (|$IsValid'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''| s@@32))
)))
(assert (forall ((s@@33 |T@$1_coin_Ghost$aggregate_supply'#0'|) ) (! (= (|$IsValid'$1_coin_Ghost$aggregate_supply'#0''| s@@33) (|$IsValid'num'| (|$v#$1_coin_Ghost$aggregate_supply'#0'| s@@33)))
 :qid |boogiebpl.10220:55|
 :skolemid |529|
 :pattern ( (|$IsValid'$1_coin_Ghost$aggregate_supply'#0''| s@@33))
)))
(assert (forall ((s@@34 T@$1_aptos_coin_AptosCoin) ) (! (= (|$IsValid'$1_aptos_coin_AptosCoin'| s@@34) true)
 :qid |boogiebpl.11481:44|
 :skolemid |530|
 :pattern ( (|$IsValid'$1_aptos_coin_AptosCoin'| s@@34))
)))
(assert (forall ((s@@35 T@$1_Bbay_ResourceAccountSignerCap) ) (! (= (|$IsValid'$1_Bbay_ResourceAccountSignerCap'| s@@35) (|$IsValid'$1_account_SignerCapability'| (|$signer_cap#$1_Bbay_ResourceAccountSignerCap| s@@35)))
 :qid |boogiebpl.11562:53|
 :skolemid |533|
 :pattern ( (|$IsValid'$1_Bbay_ResourceAccountSignerCap'| s@@35))
)))
(assert (forall ((src1@@37 (_ BitVec 16)) (src2@@29 (_ BitVec 8)) ) (! (= ($shlBv16From8 src1@@37 src2@@29) (bvshl src1@@37 (concat #x00 src2@@29)))
 :qid |boogiebpl.1769:24|
 :skolemid |53|
 :pattern ( ($shlBv16From8 src1@@37 src2@@29))
)))
(assert (forall ((src1@@38 (_ BitVec 16)) (src2@@30 (_ BitVec 8)) ) (! (= ($shrBv16From8 src1@@38 src2@@30) (bvlshr src1@@38 (concat #x00 src2@@30)))
 :qid |boogiebpl.1783:24|
 :skolemid |54|
 :pattern ( ($shrBv16From8 src1@@38 src2@@30))
)))
(assert (forall ((src1@@39 (_ BitVec 32)) (src2@@31 (_ BitVec 16)) ) (! (= ($shlBv32From16 src1@@39 src2@@31) (bvshl src1@@39 (concat #x0000 src2@@31)))
 :qid |boogiebpl.2023:25|
 :skolemid |67|
 :pattern ( ($shlBv32From16 src1@@39 src2@@31))
)))
(assert (forall ((src1@@40 (_ BitVec 32)) (src2@@32 (_ BitVec 16)) ) (! (= ($shrBv32From16 src1@@40 src2@@32) (bvlshr src1@@40 (concat #x0000 src2@@32)))
 :qid |boogiebpl.2037:25|
 :skolemid |68|
 :pattern ( ($shrBv32From16 src1@@40 src2@@32))
)))
(assert (forall ((src1@@41 (_ BitVec 32)) (src2@@33 (_ BitVec 8)) ) (! (= ($shlBv32From8 src1@@41 src2@@33) (bvshl src1@@41 (concat #x000000 src2@@33)))
 :qid |boogiebpl.1989:24|
 :skolemid |65|
 :pattern ( ($shlBv32From8 src1@@41 src2@@33))
)))
(assert (forall ((src1@@42 (_ BitVec 32)) (src2@@34 (_ BitVec 8)) ) (! (= ($shrBv32From8 src1@@42 src2@@34) (bvlshr src1@@42 (concat #x000000 src2@@34)))
 :qid |boogiebpl.2003:24|
 :skolemid |66|
 :pattern ( ($shrBv32From8 src1@@42 src2@@34))
)))
(assert (forall ((src1@@43 (_ BitVec 64)) (src2@@35 (_ BitVec 32)) ) (! (= ($shlBv64From32 src1@@43 src2@@35) (bvshl src1@@43 (concat #x00000000 src2@@35)))
 :qid |boogiebpl.2273:25|
 :skolemid |81|
 :pattern ( ($shlBv64From32 src1@@43 src2@@35))
)))
(assert (forall ((src1@@44 (_ BitVec 64)) (src2@@36 (_ BitVec 32)) ) (! (= ($shrBv64From32 src1@@44 src2@@36) (bvlshr src1@@44 (concat #x00000000 src2@@36)))
 :qid |boogiebpl.2287:25|
 :skolemid |82|
 :pattern ( ($shrBv64From32 src1@@44 src2@@36))
)))
(assert (forall ((src1@@45 (_ BitVec 64)) (src2@@37 (_ BitVec 16)) ) (! (= ($shlBv64From16 src1@@45 src2@@37) (bvshl src1@@45 (concat #x000000000000 src2@@37)))
 :qid |boogiebpl.2239:25|
 :skolemid |79|
 :pattern ( ($shlBv64From16 src1@@45 src2@@37))
)))
(assert (forall ((src1@@46 (_ BitVec 64)) (src2@@38 (_ BitVec 16)) ) (! (= ($shrBv64From16 src1@@46 src2@@38) (bvlshr src1@@46 (concat #x000000000000 src2@@38)))
 :qid |boogiebpl.2253:25|
 :skolemid |80|
 :pattern ( ($shrBv64From16 src1@@46 src2@@38))
)))
(assert (forall ((src1@@47 (_ BitVec 64)) (src2@@39 (_ BitVec 8)) ) (! (= ($shlBv64From8 src1@@47 src2@@39) (bvshl src1@@47 (concat #x00000000000000 src2@@39)))
 :qid |boogiebpl.2205:24|
 :skolemid |77|
 :pattern ( ($shlBv64From8 src1@@47 src2@@39))
)))
(assert (forall ((src1@@48 (_ BitVec 64)) (src2@@40 (_ BitVec 8)) ) (! (= ($shrBv64From8 src1@@48 src2@@40) (bvlshr src1@@48 (concat #x00000000000000 src2@@40)))
 :qid |boogiebpl.2219:24|
 :skolemid |78|
 :pattern ( ($shrBv64From8 src1@@48 src2@@40))
)))
(assert (forall ((src1@@49 (_ BitVec 128)) (src2@@41 (_ BitVec 64)) ) (! (= ($shlBv128From64 src1@@49 src2@@41) (bvshl src1@@49 (concat #x0000000000000000 src2@@41)))
 :qid |boogiebpl.2519:26|
 :skolemid |95|
 :pattern ( ($shlBv128From64 src1@@49 src2@@41))
)))
(assert (forall ((src1@@50 (_ BitVec 128)) (src2@@42 (_ BitVec 64)) ) (! (= ($shrBv128From64 src1@@50 src2@@42) (bvlshr src1@@50 (concat #x0000000000000000 src2@@42)))
 :qid |boogiebpl.2533:26|
 :skolemid |96|
 :pattern ( ($shrBv128From64 src1@@50 src2@@42))
)))
(assert (forall ((src1@@51 (_ BitVec 128)) (src2@@43 (_ BitVec 32)) ) (! (= ($shlBv128From32 src1@@51 src2@@43) (bvshl src1@@51 (concat #x000000000000000000000000 src2@@43)))
 :qid |boogiebpl.2485:26|
 :skolemid |93|
 :pattern ( ($shlBv128From32 src1@@51 src2@@43))
)))
(assert (forall ((src1@@52 (_ BitVec 128)) (src2@@44 (_ BitVec 32)) ) (! (= ($shrBv128From32 src1@@52 src2@@44) (bvlshr src1@@52 (concat #x000000000000000000000000 src2@@44)))
 :qid |boogiebpl.2499:26|
 :skolemid |94|
 :pattern ( ($shrBv128From32 src1@@52 src2@@44))
)))
(assert (forall ((src1@@53 (_ BitVec 128)) (src2@@45 (_ BitVec 16)) ) (! (= ($shlBv128From16 src1@@53 src2@@45) (bvshl src1@@53 (concat #x0000000000000000000000000000 src2@@45)))
 :qid |boogiebpl.2451:26|
 :skolemid |91|
 :pattern ( ($shlBv128From16 src1@@53 src2@@45))
)))
(assert (forall ((src1@@54 (_ BitVec 128)) (src2@@46 (_ BitVec 16)) ) (! (= ($shrBv128From16 src1@@54 src2@@46) (bvlshr src1@@54 (concat #x0000000000000000000000000000 src2@@46)))
 :qid |boogiebpl.2465:26|
 :skolemid |92|
 :pattern ( ($shrBv128From16 src1@@54 src2@@46))
)))
(assert (forall ((src1@@55 (_ BitVec 128)) (src2@@47 (_ BitVec 8)) ) (! (= ($shlBv128From8 src1@@55 src2@@47) (bvshl src1@@55 (concat #x000000000000000000000000000000 src2@@47)))
 :qid |boogiebpl.2417:25|
 :skolemid |89|
 :pattern ( ($shlBv128From8 src1@@55 src2@@47))
)))
(assert (forall ((src1@@56 (_ BitVec 128)) (src2@@48 (_ BitVec 8)) ) (! (= ($shrBv128From8 src1@@56 src2@@48) (bvlshr src1@@56 (concat #x000000000000000000000000000000 src2@@48)))
 :qid |boogiebpl.2431:25|
 :skolemid |90|
 :pattern ( ($shrBv128From8 src1@@56 src2@@48))
)))
(assert (forall ((src1@@57 (_ BitVec 256)) (src2@@49 (_ BitVec 128)) ) (! (= ($shlBv256From128 src1@@57 src2@@49) (bvshl src1@@57 (concat #x00000000000000000000000000000000 src2@@49)))
 :qid |boogiebpl.2761:27|
 :skolemid |109|
 :pattern ( ($shlBv256From128 src1@@57 src2@@49))
)))
(assert (forall ((src1@@58 (_ BitVec 256)) (src2@@50 (_ BitVec 128)) ) (! (= ($shrBv256From128 src1@@58 src2@@50) (bvlshr src1@@58 (concat #x00000000000000000000000000000000 src2@@50)))
 :qid |boogiebpl.2775:27|
 :skolemid |110|
 :pattern ( ($shrBv256From128 src1@@58 src2@@50))
)))
(assert (forall ((src1@@59 (_ BitVec 256)) (src2@@51 (_ BitVec 64)) ) (! (= ($shlBv256From64 src1@@59 src2@@51) (bvshl src1@@59 (concat #x000000000000000000000000000000000000000000000000 src2@@51)))
 :qid |boogiebpl.2727:26|
 :skolemid |107|
 :pattern ( ($shlBv256From64 src1@@59 src2@@51))
)))
(assert (forall ((src1@@60 (_ BitVec 256)) (src2@@52 (_ BitVec 64)) ) (! (= ($shrBv256From64 src1@@60 src2@@52) (bvlshr src1@@60 (concat #x000000000000000000000000000000000000000000000000 src2@@52)))
 :qid |boogiebpl.2741:26|
 :skolemid |108|
 :pattern ( ($shrBv256From64 src1@@60 src2@@52))
)))
(assert (forall ((src1@@61 (_ BitVec 256)) (src2@@53 (_ BitVec 32)) ) (! (= ($shlBv256From32 src1@@61 src2@@53) (bvshl src1@@61 (concat #x00000000000000000000000000000000000000000000000000000000 src2@@53)))
 :qid |boogiebpl.2693:26|
 :skolemid |105|
 :pattern ( ($shlBv256From32 src1@@61 src2@@53))
)))
(assert (forall ((src1@@62 (_ BitVec 256)) (src2@@54 (_ BitVec 32)) ) (! (= ($shrBv256From32 src1@@62 src2@@54) (bvlshr src1@@62 (concat #x00000000000000000000000000000000000000000000000000000000 src2@@54)))
 :qid |boogiebpl.2707:26|
 :skolemid |106|
 :pattern ( ($shrBv256From32 src1@@62 src2@@54))
)))
(assert (forall ((src1@@63 (_ BitVec 256)) (src2@@55 (_ BitVec 16)) ) (! (= ($shlBv256From16 src1@@63 src2@@55) (bvshl src1@@63 (concat #x000000000000000000000000000000000000000000000000000000000000 src2@@55)))
 :qid |boogiebpl.2659:26|
 :skolemid |103|
 :pattern ( ($shlBv256From16 src1@@63 src2@@55))
)))
(assert (forall ((src1@@64 (_ BitVec 256)) (src2@@56 (_ BitVec 16)) ) (! (= ($shrBv256From16 src1@@64 src2@@56) (bvlshr src1@@64 (concat #x000000000000000000000000000000000000000000000000000000000000 src2@@56)))
 :qid |boogiebpl.2673:26|
 :skolemid |104|
 :pattern ( ($shrBv256From16 src1@@64 src2@@56))
)))
(assert (forall ((src1@@65 (_ BitVec 256)) (src2@@57 (_ BitVec 8)) ) (! (= ($shlBv256From8 src1@@65 src2@@57) (bvshl src1@@65 (concat #x00000000000000000000000000000000000000000000000000000000000000 src2@@57)))
 :qid |boogiebpl.2625:25|
 :skolemid |101|
 :pattern ( ($shlBv256From8 src1@@65 src2@@57))
)))
(assert (forall ((src1@@66 (_ BitVec 256)) (src2@@58 (_ BitVec 8)) ) (! (= ($shrBv256From8 src1@@66 src2@@58) (bvlshr src1@@66 (concat #x00000000000000000000000000000000000000000000000000000000000000 src2@@58)))
 :qid |boogiebpl.2639:25|
 :skolemid |102|
 :pattern ( ($shrBv256From8 src1@@66 src2@@58))
)))
(assert (forall ((t@@20 T@$TypeParamInfo) ) (!  (=> (is-$TypeParamU16 t@@20) (|$IsEqual'vec'u8''| ($TypeName t@@20) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 49) 2 54) 3)))
 :qid |boogiebpl.6525:15|
 :skolemid |249|
 :pattern ( ($TypeName t@@20))
)))
(assert (forall ((t@@21 T@$TypeParamInfo) ) (!  (=> (is-$TypeParamU32 t@@21) (|$IsEqual'vec'u8''| ($TypeName t@@21) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 51) 2 50) 3)))
 :qid |boogiebpl.6527:15|
 :skolemid |251|
 :pattern ( ($TypeName t@@21))
)))
(assert (forall ((t@@22 T@$TypeParamInfo) ) (!  (=> (is-$TypeParamU64 t@@22) (|$IsEqual'vec'u8''| ($TypeName t@@22) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 54) 2 52) 3)))
 :qid |boogiebpl.6529:15|
 :skolemid |253|
 :pattern ( ($TypeName t@@22))
)))
(assert (forall ((t@@23 T@$TypeParamInfo) ) (!  (=> (|$IsEqual'vec'u8''| ($TypeName t@@23) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 49) 2 50) 3 56) 4)) (is-$TypeParamU128 t@@23))
 :qid |boogiebpl.6532:15|
 :skolemid |256|
 :pattern ( ($TypeName t@@23))
)))
(assert (forall ((agg T@$1_aggregator_Aggregator) (val Int) ) (! (= ($1_aggregator_spec_aggregator_set_val agg val) ($1_aggregator_Aggregator (|$handle#$1_aggregator_Aggregator| agg) (|$key#$1_aggregator_Aggregator| agg) (|$limit#$1_aggregator_Aggregator| agg) val))
 :qid |boogiebpl.286:48|
 :skolemid |10|
 :pattern ( ($1_aggregator_spec_aggregator_set_val agg val))
)))
(assert (forall ((src1@@67 (_ BitVec 8)) (src2@@59 (_ BitVec 8)) ) (! (= ($shlBv8From8 src1@@67 src2@@59) (bvshl src1@@67 src2@@59))
 :qid |boogiebpl.1545:23|
 :skolemid |41|
 :pattern ( ($shlBv8From8 src1@@67 src2@@59))
)))
(assert (forall ((src1@@68 (_ BitVec 8)) (src2@@60 (_ BitVec 8)) ) (! (= ($shrBv8From8 src1@@68 src2@@60) (bvlshr src1@@68 src2@@60))
 :qid |boogiebpl.1559:23|
 :skolemid |42|
 :pattern ( ($shrBv8From8 src1@@68 src2@@60))
)))
(assert (forall ((src1@@69 (_ BitVec 16)) (src2@@61 (_ BitVec 16)) ) (! (= ($shlBv16From16 src1@@69 src2@@61) (bvshl src1@@69 src2@@61))
 :qid |boogiebpl.1803:25|
 :skolemid |55|
 :pattern ( ($shlBv16From16 src1@@69 src2@@61))
)))
(assert (forall ((src1@@70 (_ BitVec 16)) (src2@@62 (_ BitVec 16)) ) (! (= ($shrBv16From16 src1@@70 src2@@62) (bvlshr src1@@70 src2@@62))
 :qid |boogiebpl.1817:25|
 :skolemid |56|
 :pattern ( ($shrBv16From16 src1@@70 src2@@62))
)))
(assert (forall ((src1@@71 (_ BitVec 32)) (src2@@63 (_ BitVec 32)) ) (! (= ($shlBv32From32 src1@@71 src2@@63) (bvshl src1@@71 src2@@63))
 :qid |boogiebpl.2057:25|
 :skolemid |69|
 :pattern ( ($shlBv32From32 src1@@71 src2@@63))
)))
(assert (forall ((src1@@72 (_ BitVec 32)) (src2@@64 (_ BitVec 32)) ) (! (= ($shrBv32From32 src1@@72 src2@@64) (bvlshr src1@@72 src2@@64))
 :qid |boogiebpl.2071:25|
 :skolemid |70|
 :pattern ( ($shrBv32From32 src1@@72 src2@@64))
)))
(assert (forall ((src1@@73 (_ BitVec 64)) (src2@@65 (_ BitVec 64)) ) (! (= ($shlBv64From64 src1@@73 src2@@65) (bvshl src1@@73 src2@@65))
 :qid |boogiebpl.2307:25|
 :skolemid |83|
 :pattern ( ($shlBv64From64 src1@@73 src2@@65))
)))
(assert (forall ((src1@@74 (_ BitVec 64)) (src2@@66 (_ BitVec 64)) ) (! (= ($shrBv64From64 src1@@74 src2@@66) (bvlshr src1@@74 src2@@66))
 :qid |boogiebpl.2321:25|
 :skolemid |84|
 :pattern ( ($shrBv64From64 src1@@74 src2@@66))
)))
(assert (forall ((src1@@75 (_ BitVec 128)) (src2@@67 (_ BitVec 128)) ) (! (= ($shlBv128From128 src1@@75 src2@@67) (bvshl src1@@75 src2@@67))
 :qid |boogiebpl.2553:27|
 :skolemid |97|
 :pattern ( ($shlBv128From128 src1@@75 src2@@67))
)))
(assert (forall ((src1@@76 (_ BitVec 128)) (src2@@68 (_ BitVec 128)) ) (! (= ($shrBv128From128 src1@@76 src2@@68) (bvlshr src1@@76 src2@@68))
 :qid |boogiebpl.2567:27|
 :skolemid |98|
 :pattern ( ($shrBv128From128 src1@@76 src2@@68))
)))
(assert (forall ((src1@@77 (_ BitVec 256)) (src2@@69 (_ BitVec 256)) ) (! (= ($shlBv256From256 src1@@77 src2@@69) (bvshl src1@@77 src2@@69))
 :qid |boogiebpl.2795:27|
 :skolemid |111|
 :pattern ( ($shlBv256From256 src1@@77 src2@@69))
)))
(assert (forall ((src1@@78 (_ BitVec 256)) (src2@@70 (_ BitVec 256)) ) (! (= ($shrBv256From256 src1@@78 src2@@70) (bvlshr src1@@78 src2@@70))
 :qid |boogiebpl.2809:27|
 :skolemid |112|
 :pattern ( ($shrBv256From256 src1@@78 src2@@70))
)))
(assert (forall ((k1@@2 T@Vec_6673) (k2@@2 T@Vec_6673) ) (!  (=> (|$IsEqual'vec'u8''| k1@@2 k2@@2) (= ($1_Signature_$ed25519_validate_pubkey k1@@2) ($1_Signature_$ed25519_validate_pubkey k2@@2)))
 :qid |boogiebpl.6435:15|
 :skolemid |240|
 :pattern ( ($1_Signature_$ed25519_validate_pubkey k1@@2) ($1_Signature_$ed25519_validate_pubkey k2@@2))
)))
(assert (forall ((v@@37 (_ BitVec 8)) ) (! (= (|$IsValid'bv8'| v@@37)  (and (bvuge v@@37 #x00) (bvule v@@37 #xff)))
 :qid |boogiebpl.423:24|
 :skolemid |14|
 :pattern ( (|$IsValid'bv8'| v@@37))
)))
(assert (forall ((v@@38 (_ BitVec 64)) ) (! (= (|$IsValid'bv64'| v@@38)  (and (bvuge v@@38 #x0000000000000000) (bvule v@@38 #xffffffffffffffff)))
 :qid |boogiebpl.798:25|
 :skolemid |17|
 :pattern ( (|$IsValid'bv64'| v@@38))
)))
(assert (forall ((v@@39 (_ BitVec 16)) ) (! (= (|$IsValid'bv16'| v@@39)  (and (bvuge v@@39 #x0000) (bvule v@@39 #xffff)))
 :qid |boogiebpl.548:25|
 :skolemid |15|
 :pattern ( (|$IsValid'bv16'| v@@39))
)))
(assert (forall ((v@@40 (_ BitVec 256)) ) (! (= (|$IsValid'bv256'| v@@40)  (and (bvuge v@@40 #x0000000000000000000000000000000000000000000000000000000000000000) (bvule v@@40 #xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)))
 :qid |boogiebpl.1048:26|
 :skolemid |19|
 :pattern ( (|$IsValid'bv256'| v@@40))
)))
(assert (forall ((v@@41 T@Vec_85428) (e@@7 |T@#0|) ) (! (let ((i@@68 (|$IndexOfVec'#0'| v@@41 e@@7)))
(ite  (not (exists ((i@@69 Int) ) (!  (and (and (|$IsValid'u64'| i@@69) (InRangeVec_65852 v@@41 i@@69)) (= (|Select__T@[Int]#0_| (|v#Vec_85428| v@@41) i@@69) e@@7))
 :qid |boogiebpl.3103:13|
 :skolemid |121|
))) (= i@@68 (- 0 1))  (and (and (and (|$IsValid'u64'| i@@68) (InRangeVec_65852 v@@41 i@@68)) (= (|Select__T@[Int]#0_| (|v#Vec_85428| v@@41) i@@68) e@@7)) (forall ((j@@13 Int) ) (!  (=> (and (and (|$IsValid'u64'| j@@13) (>= j@@13 0)) (< j@@13 i@@68)) (not (= (|Select__T@[Int]#0_| (|v#Vec_85428| v@@41) j@@13) e@@7)))
 :qid |boogiebpl.3111:17|
 :skolemid |122|
)))))
 :qid |boogiebpl.3107:15|
 :skolemid |123|
 :pattern ( (|$IndexOfVec'#0'| v@@41 e@@7))
)))
(assert (forall ((v@@42 T@Vec_90390) (e@@8 T@$1_aggregator_Aggregator) ) (! (let ((i@@70 (|$IndexOfVec'$1_aggregator_Aggregator'| v@@42 e@@8)))
(ite  (not (exists ((i@@71 Int) ) (!  (and (and (|$IsValid'u64'| i@@71) (InRangeVec_66199 v@@42 i@@71)) (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| v@@42) i@@71) e@@8))
 :qid |boogiebpl.3407:13|
 :skolemid |132|
))) (= i@@70 (- 0 1))  (and (and (and (|$IsValid'u64'| i@@70) (InRangeVec_66199 v@@42 i@@70)) (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| v@@42) i@@70) e@@8)) (forall ((j@@14 Int) ) (!  (=> (and (and (|$IsValid'u64'| j@@14) (>= j@@14 0)) (< j@@14 i@@70)) (not (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| v@@42) j@@14) e@@8)))
 :qid |boogiebpl.3415:17|
 :skolemid |133|
)))))
 :qid |boogiebpl.3411:15|
 :skolemid |134|
 :pattern ( (|$IndexOfVec'$1_aggregator_Aggregator'| v@@42 e@@8))
)))
(assert (forall ((v@@43 T@Vec_95276) (e@@9 T@$1_optional_aggregator_Integer) ) (! (let ((i@@72 (|$IndexOfVec'$1_optional_aggregator_Integer'| v@@43 e@@9)))
(ite  (not (exists ((i@@73 Int) ) (!  (and (and (|$IsValid'u64'| i@@73) (InRangeVec_66546 v@@43 i@@73)) (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| v@@43) i@@73) e@@9))
 :qid |boogiebpl.3711:13|
 :skolemid |143|
))) (= i@@72 (- 0 1))  (and (and (and (|$IsValid'u64'| i@@72) (InRangeVec_66546 v@@43 i@@72)) (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| v@@43) i@@72) e@@9)) (forall ((j@@15 Int) ) (!  (=> (and (and (|$IsValid'u64'| j@@15) (>= j@@15 0)) (< j@@15 i@@72)) (not (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| v@@43) j@@15) e@@9)))
 :qid |boogiebpl.3719:17|
 :skolemid |144|
)))))
 :qid |boogiebpl.3715:15|
 :skolemid |145|
 :pattern ( (|$IndexOfVec'$1_optional_aggregator_Integer'| v@@43 e@@9))
)))
(assert (forall ((v@@44 T@Vec_100175) (e@@10 T@$1_optional_aggregator_OptionalAggregator) ) (! (let ((i@@74 (|$IndexOfVec'$1_optional_aggregator_OptionalAggregator'| v@@44 e@@10)))
(ite  (not (exists ((i@@75 Int) ) (!  (and (and (|$IsValid'u64'| i@@75) (InRangeVec_66893 v@@44 i@@75)) (and (|$IsEqual'vec'$1_aggregator_Aggregator''| (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@44) i@@75))) (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| e@@10))) (|$IsEqual'vec'$1_optional_aggregator_Integer''| (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@44) i@@75))) (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| e@@10)))))
 :qid |boogiebpl.4015:13|
 :skolemid |154|
))) (= i@@74 (- 0 1))  (and (and (and (|$IsValid'u64'| i@@74) (InRangeVec_66893 v@@44 i@@74)) (and (|$IsEqual'vec'$1_aggregator_Aggregator''| (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@44) i@@74))) (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| e@@10))) (|$IsEqual'vec'$1_optional_aggregator_Integer''| (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@44) i@@74))) (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| e@@10))))) (forall ((j@@16 Int) ) (!  (=> (and (and (|$IsValid'u64'| j@@16) (>= j@@16 0)) (< j@@16 i@@74)) (not (and (|$IsEqual'vec'$1_aggregator_Aggregator''| (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@44) j@@16))) (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| e@@10))) (|$IsEqual'vec'$1_optional_aggregator_Integer''| (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@44) j@@16))) (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| e@@10))))))
 :qid |boogiebpl.4023:17|
 :skolemid |155|
)))))
 :qid |boogiebpl.4019:15|
 :skolemid |156|
 :pattern ( (|$IndexOfVec'$1_optional_aggregator_OptionalAggregator'| v@@44 e@@10))
)))
(assert (forall ((v@@45 T@Vec_6673) (e@@11 Int) ) (! (let ((i@@76 (|$IndexOfVec'address'| v@@45 e@@11)))
(ite  (not (exists ((i@@77 Int) ) (!  (and (and (|$IsValid'u64'| i@@77) (InRangeVec_25002 v@@45 i@@77)) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@45) i@@77) e@@11))
 :qid |boogiebpl.4319:13|
 :skolemid |165|
))) (= i@@76 (- 0 1))  (and (and (and (|$IsValid'u64'| i@@76) (InRangeVec_25002 v@@45 i@@76)) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@45) i@@76) e@@11)) (forall ((j@@17 Int) ) (!  (=> (and (and (|$IsValid'u64'| j@@17) (>= j@@17 0)) (< j@@17 i@@76)) (not (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@45) j@@17) e@@11)))
 :qid |boogiebpl.4327:17|
 :skolemid |166|
)))))
 :qid |boogiebpl.4323:15|
 :skolemid |167|
 :pattern ( (|$IndexOfVec'address'| v@@45 e@@11))
)))
(assert (forall ((v@@46 T@Vec_6673) (e@@12 Int) ) (! (let ((i@@78 (|$IndexOfVec'u64'| v@@46 e@@12)))
(ite  (not (exists ((i@@79 Int) ) (!  (and (and (|$IsValid'u64'| i@@79) (InRangeVec_25002 v@@46 i@@79)) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@46) i@@79) e@@12))
 :qid |boogiebpl.4623:13|
 :skolemid |176|
))) (= i@@78 (- 0 1))  (and (and (and (|$IsValid'u64'| i@@78) (InRangeVec_25002 v@@46 i@@78)) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@46) i@@78) e@@12)) (forall ((j@@18 Int) ) (!  (=> (and (and (|$IsValid'u64'| j@@18) (>= j@@18 0)) (< j@@18 i@@78)) (not (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@46) j@@18) e@@12)))
 :qid |boogiebpl.4631:17|
 :skolemid |177|
)))))
 :qid |boogiebpl.4627:15|
 :skolemid |178|
 :pattern ( (|$IndexOfVec'u64'| v@@46 e@@12))
)))
(assert (forall ((v@@47 T@Vec_6673) (e@@13 Int) ) (! (let ((i@@80 (|$IndexOfVec'u8'| v@@47 e@@13)))
(ite  (not (exists ((i@@81 Int) ) (!  (and (and (|$IsValid'u64'| i@@81) (InRangeVec_25002 v@@47 i@@81)) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@47) i@@81) e@@13))
 :qid |boogiebpl.4927:13|
 :skolemid |187|
))) (= i@@80 (- 0 1))  (and (and (and (|$IsValid'u64'| i@@80) (InRangeVec_25002 v@@47 i@@80)) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@47) i@@80) e@@13)) (forall ((j@@19 Int) ) (!  (=> (and (and (|$IsValid'u64'| j@@19) (>= j@@19 0)) (< j@@19 i@@80)) (not (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@47) j@@19) e@@13)))
 :qid |boogiebpl.4935:17|
 :skolemid |188|
)))))
 :qid |boogiebpl.4931:15|
 :skolemid |189|
 :pattern ( (|$IndexOfVec'u8'| v@@47 e@@13))
)))
(assert (forall ((v@@48 T@Vec_67815) (e@@14 (_ BitVec 64)) ) (! (let ((i@@82 (|$IndexOfVec'bv64'| v@@48 e@@14)))
(ite  (not (exists ((i@@83 Int) ) (!  (and (and (|$IsValid'u64'| i@@83) (InRangeVec_67819 v@@48 i@@83)) (= (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| v@@48) i@@83) e@@14))
 :qid |boogiebpl.5231:13|
 :skolemid |198|
))) (= i@@82 (- 0 1))  (and (and (and (|$IsValid'u64'| i@@82) (InRangeVec_67819 v@@48 i@@82)) (= (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| v@@48) i@@82) e@@14)) (forall ((j@@20 Int) ) (!  (=> (and (and (|$IsValid'u64'| j@@20) (>= j@@20 0)) (< j@@20 i@@82)) (not (= (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| v@@48) j@@20) e@@14)))
 :qid |boogiebpl.5239:17|
 :skolemid |199|
)))))
 :qid |boogiebpl.5235:15|
 :skolemid |200|
 :pattern ( (|$IndexOfVec'bv64'| v@@48 e@@14))
)))
(assert (forall ((v@@49 T@Vec_68162) (e@@15 (_ BitVec 8)) ) (! (let ((i@@84 (|$IndexOfVec'bv8'| v@@49 e@@15)))
(ite  (not (exists ((i@@85 Int) ) (!  (and (and (|$IsValid'u64'| i@@85) (InRangeVec_68166 v@@49 i@@85)) (= (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| v@@49) i@@85) e@@15))
 :qid |boogiebpl.5535:13|
 :skolemid |209|
))) (= i@@84 (- 0 1))  (and (and (and (|$IsValid'u64'| i@@84) (InRangeVec_68166 v@@49 i@@84)) (= (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| v@@49) i@@84) e@@15)) (forall ((j@@21 Int) ) (!  (=> (and (and (|$IsValid'u64'| j@@21) (>= j@@21 0)) (< j@@21 i@@84)) (not (= (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| v@@49) j@@21) e@@15)))
 :qid |boogiebpl.5543:17|
 :skolemid |210|
)))))
 :qid |boogiebpl.5539:15|
 :skolemid |211|
 :pattern ( (|$IndexOfVec'bv8'| v@@49 e@@15))
)))
(assert (forall ((s@@36 T@$1_account_Account) ) (! (= (|$IsValid'$1_account_Account'| s@@36)  (and (and (and (and (and (and (|$IsValid'vec'u8''| (|$authentication_key#$1_account_Account| s@@36)) (|$IsValid'u64'| (|$sequence_number#$1_account_Account| s@@36))) (|$IsValid'u64'| (|$guid_creation_num#$1_account_Account| s@@36))) (|$IsValid'$1_event_EventHandle'$1_account_CoinRegisterEvent''| (|$coin_register_events#$1_account_Account| s@@36))) (|$IsValid'$1_event_EventHandle'$1_account_KeyRotationEvent''| (|$key_rotation_events#$1_account_Account| s@@36))) (|$IsValid'$1_account_CapabilityOffer'$1_account_RotationCapability''| (|$rotation_capability_offer#$1_account_Account| s@@36))) (|$IsValid'$1_account_CapabilityOffer'$1_account_SignerCapability''| (|$signer_capability_offer#$1_account_Account| s@@36))))
 :qid |boogiebpl.8481:39|
 :skolemid |511|
 :pattern ( (|$IsValid'$1_account_Account'| s@@36))
)))
(assert (forall ((t@@24 T@$TypeParamInfo) ) (!  (=> (is-$TypeParamBool t@@24) (|$IsEqual'vec'u8''| ($TypeName t@@24) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 98) 1 111) 2 111) 3 108) 4)))
 :qid |boogiebpl.6521:15|
 :skolemid |245|
 :pattern ( ($TypeName t@@24))
)))
(assert (forall ((agg@@0 T@$1_aggregator_Aggregator) ) (! (= ($1_aggregator_spec_read agg@@0) (|$val#$1_aggregator_Aggregator| agg@@0))
 :qid |boogiebpl.282:34|
 :skolemid |9|
 :pattern ( ($1_aggregator_spec_read agg@@0))
)))
(assert (forall ((agg@@1 T@$1_aggregator_Aggregator) ) (! (= ($1_aggregator_spec_aggregator_get_val agg@@1) (|$val#$1_aggregator_Aggregator| agg@@1))
 :qid |boogiebpl.290:48|
 :skolemid |11|
 :pattern ( ($1_aggregator_spec_aggregator_get_val agg@@1))
)))
(assert (forall ((t1@@0 T@Table_36177_36178) (t2@@0 T@Table_36177_36178) ) (! (= (|$IsEqual'$1_table_Table'u64_u64''| t1@@0 t2@@0)  (and (and (and (= (|l#Table_36177_36178| t1@@0) (|l#Table_36177_36178| t2@@0)) (forall ((k@@12 Int) ) (! (= (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t1@@0) k@@12) (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t2@@0) k@@12))
 :qid |boogiebpl.5956:13|
 :skolemid |220|
))) (forall ((k@@13 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t1@@0) k@@13) (= (|Select__T@[Int]Int_| (|v#Table_36177_36178| t1@@0) k@@13) (|Select__T@[Int]Int_| (|v#Table_36177_36178| t2@@0) k@@13)))
 :qid |boogiebpl.5957:13|
 :skolemid |221|
))) (forall ((k@@14 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t2@@0) k@@14) (= (|Select__T@[Int]Int_| (|v#Table_36177_36178| t1@@0) k@@14) (|Select__T@[Int]Int_| (|v#Table_36177_36178| t2@@0) k@@14)))
 :qid |boogiebpl.5958:13|
 :skolemid |222|
))))
 :qid |boogiebpl.5954:44|
 :skolemid |223|
 :pattern ( (|$IsEqual'$1_table_Table'u64_u64''| t1@@0 t2@@0))
)))
(assert (forall ((t1@@1 T@Table_37064_126051) (t2@@1 T@Table_37064_126051) ) (! (= (|$IsEqual'$1_table_Table'u64_vec'u64'''| t1@@1 t2@@1)  (and (and (and (= (|l#Table_37064_126051| t1@@1) (|l#Table_37064_126051| t2@@1)) (forall ((k@@15 Int) ) (! (= (|Select__T@[Int]Bool_| (|e#Table_37064_126051| t1@@1) k@@15) (|Select__T@[Int]Bool_| (|e#Table_37064_126051| t2@@1) k@@15))
 :qid |boogiebpl.6074:13|
 :skolemid |226|
))) (forall ((k@@16 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_37064_126051| t1@@1) k@@16) (= (|Select__T@[Int]Vec_6673_| (|v#Table_37064_126051| t1@@1) k@@16) (|Select__T@[Int]Vec_6673_| (|v#Table_37064_126051| t2@@1) k@@16)))
 :qid |boogiebpl.6075:13|
 :skolemid |227|
))) (forall ((k@@17 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_37064_126051| t2@@1) k@@17) (= (|Select__T@[Int]Vec_6673_| (|v#Table_37064_126051| t1@@1) k@@17) (|Select__T@[Int]Vec_6673_| (|v#Table_37064_126051| t2@@1) k@@17)))
 :qid |boogiebpl.6076:13|
 :skolemid |228|
))))
 :qid |boogiebpl.6072:49|
 :skolemid |229|
 :pattern ( (|$IsEqual'$1_table_Table'u64_vec'u64'''| t1@@1 t2@@1))
)))
(assert (forall ((t1@@2 T@Table_36177_36178) (t2@@2 T@Table_36177_36178) ) (! (= (|$IsEqual'$1_table_Table'address_address''| t1@@2 t2@@2)  (and (and (and (= (|l#Table_36177_36178| t1@@2) (|l#Table_36177_36178| t2@@2)) (forall ((k@@18 Int) ) (! (= (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t1@@2) k@@18) (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t2@@2) k@@18))
 :qid |boogiebpl.6192:13|
 :skolemid |232|
))) (forall ((k@@19 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t1@@2) k@@19) (= (|Select__T@[Int]Int_| (|v#Table_36177_36178| t1@@2) k@@19) (|Select__T@[Int]Int_| (|v#Table_36177_36178| t2@@2) k@@19)))
 :qid |boogiebpl.6193:13|
 :skolemid |233|
))) (forall ((k@@20 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t2@@2) k@@20) (= (|Select__T@[Int]Int_| (|v#Table_36177_36178| t1@@2) k@@20) (|Select__T@[Int]Int_| (|v#Table_36177_36178| t2@@2) k@@20)))
 :qid |boogiebpl.6194:13|
 :skolemid |234|
))))
 :qid |boogiebpl.6190:52|
 :skolemid |235|
 :pattern ( (|$IsEqual'$1_table_Table'address_address''| t1@@2 t2@@2))
)))
(assert (forall ((v@@50 (_ BitVec 128)) ) (! (= (|$IsValid'bv128'| v@@50)  (and (bvuge v@@50 #x00000000000000000000000000000000) (bvule v@@50 #xffffffffffffffffffffffffffffffff)))
 :qid |boogiebpl.923:26|
 :skolemid |18|
 :pattern ( (|$IsValid'bv128'| v@@50))
)))
(assert (forall ((v1@@8 T@Vec_6673) (v2@@8 T@Vec_6673) ) (! (= (|$IsEqual'vec'u8''| v1@@8 v2@@8) (|$IsEqual'vec'u8''| ($1_hash_sha2 v1@@8) ($1_hash_sha2 v2@@8)))
 :qid |boogiebpl.6322:15|
 :skolemid |238|
 :pattern ( ($1_hash_sha2 v1@@8) ($1_hash_sha2 v2@@8))
)))
(assert (forall ((v1@@9 T@Vec_6673) (v2@@9 T@Vec_6673) ) (! (= (|$IsEqual'vec'u8''| v1@@9 v2@@9) (|$IsEqual'vec'u8''| ($1_hash_sha3 v1@@9) ($1_hash_sha3 v2@@9)))
 :qid |boogiebpl.6338:15|
 :skolemid |239|
 :pattern ( ($1_hash_sha3 v1@@9) ($1_hash_sha3 v2@@9))
)))
(assert (forall ((v1@@10 Int) (v2@@10 Int) ) (! (= (= v1@@10 v2@@10) (|$IsEqual'vec'u8''| (|$1_bcs_serialize'address'| v1@@10) (|$1_bcs_serialize'address'| v2@@10)))
 :qid |boogiebpl.6465:15|
 :skolemid |242|
 :pattern ( (|$1_bcs_serialize'address'| v1@@10) (|$1_bcs_serialize'address'| v2@@10))
)))
(assert (forall ((t@@25 T@$TypeParamInfo) ) (!  (=> (is-$TypeParamStruct t@@25) (|$IsEqual'vec'u8''| ($TypeName t@@25) (let ((m2@@2 (|v#Vec_6673| (|s#$TypeParamStruct| t@@25))))
(let ((l2@@1 (|l#Vec_6673| (|s#$TypeParamStruct| t@@25))))
(let ((m1@@2 (|v#Vec_6673| (let ((m2@@3 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((l2@@2 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((m1@@3 (|v#Vec_6673| (let ((m2@@4 (|v#Vec_6673| (|m#$TypeParamStruct| t@@25))))
(let ((l2@@3 (|l#Vec_6673| (|m#$TypeParamStruct| t@@25))))
(let ((m1@@4 (|v#Vec_6673| (let ((m2@@5 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((l2@@4 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((m1@@5 (|v#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(let ((l1@@2 (|l#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@2 l2@@4) l1@@2 m1@@5 m2@@5 l1@@2 DefaultVecElem_25347) (+ l1@@2 l2@@4)))))))))
(let ((l1@@3 (|l#Vec_6673| (let ((m2@@5 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((l2@@4 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((m1@@5 (|v#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(let ((l1@@2 (|l#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@2 l2@@4) l1@@2 m1@@5 m2@@5 l1@@2 DefaultVecElem_25347) (+ l1@@2 l2@@4)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@3 l2@@3) l1@@3 m1@@4 m2@@4 l1@@3 DefaultVecElem_25347) (+ l1@@3 l2@@3)))))))))
(let ((l1@@4 (|l#Vec_6673| (let ((m2@@4 (|v#Vec_6673| (|m#$TypeParamStruct| t@@25))))
(let ((l2@@3 (|l#Vec_6673| (|m#$TypeParamStruct| t@@25))))
(let ((m1@@4 (|v#Vec_6673| (let ((m2@@5 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((l2@@4 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((m1@@5 (|v#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(let ((l1@@2 (|l#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@2 l2@@4) l1@@2 m1@@5 m2@@5 l1@@2 DefaultVecElem_25347) (+ l1@@2 l2@@4)))))))))
(let ((l1@@3 (|l#Vec_6673| (let ((m2@@5 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((l2@@4 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((m1@@5 (|v#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(let ((l1@@2 (|l#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@2 l2@@4) l1@@2 m1@@5 m2@@5 l1@@2 DefaultVecElem_25347) (+ l1@@2 l2@@4)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@3 l2@@3) l1@@3 m1@@4 m2@@4 l1@@3 DefaultVecElem_25347) (+ l1@@3 l2@@3)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@4 l2@@2) l1@@4 m1@@3 m2@@3 l1@@4 DefaultVecElem_25347) (+ l1@@4 l2@@2)))))))))
(let ((l1@@5 (|l#Vec_6673| (let ((m2@@3 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((l2@@2 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((m1@@3 (|v#Vec_6673| (let ((m2@@4 (|v#Vec_6673| (|m#$TypeParamStruct| t@@25))))
(let ((l2@@3 (|l#Vec_6673| (|m#$TypeParamStruct| t@@25))))
(let ((m1@@4 (|v#Vec_6673| (let ((m2@@5 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((l2@@4 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((m1@@5 (|v#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(let ((l1@@2 (|l#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@2 l2@@4) l1@@2 m1@@5 m2@@5 l1@@2 DefaultVecElem_25347) (+ l1@@2 l2@@4)))))))))
(let ((l1@@3 (|l#Vec_6673| (let ((m2@@5 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((l2@@4 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((m1@@5 (|v#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(let ((l1@@2 (|l#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@2 l2@@4) l1@@2 m1@@5 m2@@5 l1@@2 DefaultVecElem_25347) (+ l1@@2 l2@@4)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@3 l2@@3) l1@@3 m1@@4 m2@@4 l1@@3 DefaultVecElem_25347) (+ l1@@3 l2@@3)))))))))
(let ((l1@@4 (|l#Vec_6673| (let ((m2@@4 (|v#Vec_6673| (|m#$TypeParamStruct| t@@25))))
(let ((l2@@3 (|l#Vec_6673| (|m#$TypeParamStruct| t@@25))))
(let ((m1@@4 (|v#Vec_6673| (let ((m2@@5 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((l2@@4 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((m1@@5 (|v#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(let ((l1@@2 (|l#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@2 l2@@4) l1@@2 m1@@5 m2@@5 l1@@2 DefaultVecElem_25347) (+ l1@@2 l2@@4)))))))))
(let ((l1@@3 (|l#Vec_6673| (let ((m2@@5 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((l2@@4 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((m1@@5 (|v#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(let ((l1@@2 (|l#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@2 l2@@4) l1@@2 m1@@5 m2@@5 l1@@2 DefaultVecElem_25347) (+ l1@@2 l2@@4)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@3 l2@@3) l1@@3 m1@@4 m2@@4 l1@@3 DefaultVecElem_25347) (+ l1@@3 l2@@3)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@4 l2@@2) l1@@4 m1@@3 m2@@3 l1@@4 DefaultVecElem_25347) (+ l1@@4 l2@@2)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@5 l2@@1) l1@@5 m1@@2 m2@@2 l1@@5 DefaultVecElem_25347) (+ l1@@5 l2@@1))))))))
 :qid |boogiebpl.6541:15|
 :skolemid |265|
 :pattern ( ($TypeName t@@25))
)))
(assert (forall ((v@@51 Int) ) (! (= (|$IsValid'u8'| v@@51)  (and (>= v@@51 0) (<= v@@51 $MAX_U8)))
 :qid |boogiebpl.1081:23|
 :skolemid |20|
 :pattern ( (|$IsValid'u8'| v@@51))
)))
(assert (forall ((v@@52 Int) ) (! (= (|$IsValid'u16'| v@@52)  (and (>= v@@52 0) (<= v@@52 $MAX_U16)))
 :qid |boogiebpl.1085:24|
 :skolemid |21|
 :pattern ( (|$IsValid'u16'| v@@52))
)))
(assert (forall ((v@@53 Int) ) (! (= (|$IsValid'u32'| v@@53)  (and (>= v@@53 0) (<= v@@53 $MAX_U32)))
 :qid |boogiebpl.1089:24|
 :skolemid |22|
 :pattern ( (|$IsValid'u32'| v@@53))
)))
(assert (forall ((v@@54 Int) ) (! (= (|$IsValid'u64'| v@@54)  (and (>= v@@54 0) (<= v@@54 $MAX_U64)))
 :qid |boogiebpl.1093:24|
 :skolemid |23|
 :pattern ( (|$IsValid'u64'| v@@54))
)))
(assert (forall ((v@@55 Int) ) (! (= (|$IsValid'u128'| v@@55)  (and (>= v@@55 0) (<= v@@55 $MAX_U128)))
 :qid |boogiebpl.1097:25|
 :skolemid |24|
 :pattern ( (|$IsValid'u128'| v@@55))
)))
(assert (forall ((v@@56 Int) ) (! (= (|$IsValid'u256'| v@@56)  (and (>= v@@56 0) (<= v@@56 $MAX_U256)))
 :qid |boogiebpl.1101:25|
 :skolemid |25|
 :pattern ( (|$IsValid'u256'| v@@56))
)))
(assert (forall ((v@@57 T@Vec_85428) (i@@86 Int) ) (! (= (InRangeVec_65852 v@@57 i@@86)  (and (>= i@@86 0) (< i@@86 (|l#Vec_85428| v@@57))))
 :qid |boogiebpl.123:24|
 :skolemid |3|
 :pattern ( (InRangeVec_65852 v@@57 i@@86))
)))
(assert (forall ((v@@58 T@Vec_90390) (i@@87 Int) ) (! (= (InRangeVec_66199 v@@58 i@@87)  (and (>= i@@87 0) (< i@@87 (|l#Vec_90390| v@@58))))
 :qid |boogiebpl.123:24|
 :skolemid |3|
 :pattern ( (InRangeVec_66199 v@@58 i@@87))
)))
(assert (forall ((v@@59 T@Vec_95276) (i@@88 Int) ) (! (= (InRangeVec_66546 v@@59 i@@88)  (and (>= i@@88 0) (< i@@88 (|l#Vec_95276| v@@59))))
 :qid |boogiebpl.123:24|
 :skolemid |3|
 :pattern ( (InRangeVec_66546 v@@59 i@@88))
)))
(assert (forall ((v@@60 T@Vec_100175) (i@@89 Int) ) (! (= (InRangeVec_66893 v@@60 i@@89)  (and (>= i@@89 0) (< i@@89 (|l#Vec_100175| v@@60))))
 :qid |boogiebpl.123:24|
 :skolemid |3|
 :pattern ( (InRangeVec_66893 v@@60 i@@89))
)))
(assert (forall ((v@@61 T@Vec_6673) (i@@90 Int) ) (! (= (InRangeVec_25002 v@@61 i@@90)  (and (>= i@@90 0) (< i@@90 (|l#Vec_6673| v@@61))))
 :qid |boogiebpl.123:24|
 :skolemid |3|
 :pattern ( (InRangeVec_25002 v@@61 i@@90))
)))
(assert (forall ((v@@62 T@Vec_67815) (i@@91 Int) ) (! (= (InRangeVec_67819 v@@62 i@@91)  (and (>= i@@91 0) (< i@@91 (|l#Vec_67815| v@@62))))
 :qid |boogiebpl.123:24|
 :skolemid |3|
 :pattern ( (InRangeVec_67819 v@@62 i@@91))
)))
(assert (forall ((v@@63 T@Vec_68162) (i@@92 Int) ) (! (= (InRangeVec_68166 v@@63 i@@92)  (and (>= i@@92 0) (< i@@92 (|l#Vec_68162| v@@63))))
 :qid |boogiebpl.123:24|
 :skolemid |3|
 :pattern ( (InRangeVec_68166 v@@63 i@@92))
)))
(assert (forall ((t@@26 T@$TypeParamInfo) ) (!  (=> (|$IsEqual'vec'u8''| ($TypeName t@@26) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 50) 2 53) 3 54) 4)) (is-$TypeParamU256 t@@26))
 :qid |boogiebpl.6534:15|
 :skolemid |258|
 :pattern ( ($TypeName t@@26))
)))
(assert (forall ((limit Int) ) (! (let ((agg@@2 ($1_aggregator_factory_spec_new_aggregator limit)))
(= ($1_aggregator_spec_aggregator_get_val agg@@2) 0))
 :qid |boogiebpl.300:15|
 :skolemid |13|
 :pattern ( ($1_aggregator_factory_spec_new_aggregator limit))
)))
(assert (forall ((limit@@0 Int) ) (! (let ((agg@@3 ($1_aggregator_factory_spec_new_aggregator limit@@0)))
(= (|$limit#$1_aggregator_Aggregator| agg@@3) limit@@0))
 :qid |boogiebpl.296:15|
 :skolemid |12|
 :pattern ( ($1_aggregator_factory_spec_new_aggregator limit@@0))
)))
(assert (forall ((v@@64 Int) ) (! (let ((r@@0 (|$1_bcs_serialize'address'| v@@64)))
(= (|l#Vec_6673| r@@0) $serialized_address_len))
 :qid |boogiebpl.6484:15|
 :skolemid |244|
 :pattern ( (|$1_bcs_serialize'address'| v@@64))
)))
(assert (forall ((r@@1 T@$Range) (i@@93 Int) ) (! (= ($InRange r@@1 i@@93)  (and (<= (|lb#$Range| r@@1) i@@93) (< i@@93 (|ub#$Range| r@@1))))
 :qid |boogiebpl.1119:19|
 :skolemid |28|
 :pattern ( ($InRange r@@1 i@@93))
)))
(assert (= $MAX_U32 4294967295))
(assert (= $MAX_U8 255))
(assert (= $MAX_U64 18446744073709551615))
(assert (= $MAX_U16 65535))
(assert (forall ((t@@27 T@$TypeParamInfo) ) (!  (=> (|$IsEqual'vec'u8''| ($TypeName t@@27) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 97) 1 100) 2 100) 3 114) 4 101) 5 115) 6 115) 7)) (is-$TypeParamAddress t@@27))
 :qid |boogiebpl.6536:15|
 :skolemid |260|
 :pattern ( ($TypeName t@@27))
)))
(assert (= $MAX_U256 115792089237316195423570985008687907853269984665640564039457584007913129639935))
(assert (= $EXEC_FAILURE_CODE (- 0 1)))
(assert (forall ((s@@37 T@$1_type_info_TypeInfo) ) (! (= (|$IsValid'$1_type_info_TypeInfo'| s@@37)  (and (and (|$IsValid'address'| (|$account_address#$1_type_info_TypeInfo| s@@37)) (|$IsValid'vec'u8''| (|$module_name#$1_type_info_TypeInfo| s@@37))) (|$IsValid'vec'u8''| (|$struct_name#$1_type_info_TypeInfo| s@@37))))
 :qid |boogiebpl.7384:42|
 :skolemid |389|
 :pattern ( (|$IsValid'$1_type_info_TypeInfo'| s@@37))
)))
(push 1)
(declare-fun ControlFlow (Int Int) Int)
(set-info :boogie-vc-id $1_Bbay_init_module$verify)
(set-option :timeout 40000)
(set-option :rlimit 0)
(set-option :model_validate true)
(set-option :smt.QI.EAGER_THRESHOLD 100)
(set-option :smt.QI.LAZY_THRESHOLD 100)
(set-option :trace true)
(set-option :trace_file_name z3.trace)
(set-option :smt.random_seed 1)
(set-option :smt.mbqi false)
(set-option :model.compact false)
(set-option :model.v2 true)
(set-option :pp.bv_literals false)
(assert (not
 (=> (= (ControlFlow 0 0) 17) true)
))
(check-sat)
(get-info :rlimit)
(pop 1)
; Valid
(reset)
(set-option :print-success false)
(set-info :smt-lib-version 2.6)
(set-option :produce-models true)
(set-option :model_validate true)
(set-option :smt.QI.EAGER_THRESHOLD 100)
(set-option :smt.QI.LAZY_THRESHOLD 100)
(set-option :trace true)
(set-option :trace_file_name z3.trace)
(set-option :smt.random_seed 1)
(set-option :smt.mbqi false)
(set-option :model.compact false)
(set-option :model.v2 true)
(set-option :pp.bv_literals false)
; done setting options


(declare-fun tickleBool (Bool) Bool)
(assert (and (tickleBool true) (tickleBool false)))
(declare-sort |T@#0| 0)
(declare-sort |T@[Int]#0| 0)
(declare-sort |T@[Int]Int| 0)
(declare-sort |T@[Int]$1_aggregator_Aggregator| 0)
(declare-sort |T@[Int]$1_optional_aggregator_Integer| 0)
(declare-sort |T@[Int]$1_optional_aggregator_OptionalAggregator| 0)
(declare-sort |T@[Int](_ BitVec 64)| 0)
(declare-sort |T@[Int](_ BitVec 8)| 0)
(declare-sort |T@[Int]Bool| 0)
(declare-sort |T@[Int]Vec_6673| 0)
(declare-sort |T@[Int]$1_account_Account| 0)
(declare-sort |T@[Int]$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| 0)
(declare-sort |T@[Int]$1_coin_CoinInfo'#0'| 0)
(declare-sort |T@[Int]$1_coin_CoinStore'$1_aptos_coin_AptosCoin'| 0)
(declare-sort |T@[Int]$1_coin_CoinStore'#0'| 0)
(declare-sort |T@[Int]$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'| 0)
(declare-sort |T@[Int]$1_coin_Ghost$supply'#0'| 0)
(declare-sort |T@[Int]$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'| 0)
(declare-sort |T@[Int]$1_coin_Ghost$aggregate_supply'#0'| 0)
(declare-sort |T@[Int]$1_aptos_coin_AptosCoin| 0)
(declare-sort |T@[Int]$1_Bbay_Owner| 0)
(declare-sort |T@[Int]$1_Bbay_Products| 0)
(declare-sort |T@[Int]$1_Bbay_ResourceAccountSignerCap| 0)
(declare-sort |T@[Int]$1_Bbay_User| 0)
(declare-datatypes ((T@$Memory_132314 0)) ((($Memory_132314 (|domain#$Memory_132314| |T@[Int]Bool|) (|contents#$Memory_132314| |T@[Int]#0|) ) ) ))
(declare-datatypes ((T@Vec_68162 0)) (((Vec_68162 (|v#Vec_68162| |T@[Int](_ BitVec 8)|) (|l#Vec_68162| Int) ) ) ))
(declare-datatypes ((T@Vec_67815 0)) (((Vec_67815 (|v#Vec_67815| |T@[Int](_ BitVec 64)|) (|l#Vec_67815| Int) ) ) ))
(declare-datatypes ((T@Vec_85428 0)) (((Vec_85428 (|v#Vec_85428| |T@[Int]#0|) (|l#Vec_85428| Int) ) ) ))
(declare-datatypes ((T@Table_35290_35291 0)) (((Table_35290_35291 (|v#Table_35290_35291| |T@[Int]Bool|) (|e#Table_35290_35291| |T@[Int]Bool|) (|l#Table_35290_35291| Int) ) ) ))
(declare-datatypes ((T@Table_36177_36178 0)) (((Table_36177_36178 (|v#Table_36177_36178| |T@[Int]Int|) (|e#Table_36177_36178| |T@[Int]Bool|) (|l#Table_36177_36178| Int) ) ) ))
(declare-datatypes ((T@$1_Bbay_Owner 0)) ((($1_Bbay_Owner (|$owner_address#$1_Bbay_Owner| Int) (|$user_count#$1_Bbay_Owner| Int) (|$num_of_products_added#$1_Bbay_Owner| Int) (|$resource_account#$1_Bbay_Owner| T@Table_36177_36178) ) ) ))
(declare-datatypes ((T@$Memory_158769 0)) ((($Memory_158769 (|domain#$Memory_158769| |T@[Int]Bool|) (|contents#$Memory_158769| |T@[Int]$1_Bbay_Owner|) ) ) ))
(declare-datatypes ((T@$1_aptos_coin_AptosCoin 0)) ((($1_aptos_coin_AptosCoin (|$dummy_field#$1_aptos_coin_AptosCoin| Bool) ) ) ))
(declare-datatypes ((T@$Memory_158560 0)) ((($Memory_158560 (|domain#$Memory_158560| |T@[Int]Bool|) (|contents#$Memory_158560| |T@[Int]$1_aptos_coin_AptosCoin|) ) ) ))
(declare-datatypes ((|T@$1_coin_Ghost$aggregate_supply'#0'| 0)) (((|$1_coin_Ghost$aggregate_supply'#0'| (|$v#$1_coin_Ghost$aggregate_supply'#0'| Int) ) ) ))
(declare-datatypes ((T@$Memory_152511 0)) ((($Memory_152511 (|domain#$Memory_152511| |T@[Int]Bool|) (|contents#$Memory_152511| |T@[Int]$1_coin_Ghost$aggregate_supply'#0'|) ) ) ))
(declare-datatypes ((|T@$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'| 0)) (((|$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'| (|$v#$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'| Int) ) ) ))
(declare-datatypes ((T@$Memory_152450 0)) ((($Memory_152450 (|domain#$Memory_152450| |T@[Int]Bool|) (|contents#$Memory_152450| |T@[Int]$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'|) ) ) ))
(declare-datatypes ((|T@$1_coin_Ghost$supply'#0'| 0)) (((|$1_coin_Ghost$supply'#0'| (|$v#$1_coin_Ghost$supply'#0'| Int) ) ) ))
(declare-datatypes ((T@$Memory_152389 0)) ((($Memory_152389 (|domain#$Memory_152389| |T@[Int]Bool|) (|contents#$Memory_152389| |T@[Int]$1_coin_Ghost$supply'#0'|) ) ) ))
(declare-datatypes ((|T@$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'| 0)) (((|$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'| (|$v#$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'| Int) ) ) ))
(declare-datatypes ((T@$Memory_152328 0)) ((($Memory_152328 (|domain#$Memory_152328| |T@[Int]Bool|) (|contents#$Memory_152328| |T@[Int]$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'|) ) ) ))
(declare-datatypes ((T@$1_coin_WithdrawEvent 0)) ((($1_coin_WithdrawEvent (|$amount#$1_coin_WithdrawEvent| Int) ) ) ))
(declare-datatypes ((T@$1_coin_DepositEvent 0)) ((($1_coin_DepositEvent (|$amount#$1_coin_DepositEvent| Int) ) ) ))
(declare-datatypes ((|T@$1_coin_Coin'#0'| 0)) (((|$1_coin_Coin'#0'| (|$value#$1_coin_Coin'#0'| Int) ) ) ))
(declare-datatypes ((|T@$1_coin_Coin'$1_aptos_coin_AptosCoin'| 0)) (((|$1_coin_Coin'$1_aptos_coin_AptosCoin'| (|$value#$1_coin_Coin'$1_aptos_coin_AptosCoin'| Int) ) ) ))
(declare-datatypes ((T@$1_account_SignerCapability 0)) ((($1_account_SignerCapability (|$account#$1_account_SignerCapability| Int) ) ) ))
(declare-datatypes ((T@$1_Bbay_ResourceAccountSignerCap 0)) ((($1_Bbay_ResourceAccountSignerCap (|$signer_cap#$1_Bbay_ResourceAccountSignerCap| T@$1_account_SignerCapability) ) ) ))
(declare-datatypes ((T@$Memory_159333 0)) ((($Memory_159333 (|domain#$Memory_159333| |T@[Int]Bool|) (|contents#$Memory_159333| |T@[Int]$1_Bbay_ResourceAccountSignerCap|) ) ) ))
(declare-datatypes ((T@$1_account_RotationCapability 0)) ((($1_account_RotationCapability (|$account#$1_account_RotationCapability| Int) ) ) ))
(declare-datatypes ((T@$1_guid_ID 0)) ((($1_guid_ID (|$creation_num#$1_guid_ID| Int) (|$addr#$1_guid_ID| Int) ) ) ))
(declare-datatypes ((T@$1_guid_GUID 0)) ((($1_guid_GUID (|$id#$1_guid_GUID| T@$1_guid_ID) ) ) ))
(declare-datatypes ((|T@$1_event_EventHandle'$1_coin_WithdrawEvent'| 0)) (((|$1_event_EventHandle'$1_coin_WithdrawEvent'| (|$counter#$1_event_EventHandle'$1_coin_WithdrawEvent'| Int) (|$guid#$1_event_EventHandle'$1_coin_WithdrawEvent'| T@$1_guid_GUID) ) ) ))
(declare-datatypes ((|T@$1_event_EventHandle'$1_coin_DepositEvent'| 0)) (((|$1_event_EventHandle'$1_coin_DepositEvent'| (|$counter#$1_event_EventHandle'$1_coin_DepositEvent'| Int) (|$guid#$1_event_EventHandle'$1_coin_DepositEvent'| T@$1_guid_GUID) ) ) ))
(declare-datatypes ((|T@$1_coin_CoinStore'#0'| 0)) (((|$1_coin_CoinStore'#0'| (|$coin#$1_coin_CoinStore'#0'| |T@$1_coin_Coin'#0'|) (|$frozen#$1_coin_CoinStore'#0'| Bool) (|$deposit_events#$1_coin_CoinStore'#0'| |T@$1_event_EventHandle'$1_coin_DepositEvent'|) (|$withdraw_events#$1_coin_CoinStore'#0'| |T@$1_event_EventHandle'$1_coin_WithdrawEvent'|) ) ) ))
(declare-datatypes ((T@$Memory_152181 0)) ((($Memory_152181 (|domain#$Memory_152181| |T@[Int]Bool|) (|contents#$Memory_152181| |T@[Int]$1_coin_CoinStore'#0'|) ) ) ))
(declare-datatypes ((|T@$1_coin_CoinStore'$1_aptos_coin_AptosCoin'| 0)) (((|$1_coin_CoinStore'$1_aptos_coin_AptosCoin'| (|$coin#$1_coin_CoinStore'$1_aptos_coin_AptosCoin'| |T@$1_coin_Coin'$1_aptos_coin_AptosCoin'|) (|$frozen#$1_coin_CoinStore'$1_aptos_coin_AptosCoin'| Bool) (|$deposit_events#$1_coin_CoinStore'$1_aptos_coin_AptosCoin'| |T@$1_event_EventHandle'$1_coin_DepositEvent'|) (|$withdraw_events#$1_coin_CoinStore'$1_aptos_coin_AptosCoin'| |T@$1_event_EventHandle'$1_coin_WithdrawEvent'|) ) ) ))
(declare-datatypes ((T@$Memory_151955 0)) ((($Memory_151955 (|domain#$Memory_151955| |T@[Int]Bool|) (|contents#$Memory_151955| |T@[Int]$1_coin_CoinStore'$1_aptos_coin_AptosCoin'|) ) ) ))
(declare-datatypes ((|T@$1_event_EventHandle'$1_account_KeyRotationEvent'| 0)) (((|$1_event_EventHandle'$1_account_KeyRotationEvent'| (|$counter#$1_event_EventHandle'$1_account_KeyRotationEvent'| Int) (|$guid#$1_event_EventHandle'$1_account_KeyRotationEvent'| T@$1_guid_GUID) ) ) ))
(declare-datatypes ((|T@$1_event_EventHandle'$1_account_CoinRegisterEvent'| 0)) (((|$1_event_EventHandle'$1_account_CoinRegisterEvent'| (|$counter#$1_event_EventHandle'$1_account_CoinRegisterEvent'| Int) (|$guid#$1_event_EventHandle'$1_account_CoinRegisterEvent'| T@$1_guid_GUID) ) ) ))
(declare-datatypes ((T@$1_optional_aggregator_Integer 0)) ((($1_optional_aggregator_Integer (|$value#$1_optional_aggregator_Integer| Int) (|$limit#$1_optional_aggregator_Integer| Int) ) ) ))
(declare-datatypes ((T@Vec_95276 0)) (((Vec_95276 (|v#Vec_95276| |T@[Int]$1_optional_aggregator_Integer|) (|l#Vec_95276| Int) ) ) ))
(declare-datatypes ((|T@$1_option_Option'$1_optional_aggregator_Integer'| 0)) (((|$1_option_Option'$1_optional_aggregator_Integer'| (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| T@Vec_95276) ) ) ))
(declare-datatypes ((T@Vec_6673 0)) (((Vec_6673 (|v#Vec_6673| |T@[Int]Int|) (|l#Vec_6673| Int) ) ) ))
(declare-datatypes ((T@Table_37064_126051 0)) (((Table_37064_126051 (|v#Table_37064_126051| |T@[Int]Vec_6673|) (|e#Table_37064_126051| |T@[Int]Bool|) (|l#Table_37064_126051| Int) ) ) ))
(declare-datatypes ((T@$1_Bbay_User 0)) ((($1_Bbay_User (|$user_id#$1_Bbay_User| Int) (|$orders#$1_Bbay_User| T@Vec_6673) (|$order_status#$1_Bbay_User| T@Vec_6673) (|$payment_status#$1_Bbay_User| T@Vec_6673) ) ) ))
(declare-datatypes ((T@$Memory_159573 0)) ((($Memory_159573 (|domain#$Memory_159573| |T@[Int]Bool|) (|contents#$Memory_159573| |T@[Int]$1_Bbay_User|) ) ) ))
(declare-datatypes ((T@$1_Bbay_Products 0)) ((($1_Bbay_Products (|$sr_number#$1_Bbay_Products| T@Table_36177_36178) (|$item_id#$1_Bbay_Products| T@Vec_6673) (|$item_name#$1_Bbay_Products| T@Table_37064_126051) (|$item_sold#$1_Bbay_Products| T@Table_35290_35291) (|$item_price#$1_Bbay_Products| T@Table_36177_36178) (|$item_on_selling#$1_Bbay_Products| T@Table_35290_35291) ) ) ))
(declare-datatypes ((T@$Memory_159266 0)) ((($Memory_159266 (|domain#$Memory_159266| |T@[Int]Bool|) (|contents#$Memory_159266| |T@[Int]$1_Bbay_Products|) ) ) ))
(declare-datatypes ((T@$1_account_KeyRotationEvent 0)) ((($1_account_KeyRotationEvent (|$old_authentication_key#$1_account_KeyRotationEvent| T@Vec_6673) (|$new_authentication_key#$1_account_KeyRotationEvent| T@Vec_6673) ) ) ))
(declare-datatypes ((T@$1_type_info_TypeInfo 0)) ((($1_type_info_TypeInfo (|$account_address#$1_type_info_TypeInfo| Int) (|$module_name#$1_type_info_TypeInfo| T@Vec_6673) (|$struct_name#$1_type_info_TypeInfo| T@Vec_6673) ) ) ))
(declare-datatypes ((T@$1_account_CoinRegisterEvent 0)) ((($1_account_CoinRegisterEvent (|$type_info#$1_account_CoinRegisterEvent| T@$1_type_info_TypeInfo) ) ) ))
(declare-datatypes ((T@$1_string_String 0)) ((($1_string_String (|$bytes#$1_string_String| T@Vec_6673) ) ) ))
(declare-datatypes ((|T@$1_option_Option'address'| 0)) (((|$1_option_Option'address'| (|$vec#$1_option_Option'address'| T@Vec_6673) ) ) ))
(declare-datatypes ((|T@$1_account_CapabilityOffer'$1_account_SignerCapability'| 0)) (((|$1_account_CapabilityOffer'$1_account_SignerCapability'| (|$for#$1_account_CapabilityOffer'$1_account_SignerCapability'| |T@$1_option_Option'address'|) ) ) ))
(declare-datatypes ((|T@$1_account_CapabilityOffer'$1_account_RotationCapability'| 0)) (((|$1_account_CapabilityOffer'$1_account_RotationCapability'| (|$for#$1_account_CapabilityOffer'$1_account_RotationCapability'| |T@$1_option_Option'address'|) ) ) ))
(declare-datatypes ((T@$1_account_Account 0)) ((($1_account_Account (|$authentication_key#$1_account_Account| T@Vec_6673) (|$sequence_number#$1_account_Account| Int) (|$guid_creation_num#$1_account_Account| Int) (|$coin_register_events#$1_account_Account| |T@$1_event_EventHandle'$1_account_CoinRegisterEvent'|) (|$key_rotation_events#$1_account_Account| |T@$1_event_EventHandle'$1_account_KeyRotationEvent'|) (|$rotation_capability_offer#$1_account_Account| |T@$1_account_CapabilityOffer'$1_account_RotationCapability'|) (|$signer_capability_offer#$1_account_Account| |T@$1_account_CapabilityOffer'$1_account_SignerCapability'|) ) ) ))
(declare-datatypes ((T@$Memory_145744 0)) ((($Memory_145744 (|domain#$Memory_145744| |T@[Int]Bool|) (|contents#$Memory_145744| |T@[Int]$1_account_Account|) ) ) ))
(declare-datatypes ((T@$TypeParamInfo 0)) ((($TypeParamBool ) ($TypeParamU8 ) ($TypeParamU16 ) ($TypeParamU32 ) ($TypeParamU64 ) ($TypeParamU128 ) ($TypeParamU256 ) ($TypeParamAddress ) ($TypeParamSigner ) ($TypeParamVector (|e#$TypeParamVector| T@$TypeParamInfo) ) ($TypeParamStruct (|a#$TypeParamStruct| Int) (|m#$TypeParamStruct| T@Vec_6673) (|s#$TypeParamStruct| T@Vec_6673) ) ) ))
(declare-datatypes ((T@$signer 0)) ((($signer (|$addr#$signer| Int) ) ) ))
(declare-datatypes ((T@$Location 0)) ((($Global (|a#$Global| Int) ) ($Local (|i#$Local| Int) ) ($Param (|i#$Param| Int) ) ($Uninitialized ) ) ))
(declare-datatypes ((T@$Mutation_163035 0)) ((($Mutation_163035 (|l#$Mutation_163035| T@$Location) (|p#$Mutation_163035| T@Vec_6673) (|v#$Mutation_163035| T@$1_Bbay_User) ) ) ))
(declare-datatypes ((T@$Mutation_159617 0)) ((($Mutation_159617 (|l#$Mutation_159617| T@$Location) (|p#$Mutation_159617| T@Vec_6673) (|v#$Mutation_159617| T@$1_Bbay_Products) ) ) ))
(declare-datatypes ((T@$Mutation_159596 0)) ((($Mutation_159596 (|l#$Mutation_159596| T@$Location) (|p#$Mutation_159596| T@Vec_6673) (|v#$Mutation_159596| T@$1_Bbay_Owner) ) ) ))
(declare-datatypes ((T@$Mutation_157471 0)) ((($Mutation_157471 (|l#$Mutation_157471| T@$Location) (|p#$Mutation_157471| T@Vec_6673) (|v#$Mutation_157471| |T@$1_event_EventHandle'$1_coin_WithdrawEvent'|) ) ) ))
(declare-datatypes ((T@$Mutation_153706 0)) ((($Mutation_153706 (|l#$Mutation_153706| T@$Location) (|p#$Mutation_153706| T@Vec_6673) (|v#$Mutation_153706| |T@$1_event_EventHandle'$1_coin_DepositEvent'|) ) ) ))
(declare-datatypes ((T@$Mutation_153678 0)) ((($Mutation_153678 (|l#$Mutation_153678| T@$Location) (|p#$Mutation_153678| T@Vec_6673) (|v#$Mutation_153678| |T@$1_coin_CoinStore'#0'|) ) ) ))
(declare-datatypes ((T@$Mutation_152557 0)) ((($Mutation_152557 (|l#$Mutation_152557| T@$Location) (|p#$Mutation_152557| T@Vec_6673) (|v#$Mutation_152557| |T@$1_coin_Ghost$supply'#0'|) ) ) ))
(declare-datatypes ((T@$Mutation_152529 0)) ((($Mutation_152529 (|l#$Mutation_152529| T@$Location) (|p#$Mutation_152529| T@Vec_6673) (|v#$Mutation_152529| |T@$1_coin_Coin'#0'|) ) ) ))
(declare-datatypes ((T@$Mutation_149976 0)) ((($Mutation_149976 (|l#$Mutation_149976| T@$Location) (|p#$Mutation_149976| T@Vec_6673) (|v#$Mutation_149976| |T@$1_event_EventHandle'$1_account_CoinRegisterEvent'|) ) ) ))
(declare-datatypes ((T@$Mutation_148229 0)) ((($Mutation_148229 (|l#$Mutation_148229| T@$Location) (|p#$Mutation_148229| T@Vec_6673) (|v#$Mutation_148229| |T@$1_option_Option'address'|) ) ) ))
(declare-datatypes ((T@$Mutation_148208 0)) ((($Mutation_148208 (|l#$Mutation_148208| T@$Location) (|p#$Mutation_148208| T@Vec_6673) (|v#$Mutation_148208| |T@$1_account_CapabilityOffer'$1_account_SignerCapability'|) ) ) ))
(declare-datatypes ((T@$Mutation_147502 0)) ((($Mutation_147502 (|l#$Mutation_147502| T@$Location) (|p#$Mutation_147502| T@Vec_6673) (|v#$Mutation_147502| T@$1_account_Account) ) ) ))
(declare-datatypes ((T@$Mutation_126518 0)) ((($Mutation_126518 (|l#$Mutation_126518| T@$Location) (|p#$Mutation_126518| T@Vec_6673) (|v#$Mutation_126518| T@Table_37064_126051) ) ) ))
(declare-datatypes ((T@$Mutation_124844 0)) ((($Mutation_124844 (|l#$Mutation_124844| T@$Location) (|p#$Mutation_124844| T@Vec_6673) (|v#$Mutation_124844| T@Table_36177_36178) ) ) ))
(declare-datatypes ((T@$Mutation_35848 0)) ((($Mutation_35848 (|l#$Mutation_35848| T@$Location) (|p#$Mutation_35848| T@Vec_6673) (|v#$Mutation_35848| Bool) ) ) ))
(declare-datatypes ((T@$Mutation_123244 0)) ((($Mutation_123244 (|l#$Mutation_123244| T@$Location) (|p#$Mutation_123244| T@Vec_6673) (|v#$Mutation_123244| T@Table_35290_35291) ) ) ))
(declare-datatypes ((T@$Mutation_68425 0)) ((($Mutation_68425 (|l#$Mutation_68425| T@$Location) (|p#$Mutation_68425| T@Vec_6673) (|v#$Mutation_68425| (_ BitVec 8)) ) ) ))
(declare-datatypes ((T@$Mutation_119685 0)) ((($Mutation_119685 (|l#$Mutation_119685| T@$Location) (|p#$Mutation_119685| T@Vec_6673) (|v#$Mutation_119685| T@Vec_68162) ) ) ))
(declare-datatypes ((T@$Mutation_68078 0)) ((($Mutation_68078 (|l#$Mutation_68078| T@$Location) (|p#$Mutation_68078| T@Vec_6673) (|v#$Mutation_68078| (_ BitVec 64)) ) ) ))
(declare-datatypes ((T@$Mutation_115844 0)) ((($Mutation_115844 (|l#$Mutation_115844| T@$Location) (|p#$Mutation_115844| T@Vec_6673) (|v#$Mutation_115844| T@Vec_67815) ) ) ))
(declare-datatypes ((T@$Mutation_26543 0)) ((($Mutation_26543 (|l#$Mutation_26543| T@$Location) (|p#$Mutation_26543| T@Vec_6673) (|v#$Mutation_26543| Int) ) ) ))
(declare-datatypes ((T@$Mutation_105895 0)) ((($Mutation_105895 (|l#$Mutation_105895| T@$Location) (|p#$Mutation_105895| T@Vec_6673) (|v#$Mutation_105895| T@Vec_6673) ) ) ))
(declare-datatypes ((T@$Mutation_99099 0)) ((($Mutation_99099 (|l#$Mutation_99099| T@$Location) (|p#$Mutation_99099| T@Vec_6673) (|v#$Mutation_99099| T@$1_optional_aggregator_Integer) ) ) ))
(declare-datatypes ((T@$Mutation_96128 0)) ((($Mutation_96128 (|l#$Mutation_96128| T@$Location) (|p#$Mutation_96128| T@Vec_6673) (|v#$Mutation_96128| T@Vec_95276) ) ) ))
(declare-datatypes ((T@$Mutation_89266 0)) ((($Mutation_89266 (|l#$Mutation_89266| T@$Location) (|p#$Mutation_89266| T@Vec_6673) (|v#$Mutation_89266| |T@#0|) ) ) ))
(declare-datatypes ((T@$Mutation_86282 0)) ((($Mutation_86282 (|l#$Mutation_86282| T@$Location) (|p#$Mutation_86282| T@Vec_6673) (|v#$Mutation_86282| T@Vec_85428) ) ) ))
(declare-datatypes ((T@$Range 0)) ((($Range (|lb#$Range| Int) (|ub#$Range| Int) ) ) ))
(declare-datatypes ((T@$1_aggregator_Aggregator 0)) ((($1_aggregator_Aggregator (|$handle#$1_aggregator_Aggregator| Int) (|$key#$1_aggregator_Aggregator| Int) (|$limit#$1_aggregator_Aggregator| Int) (|$val#$1_aggregator_Aggregator| Int) ) ) ))
(declare-datatypes ((T@$Mutation_94200 0)) ((($Mutation_94200 (|l#$Mutation_94200| T@$Location) (|p#$Mutation_94200| T@Vec_6673) (|v#$Mutation_94200| T@$1_aggregator_Aggregator) ) ) ))
(declare-datatypes ((T@Vec_90390 0)) (((Vec_90390 (|v#Vec_90390| |T@[Int]$1_aggregator_Aggregator|) (|l#Vec_90390| Int) ) ) ))
(declare-datatypes ((T@$Mutation_91229 0)) ((($Mutation_91229 (|l#$Mutation_91229| T@$Location) (|p#$Mutation_91229| T@Vec_6673) (|v#$Mutation_91229| T@Vec_90390) ) ) ))
(declare-datatypes ((|T@$1_option_Option'$1_aggregator_Aggregator'| 0)) (((|$1_option_Option'$1_aggregator_Aggregator'| (|$vec#$1_option_Option'$1_aggregator_Aggregator'| T@Vec_90390) ) ) ))
(declare-datatypes ((T@$1_optional_aggregator_OptionalAggregator 0)) ((($1_optional_aggregator_OptionalAggregator (|$aggregator#$1_optional_aggregator_OptionalAggregator| |T@$1_option_Option'$1_aggregator_Aggregator'|) (|$integer#$1_optional_aggregator_OptionalAggregator| |T@$1_option_Option'$1_optional_aggregator_Integer'|) ) ) ))
(declare-datatypes ((T@$Mutation_104095 0)) ((($Mutation_104095 (|l#$Mutation_104095| T@$Location) (|p#$Mutation_104095| T@Vec_6673) (|v#$Mutation_104095| T@$1_optional_aggregator_OptionalAggregator) ) ) ))
(declare-datatypes ((T@Vec_100175 0)) (((Vec_100175 (|v#Vec_100175| |T@[Int]$1_optional_aggregator_OptionalAggregator|) (|l#Vec_100175| Int) ) ) ))
(declare-datatypes ((T@$Mutation_101124 0)) ((($Mutation_101124 (|l#$Mutation_101124| T@$Location) (|p#$Mutation_101124| T@Vec_6673) (|v#$Mutation_101124| T@Vec_100175) ) ) ))
(declare-datatypes ((|T@$1_option_Option'$1_optional_aggregator_OptionalAggregator'| 0)) (((|$1_option_Option'$1_optional_aggregator_OptionalAggregator'| (|$vec#$1_option_Option'$1_optional_aggregator_OptionalAggregator'| T@Vec_100175) ) ) ))
(declare-datatypes ((|T@$1_coin_CoinInfo'#0'| 0)) (((|$1_coin_CoinInfo'#0'| (|$name#$1_coin_CoinInfo'#0'| T@$1_string_String) (|$symbol#$1_coin_CoinInfo'#0'| T@$1_string_String) (|$decimals#$1_coin_CoinInfo'#0'| Int) (|$supply#$1_coin_CoinInfo'#0'| |T@$1_option_Option'$1_optional_aggregator_OptionalAggregator'|) ) ) ))
(declare-datatypes ((T@$Memory_151729 0)) ((($Memory_151729 (|domain#$Memory_151729| |T@[Int]Bool|) (|contents#$Memory_151729| |T@[Int]$1_coin_CoinInfo'#0'|) ) ) ))
(declare-datatypes ((|T@$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| 0)) (((|$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| (|$name#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| T@$1_string_String) (|$symbol#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| T@$1_string_String) (|$decimals#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| Int) (|$supply#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| |T@$1_option_Option'$1_optional_aggregator_OptionalAggregator'|) ) ) ))
(declare-datatypes ((T@$Memory_151507 0)) ((($Memory_151507 (|domain#$Memory_151507| |T@[Int]Bool|) (|contents#$Memory_151507| |T@[Int]$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'|) ) ) ))
(declare-fun $MAX_U128 () Int)
(declare-fun $shlU256 (Int Int) Int)
(declare-fun $pow (Int Int) Int)
(declare-fun $TypeName (T@$TypeParamInfo) T@Vec_6673)
(declare-fun |$IsEqual'vec'u8''| (T@Vec_6673 T@Vec_6673) Bool)
(declare-fun |Store__T@[Int]Int_| (|T@[Int]Int| Int Int) |T@[Int]Int|)
(declare-fun |Select__T@[Int]Int_| (|T@[Int]Int| Int) Int)
(assert (forall ( ( ?x0 |T@[Int]Int|) ( ?x1 Int) ( ?x2 Int)) (! (= (|Select__T@[Int]Int_| (|Store__T@[Int]Int_| ?x0 ?x1 ?x2) ?x1)  ?x2) :weight 0)))
(assert (forall ( ( ?x0 |T@[Int]Int|) ( ?x1 Int) ( ?y1 Int) ( ?x2 Int)) (! (=>  (not (= ?x1 ?y1)) (= (|Select__T@[Int]Int_| (|Store__T@[Int]Int_| ?x0 ?x1 ?x2) ?y1) (|Select__T@[Int]Int_| ?x0 ?y1))) :weight 0)))
(declare-fun MapConstVec_25347 (Int) |T@[Int]Int|)
(declare-fun DefaultVecElem_25347 () Int)
(declare-fun |Select__T@[Int]#0_| (|T@[Int]#0| Int) |T@#0|)
(declare-fun |lambda#1| (Int Int |T@[Int]#0| Int Int |T@#0|) |T@[Int]#0|)
(declare-fun |Select__T@[Int]$1_aggregator_Aggregator_| (|T@[Int]$1_aggregator_Aggregator| Int) T@$1_aggregator_Aggregator)
(declare-fun |lambda#5| (Int Int |T@[Int]$1_aggregator_Aggregator| Int Int T@$1_aggregator_Aggregator) |T@[Int]$1_aggregator_Aggregator|)
(declare-fun |Select__T@[Int]$1_optional_aggregator_Integer_| (|T@[Int]$1_optional_aggregator_Integer| Int) T@$1_optional_aggregator_Integer)
(declare-fun |lambda#9| (Int Int |T@[Int]$1_optional_aggregator_Integer| Int Int T@$1_optional_aggregator_Integer) |T@[Int]$1_optional_aggregator_Integer|)
(declare-fun |Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|T@[Int]$1_optional_aggregator_OptionalAggregator| Int) T@$1_optional_aggregator_OptionalAggregator)
(declare-fun |lambda#13| (Int Int |T@[Int]$1_optional_aggregator_OptionalAggregator| Int Int T@$1_optional_aggregator_OptionalAggregator) |T@[Int]$1_optional_aggregator_OptionalAggregator|)
(declare-fun |lambda#17| (Int Int |T@[Int]Int| Int Int Int) |T@[Int]Int|)
(declare-fun |Select__T@[Int](_ BitVec 64)_| (|T@[Int](_ BitVec 64)| Int) (_ BitVec 64))
(declare-fun |lambda#21| (Int Int |T@[Int](_ BitVec 64)| Int Int (_ BitVec 64)) |T@[Int](_ BitVec 64)|)
(declare-fun |Select__T@[Int](_ BitVec 8)_| (|T@[Int](_ BitVec 8)| Int) (_ BitVec 8))
(declare-fun |lambda#25| (Int Int |T@[Int](_ BitVec 8)| Int Int (_ BitVec 8)) |T@[Int](_ BitVec 8)|)
(declare-fun $shr (Int Int) Int)
(declare-fun |$IsValid'$1_aggregator_Aggregator'| (T@$1_aggregator_Aggregator) Bool)
(declare-fun |$IsValid'address'| (Int) Bool)
(declare-fun |$IsValid'u128'| (Int) Bool)
(declare-fun |$IsValid'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| (|T@$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'|) Bool)
(declare-fun |$IsValid'$1_string_String'| (T@$1_string_String) Bool)
(declare-fun |$IsValid'u8'| (Int) Bool)
(declare-fun |$IsValid'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| (|T@$1_option_Option'$1_optional_aggregator_OptionalAggregator'|) Bool)
(declare-fun |$IsValid'$1_coin_CoinInfo'#0''| (|T@$1_coin_CoinInfo'#0'|) Bool)
(declare-fun |$IsValid'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''| (|T@$1_coin_CoinStore'$1_aptos_coin_AptosCoin'|) Bool)
(declare-fun |$IsValid'$1_coin_Coin'$1_aptos_coin_AptosCoin''| (|T@$1_coin_Coin'$1_aptos_coin_AptosCoin'|) Bool)
(declare-fun |$IsValid'$1_event_EventHandle'$1_coin_DepositEvent''| (|T@$1_event_EventHandle'$1_coin_DepositEvent'|) Bool)
(declare-fun |$IsValid'$1_event_EventHandle'$1_coin_WithdrawEvent''| (|T@$1_event_EventHandle'$1_coin_WithdrawEvent'|) Bool)
(declare-fun |$IsValid'$1_coin_CoinStore'#0''| (|T@$1_coin_CoinStore'#0'|) Bool)
(declare-fun |$IsValid'$1_coin_Coin'#0''| (|T@$1_coin_Coin'#0'|) Bool)
(declare-fun |$IsValid'$1_Bbay_Owner'| (T@$1_Bbay_Owner) Bool)
(declare-fun |$IsValid'u64'| (Int) Bool)
(declare-fun |$IsValid'$1_table_Table'address_address''| (T@Table_36177_36178) Bool)
(declare-fun |$IsValid'$1_Bbay_User'| (T@$1_Bbay_User) Bool)
(declare-fun |$IsValid'vec'u64''| (T@Vec_6673) Bool)
(declare-fun $ConstMemoryDomain (Bool) |T@[Int]Bool|)
(declare-fun |lambda#28| (Bool) |T@[Int]Bool|)
(declare-fun |$IsValid'$1_optional_aggregator_Integer'| (T@$1_optional_aggregator_Integer) Bool)
(declare-fun |$IsValid'$1_optional_aggregator_OptionalAggregator'| (T@$1_optional_aggregator_OptionalAggregator) Bool)
(declare-fun |$IsValid'$1_option_Option'$1_aggregator_Aggregator''| (|T@$1_option_Option'$1_aggregator_Aggregator'|) Bool)
(declare-fun |$IsValid'$1_option_Option'$1_optional_aggregator_Integer''| (|T@$1_option_Option'$1_optional_aggregator_Integer'|) Bool)
(declare-fun |$IsValid'$1_guid_ID'| (T@$1_guid_ID) Bool)
(declare-fun |$IsValid'$1_event_EventHandle'$1_account_CoinRegisterEvent''| (|T@$1_event_EventHandle'$1_account_CoinRegisterEvent'|) Bool)
(declare-fun |$IsValid'$1_guid_GUID'| (T@$1_guid_GUID) Bool)
(declare-fun |$IsValid'$1_event_EventHandle'$1_account_KeyRotationEvent''| (|T@$1_event_EventHandle'$1_account_KeyRotationEvent'|) Bool)
(declare-fun |$IsValid'$1_account_KeyRotationEvent'| (T@$1_account_KeyRotationEvent) Bool)
(declare-fun |$IsValid'vec'u8''| (T@Vec_6673) Bool)
(declare-fun |$IsEqual'vec'#0''| (T@Vec_85428 T@Vec_85428) Bool)
(declare-fun InRangeVec_65852 (T@Vec_85428 Int) Bool)
(declare-fun |$IsEqual'vec'$1_aggregator_Aggregator''| (T@Vec_90390 T@Vec_90390) Bool)
(declare-fun InRangeVec_66199 (T@Vec_90390 Int) Bool)
(declare-fun |$IsEqual'vec'$1_optional_aggregator_Integer''| (T@Vec_95276 T@Vec_95276) Bool)
(declare-fun InRangeVec_66546 (T@Vec_95276 Int) Bool)
(declare-fun |$IsEqual'vec'$1_optional_aggregator_OptionalAggregator''| (T@Vec_100175 T@Vec_100175) Bool)
(declare-fun InRangeVec_66893 (T@Vec_100175 Int) Bool)
(declare-fun |$IsEqual'vec'address''| (T@Vec_6673 T@Vec_6673) Bool)
(declare-fun InRangeVec_25002 (T@Vec_6673 Int) Bool)
(declare-fun |$IsEqual'vec'u64''| (T@Vec_6673 T@Vec_6673) Bool)
(declare-fun |$IsEqual'vec'bv64''| (T@Vec_67815 T@Vec_67815) Bool)
(declare-fun InRangeVec_67819 (T@Vec_67815 Int) Bool)
(declare-fun |$IsEqual'vec'bv8''| (T@Vec_68162 T@Vec_68162) Bool)
(declare-fun InRangeVec_68166 (T@Vec_68162 Int) Bool)
(declare-fun |$IsPrefix'vec'#0''| (T@Vec_85428 T@Vec_85428) Bool)
(declare-fun |$IsPrefix'vec'$1_aggregator_Aggregator''| (T@Vec_90390 T@Vec_90390) Bool)
(declare-fun |$IsPrefix'vec'$1_optional_aggregator_Integer''| (T@Vec_95276 T@Vec_95276) Bool)
(declare-fun |$IsPrefix'vec'$1_optional_aggregator_OptionalAggregator''| (T@Vec_100175 T@Vec_100175) Bool)
(declare-fun |$IsPrefix'vec'address''| (T@Vec_6673 T@Vec_6673) Bool)
(declare-fun |$IsPrefix'vec'u64''| (T@Vec_6673 T@Vec_6673) Bool)
(declare-fun |$IsPrefix'vec'u8''| (T@Vec_6673 T@Vec_6673) Bool)
(declare-fun |$IsPrefix'vec'bv64''| (T@Vec_67815 T@Vec_67815) Bool)
(declare-fun |$IsPrefix'vec'bv8''| (T@Vec_68162 T@Vec_68162) Bool)
(declare-fun |$IsEqual'$1_table_Table'u64_bool''| (T@Table_35290_35291 T@Table_35290_35291) Bool)
(declare-fun |Select__T@[Int]Bool_| (|T@[Int]Bool| Int) Bool)
(declare-fun DefaultTableKeyExistsArray_990 () |T@[Int]Bool|)
(declare-fun IndexOfVec_68162 (T@Vec_68162 (_ BitVec 8)) Int)
(declare-fun IndexOfVec_67815 (T@Vec_67815 (_ BitVec 64)) Int)
(declare-fun IndexOfVec_100175 (T@Vec_100175 T@$1_optional_aggregator_OptionalAggregator) Int)
(declare-fun IndexOfVec_95276 (T@Vec_95276 T@$1_optional_aggregator_Integer) Int)
(declare-fun IndexOfVec_90390 (T@Vec_90390 T@$1_aggregator_Aggregator) Int)
(declare-fun IndexOfVec_6673 (T@Vec_6673 Int) Int)
(declare-fun IndexOfVec_85428 (T@Vec_85428 |T@#0|) Int)
(declare-fun $1_Signature_$ed25519_verify (T@Vec_6673 T@Vec_6673 T@Vec_6673) Bool)
(declare-fun |lambda#0| (Int Int Int |T@[Int]#0| |T@[Int]#0| Int |T@#0|) |T@[Int]#0|)
(declare-fun |lambda#4| (Int Int Int |T@[Int]$1_aggregator_Aggregator| |T@[Int]$1_aggregator_Aggregator| Int T@$1_aggregator_Aggregator) |T@[Int]$1_aggregator_Aggregator|)
(declare-fun |lambda#8| (Int Int Int |T@[Int]$1_optional_aggregator_Integer| |T@[Int]$1_optional_aggregator_Integer| Int T@$1_optional_aggregator_Integer) |T@[Int]$1_optional_aggregator_Integer|)
(declare-fun |lambda#12| (Int Int Int |T@[Int]$1_optional_aggregator_OptionalAggregator| |T@[Int]$1_optional_aggregator_OptionalAggregator| Int T@$1_optional_aggregator_OptionalAggregator) |T@[Int]$1_optional_aggregator_OptionalAggregator|)
(declare-fun |lambda#16| (Int Int Int |T@[Int]Int| |T@[Int]Int| Int Int) |T@[Int]Int|)
(declare-fun |lambda#20| (Int Int Int |T@[Int](_ BitVec 64)| |T@[Int](_ BitVec 64)| Int (_ BitVec 64)) |T@[Int](_ BitVec 64)|)
(declare-fun |lambda#24| (Int Int Int |T@[Int](_ BitVec 8)| |T@[Int](_ BitVec 8)| Int (_ BitVec 8)) |T@[Int](_ BitVec 8)|)
(declare-fun |lambda#3| (Int Int Int |T@[Int]#0| |T@[Int]#0| Int |T@#0|) |T@[Int]#0|)
(declare-fun |lambda#7| (Int Int Int |T@[Int]$1_aggregator_Aggregator| |T@[Int]$1_aggregator_Aggregator| Int T@$1_aggregator_Aggregator) |T@[Int]$1_aggregator_Aggregator|)
(declare-fun |lambda#11| (Int Int Int |T@[Int]$1_optional_aggregator_Integer| |T@[Int]$1_optional_aggregator_Integer| Int T@$1_optional_aggregator_Integer) |T@[Int]$1_optional_aggregator_Integer|)
(declare-fun |lambda#15| (Int Int Int |T@[Int]$1_optional_aggregator_OptionalAggregator| |T@[Int]$1_optional_aggregator_OptionalAggregator| Int T@$1_optional_aggregator_OptionalAggregator) |T@[Int]$1_optional_aggregator_OptionalAggregator|)
(declare-fun |lambda#19| (Int Int Int |T@[Int]Int| |T@[Int]Int| Int Int) |T@[Int]Int|)
(declare-fun |lambda#23| (Int Int Int |T@[Int](_ BitVec 64)| |T@[Int](_ BitVec 64)| Int (_ BitVec 64)) |T@[Int](_ BitVec 64)|)
(declare-fun |lambda#27| (Int Int Int |T@[Int](_ BitVec 8)| |T@[Int](_ BitVec 8)| Int (_ BitVec 8)) |T@[Int](_ BitVec 8)|)
(declare-fun |$IsValid'bv32'| ((_ BitVec 32)) Bool)
(declare-fun |$1_bcs_serialize'address'| (Int) T@Vec_6673)
(declare-fun $1_aptos_hash_spec_keccak256 (T@Vec_6673) T@Vec_6673)
(declare-fun $1_aptos_hash_spec_sha2_512_internal (T@Vec_6673) T@Vec_6673)
(declare-fun $1_aptos_hash_spec_sha3_512_internal (T@Vec_6673) T@Vec_6673)
(declare-fun $1_aptos_hash_spec_ripemd160_internal (T@Vec_6673) T@Vec_6673)
(declare-fun $1_aptos_hash_spec_blake2b_256_internal (T@Vec_6673) T@Vec_6673)
(declare-fun |$IsSuffix'vec'#0''| (T@Vec_85428 T@Vec_85428) Bool)
(declare-fun |$IsSuffix'vec'$1_aggregator_Aggregator''| (T@Vec_90390 T@Vec_90390) Bool)
(declare-fun |$IsSuffix'vec'$1_optional_aggregator_Integer''| (T@Vec_95276 T@Vec_95276) Bool)
(declare-fun |$IsSuffix'vec'$1_optional_aggregator_OptionalAggregator''| (T@Vec_100175 T@Vec_100175) Bool)
(declare-fun |$IsSuffix'vec'address''| (T@Vec_6673 T@Vec_6673) Bool)
(declare-fun |$IsSuffix'vec'u64''| (T@Vec_6673 T@Vec_6673) Bool)
(declare-fun |$IsSuffix'vec'u8''| (T@Vec_6673 T@Vec_6673) Bool)
(declare-fun |$IsSuffix'vec'bv64''| (T@Vec_67815 T@Vec_67815) Bool)
(declare-fun |$IsSuffix'vec'bv8''| (T@Vec_68162 T@Vec_68162) Bool)
(declare-fun |lambda#2| (Int Int |T@[Int]#0| Int |T@#0|) |T@[Int]#0|)
(declare-fun |lambda#6| (Int Int |T@[Int]$1_aggregator_Aggregator| Int T@$1_aggregator_Aggregator) |T@[Int]$1_aggregator_Aggregator|)
(declare-fun |lambda#10| (Int Int |T@[Int]$1_optional_aggregator_Integer| Int T@$1_optional_aggregator_Integer) |T@[Int]$1_optional_aggregator_Integer|)
(declare-fun |lambda#14| (Int Int |T@[Int]$1_optional_aggregator_OptionalAggregator| Int T@$1_optional_aggregator_OptionalAggregator) |T@[Int]$1_optional_aggregator_OptionalAggregator|)
(declare-fun |lambda#18| (Int Int |T@[Int]Int| Int Int) |T@[Int]Int|)
(declare-fun |lambda#22| (Int Int |T@[Int](_ BitVec 64)| Int (_ BitVec 64)) |T@[Int](_ BitVec 64)|)
(declare-fun |lambda#26| (Int Int |T@[Int](_ BitVec 8)| Int (_ BitVec 8)) |T@[Int](_ BitVec 8)|)
(declare-fun $1_account_spec_create_resource_address (Int T@Vec_6673) Int)
(declare-fun |$1_from_bcs_deserializable'bool'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'u8'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'u64'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'u128'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'u256'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'address'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'signer'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'vec'u8''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'vec'u64''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'vec'address''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'vec'$1_aggregator_Aggregator''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'vec'$1_optional_aggregator_Integer''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'vec'$1_optional_aggregator_OptionalAggregator''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'vec'#0''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_table_Table'u64_bool''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_table_Table'u64_u64''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_table_Table'u64_vec'u64'''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_table_Table'address_address''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_option_Option'address''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_option_Option'$1_aggregator_Aggregator''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_option_Option'$1_optional_aggregator_Integer''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_string_String'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_type_info_TypeInfo'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_aggregator_Aggregator'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_optional_aggregator_Integer'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_optional_aggregator_OptionalAggregator'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_guid_GUID'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_guid_ID'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_event_EventHandle'$1_account_CoinRegisterEvent''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_event_EventHandle'$1_account_KeyRotationEvent''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_event_EventHandle'$1_coin_DepositEvent''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_event_EventHandle'$1_coin_WithdrawEvent''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_account_Account'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_account_CapabilityOffer'$1_account_RotationCapability''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_account_CapabilityOffer'$1_account_SignerCapability''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_account_CoinRegisterEvent'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_account_SignerCapability'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_Coin'$1_aptos_coin_AptosCoin''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_Coin'#0''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_CoinInfo'#0''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_CoinStore'#0''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_DepositEvent'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_WithdrawEvent'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_Ghost$supply'#0''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_coin_Ghost$aggregate_supply'#0''| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_aptos_coin_AptosCoin'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_Bbay_Owner'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_Bbay_Products'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_Bbay_ResourceAccountSignerCap'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'$1_Bbay_User'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserializable'#0'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserialize'bool'| (T@Vec_6673) Bool)
(declare-fun |$1_from_bcs_deserialize'u8'| (T@Vec_6673) Int)
(declare-fun |$1_from_bcs_deserialize'u64'| (T@Vec_6673) Int)
(declare-fun |$1_from_bcs_deserialize'u128'| (T@Vec_6673) Int)
(declare-fun |$1_from_bcs_deserialize'u256'| (T@Vec_6673) Int)
(declare-fun |$1_from_bcs_deserialize'address'| (T@Vec_6673) Int)
(declare-fun |$1_from_bcs_deserialize'signer'| (T@Vec_6673) T@$signer)
(declare-fun |$1_from_bcs_deserialize'vec'u8''| (T@Vec_6673) T@Vec_6673)
(declare-fun |$1_from_bcs_deserialize'vec'u64''| (T@Vec_6673) T@Vec_6673)
(declare-fun |$1_from_bcs_deserialize'vec'address''| (T@Vec_6673) T@Vec_6673)
(declare-fun |$1_from_bcs_deserialize'vec'$1_aggregator_Aggregator''| (T@Vec_6673) T@Vec_90390)
(declare-fun |$1_from_bcs_deserialize'vec'$1_optional_aggregator_Integer''| (T@Vec_6673) T@Vec_95276)
(declare-fun |$1_from_bcs_deserialize'vec'$1_optional_aggregator_OptionalAggregator''| (T@Vec_6673) T@Vec_100175)
(declare-fun |$1_from_bcs_deserialize'vec'#0''| (T@Vec_6673) T@Vec_85428)
(declare-fun |$1_from_bcs_deserialize'$1_table_Table'u64_bool''| (T@Vec_6673) T@Table_35290_35291)
(declare-fun |$IsEqual'$1_table_Table'u64_u64''| (T@Table_36177_36178 T@Table_36177_36178) Bool)
(declare-fun |$1_from_bcs_deserialize'$1_table_Table'u64_u64''| (T@Vec_6673) T@Table_36177_36178)
(declare-fun |$IsEqual'$1_table_Table'u64_vec'u64'''| (T@Table_37064_126051 T@Table_37064_126051) Bool)
(declare-fun |$1_from_bcs_deserialize'$1_table_Table'u64_vec'u64'''| (T@Vec_6673) T@Table_37064_126051)
(declare-fun |$IsEqual'$1_table_Table'address_address''| (T@Table_36177_36178 T@Table_36177_36178) Bool)
(declare-fun |$1_from_bcs_deserialize'$1_table_Table'address_address''| (T@Vec_6673) T@Table_36177_36178)
(declare-fun |$1_from_bcs_deserialize'$1_option_Option'address''| (T@Vec_6673) |T@$1_option_Option'address'|)
(declare-fun |$1_from_bcs_deserialize'$1_option_Option'$1_aggregator_Aggregator''| (T@Vec_6673) |T@$1_option_Option'$1_aggregator_Aggregator'|)
(declare-fun |$1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_Integer''| (T@Vec_6673) |T@$1_option_Option'$1_optional_aggregator_Integer'|)
(declare-fun |$1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| (T@Vec_6673) |T@$1_option_Option'$1_optional_aggregator_OptionalAggregator'|)
(declare-fun |$1_from_bcs_deserialize'$1_string_String'| (T@Vec_6673) T@$1_string_String)
(declare-fun |$1_from_bcs_deserialize'$1_type_info_TypeInfo'| (T@Vec_6673) T@$1_type_info_TypeInfo)
(declare-fun |$1_from_bcs_deserialize'$1_aggregator_Aggregator'| (T@Vec_6673) T@$1_aggregator_Aggregator)
(declare-fun |$1_from_bcs_deserialize'$1_optional_aggregator_Integer'| (T@Vec_6673) T@$1_optional_aggregator_Integer)
(declare-fun |$1_from_bcs_deserialize'$1_optional_aggregator_OptionalAggregator'| (T@Vec_6673) T@$1_optional_aggregator_OptionalAggregator)
(declare-fun |$1_from_bcs_deserialize'$1_guid_GUID'| (T@Vec_6673) T@$1_guid_GUID)
(declare-fun |$1_from_bcs_deserialize'$1_guid_ID'| (T@Vec_6673) T@$1_guid_ID)
(declare-fun |$1_from_bcs_deserialize'$1_event_EventHandle'$1_account_CoinRegisterEvent''| (T@Vec_6673) |T@$1_event_EventHandle'$1_account_CoinRegisterEvent'|)
(declare-fun |$1_from_bcs_deserialize'$1_event_EventHandle'$1_account_KeyRotationEvent''| (T@Vec_6673) |T@$1_event_EventHandle'$1_account_KeyRotationEvent'|)
(declare-fun |$1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_DepositEvent''| (T@Vec_6673) |T@$1_event_EventHandle'$1_coin_DepositEvent'|)
(declare-fun |$1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_WithdrawEvent''| (T@Vec_6673) |T@$1_event_EventHandle'$1_coin_WithdrawEvent'|)
(declare-fun |$1_from_bcs_deserialize'$1_account_Account'| (T@Vec_6673) T@$1_account_Account)
(declare-fun |$1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_RotationCapability''| (T@Vec_6673) |T@$1_account_CapabilityOffer'$1_account_RotationCapability'|)
(declare-fun |$1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_SignerCapability''| (T@Vec_6673) |T@$1_account_CapabilityOffer'$1_account_SignerCapability'|)
(declare-fun |$1_from_bcs_deserialize'$1_account_CoinRegisterEvent'| (T@Vec_6673) T@$1_account_CoinRegisterEvent)
(declare-fun |$1_from_bcs_deserialize'$1_account_SignerCapability'| (T@Vec_6673) T@$1_account_SignerCapability)
(declare-fun |$1_from_bcs_deserialize'$1_coin_Coin'$1_aptos_coin_AptosCoin''| (T@Vec_6673) |T@$1_coin_Coin'$1_aptos_coin_AptosCoin'|)
(declare-fun |$1_from_bcs_deserialize'$1_coin_Coin'#0''| (T@Vec_6673) |T@$1_coin_Coin'#0'|)
(declare-fun |$1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| (T@Vec_6673) |T@$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'|)
(declare-fun |$1_from_bcs_deserialize'$1_coin_CoinInfo'#0''| (T@Vec_6673) |T@$1_coin_CoinInfo'#0'|)
(declare-fun |$1_from_bcs_deserialize'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''| (T@Vec_6673) |T@$1_coin_CoinStore'$1_aptos_coin_AptosCoin'|)
(declare-fun |$1_from_bcs_deserialize'$1_coin_CoinStore'#0''| (T@Vec_6673) |T@$1_coin_CoinStore'#0'|)
(declare-fun |$1_from_bcs_deserialize'$1_coin_DepositEvent'| (T@Vec_6673) T@$1_coin_DepositEvent)
(declare-fun |$1_from_bcs_deserialize'$1_coin_WithdrawEvent'| (T@Vec_6673) T@$1_coin_WithdrawEvent)
(declare-fun |$1_from_bcs_deserialize'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''| (T@Vec_6673) |T@$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'|)
(declare-fun |$1_from_bcs_deserialize'$1_coin_Ghost$supply'#0''| (T@Vec_6673) |T@$1_coin_Ghost$supply'#0'|)
(declare-fun |$1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''| (T@Vec_6673) |T@$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'|)
(declare-fun |$1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'#0''| (T@Vec_6673) |T@$1_coin_Ghost$aggregate_supply'#0'|)
(declare-fun |$1_from_bcs_deserialize'$1_aptos_coin_AptosCoin'| (T@Vec_6673) T@$1_aptos_coin_AptosCoin)
(declare-fun |$1_from_bcs_deserialize'$1_Bbay_Owner'| (T@Vec_6673) T@$1_Bbay_Owner)
(declare-fun |$1_from_bcs_deserialize'$1_Bbay_Products'| (T@Vec_6673) T@$1_Bbay_Products)
(declare-fun |$1_from_bcs_deserialize'$1_Bbay_ResourceAccountSignerCap'| (T@Vec_6673) T@$1_Bbay_ResourceAccountSignerCap)
(declare-fun |$1_from_bcs_deserialize'$1_Bbay_User'| (T@Vec_6673) T@$1_Bbay_User)
(declare-fun |$1_from_bcs_deserialize'#0'| (T@Vec_6673) |T@#0|)
(declare-fun $shl (Int Int) Int)
(declare-fun |$IsValid'u256'| (Int) Bool)
(declare-fun |$IsValid'vec'address''| (T@Vec_6673) Bool)
(declare-fun |$IsValid'vec'$1_aggregator_Aggregator''| (T@Vec_90390) Bool)
(declare-fun |$IsValid'vec'$1_optional_aggregator_Integer''| (T@Vec_95276) Bool)
(declare-fun |$IsValid'vec'$1_optional_aggregator_OptionalAggregator''| (T@Vec_100175) Bool)
(declare-fun |$IsValid'vec'#0''| (T@Vec_85428) Bool)
(declare-fun |$IsValid'$1_table_Table'u64_bool''| (T@Table_35290_35291) Bool)
(declare-fun |$IsValid'$1_table_Table'u64_u64''| (T@Table_36177_36178) Bool)
(declare-fun |$IsValid'$1_table_Table'u64_vec'u64'''| (T@Table_37064_126051) Bool)
(declare-fun |$IsValid'$1_option_Option'address''| (|T@$1_option_Option'address'|) Bool)
(declare-fun |$IsValid'$1_type_info_TypeInfo'| (T@$1_type_info_TypeInfo) Bool)
(declare-fun |$IsValid'$1_account_Account'| (T@$1_account_Account) Bool)
(declare-fun |$IsValid'$1_account_CapabilityOffer'$1_account_RotationCapability''| (|T@$1_account_CapabilityOffer'$1_account_RotationCapability'|) Bool)
(declare-fun |$IsValid'$1_account_CapabilityOffer'$1_account_SignerCapability''| (|T@$1_account_CapabilityOffer'$1_account_SignerCapability'|) Bool)
(declare-fun |$IsValid'$1_account_CoinRegisterEvent'| (T@$1_account_CoinRegisterEvent) Bool)
(declare-fun |$IsValid'$1_account_SignerCapability'| (T@$1_account_SignerCapability) Bool)
(declare-fun |$IsValid'$1_coin_DepositEvent'| (T@$1_coin_DepositEvent) Bool)
(declare-fun |$IsValid'$1_coin_WithdrawEvent'| (T@$1_coin_WithdrawEvent) Bool)
(declare-fun |$IsValid'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''| (|T@$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'|) Bool)
(declare-fun |$IsValid'$1_coin_Ghost$supply'#0''| (|T@$1_coin_Ghost$supply'#0'|) Bool)
(declare-fun |$IsValid'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''| (|T@$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'|) Bool)
(declare-fun |$IsValid'$1_coin_Ghost$aggregate_supply'#0''| (|T@$1_coin_Ghost$aggregate_supply'#0'|) Bool)
(declare-fun |$IsValid'$1_aptos_coin_AptosCoin'| (T@$1_aptos_coin_AptosCoin) Bool)
(declare-fun |$IsValid'$1_Bbay_Products'| (T@$1_Bbay_Products) Bool)
(declare-fun |$IsValid'$1_Bbay_ResourceAccountSignerCap'| (T@$1_Bbay_ResourceAccountSignerCap) Bool)
(declare-fun |$EncodeKey'u64'| (Int) Int)
(declare-fun |$EncodeKey'address'| (Int) Int)
(declare-fun $shlBv8From16 ((_ BitVec 8) (_ BitVec 16)) (_ BitVec 8))
(declare-fun $shrBv8From16 ((_ BitVec 8) (_ BitVec 16)) (_ BitVec 8))
(declare-fun $shlBv8From32 ((_ BitVec 8) (_ BitVec 32)) (_ BitVec 8))
(declare-fun $shrBv8From32 ((_ BitVec 8) (_ BitVec 32)) (_ BitVec 8))
(declare-fun $shlBv8From64 ((_ BitVec 8) (_ BitVec 64)) (_ BitVec 8))
(declare-fun $shrBv8From64 ((_ BitVec 8) (_ BitVec 64)) (_ BitVec 8))
(declare-fun $shlBv8From128 ((_ BitVec 8) (_ BitVec 128)) (_ BitVec 8))
(declare-fun $shrBv8From128 ((_ BitVec 8) (_ BitVec 128)) (_ BitVec 8))
(declare-fun $shlBv8From256 ((_ BitVec 8) (_ BitVec 256)) (_ BitVec 8))
(declare-fun $shrBv8From256 ((_ BitVec 8) (_ BitVec 256)) (_ BitVec 8))
(declare-fun $shlBv16From32 ((_ BitVec 16) (_ BitVec 32)) (_ BitVec 16))
(declare-fun $shrBv16From32 ((_ BitVec 16) (_ BitVec 32)) (_ BitVec 16))
(declare-fun $shlBv16From64 ((_ BitVec 16) (_ BitVec 64)) (_ BitVec 16))
(declare-fun $shrBv16From64 ((_ BitVec 16) (_ BitVec 64)) (_ BitVec 16))
(declare-fun $shlBv16From128 ((_ BitVec 16) (_ BitVec 128)) (_ BitVec 16))
(declare-fun $shrBv16From128 ((_ BitVec 16) (_ BitVec 128)) (_ BitVec 16))
(declare-fun $shlBv16From256 ((_ BitVec 16) (_ BitVec 256)) (_ BitVec 16))
(declare-fun $shrBv16From256 ((_ BitVec 16) (_ BitVec 256)) (_ BitVec 16))
(declare-fun $shlBv32From64 ((_ BitVec 32) (_ BitVec 64)) (_ BitVec 32))
(declare-fun $shrBv32From64 ((_ BitVec 32) (_ BitVec 64)) (_ BitVec 32))
(declare-fun $shlBv32From128 ((_ BitVec 32) (_ BitVec 128)) (_ BitVec 32))
(declare-fun $shrBv32From128 ((_ BitVec 32) (_ BitVec 128)) (_ BitVec 32))
(declare-fun $shlBv32From256 ((_ BitVec 32) (_ BitVec 256)) (_ BitVec 32))
(declare-fun $shrBv32From256 ((_ BitVec 32) (_ BitVec 256)) (_ BitVec 32))
(declare-fun $shlBv64From128 ((_ BitVec 64) (_ BitVec 128)) (_ BitVec 64))
(declare-fun $shrBv64From128 ((_ BitVec 64) (_ BitVec 128)) (_ BitVec 64))
(declare-fun $shlBv64From256 ((_ BitVec 64) (_ BitVec 256)) (_ BitVec 64))
(declare-fun $shrBv64From256 ((_ BitVec 64) (_ BitVec 256)) (_ BitVec 64))
(declare-fun $shlBv128From256 ((_ BitVec 128) (_ BitVec 256)) (_ BitVec 128))
(declare-fun $shrBv128From256 ((_ BitVec 128) (_ BitVec 256)) (_ BitVec 128))
(declare-fun $shlU8 (Int Int) Int)
(declare-fun $shlU32 (Int Int) Int)
(declare-fun $shlU16 (Int Int) Int)
(declare-fun $shlU64 (Int Int) Int)
(declare-fun |$IsValid'vec'bv64''| (T@Vec_67815) Bool)
(declare-fun |$IsValid'bv64'| ((_ BitVec 64)) Bool)
(declare-fun |$IsValid'vec'bv8''| (T@Vec_68162) Bool)
(declare-fun |$IsValid'bv8'| ((_ BitVec 8)) Bool)
(declare-fun |Select__T@[Int]Vec_6673_| (|T@[Int]Vec_6673| Int) T@Vec_6673)
(declare-fun |$IsValid'num'| (Int) Bool)
(declare-fun $shlU128 (Int Int) Int)
(declare-fun $undefined_int () Int)
(declare-fun |$IsValid'$1_account_RotationCapability'| (T@$1_account_RotationCapability) Bool)
(declare-fun $shlBv16From8 ((_ BitVec 16) (_ BitVec 8)) (_ BitVec 16))
(declare-fun $shrBv16From8 ((_ BitVec 16) (_ BitVec 8)) (_ BitVec 16))
(declare-fun $shlBv32From16 ((_ BitVec 32) (_ BitVec 16)) (_ BitVec 32))
(declare-fun $shrBv32From16 ((_ BitVec 32) (_ BitVec 16)) (_ BitVec 32))
(declare-fun $shlBv32From8 ((_ BitVec 32) (_ BitVec 8)) (_ BitVec 32))
(declare-fun $shrBv32From8 ((_ BitVec 32) (_ BitVec 8)) (_ BitVec 32))
(declare-fun $shlBv64From32 ((_ BitVec 64) (_ BitVec 32)) (_ BitVec 64))
(declare-fun $shrBv64From32 ((_ BitVec 64) (_ BitVec 32)) (_ BitVec 64))
(declare-fun $shlBv64From16 ((_ BitVec 64) (_ BitVec 16)) (_ BitVec 64))
(declare-fun $shrBv64From16 ((_ BitVec 64) (_ BitVec 16)) (_ BitVec 64))
(declare-fun $shlBv64From8 ((_ BitVec 64) (_ BitVec 8)) (_ BitVec 64))
(declare-fun $shrBv64From8 ((_ BitVec 64) (_ BitVec 8)) (_ BitVec 64))
(declare-fun $shlBv128From64 ((_ BitVec 128) (_ BitVec 64)) (_ BitVec 128))
(declare-fun $shrBv128From64 ((_ BitVec 128) (_ BitVec 64)) (_ BitVec 128))
(declare-fun $shlBv128From32 ((_ BitVec 128) (_ BitVec 32)) (_ BitVec 128))
(declare-fun $shrBv128From32 ((_ BitVec 128) (_ BitVec 32)) (_ BitVec 128))
(declare-fun $shlBv128From16 ((_ BitVec 128) (_ BitVec 16)) (_ BitVec 128))
(declare-fun $shrBv128From16 ((_ BitVec 128) (_ BitVec 16)) (_ BitVec 128))
(declare-fun $shlBv128From8 ((_ BitVec 128) (_ BitVec 8)) (_ BitVec 128))
(declare-fun $shrBv128From8 ((_ BitVec 128) (_ BitVec 8)) (_ BitVec 128))
(declare-fun $shlBv256From128 ((_ BitVec 256) (_ BitVec 128)) (_ BitVec 256))
(declare-fun $shrBv256From128 ((_ BitVec 256) (_ BitVec 128)) (_ BitVec 256))
(declare-fun $shlBv256From64 ((_ BitVec 256) (_ BitVec 64)) (_ BitVec 256))
(declare-fun $shrBv256From64 ((_ BitVec 256) (_ BitVec 64)) (_ BitVec 256))
(declare-fun $shlBv256From32 ((_ BitVec 256) (_ BitVec 32)) (_ BitVec 256))
(declare-fun $shrBv256From32 ((_ BitVec 256) (_ BitVec 32)) (_ BitVec 256))
(declare-fun $shlBv256From16 ((_ BitVec 256) (_ BitVec 16)) (_ BitVec 256))
(declare-fun $shrBv256From16 ((_ BitVec 256) (_ BitVec 16)) (_ BitVec 256))
(declare-fun $shlBv256From8 ((_ BitVec 256) (_ BitVec 8)) (_ BitVec 256))
(declare-fun $shrBv256From8 ((_ BitVec 256) (_ BitVec 8)) (_ BitVec 256))
(declare-fun $1_aggregator_spec_aggregator_set_val (T@$1_aggregator_Aggregator Int) T@$1_aggregator_Aggregator)
(declare-fun $shlBv8From8 ((_ BitVec 8) (_ BitVec 8)) (_ BitVec 8))
(declare-fun $shrBv8From8 ((_ BitVec 8) (_ BitVec 8)) (_ BitVec 8))
(declare-fun $shlBv16From16 ((_ BitVec 16) (_ BitVec 16)) (_ BitVec 16))
(declare-fun $shrBv16From16 ((_ BitVec 16) (_ BitVec 16)) (_ BitVec 16))
(declare-fun $shlBv32From32 ((_ BitVec 32) (_ BitVec 32)) (_ BitVec 32))
(declare-fun $shrBv32From32 ((_ BitVec 32) (_ BitVec 32)) (_ BitVec 32))
(declare-fun $shlBv64From64 ((_ BitVec 64) (_ BitVec 64)) (_ BitVec 64))
(declare-fun $shrBv64From64 ((_ BitVec 64) (_ BitVec 64)) (_ BitVec 64))
(declare-fun $shlBv128From128 ((_ BitVec 128) (_ BitVec 128)) (_ BitVec 128))
(declare-fun $shrBv128From128 ((_ BitVec 128) (_ BitVec 128)) (_ BitVec 128))
(declare-fun $shlBv256From256 ((_ BitVec 256) (_ BitVec 256)) (_ BitVec 256))
(declare-fun $shrBv256From256 ((_ BitVec 256) (_ BitVec 256)) (_ BitVec 256))
(declare-fun $1_Signature_$ed25519_validate_pubkey (T@Vec_6673) Bool)
(declare-fun |$IsValid'bv16'| ((_ BitVec 16)) Bool)
(declare-fun |$IsValid'bv256'| ((_ BitVec 256)) Bool)
(declare-fun |$IndexOfVec'#0'| (T@Vec_85428 |T@#0|) Int)
(declare-fun |$IndexOfVec'$1_aggregator_Aggregator'| (T@Vec_90390 T@$1_aggregator_Aggregator) Int)
(declare-fun |$IndexOfVec'$1_optional_aggregator_Integer'| (T@Vec_95276 T@$1_optional_aggregator_Integer) Int)
(declare-fun |$IndexOfVec'$1_optional_aggregator_OptionalAggregator'| (T@Vec_100175 T@$1_optional_aggregator_OptionalAggregator) Int)
(declare-fun |$IndexOfVec'address'| (T@Vec_6673 Int) Int)
(declare-fun |$IndexOfVec'u64'| (T@Vec_6673 Int) Int)
(declare-fun |$IndexOfVec'u8'| (T@Vec_6673 Int) Int)
(declare-fun |$IndexOfVec'bv64'| (T@Vec_67815 (_ BitVec 64)) Int)
(declare-fun |$IndexOfVec'bv8'| (T@Vec_68162 (_ BitVec 8)) Int)
(declare-fun $1_aggregator_spec_read (T@$1_aggregator_Aggregator) Int)
(declare-fun $1_aggregator_spec_aggregator_get_val (T@$1_aggregator_Aggregator) Int)
(declare-fun |$IsValid'bv128'| ((_ BitVec 128)) Bool)
(declare-fun $1_hash_sha2 (T@Vec_6673) T@Vec_6673)
(declare-fun $1_hash_sha3 (T@Vec_6673) T@Vec_6673)
(declare-fun $MAX_U8 () Int)
(declare-fun |$IsValid'u16'| (Int) Bool)
(declare-fun $MAX_U16 () Int)
(declare-fun |$IsValid'u32'| (Int) Bool)
(declare-fun $MAX_U32 () Int)
(declare-fun $MAX_U64 () Int)
(declare-fun $MAX_U256 () Int)
(declare-fun $1_aggregator_factory_spec_new_aggregator (Int) T@$1_aggregator_Aggregator)
(declare-fun $serialized_address_len () Int)
(declare-fun $InRange (T@$Range Int) Bool)
(declare-fun $EXEC_FAILURE_CODE () Int)
(assert (= $MAX_U128 340282366920938463463374607431768211455))
(assert (forall ((src1 Int) (p Int) ) (! (= ($shlU256 src1 p) (mod (* src1 ($pow 2 p)) 115792089237316195423570985008687907853269984665640564039457584007913129639936))
 :qid |boogiebpl.1515:19|
 :skolemid |39|
 :pattern ( ($shlU256 src1 p))
)))
(assert (forall ((t T@$TypeParamInfo) ) (!  (=> (is-$TypeParamU128 t) (|$IsEqual'vec'u8''| ($TypeName t) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 49) 2 50) 3 56) 4)))
 :qid |boogiebpl.6531:15|
 :skolemid |255|
 :pattern ( ($TypeName t))
)))
(assert (forall ((t@@0 T@$TypeParamInfo) ) (!  (=> (is-$TypeParamU256 t@@0) (|$IsEqual'vec'u8''| ($TypeName t@@0) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 50) 2 53) 3 54) 4)))
 :qid |boogiebpl.6533:15|
 :skolemid |257|
 :pattern ( ($TypeName t@@0))
)))
(assert (forall ((|l#0| Int) (|l#1| Int) (|l#2| |T@[Int]#0|) (|l#3| Int) (|l#4| Int) (|l#5| |T@#0|) (i Int) ) (! (= (|Select__T@[Int]#0_| (|lambda#1| |l#0| |l#1| |l#2| |l#3| |l#4| |l#5|) i) (ite  (and (<= |l#0| i) (< i |l#1|)) (|Select__T@[Int]#0_| |l#2| (- (- |l#3| i) |l#4|)) |l#5|))
 :qid |boogiebpl.83:30|
 :skolemid |563|
 :pattern ( (|Select__T@[Int]#0_| (|lambda#1| |l#0| |l#1| |l#2| |l#3| |l#4| |l#5|) i))
)))
(assert (forall ((|l#0@@0| Int) (|l#1@@0| Int) (|l#2@@0| |T@[Int]$1_aggregator_Aggregator|) (|l#3@@0| Int) (|l#4@@0| Int) (|l#5@@0| T@$1_aggregator_Aggregator) (i@@0 Int) ) (! (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|lambda#5| |l#0@@0| |l#1@@0| |l#2@@0| |l#3@@0| |l#4@@0| |l#5@@0|) i@@0) (ite  (and (<= |l#0@@0| i@@0) (< i@@0 |l#1@@0|)) (|Select__T@[Int]$1_aggregator_Aggregator_| |l#2@@0| (- (- |l#3@@0| i@@0) |l#4@@0|)) |l#5@@0|))
 :qid |boogiebpl.83:30|
 :skolemid |567|
 :pattern ( (|Select__T@[Int]$1_aggregator_Aggregator_| (|lambda#5| |l#0@@0| |l#1@@0| |l#2@@0| |l#3@@0| |l#4@@0| |l#5@@0|) i@@0))
)))
(assert (forall ((|l#0@@1| Int) (|l#1@@1| Int) (|l#2@@1| |T@[Int]$1_optional_aggregator_Integer|) (|l#3@@1| Int) (|l#4@@1| Int) (|l#5@@1| T@$1_optional_aggregator_Integer) (i@@1 Int) ) (! (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|lambda#9| |l#0@@1| |l#1@@1| |l#2@@1| |l#3@@1| |l#4@@1| |l#5@@1|) i@@1) (ite  (and (<= |l#0@@1| i@@1) (< i@@1 |l#1@@1|)) (|Select__T@[Int]$1_optional_aggregator_Integer_| |l#2@@1| (- (- |l#3@@1| i@@1) |l#4@@1|)) |l#5@@1|))
 :qid |boogiebpl.83:30|
 :skolemid |571|
 :pattern ( (|Select__T@[Int]$1_optional_aggregator_Integer_| (|lambda#9| |l#0@@1| |l#1@@1| |l#2@@1| |l#3@@1| |l#4@@1| |l#5@@1|) i@@1))
)))
(assert (forall ((|l#0@@2| Int) (|l#1@@2| Int) (|l#2@@2| |T@[Int]$1_optional_aggregator_OptionalAggregator|) (|l#3@@2| Int) (|l#4@@2| Int) (|l#5@@2| T@$1_optional_aggregator_OptionalAggregator) (i@@2 Int) ) (! (= (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|lambda#13| |l#0@@2| |l#1@@2| |l#2@@2| |l#3@@2| |l#4@@2| |l#5@@2|) i@@2) (ite  (and (<= |l#0@@2| i@@2) (< i@@2 |l#1@@2|)) (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| |l#2@@2| (- (- |l#3@@2| i@@2) |l#4@@2|)) |l#5@@2|))
 :qid |boogiebpl.83:30|
 :skolemid |575|
 :pattern ( (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|lambda#13| |l#0@@2| |l#1@@2| |l#2@@2| |l#3@@2| |l#4@@2| |l#5@@2|) i@@2))
)))
(assert (forall ((|l#0@@3| Int) (|l#1@@3| Int) (|l#2@@3| |T@[Int]Int|) (|l#3@@3| Int) (|l#4@@3| Int) (|l#5@@3| Int) (i@@3 Int) ) (! (= (|Select__T@[Int]Int_| (|lambda#17| |l#0@@3| |l#1@@3| |l#2@@3| |l#3@@3| |l#4@@3| |l#5@@3|) i@@3) (ite  (and (<= |l#0@@3| i@@3) (< i@@3 |l#1@@3|)) (|Select__T@[Int]Int_| |l#2@@3| (- (- |l#3@@3| i@@3) |l#4@@3|)) |l#5@@3|))
 :qid |boogiebpl.83:30|
 :skolemid |579|
 :pattern ( (|Select__T@[Int]Int_| (|lambda#17| |l#0@@3| |l#1@@3| |l#2@@3| |l#3@@3| |l#4@@3| |l#5@@3|) i@@3))
)))
(assert (forall ((|l#0@@4| Int) (|l#1@@4| Int) (|l#2@@4| |T@[Int](_ BitVec 64)|) (|l#3@@4| Int) (|l#4@@4| Int) (|l#5@@4| (_ BitVec 64)) (i@@4 Int) ) (! (= (|Select__T@[Int](_ BitVec 64)_| (|lambda#21| |l#0@@4| |l#1@@4| |l#2@@4| |l#3@@4| |l#4@@4| |l#5@@4|) i@@4) (ite  (and (<= |l#0@@4| i@@4) (< i@@4 |l#1@@4|)) (|Select__T@[Int](_ BitVec 64)_| |l#2@@4| (- (- |l#3@@4| i@@4) |l#4@@4|)) |l#5@@4|))
 :qid |boogiebpl.83:30|
 :skolemid |583|
 :pattern ( (|Select__T@[Int](_ BitVec 64)_| (|lambda#21| |l#0@@4| |l#1@@4| |l#2@@4| |l#3@@4| |l#4@@4| |l#5@@4|) i@@4))
)))
(assert (forall ((|l#0@@5| Int) (|l#1@@5| Int) (|l#2@@5| |T@[Int](_ BitVec 8)|) (|l#3@@5| Int) (|l#4@@5| Int) (|l#5@@5| (_ BitVec 8)) (i@@5 Int) ) (! (= (|Select__T@[Int](_ BitVec 8)_| (|lambda#25| |l#0@@5| |l#1@@5| |l#2@@5| |l#3@@5| |l#4@@5| |l#5@@5|) i@@5) (ite  (and (<= |l#0@@5| i@@5) (< i@@5 |l#1@@5|)) (|Select__T@[Int](_ BitVec 8)_| |l#2@@5| (- (- |l#3@@5| i@@5) |l#4@@5|)) |l#5@@5|))
 :qid |boogiebpl.83:30|
 :skolemid |587|
 :pattern ( (|Select__T@[Int](_ BitVec 8)_| (|lambda#25| |l#0@@5| |l#1@@5| |l#2@@5| |l#3@@5| |l#4@@5| |l#5@@5|) i@@5))
)))
(assert (forall ((src1@@0 Int) (p@@0 Int) ) (! (= ($shr src1@@0 p@@0) (div src1@@0 ($pow 2 p@@0)))
 :qid |boogiebpl.1519:15|
 :skolemid |40|
 :pattern ( ($shr src1@@0 p@@0))
)))
(assert (forall ((s T@$1_aggregator_Aggregator) ) (! (= (|$IsValid'$1_aggregator_Aggregator'| s)  (and (and (and (|$IsValid'address'| (|$handle#$1_aggregator_Aggregator| s)) (|$IsValid'address'| (|$key#$1_aggregator_Aggregator| s))) (|$IsValid'u128'| (|$limit#$1_aggregator_Aggregator| s))) (|$IsValid'u128'| (|$val#$1_aggregator_Aggregator| s))))
 :qid |boogiebpl.260:45|
 :skolemid |8|
 :pattern ( (|$IsValid'$1_aggregator_Aggregator'| s))
)))
(assert (forall ((s@@0 |T@$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'|) ) (! (= (|$IsValid'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| s@@0)  (and (and (and (|$IsValid'$1_string_String'| (|$name#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| s@@0)) (|$IsValid'$1_string_String'| (|$symbol#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| s@@0))) (|$IsValid'u8'| (|$decimals#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| s@@0))) (|$IsValid'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| (|$supply#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| s@@0))))
 :qid |boogiebpl.10044:62|
 :skolemid |520|
 :pattern ( (|$IsValid'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| s@@0))
)))
(assert (forall ((s@@1 |T@$1_coin_CoinInfo'#0'|) ) (! (= (|$IsValid'$1_coin_CoinInfo'#0''| s@@1)  (and (and (and (|$IsValid'$1_string_String'| (|$name#$1_coin_CoinInfo'#0'| s@@1)) (|$IsValid'$1_string_String'| (|$symbol#$1_coin_CoinInfo'#0'| s@@1))) (|$IsValid'u8'| (|$decimals#$1_coin_CoinInfo'#0'| s@@1))) (|$IsValid'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| (|$supply#$1_coin_CoinInfo'#0'| s@@1))))
 :qid |boogiebpl.10073:41|
 :skolemid |521|
 :pattern ( (|$IsValid'$1_coin_CoinInfo'#0''| s@@1))
)))
(assert (forall ((s@@2 |T@$1_coin_CoinStore'$1_aptos_coin_AptosCoin'|) ) (! (= (|$IsValid'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''| s@@2)  (and (and (and (|$IsValid'$1_coin_Coin'$1_aptos_coin_AptosCoin''| (|$coin#$1_coin_CoinStore'$1_aptos_coin_AptosCoin'| s@@2)) true) (|$IsValid'$1_event_EventHandle'$1_coin_DepositEvent''| (|$deposit_events#$1_coin_CoinStore'$1_aptos_coin_AptosCoin'| s@@2))) (|$IsValid'$1_event_EventHandle'$1_coin_WithdrawEvent''| (|$withdraw_events#$1_coin_CoinStore'$1_aptos_coin_AptosCoin'| s@@2))))
 :qid |boogiebpl.10102:63|
 :skolemid |522|
 :pattern ( (|$IsValid'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''| s@@2))
)))
(assert (forall ((s@@3 |T@$1_coin_CoinStore'#0'|) ) (! (= (|$IsValid'$1_coin_CoinStore'#0''| s@@3)  (and (and (and (|$IsValid'$1_coin_Coin'#0''| (|$coin#$1_coin_CoinStore'#0'| s@@3)) true) (|$IsValid'$1_event_EventHandle'$1_coin_DepositEvent''| (|$deposit_events#$1_coin_CoinStore'#0'| s@@3))) (|$IsValid'$1_event_EventHandle'$1_coin_WithdrawEvent''| (|$withdraw_events#$1_coin_CoinStore'#0'| s@@3))))
 :qid |boogiebpl.10129:42|
 :skolemid |523|
 :pattern ( (|$IsValid'$1_coin_CoinStore'#0''| s@@3))
)))
(assert (forall ((s@@4 T@$1_Bbay_Owner) ) (! (= (|$IsValid'$1_Bbay_Owner'| s@@4)  (and (and (and (|$IsValid'address'| (|$owner_address#$1_Bbay_Owner| s@@4)) (|$IsValid'u64'| (|$user_count#$1_Bbay_Owner| s@@4))) (|$IsValid'u64'| (|$num_of_products_added#$1_Bbay_Owner| s@@4))) (|$IsValid'$1_table_Table'address_address''| (|$resource_account#$1_Bbay_Owner| s@@4))))
 :qid |boogiebpl.11505:34|
 :skolemid |531|
 :pattern ( (|$IsValid'$1_Bbay_Owner'| s@@4))
)))
(assert (forall ((s@@5 T@$1_Bbay_User) ) (! (= (|$IsValid'$1_Bbay_User'| s@@5)  (and (and (and (|$IsValid'u64'| (|$user_id#$1_Bbay_User| s@@5)) (|$IsValid'vec'u64''| (|$orders#$1_Bbay_User| s@@5))) (|$IsValid'vec'u64''| (|$order_status#$1_Bbay_User| s@@5))) (|$IsValid'vec'u64''| (|$payment_status#$1_Bbay_User| s@@5))))
 :qid |boogiebpl.11586:33|
 :skolemid |534|
 :pattern ( (|$IsValid'$1_Bbay_User'| s@@5))
)))
(assert (= ($ConstMemoryDomain false) (|lambda#28| false)))
(assert (= ($ConstMemoryDomain true) (|lambda#28| true)))
(assert (forall ((s@@6 T@$1_optional_aggregator_Integer) ) (! (= (|$IsValid'$1_optional_aggregator_Integer'| s@@6)  (and (|$IsValid'u128'| (|$value#$1_optional_aggregator_Integer| s@@6)) (|$IsValid'u128'| (|$limit#$1_optional_aggregator_Integer| s@@6))))
 :qid |boogiebpl.7404:51|
 :skolemid |390|
 :pattern ( (|$IsValid'$1_optional_aggregator_Integer'| s@@6))
)))
(assert (forall ((s@@7 T@$1_optional_aggregator_OptionalAggregator) ) (! (= (|$IsValid'$1_optional_aggregator_OptionalAggregator'| s@@7)  (and (|$IsValid'$1_option_Option'$1_aggregator_Aggregator''| (|$aggregator#$1_optional_aggregator_OptionalAggregator| s@@7)) (|$IsValid'$1_option_Option'$1_optional_aggregator_Integer''| (|$integer#$1_optional_aggregator_OptionalAggregator| s@@7))))
 :qid |boogiebpl.7422:62|
 :skolemid |391|
 :pattern ( (|$IsValid'$1_optional_aggregator_OptionalAggregator'| s@@7))
)))
(assert (forall ((s@@8 T@$1_guid_ID) ) (! (= (|$IsValid'$1_guid_ID'| s@@8)  (and (|$IsValid'u64'| (|$creation_num#$1_guid_ID| s@@8)) (|$IsValid'address'| (|$addr#$1_guid_ID| s@@8))))
 :qid |boogiebpl.7454:31|
 :skolemid |393|
 :pattern ( (|$IsValid'$1_guid_ID'| s@@8))
)))
(assert (forall ((s@@9 |T@$1_event_EventHandle'$1_account_CoinRegisterEvent'|) ) (! (= (|$IsValid'$1_event_EventHandle'$1_account_CoinRegisterEvent''| s@@9)  (and (|$IsValid'u64'| (|$counter#$1_event_EventHandle'$1_account_CoinRegisterEvent'| s@@9)) (|$IsValid'$1_guid_GUID'| (|$guid#$1_event_EventHandle'$1_account_CoinRegisterEvent'| s@@9))))
 :qid |boogiebpl.7560:71|
 :skolemid |394|
 :pattern ( (|$IsValid'$1_event_EventHandle'$1_account_CoinRegisterEvent''| s@@9))
)))
(assert (forall ((s@@10 |T@$1_event_EventHandle'$1_account_KeyRotationEvent'|) ) (! (= (|$IsValid'$1_event_EventHandle'$1_account_KeyRotationEvent''| s@@10)  (and (|$IsValid'u64'| (|$counter#$1_event_EventHandle'$1_account_KeyRotationEvent'| s@@10)) (|$IsValid'$1_guid_GUID'| (|$guid#$1_event_EventHandle'$1_account_KeyRotationEvent'| s@@10))))
 :qid |boogiebpl.7578:70|
 :skolemid |395|
 :pattern ( (|$IsValid'$1_event_EventHandle'$1_account_KeyRotationEvent''| s@@10))
)))
(assert (forall ((s@@11 |T@$1_event_EventHandle'$1_coin_DepositEvent'|) ) (! (= (|$IsValid'$1_event_EventHandle'$1_coin_DepositEvent''| s@@11)  (and (|$IsValid'u64'| (|$counter#$1_event_EventHandle'$1_coin_DepositEvent'| s@@11)) (|$IsValid'$1_guid_GUID'| (|$guid#$1_event_EventHandle'$1_coin_DepositEvent'| s@@11))))
 :qid |boogiebpl.7596:63|
 :skolemid |396|
 :pattern ( (|$IsValid'$1_event_EventHandle'$1_coin_DepositEvent''| s@@11))
)))
(assert (forall ((s@@12 |T@$1_event_EventHandle'$1_coin_WithdrawEvent'|) ) (! (= (|$IsValid'$1_event_EventHandle'$1_coin_WithdrawEvent''| s@@12)  (and (|$IsValid'u64'| (|$counter#$1_event_EventHandle'$1_coin_WithdrawEvent'| s@@12)) (|$IsValid'$1_guid_GUID'| (|$guid#$1_event_EventHandle'$1_coin_WithdrawEvent'| s@@12))))
 :qid |boogiebpl.7614:64|
 :skolemid |397|
 :pattern ( (|$IsValid'$1_event_EventHandle'$1_coin_WithdrawEvent''| s@@12))
)))
(assert (forall ((s@@13 T@$1_account_KeyRotationEvent) ) (! (= (|$IsValid'$1_account_KeyRotationEvent'| s@@13)  (and (|$IsValid'vec'u8''| (|$old_authentication_key#$1_account_KeyRotationEvent| s@@13)) (|$IsValid'vec'u8''| (|$new_authentication_key#$1_account_KeyRotationEvent| s@@13))))
 :qid |boogiebpl.8549:48|
 :skolemid |515|
 :pattern ( (|$IsValid'$1_account_KeyRotationEvent'| s@@13))
)))
(assert (forall ((v1 T@Vec_85428) (v2 T@Vec_85428) ) (! (= (|$IsEqual'vec'#0''| v1 v2)  (and (= (|l#Vec_85428| v1) (|l#Vec_85428| v2)) (forall ((i@@6 Int) ) (!  (=> (InRangeVec_65852 v1 i@@6) (= (|Select__T@[Int]#0_| (|v#Vec_85428| v1) i@@6) (|Select__T@[Int]#0_| (|v#Vec_85428| v2) i@@6)))
 :qid |boogiebpl.3080:13|
 :skolemid |113|
))))
 :qid |boogiebpl.3078:28|
 :skolemid |114|
 :pattern ( (|$IsEqual'vec'#0''| v1 v2))
)))
(assert (forall ((v1@@0 T@Vec_90390) (v2@@0 T@Vec_90390) ) (! (= (|$IsEqual'vec'$1_aggregator_Aggregator''| v1@@0 v2@@0)  (and (= (|l#Vec_90390| v1@@0) (|l#Vec_90390| v2@@0)) (forall ((i@@7 Int) ) (!  (=> (InRangeVec_66199 v1@@0 i@@7) (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| v1@@0) i@@7) (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| v2@@0) i@@7)))
 :qid |boogiebpl.3384:13|
 :skolemid |124|
))))
 :qid |boogiebpl.3382:50|
 :skolemid |125|
 :pattern ( (|$IsEqual'vec'$1_aggregator_Aggregator''| v1@@0 v2@@0))
)))
(assert (forall ((v1@@1 T@Vec_95276) (v2@@1 T@Vec_95276) ) (! (= (|$IsEqual'vec'$1_optional_aggregator_Integer''| v1@@1 v2@@1)  (and (= (|l#Vec_95276| v1@@1) (|l#Vec_95276| v2@@1)) (forall ((i@@8 Int) ) (!  (=> (InRangeVec_66546 v1@@1 i@@8) (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| v1@@1) i@@8) (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| v2@@1) i@@8)))
 :qid |boogiebpl.3688:13|
 :skolemid |135|
))))
 :qid |boogiebpl.3686:56|
 :skolemid |136|
 :pattern ( (|$IsEqual'vec'$1_optional_aggregator_Integer''| v1@@1 v2@@1))
)))
(assert (forall ((v1@@2 T@Vec_100175) (v2@@2 T@Vec_100175) ) (! (= (|$IsEqual'vec'$1_optional_aggregator_OptionalAggregator''| v1@@2 v2@@2)  (and (= (|l#Vec_100175| v1@@2) (|l#Vec_100175| v2@@2)) (forall ((i@@9 Int) ) (!  (=> (InRangeVec_66893 v1@@2 i@@9) (and (|$IsEqual'vec'$1_aggregator_Aggregator''| (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v1@@2) i@@9))) (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v2@@2) i@@9)))) (|$IsEqual'vec'$1_optional_aggregator_Integer''| (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v1@@2) i@@9))) (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v2@@2) i@@9))))))
 :qid |boogiebpl.3992:13|
 :skolemid |146|
))))
 :qid |boogiebpl.3990:67|
 :skolemid |147|
 :pattern ( (|$IsEqual'vec'$1_optional_aggregator_OptionalAggregator''| v1@@2 v2@@2))
)))
(assert (forall ((v1@@3 T@Vec_6673) (v2@@3 T@Vec_6673) ) (! (= (|$IsEqual'vec'address''| v1@@3 v2@@3)  (and (= (|l#Vec_6673| v1@@3) (|l#Vec_6673| v2@@3)) (forall ((i@@10 Int) ) (!  (=> (InRangeVec_25002 v1@@3 i@@10) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v1@@3) i@@10) (|Select__T@[Int]Int_| (|v#Vec_6673| v2@@3) i@@10)))
 :qid |boogiebpl.4296:13|
 :skolemid |157|
))))
 :qid |boogiebpl.4294:33|
 :skolemid |158|
 :pattern ( (|$IsEqual'vec'address''| v1@@3 v2@@3))
)))
(assert (forall ((v1@@4 T@Vec_6673) (v2@@4 T@Vec_6673) ) (! (= (|$IsEqual'vec'u64''| v1@@4 v2@@4)  (and (= (|l#Vec_6673| v1@@4) (|l#Vec_6673| v2@@4)) (forall ((i@@11 Int) ) (!  (=> (InRangeVec_25002 v1@@4 i@@11) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v1@@4) i@@11) (|Select__T@[Int]Int_| (|v#Vec_6673| v2@@4) i@@11)))
 :qid |boogiebpl.4600:13|
 :skolemid |168|
))))
 :qid |boogiebpl.4598:29|
 :skolemid |169|
 :pattern ( (|$IsEqual'vec'u64''| v1@@4 v2@@4))
)))
(assert (forall ((v1@@5 T@Vec_6673) (v2@@5 T@Vec_6673) ) (! (= (|$IsEqual'vec'u8''| v1@@5 v2@@5)  (and (= (|l#Vec_6673| v1@@5) (|l#Vec_6673| v2@@5)) (forall ((i@@12 Int) ) (!  (=> (InRangeVec_25002 v1@@5 i@@12) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v1@@5) i@@12) (|Select__T@[Int]Int_| (|v#Vec_6673| v2@@5) i@@12)))
 :qid |boogiebpl.4904:13|
 :skolemid |179|
))))
 :qid |boogiebpl.4902:28|
 :skolemid |180|
 :pattern ( (|$IsEqual'vec'u8''| v1@@5 v2@@5))
)))
(assert (forall ((v1@@6 T@Vec_67815) (v2@@6 T@Vec_67815) ) (! (= (|$IsEqual'vec'bv64''| v1@@6 v2@@6)  (and (= (|l#Vec_67815| v1@@6) (|l#Vec_67815| v2@@6)) (forall ((i@@13 Int) ) (!  (=> (InRangeVec_67819 v1@@6 i@@13) (= (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| v1@@6) i@@13) (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| v2@@6) i@@13)))
 :qid |boogiebpl.5208:13|
 :skolemid |190|
))))
 :qid |boogiebpl.5206:30|
 :skolemid |191|
 :pattern ( (|$IsEqual'vec'bv64''| v1@@6 v2@@6))
)))
(assert (forall ((v1@@7 T@Vec_68162) (v2@@7 T@Vec_68162) ) (! (= (|$IsEqual'vec'bv8''| v1@@7 v2@@7)  (and (= (|l#Vec_68162| v1@@7) (|l#Vec_68162| v2@@7)) (forall ((i@@14 Int) ) (!  (=> (InRangeVec_68166 v1@@7 i@@14) (= (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| v1@@7) i@@14) (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| v2@@7) i@@14)))
 :qid |boogiebpl.5512:13|
 :skolemid |201|
))))
 :qid |boogiebpl.5510:29|
 :skolemid |202|
 :pattern ( (|$IsEqual'vec'bv8''| v1@@7 v2@@7))
)))
(assert (forall ((v T@Vec_85428) (prefix T@Vec_85428) ) (! (= (|$IsPrefix'vec'#0''| v prefix)  (and (>= (|l#Vec_85428| v) (|l#Vec_85428| prefix)) (forall ((i@@15 Int) ) (!  (=> (InRangeVec_65852 prefix i@@15) (= (|Select__T@[Int]#0_| (|v#Vec_85428| v) i@@15) (|Select__T@[Int]#0_| (|v#Vec_85428| prefix) i@@15)))
 :qid |boogiebpl.3086:13|
 :skolemid |115|
))))
 :qid |boogiebpl.3084:29|
 :skolemid |116|
 :pattern ( (|$IsPrefix'vec'#0''| v prefix))
)))
(assert (forall ((v@@0 T@Vec_90390) (prefix@@0 T@Vec_90390) ) (! (= (|$IsPrefix'vec'$1_aggregator_Aggregator''| v@@0 prefix@@0)  (and (>= (|l#Vec_90390| v@@0) (|l#Vec_90390| prefix@@0)) (forall ((i@@16 Int) ) (!  (=> (InRangeVec_66199 prefix@@0 i@@16) (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| v@@0) i@@16) (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| prefix@@0) i@@16)))
 :qid |boogiebpl.3390:13|
 :skolemid |126|
))))
 :qid |boogiebpl.3388:51|
 :skolemid |127|
 :pattern ( (|$IsPrefix'vec'$1_aggregator_Aggregator''| v@@0 prefix@@0))
)))
(assert (forall ((v@@1 T@Vec_95276) (prefix@@1 T@Vec_95276) ) (! (= (|$IsPrefix'vec'$1_optional_aggregator_Integer''| v@@1 prefix@@1)  (and (>= (|l#Vec_95276| v@@1) (|l#Vec_95276| prefix@@1)) (forall ((i@@17 Int) ) (!  (=> (InRangeVec_66546 prefix@@1 i@@17) (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| v@@1) i@@17) (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| prefix@@1) i@@17)))
 :qid |boogiebpl.3694:13|
 :skolemid |137|
))))
 :qid |boogiebpl.3692:57|
 :skolemid |138|
 :pattern ( (|$IsPrefix'vec'$1_optional_aggregator_Integer''| v@@1 prefix@@1))
)))
(assert (forall ((v@@2 T@Vec_100175) (prefix@@2 T@Vec_100175) ) (! (= (|$IsPrefix'vec'$1_optional_aggregator_OptionalAggregator''| v@@2 prefix@@2)  (and (>= (|l#Vec_100175| v@@2) (|l#Vec_100175| prefix@@2)) (forall ((i@@18 Int) ) (!  (=> (InRangeVec_66893 prefix@@2 i@@18) (and (|$IsEqual'vec'$1_aggregator_Aggregator''| (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@2) i@@18))) (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| prefix@@2) i@@18)))) (|$IsEqual'vec'$1_optional_aggregator_Integer''| (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@2) i@@18))) (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| prefix@@2) i@@18))))))
 :qid |boogiebpl.3998:13|
 :skolemid |148|
))))
 :qid |boogiebpl.3996:68|
 :skolemid |149|
 :pattern ( (|$IsPrefix'vec'$1_optional_aggregator_OptionalAggregator''| v@@2 prefix@@2))
)))
(assert (forall ((v@@3 T@Vec_6673) (prefix@@3 T@Vec_6673) ) (! (= (|$IsPrefix'vec'address''| v@@3 prefix@@3)  (and (>= (|l#Vec_6673| v@@3) (|l#Vec_6673| prefix@@3)) (forall ((i@@19 Int) ) (!  (=> (InRangeVec_25002 prefix@@3 i@@19) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@3) i@@19) (|Select__T@[Int]Int_| (|v#Vec_6673| prefix@@3) i@@19)))
 :qid |boogiebpl.4302:13|
 :skolemid |159|
))))
 :qid |boogiebpl.4300:34|
 :skolemid |160|
 :pattern ( (|$IsPrefix'vec'address''| v@@3 prefix@@3))
)))
(assert (forall ((v@@4 T@Vec_6673) (prefix@@4 T@Vec_6673) ) (! (= (|$IsPrefix'vec'u64''| v@@4 prefix@@4)  (and (>= (|l#Vec_6673| v@@4) (|l#Vec_6673| prefix@@4)) (forall ((i@@20 Int) ) (!  (=> (InRangeVec_25002 prefix@@4 i@@20) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@4) i@@20) (|Select__T@[Int]Int_| (|v#Vec_6673| prefix@@4) i@@20)))
 :qid |boogiebpl.4606:13|
 :skolemid |170|
))))
 :qid |boogiebpl.4604:30|
 :skolemid |171|
 :pattern ( (|$IsPrefix'vec'u64''| v@@4 prefix@@4))
)))
(assert (forall ((v@@5 T@Vec_6673) (prefix@@5 T@Vec_6673) ) (! (= (|$IsPrefix'vec'u8''| v@@5 prefix@@5)  (and (>= (|l#Vec_6673| v@@5) (|l#Vec_6673| prefix@@5)) (forall ((i@@21 Int) ) (!  (=> (InRangeVec_25002 prefix@@5 i@@21) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@5) i@@21) (|Select__T@[Int]Int_| (|v#Vec_6673| prefix@@5) i@@21)))
 :qid |boogiebpl.4910:13|
 :skolemid |181|
))))
 :qid |boogiebpl.4908:29|
 :skolemid |182|
 :pattern ( (|$IsPrefix'vec'u8''| v@@5 prefix@@5))
)))
(assert (forall ((v@@6 T@Vec_67815) (prefix@@6 T@Vec_67815) ) (! (= (|$IsPrefix'vec'bv64''| v@@6 prefix@@6)  (and (>= (|l#Vec_67815| v@@6) (|l#Vec_67815| prefix@@6)) (forall ((i@@22 Int) ) (!  (=> (InRangeVec_67819 prefix@@6 i@@22) (= (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| v@@6) i@@22) (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| prefix@@6) i@@22)))
 :qid |boogiebpl.5214:13|
 :skolemid |192|
))))
 :qid |boogiebpl.5212:31|
 :skolemid |193|
 :pattern ( (|$IsPrefix'vec'bv64''| v@@6 prefix@@6))
)))
(assert (forall ((v@@7 T@Vec_68162) (prefix@@7 T@Vec_68162) ) (! (= (|$IsPrefix'vec'bv8''| v@@7 prefix@@7)  (and (>= (|l#Vec_68162| v@@7) (|l#Vec_68162| prefix@@7)) (forall ((i@@23 Int) ) (!  (=> (InRangeVec_68166 prefix@@7 i@@23) (= (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| v@@7) i@@23) (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| prefix@@7) i@@23)))
 :qid |boogiebpl.5518:13|
 :skolemid |203|
))))
 :qid |boogiebpl.5516:30|
 :skolemid |204|
 :pattern ( (|$IsPrefix'vec'bv8''| v@@7 prefix@@7))
)))
(assert (forall ((t1 T@Table_35290_35291) (t2 T@Table_35290_35291) ) (! (= (|$IsEqual'$1_table_Table'u64_bool''| t1 t2)  (and (and (and (= (|l#Table_35290_35291| t1) (|l#Table_35290_35291| t2)) (forall ((k Int) ) (! (= (|Select__T@[Int]Bool_| (|e#Table_35290_35291| t1) k) (|Select__T@[Int]Bool_| (|e#Table_35290_35291| t2) k))
 :qid |boogiebpl.5838:13|
 :skolemid |214|
))) (forall ((k@@0 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_35290_35291| t1) k@@0) (= (|Select__T@[Int]Bool_| (|v#Table_35290_35291| t1) k@@0) (|Select__T@[Int]Bool_| (|v#Table_35290_35291| t2) k@@0)))
 :qid |boogiebpl.5839:13|
 :skolemid |215|
))) (forall ((k@@1 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_35290_35291| t2) k@@1) (= (|Select__T@[Int]Bool_| (|v#Table_35290_35291| t1) k@@1) (|Select__T@[Int]Bool_| (|v#Table_35290_35291| t2) k@@1)))
 :qid |boogiebpl.5840:13|
 :skolemid |216|
))))
 :qid |boogiebpl.5836:45|
 :skolemid |217|
 :pattern ( (|$IsEqual'$1_table_Table'u64_bool''| t1 t2))
)))
(assert (= DefaultTableKeyExistsArray_990 (|lambda#28| false)))
(assert (forall ((v@@8 T@Vec_68162) (e (_ BitVec 8)) ) (! (let ((i@@24 (IndexOfVec_68162 v@@8 e)))
(ite  (not (exists ((i@@25 Int) ) (!  (and (InRangeVec_68166 v@@8 i@@25) (= (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| v@@8) i@@25) e))
 :qid |boogiebpl.110:13|
 :skolemid |0|
))) (= i@@24 (- 0 1))  (and (and (InRangeVec_68166 v@@8 i@@24) (= (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| v@@8) i@@24) e)) (forall ((j Int) ) (!  (=> (and (>= j 0) (< j i@@24)) (not (= (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| v@@8) j) e)))
 :qid |boogiebpl.118:17|
 :skolemid |1|
)))))
 :qid |boogiebpl.114:32|
 :skolemid |2|
 :pattern ( (IndexOfVec_68162 v@@8 e))
)))
(assert (forall ((v@@9 T@Vec_67815) (e@@0 (_ BitVec 64)) ) (! (let ((i@@26 (IndexOfVec_67815 v@@9 e@@0)))
(ite  (not (exists ((i@@27 Int) ) (!  (and (InRangeVec_67819 v@@9 i@@27) (= (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| v@@9) i@@27) e@@0))
 :qid |boogiebpl.110:13|
 :skolemid |0|
))) (= i@@26 (- 0 1))  (and (and (InRangeVec_67819 v@@9 i@@26) (= (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| v@@9) i@@26) e@@0)) (forall ((j@@0 Int) ) (!  (=> (and (>= j@@0 0) (< j@@0 i@@26)) (not (= (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| v@@9) j@@0) e@@0)))
 :qid |boogiebpl.118:17|
 :skolemid |1|
)))))
 :qid |boogiebpl.114:32|
 :skolemid |2|
 :pattern ( (IndexOfVec_67815 v@@9 e@@0))
)))
(assert (forall ((v@@10 T@Vec_100175) (e@@1 T@$1_optional_aggregator_OptionalAggregator) ) (! (let ((i@@28 (IndexOfVec_100175 v@@10 e@@1)))
(ite  (not (exists ((i@@29 Int) ) (!  (and (InRangeVec_66893 v@@10 i@@29) (= (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@10) i@@29) e@@1))
 :qid |boogiebpl.110:13|
 :skolemid |0|
))) (= i@@28 (- 0 1))  (and (and (InRangeVec_66893 v@@10 i@@28) (= (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@10) i@@28) e@@1)) (forall ((j@@1 Int) ) (!  (=> (and (>= j@@1 0) (< j@@1 i@@28)) (not (= (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@10) j@@1) e@@1)))
 :qid |boogiebpl.118:17|
 :skolemid |1|
)))))
 :qid |boogiebpl.114:32|
 :skolemid |2|
 :pattern ( (IndexOfVec_100175 v@@10 e@@1))
)))
(assert (forall ((v@@11 T@Vec_95276) (e@@2 T@$1_optional_aggregator_Integer) ) (! (let ((i@@30 (IndexOfVec_95276 v@@11 e@@2)))
(ite  (not (exists ((i@@31 Int) ) (!  (and (InRangeVec_66546 v@@11 i@@31) (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| v@@11) i@@31) e@@2))
 :qid |boogiebpl.110:13|
 :skolemid |0|
))) (= i@@30 (- 0 1))  (and (and (InRangeVec_66546 v@@11 i@@30) (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| v@@11) i@@30) e@@2)) (forall ((j@@2 Int) ) (!  (=> (and (>= j@@2 0) (< j@@2 i@@30)) (not (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| v@@11) j@@2) e@@2)))
 :qid |boogiebpl.118:17|
 :skolemid |1|
)))))
 :qid |boogiebpl.114:32|
 :skolemid |2|
 :pattern ( (IndexOfVec_95276 v@@11 e@@2))
)))
(assert (forall ((v@@12 T@Vec_90390) (e@@3 T@$1_aggregator_Aggregator) ) (! (let ((i@@32 (IndexOfVec_90390 v@@12 e@@3)))
(ite  (not (exists ((i@@33 Int) ) (!  (and (InRangeVec_66199 v@@12 i@@33) (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| v@@12) i@@33) e@@3))
 :qid |boogiebpl.110:13|
 :skolemid |0|
))) (= i@@32 (- 0 1))  (and (and (InRangeVec_66199 v@@12 i@@32) (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| v@@12) i@@32) e@@3)) (forall ((j@@3 Int) ) (!  (=> (and (>= j@@3 0) (< j@@3 i@@32)) (not (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| v@@12) j@@3) e@@3)))
 :qid |boogiebpl.118:17|
 :skolemid |1|
)))))
 :qid |boogiebpl.114:32|
 :skolemid |2|
 :pattern ( (IndexOfVec_90390 v@@12 e@@3))
)))
(assert (forall ((v@@13 T@Vec_6673) (e@@4 Int) ) (! (let ((i@@34 (IndexOfVec_6673 v@@13 e@@4)))
(ite  (not (exists ((i@@35 Int) ) (!  (and (InRangeVec_25002 v@@13 i@@35) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@13) i@@35) e@@4))
 :qid |boogiebpl.110:13|
 :skolemid |0|
))) (= i@@34 (- 0 1))  (and (and (InRangeVec_25002 v@@13 i@@34) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@13) i@@34) e@@4)) (forall ((j@@4 Int) ) (!  (=> (and (>= j@@4 0) (< j@@4 i@@34)) (not (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@13) j@@4) e@@4)))
 :qid |boogiebpl.118:17|
 :skolemid |1|
)))))
 :qid |boogiebpl.114:32|
 :skolemid |2|
 :pattern ( (IndexOfVec_6673 v@@13 e@@4))
)))
(assert (forall ((v@@14 T@Vec_85428) (e@@5 |T@#0|) ) (! (let ((i@@36 (IndexOfVec_85428 v@@14 e@@5)))
(ite  (not (exists ((i@@37 Int) ) (!  (and (InRangeVec_65852 v@@14 i@@37) (= (|Select__T@[Int]#0_| (|v#Vec_85428| v@@14) i@@37) e@@5))
 :qid |boogiebpl.110:13|
 :skolemid |0|
))) (= i@@36 (- 0 1))  (and (and (InRangeVec_65852 v@@14 i@@36) (= (|Select__T@[Int]#0_| (|v#Vec_85428| v@@14) i@@36) e@@5)) (forall ((j@@5 Int) ) (!  (=> (and (>= j@@5 0) (< j@@5 i@@36)) (not (= (|Select__T@[Int]#0_| (|v#Vec_85428| v@@14) j@@5) e@@5)))
 :qid |boogiebpl.118:17|
 :skolemid |1|
)))))
 :qid |boogiebpl.114:32|
 :skolemid |2|
 :pattern ( (IndexOfVec_85428 v@@14 e@@5))
)))
(assert (forall ((s1 T@Vec_6673) (s2 T@Vec_6673) (k1 T@Vec_6673) (k2 T@Vec_6673) (m1 T@Vec_6673) (m2 T@Vec_6673) ) (!  (=> (and (and (|$IsEqual'vec'u8''| s1 s2) (|$IsEqual'vec'u8''| k1 k2)) (|$IsEqual'vec'u8''| m1 m2)) (= ($1_Signature_$ed25519_verify s1 k1 m1) ($1_Signature_$ed25519_verify s2 k2 m2)))
 :qid |boogiebpl.6438:15|
 :skolemid |241|
 :pattern ( ($1_Signature_$ed25519_verify s1 k1 m1) ($1_Signature_$ed25519_verify s2 k2 m2))
)))
(assert (forall ((|l#0@@6| Int) (|l#1@@6| Int) (|l#2@@6| Int) (|l#3@@6| |T@[Int]#0|) (|l#4@@6| |T@[Int]#0|) (|l#5@@6| Int) (|l#6| |T@#0|) (i@@38 Int) ) (! (= (|Select__T@[Int]#0_| (|lambda#0| |l#0@@6| |l#1@@6| |l#2@@6| |l#3@@6| |l#4@@6| |l#5@@6| |l#6|) i@@38) (ite  (and (>= i@@38 |l#0@@6|) (< i@@38 |l#1@@6|)) (ite (< i@@38 |l#2@@6|) (|Select__T@[Int]#0_| |l#3@@6| i@@38) (|Select__T@[Int]#0_| |l#4@@6| (- i@@38 |l#5@@6|))) |l#6|))
 :qid |boogiebpl.74:19|
 :skolemid |562|
 :pattern ( (|Select__T@[Int]#0_| (|lambda#0| |l#0@@6| |l#1@@6| |l#2@@6| |l#3@@6| |l#4@@6| |l#5@@6| |l#6|) i@@38))
)))
(assert (forall ((|l#0@@7| Int) (|l#1@@7| Int) (|l#2@@7| Int) (|l#3@@7| |T@[Int]$1_aggregator_Aggregator|) (|l#4@@7| |T@[Int]$1_aggregator_Aggregator|) (|l#5@@7| Int) (|l#6@@0| T@$1_aggregator_Aggregator) (i@@39 Int) ) (! (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|lambda#4| |l#0@@7| |l#1@@7| |l#2@@7| |l#3@@7| |l#4@@7| |l#5@@7| |l#6@@0|) i@@39) (ite  (and (>= i@@39 |l#0@@7|) (< i@@39 |l#1@@7|)) (ite (< i@@39 |l#2@@7|) (|Select__T@[Int]$1_aggregator_Aggregator_| |l#3@@7| i@@39) (|Select__T@[Int]$1_aggregator_Aggregator_| |l#4@@7| (- i@@39 |l#5@@7|))) |l#6@@0|))
 :qid |boogiebpl.74:19|
 :skolemid |566|
 :pattern ( (|Select__T@[Int]$1_aggregator_Aggregator_| (|lambda#4| |l#0@@7| |l#1@@7| |l#2@@7| |l#3@@7| |l#4@@7| |l#5@@7| |l#6@@0|) i@@39))
)))
(assert (forall ((|l#0@@8| Int) (|l#1@@8| Int) (|l#2@@8| Int) (|l#3@@8| |T@[Int]$1_optional_aggregator_Integer|) (|l#4@@8| |T@[Int]$1_optional_aggregator_Integer|) (|l#5@@8| Int) (|l#6@@1| T@$1_optional_aggregator_Integer) (i@@40 Int) ) (! (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|lambda#8| |l#0@@8| |l#1@@8| |l#2@@8| |l#3@@8| |l#4@@8| |l#5@@8| |l#6@@1|) i@@40) (ite  (and (>= i@@40 |l#0@@8|) (< i@@40 |l#1@@8|)) (ite (< i@@40 |l#2@@8|) (|Select__T@[Int]$1_optional_aggregator_Integer_| |l#3@@8| i@@40) (|Select__T@[Int]$1_optional_aggregator_Integer_| |l#4@@8| (- i@@40 |l#5@@8|))) |l#6@@1|))
 :qid |boogiebpl.74:19|
 :skolemid |570|
 :pattern ( (|Select__T@[Int]$1_optional_aggregator_Integer_| (|lambda#8| |l#0@@8| |l#1@@8| |l#2@@8| |l#3@@8| |l#4@@8| |l#5@@8| |l#6@@1|) i@@40))
)))
(assert (forall ((|l#0@@9| Int) (|l#1@@9| Int) (|l#2@@9| Int) (|l#3@@9| |T@[Int]$1_optional_aggregator_OptionalAggregator|) (|l#4@@9| |T@[Int]$1_optional_aggregator_OptionalAggregator|) (|l#5@@9| Int) (|l#6@@2| T@$1_optional_aggregator_OptionalAggregator) (i@@41 Int) ) (! (= (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|lambda#12| |l#0@@9| |l#1@@9| |l#2@@9| |l#3@@9| |l#4@@9| |l#5@@9| |l#6@@2|) i@@41) (ite  (and (>= i@@41 |l#0@@9|) (< i@@41 |l#1@@9|)) (ite (< i@@41 |l#2@@9|) (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| |l#3@@9| i@@41) (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| |l#4@@9| (- i@@41 |l#5@@9|))) |l#6@@2|))
 :qid |boogiebpl.74:19|
 :skolemid |574|
 :pattern ( (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|lambda#12| |l#0@@9| |l#1@@9| |l#2@@9| |l#3@@9| |l#4@@9| |l#5@@9| |l#6@@2|) i@@41))
)))
(assert (forall ((|l#0@@10| Int) (|l#1@@10| Int) (|l#2@@10| Int) (|l#3@@10| |T@[Int]Int|) (|l#4@@10| |T@[Int]Int|) (|l#5@@10| Int) (|l#6@@3| Int) (i@@42 Int) ) (! (= (|Select__T@[Int]Int_| (|lambda#16| |l#0@@10| |l#1@@10| |l#2@@10| |l#3@@10| |l#4@@10| |l#5@@10| |l#6@@3|) i@@42) (ite  (and (>= i@@42 |l#0@@10|) (< i@@42 |l#1@@10|)) (ite (< i@@42 |l#2@@10|) (|Select__T@[Int]Int_| |l#3@@10| i@@42) (|Select__T@[Int]Int_| |l#4@@10| (- i@@42 |l#5@@10|))) |l#6@@3|))
 :qid |boogiebpl.74:19|
 :skolemid |578|
 :pattern ( (|Select__T@[Int]Int_| (|lambda#16| |l#0@@10| |l#1@@10| |l#2@@10| |l#3@@10| |l#4@@10| |l#5@@10| |l#6@@3|) i@@42))
)))
(assert (forall ((|l#0@@11| Int) (|l#1@@11| Int) (|l#2@@11| Int) (|l#3@@11| |T@[Int](_ BitVec 64)|) (|l#4@@11| |T@[Int](_ BitVec 64)|) (|l#5@@11| Int) (|l#6@@4| (_ BitVec 64)) (i@@43 Int) ) (! (= (|Select__T@[Int](_ BitVec 64)_| (|lambda#20| |l#0@@11| |l#1@@11| |l#2@@11| |l#3@@11| |l#4@@11| |l#5@@11| |l#6@@4|) i@@43) (ite  (and (>= i@@43 |l#0@@11|) (< i@@43 |l#1@@11|)) (ite (< i@@43 |l#2@@11|) (|Select__T@[Int](_ BitVec 64)_| |l#3@@11| i@@43) (|Select__T@[Int](_ BitVec 64)_| |l#4@@11| (- i@@43 |l#5@@11|))) |l#6@@4|))
 :qid |boogiebpl.74:19|
 :skolemid |582|
 :pattern ( (|Select__T@[Int](_ BitVec 64)_| (|lambda#20| |l#0@@11| |l#1@@11| |l#2@@11| |l#3@@11| |l#4@@11| |l#5@@11| |l#6@@4|) i@@43))
)))
(assert (forall ((|l#0@@12| Int) (|l#1@@12| Int) (|l#2@@12| Int) (|l#3@@12| |T@[Int](_ BitVec 8)|) (|l#4@@12| |T@[Int](_ BitVec 8)|) (|l#5@@12| Int) (|l#6@@5| (_ BitVec 8)) (i@@44 Int) ) (! (= (|Select__T@[Int](_ BitVec 8)_| (|lambda#24| |l#0@@12| |l#1@@12| |l#2@@12| |l#3@@12| |l#4@@12| |l#5@@12| |l#6@@5|) i@@44) (ite  (and (>= i@@44 |l#0@@12|) (< i@@44 |l#1@@12|)) (ite (< i@@44 |l#2@@12|) (|Select__T@[Int](_ BitVec 8)_| |l#3@@12| i@@44) (|Select__T@[Int](_ BitVec 8)_| |l#4@@12| (- i@@44 |l#5@@12|))) |l#6@@5|))
 :qid |boogiebpl.74:19|
 :skolemid |586|
 :pattern ( (|Select__T@[Int](_ BitVec 8)_| (|lambda#24| |l#0@@12| |l#1@@12| |l#2@@12| |l#3@@12| |l#4@@12| |l#5@@12| |l#6@@5|) i@@44))
)))
(assert (forall ((|l#0@@13| Int) (|l#1@@13| Int) (|l#2@@13| Int) (|l#3@@13| |T@[Int]#0|) (|l#4@@13| |T@[Int]#0|) (|l#5@@13| Int) (|l#6@@6| |T@#0|) (j@@6 Int) ) (! (= (|Select__T@[Int]#0_| (|lambda#3| |l#0@@13| |l#1@@13| |l#2@@13| |l#3@@13| |l#4@@13| |l#5@@13| |l#6@@6|) j@@6) (ite  (and (>= j@@6 |l#0@@13|) (< j@@6 |l#1@@13|)) (ite (< j@@6 |l#2@@13|) (|Select__T@[Int]#0_| |l#3@@13| j@@6) (|Select__T@[Int]#0_| |l#4@@13| (+ j@@6 |l#5@@13|))) |l#6@@6|))
 :qid |boogiebpl.64:20|
 :skolemid |565|
 :pattern ( (|Select__T@[Int]#0_| (|lambda#3| |l#0@@13| |l#1@@13| |l#2@@13| |l#3@@13| |l#4@@13| |l#5@@13| |l#6@@6|) j@@6))
)))
(assert (forall ((|l#0@@14| Int) (|l#1@@14| Int) (|l#2@@14| Int) (|l#3@@14| |T@[Int]$1_aggregator_Aggregator|) (|l#4@@14| |T@[Int]$1_aggregator_Aggregator|) (|l#5@@14| Int) (|l#6@@7| T@$1_aggregator_Aggregator) (j@@7 Int) ) (! (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|lambda#7| |l#0@@14| |l#1@@14| |l#2@@14| |l#3@@14| |l#4@@14| |l#5@@14| |l#6@@7|) j@@7) (ite  (and (>= j@@7 |l#0@@14|) (< j@@7 |l#1@@14|)) (ite (< j@@7 |l#2@@14|) (|Select__T@[Int]$1_aggregator_Aggregator_| |l#3@@14| j@@7) (|Select__T@[Int]$1_aggregator_Aggregator_| |l#4@@14| (+ j@@7 |l#5@@14|))) |l#6@@7|))
 :qid |boogiebpl.64:20|
 :skolemid |569|
 :pattern ( (|Select__T@[Int]$1_aggregator_Aggregator_| (|lambda#7| |l#0@@14| |l#1@@14| |l#2@@14| |l#3@@14| |l#4@@14| |l#5@@14| |l#6@@7|) j@@7))
)))
(assert (forall ((|l#0@@15| Int) (|l#1@@15| Int) (|l#2@@15| Int) (|l#3@@15| |T@[Int]$1_optional_aggregator_Integer|) (|l#4@@15| |T@[Int]$1_optional_aggregator_Integer|) (|l#5@@15| Int) (|l#6@@8| T@$1_optional_aggregator_Integer) (j@@8 Int) ) (! (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|lambda#11| |l#0@@15| |l#1@@15| |l#2@@15| |l#3@@15| |l#4@@15| |l#5@@15| |l#6@@8|) j@@8) (ite  (and (>= j@@8 |l#0@@15|) (< j@@8 |l#1@@15|)) (ite (< j@@8 |l#2@@15|) (|Select__T@[Int]$1_optional_aggregator_Integer_| |l#3@@15| j@@8) (|Select__T@[Int]$1_optional_aggregator_Integer_| |l#4@@15| (+ j@@8 |l#5@@15|))) |l#6@@8|))
 :qid |boogiebpl.64:20|
 :skolemid |573|
 :pattern ( (|Select__T@[Int]$1_optional_aggregator_Integer_| (|lambda#11| |l#0@@15| |l#1@@15| |l#2@@15| |l#3@@15| |l#4@@15| |l#5@@15| |l#6@@8|) j@@8))
)))
(assert (forall ((|l#0@@16| Int) (|l#1@@16| Int) (|l#2@@16| Int) (|l#3@@16| |T@[Int]$1_optional_aggregator_OptionalAggregator|) (|l#4@@16| |T@[Int]$1_optional_aggregator_OptionalAggregator|) (|l#5@@16| Int) (|l#6@@9| T@$1_optional_aggregator_OptionalAggregator) (j@@9 Int) ) (! (= (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|lambda#15| |l#0@@16| |l#1@@16| |l#2@@16| |l#3@@16| |l#4@@16| |l#5@@16| |l#6@@9|) j@@9) (ite  (and (>= j@@9 |l#0@@16|) (< j@@9 |l#1@@16|)) (ite (< j@@9 |l#2@@16|) (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| |l#3@@16| j@@9) (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| |l#4@@16| (+ j@@9 |l#5@@16|))) |l#6@@9|))
 :qid |boogiebpl.64:20|
 :skolemid |577|
 :pattern ( (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|lambda#15| |l#0@@16| |l#1@@16| |l#2@@16| |l#3@@16| |l#4@@16| |l#5@@16| |l#6@@9|) j@@9))
)))
(assert (forall ((|l#0@@17| Int) (|l#1@@17| Int) (|l#2@@17| Int) (|l#3@@17| |T@[Int]Int|) (|l#4@@17| |T@[Int]Int|) (|l#5@@17| Int) (|l#6@@10| Int) (j@@10 Int) ) (! (= (|Select__T@[Int]Int_| (|lambda#19| |l#0@@17| |l#1@@17| |l#2@@17| |l#3@@17| |l#4@@17| |l#5@@17| |l#6@@10|) j@@10) (ite  (and (>= j@@10 |l#0@@17|) (< j@@10 |l#1@@17|)) (ite (< j@@10 |l#2@@17|) (|Select__T@[Int]Int_| |l#3@@17| j@@10) (|Select__T@[Int]Int_| |l#4@@17| (+ j@@10 |l#5@@17|))) |l#6@@10|))
 :qid |boogiebpl.64:20|
 :skolemid |581|
 :pattern ( (|Select__T@[Int]Int_| (|lambda#19| |l#0@@17| |l#1@@17| |l#2@@17| |l#3@@17| |l#4@@17| |l#5@@17| |l#6@@10|) j@@10))
)))
(assert (forall ((|l#0@@18| Int) (|l#1@@18| Int) (|l#2@@18| Int) (|l#3@@18| |T@[Int](_ BitVec 64)|) (|l#4@@18| |T@[Int](_ BitVec 64)|) (|l#5@@18| Int) (|l#6@@11| (_ BitVec 64)) (j@@11 Int) ) (! (= (|Select__T@[Int](_ BitVec 64)_| (|lambda#23| |l#0@@18| |l#1@@18| |l#2@@18| |l#3@@18| |l#4@@18| |l#5@@18| |l#6@@11|) j@@11) (ite  (and (>= j@@11 |l#0@@18|) (< j@@11 |l#1@@18|)) (ite (< j@@11 |l#2@@18|) (|Select__T@[Int](_ BitVec 64)_| |l#3@@18| j@@11) (|Select__T@[Int](_ BitVec 64)_| |l#4@@18| (+ j@@11 |l#5@@18|))) |l#6@@11|))
 :qid |boogiebpl.64:20|
 :skolemid |585|
 :pattern ( (|Select__T@[Int](_ BitVec 64)_| (|lambda#23| |l#0@@18| |l#1@@18| |l#2@@18| |l#3@@18| |l#4@@18| |l#5@@18| |l#6@@11|) j@@11))
)))
(assert (forall ((|l#0@@19| Int) (|l#1@@19| Int) (|l#2@@19| Int) (|l#3@@19| |T@[Int](_ BitVec 8)|) (|l#4@@19| |T@[Int](_ BitVec 8)|) (|l#5@@19| Int) (|l#6@@12| (_ BitVec 8)) (j@@12 Int) ) (! (= (|Select__T@[Int](_ BitVec 8)_| (|lambda#27| |l#0@@19| |l#1@@19| |l#2@@19| |l#3@@19| |l#4@@19| |l#5@@19| |l#6@@12|) j@@12) (ite  (and (>= j@@12 |l#0@@19|) (< j@@12 |l#1@@19|)) (ite (< j@@12 |l#2@@19|) (|Select__T@[Int](_ BitVec 8)_| |l#3@@19| j@@12) (|Select__T@[Int](_ BitVec 8)_| |l#4@@19| (+ j@@12 |l#5@@19|))) |l#6@@12|))
 :qid |boogiebpl.64:20|
 :skolemid |589|
 :pattern ( (|Select__T@[Int](_ BitVec 8)_| (|lambda#27| |l#0@@19| |l#1@@19| |l#2@@19| |l#3@@19| |l#4@@19| |l#5@@19| |l#6@@12|) j@@12))
)))
(assert (forall ((v@@15 (_ BitVec 32)) ) (! (= (|$IsValid'bv32'| v@@15)  (and (bvuge v@@15 #x00000000) (bvule v@@15 #x7fffffff)))
 :qid |boogiebpl.673:25|
 :skolemid |16|
 :pattern ( (|$IsValid'bv32'| v@@15))
)))
(assert (forall ((v@@16 Int) ) (! (let ((r (|$1_bcs_serialize'address'| v@@16)))
 (and (|$IsValid'vec'u8''| r) (> (|l#Vec_6673| r) 0)))
 :qid |boogiebpl.6470:15|
 :skolemid |243|
 :pattern ( (|$1_bcs_serialize'address'| v@@16))
)))
(assert (forall ((b1 T@Vec_6673) (b2 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1) (=> (|$IsValid'vec'u8''| b2) (=> (|$IsEqual'vec'u8''| ($1_aptos_hash_spec_keccak256 b1) ($1_aptos_hash_spec_keccak256 b2)) (|$IsEqual'vec'u8''| b1 b2))))
 :qid |boogiebpl.6890:15|
 :skolemid |379|
)))
(assert (forall ((b1@@0 T@Vec_6673) (b2@@0 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@0) (=> (|$IsValid'vec'u8''| b2@@0) (=> (|$IsEqual'vec'u8''| ($1_aptos_hash_spec_sha2_512_internal b1@@0) ($1_aptos_hash_spec_sha2_512_internal b2@@0)) (|$IsEqual'vec'u8''| b1@@0 b2@@0))))
 :qid |boogiebpl.6893:15|
 :skolemid |380|
)))
(assert (forall ((b1@@1 T@Vec_6673) (b2@@1 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@1) (=> (|$IsValid'vec'u8''| b2@@1) (=> (|$IsEqual'vec'u8''| ($1_aptos_hash_spec_sha3_512_internal b1@@1) ($1_aptos_hash_spec_sha3_512_internal b2@@1)) (|$IsEqual'vec'u8''| b1@@1 b2@@1))))
 :qid |boogiebpl.6896:15|
 :skolemid |381|
)))
(assert (forall ((b1@@2 T@Vec_6673) (b2@@2 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@2) (=> (|$IsValid'vec'u8''| b2@@2) (=> (|$IsEqual'vec'u8''| ($1_aptos_hash_spec_ripemd160_internal b1@@2) ($1_aptos_hash_spec_ripemd160_internal b2@@2)) (|$IsEqual'vec'u8''| b1@@2 b2@@2))))
 :qid |boogiebpl.6899:15|
 :skolemid |382|
)))
(assert (forall ((b1@@3 T@Vec_6673) (b2@@3 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@3) (=> (|$IsValid'vec'u8''| b2@@3) (=> (|$IsEqual'vec'u8''| ($1_aptos_hash_spec_blake2b_256_internal b1@@3) ($1_aptos_hash_spec_blake2b_256_internal b2@@3)) (|$IsEqual'vec'u8''| b1@@3 b2@@3))))
 :qid |boogiebpl.6902:15|
 :skolemid |383|
)))
(assert (forall ((v@@17 Int) ) (! (= (|$IsValid'address'| v@@17) (>= v@@17 0))
 :qid |boogiebpl.1109:28|
 :skolemid |27|
 :pattern ( (|$IsValid'address'| v@@17))
)))
(assert (forall ((t@@1 T@$TypeParamInfo) ) (!  (=> (is-$TypeParamSigner t@@1) (|$IsEqual'vec'u8''| ($TypeName t@@1) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 115) 1 105) 2 103) 3 110) 4 101) 5 114) 6)))
 :qid |boogiebpl.6537:15|
 :skolemid |261|
 :pattern ( ($TypeName t@@1))
)))
(assert (forall ((v@@18 T@Vec_85428) (suffix T@Vec_85428) ) (! (= (|$IsSuffix'vec'#0''| v@@18 suffix)  (and (>= (|l#Vec_85428| v@@18) (|l#Vec_85428| suffix)) (forall ((i@@45 Int) ) (!  (=> (InRangeVec_65852 suffix i@@45) (= (|Select__T@[Int]#0_| (|v#Vec_85428| v@@18) (+ (- (|l#Vec_85428| v@@18) (|l#Vec_85428| suffix)) i@@45)) (|Select__T@[Int]#0_| (|v#Vec_85428| suffix) i@@45)))
 :qid |boogiebpl.3092:13|
 :skolemid |117|
))))
 :qid |boogiebpl.3090:29|
 :skolemid |118|
 :pattern ( (|$IsSuffix'vec'#0''| v@@18 suffix))
)))
(assert (forall ((v@@19 T@Vec_90390) (suffix@@0 T@Vec_90390) ) (! (= (|$IsSuffix'vec'$1_aggregator_Aggregator''| v@@19 suffix@@0)  (and (>= (|l#Vec_90390| v@@19) (|l#Vec_90390| suffix@@0)) (forall ((i@@46 Int) ) (!  (=> (InRangeVec_66199 suffix@@0 i@@46) (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| v@@19) (+ (- (|l#Vec_90390| v@@19) (|l#Vec_90390| suffix@@0)) i@@46)) (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| suffix@@0) i@@46)))
 :qid |boogiebpl.3396:13|
 :skolemid |128|
))))
 :qid |boogiebpl.3394:51|
 :skolemid |129|
 :pattern ( (|$IsSuffix'vec'$1_aggregator_Aggregator''| v@@19 suffix@@0))
)))
(assert (forall ((v@@20 T@Vec_95276) (suffix@@1 T@Vec_95276) ) (! (= (|$IsSuffix'vec'$1_optional_aggregator_Integer''| v@@20 suffix@@1)  (and (>= (|l#Vec_95276| v@@20) (|l#Vec_95276| suffix@@1)) (forall ((i@@47 Int) ) (!  (=> (InRangeVec_66546 suffix@@1 i@@47) (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| v@@20) (+ (- (|l#Vec_95276| v@@20) (|l#Vec_95276| suffix@@1)) i@@47)) (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| suffix@@1) i@@47)))
 :qid |boogiebpl.3700:13|
 :skolemid |139|
))))
 :qid |boogiebpl.3698:57|
 :skolemid |140|
 :pattern ( (|$IsSuffix'vec'$1_optional_aggregator_Integer''| v@@20 suffix@@1))
)))
(assert (forall ((v@@21 T@Vec_100175) (suffix@@2 T@Vec_100175) ) (! (= (|$IsSuffix'vec'$1_optional_aggregator_OptionalAggregator''| v@@21 suffix@@2)  (and (>= (|l#Vec_100175| v@@21) (|l#Vec_100175| suffix@@2)) (forall ((i@@48 Int) ) (!  (=> (InRangeVec_66893 suffix@@2 i@@48) (and (|$IsEqual'vec'$1_aggregator_Aggregator''| (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@21) (+ (- (|l#Vec_100175| v@@21) (|l#Vec_100175| suffix@@2)) i@@48)))) (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| suffix@@2) i@@48)))) (|$IsEqual'vec'$1_optional_aggregator_Integer''| (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@21) (+ (- (|l#Vec_100175| v@@21) (|l#Vec_100175| suffix@@2)) i@@48)))) (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| suffix@@2) i@@48))))))
 :qid |boogiebpl.4004:13|
 :skolemid |150|
))))
 :qid |boogiebpl.4002:68|
 :skolemid |151|
 :pattern ( (|$IsSuffix'vec'$1_optional_aggregator_OptionalAggregator''| v@@21 suffix@@2))
)))
(assert (forall ((v@@22 T@Vec_6673) (suffix@@3 T@Vec_6673) ) (! (= (|$IsSuffix'vec'address''| v@@22 suffix@@3)  (and (>= (|l#Vec_6673| v@@22) (|l#Vec_6673| suffix@@3)) (forall ((i@@49 Int) ) (!  (=> (InRangeVec_25002 suffix@@3 i@@49) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@22) (+ (- (|l#Vec_6673| v@@22) (|l#Vec_6673| suffix@@3)) i@@49)) (|Select__T@[Int]Int_| (|v#Vec_6673| suffix@@3) i@@49)))
 :qid |boogiebpl.4308:13|
 :skolemid |161|
))))
 :qid |boogiebpl.4306:34|
 :skolemid |162|
 :pattern ( (|$IsSuffix'vec'address''| v@@22 suffix@@3))
)))
(assert (forall ((v@@23 T@Vec_6673) (suffix@@4 T@Vec_6673) ) (! (= (|$IsSuffix'vec'u64''| v@@23 suffix@@4)  (and (>= (|l#Vec_6673| v@@23) (|l#Vec_6673| suffix@@4)) (forall ((i@@50 Int) ) (!  (=> (InRangeVec_25002 suffix@@4 i@@50) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@23) (+ (- (|l#Vec_6673| v@@23) (|l#Vec_6673| suffix@@4)) i@@50)) (|Select__T@[Int]Int_| (|v#Vec_6673| suffix@@4) i@@50)))
 :qid |boogiebpl.4612:13|
 :skolemid |172|
))))
 :qid |boogiebpl.4610:30|
 :skolemid |173|
 :pattern ( (|$IsSuffix'vec'u64''| v@@23 suffix@@4))
)))
(assert (forall ((v@@24 T@Vec_6673) (suffix@@5 T@Vec_6673) ) (! (= (|$IsSuffix'vec'u8''| v@@24 suffix@@5)  (and (>= (|l#Vec_6673| v@@24) (|l#Vec_6673| suffix@@5)) (forall ((i@@51 Int) ) (!  (=> (InRangeVec_25002 suffix@@5 i@@51) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@24) (+ (- (|l#Vec_6673| v@@24) (|l#Vec_6673| suffix@@5)) i@@51)) (|Select__T@[Int]Int_| (|v#Vec_6673| suffix@@5) i@@51)))
 :qid |boogiebpl.4916:13|
 :skolemid |183|
))))
 :qid |boogiebpl.4914:29|
 :skolemid |184|
 :pattern ( (|$IsSuffix'vec'u8''| v@@24 suffix@@5))
)))
(assert (forall ((v@@25 T@Vec_67815) (suffix@@6 T@Vec_67815) ) (! (= (|$IsSuffix'vec'bv64''| v@@25 suffix@@6)  (and (>= (|l#Vec_67815| v@@25) (|l#Vec_67815| suffix@@6)) (forall ((i@@52 Int) ) (!  (=> (InRangeVec_67819 suffix@@6 i@@52) (= (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| v@@25) (+ (- (|l#Vec_67815| v@@25) (|l#Vec_67815| suffix@@6)) i@@52)) (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| suffix@@6) i@@52)))
 :qid |boogiebpl.5220:13|
 :skolemid |194|
))))
 :qid |boogiebpl.5218:31|
 :skolemid |195|
 :pattern ( (|$IsSuffix'vec'bv64''| v@@25 suffix@@6))
)))
(assert (forall ((v@@26 T@Vec_68162) (suffix@@7 T@Vec_68162) ) (! (= (|$IsSuffix'vec'bv8''| v@@26 suffix@@7)  (and (>= (|l#Vec_68162| v@@26) (|l#Vec_68162| suffix@@7)) (forall ((i@@53 Int) ) (!  (=> (InRangeVec_68166 suffix@@7 i@@53) (= (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| v@@26) (+ (- (|l#Vec_68162| v@@26) (|l#Vec_68162| suffix@@7)) i@@53)) (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| suffix@@7) i@@53)))
 :qid |boogiebpl.5524:13|
 :skolemid |205|
))))
 :qid |boogiebpl.5522:30|
 :skolemid |206|
 :pattern ( (|$IsSuffix'vec'bv8''| v@@26 suffix@@7))
)))
(assert (forall ((|l#0@@20| Int) (|l#1@@20| Int) (|l#2@@20| |T@[Int]#0|) (|l#3@@20| Int) (|l#4@@20| |T@#0|) (k@@2 Int) ) (! (= (|Select__T@[Int]#0_| (|lambda#2| |l#0@@20| |l#1@@20| |l#2@@20| |l#3@@20| |l#4@@20|) k@@2) (ite  (and (<= |l#0@@20| k@@2) (< k@@2 |l#1@@20|)) (|Select__T@[Int]#0_| |l#2@@20| (+ |l#3@@20| k@@2)) |l#4@@20|))
 :qid |boogiebpl.91:14|
 :skolemid |564|
 :pattern ( (|Select__T@[Int]#0_| (|lambda#2| |l#0@@20| |l#1@@20| |l#2@@20| |l#3@@20| |l#4@@20|) k@@2))
)))
(assert (forall ((|l#0@@21| Int) (|l#1@@21| Int) (|l#2@@21| |T@[Int]$1_aggregator_Aggregator|) (|l#3@@21| Int) (|l#4@@21| T@$1_aggregator_Aggregator) (k@@3 Int) ) (! (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|lambda#6| |l#0@@21| |l#1@@21| |l#2@@21| |l#3@@21| |l#4@@21|) k@@3) (ite  (and (<= |l#0@@21| k@@3) (< k@@3 |l#1@@21|)) (|Select__T@[Int]$1_aggregator_Aggregator_| |l#2@@21| (+ |l#3@@21| k@@3)) |l#4@@21|))
 :qid |boogiebpl.91:14|
 :skolemid |568|
 :pattern ( (|Select__T@[Int]$1_aggregator_Aggregator_| (|lambda#6| |l#0@@21| |l#1@@21| |l#2@@21| |l#3@@21| |l#4@@21|) k@@3))
)))
(assert (forall ((|l#0@@22| Int) (|l#1@@22| Int) (|l#2@@22| |T@[Int]$1_optional_aggregator_Integer|) (|l#3@@22| Int) (|l#4@@22| T@$1_optional_aggregator_Integer) (k@@4 Int) ) (! (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|lambda#10| |l#0@@22| |l#1@@22| |l#2@@22| |l#3@@22| |l#4@@22|) k@@4) (ite  (and (<= |l#0@@22| k@@4) (< k@@4 |l#1@@22|)) (|Select__T@[Int]$1_optional_aggregator_Integer_| |l#2@@22| (+ |l#3@@22| k@@4)) |l#4@@22|))
 :qid |boogiebpl.91:14|
 :skolemid |572|
 :pattern ( (|Select__T@[Int]$1_optional_aggregator_Integer_| (|lambda#10| |l#0@@22| |l#1@@22| |l#2@@22| |l#3@@22| |l#4@@22|) k@@4))
)))
(assert (forall ((|l#0@@23| Int) (|l#1@@23| Int) (|l#2@@23| |T@[Int]$1_optional_aggregator_OptionalAggregator|) (|l#3@@23| Int) (|l#4@@23| T@$1_optional_aggregator_OptionalAggregator) (k@@5 Int) ) (! (= (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|lambda#14| |l#0@@23| |l#1@@23| |l#2@@23| |l#3@@23| |l#4@@23|) k@@5) (ite  (and (<= |l#0@@23| k@@5) (< k@@5 |l#1@@23|)) (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| |l#2@@23| (+ |l#3@@23| k@@5)) |l#4@@23|))
 :qid |boogiebpl.91:14|
 :skolemid |576|
 :pattern ( (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|lambda#14| |l#0@@23| |l#1@@23| |l#2@@23| |l#3@@23| |l#4@@23|) k@@5))
)))
(assert (forall ((|l#0@@24| Int) (|l#1@@24| Int) (|l#2@@24| |T@[Int]Int|) (|l#3@@24| Int) (|l#4@@24| Int) (k@@6 Int) ) (! (= (|Select__T@[Int]Int_| (|lambda#18| |l#0@@24| |l#1@@24| |l#2@@24| |l#3@@24| |l#4@@24|) k@@6) (ite  (and (<= |l#0@@24| k@@6) (< k@@6 |l#1@@24|)) (|Select__T@[Int]Int_| |l#2@@24| (+ |l#3@@24| k@@6)) |l#4@@24|))
 :qid |boogiebpl.91:14|
 :skolemid |580|
 :pattern ( (|Select__T@[Int]Int_| (|lambda#18| |l#0@@24| |l#1@@24| |l#2@@24| |l#3@@24| |l#4@@24|) k@@6))
)))
(assert (forall ((|l#0@@25| Int) (|l#1@@25| Int) (|l#2@@25| |T@[Int](_ BitVec 64)|) (|l#3@@25| Int) (|l#4@@25| (_ BitVec 64)) (k@@7 Int) ) (! (= (|Select__T@[Int](_ BitVec 64)_| (|lambda#22| |l#0@@25| |l#1@@25| |l#2@@25| |l#3@@25| |l#4@@25|) k@@7) (ite  (and (<= |l#0@@25| k@@7) (< k@@7 |l#1@@25|)) (|Select__T@[Int](_ BitVec 64)_| |l#2@@25| (+ |l#3@@25| k@@7)) |l#4@@25|))
 :qid |boogiebpl.91:14|
 :skolemid |584|
 :pattern ( (|Select__T@[Int](_ BitVec 64)_| (|lambda#22| |l#0@@25| |l#1@@25| |l#2@@25| |l#3@@25| |l#4@@25|) k@@7))
)))
(assert (forall ((|l#0@@26| Int) (|l#1@@26| Int) (|l#2@@26| |T@[Int](_ BitVec 8)|) (|l#3@@26| Int) (|l#4@@26| (_ BitVec 8)) (k@@8 Int) ) (! (= (|Select__T@[Int](_ BitVec 8)_| (|lambda#26| |l#0@@26| |l#1@@26| |l#2@@26| |l#3@@26| |l#4@@26|) k@@8) (ite  (and (<= |l#0@@26| k@@8) (< k@@8 |l#1@@26|)) (|Select__T@[Int](_ BitVec 8)_| |l#2@@26| (+ |l#3@@26| k@@8)) |l#4@@26|))
 :qid |boogiebpl.91:14|
 :skolemid |588|
 :pattern ( (|Select__T@[Int](_ BitVec 8)_| (|lambda#26| |l#0@@26| |l#1@@26| |l#2@@26| |l#3@@26| |l#4@@26|) k@@8))
)))
(assert (forall ((source Int) (seed T@Vec_6673) ) (! (let (($$res ($1_account_spec_create_resource_address source seed)))
(|$IsValid'address'| $$res))
 :qid |boogiebpl.8452:15|
 :skolemid |510|
)))
(assert (forall ((b1@@4 T@Vec_6673) (b2@@4 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@4) (=> (|$IsValid'vec'u8''| b2@@4) (=> (|$IsEqual'vec'u8''| b1@@4 b2@@4) (= (|$1_from_bcs_deserializable'bool'| b1@@4) (|$1_from_bcs_deserializable'bool'| b2@@4)))))
 :qid |boogiebpl.6554:15|
 :skolemid |267|
)))
(assert (forall ((b1@@5 T@Vec_6673) (b2@@5 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@5) (=> (|$IsValid'vec'u8''| b2@@5) (=> (|$IsEqual'vec'u8''| b1@@5 b2@@5) (= (|$1_from_bcs_deserializable'u8'| b1@@5) (|$1_from_bcs_deserializable'u8'| b2@@5)))))
 :qid |boogiebpl.6557:15|
 :skolemid |268|
)))
(assert (forall ((b1@@6 T@Vec_6673) (b2@@6 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@6) (=> (|$IsValid'vec'u8''| b2@@6) (=> (|$IsEqual'vec'u8''| b1@@6 b2@@6) (= (|$1_from_bcs_deserializable'u64'| b1@@6) (|$1_from_bcs_deserializable'u64'| b2@@6)))))
 :qid |boogiebpl.6560:15|
 :skolemid |269|
)))
(assert (forall ((b1@@7 T@Vec_6673) (b2@@7 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@7) (=> (|$IsValid'vec'u8''| b2@@7) (=> (|$IsEqual'vec'u8''| b1@@7 b2@@7) (= (|$1_from_bcs_deserializable'u128'| b1@@7) (|$1_from_bcs_deserializable'u128'| b2@@7)))))
 :qid |boogiebpl.6563:15|
 :skolemid |270|
)))
(assert (forall ((b1@@8 T@Vec_6673) (b2@@8 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@8) (=> (|$IsValid'vec'u8''| b2@@8) (=> (|$IsEqual'vec'u8''| b1@@8 b2@@8) (= (|$1_from_bcs_deserializable'u256'| b1@@8) (|$1_from_bcs_deserializable'u256'| b2@@8)))))
 :qid |boogiebpl.6566:15|
 :skolemid |271|
)))
(assert (forall ((b1@@9 T@Vec_6673) (b2@@9 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@9) (=> (|$IsValid'vec'u8''| b2@@9) (=> (|$IsEqual'vec'u8''| b1@@9 b2@@9) (= (|$1_from_bcs_deserializable'address'| b1@@9) (|$1_from_bcs_deserializable'address'| b2@@9)))))
 :qid |boogiebpl.6569:15|
 :skolemid |272|
)))
(assert (forall ((b1@@10 T@Vec_6673) (b2@@10 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@10) (=> (|$IsValid'vec'u8''| b2@@10) (=> (|$IsEqual'vec'u8''| b1@@10 b2@@10) (= (|$1_from_bcs_deserializable'signer'| b1@@10) (|$1_from_bcs_deserializable'signer'| b2@@10)))))
 :qid |boogiebpl.6572:15|
 :skolemid |273|
)))
(assert (forall ((b1@@11 T@Vec_6673) (b2@@11 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@11) (=> (|$IsValid'vec'u8''| b2@@11) (=> (|$IsEqual'vec'u8''| b1@@11 b2@@11) (= (|$1_from_bcs_deserializable'vec'u8''| b1@@11) (|$1_from_bcs_deserializable'vec'u8''| b2@@11)))))
 :qid |boogiebpl.6575:15|
 :skolemid |274|
)))
(assert (forall ((b1@@12 T@Vec_6673) (b2@@12 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@12) (=> (|$IsValid'vec'u8''| b2@@12) (=> (|$IsEqual'vec'u8''| b1@@12 b2@@12) (= (|$1_from_bcs_deserializable'vec'u64''| b1@@12) (|$1_from_bcs_deserializable'vec'u64''| b2@@12)))))
 :qid |boogiebpl.6578:15|
 :skolemid |275|
)))
(assert (forall ((b1@@13 T@Vec_6673) (b2@@13 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@13) (=> (|$IsValid'vec'u8''| b2@@13) (=> (|$IsEqual'vec'u8''| b1@@13 b2@@13) (= (|$1_from_bcs_deserializable'vec'address''| b1@@13) (|$1_from_bcs_deserializable'vec'address''| b2@@13)))))
 :qid |boogiebpl.6581:15|
 :skolemid |276|
)))
(assert (forall ((b1@@14 T@Vec_6673) (b2@@14 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@14) (=> (|$IsValid'vec'u8''| b2@@14) (=> (|$IsEqual'vec'u8''| b1@@14 b2@@14) (= (|$1_from_bcs_deserializable'vec'$1_aggregator_Aggregator''| b1@@14) (|$1_from_bcs_deserializable'vec'$1_aggregator_Aggregator''| b2@@14)))))
 :qid |boogiebpl.6584:15|
 :skolemid |277|
)))
(assert (forall ((b1@@15 T@Vec_6673) (b2@@15 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@15) (=> (|$IsValid'vec'u8''| b2@@15) (=> (|$IsEqual'vec'u8''| b1@@15 b2@@15) (= (|$1_from_bcs_deserializable'vec'$1_optional_aggregator_Integer''| b1@@15) (|$1_from_bcs_deserializable'vec'$1_optional_aggregator_Integer''| b2@@15)))))
 :qid |boogiebpl.6587:15|
 :skolemid |278|
)))
(assert (forall ((b1@@16 T@Vec_6673) (b2@@16 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@16) (=> (|$IsValid'vec'u8''| b2@@16) (=> (|$IsEqual'vec'u8''| b1@@16 b2@@16) (= (|$1_from_bcs_deserializable'vec'$1_optional_aggregator_OptionalAggregator''| b1@@16) (|$1_from_bcs_deserializable'vec'$1_optional_aggregator_OptionalAggregator''| b2@@16)))))
 :qid |boogiebpl.6590:15|
 :skolemid |279|
)))
(assert (forall ((b1@@17 T@Vec_6673) (b2@@17 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@17) (=> (|$IsValid'vec'u8''| b2@@17) (=> (|$IsEqual'vec'u8''| b1@@17 b2@@17) (= (|$1_from_bcs_deserializable'vec'#0''| b1@@17) (|$1_from_bcs_deserializable'vec'#0''| b2@@17)))))
 :qid |boogiebpl.6593:15|
 :skolemid |280|
)))
(assert (forall ((b1@@18 T@Vec_6673) (b2@@18 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@18) (=> (|$IsValid'vec'u8''| b2@@18) (=> (|$IsEqual'vec'u8''| b1@@18 b2@@18) (= (|$1_from_bcs_deserializable'$1_table_Table'u64_bool''| b1@@18) (|$1_from_bcs_deserializable'$1_table_Table'u64_bool''| b2@@18)))))
 :qid |boogiebpl.6596:15|
 :skolemid |281|
)))
(assert (forall ((b1@@19 T@Vec_6673) (b2@@19 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@19) (=> (|$IsValid'vec'u8''| b2@@19) (=> (|$IsEqual'vec'u8''| b1@@19 b2@@19) (= (|$1_from_bcs_deserializable'$1_table_Table'u64_u64''| b1@@19) (|$1_from_bcs_deserializable'$1_table_Table'u64_u64''| b2@@19)))))
 :qid |boogiebpl.6599:15|
 :skolemid |282|
)))
(assert (forall ((b1@@20 T@Vec_6673) (b2@@20 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@20) (=> (|$IsValid'vec'u8''| b2@@20) (=> (|$IsEqual'vec'u8''| b1@@20 b2@@20) (= (|$1_from_bcs_deserializable'$1_table_Table'u64_vec'u64'''| b1@@20) (|$1_from_bcs_deserializable'$1_table_Table'u64_vec'u64'''| b2@@20)))))
 :qid |boogiebpl.6602:15|
 :skolemid |283|
)))
(assert (forall ((b1@@21 T@Vec_6673) (b2@@21 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@21) (=> (|$IsValid'vec'u8''| b2@@21) (=> (|$IsEqual'vec'u8''| b1@@21 b2@@21) (= (|$1_from_bcs_deserializable'$1_table_Table'address_address''| b1@@21) (|$1_from_bcs_deserializable'$1_table_Table'address_address''| b2@@21)))))
 :qid |boogiebpl.6605:15|
 :skolemid |284|
)))
(assert (forall ((b1@@22 T@Vec_6673) (b2@@22 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@22) (=> (|$IsValid'vec'u8''| b2@@22) (=> (|$IsEqual'vec'u8''| b1@@22 b2@@22) (= (|$1_from_bcs_deserializable'$1_option_Option'address''| b1@@22) (|$1_from_bcs_deserializable'$1_option_Option'address''| b2@@22)))))
 :qid |boogiebpl.6608:15|
 :skolemid |285|
)))
(assert (forall ((b1@@23 T@Vec_6673) (b2@@23 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@23) (=> (|$IsValid'vec'u8''| b2@@23) (=> (|$IsEqual'vec'u8''| b1@@23 b2@@23) (= (|$1_from_bcs_deserializable'$1_option_Option'$1_aggregator_Aggregator''| b1@@23) (|$1_from_bcs_deserializable'$1_option_Option'$1_aggregator_Aggregator''| b2@@23)))))
 :qid |boogiebpl.6611:15|
 :skolemid |286|
)))
(assert (forall ((b1@@24 T@Vec_6673) (b2@@24 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@24) (=> (|$IsValid'vec'u8''| b2@@24) (=> (|$IsEqual'vec'u8''| b1@@24 b2@@24) (= (|$1_from_bcs_deserializable'$1_option_Option'$1_optional_aggregator_Integer''| b1@@24) (|$1_from_bcs_deserializable'$1_option_Option'$1_optional_aggregator_Integer''| b2@@24)))))
 :qid |boogiebpl.6614:15|
 :skolemid |287|
)))
(assert (forall ((b1@@25 T@Vec_6673) (b2@@25 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@25) (=> (|$IsValid'vec'u8''| b2@@25) (=> (|$IsEqual'vec'u8''| b1@@25 b2@@25) (= (|$1_from_bcs_deserializable'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| b1@@25) (|$1_from_bcs_deserializable'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| b2@@25)))))
 :qid |boogiebpl.6617:15|
 :skolemid |288|
)))
(assert (forall ((b1@@26 T@Vec_6673) (b2@@26 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@26) (=> (|$IsValid'vec'u8''| b2@@26) (=> (|$IsEqual'vec'u8''| b1@@26 b2@@26) (= (|$1_from_bcs_deserializable'$1_string_String'| b1@@26) (|$1_from_bcs_deserializable'$1_string_String'| b2@@26)))))
 :qid |boogiebpl.6620:15|
 :skolemid |289|
)))
(assert (forall ((b1@@27 T@Vec_6673) (b2@@27 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@27) (=> (|$IsValid'vec'u8''| b2@@27) (=> (|$IsEqual'vec'u8''| b1@@27 b2@@27) (= (|$1_from_bcs_deserializable'$1_type_info_TypeInfo'| b1@@27) (|$1_from_bcs_deserializable'$1_type_info_TypeInfo'| b2@@27)))))
 :qid |boogiebpl.6623:15|
 :skolemid |290|
)))
(assert (forall ((b1@@28 T@Vec_6673) (b2@@28 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@28) (=> (|$IsValid'vec'u8''| b2@@28) (=> (|$IsEqual'vec'u8''| b1@@28 b2@@28) (= (|$1_from_bcs_deserializable'$1_aggregator_Aggregator'| b1@@28) (|$1_from_bcs_deserializable'$1_aggregator_Aggregator'| b2@@28)))))
 :qid |boogiebpl.6626:15|
 :skolemid |291|
)))
(assert (forall ((b1@@29 T@Vec_6673) (b2@@29 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@29) (=> (|$IsValid'vec'u8''| b2@@29) (=> (|$IsEqual'vec'u8''| b1@@29 b2@@29) (= (|$1_from_bcs_deserializable'$1_optional_aggregator_Integer'| b1@@29) (|$1_from_bcs_deserializable'$1_optional_aggregator_Integer'| b2@@29)))))
 :qid |boogiebpl.6629:15|
 :skolemid |292|
)))
(assert (forall ((b1@@30 T@Vec_6673) (b2@@30 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@30) (=> (|$IsValid'vec'u8''| b2@@30) (=> (|$IsEqual'vec'u8''| b1@@30 b2@@30) (= (|$1_from_bcs_deserializable'$1_optional_aggregator_OptionalAggregator'| b1@@30) (|$1_from_bcs_deserializable'$1_optional_aggregator_OptionalAggregator'| b2@@30)))))
 :qid |boogiebpl.6632:15|
 :skolemid |293|
)))
(assert (forall ((b1@@31 T@Vec_6673) (b2@@31 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@31) (=> (|$IsValid'vec'u8''| b2@@31) (=> (|$IsEqual'vec'u8''| b1@@31 b2@@31) (= (|$1_from_bcs_deserializable'$1_guid_GUID'| b1@@31) (|$1_from_bcs_deserializable'$1_guid_GUID'| b2@@31)))))
 :qid |boogiebpl.6635:15|
 :skolemid |294|
)))
(assert (forall ((b1@@32 T@Vec_6673) (b2@@32 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@32) (=> (|$IsValid'vec'u8''| b2@@32) (=> (|$IsEqual'vec'u8''| b1@@32 b2@@32) (= (|$1_from_bcs_deserializable'$1_guid_ID'| b1@@32) (|$1_from_bcs_deserializable'$1_guid_ID'| b2@@32)))))
 :qid |boogiebpl.6638:15|
 :skolemid |295|
)))
(assert (forall ((b1@@33 T@Vec_6673) (b2@@33 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@33) (=> (|$IsValid'vec'u8''| b2@@33) (=> (|$IsEqual'vec'u8''| b1@@33 b2@@33) (= (|$1_from_bcs_deserializable'$1_event_EventHandle'$1_account_CoinRegisterEvent''| b1@@33) (|$1_from_bcs_deserializable'$1_event_EventHandle'$1_account_CoinRegisterEvent''| b2@@33)))))
 :qid |boogiebpl.6641:15|
 :skolemid |296|
)))
(assert (forall ((b1@@34 T@Vec_6673) (b2@@34 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@34) (=> (|$IsValid'vec'u8''| b2@@34) (=> (|$IsEqual'vec'u8''| b1@@34 b2@@34) (= (|$1_from_bcs_deserializable'$1_event_EventHandle'$1_account_KeyRotationEvent''| b1@@34) (|$1_from_bcs_deserializable'$1_event_EventHandle'$1_account_KeyRotationEvent''| b2@@34)))))
 :qid |boogiebpl.6644:15|
 :skolemid |297|
)))
(assert (forall ((b1@@35 T@Vec_6673) (b2@@35 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@35) (=> (|$IsValid'vec'u8''| b2@@35) (=> (|$IsEqual'vec'u8''| b1@@35 b2@@35) (= (|$1_from_bcs_deserializable'$1_event_EventHandle'$1_coin_DepositEvent''| b1@@35) (|$1_from_bcs_deserializable'$1_event_EventHandle'$1_coin_DepositEvent''| b2@@35)))))
 :qid |boogiebpl.6647:15|
 :skolemid |298|
)))
(assert (forall ((b1@@36 T@Vec_6673) (b2@@36 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@36) (=> (|$IsValid'vec'u8''| b2@@36) (=> (|$IsEqual'vec'u8''| b1@@36 b2@@36) (= (|$1_from_bcs_deserializable'$1_event_EventHandle'$1_coin_WithdrawEvent''| b1@@36) (|$1_from_bcs_deserializable'$1_event_EventHandle'$1_coin_WithdrawEvent''| b2@@36)))))
 :qid |boogiebpl.6650:15|
 :skolemid |299|
)))
(assert (forall ((b1@@37 T@Vec_6673) (b2@@37 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@37) (=> (|$IsValid'vec'u8''| b2@@37) (=> (|$IsEqual'vec'u8''| b1@@37 b2@@37) (= (|$1_from_bcs_deserializable'$1_account_Account'| b1@@37) (|$1_from_bcs_deserializable'$1_account_Account'| b2@@37)))))
 :qid |boogiebpl.6653:15|
 :skolemid |300|
)))
(assert (forall ((b1@@38 T@Vec_6673) (b2@@38 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@38) (=> (|$IsValid'vec'u8''| b2@@38) (=> (|$IsEqual'vec'u8''| b1@@38 b2@@38) (= (|$1_from_bcs_deserializable'$1_account_CapabilityOffer'$1_account_RotationCapability''| b1@@38) (|$1_from_bcs_deserializable'$1_account_CapabilityOffer'$1_account_RotationCapability''| b2@@38)))))
 :qid |boogiebpl.6656:15|
 :skolemid |301|
)))
(assert (forall ((b1@@39 T@Vec_6673) (b2@@39 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@39) (=> (|$IsValid'vec'u8''| b2@@39) (=> (|$IsEqual'vec'u8''| b1@@39 b2@@39) (= (|$1_from_bcs_deserializable'$1_account_CapabilityOffer'$1_account_SignerCapability''| b1@@39) (|$1_from_bcs_deserializable'$1_account_CapabilityOffer'$1_account_SignerCapability''| b2@@39)))))
 :qid |boogiebpl.6659:15|
 :skolemid |302|
)))
(assert (forall ((b1@@40 T@Vec_6673) (b2@@40 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@40) (=> (|$IsValid'vec'u8''| b2@@40) (=> (|$IsEqual'vec'u8''| b1@@40 b2@@40) (= (|$1_from_bcs_deserializable'$1_account_CoinRegisterEvent'| b1@@40) (|$1_from_bcs_deserializable'$1_account_CoinRegisterEvent'| b2@@40)))))
 :qid |boogiebpl.6662:15|
 :skolemid |303|
)))
(assert (forall ((b1@@41 T@Vec_6673) (b2@@41 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@41) (=> (|$IsValid'vec'u8''| b2@@41) (=> (|$IsEqual'vec'u8''| b1@@41 b2@@41) (= (|$1_from_bcs_deserializable'$1_account_SignerCapability'| b1@@41) (|$1_from_bcs_deserializable'$1_account_SignerCapability'| b2@@41)))))
 :qid |boogiebpl.6665:15|
 :skolemid |304|
)))
(assert (forall ((b1@@42 T@Vec_6673) (b2@@42 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@42) (=> (|$IsValid'vec'u8''| b2@@42) (=> (|$IsEqual'vec'u8''| b1@@42 b2@@42) (= (|$1_from_bcs_deserializable'$1_coin_Coin'$1_aptos_coin_AptosCoin''| b1@@42) (|$1_from_bcs_deserializable'$1_coin_Coin'$1_aptos_coin_AptosCoin''| b2@@42)))))
 :qid |boogiebpl.6668:15|
 :skolemid |305|
)))
(assert (forall ((b1@@43 T@Vec_6673) (b2@@43 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@43) (=> (|$IsValid'vec'u8''| b2@@43) (=> (|$IsEqual'vec'u8''| b1@@43 b2@@43) (= (|$1_from_bcs_deserializable'$1_coin_Coin'#0''| b1@@43) (|$1_from_bcs_deserializable'$1_coin_Coin'#0''| b2@@43)))))
 :qid |boogiebpl.6671:15|
 :skolemid |306|
)))
(assert (forall ((b1@@44 T@Vec_6673) (b2@@44 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@44) (=> (|$IsValid'vec'u8''| b2@@44) (=> (|$IsEqual'vec'u8''| b1@@44 b2@@44) (= (|$1_from_bcs_deserializable'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| b1@@44) (|$1_from_bcs_deserializable'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| b2@@44)))))
 :qid |boogiebpl.6674:15|
 :skolemid |307|
)))
(assert (forall ((b1@@45 T@Vec_6673) (b2@@45 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@45) (=> (|$IsValid'vec'u8''| b2@@45) (=> (|$IsEqual'vec'u8''| b1@@45 b2@@45) (= (|$1_from_bcs_deserializable'$1_coin_CoinInfo'#0''| b1@@45) (|$1_from_bcs_deserializable'$1_coin_CoinInfo'#0''| b2@@45)))))
 :qid |boogiebpl.6677:15|
 :skolemid |308|
)))
(assert (forall ((b1@@46 T@Vec_6673) (b2@@46 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@46) (=> (|$IsValid'vec'u8''| b2@@46) (=> (|$IsEqual'vec'u8''| b1@@46 b2@@46) (= (|$1_from_bcs_deserializable'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''| b1@@46) (|$1_from_bcs_deserializable'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''| b2@@46)))))
 :qid |boogiebpl.6680:15|
 :skolemid |309|
)))
(assert (forall ((b1@@47 T@Vec_6673) (b2@@47 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@47) (=> (|$IsValid'vec'u8''| b2@@47) (=> (|$IsEqual'vec'u8''| b1@@47 b2@@47) (= (|$1_from_bcs_deserializable'$1_coin_CoinStore'#0''| b1@@47) (|$1_from_bcs_deserializable'$1_coin_CoinStore'#0''| b2@@47)))))
 :qid |boogiebpl.6683:15|
 :skolemid |310|
)))
(assert (forall ((b1@@48 T@Vec_6673) (b2@@48 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@48) (=> (|$IsValid'vec'u8''| b2@@48) (=> (|$IsEqual'vec'u8''| b1@@48 b2@@48) (= (|$1_from_bcs_deserializable'$1_coin_DepositEvent'| b1@@48) (|$1_from_bcs_deserializable'$1_coin_DepositEvent'| b2@@48)))))
 :qid |boogiebpl.6686:15|
 :skolemid |311|
)))
(assert (forall ((b1@@49 T@Vec_6673) (b2@@49 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@49) (=> (|$IsValid'vec'u8''| b2@@49) (=> (|$IsEqual'vec'u8''| b1@@49 b2@@49) (= (|$1_from_bcs_deserializable'$1_coin_WithdrawEvent'| b1@@49) (|$1_from_bcs_deserializable'$1_coin_WithdrawEvent'| b2@@49)))))
 :qid |boogiebpl.6689:15|
 :skolemid |312|
)))
(assert (forall ((b1@@50 T@Vec_6673) (b2@@50 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@50) (=> (|$IsValid'vec'u8''| b2@@50) (=> (|$IsEqual'vec'u8''| b1@@50 b2@@50) (= (|$1_from_bcs_deserializable'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''| b1@@50) (|$1_from_bcs_deserializable'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''| b2@@50)))))
 :qid |boogiebpl.6692:15|
 :skolemid |313|
)))
(assert (forall ((b1@@51 T@Vec_6673) (b2@@51 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@51) (=> (|$IsValid'vec'u8''| b2@@51) (=> (|$IsEqual'vec'u8''| b1@@51 b2@@51) (= (|$1_from_bcs_deserializable'$1_coin_Ghost$supply'#0''| b1@@51) (|$1_from_bcs_deserializable'$1_coin_Ghost$supply'#0''| b2@@51)))))
 :qid |boogiebpl.6695:15|
 :skolemid |314|
)))
(assert (forall ((b1@@52 T@Vec_6673) (b2@@52 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@52) (=> (|$IsValid'vec'u8''| b2@@52) (=> (|$IsEqual'vec'u8''| b1@@52 b2@@52) (= (|$1_from_bcs_deserializable'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''| b1@@52) (|$1_from_bcs_deserializable'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''| b2@@52)))))
 :qid |boogiebpl.6698:15|
 :skolemid |315|
)))
(assert (forall ((b1@@53 T@Vec_6673) (b2@@53 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@53) (=> (|$IsValid'vec'u8''| b2@@53) (=> (|$IsEqual'vec'u8''| b1@@53 b2@@53) (= (|$1_from_bcs_deserializable'$1_coin_Ghost$aggregate_supply'#0''| b1@@53) (|$1_from_bcs_deserializable'$1_coin_Ghost$aggregate_supply'#0''| b2@@53)))))
 :qid |boogiebpl.6701:15|
 :skolemid |316|
)))
(assert (forall ((b1@@54 T@Vec_6673) (b2@@54 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@54) (=> (|$IsValid'vec'u8''| b2@@54) (=> (|$IsEqual'vec'u8''| b1@@54 b2@@54) (= (|$1_from_bcs_deserializable'$1_aptos_coin_AptosCoin'| b1@@54) (|$1_from_bcs_deserializable'$1_aptos_coin_AptosCoin'| b2@@54)))))
 :qid |boogiebpl.6704:15|
 :skolemid |317|
)))
(assert (forall ((b1@@55 T@Vec_6673) (b2@@55 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@55) (=> (|$IsValid'vec'u8''| b2@@55) (=> (|$IsEqual'vec'u8''| b1@@55 b2@@55) (= (|$1_from_bcs_deserializable'$1_Bbay_Owner'| b1@@55) (|$1_from_bcs_deserializable'$1_Bbay_Owner'| b2@@55)))))
 :qid |boogiebpl.6707:15|
 :skolemid |318|
)))
(assert (forall ((b1@@56 T@Vec_6673) (b2@@56 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@56) (=> (|$IsValid'vec'u8''| b2@@56) (=> (|$IsEqual'vec'u8''| b1@@56 b2@@56) (= (|$1_from_bcs_deserializable'$1_Bbay_Products'| b1@@56) (|$1_from_bcs_deserializable'$1_Bbay_Products'| b2@@56)))))
 :qid |boogiebpl.6710:15|
 :skolemid |319|
)))
(assert (forall ((b1@@57 T@Vec_6673) (b2@@57 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@57) (=> (|$IsValid'vec'u8''| b2@@57) (=> (|$IsEqual'vec'u8''| b1@@57 b2@@57) (= (|$1_from_bcs_deserializable'$1_Bbay_ResourceAccountSignerCap'| b1@@57) (|$1_from_bcs_deserializable'$1_Bbay_ResourceAccountSignerCap'| b2@@57)))))
 :qid |boogiebpl.6713:15|
 :skolemid |320|
)))
(assert (forall ((b1@@58 T@Vec_6673) (b2@@58 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@58) (=> (|$IsValid'vec'u8''| b2@@58) (=> (|$IsEqual'vec'u8''| b1@@58 b2@@58) (= (|$1_from_bcs_deserializable'$1_Bbay_User'| b1@@58) (|$1_from_bcs_deserializable'$1_Bbay_User'| b2@@58)))))
 :qid |boogiebpl.6716:15|
 :skolemid |321|
)))
(assert (forall ((b1@@59 T@Vec_6673) (b2@@59 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@59) (=> (|$IsValid'vec'u8''| b2@@59) (=> (|$IsEqual'vec'u8''| b1@@59 b2@@59) (= (|$1_from_bcs_deserializable'#0'| b1@@59) (|$1_from_bcs_deserializable'#0'| b2@@59)))))
 :qid |boogiebpl.6719:15|
 :skolemid |322|
)))
(assert (forall ((b1@@60 T@Vec_6673) (b2@@60 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@60) (=> (|$IsValid'vec'u8''| b2@@60) (=> (|$IsEqual'vec'u8''| b1@@60 b2@@60) (= (|$1_from_bcs_deserialize'bool'| b1@@60) (|$1_from_bcs_deserialize'bool'| b2@@60)))))
 :qid |boogiebpl.6722:15|
 :skolemid |323|
)))
(assert (forall ((b1@@61 T@Vec_6673) (b2@@61 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@61) (=> (|$IsValid'vec'u8''| b2@@61) (=> (|$IsEqual'vec'u8''| b1@@61 b2@@61) (= (|$1_from_bcs_deserialize'u8'| b1@@61) (|$1_from_bcs_deserialize'u8'| b2@@61)))))
 :qid |boogiebpl.6725:15|
 :skolemid |324|
)))
(assert (forall ((b1@@62 T@Vec_6673) (b2@@62 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@62) (=> (|$IsValid'vec'u8''| b2@@62) (=> (|$IsEqual'vec'u8''| b1@@62 b2@@62) (= (|$1_from_bcs_deserialize'u64'| b1@@62) (|$1_from_bcs_deserialize'u64'| b2@@62)))))
 :qid |boogiebpl.6728:15|
 :skolemid |325|
)))
(assert (forall ((b1@@63 T@Vec_6673) (b2@@63 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@63) (=> (|$IsValid'vec'u8''| b2@@63) (=> (|$IsEqual'vec'u8''| b1@@63 b2@@63) (= (|$1_from_bcs_deserialize'u128'| b1@@63) (|$1_from_bcs_deserialize'u128'| b2@@63)))))
 :qid |boogiebpl.6731:15|
 :skolemid |326|
)))
(assert (forall ((b1@@64 T@Vec_6673) (b2@@64 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@64) (=> (|$IsValid'vec'u8''| b2@@64) (=> (|$IsEqual'vec'u8''| b1@@64 b2@@64) (= (|$1_from_bcs_deserialize'u256'| b1@@64) (|$1_from_bcs_deserialize'u256'| b2@@64)))))
 :qid |boogiebpl.6734:15|
 :skolemid |327|
)))
(assert (forall ((b1@@65 T@Vec_6673) (b2@@65 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@65) (=> (|$IsValid'vec'u8''| b2@@65) (=> (|$IsEqual'vec'u8''| b1@@65 b2@@65) (= (|$1_from_bcs_deserialize'address'| b1@@65) (|$1_from_bcs_deserialize'address'| b2@@65)))))
 :qid |boogiebpl.6737:15|
 :skolemid |328|
)))
(assert (forall ((b1@@66 T@Vec_6673) (b2@@66 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@66) (=> (|$IsValid'vec'u8''| b2@@66) (=> (|$IsEqual'vec'u8''| b1@@66 b2@@66) (= (|$1_from_bcs_deserialize'signer'| b1@@66) (|$1_from_bcs_deserialize'signer'| b2@@66)))))
 :qid |boogiebpl.6740:15|
 :skolemid |329|
)))
(assert (forall ((b1@@67 T@Vec_6673) (b2@@67 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@67) (=> (|$IsValid'vec'u8''| b2@@67) (=> (|$IsEqual'vec'u8''| b1@@67 b2@@67) (|$IsEqual'vec'u8''| (|$1_from_bcs_deserialize'vec'u8''| b1@@67) (|$1_from_bcs_deserialize'vec'u8''| b2@@67)))))
 :qid |boogiebpl.6743:15|
 :skolemid |330|
)))
(assert (forall ((b1@@68 T@Vec_6673) (b2@@68 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@68) (=> (|$IsValid'vec'u8''| b2@@68) (=> (|$IsEqual'vec'u8''| b1@@68 b2@@68) (|$IsEqual'vec'u64''| (|$1_from_bcs_deserialize'vec'u64''| b1@@68) (|$1_from_bcs_deserialize'vec'u64''| b2@@68)))))
 :qid |boogiebpl.6746:15|
 :skolemid |331|
)))
(assert (forall ((b1@@69 T@Vec_6673) (b2@@69 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@69) (=> (|$IsValid'vec'u8''| b2@@69) (=> (|$IsEqual'vec'u8''| b1@@69 b2@@69) (|$IsEqual'vec'address''| (|$1_from_bcs_deserialize'vec'address''| b1@@69) (|$1_from_bcs_deserialize'vec'address''| b2@@69)))))
 :qid |boogiebpl.6749:15|
 :skolemid |332|
)))
(assert (forall ((b1@@70 T@Vec_6673) (b2@@70 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@70) (=> (|$IsValid'vec'u8''| b2@@70) (=> (|$IsEqual'vec'u8''| b1@@70 b2@@70) (|$IsEqual'vec'$1_aggregator_Aggregator''| (|$1_from_bcs_deserialize'vec'$1_aggregator_Aggregator''| b1@@70) (|$1_from_bcs_deserialize'vec'$1_aggregator_Aggregator''| b2@@70)))))
 :qid |boogiebpl.6752:15|
 :skolemid |333|
)))
(assert (forall ((b1@@71 T@Vec_6673) (b2@@71 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@71) (=> (|$IsValid'vec'u8''| b2@@71) (=> (|$IsEqual'vec'u8''| b1@@71 b2@@71) (|$IsEqual'vec'$1_optional_aggregator_Integer''| (|$1_from_bcs_deserialize'vec'$1_optional_aggregator_Integer''| b1@@71) (|$1_from_bcs_deserialize'vec'$1_optional_aggregator_Integer''| b2@@71)))))
 :qid |boogiebpl.6755:15|
 :skolemid |334|
)))
(assert (forall ((b1@@72 T@Vec_6673) (b2@@72 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@72) (=> (|$IsValid'vec'u8''| b2@@72) (=> (|$IsEqual'vec'u8''| b1@@72 b2@@72) (|$IsEqual'vec'$1_optional_aggregator_OptionalAggregator''| (|$1_from_bcs_deserialize'vec'$1_optional_aggregator_OptionalAggregator''| b1@@72) (|$1_from_bcs_deserialize'vec'$1_optional_aggregator_OptionalAggregator''| b2@@72)))))
 :qid |boogiebpl.6758:15|
 :skolemid |335|
)))
(assert (forall ((b1@@73 T@Vec_6673) (b2@@73 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@73) (=> (|$IsValid'vec'u8''| b2@@73) (=> (|$IsEqual'vec'u8''| b1@@73 b2@@73) (|$IsEqual'vec'#0''| (|$1_from_bcs_deserialize'vec'#0''| b1@@73) (|$1_from_bcs_deserialize'vec'#0''| b2@@73)))))
 :qid |boogiebpl.6761:15|
 :skolemid |336|
)))
(assert (forall ((b1@@74 T@Vec_6673) (b2@@74 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@74) (=> (|$IsValid'vec'u8''| b2@@74) (=> (|$IsEqual'vec'u8''| b1@@74 b2@@74) (|$IsEqual'$1_table_Table'u64_bool''| (|$1_from_bcs_deserialize'$1_table_Table'u64_bool''| b1@@74) (|$1_from_bcs_deserialize'$1_table_Table'u64_bool''| b2@@74)))))
 :qid |boogiebpl.6764:15|
 :skolemid |337|
)))
(assert (forall ((b1@@75 T@Vec_6673) (b2@@75 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@75) (=> (|$IsValid'vec'u8''| b2@@75) (=> (|$IsEqual'vec'u8''| b1@@75 b2@@75) (|$IsEqual'$1_table_Table'u64_u64''| (|$1_from_bcs_deserialize'$1_table_Table'u64_u64''| b1@@75) (|$1_from_bcs_deserialize'$1_table_Table'u64_u64''| b2@@75)))))
 :qid |boogiebpl.6767:15|
 :skolemid |338|
)))
(assert (forall ((b1@@76 T@Vec_6673) (b2@@76 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@76) (=> (|$IsValid'vec'u8''| b2@@76) (=> (|$IsEqual'vec'u8''| b1@@76 b2@@76) (|$IsEqual'$1_table_Table'u64_vec'u64'''| (|$1_from_bcs_deserialize'$1_table_Table'u64_vec'u64'''| b1@@76) (|$1_from_bcs_deserialize'$1_table_Table'u64_vec'u64'''| b2@@76)))))
 :qid |boogiebpl.6770:15|
 :skolemid |339|
)))
(assert (forall ((b1@@77 T@Vec_6673) (b2@@77 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@77) (=> (|$IsValid'vec'u8''| b2@@77) (=> (|$IsEqual'vec'u8''| b1@@77 b2@@77) (|$IsEqual'$1_table_Table'address_address''| (|$1_from_bcs_deserialize'$1_table_Table'address_address''| b1@@77) (|$1_from_bcs_deserialize'$1_table_Table'address_address''| b2@@77)))))
 :qid |boogiebpl.6773:15|
 :skolemid |340|
)))
(assert (forall ((b1@@78 T@Vec_6673) (b2@@78 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@78) (=> (|$IsValid'vec'u8''| b2@@78) (=> (|$IsEqual'vec'u8''| b1@@78 b2@@78) (|$IsEqual'vec'address''| (|$vec#$1_option_Option'address'| (|$1_from_bcs_deserialize'$1_option_Option'address''| b1@@78)) (|$vec#$1_option_Option'address'| (|$1_from_bcs_deserialize'$1_option_Option'address''| b2@@78))))))
 :qid |boogiebpl.6776:15|
 :skolemid |341|
)))
(assert (forall ((b1@@79 T@Vec_6673) (b2@@79 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@79) (=> (|$IsValid'vec'u8''| b2@@79) (=> (|$IsEqual'vec'u8''| b1@@79 b2@@79) (|$IsEqual'vec'$1_aggregator_Aggregator''| (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$1_from_bcs_deserialize'$1_option_Option'$1_aggregator_Aggregator''| b1@@79)) (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$1_from_bcs_deserialize'$1_option_Option'$1_aggregator_Aggregator''| b2@@79))))))
 :qid |boogiebpl.6779:15|
 :skolemid |342|
)))
(assert (forall ((b1@@80 T@Vec_6673) (b2@@80 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@80) (=> (|$IsValid'vec'u8''| b2@@80) (=> (|$IsEqual'vec'u8''| b1@@80 b2@@80) (|$IsEqual'vec'$1_optional_aggregator_Integer''| (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_Integer''| b1@@80)) (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_Integer''| b2@@80))))))
 :qid |boogiebpl.6782:15|
 :skolemid |343|
)))
(assert (forall ((b1@@81 T@Vec_6673) (b2@@81 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@81) (=> (|$IsValid'vec'u8''| b2@@81) (=> (|$IsEqual'vec'u8''| b1@@81 b2@@81) (|$IsEqual'vec'$1_optional_aggregator_OptionalAggregator''| (|$vec#$1_option_Option'$1_optional_aggregator_OptionalAggregator'| (|$1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| b1@@81)) (|$vec#$1_option_Option'$1_optional_aggregator_OptionalAggregator'| (|$1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| b2@@81))))))
 :qid |boogiebpl.6785:15|
 :skolemid |344|
)))
(assert (forall ((b1@@82 T@Vec_6673) (b2@@82 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@82) (=> (|$IsValid'vec'u8''| b2@@82) (=> (|$IsEqual'vec'u8''| b1@@82 b2@@82) (|$IsEqual'vec'u8''| (|$bytes#$1_string_String| (|$1_from_bcs_deserialize'$1_string_String'| b1@@82)) (|$bytes#$1_string_String| (|$1_from_bcs_deserialize'$1_string_String'| b2@@82))))))
 :qid |boogiebpl.6788:15|
 :skolemid |345|
)))
(assert (forall ((b1@@83 T@Vec_6673) (b2@@83 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@83) (=> (|$IsValid'vec'u8''| b2@@83) (=> (|$IsEqual'vec'u8''| b1@@83 b2@@83) (and (and (= (|$account_address#$1_type_info_TypeInfo| (|$1_from_bcs_deserialize'$1_type_info_TypeInfo'| b1@@83)) (|$account_address#$1_type_info_TypeInfo| (|$1_from_bcs_deserialize'$1_type_info_TypeInfo'| b2@@83))) (|$IsEqual'vec'u8''| (|$module_name#$1_type_info_TypeInfo| (|$1_from_bcs_deserialize'$1_type_info_TypeInfo'| b1@@83)) (|$module_name#$1_type_info_TypeInfo| (|$1_from_bcs_deserialize'$1_type_info_TypeInfo'| b2@@83)))) (|$IsEqual'vec'u8''| (|$struct_name#$1_type_info_TypeInfo| (|$1_from_bcs_deserialize'$1_type_info_TypeInfo'| b1@@83)) (|$struct_name#$1_type_info_TypeInfo| (|$1_from_bcs_deserialize'$1_type_info_TypeInfo'| b2@@83)))))))
 :qid |boogiebpl.6791:15|
 :skolemid |346|
)))
(assert (forall ((b1@@84 T@Vec_6673) (b2@@84 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@84) (=> (|$IsValid'vec'u8''| b2@@84) (=> (|$IsEqual'vec'u8''| b1@@84 b2@@84) (= (|$1_from_bcs_deserialize'$1_aggregator_Aggregator'| b1@@84) (|$1_from_bcs_deserialize'$1_aggregator_Aggregator'| b2@@84)))))
 :qid |boogiebpl.6794:15|
 :skolemid |347|
)))
(assert (forall ((b1@@85 T@Vec_6673) (b2@@85 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@85) (=> (|$IsValid'vec'u8''| b2@@85) (=> (|$IsEqual'vec'u8''| b1@@85 b2@@85) (= (|$1_from_bcs_deserialize'$1_optional_aggregator_Integer'| b1@@85) (|$1_from_bcs_deserialize'$1_optional_aggregator_Integer'| b2@@85)))))
 :qid |boogiebpl.6797:15|
 :skolemid |348|
)))
(assert (forall ((b1@@86 T@Vec_6673) (b2@@86 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@86) (=> (|$IsValid'vec'u8''| b2@@86) (=> (|$IsEqual'vec'u8''| b1@@86 b2@@86) (and (|$IsEqual'vec'$1_aggregator_Aggregator''| (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| (|$1_from_bcs_deserialize'$1_optional_aggregator_OptionalAggregator'| b1@@86))) (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| (|$1_from_bcs_deserialize'$1_optional_aggregator_OptionalAggregator'| b2@@86)))) (|$IsEqual'vec'$1_optional_aggregator_Integer''| (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| (|$1_from_bcs_deserialize'$1_optional_aggregator_OptionalAggregator'| b1@@86))) (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| (|$1_from_bcs_deserialize'$1_optional_aggregator_OptionalAggregator'| b2@@86))))))))
 :qid |boogiebpl.6800:15|
 :skolemid |349|
)))
(assert (forall ((b1@@87 T@Vec_6673) (b2@@87 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@87) (=> (|$IsValid'vec'u8''| b2@@87) (=> (|$IsEqual'vec'u8''| b1@@87 b2@@87) (= (|$1_from_bcs_deserialize'$1_guid_GUID'| b1@@87) (|$1_from_bcs_deserialize'$1_guid_GUID'| b2@@87)))))
 :qid |boogiebpl.6803:15|
 :skolemid |350|
)))
(assert (forall ((b1@@88 T@Vec_6673) (b2@@88 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@88) (=> (|$IsValid'vec'u8''| b2@@88) (=> (|$IsEqual'vec'u8''| b1@@88 b2@@88) (= (|$1_from_bcs_deserialize'$1_guid_ID'| b1@@88) (|$1_from_bcs_deserialize'$1_guid_ID'| b2@@88)))))
 :qid |boogiebpl.6806:15|
 :skolemid |351|
)))
(assert (forall ((b1@@89 T@Vec_6673) (b2@@89 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@89) (=> (|$IsValid'vec'u8''| b2@@89) (=> (|$IsEqual'vec'u8''| b1@@89 b2@@89) (= (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_account_CoinRegisterEvent''| b1@@89) (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_account_CoinRegisterEvent''| b2@@89)))))
 :qid |boogiebpl.6809:15|
 :skolemid |352|
)))
(assert (forall ((b1@@90 T@Vec_6673) (b2@@90 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@90) (=> (|$IsValid'vec'u8''| b2@@90) (=> (|$IsEqual'vec'u8''| b1@@90 b2@@90) (= (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_account_KeyRotationEvent''| b1@@90) (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_account_KeyRotationEvent''| b2@@90)))))
 :qid |boogiebpl.6812:15|
 :skolemid |353|
)))
(assert (forall ((b1@@91 T@Vec_6673) (b2@@91 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@91) (=> (|$IsValid'vec'u8''| b2@@91) (=> (|$IsEqual'vec'u8''| b1@@91 b2@@91) (= (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_DepositEvent''| b1@@91) (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_DepositEvent''| b2@@91)))))
 :qid |boogiebpl.6815:15|
 :skolemid |354|
)))
(assert (forall ((b1@@92 T@Vec_6673) (b2@@92 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@92) (=> (|$IsValid'vec'u8''| b2@@92) (=> (|$IsEqual'vec'u8''| b1@@92 b2@@92) (= (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_WithdrawEvent''| b1@@92) (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_WithdrawEvent''| b2@@92)))))
 :qid |boogiebpl.6818:15|
 :skolemid |355|
)))
(assert (forall ((b1@@93 T@Vec_6673) (b2@@93 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@93) (=> (|$IsValid'vec'u8''| b2@@93) (=> (|$IsEqual'vec'u8''| b1@@93 b2@@93) (and (and (and (and (and (and (|$IsEqual'vec'u8''| (|$authentication_key#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b1@@93)) (|$authentication_key#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b2@@93))) (= (|$sequence_number#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b1@@93)) (|$sequence_number#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b2@@93)))) (= (|$guid_creation_num#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b1@@93)) (|$guid_creation_num#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b2@@93)))) (= (|$coin_register_events#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b1@@93)) (|$coin_register_events#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b2@@93)))) (= (|$key_rotation_events#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b1@@93)) (|$key_rotation_events#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b2@@93)))) (|$IsEqual'vec'address''| (|$vec#$1_option_Option'address'| (|$for#$1_account_CapabilityOffer'$1_account_RotationCapability'| (|$rotation_capability_offer#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b1@@93)))) (|$vec#$1_option_Option'address'| (|$for#$1_account_CapabilityOffer'$1_account_RotationCapability'| (|$rotation_capability_offer#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b2@@93)))))) (|$IsEqual'vec'address''| (|$vec#$1_option_Option'address'| (|$for#$1_account_CapabilityOffer'$1_account_SignerCapability'| (|$signer_capability_offer#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b1@@93)))) (|$vec#$1_option_Option'address'| (|$for#$1_account_CapabilityOffer'$1_account_SignerCapability'| (|$signer_capability_offer#$1_account_Account| (|$1_from_bcs_deserialize'$1_account_Account'| b2@@93)))))))))
 :qid |boogiebpl.6821:15|
 :skolemid |356|
)))
(assert (forall ((b1@@94 T@Vec_6673) (b2@@94 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@94) (=> (|$IsValid'vec'u8''| b2@@94) (=> (|$IsEqual'vec'u8''| b1@@94 b2@@94) (|$IsEqual'vec'address''| (|$vec#$1_option_Option'address'| (|$for#$1_account_CapabilityOffer'$1_account_RotationCapability'| (|$1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_RotationCapability''| b1@@94))) (|$vec#$1_option_Option'address'| (|$for#$1_account_CapabilityOffer'$1_account_RotationCapability'| (|$1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_RotationCapability''| b2@@94)))))))
 :qid |boogiebpl.6824:15|
 :skolemid |357|
)))
(assert (forall ((b1@@95 T@Vec_6673) (b2@@95 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@95) (=> (|$IsValid'vec'u8''| b2@@95) (=> (|$IsEqual'vec'u8''| b1@@95 b2@@95) (|$IsEqual'vec'address''| (|$vec#$1_option_Option'address'| (|$for#$1_account_CapabilityOffer'$1_account_SignerCapability'| (|$1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_SignerCapability''| b1@@95))) (|$vec#$1_option_Option'address'| (|$for#$1_account_CapabilityOffer'$1_account_SignerCapability'| (|$1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_SignerCapability''| b2@@95)))))))
 :qid |boogiebpl.6827:15|
 :skolemid |358|
)))
(assert (forall ((b1@@96 T@Vec_6673) (b2@@96 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@96) (=> (|$IsValid'vec'u8''| b2@@96) (=> (|$IsEqual'vec'u8''| b1@@96 b2@@96) (and (and (= (|$account_address#$1_type_info_TypeInfo| (|$type_info#$1_account_CoinRegisterEvent| (|$1_from_bcs_deserialize'$1_account_CoinRegisterEvent'| b1@@96))) (|$account_address#$1_type_info_TypeInfo| (|$type_info#$1_account_CoinRegisterEvent| (|$1_from_bcs_deserialize'$1_account_CoinRegisterEvent'| b2@@96)))) (|$IsEqual'vec'u8''| (|$module_name#$1_type_info_TypeInfo| (|$type_info#$1_account_CoinRegisterEvent| (|$1_from_bcs_deserialize'$1_account_CoinRegisterEvent'| b1@@96))) (|$module_name#$1_type_info_TypeInfo| (|$type_info#$1_account_CoinRegisterEvent| (|$1_from_bcs_deserialize'$1_account_CoinRegisterEvent'| b2@@96))))) (|$IsEqual'vec'u8''| (|$struct_name#$1_type_info_TypeInfo| (|$type_info#$1_account_CoinRegisterEvent| (|$1_from_bcs_deserialize'$1_account_CoinRegisterEvent'| b1@@96))) (|$struct_name#$1_type_info_TypeInfo| (|$type_info#$1_account_CoinRegisterEvent| (|$1_from_bcs_deserialize'$1_account_CoinRegisterEvent'| b2@@96))))))))
 :qid |boogiebpl.6830:15|
 :skolemid |359|
)))
(assert (forall ((b1@@97 T@Vec_6673) (b2@@97 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@97) (=> (|$IsValid'vec'u8''| b2@@97) (=> (|$IsEqual'vec'u8''| b1@@97 b2@@97) (= (|$1_from_bcs_deserialize'$1_account_SignerCapability'| b1@@97) (|$1_from_bcs_deserialize'$1_account_SignerCapability'| b2@@97)))))
 :qid |boogiebpl.6833:15|
 :skolemid |360|
)))
(assert (forall ((b1@@98 T@Vec_6673) (b2@@98 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@98) (=> (|$IsValid'vec'u8''| b2@@98) (=> (|$IsEqual'vec'u8''| b1@@98 b2@@98) (= (|$1_from_bcs_deserialize'$1_coin_Coin'$1_aptos_coin_AptosCoin''| b1@@98) (|$1_from_bcs_deserialize'$1_coin_Coin'$1_aptos_coin_AptosCoin''| b2@@98)))))
 :qid |boogiebpl.6836:15|
 :skolemid |361|
)))
(assert (forall ((b1@@99 T@Vec_6673) (b2@@99 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@99) (=> (|$IsValid'vec'u8''| b2@@99) (=> (|$IsEqual'vec'u8''| b1@@99 b2@@99) (= (|$1_from_bcs_deserialize'$1_coin_Coin'#0''| b1@@99) (|$1_from_bcs_deserialize'$1_coin_Coin'#0''| b2@@99)))))
 :qid |boogiebpl.6839:15|
 :skolemid |362|
)))
(assert (forall ((b1@@100 T@Vec_6673) (b2@@100 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@100) (=> (|$IsValid'vec'u8''| b2@@100) (=> (|$IsEqual'vec'u8''| b1@@100 b2@@100) (and (and (and (|$IsEqual'vec'u8''| (|$bytes#$1_string_String| (|$name#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| b1@@100))) (|$bytes#$1_string_String| (|$name#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| b2@@100)))) (|$IsEqual'vec'u8''| (|$bytes#$1_string_String| (|$symbol#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| b1@@100))) (|$bytes#$1_string_String| (|$symbol#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| b2@@100))))) (= (|$decimals#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| b1@@100)) (|$decimals#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| b2@@100)))) (|$IsEqual'vec'$1_optional_aggregator_OptionalAggregator''| (|$vec#$1_option_Option'$1_optional_aggregator_OptionalAggregator'| (|$supply#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| b1@@100))) (|$vec#$1_option_Option'$1_optional_aggregator_OptionalAggregator'| (|$supply#$1_coin_CoinInfo'$1_aptos_coin_AptosCoin'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| b2@@100))))))))
 :qid |boogiebpl.6842:15|
 :skolemid |363|
)))
(assert (forall ((b1@@101 T@Vec_6673) (b2@@101 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@101) (=> (|$IsValid'vec'u8''| b2@@101) (=> (|$IsEqual'vec'u8''| b1@@101 b2@@101) (and (and (and (|$IsEqual'vec'u8''| (|$bytes#$1_string_String| (|$name#$1_coin_CoinInfo'#0'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'#0''| b1@@101))) (|$bytes#$1_string_String| (|$name#$1_coin_CoinInfo'#0'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'#0''| b2@@101)))) (|$IsEqual'vec'u8''| (|$bytes#$1_string_String| (|$symbol#$1_coin_CoinInfo'#0'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'#0''| b1@@101))) (|$bytes#$1_string_String| (|$symbol#$1_coin_CoinInfo'#0'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'#0''| b2@@101))))) (= (|$decimals#$1_coin_CoinInfo'#0'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'#0''| b1@@101)) (|$decimals#$1_coin_CoinInfo'#0'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'#0''| b2@@101)))) (|$IsEqual'vec'$1_optional_aggregator_OptionalAggregator''| (|$vec#$1_option_Option'$1_optional_aggregator_OptionalAggregator'| (|$supply#$1_coin_CoinInfo'#0'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'#0''| b1@@101))) (|$vec#$1_option_Option'$1_optional_aggregator_OptionalAggregator'| (|$supply#$1_coin_CoinInfo'#0'| (|$1_from_bcs_deserialize'$1_coin_CoinInfo'#0''| b2@@101))))))))
 :qid |boogiebpl.6845:15|
 :skolemid |364|
)))
(assert (forall ((b1@@102 T@Vec_6673) (b2@@102 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@102) (=> (|$IsValid'vec'u8''| b2@@102) (=> (|$IsEqual'vec'u8''| b1@@102 b2@@102) (= (|$1_from_bcs_deserialize'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''| b1@@102) (|$1_from_bcs_deserialize'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''| b2@@102)))))
 :qid |boogiebpl.6848:15|
 :skolemid |365|
)))
(assert (forall ((b1@@103 T@Vec_6673) (b2@@103 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@103) (=> (|$IsValid'vec'u8''| b2@@103) (=> (|$IsEqual'vec'u8''| b1@@103 b2@@103) (= (|$1_from_bcs_deserialize'$1_coin_CoinStore'#0''| b1@@103) (|$1_from_bcs_deserialize'$1_coin_CoinStore'#0''| b2@@103)))))
 :qid |boogiebpl.6851:15|
 :skolemid |366|
)))
(assert (forall ((b1@@104 T@Vec_6673) (b2@@104 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@104) (=> (|$IsValid'vec'u8''| b2@@104) (=> (|$IsEqual'vec'u8''| b1@@104 b2@@104) (= (|$1_from_bcs_deserialize'$1_coin_DepositEvent'| b1@@104) (|$1_from_bcs_deserialize'$1_coin_DepositEvent'| b2@@104)))))
 :qid |boogiebpl.6854:15|
 :skolemid |367|
)))
(assert (forall ((b1@@105 T@Vec_6673) (b2@@105 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@105) (=> (|$IsValid'vec'u8''| b2@@105) (=> (|$IsEqual'vec'u8''| b1@@105 b2@@105) (= (|$1_from_bcs_deserialize'$1_coin_WithdrawEvent'| b1@@105) (|$1_from_bcs_deserialize'$1_coin_WithdrawEvent'| b2@@105)))))
 :qid |boogiebpl.6857:15|
 :skolemid |368|
)))
(assert (forall ((b1@@106 T@Vec_6673) (b2@@106 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@106) (=> (|$IsValid'vec'u8''| b2@@106) (=> (|$IsEqual'vec'u8''| b1@@106 b2@@106) (= (|$1_from_bcs_deserialize'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''| b1@@106) (|$1_from_bcs_deserialize'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''| b2@@106)))))
 :qid |boogiebpl.6860:15|
 :skolemid |369|
)))
(assert (forall ((b1@@107 T@Vec_6673) (b2@@107 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@107) (=> (|$IsValid'vec'u8''| b2@@107) (=> (|$IsEqual'vec'u8''| b1@@107 b2@@107) (= (|$1_from_bcs_deserialize'$1_coin_Ghost$supply'#0''| b1@@107) (|$1_from_bcs_deserialize'$1_coin_Ghost$supply'#0''| b2@@107)))))
 :qid |boogiebpl.6863:15|
 :skolemid |370|
)))
(assert (forall ((b1@@108 T@Vec_6673) (b2@@108 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@108) (=> (|$IsValid'vec'u8''| b2@@108) (=> (|$IsEqual'vec'u8''| b1@@108 b2@@108) (= (|$1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''| b1@@108) (|$1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''| b2@@108)))))
 :qid |boogiebpl.6866:15|
 :skolemid |371|
)))
(assert (forall ((b1@@109 T@Vec_6673) (b2@@109 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@109) (=> (|$IsValid'vec'u8''| b2@@109) (=> (|$IsEqual'vec'u8''| b1@@109 b2@@109) (= (|$1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'#0''| b1@@109) (|$1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'#0''| b2@@109)))))
 :qid |boogiebpl.6869:15|
 :skolemid |372|
)))
(assert (forall ((b1@@110 T@Vec_6673) (b2@@110 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@110) (=> (|$IsValid'vec'u8''| b2@@110) (=> (|$IsEqual'vec'u8''| b1@@110 b2@@110) (= (|$1_from_bcs_deserialize'$1_aptos_coin_AptosCoin'| b1@@110) (|$1_from_bcs_deserialize'$1_aptos_coin_AptosCoin'| b2@@110)))))
 :qid |boogiebpl.6872:15|
 :skolemid |373|
)))
(assert (forall ((b1@@111 T@Vec_6673) (b2@@111 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@111) (=> (|$IsValid'vec'u8''| b2@@111) (=> (|$IsEqual'vec'u8''| b1@@111 b2@@111) (= (|$1_from_bcs_deserialize'$1_Bbay_Owner'| b1@@111) (|$1_from_bcs_deserialize'$1_Bbay_Owner'| b2@@111)))))
 :qid |boogiebpl.6875:15|
 :skolemid |374|
)))
(assert (forall ((b1@@112 T@Vec_6673) (b2@@112 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@112) (=> (|$IsValid'vec'u8''| b2@@112) (=> (|$IsEqual'vec'u8''| b1@@112 b2@@112) (and (and (and (and (and (|$IsEqual'$1_table_Table'u64_u64''| (|$sr_number#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b1@@112)) (|$sr_number#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b2@@112))) (|$IsEqual'vec'u64''| (|$item_id#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b1@@112)) (|$item_id#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b2@@112)))) (|$IsEqual'$1_table_Table'u64_vec'u64'''| (|$item_name#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b1@@112)) (|$item_name#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b2@@112)))) (|$IsEqual'$1_table_Table'u64_bool''| (|$item_sold#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b1@@112)) (|$item_sold#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b2@@112)))) (|$IsEqual'$1_table_Table'u64_u64''| (|$item_price#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b1@@112)) (|$item_price#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b2@@112)))) (|$IsEqual'$1_table_Table'u64_bool''| (|$item_on_selling#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b1@@112)) (|$item_on_selling#$1_Bbay_Products| (|$1_from_bcs_deserialize'$1_Bbay_Products'| b2@@112)))))))
 :qid |boogiebpl.6878:15|
 :skolemid |375|
)))
(assert (forall ((b1@@113 T@Vec_6673) (b2@@113 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@113) (=> (|$IsValid'vec'u8''| b2@@113) (=> (|$IsEqual'vec'u8''| b1@@113 b2@@113) (= (|$1_from_bcs_deserialize'$1_Bbay_ResourceAccountSignerCap'| b1@@113) (|$1_from_bcs_deserialize'$1_Bbay_ResourceAccountSignerCap'| b2@@113)))))
 :qid |boogiebpl.6881:15|
 :skolemid |376|
)))
(assert (forall ((b1@@114 T@Vec_6673) (b2@@114 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@114) (=> (|$IsValid'vec'u8''| b2@@114) (=> (|$IsEqual'vec'u8''| b1@@114 b2@@114) (and (and (and (= (|$user_id#$1_Bbay_User| (|$1_from_bcs_deserialize'$1_Bbay_User'| b1@@114)) (|$user_id#$1_Bbay_User| (|$1_from_bcs_deserialize'$1_Bbay_User'| b2@@114))) (|$IsEqual'vec'u64''| (|$orders#$1_Bbay_User| (|$1_from_bcs_deserialize'$1_Bbay_User'| b1@@114)) (|$orders#$1_Bbay_User| (|$1_from_bcs_deserialize'$1_Bbay_User'| b2@@114)))) (|$IsEqual'vec'u64''| (|$order_status#$1_Bbay_User| (|$1_from_bcs_deserialize'$1_Bbay_User'| b1@@114)) (|$order_status#$1_Bbay_User| (|$1_from_bcs_deserialize'$1_Bbay_User'| b2@@114)))) (|$IsEqual'vec'u64''| (|$payment_status#$1_Bbay_User| (|$1_from_bcs_deserialize'$1_Bbay_User'| b1@@114)) (|$payment_status#$1_Bbay_User| (|$1_from_bcs_deserialize'$1_Bbay_User'| b2@@114)))))))
 :qid |boogiebpl.6884:15|
 :skolemid |377|
)))
(assert (forall ((b1@@115 T@Vec_6673) (b2@@115 T@Vec_6673) ) (!  (=> (|$IsValid'vec'u8''| b1@@115) (=> (|$IsValid'vec'u8''| b2@@115) (=> (|$IsEqual'vec'u8''| b1@@115 b2@@115) (= (|$1_from_bcs_deserialize'#0'| b1@@115) (|$1_from_bcs_deserialize'#0'| b2@@115)))))
 :qid |boogiebpl.6887:15|
 :skolemid |378|
)))
(assert (forall ((src1@@1 Int) (p@@1 Int) ) (! (= ($shl src1@@1 p@@1) (* src1@@1 ($pow 2 p@@1)))
 :qid |boogiebpl.1491:15|
 :skolemid |33|
 :pattern ( ($shl src1@@1 p@@1))
)))
(assert (forall ((t@@2 T@$TypeParamInfo) ) (!  (=> (|$IsEqual'vec'u8''| ($TypeName t@@2) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 49) 2 54) 3)) (is-$TypeParamU16 t@@2))
 :qid |boogiebpl.6526:15|
 :skolemid |250|
 :pattern ( ($TypeName t@@2))
)))
(assert (forall ((t@@3 T@$TypeParamInfo) ) (!  (=> (|$IsEqual'vec'u8''| ($TypeName t@@3) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 51) 2 50) 3)) (is-$TypeParamU32 t@@3))
 :qid |boogiebpl.6528:15|
 :skolemid |252|
 :pattern ( ($TypeName t@@3))
)))
(assert (forall ((t@@4 T@$TypeParamInfo) ) (!  (=> (|$IsEqual'vec'u8''| ($TypeName t@@4) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 54) 2 52) 3)) (is-$TypeParamU64 t@@4))
 :qid |boogiebpl.6530:15|
 :skolemid |254|
 :pattern ( ($TypeName t@@4))
)))
(assert (forall ((bytes T@Vec_6673) ) (! true
 :qid |boogiebpl.7780:15|
 :skolemid |398|
)))
(assert (forall ((bytes@@0 T@Vec_6673) ) (! (let (($$res@@0 (|$1_from_bcs_deserialize'u8'| bytes@@0)))
(|$IsValid'u8'| $$res@@0))
 :qid |boogiebpl.7786:15|
 :skolemid |399|
)))
(assert (forall ((bytes@@1 T@Vec_6673) ) (! (let (($$res@@1 (|$1_from_bcs_deserialize'u64'| bytes@@1)))
(|$IsValid'u64'| $$res@@1))
 :qid |boogiebpl.7792:15|
 :skolemid |400|
)))
(assert (forall ((bytes@@2 T@Vec_6673) ) (! (let (($$res@@2 (|$1_from_bcs_deserialize'u128'| bytes@@2)))
(|$IsValid'u128'| $$res@@2))
 :qid |boogiebpl.7798:15|
 :skolemid |401|
)))
(assert (forall ((bytes@@3 T@Vec_6673) ) (! (let (($$res@@3 (|$1_from_bcs_deserialize'u256'| bytes@@3)))
(|$IsValid'u256'| $$res@@3))
 :qid |boogiebpl.7804:15|
 :skolemid |402|
)))
(assert (forall ((bytes@@4 T@Vec_6673) ) (! (let (($$res@@4 (|$1_from_bcs_deserialize'address'| bytes@@4)))
(|$IsValid'address'| $$res@@4))
 :qid |boogiebpl.7810:15|
 :skolemid |403|
)))
(assert (forall ((bytes@@5 T@Vec_6673) ) (! (let (($$res@@5 (|$1_from_bcs_deserialize'signer'| bytes@@5)))
(|$IsValid'address'| (|$addr#$signer| $$res@@5)))
 :qid |boogiebpl.7816:15|
 :skolemid |404|
)))
(assert (forall ((bytes@@6 T@Vec_6673) ) (! (let (($$res@@6 (|$1_from_bcs_deserialize'vec'u8''| bytes@@6)))
(|$IsValid'vec'u8''| $$res@@6))
 :qid |boogiebpl.7822:15|
 :skolemid |405|
)))
(assert (forall ((bytes@@7 T@Vec_6673) ) (! (let (($$res@@7 (|$1_from_bcs_deserialize'vec'u64''| bytes@@7)))
(|$IsValid'vec'u64''| $$res@@7))
 :qid |boogiebpl.7828:15|
 :skolemid |406|
)))
(assert (forall ((bytes@@8 T@Vec_6673) ) (! (let (($$res@@8 (|$1_from_bcs_deserialize'vec'address''| bytes@@8)))
(|$IsValid'vec'address''| $$res@@8))
 :qid |boogiebpl.7834:15|
 :skolemid |407|
)))
(assert (forall ((bytes@@9 T@Vec_6673) ) (! (let (($$res@@9 (|$1_from_bcs_deserialize'vec'$1_aggregator_Aggregator''| bytes@@9)))
(|$IsValid'vec'$1_aggregator_Aggregator''| $$res@@9))
 :qid |boogiebpl.7840:15|
 :skolemid |408|
)))
(assert (forall ((bytes@@10 T@Vec_6673) ) (! (let (($$res@@10 (|$1_from_bcs_deserialize'vec'$1_optional_aggregator_Integer''| bytes@@10)))
(|$IsValid'vec'$1_optional_aggregator_Integer''| $$res@@10))
 :qid |boogiebpl.7846:15|
 :skolemid |409|
)))
(assert (forall ((bytes@@11 T@Vec_6673) ) (! (let (($$res@@11 (|$1_from_bcs_deserialize'vec'$1_optional_aggregator_OptionalAggregator''| bytes@@11)))
(|$IsValid'vec'$1_optional_aggregator_OptionalAggregator''| $$res@@11))
 :qid |boogiebpl.7852:15|
 :skolemid |410|
)))
(assert (forall ((bytes@@12 T@Vec_6673) ) (! (let (($$res@@12 (|$1_from_bcs_deserialize'vec'#0''| bytes@@12)))
(|$IsValid'vec'#0''| $$res@@12))
 :qid |boogiebpl.7858:15|
 :skolemid |411|
)))
(assert (forall ((bytes@@13 T@Vec_6673) ) (! (let (($$res@@13 (|$1_from_bcs_deserialize'$1_table_Table'u64_bool''| bytes@@13)))
(|$IsValid'$1_table_Table'u64_bool''| $$res@@13))
 :qid |boogiebpl.7864:15|
 :skolemid |412|
)))
(assert (forall ((bytes@@14 T@Vec_6673) ) (! (let (($$res@@14 (|$1_from_bcs_deserialize'$1_table_Table'u64_u64''| bytes@@14)))
(|$IsValid'$1_table_Table'u64_u64''| $$res@@14))
 :qid |boogiebpl.7870:15|
 :skolemid |413|
)))
(assert (forall ((bytes@@15 T@Vec_6673) ) (! (let (($$res@@15 (|$1_from_bcs_deserialize'$1_table_Table'u64_vec'u64'''| bytes@@15)))
(|$IsValid'$1_table_Table'u64_vec'u64'''| $$res@@15))
 :qid |boogiebpl.7876:15|
 :skolemid |414|
)))
(assert (forall ((bytes@@16 T@Vec_6673) ) (! (let (($$res@@16 (|$1_from_bcs_deserialize'$1_table_Table'address_address''| bytes@@16)))
(|$IsValid'$1_table_Table'address_address''| $$res@@16))
 :qid |boogiebpl.7882:15|
 :skolemid |415|
)))
(assert (forall ((bytes@@17 T@Vec_6673) ) (! (let (($$res@@17 (|$1_from_bcs_deserialize'$1_option_Option'address''| bytes@@17)))
(|$IsValid'$1_option_Option'address''| $$res@@17))
 :qid |boogiebpl.7888:15|
 :skolemid |416|
)))
(assert (forall ((bytes@@18 T@Vec_6673) ) (! (let (($$res@@18 (|$1_from_bcs_deserialize'$1_option_Option'$1_aggregator_Aggregator''| bytes@@18)))
(|$IsValid'$1_option_Option'$1_aggregator_Aggregator''| $$res@@18))
 :qid |boogiebpl.7894:15|
 :skolemid |417|
)))
(assert (forall ((bytes@@19 T@Vec_6673) ) (! (let (($$res@@19 (|$1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_Integer''| bytes@@19)))
(|$IsValid'$1_option_Option'$1_optional_aggregator_Integer''| $$res@@19))
 :qid |boogiebpl.7900:15|
 :skolemid |418|
)))
(assert (forall ((bytes@@20 T@Vec_6673) ) (! (let (($$res@@20 (|$1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| bytes@@20)))
(|$IsValid'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| $$res@@20))
 :qid |boogiebpl.7906:15|
 :skolemid |419|
)))
(assert (forall ((bytes@@21 T@Vec_6673) ) (! (let (($$res@@21 (|$1_from_bcs_deserialize'$1_string_String'| bytes@@21)))
(|$IsValid'$1_string_String'| $$res@@21))
 :qid |boogiebpl.7912:15|
 :skolemid |420|
)))
(assert (forall ((bytes@@22 T@Vec_6673) ) (! (let (($$res@@22 (|$1_from_bcs_deserialize'$1_type_info_TypeInfo'| bytes@@22)))
(|$IsValid'$1_type_info_TypeInfo'| $$res@@22))
 :qid |boogiebpl.7918:15|
 :skolemid |421|
)))
(assert (forall ((bytes@@23 T@Vec_6673) ) (! (let (($$res@@23 (|$1_from_bcs_deserialize'$1_aggregator_Aggregator'| bytes@@23)))
(|$IsValid'$1_aggregator_Aggregator'| $$res@@23))
 :qid |boogiebpl.7924:15|
 :skolemid |422|
)))
(assert (forall ((bytes@@24 T@Vec_6673) ) (! (let (($$res@@24 (|$1_from_bcs_deserialize'$1_optional_aggregator_Integer'| bytes@@24)))
(|$IsValid'$1_optional_aggregator_Integer'| $$res@@24))
 :qid |boogiebpl.7930:15|
 :skolemid |423|
)))
(assert (forall ((bytes@@25 T@Vec_6673) ) (! (let (($$res@@25 (|$1_from_bcs_deserialize'$1_optional_aggregator_OptionalAggregator'| bytes@@25)))
(|$IsValid'$1_optional_aggregator_OptionalAggregator'| $$res@@25))
 :qid |boogiebpl.7936:15|
 :skolemid |424|
)))
(assert (forall ((bytes@@26 T@Vec_6673) ) (! (let (($$res@@26 (|$1_from_bcs_deserialize'$1_guid_GUID'| bytes@@26)))
(|$IsValid'$1_guid_GUID'| $$res@@26))
 :qid |boogiebpl.7942:15|
 :skolemid |425|
)))
(assert (forall ((bytes@@27 T@Vec_6673) ) (! (let (($$res@@27 (|$1_from_bcs_deserialize'$1_guid_ID'| bytes@@27)))
(|$IsValid'$1_guid_ID'| $$res@@27))
 :qid |boogiebpl.7948:15|
 :skolemid |426|
)))
(assert (forall ((bytes@@28 T@Vec_6673) ) (! (let (($$res@@28 (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_account_CoinRegisterEvent''| bytes@@28)))
(|$IsValid'$1_event_EventHandle'$1_account_CoinRegisterEvent''| $$res@@28))
 :qid |boogiebpl.7954:15|
 :skolemid |427|
)))
(assert (forall ((bytes@@29 T@Vec_6673) ) (! (let (($$res@@29 (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_account_KeyRotationEvent''| bytes@@29)))
(|$IsValid'$1_event_EventHandle'$1_account_KeyRotationEvent''| $$res@@29))
 :qid |boogiebpl.7960:15|
 :skolemid |428|
)))
(assert (forall ((bytes@@30 T@Vec_6673) ) (! (let (($$res@@30 (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_DepositEvent''| bytes@@30)))
(|$IsValid'$1_event_EventHandle'$1_coin_DepositEvent''| $$res@@30))
 :qid |boogiebpl.7966:15|
 :skolemid |429|
)))
(assert (forall ((bytes@@31 T@Vec_6673) ) (! (let (($$res@@31 (|$1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_WithdrawEvent''| bytes@@31)))
(|$IsValid'$1_event_EventHandle'$1_coin_WithdrawEvent''| $$res@@31))
 :qid |boogiebpl.7972:15|
 :skolemid |430|
)))
(assert (forall ((bytes@@32 T@Vec_6673) ) (! (let (($$res@@32 (|$1_from_bcs_deserialize'$1_account_Account'| bytes@@32)))
(|$IsValid'$1_account_Account'| $$res@@32))
 :qid |boogiebpl.7978:15|
 :skolemid |431|
)))
(assert (forall ((bytes@@33 T@Vec_6673) ) (! (let (($$res@@33 (|$1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_RotationCapability''| bytes@@33)))
(|$IsValid'$1_account_CapabilityOffer'$1_account_RotationCapability''| $$res@@33))
 :qid |boogiebpl.7984:15|
 :skolemid |432|
)))
(assert (forall ((bytes@@34 T@Vec_6673) ) (! (let (($$res@@34 (|$1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_SignerCapability''| bytes@@34)))
(|$IsValid'$1_account_CapabilityOffer'$1_account_SignerCapability''| $$res@@34))
 :qid |boogiebpl.7990:15|
 :skolemid |433|
)))
(assert (forall ((bytes@@35 T@Vec_6673) ) (! (let (($$res@@35 (|$1_from_bcs_deserialize'$1_account_CoinRegisterEvent'| bytes@@35)))
(|$IsValid'$1_account_CoinRegisterEvent'| $$res@@35))
 :qid |boogiebpl.7996:15|
 :skolemid |434|
)))
(assert (forall ((bytes@@36 T@Vec_6673) ) (! (let (($$res@@36 (|$1_from_bcs_deserialize'$1_account_SignerCapability'| bytes@@36)))
(|$IsValid'$1_account_SignerCapability'| $$res@@36))
 :qid |boogiebpl.8002:15|
 :skolemid |435|
)))
(assert (forall ((bytes@@37 T@Vec_6673) ) (! (let (($$res@@37 (|$1_from_bcs_deserialize'$1_coin_Coin'$1_aptos_coin_AptosCoin''| bytes@@37)))
(|$IsValid'$1_coin_Coin'$1_aptos_coin_AptosCoin''| $$res@@37))
 :qid |boogiebpl.8008:15|
 :skolemid |436|
)))
(assert (forall ((bytes@@38 T@Vec_6673) ) (! (let (($$res@@38 (|$1_from_bcs_deserialize'$1_coin_Coin'#0''| bytes@@38)))
(|$IsValid'$1_coin_Coin'#0''| $$res@@38))
 :qid |boogiebpl.8014:15|
 :skolemid |437|
)))
(assert (forall ((bytes@@39 T@Vec_6673) ) (! (let (($$res@@39 (|$1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| bytes@@39)))
(|$IsValid'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''| $$res@@39))
 :qid |boogiebpl.8020:15|
 :skolemid |438|
)))
(assert (forall ((bytes@@40 T@Vec_6673) ) (! (let (($$res@@40 (|$1_from_bcs_deserialize'$1_coin_CoinInfo'#0''| bytes@@40)))
(|$IsValid'$1_coin_CoinInfo'#0''| $$res@@40))
 :qid |boogiebpl.8026:15|
 :skolemid |439|
)))
(assert (forall ((bytes@@41 T@Vec_6673) ) (! (let (($$res@@41 (|$1_from_bcs_deserialize'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''| bytes@@41)))
(|$IsValid'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''| $$res@@41))
 :qid |boogiebpl.8032:15|
 :skolemid |440|
)))
(assert (forall ((bytes@@42 T@Vec_6673) ) (! (let (($$res@@42 (|$1_from_bcs_deserialize'$1_coin_CoinStore'#0''| bytes@@42)))
(|$IsValid'$1_coin_CoinStore'#0''| $$res@@42))
 :qid |boogiebpl.8038:15|
 :skolemid |441|
)))
(assert (forall ((bytes@@43 T@Vec_6673) ) (! (let (($$res@@43 (|$1_from_bcs_deserialize'$1_coin_DepositEvent'| bytes@@43)))
(|$IsValid'$1_coin_DepositEvent'| $$res@@43))
 :qid |boogiebpl.8044:15|
 :skolemid |442|
)))
(assert (forall ((bytes@@44 T@Vec_6673) ) (! (let (($$res@@44 (|$1_from_bcs_deserialize'$1_coin_WithdrawEvent'| bytes@@44)))
(|$IsValid'$1_coin_WithdrawEvent'| $$res@@44))
 :qid |boogiebpl.8050:15|
 :skolemid |443|
)))
(assert (forall ((bytes@@45 T@Vec_6673) ) (! (let (($$res@@45 (|$1_from_bcs_deserialize'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''| bytes@@45)))
(|$IsValid'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''| $$res@@45))
 :qid |boogiebpl.8056:15|
 :skolemid |444|
)))
(assert (forall ((bytes@@46 T@Vec_6673) ) (! (let (($$res@@46 (|$1_from_bcs_deserialize'$1_coin_Ghost$supply'#0''| bytes@@46)))
(|$IsValid'$1_coin_Ghost$supply'#0''| $$res@@46))
 :qid |boogiebpl.8062:15|
 :skolemid |445|
)))
(assert (forall ((bytes@@47 T@Vec_6673) ) (! (let (($$res@@47 (|$1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''| bytes@@47)))
(|$IsValid'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''| $$res@@47))
 :qid |boogiebpl.8068:15|
 :skolemid |446|
)))
(assert (forall ((bytes@@48 T@Vec_6673) ) (! (let (($$res@@48 (|$1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'#0''| bytes@@48)))
(|$IsValid'$1_coin_Ghost$aggregate_supply'#0''| $$res@@48))
 :qid |boogiebpl.8074:15|
 :skolemid |447|
)))
(assert (forall ((bytes@@49 T@Vec_6673) ) (! (let (($$res@@49 (|$1_from_bcs_deserialize'$1_aptos_coin_AptosCoin'| bytes@@49)))
(|$IsValid'$1_aptos_coin_AptosCoin'| $$res@@49))
 :qid |boogiebpl.8080:15|
 :skolemid |448|
)))
(assert (forall ((bytes@@50 T@Vec_6673) ) (! (let (($$res@@50 (|$1_from_bcs_deserialize'$1_Bbay_Owner'| bytes@@50)))
(|$IsValid'$1_Bbay_Owner'| $$res@@50))
 :qid |boogiebpl.8086:15|
 :skolemid |449|
)))
(assert (forall ((bytes@@51 T@Vec_6673) ) (! (let (($$res@@51 (|$1_from_bcs_deserialize'$1_Bbay_Products'| bytes@@51)))
(|$IsValid'$1_Bbay_Products'| $$res@@51))
 :qid |boogiebpl.8092:15|
 :skolemid |450|
)))
(assert (forall ((bytes@@52 T@Vec_6673) ) (! (let (($$res@@52 (|$1_from_bcs_deserialize'$1_Bbay_ResourceAccountSignerCap'| bytes@@52)))
(|$IsValid'$1_Bbay_ResourceAccountSignerCap'| $$res@@52))
 :qid |boogiebpl.8098:15|
 :skolemid |451|
)))
(assert (forall ((bytes@@53 T@Vec_6673) ) (! (let (($$res@@53 (|$1_from_bcs_deserialize'$1_Bbay_User'| bytes@@53)))
(|$IsValid'$1_Bbay_User'| $$res@@53))
 :qid |boogiebpl.8104:15|
 :skolemid |452|
)))
(assert (forall ((bytes@@54 T@Vec_6673) ) (! true
 :qid |boogiebpl.8110:15|
 :skolemid |453|
)))
(assert (forall ((bytes@@55 T@Vec_6673) ) (! true
 :qid |boogiebpl.8116:15|
 :skolemid |454|
)))
(assert (forall ((bytes@@56 T@Vec_6673) ) (! true
 :qid |boogiebpl.8122:15|
 :skolemid |455|
)))
(assert (forall ((bytes@@57 T@Vec_6673) ) (! true
 :qid |boogiebpl.8128:15|
 :skolemid |456|
)))
(assert (forall ((bytes@@58 T@Vec_6673) ) (! true
 :qid |boogiebpl.8134:15|
 :skolemid |457|
)))
(assert (forall ((bytes@@59 T@Vec_6673) ) (! true
 :qid |boogiebpl.8140:15|
 :skolemid |458|
)))
(assert (forall ((bytes@@60 T@Vec_6673) ) (! true
 :qid |boogiebpl.8146:15|
 :skolemid |459|
)))
(assert (forall ((bytes@@61 T@Vec_6673) ) (! true
 :qid |boogiebpl.8152:15|
 :skolemid |460|
)))
(assert (forall ((bytes@@62 T@Vec_6673) ) (! true
 :qid |boogiebpl.8158:15|
 :skolemid |461|
)))
(assert (forall ((bytes@@63 T@Vec_6673) ) (! true
 :qid |boogiebpl.8164:15|
 :skolemid |462|
)))
(assert (forall ((bytes@@64 T@Vec_6673) ) (! true
 :qid |boogiebpl.8170:15|
 :skolemid |463|
)))
(assert (forall ((bytes@@65 T@Vec_6673) ) (! true
 :qid |boogiebpl.8176:15|
 :skolemid |464|
)))
(assert (forall ((bytes@@66 T@Vec_6673) ) (! true
 :qid |boogiebpl.8182:15|
 :skolemid |465|
)))
(assert (forall ((bytes@@67 T@Vec_6673) ) (! true
 :qid |boogiebpl.8188:15|
 :skolemid |466|
)))
(assert (forall ((bytes@@68 T@Vec_6673) ) (! true
 :qid |boogiebpl.8194:15|
 :skolemid |467|
)))
(assert (forall ((bytes@@69 T@Vec_6673) ) (! true
 :qid |boogiebpl.8200:15|
 :skolemid |468|
)))
(assert (forall ((bytes@@70 T@Vec_6673) ) (! true
 :qid |boogiebpl.8206:15|
 :skolemid |469|
)))
(assert (forall ((bytes@@71 T@Vec_6673) ) (! true
 :qid |boogiebpl.8212:15|
 :skolemid |470|
)))
(assert (forall ((bytes@@72 T@Vec_6673) ) (! true
 :qid |boogiebpl.8218:15|
 :skolemid |471|
)))
(assert (forall ((bytes@@73 T@Vec_6673) ) (! true
 :qid |boogiebpl.8224:15|
 :skolemid |472|
)))
(assert (forall ((bytes@@74 T@Vec_6673) ) (! true
 :qid |boogiebpl.8230:15|
 :skolemid |473|
)))
(assert (forall ((bytes@@75 T@Vec_6673) ) (! true
 :qid |boogiebpl.8236:15|
 :skolemid |474|
)))
(assert (forall ((bytes@@76 T@Vec_6673) ) (! true
 :qid |boogiebpl.8242:15|
 :skolemid |475|
)))
(assert (forall ((bytes@@77 T@Vec_6673) ) (! true
 :qid |boogiebpl.8248:15|
 :skolemid |476|
)))
(assert (forall ((bytes@@78 T@Vec_6673) ) (! true
 :qid |boogiebpl.8254:15|
 :skolemid |477|
)))
(assert (forall ((bytes@@79 T@Vec_6673) ) (! true
 :qid |boogiebpl.8260:15|
 :skolemid |478|
)))
(assert (forall ((bytes@@80 T@Vec_6673) ) (! true
 :qid |boogiebpl.8266:15|
 :skolemid |479|
)))
(assert (forall ((bytes@@81 T@Vec_6673) ) (! true
 :qid |boogiebpl.8272:15|
 :skolemid |480|
)))
(assert (forall ((bytes@@82 T@Vec_6673) ) (! true
 :qid |boogiebpl.8278:15|
 :skolemid |481|
)))
(assert (forall ((bytes@@83 T@Vec_6673) ) (! true
 :qid |boogiebpl.8284:15|
 :skolemid |482|
)))
(assert (forall ((bytes@@84 T@Vec_6673) ) (! true
 :qid |boogiebpl.8290:15|
 :skolemid |483|
)))
(assert (forall ((bytes@@85 T@Vec_6673) ) (! true
 :qid |boogiebpl.8296:15|
 :skolemid |484|
)))
(assert (forall ((bytes@@86 T@Vec_6673) ) (! true
 :qid |boogiebpl.8302:15|
 :skolemid |485|
)))
(assert (forall ((bytes@@87 T@Vec_6673) ) (! true
 :qid |boogiebpl.8308:15|
 :skolemid |486|
)))
(assert (forall ((bytes@@88 T@Vec_6673) ) (! true
 :qid |boogiebpl.8314:15|
 :skolemid |487|
)))
(assert (forall ((bytes@@89 T@Vec_6673) ) (! true
 :qid |boogiebpl.8320:15|
 :skolemid |488|
)))
(assert (forall ((bytes@@90 T@Vec_6673) ) (! true
 :qid |boogiebpl.8326:15|
 :skolemid |489|
)))
(assert (forall ((bytes@@91 T@Vec_6673) ) (! true
 :qid |boogiebpl.8332:15|
 :skolemid |490|
)))
(assert (forall ((bytes@@92 T@Vec_6673) ) (! true
 :qid |boogiebpl.8338:15|
 :skolemid |491|
)))
(assert (forall ((bytes@@93 T@Vec_6673) ) (! true
 :qid |boogiebpl.8344:15|
 :skolemid |492|
)))
(assert (forall ((bytes@@94 T@Vec_6673) ) (! true
 :qid |boogiebpl.8350:15|
 :skolemid |493|
)))
(assert (forall ((bytes@@95 T@Vec_6673) ) (! true
 :qid |boogiebpl.8356:15|
 :skolemid |494|
)))
(assert (forall ((bytes@@96 T@Vec_6673) ) (! true
 :qid |boogiebpl.8362:15|
 :skolemid |495|
)))
(assert (forall ((bytes@@97 T@Vec_6673) ) (! true
 :qid |boogiebpl.8368:15|
 :skolemid |496|
)))
(assert (forall ((bytes@@98 T@Vec_6673) ) (! true
 :qid |boogiebpl.8374:15|
 :skolemid |497|
)))
(assert (forall ((bytes@@99 T@Vec_6673) ) (! true
 :qid |boogiebpl.8380:15|
 :skolemid |498|
)))
(assert (forall ((bytes@@100 T@Vec_6673) ) (! true
 :qid |boogiebpl.8386:15|
 :skolemid |499|
)))
(assert (forall ((bytes@@101 T@Vec_6673) ) (! true
 :qid |boogiebpl.8392:15|
 :skolemid |500|
)))
(assert (forall ((bytes@@102 T@Vec_6673) ) (! true
 :qid |boogiebpl.8398:15|
 :skolemid |501|
)))
(assert (forall ((bytes@@103 T@Vec_6673) ) (! true
 :qid |boogiebpl.8404:15|
 :skolemid |502|
)))
(assert (forall ((bytes@@104 T@Vec_6673) ) (! true
 :qid |boogiebpl.8410:15|
 :skolemid |503|
)))
(assert (forall ((bytes@@105 T@Vec_6673) ) (! true
 :qid |boogiebpl.8416:15|
 :skolemid |504|
)))
(assert (forall ((bytes@@106 T@Vec_6673) ) (! true
 :qid |boogiebpl.8422:15|
 :skolemid |505|
)))
(assert (forall ((bytes@@107 T@Vec_6673) ) (! true
 :qid |boogiebpl.8428:15|
 :skolemid |506|
)))
(assert (forall ((bytes@@108 T@Vec_6673) ) (! true
 :qid |boogiebpl.8434:15|
 :skolemid |507|
)))
(assert (forall ((bytes@@109 T@Vec_6673) ) (! true
 :qid |boogiebpl.8440:15|
 :skolemid |508|
)))
(assert (forall ((bytes@@110 T@Vec_6673) ) (! true
 :qid |boogiebpl.8446:15|
 :skolemid |509|
)))
(assert (forall ((bytes@@111 T@Vec_6673) ) (! (let (($$res@@54 ($1_aptos_hash_spec_keccak256 bytes@@111)))
(|$IsValid'vec'u8''| $$res@@54))
 :qid |boogiebpl.13087:15|
 :skolemid |557|
)))
(assert (forall ((bytes@@112 T@Vec_6673) ) (! (let (($$res@@55 ($1_aptos_hash_spec_sha2_512_internal bytes@@112)))
(|$IsValid'vec'u8''| $$res@@55))
 :qid |boogiebpl.13093:15|
 :skolemid |558|
)))
(assert (forall ((bytes@@113 T@Vec_6673) ) (! (let (($$res@@56 ($1_aptos_hash_spec_sha3_512_internal bytes@@113)))
(|$IsValid'vec'u8''| $$res@@56))
 :qid |boogiebpl.13099:15|
 :skolemid |559|
)))
(assert (forall ((bytes@@114 T@Vec_6673) ) (! (let (($$res@@57 ($1_aptos_hash_spec_ripemd160_internal bytes@@114)))
(|$IsValid'vec'u8''| $$res@@57))
 :qid |boogiebpl.13105:15|
 :skolemid |560|
)))
(assert (forall ((bytes@@115 T@Vec_6673) ) (! (let (($$res@@58 ($1_aptos_hash_spec_blake2b_256_internal bytes@@115)))
(|$IsValid'vec'u8''| $$res@@58))
 :qid |boogiebpl.13111:15|
 :skolemid |561|
)))
(assert (forall ((t@@5 T@$TypeParamInfo) ) (!  (=> (is-$TypeParamAddress t@@5) (|$IsEqual'vec'u8''| ($TypeName t@@5) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 97) 1 100) 2 100) 3 114) 4 101) 5 115) 6 115) 7)))
 :qid |boogiebpl.6535:15|
 :skolemid |259|
 :pattern ( ($TypeName t@@5))
)))
(assert (forall ((k1@@0 Int) (k2@@0 Int) ) (! (= (= k1@@0 k2@@0) (= (|$EncodeKey'u64'| k1@@0) (|$EncodeKey'u64'| k2@@0)))
 :qid |boogiebpl.5818:10|
 :skolemid |212|
 :pattern ( (|$EncodeKey'u64'| k1@@0) (|$EncodeKey'u64'| k2@@0))
)))
(assert (forall ((k1@@1 Int) (k2@@1 Int) ) (! (= (= k1@@1 k2@@1) (= (|$EncodeKey'address'| k1@@1) (|$EncodeKey'address'| k2@@1)))
 :qid |boogiebpl.5828:10|
 :skolemid |213|
 :pattern ( (|$EncodeKey'address'| k1@@1) (|$EncodeKey'address'| k2@@1))
)))
(assert (forall ((t@@6 T@$TypeParamInfo) ) (!  (=> (is-$TypeParamVector t@@6) (|$IsEqual'vec'u8''| ($TypeName t@@6) (let ((m2@@0 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 62) 1))))
(let ((l2 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 62) 1))))
(let ((m1@@0 (|v#Vec_6673| (let ((m2@@1 (|v#Vec_6673| ($TypeName (|e#$TypeParamVector| t@@6)))))
(let ((l2@@0 (|l#Vec_6673| ($TypeName (|e#$TypeParamVector| t@@6)))))
(let ((m1@@1 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 118) 1 101) 2 99) 3 116) 4 111) 5 114) 6 60) 7))))
(let ((l1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 118) 1 101) 2 99) 3 116) 4 111) 5 114) 6 60) 7))))
(Vec_6673 (|lambda#16| 0 (+ l1 l2@@0) l1 m1@@1 m2@@1 l1 DefaultVecElem_25347) (+ l1 l2@@0)))))))))
(let ((l1@@0 (|l#Vec_6673| (let ((m2@@1 (|v#Vec_6673| ($TypeName (|e#$TypeParamVector| t@@6)))))
(let ((l2@@0 (|l#Vec_6673| ($TypeName (|e#$TypeParamVector| t@@6)))))
(let ((m1@@1 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 118) 1 101) 2 99) 3 116) 4 111) 5 114) 6 60) 7))))
(let ((l1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 118) 1 101) 2 99) 3 116) 4 111) 5 114) 6 60) 7))))
(Vec_6673 (|lambda#16| 0 (+ l1 l2@@0) l1 m1@@1 m2@@1 l1 DefaultVecElem_25347) (+ l1 l2@@0)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@0 l2) l1@@0 m1@@0 m2@@0 l1@@0 DefaultVecElem_25347) (+ l1@@0 l2))))))))
 :qid |boogiebpl.6539:15|
 :skolemid |263|
 :pattern ( ($TypeName t@@6))
)))
(assert (forall ((t@@7 T@Table_37064_126051) ) (!  (=> (exists ((k@@9 Int) ) (! (|Select__T@[Int]Bool_| (|e#Table_37064_126051| t@@7) k@@9)
 :qid |boogiebpl.231:13|
 :skolemid |6|
 :pattern ( (|Select__T@[Int]Bool_| (|e#Table_37064_126051| t@@7) k@@9))
)) (>= (|l#Table_37064_126051| t@@7) 1))
 :qid |boogiebpl.230:36|
 :skolemid |7|
 :pattern ( (|l#Table_37064_126051| t@@7))
)))
(assert (forall ((t@@8 T@Table_36177_36178) ) (!  (=> (exists ((k@@10 Int) ) (! (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t@@8) k@@10)
 :qid |boogiebpl.231:13|
 :skolemid |6|
 :pattern ( (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t@@8) k@@10))
)) (>= (|l#Table_36177_36178| t@@8) 1))
 :qid |boogiebpl.230:36|
 :skolemid |7|
 :pattern ( (|l#Table_36177_36178| t@@8))
)))
(assert (forall ((t@@9 T@Table_35290_35291) ) (!  (=> (exists ((k@@11 Int) ) (! (|Select__T@[Int]Bool_| (|e#Table_35290_35291| t@@9) k@@11)
 :qid |boogiebpl.231:13|
 :skolemid |6|
 :pattern ( (|Select__T@[Int]Bool_| (|e#Table_35290_35291| t@@9) k@@11))
)) (>= (|l#Table_35290_35291| t@@9) 1))
 :qid |boogiebpl.230:36|
 :skolemid |7|
 :pattern ( (|l#Table_35290_35291| t@@9))
)))
(assert (forall ((t@@10 T@$TypeParamInfo) ) (!  (=> (|$IsEqual'vec'u8''| ($TypeName t@@10) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 98) 1 111) 2 111) 3 108) 4)) (is-$TypeParamBool t@@10))
 :qid |boogiebpl.6522:15|
 :skolemid |246|
 :pattern ( ($TypeName t@@10))
)))
(assert (forall ((src1@@2 (_ BitVec 8)) (src2 (_ BitVec 16)) ) (! (= ($shlBv8From16 src1@@2 src2) (bvshl src1@@2 ((_ extract 7 0) src2)))
 :qid |boogiebpl.1583:24|
 :skolemid |43|
 :pattern ( ($shlBv8From16 src1@@2 src2))
)))
(assert (forall ((src1@@3 (_ BitVec 8)) (src2@@0 (_ BitVec 16)) ) (! (= ($shrBv8From16 src1@@3 src2@@0) (bvlshr src1@@3 ((_ extract 7 0) src2@@0)))
 :qid |boogiebpl.1597:24|
 :skolemid |44|
 :pattern ( ($shrBv8From16 src1@@3 src2@@0))
)))
(assert (forall ((src1@@4 (_ BitVec 8)) (src2@@1 (_ BitVec 32)) ) (! (= ($shlBv8From32 src1@@4 src2@@1) (bvshl src1@@4 ((_ extract 7 0) src2@@1)))
 :qid |boogiebpl.1621:24|
 :skolemid |45|
 :pattern ( ($shlBv8From32 src1@@4 src2@@1))
)))
(assert (forall ((src1@@5 (_ BitVec 8)) (src2@@2 (_ BitVec 32)) ) (! (= ($shrBv8From32 src1@@5 src2@@2) (bvlshr src1@@5 ((_ extract 7 0) src2@@2)))
 :qid |boogiebpl.1635:24|
 :skolemid |46|
 :pattern ( ($shrBv8From32 src1@@5 src2@@2))
)))
(assert (forall ((src1@@6 (_ BitVec 8)) (src2@@3 (_ BitVec 64)) ) (! (= ($shlBv8From64 src1@@6 src2@@3) (bvshl src1@@6 ((_ extract 7 0) src2@@3)))
 :qid |boogiebpl.1659:24|
 :skolemid |47|
 :pattern ( ($shlBv8From64 src1@@6 src2@@3))
)))
(assert (forall ((src1@@7 (_ BitVec 8)) (src2@@4 (_ BitVec 64)) ) (! (= ($shrBv8From64 src1@@7 src2@@4) (bvlshr src1@@7 ((_ extract 7 0) src2@@4)))
 :qid |boogiebpl.1673:24|
 :skolemid |48|
 :pattern ( ($shrBv8From64 src1@@7 src2@@4))
)))
(assert (forall ((src1@@8 (_ BitVec 8)) (src2@@5 (_ BitVec 128)) ) (! (= ($shlBv8From128 src1@@8 src2@@5) (bvshl src1@@8 ((_ extract 7 0) src2@@5)))
 :qid |boogiebpl.1697:25|
 :skolemid |49|
 :pattern ( ($shlBv8From128 src1@@8 src2@@5))
)))
(assert (forall ((src1@@9 (_ BitVec 8)) (src2@@6 (_ BitVec 128)) ) (! (= ($shrBv8From128 src1@@9 src2@@6) (bvlshr src1@@9 ((_ extract 7 0) src2@@6)))
 :qid |boogiebpl.1711:25|
 :skolemid |50|
 :pattern ( ($shrBv8From128 src1@@9 src2@@6))
)))
(assert (forall ((src1@@10 (_ BitVec 8)) (src2@@7 (_ BitVec 256)) ) (! (= ($shlBv8From256 src1@@10 src2@@7) (bvshl src1@@10 ((_ extract 7 0) src2@@7)))
 :qid |boogiebpl.1735:25|
 :skolemid |51|
 :pattern ( ($shlBv8From256 src1@@10 src2@@7))
)))
(assert (forall ((src1@@11 (_ BitVec 8)) (src2@@8 (_ BitVec 256)) ) (! (= ($shrBv8From256 src1@@11 src2@@8) (bvlshr src1@@11 ((_ extract 7 0) src2@@8)))
 :qid |boogiebpl.1749:25|
 :skolemid |52|
 :pattern ( ($shrBv8From256 src1@@11 src2@@8))
)))
(assert (forall ((src1@@12 (_ BitVec 16)) (src2@@9 (_ BitVec 32)) ) (! (= ($shlBv16From32 src1@@12 src2@@9) (bvshl src1@@12 ((_ extract 15 0) src2@@9)))
 :qid |boogiebpl.1841:25|
 :skolemid |57|
 :pattern ( ($shlBv16From32 src1@@12 src2@@9))
)))
(assert (forall ((src1@@13 (_ BitVec 16)) (src2@@10 (_ BitVec 32)) ) (! (= ($shrBv16From32 src1@@13 src2@@10) (bvlshr src1@@13 ((_ extract 15 0) src2@@10)))
 :qid |boogiebpl.1855:25|
 :skolemid |58|
 :pattern ( ($shrBv16From32 src1@@13 src2@@10))
)))
(assert (forall ((src1@@14 (_ BitVec 16)) (src2@@11 (_ BitVec 64)) ) (! (= ($shlBv16From64 src1@@14 src2@@11) (bvshl src1@@14 ((_ extract 15 0) src2@@11)))
 :qid |boogiebpl.1879:25|
 :skolemid |59|
 :pattern ( ($shlBv16From64 src1@@14 src2@@11))
)))
(assert (forall ((src1@@15 (_ BitVec 16)) (src2@@12 (_ BitVec 64)) ) (! (= ($shrBv16From64 src1@@15 src2@@12) (bvlshr src1@@15 ((_ extract 15 0) src2@@12)))
 :qid |boogiebpl.1893:25|
 :skolemid |60|
 :pattern ( ($shrBv16From64 src1@@15 src2@@12))
)))
(assert (forall ((src1@@16 (_ BitVec 16)) (src2@@13 (_ BitVec 128)) ) (! (= ($shlBv16From128 src1@@16 src2@@13) (bvshl src1@@16 ((_ extract 15 0) src2@@13)))
 :qid |boogiebpl.1917:26|
 :skolemid |61|
 :pattern ( ($shlBv16From128 src1@@16 src2@@13))
)))
(assert (forall ((src1@@17 (_ BitVec 16)) (src2@@14 (_ BitVec 128)) ) (! (= ($shrBv16From128 src1@@17 src2@@14) (bvlshr src1@@17 ((_ extract 15 0) src2@@14)))
 :qid |boogiebpl.1931:26|
 :skolemid |62|
 :pattern ( ($shrBv16From128 src1@@17 src2@@14))
)))
(assert (forall ((src1@@18 (_ BitVec 16)) (src2@@15 (_ BitVec 256)) ) (! (= ($shlBv16From256 src1@@18 src2@@15) (bvshl src1@@18 ((_ extract 15 0) src2@@15)))
 :qid |boogiebpl.1955:26|
 :skolemid |63|
 :pattern ( ($shlBv16From256 src1@@18 src2@@15))
)))
(assert (forall ((src1@@19 (_ BitVec 16)) (src2@@16 (_ BitVec 256)) ) (! (= ($shrBv16From256 src1@@19 src2@@16) (bvlshr src1@@19 ((_ extract 15 0) src2@@16)))
 :qid |boogiebpl.1969:26|
 :skolemid |64|
 :pattern ( ($shrBv16From256 src1@@19 src2@@16))
)))
(assert (forall ((src1@@20 (_ BitVec 32)) (src2@@17 (_ BitVec 64)) ) (! (= ($shlBv32From64 src1@@20 src2@@17) (bvshl src1@@20 ((_ extract 31 0) src2@@17)))
 :qid |boogiebpl.2095:25|
 :skolemid |71|
 :pattern ( ($shlBv32From64 src1@@20 src2@@17))
)))
(assert (forall ((src1@@21 (_ BitVec 32)) (src2@@18 (_ BitVec 64)) ) (! (= ($shrBv32From64 src1@@21 src2@@18) (bvlshr src1@@21 ((_ extract 31 0) src2@@18)))
 :qid |boogiebpl.2109:25|
 :skolemid |72|
 :pattern ( ($shrBv32From64 src1@@21 src2@@18))
)))
(assert (forall ((src1@@22 (_ BitVec 32)) (src2@@19 (_ BitVec 128)) ) (! (= ($shlBv32From128 src1@@22 src2@@19) (bvshl src1@@22 ((_ extract 31 0) src2@@19)))
 :qid |boogiebpl.2133:26|
 :skolemid |73|
 :pattern ( ($shlBv32From128 src1@@22 src2@@19))
)))
(assert (forall ((src1@@23 (_ BitVec 32)) (src2@@20 (_ BitVec 128)) ) (! (= ($shrBv32From128 src1@@23 src2@@20) (bvlshr src1@@23 ((_ extract 31 0) src2@@20)))
 :qid |boogiebpl.2147:26|
 :skolemid |74|
 :pattern ( ($shrBv32From128 src1@@23 src2@@20))
)))
(assert (forall ((src1@@24 (_ BitVec 32)) (src2@@21 (_ BitVec 256)) ) (! (= ($shlBv32From256 src1@@24 src2@@21) (bvshl src1@@24 ((_ extract 31 0) src2@@21)))
 :qid |boogiebpl.2171:26|
 :skolemid |75|
 :pattern ( ($shlBv32From256 src1@@24 src2@@21))
)))
(assert (forall ((src1@@25 (_ BitVec 32)) (src2@@22 (_ BitVec 256)) ) (! (= ($shrBv32From256 src1@@25 src2@@22) (bvlshr src1@@25 ((_ extract 31 0) src2@@22)))
 :qid |boogiebpl.2185:26|
 :skolemid |76|
 :pattern ( ($shrBv32From256 src1@@25 src2@@22))
)))
(assert (forall ((src1@@26 (_ BitVec 64)) (src2@@23 (_ BitVec 128)) ) (! (= ($shlBv64From128 src1@@26 src2@@23) (bvshl src1@@26 ((_ extract 63 0) src2@@23)))
 :qid |boogiebpl.2345:26|
 :skolemid |85|
 :pattern ( ($shlBv64From128 src1@@26 src2@@23))
)))
(assert (forall ((src1@@27 (_ BitVec 64)) (src2@@24 (_ BitVec 128)) ) (! (= ($shrBv64From128 src1@@27 src2@@24) (bvlshr src1@@27 ((_ extract 63 0) src2@@24)))
 :qid |boogiebpl.2359:26|
 :skolemid |86|
 :pattern ( ($shrBv64From128 src1@@27 src2@@24))
)))
(assert (forall ((src1@@28 (_ BitVec 64)) (src2@@25 (_ BitVec 256)) ) (! (= ($shlBv64From256 src1@@28 src2@@25) (bvshl src1@@28 ((_ extract 63 0) src2@@25)))
 :qid |boogiebpl.2383:26|
 :skolemid |87|
 :pattern ( ($shlBv64From256 src1@@28 src2@@25))
)))
(assert (forall ((src1@@29 (_ BitVec 64)) (src2@@26 (_ BitVec 256)) ) (! (= ($shrBv64From256 src1@@29 src2@@26) (bvlshr src1@@29 ((_ extract 63 0) src2@@26)))
 :qid |boogiebpl.2397:26|
 :skolemid |88|
 :pattern ( ($shrBv64From256 src1@@29 src2@@26))
)))
(assert (forall ((src1@@30 (_ BitVec 128)) (src2@@27 (_ BitVec 256)) ) (! (= ($shlBv128From256 src1@@30 src2@@27) (bvshl src1@@30 ((_ extract 127 0) src2@@27)))
 :qid |boogiebpl.2591:27|
 :skolemid |99|
 :pattern ( ($shlBv128From256 src1@@30 src2@@27))
)))
(assert (forall ((src1@@31 (_ BitVec 128)) (src2@@28 (_ BitVec 256)) ) (! (= ($shrBv128From256 src1@@31 src2@@28) (bvlshr src1@@31 ((_ extract 127 0) src2@@28)))
 :qid |boogiebpl.2605:27|
 :skolemid |100|
 :pattern ( ($shrBv128From256 src1@@31 src2@@28))
)))
(assert (forall ((src1@@32 Int) (p@@2 Int) ) (! (= ($shlU8 src1@@32 p@@2) (mod (* src1@@32 ($pow 2 p@@2)) 256))
 :qid |boogiebpl.1495:17|
 :skolemid |34|
 :pattern ( ($shlU8 src1@@32 p@@2))
)))
(assert (forall ((src1@@33 Int) (p@@3 Int) ) (! (= ($shlU32 src1@@33 p@@3) (mod (* src1@@33 ($pow 2 p@@3)) 4294967296))
 :qid |boogiebpl.1503:18|
 :skolemid |36|
 :pattern ( ($shlU32 src1@@33 p@@3))
)))
(assert (forall ((src1@@34 Int) (p@@4 Int) ) (! (= ($shlU16 src1@@34 p@@4) (mod (* src1@@34 ($pow 2 p@@4)) 65536))
 :qid |boogiebpl.1499:18|
 :skolemid |35|
 :pattern ( ($shlU16 src1@@34 p@@4))
)))
(assert (forall ((src1@@35 Int) (p@@5 Int) ) (! (= ($shlU64 src1@@35 p@@5) (mod (* src1@@35 ($pow 2 p@@5)) 18446744073709551616))
 :qid |boogiebpl.1507:18|
 :skolemid |37|
 :pattern ( ($shlU64 src1@@35 p@@5))
)))
(assert (forall ((s@@14 T@$1_Bbay_Products) ) (! (= (|$IsValid'$1_Bbay_Products'| s@@14)  (and (and (and (and (and (|$IsValid'$1_table_Table'u64_u64''| (|$sr_number#$1_Bbay_Products| s@@14)) (|$IsValid'vec'u64''| (|$item_id#$1_Bbay_Products| s@@14))) (|$IsValid'$1_table_Table'u64_vec'u64'''| (|$item_name#$1_Bbay_Products| s@@14))) (|$IsValid'$1_table_Table'u64_bool''| (|$item_sold#$1_Bbay_Products| s@@14))) (|$IsValid'$1_table_Table'u64_u64''| (|$item_price#$1_Bbay_Products| s@@14))) (|$IsValid'$1_table_Table'u64_bool''| (|$item_on_selling#$1_Bbay_Products| s@@14))))
 :qid |boogiebpl.11538:37|
 :skolemid |532|
 :pattern ( (|$IsValid'$1_Bbay_Products'| s@@14))
)))
(assert (forall ((t@@11 T@$TypeParamInfo) ) (!  (=> (and (|$IsPrefix'vec'u8''| ($TypeName t@@11) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 118) 1 101) 2 99) 3 116) 4 111) 5 114) 6 60) 7)) (|$IsSuffix'vec'u8''| ($TypeName t@@11) (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 62) 1))) (is-$TypeParamVector t@@11))
 :qid |boogiebpl.6540:15|
 :skolemid |264|
 :pattern ( ($TypeName t@@11))
)))
(assert (forall ((t@@12 T@$TypeParamInfo) ) (!  (=> (|$IsEqual'vec'u8''| ($TypeName t@@12) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 115) 1 105) 2 103) 3 110) 4 101) 5 114) 6)) (is-$TypeParamSigner t@@12))
 :qid |boogiebpl.6538:15|
 :skolemid |262|
 :pattern ( ($TypeName t@@12))
)))
(assert (forall ((v@@27 T@Vec_85428) ) (! (= (|$IsValid'vec'#0''| v@@27)  (and (|$IsValid'u64'| (|l#Vec_85428| v@@27)) (forall ((i@@54 Int) ) (!  (=> (InRangeVec_65852 v@@27 i@@54) true)
 :qid |boogiebpl.3098:13|
 :skolemid |119|
))))
 :qid |boogiebpl.3096:28|
 :skolemid |120|
 :pattern ( (|$IsValid'vec'#0''| v@@27))
)))
(assert (forall ((v@@28 T@Vec_90390) ) (! (= (|$IsValid'vec'$1_aggregator_Aggregator''| v@@28)  (and (|$IsValid'u64'| (|l#Vec_90390| v@@28)) (forall ((i@@55 Int) ) (!  (=> (InRangeVec_66199 v@@28 i@@55) (|$IsValid'$1_aggregator_Aggregator'| (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| v@@28) i@@55)))
 :qid |boogiebpl.3402:13|
 :skolemid |130|
))))
 :qid |boogiebpl.3400:50|
 :skolemid |131|
 :pattern ( (|$IsValid'vec'$1_aggregator_Aggregator''| v@@28))
)))
(assert (forall ((v@@29 T@Vec_95276) ) (! (= (|$IsValid'vec'$1_optional_aggregator_Integer''| v@@29)  (and (|$IsValid'u64'| (|l#Vec_95276| v@@29)) (forall ((i@@56 Int) ) (!  (=> (InRangeVec_66546 v@@29 i@@56) (|$IsValid'$1_optional_aggregator_Integer'| (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| v@@29) i@@56)))
 :qid |boogiebpl.3706:13|
 :skolemid |141|
))))
 :qid |boogiebpl.3704:56|
 :skolemid |142|
 :pattern ( (|$IsValid'vec'$1_optional_aggregator_Integer''| v@@29))
)))
(assert (forall ((v@@30 T@Vec_100175) ) (! (= (|$IsValid'vec'$1_optional_aggregator_OptionalAggregator''| v@@30)  (and (|$IsValid'u64'| (|l#Vec_100175| v@@30)) (forall ((i@@57 Int) ) (!  (=> (InRangeVec_66893 v@@30 i@@57) (|$IsValid'$1_optional_aggregator_OptionalAggregator'| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@30) i@@57)))
 :qid |boogiebpl.4010:13|
 :skolemid |152|
))))
 :qid |boogiebpl.4008:67|
 :skolemid |153|
 :pattern ( (|$IsValid'vec'$1_optional_aggregator_OptionalAggregator''| v@@30))
)))
(assert (forall ((v@@31 T@Vec_6673) ) (! (= (|$IsValid'vec'address''| v@@31)  (and (|$IsValid'u64'| (|l#Vec_6673| v@@31)) (forall ((i@@58 Int) ) (!  (=> (InRangeVec_25002 v@@31 i@@58) (|$IsValid'address'| (|Select__T@[Int]Int_| (|v#Vec_6673| v@@31) i@@58)))
 :qid |boogiebpl.4314:13|
 :skolemid |163|
))))
 :qid |boogiebpl.4312:33|
 :skolemid |164|
 :pattern ( (|$IsValid'vec'address''| v@@31))
)))
(assert (forall ((v@@32 T@Vec_6673) ) (! (= (|$IsValid'vec'u64''| v@@32)  (and (|$IsValid'u64'| (|l#Vec_6673| v@@32)) (forall ((i@@59 Int) ) (!  (=> (InRangeVec_25002 v@@32 i@@59) (|$IsValid'u64'| (|Select__T@[Int]Int_| (|v#Vec_6673| v@@32) i@@59)))
 :qid |boogiebpl.4618:13|
 :skolemid |174|
))))
 :qid |boogiebpl.4616:29|
 :skolemid |175|
 :pattern ( (|$IsValid'vec'u64''| v@@32))
)))
(assert (forall ((v@@33 T@Vec_6673) ) (! (= (|$IsValid'vec'u8''| v@@33)  (and (|$IsValid'u64'| (|l#Vec_6673| v@@33)) (forall ((i@@60 Int) ) (!  (=> (InRangeVec_25002 v@@33 i@@60) (|$IsValid'u8'| (|Select__T@[Int]Int_| (|v#Vec_6673| v@@33) i@@60)))
 :qid |boogiebpl.4922:13|
 :skolemid |185|
))))
 :qid |boogiebpl.4920:28|
 :skolemid |186|
 :pattern ( (|$IsValid'vec'u8''| v@@33))
)))
(assert (forall ((v@@34 T@Vec_67815) ) (! (= (|$IsValid'vec'bv64''| v@@34)  (and (|$IsValid'u64'| (|l#Vec_67815| v@@34)) (forall ((i@@61 Int) ) (!  (=> (InRangeVec_67819 v@@34 i@@61) (|$IsValid'bv64'| (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| v@@34) i@@61)))
 :qid |boogiebpl.5226:13|
 :skolemid |196|
))))
 :qid |boogiebpl.5224:30|
 :skolemid |197|
 :pattern ( (|$IsValid'vec'bv64''| v@@34))
)))
(assert (forall ((v@@35 T@Vec_68162) ) (! (= (|$IsValid'vec'bv8''| v@@35)  (and (|$IsValid'u64'| (|l#Vec_68162| v@@35)) (forall ((i@@62 Int) ) (!  (=> (InRangeVec_68166 v@@35 i@@62) (|$IsValid'bv8'| (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| v@@35) i@@62)))
 :qid |boogiebpl.5530:13|
 :skolemid |207|
))))
 :qid |boogiebpl.5528:29|
 :skolemid |208|
 :pattern ( (|$IsValid'vec'bv8''| v@@35))
)))
(assert (forall ((t@@13 T@Table_35290_35291) ) (! (= (|$IsValid'$1_table_Table'u64_bool''| t@@13)  (and (|$IsValid'u64'| (|l#Table_35290_35291| t@@13)) (forall ((i@@63 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_35290_35291| t@@13) i@@63) true)
 :qid |boogiebpl.5846:13|
 :skolemid |218|
))))
 :qid |boogiebpl.5844:45|
 :skolemid |219|
 :pattern ( (|$IsValid'$1_table_Table'u64_bool''| t@@13))
)))
(assert (forall ((t@@14 T@Table_36177_36178) ) (! (= (|$IsValid'$1_table_Table'u64_u64''| t@@14)  (and (|$IsValid'u64'| (|l#Table_36177_36178| t@@14)) (forall ((i@@64 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t@@14) i@@64) (|$IsValid'u64'| (|Select__T@[Int]Int_| (|v#Table_36177_36178| t@@14) i@@64)))
 :qid |boogiebpl.5964:13|
 :skolemid |224|
))))
 :qid |boogiebpl.5962:44|
 :skolemid |225|
 :pattern ( (|$IsValid'$1_table_Table'u64_u64''| t@@14))
)))
(assert (forall ((t@@15 T@Table_37064_126051) ) (! (= (|$IsValid'$1_table_Table'u64_vec'u64'''| t@@15)  (and (|$IsValid'u64'| (|l#Table_37064_126051| t@@15)) (forall ((i@@65 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_37064_126051| t@@15) i@@65) (|$IsValid'vec'u64''| (|Select__T@[Int]Vec_6673_| (|v#Table_37064_126051| t@@15) i@@65)))
 :qid |boogiebpl.6082:13|
 :skolemid |230|
))))
 :qid |boogiebpl.6080:49|
 :skolemid |231|
 :pattern ( (|$IsValid'$1_table_Table'u64_vec'u64'''| t@@15))
)))
(assert (forall ((t@@16 T@Table_36177_36178) ) (! (= (|$IsValid'$1_table_Table'address_address''| t@@16)  (and (|$IsValid'u64'| (|l#Table_36177_36178| t@@16)) (forall ((i@@66 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t@@16) i@@66) (|$IsValid'address'| (|Select__T@[Int]Int_| (|v#Table_36177_36178| t@@16) i@@66)))
 :qid |boogiebpl.6200:13|
 :skolemid |236|
))))
 :qid |boogiebpl.6198:52|
 :skolemid |237|
 :pattern ( (|$IsValid'$1_table_Table'address_address''| t@@16))
)))
(assert (forall ((|l#0@@27| Bool) (i@@67 Int) ) (! (= (|Select__T@[Int]Bool_| (|lambda#28| |l#0@@27|) i@@67) |l#0@@27|)
 :qid |boogiebpl.194:57|
 :skolemid |590|
 :pattern ( (|Select__T@[Int]Bool_| (|lambda#28| |l#0@@27|) i@@67))
)))
(assert (forall ((v@@36 Int) ) (! (= (|$IsValid'num'| v@@36) true)
 :qid |boogiebpl.1105:24|
 :skolemid |26|
 :pattern ( (|$IsValid'num'| v@@36))
)))
(assert (forall ((t@@17 T@$TypeParamInfo) ) (!  (=> (is-$TypeParamU8 t@@17) (|$IsEqual'vec'u8''| ($TypeName t@@17) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 56) 2)))
 :qid |boogiebpl.6523:15|
 :skolemid |247|
 :pattern ( ($TypeName t@@17))
)))
(assert (forall ((src1@@36 Int) (p@@6 Int) ) (! (= ($shlU128 src1@@36 p@@6) (mod (* src1@@36 ($pow 2 p@@6)) 340282366920938463463374607431768211456))
 :qid |boogiebpl.1511:19|
 :skolemid |38|
 :pattern ( ($shlU128 src1@@36 p@@6))
)))
(assert (forall ((n Int) (e@@6 Int) ) (! (= ($pow n e@@6) (ite  (and (not (= n 0)) (= e@@6 0)) 1 (ite (> e@@6 0) (* n ($pow n (- e@@6 1))) $undefined_int)))
 :qid |boogiebpl.1485:15|
 :skolemid |32|
 :pattern ( ($pow n e@@6))
)))
(assert (forall ((t@@18 T@$TypeParamInfo) ) (!  (=> (|$IsPrefix'vec'u8''| ($TypeName t@@18) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2)) (is-$TypeParamVector t@@18))
 :qid |boogiebpl.6542:15|
 :skolemid |266|
 :pattern ( ($TypeName t@@18))
)))
(assert (forall ((t@@19 T@$TypeParamInfo) ) (!  (=> (|$IsEqual'vec'u8''| ($TypeName t@@19) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 56) 2)) (is-$TypeParamU8 t@@19))
 :qid |boogiebpl.6524:15|
 :skolemid |248|
 :pattern ( ($TypeName t@@19))
)))
(assert (forall ((s@@15 |T@$1_option_Option'address'|) ) (! (= (|$IsValid'$1_option_Option'address''| s@@15) (|$IsValid'vec'address''| (|$vec#$1_option_Option'address'| s@@15)))
 :qid |boogiebpl.7025:46|
 :skolemid |384|
 :pattern ( (|$IsValid'$1_option_Option'address''| s@@15))
)))
(assert (forall ((s@@16 |T@$1_option_Option'$1_aggregator_Aggregator'|) ) (! (= (|$IsValid'$1_option_Option'$1_aggregator_Aggregator''| s@@16) (|$IsValid'vec'$1_aggregator_Aggregator''| (|$vec#$1_option_Option'$1_aggregator_Aggregator'| s@@16)))
 :qid |boogiebpl.7038:63|
 :skolemid |385|
 :pattern ( (|$IsValid'$1_option_Option'$1_aggregator_Aggregator''| s@@16))
)))
(assert (forall ((s@@17 |T@$1_option_Option'$1_optional_aggregator_Integer'|) ) (! (= (|$IsValid'$1_option_Option'$1_optional_aggregator_Integer''| s@@17) (|$IsValid'vec'$1_optional_aggregator_Integer''| (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| s@@17)))
 :qid |boogiebpl.7051:69|
 :skolemid |386|
 :pattern ( (|$IsValid'$1_option_Option'$1_optional_aggregator_Integer''| s@@17))
)))
(assert (forall ((s@@18 |T@$1_option_Option'$1_optional_aggregator_OptionalAggregator'|) ) (! (= (|$IsValid'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| s@@18) (|$IsValid'vec'$1_optional_aggregator_OptionalAggregator''| (|$vec#$1_option_Option'$1_optional_aggregator_OptionalAggregator'| s@@18)))
 :qid |boogiebpl.7064:80|
 :skolemid |387|
 :pattern ( (|$IsValid'$1_option_Option'$1_optional_aggregator_OptionalAggregator''| s@@18))
)))
(assert (forall ((s@@19 T@$1_string_String) ) (! (= (|$IsValid'$1_string_String'| s@@19) (|$IsValid'vec'u8''| (|$bytes#$1_string_String| s@@19)))
 :qid |boogiebpl.7077:37|
 :skolemid |388|
 :pattern ( (|$IsValid'$1_string_String'| s@@19))
)))
(assert (forall ((s@@20 T@$1_guid_GUID) ) (! (= (|$IsValid'$1_guid_GUID'| s@@20) (|$IsValid'$1_guid_ID'| (|$id#$1_guid_GUID| s@@20)))
 :qid |boogiebpl.7437:33|
 :skolemid |392|
 :pattern ( (|$IsValid'$1_guid_GUID'| s@@20))
)))
(assert (forall ((s@@21 |T@$1_account_CapabilityOffer'$1_account_RotationCapability'|) ) (! (= (|$IsValid'$1_account_CapabilityOffer'$1_account_RotationCapability''| s@@21) (|$IsValid'$1_option_Option'address''| (|$for#$1_account_CapabilityOffer'$1_account_RotationCapability'| s@@21)))
 :qid |boogiebpl.8507:78|
 :skolemid |512|
 :pattern ( (|$IsValid'$1_account_CapabilityOffer'$1_account_RotationCapability''| s@@21))
)))
(assert (forall ((s@@22 |T@$1_account_CapabilityOffer'$1_account_SignerCapability'|) ) (! (= (|$IsValid'$1_account_CapabilityOffer'$1_account_SignerCapability''| s@@22) (|$IsValid'$1_option_Option'address''| (|$for#$1_account_CapabilityOffer'$1_account_SignerCapability'| s@@22)))
 :qid |boogiebpl.8520:76|
 :skolemid |513|
 :pattern ( (|$IsValid'$1_account_CapabilityOffer'$1_account_SignerCapability''| s@@22))
)))
(assert (forall ((s@@23 T@$1_account_CoinRegisterEvent) ) (! (= (|$IsValid'$1_account_CoinRegisterEvent'| s@@23) (|$IsValid'$1_type_info_TypeInfo'| (|$type_info#$1_account_CoinRegisterEvent| s@@23)))
 :qid |boogiebpl.8533:49|
 :skolemid |514|
 :pattern ( (|$IsValid'$1_account_CoinRegisterEvent'| s@@23))
)))
(assert (forall ((s@@24 T@$1_account_RotationCapability) ) (! (= (|$IsValid'$1_account_RotationCapability'| s@@24) (|$IsValid'address'| (|$account#$1_account_RotationCapability| s@@24)))
 :qid |boogiebpl.8564:50|
 :skolemid |516|
 :pattern ( (|$IsValid'$1_account_RotationCapability'| s@@24))
)))
(assert (forall ((s@@25 T@$1_account_SignerCapability) ) (! (= (|$IsValid'$1_account_SignerCapability'| s@@25) (|$IsValid'address'| (|$account#$1_account_SignerCapability| s@@25)))
 :qid |boogiebpl.8578:48|
 :skolemid |517|
 :pattern ( (|$IsValid'$1_account_SignerCapability'| s@@25))
)))
(assert (forall ((s@@26 |T@$1_coin_Coin'$1_aptos_coin_AptosCoin'|) ) (! (= (|$IsValid'$1_coin_Coin'$1_aptos_coin_AptosCoin''| s@@26) (|$IsValid'u64'| (|$value#$1_coin_Coin'$1_aptos_coin_AptosCoin'| s@@26)))
 :qid |boogiebpl.10007:58|
 :skolemid |518|
 :pattern ( (|$IsValid'$1_coin_Coin'$1_aptos_coin_AptosCoin''| s@@26))
)))
(assert (forall ((s@@27 |T@$1_coin_Coin'#0'|) ) (! (= (|$IsValid'$1_coin_Coin'#0''| s@@27) (|$IsValid'u64'| (|$value#$1_coin_Coin'#0'| s@@27)))
 :qid |boogiebpl.10021:37|
 :skolemid |519|
 :pattern ( (|$IsValid'$1_coin_Coin'#0''| s@@27))
)))
(assert (forall ((s@@28 T@$1_coin_DepositEvent) ) (! (= (|$IsValid'$1_coin_DepositEvent'| s@@28) (|$IsValid'u64'| (|$amount#$1_coin_DepositEvent| s@@28)))
 :qid |boogiebpl.10147:41|
 :skolemid |524|
 :pattern ( (|$IsValid'$1_coin_DepositEvent'| s@@28))
)))
(assert (forall ((s@@29 T@$1_coin_WithdrawEvent) ) (! (= (|$IsValid'$1_coin_WithdrawEvent'| s@@29) (|$IsValid'u64'| (|$amount#$1_coin_WithdrawEvent| s@@29)))
 :qid |boogiebpl.10161:42|
 :skolemid |525|
 :pattern ( (|$IsValid'$1_coin_WithdrawEvent'| s@@29))
)))
(assert (forall ((s@@30 |T@$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'|) ) (! (= (|$IsValid'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''| s@@30) (|$IsValid'num'| (|$v#$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'| s@@30)))
 :qid |boogiebpl.10175:66|
 :skolemid |526|
 :pattern ( (|$IsValid'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''| s@@30))
)))
(assert (forall ((s@@31 |T@$1_coin_Ghost$supply'#0'|) ) (! (= (|$IsValid'$1_coin_Ghost$supply'#0''| s@@31) (|$IsValid'num'| (|$v#$1_coin_Ghost$supply'#0'| s@@31)))
 :qid |boogiebpl.10190:45|
 :skolemid |527|
 :pattern ( (|$IsValid'$1_coin_Ghost$supply'#0''| s@@31))
)))
(assert (forall ((s@@32 |T@$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'|) ) (! (= (|$IsValid'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''| s@@32) (|$IsValid'num'| (|$v#$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'| s@@32)))
 :qid |boogiebpl.10205:76|
 :skolemid |528|
 :pattern ( (|$IsValid'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''| s@@32))
)))
(assert (forall ((s@@33 |T@$1_coin_Ghost$aggregate_supply'#0'|) ) (! (= (|$IsValid'$1_coin_Ghost$aggregate_supply'#0''| s@@33) (|$IsValid'num'| (|$v#$1_coin_Ghost$aggregate_supply'#0'| s@@33)))
 :qid |boogiebpl.10220:55|
 :skolemid |529|
 :pattern ( (|$IsValid'$1_coin_Ghost$aggregate_supply'#0''| s@@33))
)))
(assert (forall ((s@@34 T@$1_aptos_coin_AptosCoin) ) (! (= (|$IsValid'$1_aptos_coin_AptosCoin'| s@@34) true)
 :qid |boogiebpl.11481:44|
 :skolemid |530|
 :pattern ( (|$IsValid'$1_aptos_coin_AptosCoin'| s@@34))
)))
(assert (forall ((s@@35 T@$1_Bbay_ResourceAccountSignerCap) ) (! (= (|$IsValid'$1_Bbay_ResourceAccountSignerCap'| s@@35) (|$IsValid'$1_account_SignerCapability'| (|$signer_cap#$1_Bbay_ResourceAccountSignerCap| s@@35)))
 :qid |boogiebpl.11562:53|
 :skolemid |533|
 :pattern ( (|$IsValid'$1_Bbay_ResourceAccountSignerCap'| s@@35))
)))
(assert (forall ((src1@@37 (_ BitVec 16)) (src2@@29 (_ BitVec 8)) ) (! (= ($shlBv16From8 src1@@37 src2@@29) (bvshl src1@@37 (concat #x00 src2@@29)))
 :qid |boogiebpl.1769:24|
 :skolemid |53|
 :pattern ( ($shlBv16From8 src1@@37 src2@@29))
)))
(assert (forall ((src1@@38 (_ BitVec 16)) (src2@@30 (_ BitVec 8)) ) (! (= ($shrBv16From8 src1@@38 src2@@30) (bvlshr src1@@38 (concat #x00 src2@@30)))
 :qid |boogiebpl.1783:24|
 :skolemid |54|
 :pattern ( ($shrBv16From8 src1@@38 src2@@30))
)))
(assert (forall ((src1@@39 (_ BitVec 32)) (src2@@31 (_ BitVec 16)) ) (! (= ($shlBv32From16 src1@@39 src2@@31) (bvshl src1@@39 (concat #x0000 src2@@31)))
 :qid |boogiebpl.2023:25|
 :skolemid |67|
 :pattern ( ($shlBv32From16 src1@@39 src2@@31))
)))
(assert (forall ((src1@@40 (_ BitVec 32)) (src2@@32 (_ BitVec 16)) ) (! (= ($shrBv32From16 src1@@40 src2@@32) (bvlshr src1@@40 (concat #x0000 src2@@32)))
 :qid |boogiebpl.2037:25|
 :skolemid |68|
 :pattern ( ($shrBv32From16 src1@@40 src2@@32))
)))
(assert (forall ((src1@@41 (_ BitVec 32)) (src2@@33 (_ BitVec 8)) ) (! (= ($shlBv32From8 src1@@41 src2@@33) (bvshl src1@@41 (concat #x000000 src2@@33)))
 :qid |boogiebpl.1989:24|
 :skolemid |65|
 :pattern ( ($shlBv32From8 src1@@41 src2@@33))
)))
(assert (forall ((src1@@42 (_ BitVec 32)) (src2@@34 (_ BitVec 8)) ) (! (= ($shrBv32From8 src1@@42 src2@@34) (bvlshr src1@@42 (concat #x000000 src2@@34)))
 :qid |boogiebpl.2003:24|
 :skolemid |66|
 :pattern ( ($shrBv32From8 src1@@42 src2@@34))
)))
(assert (forall ((src1@@43 (_ BitVec 64)) (src2@@35 (_ BitVec 32)) ) (! (= ($shlBv64From32 src1@@43 src2@@35) (bvshl src1@@43 (concat #x00000000 src2@@35)))
 :qid |boogiebpl.2273:25|
 :skolemid |81|
 :pattern ( ($shlBv64From32 src1@@43 src2@@35))
)))
(assert (forall ((src1@@44 (_ BitVec 64)) (src2@@36 (_ BitVec 32)) ) (! (= ($shrBv64From32 src1@@44 src2@@36) (bvlshr src1@@44 (concat #x00000000 src2@@36)))
 :qid |boogiebpl.2287:25|
 :skolemid |82|
 :pattern ( ($shrBv64From32 src1@@44 src2@@36))
)))
(assert (forall ((src1@@45 (_ BitVec 64)) (src2@@37 (_ BitVec 16)) ) (! (= ($shlBv64From16 src1@@45 src2@@37) (bvshl src1@@45 (concat #x000000000000 src2@@37)))
 :qid |boogiebpl.2239:25|
 :skolemid |79|
 :pattern ( ($shlBv64From16 src1@@45 src2@@37))
)))
(assert (forall ((src1@@46 (_ BitVec 64)) (src2@@38 (_ BitVec 16)) ) (! (= ($shrBv64From16 src1@@46 src2@@38) (bvlshr src1@@46 (concat #x000000000000 src2@@38)))
 :qid |boogiebpl.2253:25|
 :skolemid |80|
 :pattern ( ($shrBv64From16 src1@@46 src2@@38))
)))
(assert (forall ((src1@@47 (_ BitVec 64)) (src2@@39 (_ BitVec 8)) ) (! (= ($shlBv64From8 src1@@47 src2@@39) (bvshl src1@@47 (concat #x00000000000000 src2@@39)))
 :qid |boogiebpl.2205:24|
 :skolemid |77|
 :pattern ( ($shlBv64From8 src1@@47 src2@@39))
)))
(assert (forall ((src1@@48 (_ BitVec 64)) (src2@@40 (_ BitVec 8)) ) (! (= ($shrBv64From8 src1@@48 src2@@40) (bvlshr src1@@48 (concat #x00000000000000 src2@@40)))
 :qid |boogiebpl.2219:24|
 :skolemid |78|
 :pattern ( ($shrBv64From8 src1@@48 src2@@40))
)))
(assert (forall ((src1@@49 (_ BitVec 128)) (src2@@41 (_ BitVec 64)) ) (! (= ($shlBv128From64 src1@@49 src2@@41) (bvshl src1@@49 (concat #x0000000000000000 src2@@41)))
 :qid |boogiebpl.2519:26|
 :skolemid |95|
 :pattern ( ($shlBv128From64 src1@@49 src2@@41))
)))
(assert (forall ((src1@@50 (_ BitVec 128)) (src2@@42 (_ BitVec 64)) ) (! (= ($shrBv128From64 src1@@50 src2@@42) (bvlshr src1@@50 (concat #x0000000000000000 src2@@42)))
 :qid |boogiebpl.2533:26|
 :skolemid |96|
 :pattern ( ($shrBv128From64 src1@@50 src2@@42))
)))
(assert (forall ((src1@@51 (_ BitVec 128)) (src2@@43 (_ BitVec 32)) ) (! (= ($shlBv128From32 src1@@51 src2@@43) (bvshl src1@@51 (concat #x000000000000000000000000 src2@@43)))
 :qid |boogiebpl.2485:26|
 :skolemid |93|
 :pattern ( ($shlBv128From32 src1@@51 src2@@43))
)))
(assert (forall ((src1@@52 (_ BitVec 128)) (src2@@44 (_ BitVec 32)) ) (! (= ($shrBv128From32 src1@@52 src2@@44) (bvlshr src1@@52 (concat #x000000000000000000000000 src2@@44)))
 :qid |boogiebpl.2499:26|
 :skolemid |94|
 :pattern ( ($shrBv128From32 src1@@52 src2@@44))
)))
(assert (forall ((src1@@53 (_ BitVec 128)) (src2@@45 (_ BitVec 16)) ) (! (= ($shlBv128From16 src1@@53 src2@@45) (bvshl src1@@53 (concat #x0000000000000000000000000000 src2@@45)))
 :qid |boogiebpl.2451:26|
 :skolemid |91|
 :pattern ( ($shlBv128From16 src1@@53 src2@@45))
)))
(assert (forall ((src1@@54 (_ BitVec 128)) (src2@@46 (_ BitVec 16)) ) (! (= ($shrBv128From16 src1@@54 src2@@46) (bvlshr src1@@54 (concat #x0000000000000000000000000000 src2@@46)))
 :qid |boogiebpl.2465:26|
 :skolemid |92|
 :pattern ( ($shrBv128From16 src1@@54 src2@@46))
)))
(assert (forall ((src1@@55 (_ BitVec 128)) (src2@@47 (_ BitVec 8)) ) (! (= ($shlBv128From8 src1@@55 src2@@47) (bvshl src1@@55 (concat #x000000000000000000000000000000 src2@@47)))
 :qid |boogiebpl.2417:25|
 :skolemid |89|
 :pattern ( ($shlBv128From8 src1@@55 src2@@47))
)))
(assert (forall ((src1@@56 (_ BitVec 128)) (src2@@48 (_ BitVec 8)) ) (! (= ($shrBv128From8 src1@@56 src2@@48) (bvlshr src1@@56 (concat #x000000000000000000000000000000 src2@@48)))
 :qid |boogiebpl.2431:25|
 :skolemid |90|
 :pattern ( ($shrBv128From8 src1@@56 src2@@48))
)))
(assert (forall ((src1@@57 (_ BitVec 256)) (src2@@49 (_ BitVec 128)) ) (! (= ($shlBv256From128 src1@@57 src2@@49) (bvshl src1@@57 (concat #x00000000000000000000000000000000 src2@@49)))
 :qid |boogiebpl.2761:27|
 :skolemid |109|
 :pattern ( ($shlBv256From128 src1@@57 src2@@49))
)))
(assert (forall ((src1@@58 (_ BitVec 256)) (src2@@50 (_ BitVec 128)) ) (! (= ($shrBv256From128 src1@@58 src2@@50) (bvlshr src1@@58 (concat #x00000000000000000000000000000000 src2@@50)))
 :qid |boogiebpl.2775:27|
 :skolemid |110|
 :pattern ( ($shrBv256From128 src1@@58 src2@@50))
)))
(assert (forall ((src1@@59 (_ BitVec 256)) (src2@@51 (_ BitVec 64)) ) (! (= ($shlBv256From64 src1@@59 src2@@51) (bvshl src1@@59 (concat #x000000000000000000000000000000000000000000000000 src2@@51)))
 :qid |boogiebpl.2727:26|
 :skolemid |107|
 :pattern ( ($shlBv256From64 src1@@59 src2@@51))
)))
(assert (forall ((src1@@60 (_ BitVec 256)) (src2@@52 (_ BitVec 64)) ) (! (= ($shrBv256From64 src1@@60 src2@@52) (bvlshr src1@@60 (concat #x000000000000000000000000000000000000000000000000 src2@@52)))
 :qid |boogiebpl.2741:26|
 :skolemid |108|
 :pattern ( ($shrBv256From64 src1@@60 src2@@52))
)))
(assert (forall ((src1@@61 (_ BitVec 256)) (src2@@53 (_ BitVec 32)) ) (! (= ($shlBv256From32 src1@@61 src2@@53) (bvshl src1@@61 (concat #x00000000000000000000000000000000000000000000000000000000 src2@@53)))
 :qid |boogiebpl.2693:26|
 :skolemid |105|
 :pattern ( ($shlBv256From32 src1@@61 src2@@53))
)))
(assert (forall ((src1@@62 (_ BitVec 256)) (src2@@54 (_ BitVec 32)) ) (! (= ($shrBv256From32 src1@@62 src2@@54) (bvlshr src1@@62 (concat #x00000000000000000000000000000000000000000000000000000000 src2@@54)))
 :qid |boogiebpl.2707:26|
 :skolemid |106|
 :pattern ( ($shrBv256From32 src1@@62 src2@@54))
)))
(assert (forall ((src1@@63 (_ BitVec 256)) (src2@@55 (_ BitVec 16)) ) (! (= ($shlBv256From16 src1@@63 src2@@55) (bvshl src1@@63 (concat #x000000000000000000000000000000000000000000000000000000000000 src2@@55)))
 :qid |boogiebpl.2659:26|
 :skolemid |103|
 :pattern ( ($shlBv256From16 src1@@63 src2@@55))
)))
(assert (forall ((src1@@64 (_ BitVec 256)) (src2@@56 (_ BitVec 16)) ) (! (= ($shrBv256From16 src1@@64 src2@@56) (bvlshr src1@@64 (concat #x000000000000000000000000000000000000000000000000000000000000 src2@@56)))
 :qid |boogiebpl.2673:26|
 :skolemid |104|
 :pattern ( ($shrBv256From16 src1@@64 src2@@56))
)))
(assert (forall ((src1@@65 (_ BitVec 256)) (src2@@57 (_ BitVec 8)) ) (! (= ($shlBv256From8 src1@@65 src2@@57) (bvshl src1@@65 (concat #x00000000000000000000000000000000000000000000000000000000000000 src2@@57)))
 :qid |boogiebpl.2625:25|
 :skolemid |101|
 :pattern ( ($shlBv256From8 src1@@65 src2@@57))
)))
(assert (forall ((src1@@66 (_ BitVec 256)) (src2@@58 (_ BitVec 8)) ) (! (= ($shrBv256From8 src1@@66 src2@@58) (bvlshr src1@@66 (concat #x00000000000000000000000000000000000000000000000000000000000000 src2@@58)))
 :qid |boogiebpl.2639:25|
 :skolemid |102|
 :pattern ( ($shrBv256From8 src1@@66 src2@@58))
)))
(assert (forall ((t@@20 T@$TypeParamInfo) ) (!  (=> (is-$TypeParamU16 t@@20) (|$IsEqual'vec'u8''| ($TypeName t@@20) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 49) 2 54) 3)))
 :qid |boogiebpl.6525:15|
 :skolemid |249|
 :pattern ( ($TypeName t@@20))
)))
(assert (forall ((t@@21 T@$TypeParamInfo) ) (!  (=> (is-$TypeParamU32 t@@21) (|$IsEqual'vec'u8''| ($TypeName t@@21) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 51) 2 50) 3)))
 :qid |boogiebpl.6527:15|
 :skolemid |251|
 :pattern ( ($TypeName t@@21))
)))
(assert (forall ((t@@22 T@$TypeParamInfo) ) (!  (=> (is-$TypeParamU64 t@@22) (|$IsEqual'vec'u8''| ($TypeName t@@22) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 54) 2 52) 3)))
 :qid |boogiebpl.6529:15|
 :skolemid |253|
 :pattern ( ($TypeName t@@22))
)))
(assert (forall ((t@@23 T@$TypeParamInfo) ) (!  (=> (|$IsEqual'vec'u8''| ($TypeName t@@23) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 49) 2 50) 3 56) 4)) (is-$TypeParamU128 t@@23))
 :qid |boogiebpl.6532:15|
 :skolemid |256|
 :pattern ( ($TypeName t@@23))
)))
(assert (forall ((agg T@$1_aggregator_Aggregator) (val Int) ) (! (= ($1_aggregator_spec_aggregator_set_val agg val) ($1_aggregator_Aggregator (|$handle#$1_aggregator_Aggregator| agg) (|$key#$1_aggregator_Aggregator| agg) (|$limit#$1_aggregator_Aggregator| agg) val))
 :qid |boogiebpl.286:48|
 :skolemid |10|
 :pattern ( ($1_aggregator_spec_aggregator_set_val agg val))
)))
(assert (forall ((src1@@67 (_ BitVec 8)) (src2@@59 (_ BitVec 8)) ) (! (= ($shlBv8From8 src1@@67 src2@@59) (bvshl src1@@67 src2@@59))
 :qid |boogiebpl.1545:23|
 :skolemid |41|
 :pattern ( ($shlBv8From8 src1@@67 src2@@59))
)))
(assert (forall ((src1@@68 (_ BitVec 8)) (src2@@60 (_ BitVec 8)) ) (! (= ($shrBv8From8 src1@@68 src2@@60) (bvlshr src1@@68 src2@@60))
 :qid |boogiebpl.1559:23|
 :skolemid |42|
 :pattern ( ($shrBv8From8 src1@@68 src2@@60))
)))
(assert (forall ((src1@@69 (_ BitVec 16)) (src2@@61 (_ BitVec 16)) ) (! (= ($shlBv16From16 src1@@69 src2@@61) (bvshl src1@@69 src2@@61))
 :qid |boogiebpl.1803:25|
 :skolemid |55|
 :pattern ( ($shlBv16From16 src1@@69 src2@@61))
)))
(assert (forall ((src1@@70 (_ BitVec 16)) (src2@@62 (_ BitVec 16)) ) (! (= ($shrBv16From16 src1@@70 src2@@62) (bvlshr src1@@70 src2@@62))
 :qid |boogiebpl.1817:25|
 :skolemid |56|
 :pattern ( ($shrBv16From16 src1@@70 src2@@62))
)))
(assert (forall ((src1@@71 (_ BitVec 32)) (src2@@63 (_ BitVec 32)) ) (! (= ($shlBv32From32 src1@@71 src2@@63) (bvshl src1@@71 src2@@63))
 :qid |boogiebpl.2057:25|
 :skolemid |69|
 :pattern ( ($shlBv32From32 src1@@71 src2@@63))
)))
(assert (forall ((src1@@72 (_ BitVec 32)) (src2@@64 (_ BitVec 32)) ) (! (= ($shrBv32From32 src1@@72 src2@@64) (bvlshr src1@@72 src2@@64))
 :qid |boogiebpl.2071:25|
 :skolemid |70|
 :pattern ( ($shrBv32From32 src1@@72 src2@@64))
)))
(assert (forall ((src1@@73 (_ BitVec 64)) (src2@@65 (_ BitVec 64)) ) (! (= ($shlBv64From64 src1@@73 src2@@65) (bvshl src1@@73 src2@@65))
 :qid |boogiebpl.2307:25|
 :skolemid |83|
 :pattern ( ($shlBv64From64 src1@@73 src2@@65))
)))
(assert (forall ((src1@@74 (_ BitVec 64)) (src2@@66 (_ BitVec 64)) ) (! (= ($shrBv64From64 src1@@74 src2@@66) (bvlshr src1@@74 src2@@66))
 :qid |boogiebpl.2321:25|
 :skolemid |84|
 :pattern ( ($shrBv64From64 src1@@74 src2@@66))
)))
(assert (forall ((src1@@75 (_ BitVec 128)) (src2@@67 (_ BitVec 128)) ) (! (= ($shlBv128From128 src1@@75 src2@@67) (bvshl src1@@75 src2@@67))
 :qid |boogiebpl.2553:27|
 :skolemid |97|
 :pattern ( ($shlBv128From128 src1@@75 src2@@67))
)))
(assert (forall ((src1@@76 (_ BitVec 128)) (src2@@68 (_ BitVec 128)) ) (! (= ($shrBv128From128 src1@@76 src2@@68) (bvlshr src1@@76 src2@@68))
 :qid |boogiebpl.2567:27|
 :skolemid |98|
 :pattern ( ($shrBv128From128 src1@@76 src2@@68))
)))
(assert (forall ((src1@@77 (_ BitVec 256)) (src2@@69 (_ BitVec 256)) ) (! (= ($shlBv256From256 src1@@77 src2@@69) (bvshl src1@@77 src2@@69))
 :qid |boogiebpl.2795:27|
 :skolemid |111|
 :pattern ( ($shlBv256From256 src1@@77 src2@@69))
)))
(assert (forall ((src1@@78 (_ BitVec 256)) (src2@@70 (_ BitVec 256)) ) (! (= ($shrBv256From256 src1@@78 src2@@70) (bvlshr src1@@78 src2@@70))
 :qid |boogiebpl.2809:27|
 :skolemid |112|
 :pattern ( ($shrBv256From256 src1@@78 src2@@70))
)))
(assert (forall ((k1@@2 T@Vec_6673) (k2@@2 T@Vec_6673) ) (!  (=> (|$IsEqual'vec'u8''| k1@@2 k2@@2) (= ($1_Signature_$ed25519_validate_pubkey k1@@2) ($1_Signature_$ed25519_validate_pubkey k2@@2)))
 :qid |boogiebpl.6435:15|
 :skolemid |240|
 :pattern ( ($1_Signature_$ed25519_validate_pubkey k1@@2) ($1_Signature_$ed25519_validate_pubkey k2@@2))
)))
(assert (forall ((v@@37 (_ BitVec 8)) ) (! (= (|$IsValid'bv8'| v@@37)  (and (bvuge v@@37 #x00) (bvule v@@37 #xff)))
 :qid |boogiebpl.423:24|
 :skolemid |14|
 :pattern ( (|$IsValid'bv8'| v@@37))
)))
(assert (forall ((v@@38 (_ BitVec 64)) ) (! (= (|$IsValid'bv64'| v@@38)  (and (bvuge v@@38 #x0000000000000000) (bvule v@@38 #xffffffffffffffff)))
 :qid |boogiebpl.798:25|
 :skolemid |17|
 :pattern ( (|$IsValid'bv64'| v@@38))
)))
(assert (forall ((v@@39 (_ BitVec 16)) ) (! (= (|$IsValid'bv16'| v@@39)  (and (bvuge v@@39 #x0000) (bvule v@@39 #xffff)))
 :qid |boogiebpl.548:25|
 :skolemid |15|
 :pattern ( (|$IsValid'bv16'| v@@39))
)))
(assert (forall ((v@@40 (_ BitVec 256)) ) (! (= (|$IsValid'bv256'| v@@40)  (and (bvuge v@@40 #x0000000000000000000000000000000000000000000000000000000000000000) (bvule v@@40 #xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)))
 :qid |boogiebpl.1048:26|
 :skolemid |19|
 :pattern ( (|$IsValid'bv256'| v@@40))
)))
(assert (forall ((v@@41 T@Vec_85428) (e@@7 |T@#0|) ) (! (let ((i@@68 (|$IndexOfVec'#0'| v@@41 e@@7)))
(ite  (not (exists ((i@@69 Int) ) (!  (and (and (|$IsValid'u64'| i@@69) (InRangeVec_65852 v@@41 i@@69)) (= (|Select__T@[Int]#0_| (|v#Vec_85428| v@@41) i@@69) e@@7))
 :qid |boogiebpl.3103:13|
 :skolemid |121|
))) (= i@@68 (- 0 1))  (and (and (and (|$IsValid'u64'| i@@68) (InRangeVec_65852 v@@41 i@@68)) (= (|Select__T@[Int]#0_| (|v#Vec_85428| v@@41) i@@68) e@@7)) (forall ((j@@13 Int) ) (!  (=> (and (and (|$IsValid'u64'| j@@13) (>= j@@13 0)) (< j@@13 i@@68)) (not (= (|Select__T@[Int]#0_| (|v#Vec_85428| v@@41) j@@13) e@@7)))
 :qid |boogiebpl.3111:17|
 :skolemid |122|
)))))
 :qid |boogiebpl.3107:15|
 :skolemid |123|
 :pattern ( (|$IndexOfVec'#0'| v@@41 e@@7))
)))
(assert (forall ((v@@42 T@Vec_90390) (e@@8 T@$1_aggregator_Aggregator) ) (! (let ((i@@70 (|$IndexOfVec'$1_aggregator_Aggregator'| v@@42 e@@8)))
(ite  (not (exists ((i@@71 Int) ) (!  (and (and (|$IsValid'u64'| i@@71) (InRangeVec_66199 v@@42 i@@71)) (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| v@@42) i@@71) e@@8))
 :qid |boogiebpl.3407:13|
 :skolemid |132|
))) (= i@@70 (- 0 1))  (and (and (and (|$IsValid'u64'| i@@70) (InRangeVec_66199 v@@42 i@@70)) (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| v@@42) i@@70) e@@8)) (forall ((j@@14 Int) ) (!  (=> (and (and (|$IsValid'u64'| j@@14) (>= j@@14 0)) (< j@@14 i@@70)) (not (= (|Select__T@[Int]$1_aggregator_Aggregator_| (|v#Vec_90390| v@@42) j@@14) e@@8)))
 :qid |boogiebpl.3415:17|
 :skolemid |133|
)))))
 :qid |boogiebpl.3411:15|
 :skolemid |134|
 :pattern ( (|$IndexOfVec'$1_aggregator_Aggregator'| v@@42 e@@8))
)))
(assert (forall ((v@@43 T@Vec_95276) (e@@9 T@$1_optional_aggregator_Integer) ) (! (let ((i@@72 (|$IndexOfVec'$1_optional_aggregator_Integer'| v@@43 e@@9)))
(ite  (not (exists ((i@@73 Int) ) (!  (and (and (|$IsValid'u64'| i@@73) (InRangeVec_66546 v@@43 i@@73)) (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| v@@43) i@@73) e@@9))
 :qid |boogiebpl.3711:13|
 :skolemid |143|
))) (= i@@72 (- 0 1))  (and (and (and (|$IsValid'u64'| i@@72) (InRangeVec_66546 v@@43 i@@72)) (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| v@@43) i@@72) e@@9)) (forall ((j@@15 Int) ) (!  (=> (and (and (|$IsValid'u64'| j@@15) (>= j@@15 0)) (< j@@15 i@@72)) (not (= (|Select__T@[Int]$1_optional_aggregator_Integer_| (|v#Vec_95276| v@@43) j@@15) e@@9)))
 :qid |boogiebpl.3719:17|
 :skolemid |144|
)))))
 :qid |boogiebpl.3715:15|
 :skolemid |145|
 :pattern ( (|$IndexOfVec'$1_optional_aggregator_Integer'| v@@43 e@@9))
)))
(assert (forall ((v@@44 T@Vec_100175) (e@@10 T@$1_optional_aggregator_OptionalAggregator) ) (! (let ((i@@74 (|$IndexOfVec'$1_optional_aggregator_OptionalAggregator'| v@@44 e@@10)))
(ite  (not (exists ((i@@75 Int) ) (!  (and (and (|$IsValid'u64'| i@@75) (InRangeVec_66893 v@@44 i@@75)) (and (|$IsEqual'vec'$1_aggregator_Aggregator''| (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@44) i@@75))) (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| e@@10))) (|$IsEqual'vec'$1_optional_aggregator_Integer''| (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@44) i@@75))) (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| e@@10)))))
 :qid |boogiebpl.4015:13|
 :skolemid |154|
))) (= i@@74 (- 0 1))  (and (and (and (|$IsValid'u64'| i@@74) (InRangeVec_66893 v@@44 i@@74)) (and (|$IsEqual'vec'$1_aggregator_Aggregator''| (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@44) i@@74))) (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| e@@10))) (|$IsEqual'vec'$1_optional_aggregator_Integer''| (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@44) i@@74))) (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| e@@10))))) (forall ((j@@16 Int) ) (!  (=> (and (and (|$IsValid'u64'| j@@16) (>= j@@16 0)) (< j@@16 i@@74)) (not (and (|$IsEqual'vec'$1_aggregator_Aggregator''| (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@44) j@@16))) (|$vec#$1_option_Option'$1_aggregator_Aggregator'| (|$aggregator#$1_optional_aggregator_OptionalAggregator| e@@10))) (|$IsEqual'vec'$1_optional_aggregator_Integer''| (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| (|Select__T@[Int]$1_optional_aggregator_OptionalAggregator_| (|v#Vec_100175| v@@44) j@@16))) (|$vec#$1_option_Option'$1_optional_aggregator_Integer'| (|$integer#$1_optional_aggregator_OptionalAggregator| e@@10))))))
 :qid |boogiebpl.4023:17|
 :skolemid |155|
)))))
 :qid |boogiebpl.4019:15|
 :skolemid |156|
 :pattern ( (|$IndexOfVec'$1_optional_aggregator_OptionalAggregator'| v@@44 e@@10))
)))
(assert (forall ((v@@45 T@Vec_6673) (e@@11 Int) ) (! (let ((i@@76 (|$IndexOfVec'address'| v@@45 e@@11)))
(ite  (not (exists ((i@@77 Int) ) (!  (and (and (|$IsValid'u64'| i@@77) (InRangeVec_25002 v@@45 i@@77)) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@45) i@@77) e@@11))
 :qid |boogiebpl.4319:13|
 :skolemid |165|
))) (= i@@76 (- 0 1))  (and (and (and (|$IsValid'u64'| i@@76) (InRangeVec_25002 v@@45 i@@76)) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@45) i@@76) e@@11)) (forall ((j@@17 Int) ) (!  (=> (and (and (|$IsValid'u64'| j@@17) (>= j@@17 0)) (< j@@17 i@@76)) (not (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@45) j@@17) e@@11)))
 :qid |boogiebpl.4327:17|
 :skolemid |166|
)))))
 :qid |boogiebpl.4323:15|
 :skolemid |167|
 :pattern ( (|$IndexOfVec'address'| v@@45 e@@11))
)))
(assert (forall ((v@@46 T@Vec_6673) (e@@12 Int) ) (! (let ((i@@78 (|$IndexOfVec'u64'| v@@46 e@@12)))
(ite  (not (exists ((i@@79 Int) ) (!  (and (and (|$IsValid'u64'| i@@79) (InRangeVec_25002 v@@46 i@@79)) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@46) i@@79) e@@12))
 :qid |boogiebpl.4623:13|
 :skolemid |176|
))) (= i@@78 (- 0 1))  (and (and (and (|$IsValid'u64'| i@@78) (InRangeVec_25002 v@@46 i@@78)) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@46) i@@78) e@@12)) (forall ((j@@18 Int) ) (!  (=> (and (and (|$IsValid'u64'| j@@18) (>= j@@18 0)) (< j@@18 i@@78)) (not (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@46) j@@18) e@@12)))
 :qid |boogiebpl.4631:17|
 :skolemid |177|
)))))
 :qid |boogiebpl.4627:15|
 :skolemid |178|
 :pattern ( (|$IndexOfVec'u64'| v@@46 e@@12))
)))
(assert (forall ((v@@47 T@Vec_6673) (e@@13 Int) ) (! (let ((i@@80 (|$IndexOfVec'u8'| v@@47 e@@13)))
(ite  (not (exists ((i@@81 Int) ) (!  (and (and (|$IsValid'u64'| i@@81) (InRangeVec_25002 v@@47 i@@81)) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@47) i@@81) e@@13))
 :qid |boogiebpl.4927:13|
 :skolemid |187|
))) (= i@@80 (- 0 1))  (and (and (and (|$IsValid'u64'| i@@80) (InRangeVec_25002 v@@47 i@@80)) (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@47) i@@80) e@@13)) (forall ((j@@19 Int) ) (!  (=> (and (and (|$IsValid'u64'| j@@19) (>= j@@19 0)) (< j@@19 i@@80)) (not (= (|Select__T@[Int]Int_| (|v#Vec_6673| v@@47) j@@19) e@@13)))
 :qid |boogiebpl.4935:17|
 :skolemid |188|
)))))
 :qid |boogiebpl.4931:15|
 :skolemid |189|
 :pattern ( (|$IndexOfVec'u8'| v@@47 e@@13))
)))
(assert (forall ((v@@48 T@Vec_67815) (e@@14 (_ BitVec 64)) ) (! (let ((i@@82 (|$IndexOfVec'bv64'| v@@48 e@@14)))
(ite  (not (exists ((i@@83 Int) ) (!  (and (and (|$IsValid'u64'| i@@83) (InRangeVec_67819 v@@48 i@@83)) (= (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| v@@48) i@@83) e@@14))
 :qid |boogiebpl.5231:13|
 :skolemid |198|
))) (= i@@82 (- 0 1))  (and (and (and (|$IsValid'u64'| i@@82) (InRangeVec_67819 v@@48 i@@82)) (= (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| v@@48) i@@82) e@@14)) (forall ((j@@20 Int) ) (!  (=> (and (and (|$IsValid'u64'| j@@20) (>= j@@20 0)) (< j@@20 i@@82)) (not (= (|Select__T@[Int](_ BitVec 64)_| (|v#Vec_67815| v@@48) j@@20) e@@14)))
 :qid |boogiebpl.5239:17|
 :skolemid |199|
)))))
 :qid |boogiebpl.5235:15|
 :skolemid |200|
 :pattern ( (|$IndexOfVec'bv64'| v@@48 e@@14))
)))
(assert (forall ((v@@49 T@Vec_68162) (e@@15 (_ BitVec 8)) ) (! (let ((i@@84 (|$IndexOfVec'bv8'| v@@49 e@@15)))
(ite  (not (exists ((i@@85 Int) ) (!  (and (and (|$IsValid'u64'| i@@85) (InRangeVec_68166 v@@49 i@@85)) (= (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| v@@49) i@@85) e@@15))
 :qid |boogiebpl.5535:13|
 :skolemid |209|
))) (= i@@84 (- 0 1))  (and (and (and (|$IsValid'u64'| i@@84) (InRangeVec_68166 v@@49 i@@84)) (= (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| v@@49) i@@84) e@@15)) (forall ((j@@21 Int) ) (!  (=> (and (and (|$IsValid'u64'| j@@21) (>= j@@21 0)) (< j@@21 i@@84)) (not (= (|Select__T@[Int](_ BitVec 8)_| (|v#Vec_68162| v@@49) j@@21) e@@15)))
 :qid |boogiebpl.5543:17|
 :skolemid |210|
)))))
 :qid |boogiebpl.5539:15|
 :skolemid |211|
 :pattern ( (|$IndexOfVec'bv8'| v@@49 e@@15))
)))
(assert (forall ((s@@36 T@$1_account_Account) ) (! (= (|$IsValid'$1_account_Account'| s@@36)  (and (and (and (and (and (and (|$IsValid'vec'u8''| (|$authentication_key#$1_account_Account| s@@36)) (|$IsValid'u64'| (|$sequence_number#$1_account_Account| s@@36))) (|$IsValid'u64'| (|$guid_creation_num#$1_account_Account| s@@36))) (|$IsValid'$1_event_EventHandle'$1_account_CoinRegisterEvent''| (|$coin_register_events#$1_account_Account| s@@36))) (|$IsValid'$1_event_EventHandle'$1_account_KeyRotationEvent''| (|$key_rotation_events#$1_account_Account| s@@36))) (|$IsValid'$1_account_CapabilityOffer'$1_account_RotationCapability''| (|$rotation_capability_offer#$1_account_Account| s@@36))) (|$IsValid'$1_account_CapabilityOffer'$1_account_SignerCapability''| (|$signer_capability_offer#$1_account_Account| s@@36))))
 :qid |boogiebpl.8481:39|
 :skolemid |511|
 :pattern ( (|$IsValid'$1_account_Account'| s@@36))
)))
(assert (forall ((t@@24 T@$TypeParamInfo) ) (!  (=> (is-$TypeParamBool t@@24) (|$IsEqual'vec'u8''| ($TypeName t@@24) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 98) 1 111) 2 111) 3 108) 4)))
 :qid |boogiebpl.6521:15|
 :skolemid |245|
 :pattern ( ($TypeName t@@24))
)))
(assert (forall ((agg@@0 T@$1_aggregator_Aggregator) ) (! (= ($1_aggregator_spec_read agg@@0) (|$val#$1_aggregator_Aggregator| agg@@0))
 :qid |boogiebpl.282:34|
 :skolemid |9|
 :pattern ( ($1_aggregator_spec_read agg@@0))
)))
(assert (forall ((agg@@1 T@$1_aggregator_Aggregator) ) (! (= ($1_aggregator_spec_aggregator_get_val agg@@1) (|$val#$1_aggregator_Aggregator| agg@@1))
 :qid |boogiebpl.290:48|
 :skolemid |11|
 :pattern ( ($1_aggregator_spec_aggregator_get_val agg@@1))
)))
(assert (forall ((t1@@0 T@Table_36177_36178) (t2@@0 T@Table_36177_36178) ) (! (= (|$IsEqual'$1_table_Table'u64_u64''| t1@@0 t2@@0)  (and (and (and (= (|l#Table_36177_36178| t1@@0) (|l#Table_36177_36178| t2@@0)) (forall ((k@@12 Int) ) (! (= (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t1@@0) k@@12) (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t2@@0) k@@12))
 :qid |boogiebpl.5956:13|
 :skolemid |220|
))) (forall ((k@@13 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t1@@0) k@@13) (= (|Select__T@[Int]Int_| (|v#Table_36177_36178| t1@@0) k@@13) (|Select__T@[Int]Int_| (|v#Table_36177_36178| t2@@0) k@@13)))
 :qid |boogiebpl.5957:13|
 :skolemid |221|
))) (forall ((k@@14 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t2@@0) k@@14) (= (|Select__T@[Int]Int_| (|v#Table_36177_36178| t1@@0) k@@14) (|Select__T@[Int]Int_| (|v#Table_36177_36178| t2@@0) k@@14)))
 :qid |boogiebpl.5958:13|
 :skolemid |222|
))))
 :qid |boogiebpl.5954:44|
 :skolemid |223|
 :pattern ( (|$IsEqual'$1_table_Table'u64_u64''| t1@@0 t2@@0))
)))
(assert (forall ((t1@@1 T@Table_37064_126051) (t2@@1 T@Table_37064_126051) ) (! (= (|$IsEqual'$1_table_Table'u64_vec'u64'''| t1@@1 t2@@1)  (and (and (and (= (|l#Table_37064_126051| t1@@1) (|l#Table_37064_126051| t2@@1)) (forall ((k@@15 Int) ) (! (= (|Select__T@[Int]Bool_| (|e#Table_37064_126051| t1@@1) k@@15) (|Select__T@[Int]Bool_| (|e#Table_37064_126051| t2@@1) k@@15))
 :qid |boogiebpl.6074:13|
 :skolemid |226|
))) (forall ((k@@16 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_37064_126051| t1@@1) k@@16) (= (|Select__T@[Int]Vec_6673_| (|v#Table_37064_126051| t1@@1) k@@16) (|Select__T@[Int]Vec_6673_| (|v#Table_37064_126051| t2@@1) k@@16)))
 :qid |boogiebpl.6075:13|
 :skolemid |227|
))) (forall ((k@@17 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_37064_126051| t2@@1) k@@17) (= (|Select__T@[Int]Vec_6673_| (|v#Table_37064_126051| t1@@1) k@@17) (|Select__T@[Int]Vec_6673_| (|v#Table_37064_126051| t2@@1) k@@17)))
 :qid |boogiebpl.6076:13|
 :skolemid |228|
))))
 :qid |boogiebpl.6072:49|
 :skolemid |229|
 :pattern ( (|$IsEqual'$1_table_Table'u64_vec'u64'''| t1@@1 t2@@1))
)))
(assert (forall ((t1@@2 T@Table_36177_36178) (t2@@2 T@Table_36177_36178) ) (! (= (|$IsEqual'$1_table_Table'address_address''| t1@@2 t2@@2)  (and (and (and (= (|l#Table_36177_36178| t1@@2) (|l#Table_36177_36178| t2@@2)) (forall ((k@@18 Int) ) (! (= (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t1@@2) k@@18) (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t2@@2) k@@18))
 :qid |boogiebpl.6192:13|
 :skolemid |232|
))) (forall ((k@@19 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t1@@2) k@@19) (= (|Select__T@[Int]Int_| (|v#Table_36177_36178| t1@@2) k@@19) (|Select__T@[Int]Int_| (|v#Table_36177_36178| t2@@2) k@@19)))
 :qid |boogiebpl.6193:13|
 :skolemid |233|
))) (forall ((k@@20 Int) ) (!  (=> (|Select__T@[Int]Bool_| (|e#Table_36177_36178| t2@@2) k@@20) (= (|Select__T@[Int]Int_| (|v#Table_36177_36178| t1@@2) k@@20) (|Select__T@[Int]Int_| (|v#Table_36177_36178| t2@@2) k@@20)))
 :qid |boogiebpl.6194:13|
 :skolemid |234|
))))
 :qid |boogiebpl.6190:52|
 :skolemid |235|
 :pattern ( (|$IsEqual'$1_table_Table'address_address''| t1@@2 t2@@2))
)))
(assert (forall ((v@@50 (_ BitVec 128)) ) (! (= (|$IsValid'bv128'| v@@50)  (and (bvuge v@@50 #x00000000000000000000000000000000) (bvule v@@50 #xffffffffffffffffffffffffffffffff)))
 :qid |boogiebpl.923:26|
 :skolemid |18|
 :pattern ( (|$IsValid'bv128'| v@@50))
)))
(assert (forall ((v1@@8 T@Vec_6673) (v2@@8 T@Vec_6673) ) (! (= (|$IsEqual'vec'u8''| v1@@8 v2@@8) (|$IsEqual'vec'u8''| ($1_hash_sha2 v1@@8) ($1_hash_sha2 v2@@8)))
 :qid |boogiebpl.6322:15|
 :skolemid |238|
 :pattern ( ($1_hash_sha2 v1@@8) ($1_hash_sha2 v2@@8))
)))
(assert (forall ((v1@@9 T@Vec_6673) (v2@@9 T@Vec_6673) ) (! (= (|$IsEqual'vec'u8''| v1@@9 v2@@9) (|$IsEqual'vec'u8''| ($1_hash_sha3 v1@@9) ($1_hash_sha3 v2@@9)))
 :qid |boogiebpl.6338:15|
 :skolemid |239|
 :pattern ( ($1_hash_sha3 v1@@9) ($1_hash_sha3 v2@@9))
)))
(assert (forall ((v1@@10 Int) (v2@@10 Int) ) (! (= (= v1@@10 v2@@10) (|$IsEqual'vec'u8''| (|$1_bcs_serialize'address'| v1@@10) (|$1_bcs_serialize'address'| v2@@10)))
 :qid |boogiebpl.6465:15|
 :skolemid |242|
 :pattern ( (|$1_bcs_serialize'address'| v1@@10) (|$1_bcs_serialize'address'| v2@@10))
)))
(assert (forall ((t@@25 T@$TypeParamInfo) ) (!  (=> (is-$TypeParamStruct t@@25) (|$IsEqual'vec'u8''| ($TypeName t@@25) (let ((m2@@2 (|v#Vec_6673| (|s#$TypeParamStruct| t@@25))))
(let ((l2@@1 (|l#Vec_6673| (|s#$TypeParamStruct| t@@25))))
(let ((m1@@2 (|v#Vec_6673| (let ((m2@@3 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((l2@@2 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((m1@@3 (|v#Vec_6673| (let ((m2@@4 (|v#Vec_6673| (|m#$TypeParamStruct| t@@25))))
(let ((l2@@3 (|l#Vec_6673| (|m#$TypeParamStruct| t@@25))))
(let ((m1@@4 (|v#Vec_6673| (let ((m2@@5 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((l2@@4 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((m1@@5 (|v#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(let ((l1@@2 (|l#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@2 l2@@4) l1@@2 m1@@5 m2@@5 l1@@2 DefaultVecElem_25347) (+ l1@@2 l2@@4)))))))))
(let ((l1@@3 (|l#Vec_6673| (let ((m2@@5 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((l2@@4 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((m1@@5 (|v#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(let ((l1@@2 (|l#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@2 l2@@4) l1@@2 m1@@5 m2@@5 l1@@2 DefaultVecElem_25347) (+ l1@@2 l2@@4)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@3 l2@@3) l1@@3 m1@@4 m2@@4 l1@@3 DefaultVecElem_25347) (+ l1@@3 l2@@3)))))))))
(let ((l1@@4 (|l#Vec_6673| (let ((m2@@4 (|v#Vec_6673| (|m#$TypeParamStruct| t@@25))))
(let ((l2@@3 (|l#Vec_6673| (|m#$TypeParamStruct| t@@25))))
(let ((m1@@4 (|v#Vec_6673| (let ((m2@@5 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((l2@@4 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((m1@@5 (|v#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(let ((l1@@2 (|l#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@2 l2@@4) l1@@2 m1@@5 m2@@5 l1@@2 DefaultVecElem_25347) (+ l1@@2 l2@@4)))))))))
(let ((l1@@3 (|l#Vec_6673| (let ((m2@@5 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((l2@@4 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((m1@@5 (|v#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(let ((l1@@2 (|l#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@2 l2@@4) l1@@2 m1@@5 m2@@5 l1@@2 DefaultVecElem_25347) (+ l1@@2 l2@@4)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@3 l2@@3) l1@@3 m1@@4 m2@@4 l1@@3 DefaultVecElem_25347) (+ l1@@3 l2@@3)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@4 l2@@2) l1@@4 m1@@3 m2@@3 l1@@4 DefaultVecElem_25347) (+ l1@@4 l2@@2)))))))))
(let ((l1@@5 (|l#Vec_6673| (let ((m2@@3 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((l2@@2 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((m1@@3 (|v#Vec_6673| (let ((m2@@4 (|v#Vec_6673| (|m#$TypeParamStruct| t@@25))))
(let ((l2@@3 (|l#Vec_6673| (|m#$TypeParamStruct| t@@25))))
(let ((m1@@4 (|v#Vec_6673| (let ((m2@@5 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((l2@@4 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((m1@@5 (|v#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(let ((l1@@2 (|l#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@2 l2@@4) l1@@2 m1@@5 m2@@5 l1@@2 DefaultVecElem_25347) (+ l1@@2 l2@@4)))))))))
(let ((l1@@3 (|l#Vec_6673| (let ((m2@@5 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((l2@@4 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((m1@@5 (|v#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(let ((l1@@2 (|l#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@2 l2@@4) l1@@2 m1@@5 m2@@5 l1@@2 DefaultVecElem_25347) (+ l1@@2 l2@@4)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@3 l2@@3) l1@@3 m1@@4 m2@@4 l1@@3 DefaultVecElem_25347) (+ l1@@3 l2@@3)))))))))
(let ((l1@@4 (|l#Vec_6673| (let ((m2@@4 (|v#Vec_6673| (|m#$TypeParamStruct| t@@25))))
(let ((l2@@3 (|l#Vec_6673| (|m#$TypeParamStruct| t@@25))))
(let ((m1@@4 (|v#Vec_6673| (let ((m2@@5 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((l2@@4 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((m1@@5 (|v#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(let ((l1@@2 (|l#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@2 l2@@4) l1@@2 m1@@5 m2@@5 l1@@2 DefaultVecElem_25347) (+ l1@@2 l2@@4)))))))))
(let ((l1@@3 (|l#Vec_6673| (let ((m2@@5 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((l2@@4 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 58) 1 58) 2))))
(let ((m1@@5 (|v#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(let ((l1@@2 (|l#Vec_6673| (let ((m2@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((l2@@5 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 (|a#$TypeParamStruct| t@@25)) 1))))
(let ((m1@@6 (|v#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(let ((l1@@1 (|l#Vec_6673| (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 48) 1 120) 2))))
(Vec_6673 (|lambda#16| 0 (+ l1@@1 l2@@5) l1@@1 m1@@6 m2@@6 l1@@1 DefaultVecElem_25347) (+ l1@@1 l2@@5)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@2 l2@@4) l1@@2 m1@@5 m2@@5 l1@@2 DefaultVecElem_25347) (+ l1@@2 l2@@4)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@3 l2@@3) l1@@3 m1@@4 m2@@4 l1@@3 DefaultVecElem_25347) (+ l1@@3 l2@@3)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@4 l2@@2) l1@@4 m1@@3 m2@@3 l1@@4 DefaultVecElem_25347) (+ l1@@4 l2@@2)))))))))
(Vec_6673 (|lambda#16| 0 (+ l1@@5 l2@@1) l1@@5 m1@@2 m2@@2 l1@@5 DefaultVecElem_25347) (+ l1@@5 l2@@1))))))))
 :qid |boogiebpl.6541:15|
 :skolemid |265|
 :pattern ( ($TypeName t@@25))
)))
(assert (forall ((v@@51 Int) ) (! (= (|$IsValid'u8'| v@@51)  (and (>= v@@51 0) (<= v@@51 $MAX_U8)))
 :qid |boogiebpl.1081:23|
 :skolemid |20|
 :pattern ( (|$IsValid'u8'| v@@51))
)))
(assert (forall ((v@@52 Int) ) (! (= (|$IsValid'u16'| v@@52)  (and (>= v@@52 0) (<= v@@52 $MAX_U16)))
 :qid |boogiebpl.1085:24|
 :skolemid |21|
 :pattern ( (|$IsValid'u16'| v@@52))
)))
(assert (forall ((v@@53 Int) ) (! (= (|$IsValid'u32'| v@@53)  (and (>= v@@53 0) (<= v@@53 $MAX_U32)))
 :qid |boogiebpl.1089:24|
 :skolemid |22|
 :pattern ( (|$IsValid'u32'| v@@53))
)))
(assert (forall ((v@@54 Int) ) (! (= (|$IsValid'u64'| v@@54)  (and (>= v@@54 0) (<= v@@54 $MAX_U64)))
 :qid |boogiebpl.1093:24|
 :skolemid |23|
 :pattern ( (|$IsValid'u64'| v@@54))
)))
(assert (forall ((v@@55 Int) ) (! (= (|$IsValid'u128'| v@@55)  (and (>= v@@55 0) (<= v@@55 $MAX_U128)))
 :qid |boogiebpl.1097:25|
 :skolemid |24|
 :pattern ( (|$IsValid'u128'| v@@55))
)))
(assert (forall ((v@@56 Int) ) (! (= (|$IsValid'u256'| v@@56)  (and (>= v@@56 0) (<= v@@56 $MAX_U256)))
 :qid |boogiebpl.1101:25|
 :skolemid |25|
 :pattern ( (|$IsValid'u256'| v@@56))
)))
(assert (forall ((v@@57 T@Vec_85428) (i@@86 Int) ) (! (= (InRangeVec_65852 v@@57 i@@86)  (and (>= i@@86 0) (< i@@86 (|l#Vec_85428| v@@57))))
 :qid |boogiebpl.123:24|
 :skolemid |3|
 :pattern ( (InRangeVec_65852 v@@57 i@@86))
)))
(assert (forall ((v@@58 T@Vec_90390) (i@@87 Int) ) (! (= (InRangeVec_66199 v@@58 i@@87)  (and (>= i@@87 0) (< i@@87 (|l#Vec_90390| v@@58))))
 :qid |boogiebpl.123:24|
 :skolemid |3|
 :pattern ( (InRangeVec_66199 v@@58 i@@87))
)))
(assert (forall ((v@@59 T@Vec_95276) (i@@88 Int) ) (! (= (InRangeVec_66546 v@@59 i@@88)  (and (>= i@@88 0) (< i@@88 (|l#Vec_95276| v@@59))))
 :qid |boogiebpl.123:24|
 :skolemid |3|
 :pattern ( (InRangeVec_66546 v@@59 i@@88))
)))
(assert (forall ((v@@60 T@Vec_100175) (i@@89 Int) ) (! (= (InRangeVec_66893 v@@60 i@@89)  (and (>= i@@89 0) (< i@@89 (|l#Vec_100175| v@@60))))
 :qid |boogiebpl.123:24|
 :skolemid |3|
 :pattern ( (InRangeVec_66893 v@@60 i@@89))
)))
(assert (forall ((v@@61 T@Vec_6673) (i@@90 Int) ) (! (= (InRangeVec_25002 v@@61 i@@90)  (and (>= i@@90 0) (< i@@90 (|l#Vec_6673| v@@61))))
 :qid |boogiebpl.123:24|
 :skolemid |3|
 :pattern ( (InRangeVec_25002 v@@61 i@@90))
)))
(assert (forall ((v@@62 T@Vec_67815) (i@@91 Int) ) (! (= (InRangeVec_67819 v@@62 i@@91)  (and (>= i@@91 0) (< i@@91 (|l#Vec_67815| v@@62))))
 :qid |boogiebpl.123:24|
 :skolemid |3|
 :pattern ( (InRangeVec_67819 v@@62 i@@91))
)))
(assert (forall ((v@@63 T@Vec_68162) (i@@92 Int) ) (! (= (InRangeVec_68166 v@@63 i@@92)  (and (>= i@@92 0) (< i@@92 (|l#Vec_68162| v@@63))))
 :qid |boogiebpl.123:24|
 :skolemid |3|
 :pattern ( (InRangeVec_68166 v@@63 i@@92))
)))
(assert (forall ((t@@26 T@$TypeParamInfo) ) (!  (=> (|$IsEqual'vec'u8''| ($TypeName t@@26) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 117) 1 50) 2 53) 3 54) 4)) (is-$TypeParamU256 t@@26))
 :qid |boogiebpl.6534:15|
 :skolemid |258|
 :pattern ( ($TypeName t@@26))
)))
(assert (forall ((limit Int) ) (! (let ((agg@@2 ($1_aggregator_factory_spec_new_aggregator limit)))
(= ($1_aggregator_spec_aggregator_get_val agg@@2) 0))
 :qid |boogiebpl.300:15|
 :skolemid |13|
 :pattern ( ($1_aggregator_factory_spec_new_aggregator limit))
)))
(assert (forall ((limit@@0 Int) ) (! (let ((agg@@3 ($1_aggregator_factory_spec_new_aggregator limit@@0)))
(= (|$limit#$1_aggregator_Aggregator| agg@@3) limit@@0))
 :qid |boogiebpl.296:15|
 :skolemid |12|
 :pattern ( ($1_aggregator_factory_spec_new_aggregator limit@@0))
)))
(assert (forall ((v@@64 Int) ) (! (let ((r@@0 (|$1_bcs_serialize'address'| v@@64)))
(= (|l#Vec_6673| r@@0) $serialized_address_len))
 :qid |boogiebpl.6484:15|
 :skolemid |244|
 :pattern ( (|$1_bcs_serialize'address'| v@@64))
)))
(assert (forall ((r@@1 T@$Range) (i@@93 Int) ) (! (= ($InRange r@@1 i@@93)  (and (<= (|lb#$Range| r@@1) i@@93) (< i@@93 (|ub#$Range| r@@1))))
 :qid |boogiebpl.1119:19|
 :skolemid |28|
 :pattern ( ($InRange r@@1 i@@93))
)))
(assert (= $MAX_U32 4294967295))
(assert (= $MAX_U8 255))
(assert (= $MAX_U64 18446744073709551615))
(assert (= $MAX_U16 65535))
(assert (forall ((t@@27 T@$TypeParamInfo) ) (!  (=> (|$IsEqual'vec'u8''| ($TypeName t@@27) (Vec_6673 (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (|Store__T@[Int]Int_| (MapConstVec_25347 DefaultVecElem_25347) 0 97) 1 100) 2 100) 3 114) 4 101) 5 115) 6 115) 7)) (is-$TypeParamAddress t@@27))
 :qid |boogiebpl.6536:15|
 :skolemid |260|
 :pattern ( ($TypeName t@@27))
)))
(assert (= $MAX_U256 115792089237316195423570985008687907853269984665640564039457584007913129639935))
(assert (= $EXEC_FAILURE_CODE (- 0 1)))
(assert (forall ((s@@37 T@$1_type_info_TypeInfo) ) (! (= (|$IsValid'$1_type_info_TypeInfo'| s@@37)  (and (and (|$IsValid'address'| (|$account_address#$1_type_info_TypeInfo| s@@37)) (|$IsValid'vec'u8''| (|$module_name#$1_type_info_TypeInfo| s@@37))) (|$IsValid'vec'u8''| (|$struct_name#$1_type_info_TypeInfo| s@@37))))
 :qid |boogiebpl.7384:42|
 :skolemid |389|
 :pattern ( (|$IsValid'$1_type_info_TypeInfo'| s@@37))
)))
; Valid

