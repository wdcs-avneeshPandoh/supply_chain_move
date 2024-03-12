
// ** Expanded prelude

// Copyright (c) The Diem Core Contributors
// Copyright (c) The Move Contributors
// SPDX-License-Identifier: Apache-2.0

// Basic theory for vectors using arrays. This version of vectors is not extensional.

datatype Vec<T> {
    Vec(v: [int]T, l: int)
}

function {:builtin "MapConst"} MapConstVec<T>(T): [int]T;
function DefaultVecElem<T>(): T;
function {:inline} DefaultVecMap<T>(): [int]T { MapConstVec(DefaultVecElem()) }

function {:inline} EmptyVec<T>(): Vec T {
    Vec(DefaultVecMap(), 0)
}

function {:inline} MakeVec1<T>(v: T): Vec T {
    Vec(DefaultVecMap()[0 := v], 1)
}

function {:inline} MakeVec2<T>(v1: T, v2: T): Vec T {
    Vec(DefaultVecMap()[0 := v1][1 := v2], 2)
}

function {:inline} MakeVec3<T>(v1: T, v2: T, v3: T): Vec T {
    Vec(DefaultVecMap()[0 := v1][1 := v2][2 := v3], 3)
}

function {:inline} MakeVec4<T>(v1: T, v2: T, v3: T, v4: T): Vec T {
    Vec(DefaultVecMap()[0 := v1][1 := v2][2 := v3][3 := v4], 4)
}

function {:inline} ExtendVec<T>(v: Vec T, elem: T): Vec T {
    (var l := v->l;
    Vec(v->v[l := elem], l + 1))
}

function {:inline} ReadVec<T>(v: Vec T, i: int): T {
    v->v[i]
}

function {:inline} LenVec<T>(v: Vec T): int {
    v->l
}

function {:inline} IsEmptyVec<T>(v: Vec T): bool {
    v->l == 0
}

function {:inline} RemoveVec<T>(v: Vec T): Vec T {
    (var l := v->l - 1;
    Vec(v->v[l := DefaultVecElem()], l))
}

function {:inline} RemoveAtVec<T>(v: Vec T, i: int): Vec T {
    (var l := v->l - 1;
    Vec(
        (lambda j: int ::
           if j >= 0 && j < l then
               if j < i then v->v[j] else v->v[j+1]
           else DefaultVecElem()),
        l))
}

function {:inline} ConcatVec<T>(v1: Vec T, v2: Vec T): Vec T {
    (var l1, m1, l2, m2 := v1->l, v1->v, v2->l, v2->v;
    Vec(
        (lambda i: int ::
          if i >= 0 && i < l1 + l2 then
            if i < l1 then m1[i] else m2[i - l1]
          else DefaultVecElem()),
        l1 + l2))
}

function {:inline} ReverseVec<T>(v: Vec T): Vec T {
    (var l := v->l;
    Vec(
        (lambda i: int :: if 0 <= i && i < l then v->v[l - i - 1] else DefaultVecElem()),
        l))
}

function {:inline} SliceVec<T>(v: Vec T, i: int, j: int): Vec T {
    (var m := v->v;
    Vec(
        (lambda k:int ::
          if 0 <= k && k < j - i then
            m[i + k]
          else
            DefaultVecElem()),
        (if j - i < 0 then 0 else j - i)))
}


function {:inline} UpdateVec<T>(v: Vec T, i: int, elem: T): Vec T {
    Vec(v->v[i := elem], v->l)
}

function {:inline} SwapVec<T>(v: Vec T, i: int, j: int): Vec T {
    (var m := v->v;
    Vec(m[i := m[j]][j := m[i]], v->l))
}

function {:inline} ContainsVec<T>(v: Vec T, e: T): bool {
    (var l := v->l;
    (exists i: int :: InRangeVec(v, i) && v->v[i] == e))
}

function IndexOfVec<T>(v: Vec T, e: T): int;
axiom {:ctor "Vec"} (forall<T> v: Vec T, e: T :: {IndexOfVec(v, e)}
    (var i := IndexOfVec(v,e);
     if (!ContainsVec(v, e)) then i == -1
     else InRangeVec(v, i) && ReadVec(v, i) == e &&
        (forall j: int :: j >= 0 && j < i ==> ReadVec(v, j) != e)));

// This function should stay non-inlined as it guards many quantifiers
// over vectors. It appears important to have this uninterpreted for
// quantifier triggering.
function InRangeVec<T>(v: Vec T, i: int): bool {
    i >= 0 && i < LenVec(v)
}

// Copyright (c) The Diem Core Contributors
// Copyright (c) The Move Contributors
// SPDX-License-Identifier: Apache-2.0

// Boogie model for multisets, based on Boogie arrays. This theory assumes extensional equality for element types.

datatype Multiset<T> {
    Multiset(v: [T]int, l: int)
}

function {:builtin "MapConst"} MapConstMultiset<T>(l: int): [T]int;

function {:inline} EmptyMultiset<T>(): Multiset T {
    Multiset(MapConstMultiset(0), 0)
}

function {:inline} LenMultiset<T>(s: Multiset T): int {
    s->l
}

function {:inline} ExtendMultiset<T>(s: Multiset T, v: T): Multiset T {
    (var len := s->l;
    (var cnt := s->v[v];
    Multiset(s->v[v := (cnt + 1)], len + 1)))
}

// This function returns (s1 - s2). This function assumes that s2 is a subset of s1.
function {:inline} SubtractMultiset<T>(s1: Multiset T, s2: Multiset T): Multiset T {
    (var len1 := s1->l;
    (var len2 := s2->l;
    Multiset((lambda v:T :: s1->v[v]-s2->v[v]), len1-len2)))
}

function {:inline} IsEmptyMultiset<T>(s: Multiset T): bool {
    (s->l == 0) &&
    (forall v: T :: s->v[v] == 0)
}

function {:inline} IsSubsetMultiset<T>(s1: Multiset T, s2: Multiset T): bool {
    (s1->l <= s2->l) &&
    (forall v: T :: s1->v[v] <= s2->v[v])
}

function {:inline} ContainsMultiset<T>(s: Multiset T, v: T): bool {
    s->v[v] > 0
}

// Copyright (c) The Diem Core Contributors
// Copyright (c) The Move Contributors
// SPDX-License-Identifier: Apache-2.0

// Theory for tables.

// v is the SMT array holding the key-value assignment. e is an array which
// independently determines whether a key is valid or not. l is the length.
//
// Note that even though the program cannot reflect over existence of a key,
// we want the specification to be able to do this, so it can express
// verification conditions like "key has been inserted".
datatype Table <K, V> {
    Table(v: [K]V, e: [K]bool, l: int)
}

// Functions for default SMT arrays. For the table values, we don't care and
// use an uninterpreted function.
function DefaultTableArray<K, V>(): [K]V;
function DefaultTableKeyExistsArray<K>(): [K]bool;
axiom DefaultTableKeyExistsArray() == (lambda i: int :: false);

function {:inline} EmptyTable<K, V>(): Table K V {
    Table(DefaultTableArray(), DefaultTableKeyExistsArray(), 0)
}

function {:inline} GetTable<K,V>(t: Table K V, k: K): V {
    // Notice we do not check whether key is in the table. The result is undetermined if it is not.
    t->v[k]
}

function {:inline} LenTable<K,V>(t: Table K V): int {
    t->l
}


function {:inline} ContainsTable<K,V>(t: Table K V, k: K): bool {
    t->e[k]
}

function {:inline} UpdateTable<K,V>(t: Table K V, k: K, v: V): Table K V {
    Table(t->v[k := v], t->e, t->l)
}

function {:inline} AddTable<K,V>(t: Table K V, k: K, v: V): Table K V {
    // This function has an undetermined result if the key is already in the table
    // (all specification functions have this "partial definiteness" behavior). Thus we can
    // just increment the length.
    Table(t->v[k := v], t->e[k := true], t->l + 1)
}

function {:inline} RemoveTable<K,V>(t: Table K V, k: K): Table K V {
    // Similar as above, we only need to consider the case where the key is in the table.
    Table(t->v, t->e[k := false], t->l - 1)
}

axiom {:ctor "Table"} (forall<K,V> t: Table K V :: {LenTable(t)}
    (exists k: K :: {ContainsTable(t, k)} ContainsTable(t, k)) ==> LenTable(t) >= 1
);
// TODO: we might want to encoder a stronger property that the length of table
// must be more than N given a set of N items. Currently we don't see a need here
// and the above axiom seems to be sufficient.
// Copyright © Aptos Foundation
// SPDX-License-Identifier: Apache-2.0

// ==================================================================================
// Native object::exists_at

// ==================================================================================
// Intrinsic implementation of aggregator and aggregator factory

datatype $1_aggregator_Aggregator {
    $1_aggregator_Aggregator($handle: int, $key: int, $limit: int, $val: int)
}
function {:inline} $Update'$1_aggregator_Aggregator'_handle(s: $1_aggregator_Aggregator, x: int): $1_aggregator_Aggregator {
    $1_aggregator_Aggregator(x, s->$key, s->$limit, s->$val)
}
function {:inline} $Update'$1_aggregator_Aggregator'_key(s: $1_aggregator_Aggregator, x: int): $1_aggregator_Aggregator {
    $1_aggregator_Aggregator(s->$handle, x, s->$limit, s->$val)
}
function {:inline} $Update'$1_aggregator_Aggregator'_limit(s: $1_aggregator_Aggregator, x: int): $1_aggregator_Aggregator {
    $1_aggregator_Aggregator(s->$handle, s->$key, x, s->$val)
}
function {:inline} $Update'$1_aggregator_Aggregator'_val(s: $1_aggregator_Aggregator, x: int): $1_aggregator_Aggregator {
    $1_aggregator_Aggregator(s->$handle, s->$key, s->$limit, x)
}
function $IsValid'$1_aggregator_Aggregator'(s: $1_aggregator_Aggregator): bool {
    $IsValid'address'(s->$handle)
      && $IsValid'address'(s->$key)
      && $IsValid'u128'(s->$limit)
      && $IsValid'u128'(s->$val)
}
function {:inline} $IsEqual'$1_aggregator_Aggregator'(s1: $1_aggregator_Aggregator, s2: $1_aggregator_Aggregator): bool {
    s1 == s2
}
function {:inline} $1_aggregator_spec_get_limit(s: $1_aggregator_Aggregator): int {
    s->$limit
}
function {:inline} $1_aggregator_spec_get_handle(s: $1_aggregator_Aggregator): int {
    s->$handle
}
function {:inline} $1_aggregator_spec_get_key(s: $1_aggregator_Aggregator): int {
    s->$key
}
function {:inline} $1_aggregator_spec_get_val(s: $1_aggregator_Aggregator): int {
    s->$val
}

function $1_aggregator_spec_read(agg: $1_aggregator_Aggregator): int {
    $1_aggregator_spec_get_val(agg)
}

function $1_aggregator_spec_aggregator_set_val(agg: $1_aggregator_Aggregator, val: int): $1_aggregator_Aggregator {
    $Update'$1_aggregator_Aggregator'_val(agg, val)
}

function $1_aggregator_spec_aggregator_get_val(agg: $1_aggregator_Aggregator): int {
    $1_aggregator_spec_get_val(agg)
}

function $1_aggregator_factory_spec_new_aggregator(limit: int) : $1_aggregator_Aggregator;

axiom (forall limit: int :: {$1_aggregator_factory_spec_new_aggregator(limit)}
    (var agg := $1_aggregator_factory_spec_new_aggregator(limit);
     $1_aggregator_spec_get_limit(agg) == limit));

axiom (forall limit: int :: {$1_aggregator_factory_spec_new_aggregator(limit)}
     (var agg := $1_aggregator_factory_spec_new_aggregator(limit);
     $1_aggregator_spec_aggregator_get_val(agg) == 0));


// ============================================================================================
// Primitive Types

const $MAX_U8: int;
axiom $MAX_U8 == 255;
const $MAX_U16: int;
axiom $MAX_U16 == 65535;
const $MAX_U32: int;
axiom $MAX_U32 == 4294967295;
const $MAX_U64: int;
axiom $MAX_U64 == 18446744073709551615;
const $MAX_U128: int;
axiom $MAX_U128 == 340282366920938463463374607431768211455;
const $MAX_U256: int;
axiom $MAX_U256 == 115792089237316195423570985008687907853269984665640564039457584007913129639935;

// Templates for bitvector operations

function {:bvbuiltin "bvand"} $And'Bv8'(bv8,bv8) returns(bv8);
function {:bvbuiltin "bvor"} $Or'Bv8'(bv8,bv8) returns(bv8);
function {:bvbuiltin "bvxor"} $Xor'Bv8'(bv8,bv8) returns(bv8);
function {:bvbuiltin "bvadd"} $Add'Bv8'(bv8,bv8) returns(bv8);
function {:bvbuiltin "bvsub"} $Sub'Bv8'(bv8,bv8) returns(bv8);
function {:bvbuiltin "bvmul"} $Mul'Bv8'(bv8,bv8) returns(bv8);
function {:bvbuiltin "bvudiv"} $Div'Bv8'(bv8,bv8) returns(bv8);
function {:bvbuiltin "bvurem"} $Mod'Bv8'(bv8,bv8) returns(bv8);
function {:bvbuiltin "bvshl"} $Shl'Bv8'(bv8,bv8) returns(bv8);
function {:bvbuiltin "bvlshr"} $Shr'Bv8'(bv8,bv8) returns(bv8);
function {:bvbuiltin "bvult"} $Lt'Bv8'(bv8,bv8) returns(bool);
function {:bvbuiltin "bvule"} $Le'Bv8'(bv8,bv8) returns(bool);
function {:bvbuiltin "bvugt"} $Gt'Bv8'(bv8,bv8) returns(bool);
function {:bvbuiltin "bvuge"} $Ge'Bv8'(bv8,bv8) returns(bool);

procedure {:inline 1} $AddBv8(src1: bv8, src2: bv8) returns (dst: bv8)
{
    if ($Lt'Bv8'($Add'Bv8'(src1, src2), src1)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Add'Bv8'(src1, src2);
}

procedure {:inline 1} $AddBv8_unchecked(src1: bv8, src2: bv8) returns (dst: bv8)
{
    dst := $Add'Bv8'(src1, src2);
}

procedure {:inline 1} $SubBv8(src1: bv8, src2: bv8) returns (dst: bv8)
{
    if ($Lt'Bv8'(src1, src2)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Sub'Bv8'(src1, src2);
}

procedure {:inline 1} $MulBv8(src1: bv8, src2: bv8) returns (dst: bv8)
{
    if ($Lt'Bv8'($Mul'Bv8'(src1, src2), src1)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Mul'Bv8'(src1, src2);
}

procedure {:inline 1} $DivBv8(src1: bv8, src2: bv8) returns (dst: bv8)
{
    if (src2 == 0bv8) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Div'Bv8'(src1, src2);
}

procedure {:inline 1} $ModBv8(src1: bv8, src2: bv8) returns (dst: bv8)
{
    if (src2 == 0bv8) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Mod'Bv8'(src1, src2);
}

procedure {:inline 1} $AndBv8(src1: bv8, src2: bv8) returns (dst: bv8)
{
    dst := $And'Bv8'(src1,src2);
}

procedure {:inline 1} $OrBv8(src1: bv8, src2: bv8) returns (dst: bv8)
{
    dst := $Or'Bv8'(src1,src2);
}

procedure {:inline 1} $XorBv8(src1: bv8, src2: bv8) returns (dst: bv8)
{
    dst := $Xor'Bv8'(src1,src2);
}

procedure {:inline 1} $LtBv8(src1: bv8, src2: bv8) returns (dst: bool)
{
    dst := $Lt'Bv8'(src1,src2);
}

procedure {:inline 1} $LeBv8(src1: bv8, src2: bv8) returns (dst: bool)
{
    dst := $Le'Bv8'(src1,src2);
}

procedure {:inline 1} $GtBv8(src1: bv8, src2: bv8) returns (dst: bool)
{
    dst := $Gt'Bv8'(src1,src2);
}

procedure {:inline 1} $GeBv8(src1: bv8, src2: bv8) returns (dst: bool)
{
    dst := $Ge'Bv8'(src1,src2);
}

function $IsValid'bv8'(v: bv8): bool {
  $Ge'Bv8'(v,0bv8) && $Le'Bv8'(v,255bv8)
}

function {:inline} $IsEqual'bv8'(x: bv8, y: bv8): bool {
    x == y
}

procedure {:inline 1} $int2bv8(src: int) returns (dst: bv8)
{
    if (src > 255) {
        call $ExecFailureAbort();
        return;
    }
    dst := $int2bv.8(src);
}

procedure {:inline 1} $bv2int8(src: bv8) returns (dst: int)
{
    dst := $bv2int.8(src);
}

function {:builtin "(_ int2bv 8)"} $int2bv.8(i: int) returns (bv8);
function {:builtin "bv2nat"} $bv2int.8(i: bv8) returns (int);

function {:bvbuiltin "bvand"} $And'Bv16'(bv16,bv16) returns(bv16);
function {:bvbuiltin "bvor"} $Or'Bv16'(bv16,bv16) returns(bv16);
function {:bvbuiltin "bvxor"} $Xor'Bv16'(bv16,bv16) returns(bv16);
function {:bvbuiltin "bvadd"} $Add'Bv16'(bv16,bv16) returns(bv16);
function {:bvbuiltin "bvsub"} $Sub'Bv16'(bv16,bv16) returns(bv16);
function {:bvbuiltin "bvmul"} $Mul'Bv16'(bv16,bv16) returns(bv16);
function {:bvbuiltin "bvudiv"} $Div'Bv16'(bv16,bv16) returns(bv16);
function {:bvbuiltin "bvurem"} $Mod'Bv16'(bv16,bv16) returns(bv16);
function {:bvbuiltin "bvshl"} $Shl'Bv16'(bv16,bv16) returns(bv16);
function {:bvbuiltin "bvlshr"} $Shr'Bv16'(bv16,bv16) returns(bv16);
function {:bvbuiltin "bvult"} $Lt'Bv16'(bv16,bv16) returns(bool);
function {:bvbuiltin "bvule"} $Le'Bv16'(bv16,bv16) returns(bool);
function {:bvbuiltin "bvugt"} $Gt'Bv16'(bv16,bv16) returns(bool);
function {:bvbuiltin "bvuge"} $Ge'Bv16'(bv16,bv16) returns(bool);

procedure {:inline 1} $AddBv16(src1: bv16, src2: bv16) returns (dst: bv16)
{
    if ($Lt'Bv16'($Add'Bv16'(src1, src2), src1)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Add'Bv16'(src1, src2);
}

procedure {:inline 1} $AddBv16_unchecked(src1: bv16, src2: bv16) returns (dst: bv16)
{
    dst := $Add'Bv16'(src1, src2);
}

procedure {:inline 1} $SubBv16(src1: bv16, src2: bv16) returns (dst: bv16)
{
    if ($Lt'Bv16'(src1, src2)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Sub'Bv16'(src1, src2);
}

procedure {:inline 1} $MulBv16(src1: bv16, src2: bv16) returns (dst: bv16)
{
    if ($Lt'Bv16'($Mul'Bv16'(src1, src2), src1)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Mul'Bv16'(src1, src2);
}

procedure {:inline 1} $DivBv16(src1: bv16, src2: bv16) returns (dst: bv16)
{
    if (src2 == 0bv16) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Div'Bv16'(src1, src2);
}

procedure {:inline 1} $ModBv16(src1: bv16, src2: bv16) returns (dst: bv16)
{
    if (src2 == 0bv16) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Mod'Bv16'(src1, src2);
}

procedure {:inline 1} $AndBv16(src1: bv16, src2: bv16) returns (dst: bv16)
{
    dst := $And'Bv16'(src1,src2);
}

procedure {:inline 1} $OrBv16(src1: bv16, src2: bv16) returns (dst: bv16)
{
    dst := $Or'Bv16'(src1,src2);
}

procedure {:inline 1} $XorBv16(src1: bv16, src2: bv16) returns (dst: bv16)
{
    dst := $Xor'Bv16'(src1,src2);
}

procedure {:inline 1} $LtBv16(src1: bv16, src2: bv16) returns (dst: bool)
{
    dst := $Lt'Bv16'(src1,src2);
}

procedure {:inline 1} $LeBv16(src1: bv16, src2: bv16) returns (dst: bool)
{
    dst := $Le'Bv16'(src1,src2);
}

procedure {:inline 1} $GtBv16(src1: bv16, src2: bv16) returns (dst: bool)
{
    dst := $Gt'Bv16'(src1,src2);
}

procedure {:inline 1} $GeBv16(src1: bv16, src2: bv16) returns (dst: bool)
{
    dst := $Ge'Bv16'(src1,src2);
}

function $IsValid'bv16'(v: bv16): bool {
  $Ge'Bv16'(v,0bv16) && $Le'Bv16'(v,65535bv16)
}

function {:inline} $IsEqual'bv16'(x: bv16, y: bv16): bool {
    x == y
}

procedure {:inline 1} $int2bv16(src: int) returns (dst: bv16)
{
    if (src > 65535) {
        call $ExecFailureAbort();
        return;
    }
    dst := $int2bv.16(src);
}

procedure {:inline 1} $bv2int16(src: bv16) returns (dst: int)
{
    dst := $bv2int.16(src);
}

function {:builtin "(_ int2bv 16)"} $int2bv.16(i: int) returns (bv16);
function {:builtin "bv2nat"} $bv2int.16(i: bv16) returns (int);

function {:bvbuiltin "bvand"} $And'Bv32'(bv32,bv32) returns(bv32);
function {:bvbuiltin "bvor"} $Or'Bv32'(bv32,bv32) returns(bv32);
function {:bvbuiltin "bvxor"} $Xor'Bv32'(bv32,bv32) returns(bv32);
function {:bvbuiltin "bvadd"} $Add'Bv32'(bv32,bv32) returns(bv32);
function {:bvbuiltin "bvsub"} $Sub'Bv32'(bv32,bv32) returns(bv32);
function {:bvbuiltin "bvmul"} $Mul'Bv32'(bv32,bv32) returns(bv32);
function {:bvbuiltin "bvudiv"} $Div'Bv32'(bv32,bv32) returns(bv32);
function {:bvbuiltin "bvurem"} $Mod'Bv32'(bv32,bv32) returns(bv32);
function {:bvbuiltin "bvshl"} $Shl'Bv32'(bv32,bv32) returns(bv32);
function {:bvbuiltin "bvlshr"} $Shr'Bv32'(bv32,bv32) returns(bv32);
function {:bvbuiltin "bvult"} $Lt'Bv32'(bv32,bv32) returns(bool);
function {:bvbuiltin "bvule"} $Le'Bv32'(bv32,bv32) returns(bool);
function {:bvbuiltin "bvugt"} $Gt'Bv32'(bv32,bv32) returns(bool);
function {:bvbuiltin "bvuge"} $Ge'Bv32'(bv32,bv32) returns(bool);

procedure {:inline 1} $AddBv32(src1: bv32, src2: bv32) returns (dst: bv32)
{
    if ($Lt'Bv32'($Add'Bv32'(src1, src2), src1)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Add'Bv32'(src1, src2);
}

procedure {:inline 1} $AddBv32_unchecked(src1: bv32, src2: bv32) returns (dst: bv32)
{
    dst := $Add'Bv32'(src1, src2);
}

procedure {:inline 1} $SubBv32(src1: bv32, src2: bv32) returns (dst: bv32)
{
    if ($Lt'Bv32'(src1, src2)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Sub'Bv32'(src1, src2);
}

procedure {:inline 1} $MulBv32(src1: bv32, src2: bv32) returns (dst: bv32)
{
    if ($Lt'Bv32'($Mul'Bv32'(src1, src2), src1)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Mul'Bv32'(src1, src2);
}

procedure {:inline 1} $DivBv32(src1: bv32, src2: bv32) returns (dst: bv32)
{
    if (src2 == 0bv32) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Div'Bv32'(src1, src2);
}

procedure {:inline 1} $ModBv32(src1: bv32, src2: bv32) returns (dst: bv32)
{
    if (src2 == 0bv32) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Mod'Bv32'(src1, src2);
}

procedure {:inline 1} $AndBv32(src1: bv32, src2: bv32) returns (dst: bv32)
{
    dst := $And'Bv32'(src1,src2);
}

procedure {:inline 1} $OrBv32(src1: bv32, src2: bv32) returns (dst: bv32)
{
    dst := $Or'Bv32'(src1,src2);
}

procedure {:inline 1} $XorBv32(src1: bv32, src2: bv32) returns (dst: bv32)
{
    dst := $Xor'Bv32'(src1,src2);
}

procedure {:inline 1} $LtBv32(src1: bv32, src2: bv32) returns (dst: bool)
{
    dst := $Lt'Bv32'(src1,src2);
}

procedure {:inline 1} $LeBv32(src1: bv32, src2: bv32) returns (dst: bool)
{
    dst := $Le'Bv32'(src1,src2);
}

procedure {:inline 1} $GtBv32(src1: bv32, src2: bv32) returns (dst: bool)
{
    dst := $Gt'Bv32'(src1,src2);
}

procedure {:inline 1} $GeBv32(src1: bv32, src2: bv32) returns (dst: bool)
{
    dst := $Ge'Bv32'(src1,src2);
}

function $IsValid'bv32'(v: bv32): bool {
  $Ge'Bv32'(v,0bv32) && $Le'Bv32'(v,2147483647bv32)
}

function {:inline} $IsEqual'bv32'(x: bv32, y: bv32): bool {
    x == y
}

procedure {:inline 1} $int2bv32(src: int) returns (dst: bv32)
{
    if (src > 2147483647) {
        call $ExecFailureAbort();
        return;
    }
    dst := $int2bv.32(src);
}

procedure {:inline 1} $bv2int32(src: bv32) returns (dst: int)
{
    dst := $bv2int.32(src);
}

function {:builtin "(_ int2bv 32)"} $int2bv.32(i: int) returns (bv32);
function {:builtin "bv2nat"} $bv2int.32(i: bv32) returns (int);

function {:bvbuiltin "bvand"} $And'Bv64'(bv64,bv64) returns(bv64);
function {:bvbuiltin "bvor"} $Or'Bv64'(bv64,bv64) returns(bv64);
function {:bvbuiltin "bvxor"} $Xor'Bv64'(bv64,bv64) returns(bv64);
function {:bvbuiltin "bvadd"} $Add'Bv64'(bv64,bv64) returns(bv64);
function {:bvbuiltin "bvsub"} $Sub'Bv64'(bv64,bv64) returns(bv64);
function {:bvbuiltin "bvmul"} $Mul'Bv64'(bv64,bv64) returns(bv64);
function {:bvbuiltin "bvudiv"} $Div'Bv64'(bv64,bv64) returns(bv64);
function {:bvbuiltin "bvurem"} $Mod'Bv64'(bv64,bv64) returns(bv64);
function {:bvbuiltin "bvshl"} $Shl'Bv64'(bv64,bv64) returns(bv64);
function {:bvbuiltin "bvlshr"} $Shr'Bv64'(bv64,bv64) returns(bv64);
function {:bvbuiltin "bvult"} $Lt'Bv64'(bv64,bv64) returns(bool);
function {:bvbuiltin "bvule"} $Le'Bv64'(bv64,bv64) returns(bool);
function {:bvbuiltin "bvugt"} $Gt'Bv64'(bv64,bv64) returns(bool);
function {:bvbuiltin "bvuge"} $Ge'Bv64'(bv64,bv64) returns(bool);

procedure {:inline 1} $AddBv64(src1: bv64, src2: bv64) returns (dst: bv64)
{
    if ($Lt'Bv64'($Add'Bv64'(src1, src2), src1)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Add'Bv64'(src1, src2);
}

procedure {:inline 1} $AddBv64_unchecked(src1: bv64, src2: bv64) returns (dst: bv64)
{
    dst := $Add'Bv64'(src1, src2);
}

procedure {:inline 1} $SubBv64(src1: bv64, src2: bv64) returns (dst: bv64)
{
    if ($Lt'Bv64'(src1, src2)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Sub'Bv64'(src1, src2);
}

procedure {:inline 1} $MulBv64(src1: bv64, src2: bv64) returns (dst: bv64)
{
    if ($Lt'Bv64'($Mul'Bv64'(src1, src2), src1)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Mul'Bv64'(src1, src2);
}

procedure {:inline 1} $DivBv64(src1: bv64, src2: bv64) returns (dst: bv64)
{
    if (src2 == 0bv64) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Div'Bv64'(src1, src2);
}

procedure {:inline 1} $ModBv64(src1: bv64, src2: bv64) returns (dst: bv64)
{
    if (src2 == 0bv64) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Mod'Bv64'(src1, src2);
}

procedure {:inline 1} $AndBv64(src1: bv64, src2: bv64) returns (dst: bv64)
{
    dst := $And'Bv64'(src1,src2);
}

procedure {:inline 1} $OrBv64(src1: bv64, src2: bv64) returns (dst: bv64)
{
    dst := $Or'Bv64'(src1,src2);
}

procedure {:inline 1} $XorBv64(src1: bv64, src2: bv64) returns (dst: bv64)
{
    dst := $Xor'Bv64'(src1,src2);
}

procedure {:inline 1} $LtBv64(src1: bv64, src2: bv64) returns (dst: bool)
{
    dst := $Lt'Bv64'(src1,src2);
}

procedure {:inline 1} $LeBv64(src1: bv64, src2: bv64) returns (dst: bool)
{
    dst := $Le'Bv64'(src1,src2);
}

procedure {:inline 1} $GtBv64(src1: bv64, src2: bv64) returns (dst: bool)
{
    dst := $Gt'Bv64'(src1,src2);
}

procedure {:inline 1} $GeBv64(src1: bv64, src2: bv64) returns (dst: bool)
{
    dst := $Ge'Bv64'(src1,src2);
}

function $IsValid'bv64'(v: bv64): bool {
  $Ge'Bv64'(v,0bv64) && $Le'Bv64'(v,18446744073709551615bv64)
}

function {:inline} $IsEqual'bv64'(x: bv64, y: bv64): bool {
    x == y
}

procedure {:inline 1} $int2bv64(src: int) returns (dst: bv64)
{
    if (src > 18446744073709551615) {
        call $ExecFailureAbort();
        return;
    }
    dst := $int2bv.64(src);
}

procedure {:inline 1} $bv2int64(src: bv64) returns (dst: int)
{
    dst := $bv2int.64(src);
}

function {:builtin "(_ int2bv 64)"} $int2bv.64(i: int) returns (bv64);
function {:builtin "bv2nat"} $bv2int.64(i: bv64) returns (int);

function {:bvbuiltin "bvand"} $And'Bv128'(bv128,bv128) returns(bv128);
function {:bvbuiltin "bvor"} $Or'Bv128'(bv128,bv128) returns(bv128);
function {:bvbuiltin "bvxor"} $Xor'Bv128'(bv128,bv128) returns(bv128);
function {:bvbuiltin "bvadd"} $Add'Bv128'(bv128,bv128) returns(bv128);
function {:bvbuiltin "bvsub"} $Sub'Bv128'(bv128,bv128) returns(bv128);
function {:bvbuiltin "bvmul"} $Mul'Bv128'(bv128,bv128) returns(bv128);
function {:bvbuiltin "bvudiv"} $Div'Bv128'(bv128,bv128) returns(bv128);
function {:bvbuiltin "bvurem"} $Mod'Bv128'(bv128,bv128) returns(bv128);
function {:bvbuiltin "bvshl"} $Shl'Bv128'(bv128,bv128) returns(bv128);
function {:bvbuiltin "bvlshr"} $Shr'Bv128'(bv128,bv128) returns(bv128);
function {:bvbuiltin "bvult"} $Lt'Bv128'(bv128,bv128) returns(bool);
function {:bvbuiltin "bvule"} $Le'Bv128'(bv128,bv128) returns(bool);
function {:bvbuiltin "bvugt"} $Gt'Bv128'(bv128,bv128) returns(bool);
function {:bvbuiltin "bvuge"} $Ge'Bv128'(bv128,bv128) returns(bool);

procedure {:inline 1} $AddBv128(src1: bv128, src2: bv128) returns (dst: bv128)
{
    if ($Lt'Bv128'($Add'Bv128'(src1, src2), src1)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Add'Bv128'(src1, src2);
}

procedure {:inline 1} $AddBv128_unchecked(src1: bv128, src2: bv128) returns (dst: bv128)
{
    dst := $Add'Bv128'(src1, src2);
}

procedure {:inline 1} $SubBv128(src1: bv128, src2: bv128) returns (dst: bv128)
{
    if ($Lt'Bv128'(src1, src2)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Sub'Bv128'(src1, src2);
}

procedure {:inline 1} $MulBv128(src1: bv128, src2: bv128) returns (dst: bv128)
{
    if ($Lt'Bv128'($Mul'Bv128'(src1, src2), src1)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Mul'Bv128'(src1, src2);
}

procedure {:inline 1} $DivBv128(src1: bv128, src2: bv128) returns (dst: bv128)
{
    if (src2 == 0bv128) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Div'Bv128'(src1, src2);
}

procedure {:inline 1} $ModBv128(src1: bv128, src2: bv128) returns (dst: bv128)
{
    if (src2 == 0bv128) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Mod'Bv128'(src1, src2);
}

procedure {:inline 1} $AndBv128(src1: bv128, src2: bv128) returns (dst: bv128)
{
    dst := $And'Bv128'(src1,src2);
}

procedure {:inline 1} $OrBv128(src1: bv128, src2: bv128) returns (dst: bv128)
{
    dst := $Or'Bv128'(src1,src2);
}

procedure {:inline 1} $XorBv128(src1: bv128, src2: bv128) returns (dst: bv128)
{
    dst := $Xor'Bv128'(src1,src2);
}

procedure {:inline 1} $LtBv128(src1: bv128, src2: bv128) returns (dst: bool)
{
    dst := $Lt'Bv128'(src1,src2);
}

procedure {:inline 1} $LeBv128(src1: bv128, src2: bv128) returns (dst: bool)
{
    dst := $Le'Bv128'(src1,src2);
}

procedure {:inline 1} $GtBv128(src1: bv128, src2: bv128) returns (dst: bool)
{
    dst := $Gt'Bv128'(src1,src2);
}

procedure {:inline 1} $GeBv128(src1: bv128, src2: bv128) returns (dst: bool)
{
    dst := $Ge'Bv128'(src1,src2);
}

function $IsValid'bv128'(v: bv128): bool {
  $Ge'Bv128'(v,0bv128) && $Le'Bv128'(v,340282366920938463463374607431768211455bv128)
}

function {:inline} $IsEqual'bv128'(x: bv128, y: bv128): bool {
    x == y
}

procedure {:inline 1} $int2bv128(src: int) returns (dst: bv128)
{
    if (src > 340282366920938463463374607431768211455) {
        call $ExecFailureAbort();
        return;
    }
    dst := $int2bv.128(src);
}

procedure {:inline 1} $bv2int128(src: bv128) returns (dst: int)
{
    dst := $bv2int.128(src);
}

function {:builtin "(_ int2bv 128)"} $int2bv.128(i: int) returns (bv128);
function {:builtin "bv2nat"} $bv2int.128(i: bv128) returns (int);

function {:bvbuiltin "bvand"} $And'Bv256'(bv256,bv256) returns(bv256);
function {:bvbuiltin "bvor"} $Or'Bv256'(bv256,bv256) returns(bv256);
function {:bvbuiltin "bvxor"} $Xor'Bv256'(bv256,bv256) returns(bv256);
function {:bvbuiltin "bvadd"} $Add'Bv256'(bv256,bv256) returns(bv256);
function {:bvbuiltin "bvsub"} $Sub'Bv256'(bv256,bv256) returns(bv256);
function {:bvbuiltin "bvmul"} $Mul'Bv256'(bv256,bv256) returns(bv256);
function {:bvbuiltin "bvudiv"} $Div'Bv256'(bv256,bv256) returns(bv256);
function {:bvbuiltin "bvurem"} $Mod'Bv256'(bv256,bv256) returns(bv256);
function {:bvbuiltin "bvshl"} $Shl'Bv256'(bv256,bv256) returns(bv256);
function {:bvbuiltin "bvlshr"} $Shr'Bv256'(bv256,bv256) returns(bv256);
function {:bvbuiltin "bvult"} $Lt'Bv256'(bv256,bv256) returns(bool);
function {:bvbuiltin "bvule"} $Le'Bv256'(bv256,bv256) returns(bool);
function {:bvbuiltin "bvugt"} $Gt'Bv256'(bv256,bv256) returns(bool);
function {:bvbuiltin "bvuge"} $Ge'Bv256'(bv256,bv256) returns(bool);

procedure {:inline 1} $AddBv256(src1: bv256, src2: bv256) returns (dst: bv256)
{
    if ($Lt'Bv256'($Add'Bv256'(src1, src2), src1)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Add'Bv256'(src1, src2);
}

procedure {:inline 1} $AddBv256_unchecked(src1: bv256, src2: bv256) returns (dst: bv256)
{
    dst := $Add'Bv256'(src1, src2);
}

procedure {:inline 1} $SubBv256(src1: bv256, src2: bv256) returns (dst: bv256)
{
    if ($Lt'Bv256'(src1, src2)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Sub'Bv256'(src1, src2);
}

procedure {:inline 1} $MulBv256(src1: bv256, src2: bv256) returns (dst: bv256)
{
    if ($Lt'Bv256'($Mul'Bv256'(src1, src2), src1)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Mul'Bv256'(src1, src2);
}

procedure {:inline 1} $DivBv256(src1: bv256, src2: bv256) returns (dst: bv256)
{
    if (src2 == 0bv256) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Div'Bv256'(src1, src2);
}

procedure {:inline 1} $ModBv256(src1: bv256, src2: bv256) returns (dst: bv256)
{
    if (src2 == 0bv256) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Mod'Bv256'(src1, src2);
}

procedure {:inline 1} $AndBv256(src1: bv256, src2: bv256) returns (dst: bv256)
{
    dst := $And'Bv256'(src1,src2);
}

procedure {:inline 1} $OrBv256(src1: bv256, src2: bv256) returns (dst: bv256)
{
    dst := $Or'Bv256'(src1,src2);
}

procedure {:inline 1} $XorBv256(src1: bv256, src2: bv256) returns (dst: bv256)
{
    dst := $Xor'Bv256'(src1,src2);
}

procedure {:inline 1} $LtBv256(src1: bv256, src2: bv256) returns (dst: bool)
{
    dst := $Lt'Bv256'(src1,src2);
}

procedure {:inline 1} $LeBv256(src1: bv256, src2: bv256) returns (dst: bool)
{
    dst := $Le'Bv256'(src1,src2);
}

procedure {:inline 1} $GtBv256(src1: bv256, src2: bv256) returns (dst: bool)
{
    dst := $Gt'Bv256'(src1,src2);
}

procedure {:inline 1} $GeBv256(src1: bv256, src2: bv256) returns (dst: bool)
{
    dst := $Ge'Bv256'(src1,src2);
}

function $IsValid'bv256'(v: bv256): bool {
  $Ge'Bv256'(v,0bv256) && $Le'Bv256'(v,115792089237316195423570985008687907853269984665640564039457584007913129639935bv256)
}

function {:inline} $IsEqual'bv256'(x: bv256, y: bv256): bool {
    x == y
}

procedure {:inline 1} $int2bv256(src: int) returns (dst: bv256)
{
    if (src > 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
        call $ExecFailureAbort();
        return;
    }
    dst := $int2bv.256(src);
}

procedure {:inline 1} $bv2int256(src: bv256) returns (dst: int)
{
    dst := $bv2int.256(src);
}

function {:builtin "(_ int2bv 256)"} $int2bv.256(i: int) returns (bv256);
function {:builtin "bv2nat"} $bv2int.256(i: bv256) returns (int);

datatype $Range {
    $Range(lb: int, ub: int)
}

function {:inline} $IsValid'bool'(v: bool): bool {
  true
}

function $IsValid'u8'(v: int): bool {
  v >= 0 && v <= $MAX_U8
}

function $IsValid'u16'(v: int): bool {
  v >= 0 && v <= $MAX_U16
}

function $IsValid'u32'(v: int): bool {
  v >= 0 && v <= $MAX_U32
}

function $IsValid'u64'(v: int): bool {
  v >= 0 && v <= $MAX_U64
}

function $IsValid'u128'(v: int): bool {
  v >= 0 && v <= $MAX_U128
}

function $IsValid'u256'(v: int): bool {
  v >= 0 && v <= $MAX_U256
}

function $IsValid'num'(v: int): bool {
  true
}

function $IsValid'address'(v: int): bool {
  // TODO: restrict max to representable addresses?
  v >= 0
}

function {:inline} $IsValidRange(r: $Range): bool {
   $IsValid'u64'(r->lb) &&  $IsValid'u64'(r->ub)
}

// Intentionally not inlined so it serves as a trigger in quantifiers.
function $InRange(r: $Range, i: int): bool {
   r->lb <= i && i < r->ub
}


function {:inline} $IsEqual'u8'(x: int, y: int): bool {
    x == y
}

function {:inline} $IsEqual'u16'(x: int, y: int): bool {
    x == y
}

function {:inline} $IsEqual'u32'(x: int, y: int): bool {
    x == y
}

function {:inline} $IsEqual'u64'(x: int, y: int): bool {
    x == y
}

function {:inline} $IsEqual'u128'(x: int, y: int): bool {
    x == y
}

function {:inline} $IsEqual'u256'(x: int, y: int): bool {
    x == y
}

function {:inline} $IsEqual'num'(x: int, y: int): bool {
    x == y
}

function {:inline} $IsEqual'address'(x: int, y: int): bool {
    x == y
}

function {:inline} $IsEqual'bool'(x: bool, y: bool): bool {
    x == y
}

// ============================================================================================
// Memory

datatype $Location {
    // A global resource location within the statically known resource type's memory,
    // where `a` is an address.
    $Global(a: int),
    // A local location. `i` is the unique index of the local.
    $Local(i: int),
    // The location of a reference outside of the verification scope, for example, a `&mut` parameter
    // of the function being verified. References with these locations don't need to be written back
    // when mutation ends.
    $Param(i: int),
    // The location of an uninitialized mutation. Using this to make sure that the location
    // will not be equal to any valid mutation locations, i.e., $Local, $Global, or $Param.
    $Uninitialized()
}

// A mutable reference which also carries its current value. Since mutable references
// are single threaded in Move, we can keep them together and treat them as a value
// during mutation until the point they are stored back to their original location.
datatype $Mutation<T> {
    $Mutation(l: $Location, p: Vec int, v: T)
}

// Representation of memory for a given type.
datatype $Memory<T> {
    $Memory(domain: [int]bool, contents: [int]T)
}

function {:builtin "MapConst"} $ConstMemoryDomain(v: bool): [int]bool;
function {:builtin "MapConst"} $ConstMemoryContent<T>(v: T): [int]T;
axiom $ConstMemoryDomain(false) == (lambda i: int :: false);
axiom $ConstMemoryDomain(true) == (lambda i: int :: true);


// Dereferences a mutation.
function {:inline} $Dereference<T>(ref: $Mutation T): T {
    ref->v
}

// Update the value of a mutation.
function {:inline} $UpdateMutation<T>(m: $Mutation T, v: T): $Mutation T {
    $Mutation(m->l, m->p, v)
}

function {:inline} $ChildMutation<T1, T2>(m: $Mutation T1, offset: int, v: T2): $Mutation T2 {
    $Mutation(m->l, ExtendVec(m->p, offset), v)
}

// Return true if two mutations share the location and path
function {:inline} $IsSameMutation<T1, T2>(parent: $Mutation T1, child: $Mutation T2 ): bool {
    parent->l == child->l && parent->p == child->p
}

// Return true if the mutation is a parent of a child which was derived with the given edge offset. This
// is used to implement write-back choices.
function {:inline} $IsParentMutation<T1, T2>(parent: $Mutation T1, edge: int, child: $Mutation T2 ): bool {
    parent->l == child->l &&
    (var pp := parent->p;
    (var cp := child->p;
    (var pl := LenVec(pp);
    (var cl := LenVec(cp);
     cl == pl + 1 &&
     (forall i: int:: i >= 0 && i < pl ==> ReadVec(pp, i) ==  ReadVec(cp, i)) &&
     $EdgeMatches(ReadVec(cp, pl), edge)
    ))))
}

// Return true if the mutation is a parent of a child, for hyper edge.
function {:inline} $IsParentMutationHyper<T1, T2>(parent: $Mutation T1, hyper_edge: Vec int, child: $Mutation T2 ): bool {
    parent->l == child->l &&
    (var pp := parent->p;
    (var cp := child->p;
    (var pl := LenVec(pp);
    (var cl := LenVec(cp);
    (var el := LenVec(hyper_edge);
     cl == pl + el &&
     (forall i: int:: i >= 0 && i < pl ==> ReadVec(pp, i) == ReadVec(cp, i)) &&
     (forall i: int:: i >= 0 && i < el ==> $EdgeMatches(ReadVec(cp, pl + i), ReadVec(hyper_edge, i)))
    )))))
}

function {:inline} $EdgeMatches(edge: int, edge_pattern: int): bool {
    edge_pattern == -1 // wildcard
    || edge_pattern == edge
}



function {:inline} $SameLocation<T1, T2>(m1: $Mutation T1, m2: $Mutation T2): bool {
    m1->l == m2->l
}

function {:inline} $HasGlobalLocation<T>(m: $Mutation T): bool {
    (m->l) is $Global
}

function {:inline} $HasLocalLocation<T>(m: $Mutation T, idx: int): bool {
    m->l == $Local(idx)
}

function {:inline} $GlobalLocationAddress<T>(m: $Mutation T): int {
    (m->l)->a
}



// Tests whether resource exists.
function {:inline} $ResourceExists<T>(m: $Memory T, addr: int): bool {
    m->domain[addr]
}

// Obtains Value of given resource.
function {:inline} $ResourceValue<T>(m: $Memory T, addr: int): T {
    m->contents[addr]
}

// Update resource.
function {:inline} $ResourceUpdate<T>(m: $Memory T, a: int, v: T): $Memory T {
    $Memory(m->domain[a := true], m->contents[a := v])
}

// Remove resource.
function {:inline} $ResourceRemove<T>(m: $Memory T, a: int): $Memory T {
    $Memory(m->domain[a := false], m->contents)
}

// Copies resource from memory s to m.
function {:inline} $ResourceCopy<T>(m: $Memory T, s: $Memory T, a: int): $Memory T {
    $Memory(m->domain[a := s->domain[a]],
            m->contents[a := s->contents[a]])
}



// ============================================================================================
// Abort Handling

var $abort_flag: bool;
var $abort_code: int;

function {:inline} $process_abort_code(code: int): int {
    code
}

const $EXEC_FAILURE_CODE: int;
axiom $EXEC_FAILURE_CODE == -1;

// TODO(wrwg): currently we map aborts of native functions like those for vectors also to
//   execution failure. This may need to be aligned with what the runtime actually does.

procedure {:inline 1} $ExecFailureAbort() {
    $abort_flag := true;
    $abort_code := $EXEC_FAILURE_CODE;
}

procedure {:inline 1} $Abort(code: int) {
    $abort_flag := true;
    $abort_code := code;
}

function {:inline} $StdError(cat: int, reason: int): int {
    reason * 256 + cat
}

procedure {:inline 1} $InitVerification() {
    // Set abort_flag to false, and havoc abort_code
    $abort_flag := false;
    havoc $abort_code;
    // Initialize event store
    call $InitEventStore();
}

// ============================================================================================
// Instructions


procedure {:inline 1} $CastU8(src: int) returns (dst: int)
{
    if (src > $MAX_U8) {
        call $ExecFailureAbort();
        return;
    }
    dst := src;
}

procedure {:inline 1} $CastU16(src: int) returns (dst: int)
{
    if (src > $MAX_U16) {
        call $ExecFailureAbort();
        return;
    }
    dst := src;
}

procedure {:inline 1} $CastU32(src: int) returns (dst: int)
{
    if (src > $MAX_U32) {
        call $ExecFailureAbort();
        return;
    }
    dst := src;
}

procedure {:inline 1} $CastU64(src: int) returns (dst: int)
{
    if (src > $MAX_U64) {
        call $ExecFailureAbort();
        return;
    }
    dst := src;
}

procedure {:inline 1} $CastU128(src: int) returns (dst: int)
{
    if (src > $MAX_U128) {
        call $ExecFailureAbort();
        return;
    }
    dst := src;
}

procedure {:inline 1} $CastU256(src: int) returns (dst: int)
{
    if (src > $MAX_U256) {
        call $ExecFailureAbort();
        return;
    }
    dst := src;
}

procedure {:inline 1} $AddU8(src1: int, src2: int) returns (dst: int)
{
    if (src1 + src2 > $MAX_U8) {
        call $ExecFailureAbort();
        return;
    }
    dst := src1 + src2;
}

procedure {:inline 1} $AddU16(src1: int, src2: int) returns (dst: int)
{
    if (src1 + src2 > $MAX_U16) {
        call $ExecFailureAbort();
        return;
    }
    dst := src1 + src2;
}

procedure {:inline 1} $AddU16_unchecked(src1: int, src2: int) returns (dst: int)
{
    dst := src1 + src2;
}

procedure {:inline 1} $AddU32(src1: int, src2: int) returns (dst: int)
{
    if (src1 + src2 > $MAX_U32) {
        call $ExecFailureAbort();
        return;
    }
    dst := src1 + src2;
}

procedure {:inline 1} $AddU32_unchecked(src1: int, src2: int) returns (dst: int)
{
    dst := src1 + src2;
}

procedure {:inline 1} $AddU64(src1: int, src2: int) returns (dst: int)
{
    if (src1 + src2 > $MAX_U64) {
        call $ExecFailureAbort();
        return;
    }
    dst := src1 + src2;
}

procedure {:inline 1} $AddU64_unchecked(src1: int, src2: int) returns (dst: int)
{
    dst := src1 + src2;
}

procedure {:inline 1} $AddU128(src1: int, src2: int) returns (dst: int)
{
    if (src1 + src2 > $MAX_U128) {
        call $ExecFailureAbort();
        return;
    }
    dst := src1 + src2;
}

procedure {:inline 1} $AddU128_unchecked(src1: int, src2: int) returns (dst: int)
{
    dst := src1 + src2;
}

procedure {:inline 1} $AddU256(src1: int, src2: int) returns (dst: int)
{
    if (src1 + src2 > $MAX_U256) {
        call $ExecFailureAbort();
        return;
    }
    dst := src1 + src2;
}

procedure {:inline 1} $AddU256_unchecked(src1: int, src2: int) returns (dst: int)
{
    dst := src1 + src2;
}

procedure {:inline 1} $Sub(src1: int, src2: int) returns (dst: int)
{
    if (src1 < src2) {
        call $ExecFailureAbort();
        return;
    }
    dst := src1 - src2;
}

// uninterpreted function to return an undefined value.
function $undefined_int(): int;

// Recursive exponentiation function
// Undefined unless e >=0.  $pow(0,0) is also undefined.
function $pow(n: int, e: int): int {
    if n != 0 && e == 0 then 1
    else if e > 0 then n * $pow(n, e - 1)
    else $undefined_int()
}

function $shl(src1: int, p: int): int {
    src1 * $pow(2, p)
}

function $shlU8(src1: int, p: int): int {
    (src1 * $pow(2, p)) mod 256
}

function $shlU16(src1: int, p: int): int {
    (src1 * $pow(2, p)) mod 65536
}

function $shlU32(src1: int, p: int): int {
    (src1 * $pow(2, p)) mod 4294967296
}

function $shlU64(src1: int, p: int): int {
    (src1 * $pow(2, p)) mod 18446744073709551616
}

function $shlU128(src1: int, p: int): int {
    (src1 * $pow(2, p)) mod 340282366920938463463374607431768211456
}

function $shlU256(src1: int, p: int): int {
    (src1 * $pow(2, p)) mod 115792089237316195423570985008687907853269984665640564039457584007913129639936
}

function $shr(src1: int, p: int): int {
    src1 div $pow(2, p)
}

// We need to know the size of the destination in order to drop bits
// that have been shifted left more than that, so we have $ShlU8/16/32/64/128/256
procedure {:inline 1} $ShlU8(src1: int, src2: int) returns (dst: int)
{
    var res: int;
    // src2 is a u8
    assume src2 >= 0 && src2 < 256;
    if (src2 >= 8) {
        call $ExecFailureAbort();
        return;
    }
    dst := $shlU8(src1, src2);
}

// Template for cast and shift operations of bitvector types

procedure {:inline 1} $CastBv8to8(src: bv8) returns (dst: bv8)
{
    dst := src;
}


function $shlBv8From8(src1: bv8, src2: bv8) returns (bv8)
{
    $Shl'Bv8'(src1, src2)
}

procedure {:inline 1} $ShlBv8From8(src1: bv8, src2: bv8) returns (dst: bv8)
{
    if ($Ge'Bv8'(src2, 8bv8)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv8'(src1, src2);
}

function $shrBv8From8(src1: bv8, src2: bv8) returns (bv8)
{
    $Shr'Bv8'(src1, src2)
}

procedure {:inline 1} $ShrBv8From8(src1: bv8, src2: bv8) returns (dst: bv8)
{
    if ($Ge'Bv8'(src2, 8bv8)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv8'(src1, src2);
}

procedure {:inline 1} $CastBv16to8(src: bv16) returns (dst: bv8)
{
    if ($Gt'Bv16'(src, 255bv16)) {
            call $ExecFailureAbort();
            return;
    }
    dst := src[8:0];
}


function $shlBv8From16(src1: bv8, src2: bv16) returns (bv8)
{
    $Shl'Bv8'(src1, src2[8:0])
}

procedure {:inline 1} $ShlBv8From16(src1: bv8, src2: bv16) returns (dst: bv8)
{
    if ($Ge'Bv16'(src2, 8bv16)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv8'(src1, src2[8:0]);
}

function $shrBv8From16(src1: bv8, src2: bv16) returns (bv8)
{
    $Shr'Bv8'(src1, src2[8:0])
}

procedure {:inline 1} $ShrBv8From16(src1: bv8, src2: bv16) returns (dst: bv8)
{
    if ($Ge'Bv16'(src2, 8bv16)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv8'(src1, src2[8:0]);
}

procedure {:inline 1} $CastBv32to8(src: bv32) returns (dst: bv8)
{
    if ($Gt'Bv32'(src, 255bv32)) {
            call $ExecFailureAbort();
            return;
    }
    dst := src[8:0];
}


function $shlBv8From32(src1: bv8, src2: bv32) returns (bv8)
{
    $Shl'Bv8'(src1, src2[8:0])
}

procedure {:inline 1} $ShlBv8From32(src1: bv8, src2: bv32) returns (dst: bv8)
{
    if ($Ge'Bv32'(src2, 8bv32)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv8'(src1, src2[8:0]);
}

function $shrBv8From32(src1: bv8, src2: bv32) returns (bv8)
{
    $Shr'Bv8'(src1, src2[8:0])
}

procedure {:inline 1} $ShrBv8From32(src1: bv8, src2: bv32) returns (dst: bv8)
{
    if ($Ge'Bv32'(src2, 8bv32)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv8'(src1, src2[8:0]);
}

procedure {:inline 1} $CastBv64to8(src: bv64) returns (dst: bv8)
{
    if ($Gt'Bv64'(src, 255bv64)) {
            call $ExecFailureAbort();
            return;
    }
    dst := src[8:0];
}


function $shlBv8From64(src1: bv8, src2: bv64) returns (bv8)
{
    $Shl'Bv8'(src1, src2[8:0])
}

procedure {:inline 1} $ShlBv8From64(src1: bv8, src2: bv64) returns (dst: bv8)
{
    if ($Ge'Bv64'(src2, 8bv64)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv8'(src1, src2[8:0]);
}

function $shrBv8From64(src1: bv8, src2: bv64) returns (bv8)
{
    $Shr'Bv8'(src1, src2[8:0])
}

procedure {:inline 1} $ShrBv8From64(src1: bv8, src2: bv64) returns (dst: bv8)
{
    if ($Ge'Bv64'(src2, 8bv64)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv8'(src1, src2[8:0]);
}

procedure {:inline 1} $CastBv128to8(src: bv128) returns (dst: bv8)
{
    if ($Gt'Bv128'(src, 255bv128)) {
            call $ExecFailureAbort();
            return;
    }
    dst := src[8:0];
}


function $shlBv8From128(src1: bv8, src2: bv128) returns (bv8)
{
    $Shl'Bv8'(src1, src2[8:0])
}

procedure {:inline 1} $ShlBv8From128(src1: bv8, src2: bv128) returns (dst: bv8)
{
    if ($Ge'Bv128'(src2, 8bv128)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv8'(src1, src2[8:0]);
}

function $shrBv8From128(src1: bv8, src2: bv128) returns (bv8)
{
    $Shr'Bv8'(src1, src2[8:0])
}

procedure {:inline 1} $ShrBv8From128(src1: bv8, src2: bv128) returns (dst: bv8)
{
    if ($Ge'Bv128'(src2, 8bv128)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv8'(src1, src2[8:0]);
}

procedure {:inline 1} $CastBv256to8(src: bv256) returns (dst: bv8)
{
    if ($Gt'Bv256'(src, 255bv256)) {
            call $ExecFailureAbort();
            return;
    }
    dst := src[8:0];
}


function $shlBv8From256(src1: bv8, src2: bv256) returns (bv8)
{
    $Shl'Bv8'(src1, src2[8:0])
}

procedure {:inline 1} $ShlBv8From256(src1: bv8, src2: bv256) returns (dst: bv8)
{
    if ($Ge'Bv256'(src2, 8bv256)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv8'(src1, src2[8:0]);
}

function $shrBv8From256(src1: bv8, src2: bv256) returns (bv8)
{
    $Shr'Bv8'(src1, src2[8:0])
}

procedure {:inline 1} $ShrBv8From256(src1: bv8, src2: bv256) returns (dst: bv8)
{
    if ($Ge'Bv256'(src2, 8bv256)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv8'(src1, src2[8:0]);
}

procedure {:inline 1} $CastBv8to16(src: bv8) returns (dst: bv16)
{
    dst := 0bv8 ++ src;
}


function $shlBv16From8(src1: bv16, src2: bv8) returns (bv16)
{
    $Shl'Bv16'(src1, 0bv8 ++ src2)
}

procedure {:inline 1} $ShlBv16From8(src1: bv16, src2: bv8) returns (dst: bv16)
{
    if ($Ge'Bv8'(src2, 16bv8)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv16'(src1, 0bv8 ++ src2);
}

function $shrBv16From8(src1: bv16, src2: bv8) returns (bv16)
{
    $Shr'Bv16'(src1, 0bv8 ++ src2)
}

procedure {:inline 1} $ShrBv16From8(src1: bv16, src2: bv8) returns (dst: bv16)
{
    if ($Ge'Bv8'(src2, 16bv8)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv16'(src1, 0bv8 ++ src2);
}

procedure {:inline 1} $CastBv16to16(src: bv16) returns (dst: bv16)
{
    dst := src;
}


function $shlBv16From16(src1: bv16, src2: bv16) returns (bv16)
{
    $Shl'Bv16'(src1, src2)
}

procedure {:inline 1} $ShlBv16From16(src1: bv16, src2: bv16) returns (dst: bv16)
{
    if ($Ge'Bv16'(src2, 16bv16)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv16'(src1, src2);
}

function $shrBv16From16(src1: bv16, src2: bv16) returns (bv16)
{
    $Shr'Bv16'(src1, src2)
}

procedure {:inline 1} $ShrBv16From16(src1: bv16, src2: bv16) returns (dst: bv16)
{
    if ($Ge'Bv16'(src2, 16bv16)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv16'(src1, src2);
}

procedure {:inline 1} $CastBv32to16(src: bv32) returns (dst: bv16)
{
    if ($Gt'Bv32'(src, 65535bv32)) {
            call $ExecFailureAbort();
            return;
    }
    dst := src[16:0];
}


function $shlBv16From32(src1: bv16, src2: bv32) returns (bv16)
{
    $Shl'Bv16'(src1, src2[16:0])
}

procedure {:inline 1} $ShlBv16From32(src1: bv16, src2: bv32) returns (dst: bv16)
{
    if ($Ge'Bv32'(src2, 16bv32)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv16'(src1, src2[16:0]);
}

function $shrBv16From32(src1: bv16, src2: bv32) returns (bv16)
{
    $Shr'Bv16'(src1, src2[16:0])
}

procedure {:inline 1} $ShrBv16From32(src1: bv16, src2: bv32) returns (dst: bv16)
{
    if ($Ge'Bv32'(src2, 16bv32)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv16'(src1, src2[16:0]);
}

procedure {:inline 1} $CastBv64to16(src: bv64) returns (dst: bv16)
{
    if ($Gt'Bv64'(src, 65535bv64)) {
            call $ExecFailureAbort();
            return;
    }
    dst := src[16:0];
}


function $shlBv16From64(src1: bv16, src2: bv64) returns (bv16)
{
    $Shl'Bv16'(src1, src2[16:0])
}

procedure {:inline 1} $ShlBv16From64(src1: bv16, src2: bv64) returns (dst: bv16)
{
    if ($Ge'Bv64'(src2, 16bv64)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv16'(src1, src2[16:0]);
}

function $shrBv16From64(src1: bv16, src2: bv64) returns (bv16)
{
    $Shr'Bv16'(src1, src2[16:0])
}

procedure {:inline 1} $ShrBv16From64(src1: bv16, src2: bv64) returns (dst: bv16)
{
    if ($Ge'Bv64'(src2, 16bv64)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv16'(src1, src2[16:0]);
}

procedure {:inline 1} $CastBv128to16(src: bv128) returns (dst: bv16)
{
    if ($Gt'Bv128'(src, 65535bv128)) {
            call $ExecFailureAbort();
            return;
    }
    dst := src[16:0];
}


function $shlBv16From128(src1: bv16, src2: bv128) returns (bv16)
{
    $Shl'Bv16'(src1, src2[16:0])
}

procedure {:inline 1} $ShlBv16From128(src1: bv16, src2: bv128) returns (dst: bv16)
{
    if ($Ge'Bv128'(src2, 16bv128)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv16'(src1, src2[16:0]);
}

function $shrBv16From128(src1: bv16, src2: bv128) returns (bv16)
{
    $Shr'Bv16'(src1, src2[16:0])
}

procedure {:inline 1} $ShrBv16From128(src1: bv16, src2: bv128) returns (dst: bv16)
{
    if ($Ge'Bv128'(src2, 16bv128)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv16'(src1, src2[16:0]);
}

procedure {:inline 1} $CastBv256to16(src: bv256) returns (dst: bv16)
{
    if ($Gt'Bv256'(src, 65535bv256)) {
            call $ExecFailureAbort();
            return;
    }
    dst := src[16:0];
}


function $shlBv16From256(src1: bv16, src2: bv256) returns (bv16)
{
    $Shl'Bv16'(src1, src2[16:0])
}

procedure {:inline 1} $ShlBv16From256(src1: bv16, src2: bv256) returns (dst: bv16)
{
    if ($Ge'Bv256'(src2, 16bv256)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv16'(src1, src2[16:0]);
}

function $shrBv16From256(src1: bv16, src2: bv256) returns (bv16)
{
    $Shr'Bv16'(src1, src2[16:0])
}

procedure {:inline 1} $ShrBv16From256(src1: bv16, src2: bv256) returns (dst: bv16)
{
    if ($Ge'Bv256'(src2, 16bv256)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv16'(src1, src2[16:0]);
}

procedure {:inline 1} $CastBv8to32(src: bv8) returns (dst: bv32)
{
    dst := 0bv24 ++ src;
}


function $shlBv32From8(src1: bv32, src2: bv8) returns (bv32)
{
    $Shl'Bv32'(src1, 0bv24 ++ src2)
}

procedure {:inline 1} $ShlBv32From8(src1: bv32, src2: bv8) returns (dst: bv32)
{
    if ($Ge'Bv8'(src2, 32bv8)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv32'(src1, 0bv24 ++ src2);
}

function $shrBv32From8(src1: bv32, src2: bv8) returns (bv32)
{
    $Shr'Bv32'(src1, 0bv24 ++ src2)
}

procedure {:inline 1} $ShrBv32From8(src1: bv32, src2: bv8) returns (dst: bv32)
{
    if ($Ge'Bv8'(src2, 32bv8)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv32'(src1, 0bv24 ++ src2);
}

procedure {:inline 1} $CastBv16to32(src: bv16) returns (dst: bv32)
{
    dst := 0bv16 ++ src;
}


function $shlBv32From16(src1: bv32, src2: bv16) returns (bv32)
{
    $Shl'Bv32'(src1, 0bv16 ++ src2)
}

procedure {:inline 1} $ShlBv32From16(src1: bv32, src2: bv16) returns (dst: bv32)
{
    if ($Ge'Bv16'(src2, 32bv16)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv32'(src1, 0bv16 ++ src2);
}

function $shrBv32From16(src1: bv32, src2: bv16) returns (bv32)
{
    $Shr'Bv32'(src1, 0bv16 ++ src2)
}

procedure {:inline 1} $ShrBv32From16(src1: bv32, src2: bv16) returns (dst: bv32)
{
    if ($Ge'Bv16'(src2, 32bv16)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv32'(src1, 0bv16 ++ src2);
}

procedure {:inline 1} $CastBv32to32(src: bv32) returns (dst: bv32)
{
    dst := src;
}


function $shlBv32From32(src1: bv32, src2: bv32) returns (bv32)
{
    $Shl'Bv32'(src1, src2)
}

procedure {:inline 1} $ShlBv32From32(src1: bv32, src2: bv32) returns (dst: bv32)
{
    if ($Ge'Bv32'(src2, 32bv32)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv32'(src1, src2);
}

function $shrBv32From32(src1: bv32, src2: bv32) returns (bv32)
{
    $Shr'Bv32'(src1, src2)
}

procedure {:inline 1} $ShrBv32From32(src1: bv32, src2: bv32) returns (dst: bv32)
{
    if ($Ge'Bv32'(src2, 32bv32)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv32'(src1, src2);
}

procedure {:inline 1} $CastBv64to32(src: bv64) returns (dst: bv32)
{
    if ($Gt'Bv64'(src, 2147483647bv64)) {
            call $ExecFailureAbort();
            return;
    }
    dst := src[32:0];
}


function $shlBv32From64(src1: bv32, src2: bv64) returns (bv32)
{
    $Shl'Bv32'(src1, src2[32:0])
}

procedure {:inline 1} $ShlBv32From64(src1: bv32, src2: bv64) returns (dst: bv32)
{
    if ($Ge'Bv64'(src2, 32bv64)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv32'(src1, src2[32:0]);
}

function $shrBv32From64(src1: bv32, src2: bv64) returns (bv32)
{
    $Shr'Bv32'(src1, src2[32:0])
}

procedure {:inline 1} $ShrBv32From64(src1: bv32, src2: bv64) returns (dst: bv32)
{
    if ($Ge'Bv64'(src2, 32bv64)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv32'(src1, src2[32:0]);
}

procedure {:inline 1} $CastBv128to32(src: bv128) returns (dst: bv32)
{
    if ($Gt'Bv128'(src, 2147483647bv128)) {
            call $ExecFailureAbort();
            return;
    }
    dst := src[32:0];
}


function $shlBv32From128(src1: bv32, src2: bv128) returns (bv32)
{
    $Shl'Bv32'(src1, src2[32:0])
}

procedure {:inline 1} $ShlBv32From128(src1: bv32, src2: bv128) returns (dst: bv32)
{
    if ($Ge'Bv128'(src2, 32bv128)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv32'(src1, src2[32:0]);
}

function $shrBv32From128(src1: bv32, src2: bv128) returns (bv32)
{
    $Shr'Bv32'(src1, src2[32:0])
}

procedure {:inline 1} $ShrBv32From128(src1: bv32, src2: bv128) returns (dst: bv32)
{
    if ($Ge'Bv128'(src2, 32bv128)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv32'(src1, src2[32:0]);
}

procedure {:inline 1} $CastBv256to32(src: bv256) returns (dst: bv32)
{
    if ($Gt'Bv256'(src, 2147483647bv256)) {
            call $ExecFailureAbort();
            return;
    }
    dst := src[32:0];
}


function $shlBv32From256(src1: bv32, src2: bv256) returns (bv32)
{
    $Shl'Bv32'(src1, src2[32:0])
}

procedure {:inline 1} $ShlBv32From256(src1: bv32, src2: bv256) returns (dst: bv32)
{
    if ($Ge'Bv256'(src2, 32bv256)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv32'(src1, src2[32:0]);
}

function $shrBv32From256(src1: bv32, src2: bv256) returns (bv32)
{
    $Shr'Bv32'(src1, src2[32:0])
}

procedure {:inline 1} $ShrBv32From256(src1: bv32, src2: bv256) returns (dst: bv32)
{
    if ($Ge'Bv256'(src2, 32bv256)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv32'(src1, src2[32:0]);
}

procedure {:inline 1} $CastBv8to64(src: bv8) returns (dst: bv64)
{
    dst := 0bv56 ++ src;
}


function $shlBv64From8(src1: bv64, src2: bv8) returns (bv64)
{
    $Shl'Bv64'(src1, 0bv56 ++ src2)
}

procedure {:inline 1} $ShlBv64From8(src1: bv64, src2: bv8) returns (dst: bv64)
{
    if ($Ge'Bv8'(src2, 64bv8)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv64'(src1, 0bv56 ++ src2);
}

function $shrBv64From8(src1: bv64, src2: bv8) returns (bv64)
{
    $Shr'Bv64'(src1, 0bv56 ++ src2)
}

procedure {:inline 1} $ShrBv64From8(src1: bv64, src2: bv8) returns (dst: bv64)
{
    if ($Ge'Bv8'(src2, 64bv8)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv64'(src1, 0bv56 ++ src2);
}

procedure {:inline 1} $CastBv16to64(src: bv16) returns (dst: bv64)
{
    dst := 0bv48 ++ src;
}


function $shlBv64From16(src1: bv64, src2: bv16) returns (bv64)
{
    $Shl'Bv64'(src1, 0bv48 ++ src2)
}

procedure {:inline 1} $ShlBv64From16(src1: bv64, src2: bv16) returns (dst: bv64)
{
    if ($Ge'Bv16'(src2, 64bv16)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv64'(src1, 0bv48 ++ src2);
}

function $shrBv64From16(src1: bv64, src2: bv16) returns (bv64)
{
    $Shr'Bv64'(src1, 0bv48 ++ src2)
}

procedure {:inline 1} $ShrBv64From16(src1: bv64, src2: bv16) returns (dst: bv64)
{
    if ($Ge'Bv16'(src2, 64bv16)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv64'(src1, 0bv48 ++ src2);
}

procedure {:inline 1} $CastBv32to64(src: bv32) returns (dst: bv64)
{
    dst := 0bv32 ++ src;
}


function $shlBv64From32(src1: bv64, src2: bv32) returns (bv64)
{
    $Shl'Bv64'(src1, 0bv32 ++ src2)
}

procedure {:inline 1} $ShlBv64From32(src1: bv64, src2: bv32) returns (dst: bv64)
{
    if ($Ge'Bv32'(src2, 64bv32)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv64'(src1, 0bv32 ++ src2);
}

function $shrBv64From32(src1: bv64, src2: bv32) returns (bv64)
{
    $Shr'Bv64'(src1, 0bv32 ++ src2)
}

procedure {:inline 1} $ShrBv64From32(src1: bv64, src2: bv32) returns (dst: bv64)
{
    if ($Ge'Bv32'(src2, 64bv32)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv64'(src1, 0bv32 ++ src2);
}

procedure {:inline 1} $CastBv64to64(src: bv64) returns (dst: bv64)
{
    dst := src;
}


function $shlBv64From64(src1: bv64, src2: bv64) returns (bv64)
{
    $Shl'Bv64'(src1, src2)
}

procedure {:inline 1} $ShlBv64From64(src1: bv64, src2: bv64) returns (dst: bv64)
{
    if ($Ge'Bv64'(src2, 64bv64)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv64'(src1, src2);
}

function $shrBv64From64(src1: bv64, src2: bv64) returns (bv64)
{
    $Shr'Bv64'(src1, src2)
}

procedure {:inline 1} $ShrBv64From64(src1: bv64, src2: bv64) returns (dst: bv64)
{
    if ($Ge'Bv64'(src2, 64bv64)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv64'(src1, src2);
}

procedure {:inline 1} $CastBv128to64(src: bv128) returns (dst: bv64)
{
    if ($Gt'Bv128'(src, 18446744073709551615bv128)) {
            call $ExecFailureAbort();
            return;
    }
    dst := src[64:0];
}


function $shlBv64From128(src1: bv64, src2: bv128) returns (bv64)
{
    $Shl'Bv64'(src1, src2[64:0])
}

procedure {:inline 1} $ShlBv64From128(src1: bv64, src2: bv128) returns (dst: bv64)
{
    if ($Ge'Bv128'(src2, 64bv128)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv64'(src1, src2[64:0]);
}

function $shrBv64From128(src1: bv64, src2: bv128) returns (bv64)
{
    $Shr'Bv64'(src1, src2[64:0])
}

procedure {:inline 1} $ShrBv64From128(src1: bv64, src2: bv128) returns (dst: bv64)
{
    if ($Ge'Bv128'(src2, 64bv128)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv64'(src1, src2[64:0]);
}

procedure {:inline 1} $CastBv256to64(src: bv256) returns (dst: bv64)
{
    if ($Gt'Bv256'(src, 18446744073709551615bv256)) {
            call $ExecFailureAbort();
            return;
    }
    dst := src[64:0];
}


function $shlBv64From256(src1: bv64, src2: bv256) returns (bv64)
{
    $Shl'Bv64'(src1, src2[64:0])
}

procedure {:inline 1} $ShlBv64From256(src1: bv64, src2: bv256) returns (dst: bv64)
{
    if ($Ge'Bv256'(src2, 64bv256)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv64'(src1, src2[64:0]);
}

function $shrBv64From256(src1: bv64, src2: bv256) returns (bv64)
{
    $Shr'Bv64'(src1, src2[64:0])
}

procedure {:inline 1} $ShrBv64From256(src1: bv64, src2: bv256) returns (dst: bv64)
{
    if ($Ge'Bv256'(src2, 64bv256)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv64'(src1, src2[64:0]);
}

procedure {:inline 1} $CastBv8to128(src: bv8) returns (dst: bv128)
{
    dst := 0bv120 ++ src;
}


function $shlBv128From8(src1: bv128, src2: bv8) returns (bv128)
{
    $Shl'Bv128'(src1, 0bv120 ++ src2)
}

procedure {:inline 1} $ShlBv128From8(src1: bv128, src2: bv8) returns (dst: bv128)
{
    if ($Ge'Bv8'(src2, 128bv8)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv128'(src1, 0bv120 ++ src2);
}

function $shrBv128From8(src1: bv128, src2: bv8) returns (bv128)
{
    $Shr'Bv128'(src1, 0bv120 ++ src2)
}

procedure {:inline 1} $ShrBv128From8(src1: bv128, src2: bv8) returns (dst: bv128)
{
    if ($Ge'Bv8'(src2, 128bv8)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv128'(src1, 0bv120 ++ src2);
}

procedure {:inline 1} $CastBv16to128(src: bv16) returns (dst: bv128)
{
    dst := 0bv112 ++ src;
}


function $shlBv128From16(src1: bv128, src2: bv16) returns (bv128)
{
    $Shl'Bv128'(src1, 0bv112 ++ src2)
}

procedure {:inline 1} $ShlBv128From16(src1: bv128, src2: bv16) returns (dst: bv128)
{
    if ($Ge'Bv16'(src2, 128bv16)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv128'(src1, 0bv112 ++ src2);
}

function $shrBv128From16(src1: bv128, src2: bv16) returns (bv128)
{
    $Shr'Bv128'(src1, 0bv112 ++ src2)
}

procedure {:inline 1} $ShrBv128From16(src1: bv128, src2: bv16) returns (dst: bv128)
{
    if ($Ge'Bv16'(src2, 128bv16)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv128'(src1, 0bv112 ++ src2);
}

procedure {:inline 1} $CastBv32to128(src: bv32) returns (dst: bv128)
{
    dst := 0bv96 ++ src;
}


function $shlBv128From32(src1: bv128, src2: bv32) returns (bv128)
{
    $Shl'Bv128'(src1, 0bv96 ++ src2)
}

procedure {:inline 1} $ShlBv128From32(src1: bv128, src2: bv32) returns (dst: bv128)
{
    if ($Ge'Bv32'(src2, 128bv32)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv128'(src1, 0bv96 ++ src2);
}

function $shrBv128From32(src1: bv128, src2: bv32) returns (bv128)
{
    $Shr'Bv128'(src1, 0bv96 ++ src2)
}

procedure {:inline 1} $ShrBv128From32(src1: bv128, src2: bv32) returns (dst: bv128)
{
    if ($Ge'Bv32'(src2, 128bv32)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv128'(src1, 0bv96 ++ src2);
}

procedure {:inline 1} $CastBv64to128(src: bv64) returns (dst: bv128)
{
    dst := 0bv64 ++ src;
}


function $shlBv128From64(src1: bv128, src2: bv64) returns (bv128)
{
    $Shl'Bv128'(src1, 0bv64 ++ src2)
}

procedure {:inline 1} $ShlBv128From64(src1: bv128, src2: bv64) returns (dst: bv128)
{
    if ($Ge'Bv64'(src2, 128bv64)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv128'(src1, 0bv64 ++ src2);
}

function $shrBv128From64(src1: bv128, src2: bv64) returns (bv128)
{
    $Shr'Bv128'(src1, 0bv64 ++ src2)
}

procedure {:inline 1} $ShrBv128From64(src1: bv128, src2: bv64) returns (dst: bv128)
{
    if ($Ge'Bv64'(src2, 128bv64)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv128'(src1, 0bv64 ++ src2);
}

procedure {:inline 1} $CastBv128to128(src: bv128) returns (dst: bv128)
{
    dst := src;
}


function $shlBv128From128(src1: bv128, src2: bv128) returns (bv128)
{
    $Shl'Bv128'(src1, src2)
}

procedure {:inline 1} $ShlBv128From128(src1: bv128, src2: bv128) returns (dst: bv128)
{
    if ($Ge'Bv128'(src2, 128bv128)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv128'(src1, src2);
}

function $shrBv128From128(src1: bv128, src2: bv128) returns (bv128)
{
    $Shr'Bv128'(src1, src2)
}

procedure {:inline 1} $ShrBv128From128(src1: bv128, src2: bv128) returns (dst: bv128)
{
    if ($Ge'Bv128'(src2, 128bv128)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv128'(src1, src2);
}

procedure {:inline 1} $CastBv256to128(src: bv256) returns (dst: bv128)
{
    if ($Gt'Bv256'(src, 340282366920938463463374607431768211455bv256)) {
            call $ExecFailureAbort();
            return;
    }
    dst := src[128:0];
}


function $shlBv128From256(src1: bv128, src2: bv256) returns (bv128)
{
    $Shl'Bv128'(src1, src2[128:0])
}

procedure {:inline 1} $ShlBv128From256(src1: bv128, src2: bv256) returns (dst: bv128)
{
    if ($Ge'Bv256'(src2, 128bv256)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv128'(src1, src2[128:0]);
}

function $shrBv128From256(src1: bv128, src2: bv256) returns (bv128)
{
    $Shr'Bv128'(src1, src2[128:0])
}

procedure {:inline 1} $ShrBv128From256(src1: bv128, src2: bv256) returns (dst: bv128)
{
    if ($Ge'Bv256'(src2, 128bv256)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv128'(src1, src2[128:0]);
}

procedure {:inline 1} $CastBv8to256(src: bv8) returns (dst: bv256)
{
    dst := 0bv248 ++ src;
}


function $shlBv256From8(src1: bv256, src2: bv8) returns (bv256)
{
    $Shl'Bv256'(src1, 0bv248 ++ src2)
}

procedure {:inline 1} $ShlBv256From8(src1: bv256, src2: bv8) returns (dst: bv256)
{
    if ($Ge'Bv8'(src2, 256bv8)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv256'(src1, 0bv248 ++ src2);
}

function $shrBv256From8(src1: bv256, src2: bv8) returns (bv256)
{
    $Shr'Bv256'(src1, 0bv248 ++ src2)
}

procedure {:inline 1} $ShrBv256From8(src1: bv256, src2: bv8) returns (dst: bv256)
{
    if ($Ge'Bv8'(src2, 256bv8)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv256'(src1, 0bv248 ++ src2);
}

procedure {:inline 1} $CastBv16to256(src: bv16) returns (dst: bv256)
{
    dst := 0bv240 ++ src;
}


function $shlBv256From16(src1: bv256, src2: bv16) returns (bv256)
{
    $Shl'Bv256'(src1, 0bv240 ++ src2)
}

procedure {:inline 1} $ShlBv256From16(src1: bv256, src2: bv16) returns (dst: bv256)
{
    if ($Ge'Bv16'(src2, 256bv16)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv256'(src1, 0bv240 ++ src2);
}

function $shrBv256From16(src1: bv256, src2: bv16) returns (bv256)
{
    $Shr'Bv256'(src1, 0bv240 ++ src2)
}

procedure {:inline 1} $ShrBv256From16(src1: bv256, src2: bv16) returns (dst: bv256)
{
    if ($Ge'Bv16'(src2, 256bv16)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv256'(src1, 0bv240 ++ src2);
}

procedure {:inline 1} $CastBv32to256(src: bv32) returns (dst: bv256)
{
    dst := 0bv224 ++ src;
}


function $shlBv256From32(src1: bv256, src2: bv32) returns (bv256)
{
    $Shl'Bv256'(src1, 0bv224 ++ src2)
}

procedure {:inline 1} $ShlBv256From32(src1: bv256, src2: bv32) returns (dst: bv256)
{
    if ($Ge'Bv32'(src2, 256bv32)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv256'(src1, 0bv224 ++ src2);
}

function $shrBv256From32(src1: bv256, src2: bv32) returns (bv256)
{
    $Shr'Bv256'(src1, 0bv224 ++ src2)
}

procedure {:inline 1} $ShrBv256From32(src1: bv256, src2: bv32) returns (dst: bv256)
{
    if ($Ge'Bv32'(src2, 256bv32)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv256'(src1, 0bv224 ++ src2);
}

procedure {:inline 1} $CastBv64to256(src: bv64) returns (dst: bv256)
{
    dst := 0bv192 ++ src;
}


function $shlBv256From64(src1: bv256, src2: bv64) returns (bv256)
{
    $Shl'Bv256'(src1, 0bv192 ++ src2)
}

procedure {:inline 1} $ShlBv256From64(src1: bv256, src2: bv64) returns (dst: bv256)
{
    if ($Ge'Bv64'(src2, 256bv64)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv256'(src1, 0bv192 ++ src2);
}

function $shrBv256From64(src1: bv256, src2: bv64) returns (bv256)
{
    $Shr'Bv256'(src1, 0bv192 ++ src2)
}

procedure {:inline 1} $ShrBv256From64(src1: bv256, src2: bv64) returns (dst: bv256)
{
    if ($Ge'Bv64'(src2, 256bv64)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv256'(src1, 0bv192 ++ src2);
}

procedure {:inline 1} $CastBv128to256(src: bv128) returns (dst: bv256)
{
    dst := 0bv128 ++ src;
}


function $shlBv256From128(src1: bv256, src2: bv128) returns (bv256)
{
    $Shl'Bv256'(src1, 0bv128 ++ src2)
}

procedure {:inline 1} $ShlBv256From128(src1: bv256, src2: bv128) returns (dst: bv256)
{
    if ($Ge'Bv128'(src2, 256bv128)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv256'(src1, 0bv128 ++ src2);
}

function $shrBv256From128(src1: bv256, src2: bv128) returns (bv256)
{
    $Shr'Bv256'(src1, 0bv128 ++ src2)
}

procedure {:inline 1} $ShrBv256From128(src1: bv256, src2: bv128) returns (dst: bv256)
{
    if ($Ge'Bv128'(src2, 256bv128)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv256'(src1, 0bv128 ++ src2);
}

procedure {:inline 1} $CastBv256to256(src: bv256) returns (dst: bv256)
{
    dst := src;
}


function $shlBv256From256(src1: bv256, src2: bv256) returns (bv256)
{
    $Shl'Bv256'(src1, src2)
}

procedure {:inline 1} $ShlBv256From256(src1: bv256, src2: bv256) returns (dst: bv256)
{
    if ($Ge'Bv256'(src2, 256bv256)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shl'Bv256'(src1, src2);
}

function $shrBv256From256(src1: bv256, src2: bv256) returns (bv256)
{
    $Shr'Bv256'(src1, src2)
}

procedure {:inline 1} $ShrBv256From256(src1: bv256, src2: bv256) returns (dst: bv256)
{
    if ($Ge'Bv256'(src2, 256bv256)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Shr'Bv256'(src1, src2);
}

procedure {:inline 1} $ShlU16(src1: int, src2: int) returns (dst: int)
{
    var res: int;
    // src2 is a u8
    assume src2 >= 0 && src2 < 256;
    if (src2 >= 16) {
        call $ExecFailureAbort();
        return;
    }
    dst := $shlU16(src1, src2);
}

procedure {:inline 1} $ShlU32(src1: int, src2: int) returns (dst: int)
{
    var res: int;
    // src2 is a u8
    assume src2 >= 0 && src2 < 256;
    if (src2 >= 32) {
        call $ExecFailureAbort();
        return;
    }
    dst := $shlU32(src1, src2);
}

procedure {:inline 1} $ShlU64(src1: int, src2: int) returns (dst: int)
{
    var res: int;
    // src2 is a u8
    assume src2 >= 0 && src2 < 256;
    if (src2 >= 64) {
       call $ExecFailureAbort();
       return;
    }
    dst := $shlU64(src1, src2);
}

procedure {:inline 1} $ShlU128(src1: int, src2: int) returns (dst: int)
{
    var res: int;
    // src2 is a u8
    assume src2 >= 0 && src2 < 256;
    if (src2 >= 128) {
        call $ExecFailureAbort();
        return;
    }
    dst := $shlU128(src1, src2);
}

procedure {:inline 1} $ShlU256(src1: int, src2: int) returns (dst: int)
{
    var res: int;
    // src2 is a u8
    assume src2 >= 0 && src2 < 256;
    dst := $shlU256(src1, src2);
}

procedure {:inline 1} $Shr(src1: int, src2: int) returns (dst: int)
{
    var res: int;
    // src2 is a u8
    assume src2 >= 0 && src2 < 256;
    dst := $shr(src1, src2);
}

procedure {:inline 1} $ShrU8(src1: int, src2: int) returns (dst: int)
{
    var res: int;
    // src2 is a u8
    assume src2 >= 0 && src2 < 256;
    if (src2 >= 8) {
        call $ExecFailureAbort();
        return;
    }
    dst := $shr(src1, src2);
}

procedure {:inline 1} $ShrU16(src1: int, src2: int) returns (dst: int)
{
    var res: int;
    // src2 is a u8
    assume src2 >= 0 && src2 < 256;
    if (src2 >= 16) {
        call $ExecFailureAbort();
        return;
    }
    dst := $shr(src1, src2);
}

procedure {:inline 1} $ShrU32(src1: int, src2: int) returns (dst: int)
{
    var res: int;
    // src2 is a u8
    assume src2 >= 0 && src2 < 256;
    if (src2 >= 32) {
        call $ExecFailureAbort();
        return;
    }
    dst := $shr(src1, src2);
}

procedure {:inline 1} $ShrU64(src1: int, src2: int) returns (dst: int)
{
    var res: int;
    // src2 is a u8
    assume src2 >= 0 && src2 < 256;
    if (src2 >= 64) {
        call $ExecFailureAbort();
        return;
    }
    dst := $shr(src1, src2);
}

procedure {:inline 1} $ShrU128(src1: int, src2: int) returns (dst: int)
{
    var res: int;
    // src2 is a u8
    assume src2 >= 0 && src2 < 256;
    if (src2 >= 128) {
        call $ExecFailureAbort();
        return;
    }
    dst := $shr(src1, src2);
}

procedure {:inline 1} $ShrU256(src1: int, src2: int) returns (dst: int)
{
    var res: int;
    // src2 is a u8
    assume src2 >= 0 && src2 < 256;
    dst := $shr(src1, src2);
}

procedure {:inline 1} $MulU8(src1: int, src2: int) returns (dst: int)
{
    if (src1 * src2 > $MAX_U8) {
        call $ExecFailureAbort();
        return;
    }
    dst := src1 * src2;
}

procedure {:inline 1} $MulU16(src1: int, src2: int) returns (dst: int)
{
    if (src1 * src2 > $MAX_U16) {
        call $ExecFailureAbort();
        return;
    }
    dst := src1 * src2;
}

procedure {:inline 1} $MulU32(src1: int, src2: int) returns (dst: int)
{
    if (src1 * src2 > $MAX_U32) {
        call $ExecFailureAbort();
        return;
    }
    dst := src1 * src2;
}

procedure {:inline 1} $MulU64(src1: int, src2: int) returns (dst: int)
{
    if (src1 * src2 > $MAX_U64) {
        call $ExecFailureAbort();
        return;
    }
    dst := src1 * src2;
}

procedure {:inline 1} $MulU128(src1: int, src2: int) returns (dst: int)
{
    if (src1 * src2 > $MAX_U128) {
        call $ExecFailureAbort();
        return;
    }
    dst := src1 * src2;
}

procedure {:inline 1} $MulU256(src1: int, src2: int) returns (dst: int)
{
    if (src1 * src2 > $MAX_U256) {
        call $ExecFailureAbort();
        return;
    }
    dst := src1 * src2;
}

procedure {:inline 1} $Div(src1: int, src2: int) returns (dst: int)
{
    if (src2 == 0) {
        call $ExecFailureAbort();
        return;
    }
    dst := src1 div src2;
}

procedure {:inline 1} $Mod(src1: int, src2: int) returns (dst: int)
{
    if (src2 == 0) {
        call $ExecFailureAbort();
        return;
    }
    dst := src1 mod src2;
}

procedure {:inline 1} $ArithBinaryUnimplemented(src1: int, src2: int) returns (dst: int);

procedure {:inline 1} $Lt(src1: int, src2: int) returns (dst: bool)
{
    dst := src1 < src2;
}

procedure {:inline 1} $Gt(src1: int, src2: int) returns (dst: bool)
{
    dst := src1 > src2;
}

procedure {:inline 1} $Le(src1: int, src2: int) returns (dst: bool)
{
    dst := src1 <= src2;
}

procedure {:inline 1} $Ge(src1: int, src2: int) returns (dst: bool)
{
    dst := src1 >= src2;
}

procedure {:inline 1} $And(src1: bool, src2: bool) returns (dst: bool)
{
    dst := src1 && src2;
}

procedure {:inline 1} $Or(src1: bool, src2: bool) returns (dst: bool)
{
    dst := src1 || src2;
}

procedure {:inline 1} $Not(src: bool) returns (dst: bool)
{
    dst := !src;
}

// Pack and Unpack are auto-generated for each type T


// ==================================================================================
// Native Vector

function {:inline} $SliceVecByRange<T>(v: Vec T, r: $Range): Vec T {
    SliceVec(v, r->lb, r->ub)
}

// ----------------------------------------------------------------------------------
// Native Vector implementation for element type `#0`

// Not inlined. It appears faster this way.
function $IsEqual'vec'#0''(v1: Vec (#0), v2: Vec (#0)): bool {
    LenVec(v1) == LenVec(v2) &&
    (forall i: int:: InRangeVec(v1, i) ==> $IsEqual'#0'(ReadVec(v1, i), ReadVec(v2, i)))
}

// Not inlined.
function $IsPrefix'vec'#0''(v: Vec (#0), prefix: Vec (#0)): bool {
    LenVec(v) >= LenVec(prefix) &&
    (forall i: int:: InRangeVec(prefix, i) ==> $IsEqual'#0'(ReadVec(v, i), ReadVec(prefix, i)))
}

// Not inlined.
function $IsSuffix'vec'#0''(v: Vec (#0), suffix: Vec (#0)): bool {
    LenVec(v) >= LenVec(suffix) &&
    (forall i: int:: InRangeVec(suffix, i) ==> $IsEqual'#0'(ReadVec(v, LenVec(v) - LenVec(suffix) + i), ReadVec(suffix, i)))
}

// Not inlined.
function $IsValid'vec'#0''(v: Vec (#0)): bool {
    $IsValid'u64'(LenVec(v)) &&
    (forall i: int:: InRangeVec(v, i) ==> $IsValid'#0'(ReadVec(v, i)))
}


function {:inline} $ContainsVec'#0'(v: Vec (#0), e: #0): bool {
    (exists i: int :: $IsValid'u64'(i) && InRangeVec(v, i) && $IsEqual'#0'(ReadVec(v, i), e))
}

function $IndexOfVec'#0'(v: Vec (#0), e: #0): int;
axiom (forall v: Vec (#0), e: #0:: {$IndexOfVec'#0'(v, e)}
    (var i := $IndexOfVec'#0'(v, e);
     if (!$ContainsVec'#0'(v, e)) then i == -1
     else $IsValid'u64'(i) && InRangeVec(v, i) && $IsEqual'#0'(ReadVec(v, i), e) &&
        (forall j: int :: $IsValid'u64'(j) && j >= 0 && j < i ==> !$IsEqual'#0'(ReadVec(v, j), e))));


function {:inline} $RangeVec'#0'(v: Vec (#0)): $Range {
    $Range(0, LenVec(v))
}


function {:inline} $EmptyVec'#0'(): Vec (#0) {
    EmptyVec()
}

procedure {:inline 1} $1_vector_empty'#0'() returns (v: Vec (#0)) {
    v := EmptyVec();
}

function {:inline} $1_vector_$empty'#0'(): Vec (#0) {
    EmptyVec()
}

procedure {:inline 1} $1_vector_is_empty'#0'(v: Vec (#0)) returns (b: bool) {
    b := IsEmptyVec(v);
}

procedure {:inline 1} $1_vector_push_back'#0'(m: $Mutation (Vec (#0)), val: #0) returns (m': $Mutation (Vec (#0))) {
    m' := $UpdateMutation(m, ExtendVec($Dereference(m), val));
}

function {:inline} $1_vector_$push_back'#0'(v: Vec (#0), val: #0): Vec (#0) {
    ExtendVec(v, val)
}

procedure {:inline 1} $1_vector_pop_back'#0'(m: $Mutation (Vec (#0))) returns (e: #0, m': $Mutation (Vec (#0))) {
    var v: Vec (#0);
    var len: int;
    v := $Dereference(m);
    len := LenVec(v);
    if (len == 0) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, len-1);
    m' := $UpdateMutation(m, RemoveVec(v));
}

procedure {:inline 1} $1_vector_append'#0'(m: $Mutation (Vec (#0)), other: Vec (#0)) returns (m': $Mutation (Vec (#0))) {
    m' := $UpdateMutation(m, ConcatVec($Dereference(m), other));
}

procedure {:inline 1} $1_vector_reverse'#0'(m: $Mutation (Vec (#0))) returns (m': $Mutation (Vec (#0))) {
    m' := $UpdateMutation(m, ReverseVec($Dereference(m)));
}

procedure {:inline 1} $1_vector_reverse_append'#0'(m: $Mutation (Vec (#0)), other: Vec (#0)) returns (m': $Mutation (Vec (#0))) {
    m' := $UpdateMutation(m, ConcatVec($Dereference(m), ReverseVec(other)));
}

procedure {:inline 1} $1_vector_trim_reverse'#0'(m: $Mutation (Vec (#0)), new_len: int) returns (v: (Vec (#0)), m': $Mutation (Vec (#0))) {
    var len: int;
    v := $Dereference(m);
    if (LenVec(v) < new_len) {
        call $ExecFailureAbort();
        return;
    }
    v := SliceVec(v, new_len, LenVec(v));
    v := ReverseVec(v);
    m' := $UpdateMutation(m, SliceVec($Dereference(m), 0, new_len));
}

procedure {:inline 1} $1_vector_trim'#0'(m: $Mutation (Vec (#0)), new_len: int) returns (v: (Vec (#0)), m': $Mutation (Vec (#0))) {
    var len: int;
    v := $Dereference(m);
    if (LenVec(v) < new_len) {
        call $ExecFailureAbort();
        return;
    }
    v := SliceVec(v, new_len, LenVec(v));
    m' := $UpdateMutation(m, SliceVec($Dereference(m), 0, new_len));
}

procedure {:inline 1} $1_vector_reverse_slice'#0'(m: $Mutation (Vec (#0)), left: int, right: int) returns (m': $Mutation (Vec (#0))) {
    var left_vec: Vec (#0);
    var mid_vec: Vec (#0);
    var right_vec: Vec (#0);
    var v: Vec (#0);
    if (left > right) {
        call $ExecFailureAbort();
        return;
    }
    if (left == right) {
        m' := m;
        return;
    }
    v := $Dereference(m);
    if (!(right >= 0 && right <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    left_vec := SliceVec(v, 0, left);
    right_vec := SliceVec(v, right, LenVec(v));
    mid_vec := ReverseVec(SliceVec(v, left, right));
    m' := $UpdateMutation(m, ConcatVec(left_vec, ConcatVec(mid_vec, right_vec)));
}

procedure {:inline 1} $1_vector_rotate'#0'(m: $Mutation (Vec (#0)), rot: int) returns (n: int, m': $Mutation (Vec (#0))) {
    var v: Vec (#0);
    var len: int;
    var left_vec: Vec (#0);
    var right_vec: Vec (#0);
    v := $Dereference(m);
    if (!(rot >= 0 && rot <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    left_vec := SliceVec(v, 0, rot);
    right_vec := SliceVec(v, rot, LenVec(v));
    m' := $UpdateMutation(m, ConcatVec(right_vec, left_vec));
    n := LenVec(v) - rot;
}

procedure {:inline 1} $1_vector_rotate_slice'#0'(m: $Mutation (Vec (#0)), left: int, rot: int, right: int) returns (n: int, m': $Mutation (Vec (#0))) {
    var left_vec: Vec (#0);
    var mid_vec: Vec (#0);
    var right_vec: Vec (#0);
    var mid_left_vec: Vec (#0);
    var mid_right_vec: Vec (#0);
    var v: Vec (#0);
    v := $Dereference(m);
    if (!(left <= rot && rot <= right)) {
        call $ExecFailureAbort();
        return;
    }
    if (!(right >= 0 && right <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    v := $Dereference(m);
    left_vec := SliceVec(v, 0, left);
    right_vec := SliceVec(v, right, LenVec(v));
    mid_left_vec := SliceVec(v, left, rot);
    mid_right_vec := SliceVec(v, rot, right);
    mid_vec := ConcatVec(mid_right_vec, mid_left_vec);
    m' := $UpdateMutation(m, ConcatVec(left_vec, ConcatVec(mid_vec, right_vec)));
    n := left + (right - rot);
}

procedure {:inline 1} $1_vector_insert'#0'(m: $Mutation (Vec (#0)), i: int, e: #0) returns (m': $Mutation (Vec (#0))) {
    var left_vec: Vec (#0);
    var right_vec: Vec (#0);
    var v: Vec (#0);
    v := $Dereference(m);
    if (!(i >= 0 && i <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    if (i == LenVec(v)) {
        m' := $UpdateMutation(m, ExtendVec(v, e));
    } else {
        left_vec := ExtendVec(SliceVec(v, 0, i), e);
        right_vec := SliceVec(v, i, LenVec(v));
        m' := $UpdateMutation(m, ConcatVec(left_vec, right_vec));
    }
}

procedure {:inline 1} $1_vector_length'#0'(v: Vec (#0)) returns (l: int) {
    l := LenVec(v);
}

function {:inline} $1_vector_$length'#0'(v: Vec (#0)): int {
    LenVec(v)
}

procedure {:inline 1} $1_vector_borrow'#0'(v: Vec (#0), i: int) returns (dst: #0) {
    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    dst := ReadVec(v, i);
}

function {:inline} $1_vector_$borrow'#0'(v: Vec (#0), i: int): #0 {
    ReadVec(v, i)
}

procedure {:inline 1} $1_vector_borrow_mut'#0'(m: $Mutation (Vec (#0)), index: int)
returns (dst: $Mutation (#0), m': $Mutation (Vec (#0)))
{
    var v: Vec (#0);
    v := $Dereference(m);
    if (!InRangeVec(v, index)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Mutation(m->l, ExtendVec(m->p, index), ReadVec(v, index));
    m' := m;
}

function {:inline} $1_vector_$borrow_mut'#0'(v: Vec (#0), i: int): #0 {
    ReadVec(v, i)
}

procedure {:inline 1} $1_vector_destroy_empty'#0'(v: Vec (#0)) {
    if (!IsEmptyVec(v)) {
      call $ExecFailureAbort();
    }
}

procedure {:inline 1} $1_vector_swap'#0'(m: $Mutation (Vec (#0)), i: int, j: int) returns (m': $Mutation (Vec (#0)))
{
    var v: Vec (#0);
    v := $Dereference(m);
    if (!InRangeVec(v, i) || !InRangeVec(v, j)) {
        call $ExecFailureAbort();
        return;
    }
    m' := $UpdateMutation(m, SwapVec(v, i, j));
}

function {:inline} $1_vector_$swap'#0'(v: Vec (#0), i: int, j: int): Vec (#0) {
    SwapVec(v, i, j)
}

procedure {:inline 1} $1_vector_remove'#0'(m: $Mutation (Vec (#0)), i: int) returns (e: #0, m': $Mutation (Vec (#0)))
{
    var v: Vec (#0);

    v := $Dereference(m);

    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, i);
    m' := $UpdateMutation(m, RemoveAtVec(v, i));
}

procedure {:inline 1} $1_vector_swap_remove'#0'(m: $Mutation (Vec (#0)), i: int) returns (e: #0, m': $Mutation (Vec (#0)))
{
    var len: int;
    var v: Vec (#0);

    v := $Dereference(m);
    len := LenVec(v);
    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, i);
    m' := $UpdateMutation(m, RemoveVec(SwapVec(v, i, len-1)));
}

procedure {:inline 1} $1_vector_contains'#0'(v: Vec (#0), e: #0) returns (res: bool)  {
    res := $ContainsVec'#0'(v, e);
}

procedure {:inline 1}
$1_vector_index_of'#0'(v: Vec (#0), e: #0) returns (res1: bool, res2: int) {
    res2 := $IndexOfVec'#0'(v, e);
    if (res2 >= 0) {
        res1 := true;
    } else {
        res1 := false;
        res2 := 0;
    }
}


// ----------------------------------------------------------------------------------
// Native Vector implementation for element type `$1_aggregator_Aggregator`

// Not inlined. It appears faster this way.
function $IsEqual'vec'$1_aggregator_Aggregator''(v1: Vec ($1_aggregator_Aggregator), v2: Vec ($1_aggregator_Aggregator)): bool {
    LenVec(v1) == LenVec(v2) &&
    (forall i: int:: InRangeVec(v1, i) ==> $IsEqual'$1_aggregator_Aggregator'(ReadVec(v1, i), ReadVec(v2, i)))
}

// Not inlined.
function $IsPrefix'vec'$1_aggregator_Aggregator''(v: Vec ($1_aggregator_Aggregator), prefix: Vec ($1_aggregator_Aggregator)): bool {
    LenVec(v) >= LenVec(prefix) &&
    (forall i: int:: InRangeVec(prefix, i) ==> $IsEqual'$1_aggregator_Aggregator'(ReadVec(v, i), ReadVec(prefix, i)))
}

// Not inlined.
function $IsSuffix'vec'$1_aggregator_Aggregator''(v: Vec ($1_aggregator_Aggregator), suffix: Vec ($1_aggregator_Aggregator)): bool {
    LenVec(v) >= LenVec(suffix) &&
    (forall i: int:: InRangeVec(suffix, i) ==> $IsEqual'$1_aggregator_Aggregator'(ReadVec(v, LenVec(v) - LenVec(suffix) + i), ReadVec(suffix, i)))
}

// Not inlined.
function $IsValid'vec'$1_aggregator_Aggregator''(v: Vec ($1_aggregator_Aggregator)): bool {
    $IsValid'u64'(LenVec(v)) &&
    (forall i: int:: InRangeVec(v, i) ==> $IsValid'$1_aggregator_Aggregator'(ReadVec(v, i)))
}


function {:inline} $ContainsVec'$1_aggregator_Aggregator'(v: Vec ($1_aggregator_Aggregator), e: $1_aggregator_Aggregator): bool {
    (exists i: int :: $IsValid'u64'(i) && InRangeVec(v, i) && $IsEqual'$1_aggregator_Aggregator'(ReadVec(v, i), e))
}

function $IndexOfVec'$1_aggregator_Aggregator'(v: Vec ($1_aggregator_Aggregator), e: $1_aggregator_Aggregator): int;
axiom (forall v: Vec ($1_aggregator_Aggregator), e: $1_aggregator_Aggregator:: {$IndexOfVec'$1_aggregator_Aggregator'(v, e)}
    (var i := $IndexOfVec'$1_aggregator_Aggregator'(v, e);
     if (!$ContainsVec'$1_aggregator_Aggregator'(v, e)) then i == -1
     else $IsValid'u64'(i) && InRangeVec(v, i) && $IsEqual'$1_aggregator_Aggregator'(ReadVec(v, i), e) &&
        (forall j: int :: $IsValid'u64'(j) && j >= 0 && j < i ==> !$IsEqual'$1_aggregator_Aggregator'(ReadVec(v, j), e))));


function {:inline} $RangeVec'$1_aggregator_Aggregator'(v: Vec ($1_aggregator_Aggregator)): $Range {
    $Range(0, LenVec(v))
}


function {:inline} $EmptyVec'$1_aggregator_Aggregator'(): Vec ($1_aggregator_Aggregator) {
    EmptyVec()
}

procedure {:inline 1} $1_vector_empty'$1_aggregator_Aggregator'() returns (v: Vec ($1_aggregator_Aggregator)) {
    v := EmptyVec();
}

function {:inline} $1_vector_$empty'$1_aggregator_Aggregator'(): Vec ($1_aggregator_Aggregator) {
    EmptyVec()
}

procedure {:inline 1} $1_vector_is_empty'$1_aggregator_Aggregator'(v: Vec ($1_aggregator_Aggregator)) returns (b: bool) {
    b := IsEmptyVec(v);
}

procedure {:inline 1} $1_vector_push_back'$1_aggregator_Aggregator'(m: $Mutation (Vec ($1_aggregator_Aggregator)), val: $1_aggregator_Aggregator) returns (m': $Mutation (Vec ($1_aggregator_Aggregator))) {
    m' := $UpdateMutation(m, ExtendVec($Dereference(m), val));
}

function {:inline} $1_vector_$push_back'$1_aggregator_Aggregator'(v: Vec ($1_aggregator_Aggregator), val: $1_aggregator_Aggregator): Vec ($1_aggregator_Aggregator) {
    ExtendVec(v, val)
}

procedure {:inline 1} $1_vector_pop_back'$1_aggregator_Aggregator'(m: $Mutation (Vec ($1_aggregator_Aggregator))) returns (e: $1_aggregator_Aggregator, m': $Mutation (Vec ($1_aggregator_Aggregator))) {
    var v: Vec ($1_aggregator_Aggregator);
    var len: int;
    v := $Dereference(m);
    len := LenVec(v);
    if (len == 0) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, len-1);
    m' := $UpdateMutation(m, RemoveVec(v));
}

procedure {:inline 1} $1_vector_append'$1_aggregator_Aggregator'(m: $Mutation (Vec ($1_aggregator_Aggregator)), other: Vec ($1_aggregator_Aggregator)) returns (m': $Mutation (Vec ($1_aggregator_Aggregator))) {
    m' := $UpdateMutation(m, ConcatVec($Dereference(m), other));
}

procedure {:inline 1} $1_vector_reverse'$1_aggregator_Aggregator'(m: $Mutation (Vec ($1_aggregator_Aggregator))) returns (m': $Mutation (Vec ($1_aggregator_Aggregator))) {
    m' := $UpdateMutation(m, ReverseVec($Dereference(m)));
}

procedure {:inline 1} $1_vector_reverse_append'$1_aggregator_Aggregator'(m: $Mutation (Vec ($1_aggregator_Aggregator)), other: Vec ($1_aggregator_Aggregator)) returns (m': $Mutation (Vec ($1_aggregator_Aggregator))) {
    m' := $UpdateMutation(m, ConcatVec($Dereference(m), ReverseVec(other)));
}

procedure {:inline 1} $1_vector_trim_reverse'$1_aggregator_Aggregator'(m: $Mutation (Vec ($1_aggregator_Aggregator)), new_len: int) returns (v: (Vec ($1_aggregator_Aggregator)), m': $Mutation (Vec ($1_aggregator_Aggregator))) {
    var len: int;
    v := $Dereference(m);
    if (LenVec(v) < new_len) {
        call $ExecFailureAbort();
        return;
    }
    v := SliceVec(v, new_len, LenVec(v));
    v := ReverseVec(v);
    m' := $UpdateMutation(m, SliceVec($Dereference(m), 0, new_len));
}

procedure {:inline 1} $1_vector_trim'$1_aggregator_Aggregator'(m: $Mutation (Vec ($1_aggregator_Aggregator)), new_len: int) returns (v: (Vec ($1_aggregator_Aggregator)), m': $Mutation (Vec ($1_aggregator_Aggregator))) {
    var len: int;
    v := $Dereference(m);
    if (LenVec(v) < new_len) {
        call $ExecFailureAbort();
        return;
    }
    v := SliceVec(v, new_len, LenVec(v));
    m' := $UpdateMutation(m, SliceVec($Dereference(m), 0, new_len));
}

procedure {:inline 1} $1_vector_reverse_slice'$1_aggregator_Aggregator'(m: $Mutation (Vec ($1_aggregator_Aggregator)), left: int, right: int) returns (m': $Mutation (Vec ($1_aggregator_Aggregator))) {
    var left_vec: Vec ($1_aggregator_Aggregator);
    var mid_vec: Vec ($1_aggregator_Aggregator);
    var right_vec: Vec ($1_aggregator_Aggregator);
    var v: Vec ($1_aggregator_Aggregator);
    if (left > right) {
        call $ExecFailureAbort();
        return;
    }
    if (left == right) {
        m' := m;
        return;
    }
    v := $Dereference(m);
    if (!(right >= 0 && right <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    left_vec := SliceVec(v, 0, left);
    right_vec := SliceVec(v, right, LenVec(v));
    mid_vec := ReverseVec(SliceVec(v, left, right));
    m' := $UpdateMutation(m, ConcatVec(left_vec, ConcatVec(mid_vec, right_vec)));
}

procedure {:inline 1} $1_vector_rotate'$1_aggregator_Aggregator'(m: $Mutation (Vec ($1_aggregator_Aggregator)), rot: int) returns (n: int, m': $Mutation (Vec ($1_aggregator_Aggregator))) {
    var v: Vec ($1_aggregator_Aggregator);
    var len: int;
    var left_vec: Vec ($1_aggregator_Aggregator);
    var right_vec: Vec ($1_aggregator_Aggregator);
    v := $Dereference(m);
    if (!(rot >= 0 && rot <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    left_vec := SliceVec(v, 0, rot);
    right_vec := SliceVec(v, rot, LenVec(v));
    m' := $UpdateMutation(m, ConcatVec(right_vec, left_vec));
    n := LenVec(v) - rot;
}

procedure {:inline 1} $1_vector_rotate_slice'$1_aggregator_Aggregator'(m: $Mutation (Vec ($1_aggregator_Aggregator)), left: int, rot: int, right: int) returns (n: int, m': $Mutation (Vec ($1_aggregator_Aggregator))) {
    var left_vec: Vec ($1_aggregator_Aggregator);
    var mid_vec: Vec ($1_aggregator_Aggregator);
    var right_vec: Vec ($1_aggregator_Aggregator);
    var mid_left_vec: Vec ($1_aggregator_Aggregator);
    var mid_right_vec: Vec ($1_aggregator_Aggregator);
    var v: Vec ($1_aggregator_Aggregator);
    v := $Dereference(m);
    if (!(left <= rot && rot <= right)) {
        call $ExecFailureAbort();
        return;
    }
    if (!(right >= 0 && right <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    v := $Dereference(m);
    left_vec := SliceVec(v, 0, left);
    right_vec := SliceVec(v, right, LenVec(v));
    mid_left_vec := SliceVec(v, left, rot);
    mid_right_vec := SliceVec(v, rot, right);
    mid_vec := ConcatVec(mid_right_vec, mid_left_vec);
    m' := $UpdateMutation(m, ConcatVec(left_vec, ConcatVec(mid_vec, right_vec)));
    n := left + (right - rot);
}

procedure {:inline 1} $1_vector_insert'$1_aggregator_Aggregator'(m: $Mutation (Vec ($1_aggregator_Aggregator)), i: int, e: $1_aggregator_Aggregator) returns (m': $Mutation (Vec ($1_aggregator_Aggregator))) {
    var left_vec: Vec ($1_aggregator_Aggregator);
    var right_vec: Vec ($1_aggregator_Aggregator);
    var v: Vec ($1_aggregator_Aggregator);
    v := $Dereference(m);
    if (!(i >= 0 && i <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    if (i == LenVec(v)) {
        m' := $UpdateMutation(m, ExtendVec(v, e));
    } else {
        left_vec := ExtendVec(SliceVec(v, 0, i), e);
        right_vec := SliceVec(v, i, LenVec(v));
        m' := $UpdateMutation(m, ConcatVec(left_vec, right_vec));
    }
}

procedure {:inline 1} $1_vector_length'$1_aggregator_Aggregator'(v: Vec ($1_aggregator_Aggregator)) returns (l: int) {
    l := LenVec(v);
}

function {:inline} $1_vector_$length'$1_aggregator_Aggregator'(v: Vec ($1_aggregator_Aggregator)): int {
    LenVec(v)
}

procedure {:inline 1} $1_vector_borrow'$1_aggregator_Aggregator'(v: Vec ($1_aggregator_Aggregator), i: int) returns (dst: $1_aggregator_Aggregator) {
    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    dst := ReadVec(v, i);
}

function {:inline} $1_vector_$borrow'$1_aggregator_Aggregator'(v: Vec ($1_aggregator_Aggregator), i: int): $1_aggregator_Aggregator {
    ReadVec(v, i)
}

procedure {:inline 1} $1_vector_borrow_mut'$1_aggregator_Aggregator'(m: $Mutation (Vec ($1_aggregator_Aggregator)), index: int)
returns (dst: $Mutation ($1_aggregator_Aggregator), m': $Mutation (Vec ($1_aggregator_Aggregator)))
{
    var v: Vec ($1_aggregator_Aggregator);
    v := $Dereference(m);
    if (!InRangeVec(v, index)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Mutation(m->l, ExtendVec(m->p, index), ReadVec(v, index));
    m' := m;
}

function {:inline} $1_vector_$borrow_mut'$1_aggregator_Aggregator'(v: Vec ($1_aggregator_Aggregator), i: int): $1_aggregator_Aggregator {
    ReadVec(v, i)
}

procedure {:inline 1} $1_vector_destroy_empty'$1_aggregator_Aggregator'(v: Vec ($1_aggregator_Aggregator)) {
    if (!IsEmptyVec(v)) {
      call $ExecFailureAbort();
    }
}

procedure {:inline 1} $1_vector_swap'$1_aggregator_Aggregator'(m: $Mutation (Vec ($1_aggregator_Aggregator)), i: int, j: int) returns (m': $Mutation (Vec ($1_aggregator_Aggregator)))
{
    var v: Vec ($1_aggregator_Aggregator);
    v := $Dereference(m);
    if (!InRangeVec(v, i) || !InRangeVec(v, j)) {
        call $ExecFailureAbort();
        return;
    }
    m' := $UpdateMutation(m, SwapVec(v, i, j));
}

function {:inline} $1_vector_$swap'$1_aggregator_Aggregator'(v: Vec ($1_aggregator_Aggregator), i: int, j: int): Vec ($1_aggregator_Aggregator) {
    SwapVec(v, i, j)
}

procedure {:inline 1} $1_vector_remove'$1_aggregator_Aggregator'(m: $Mutation (Vec ($1_aggregator_Aggregator)), i: int) returns (e: $1_aggregator_Aggregator, m': $Mutation (Vec ($1_aggregator_Aggregator)))
{
    var v: Vec ($1_aggregator_Aggregator);

    v := $Dereference(m);

    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, i);
    m' := $UpdateMutation(m, RemoveAtVec(v, i));
}

procedure {:inline 1} $1_vector_swap_remove'$1_aggregator_Aggregator'(m: $Mutation (Vec ($1_aggregator_Aggregator)), i: int) returns (e: $1_aggregator_Aggregator, m': $Mutation (Vec ($1_aggregator_Aggregator)))
{
    var len: int;
    var v: Vec ($1_aggregator_Aggregator);

    v := $Dereference(m);
    len := LenVec(v);
    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, i);
    m' := $UpdateMutation(m, RemoveVec(SwapVec(v, i, len-1)));
}

procedure {:inline 1} $1_vector_contains'$1_aggregator_Aggregator'(v: Vec ($1_aggregator_Aggregator), e: $1_aggregator_Aggregator) returns (res: bool)  {
    res := $ContainsVec'$1_aggregator_Aggregator'(v, e);
}

procedure {:inline 1}
$1_vector_index_of'$1_aggregator_Aggregator'(v: Vec ($1_aggregator_Aggregator), e: $1_aggregator_Aggregator) returns (res1: bool, res2: int) {
    res2 := $IndexOfVec'$1_aggregator_Aggregator'(v, e);
    if (res2 >= 0) {
        res1 := true;
    } else {
        res1 := false;
        res2 := 0;
    }
}


// ----------------------------------------------------------------------------------
// Native Vector implementation for element type `$1_optional_aggregator_Integer`

// Not inlined. It appears faster this way.
function $IsEqual'vec'$1_optional_aggregator_Integer''(v1: Vec ($1_optional_aggregator_Integer), v2: Vec ($1_optional_aggregator_Integer)): bool {
    LenVec(v1) == LenVec(v2) &&
    (forall i: int:: InRangeVec(v1, i) ==> $IsEqual'$1_optional_aggregator_Integer'(ReadVec(v1, i), ReadVec(v2, i)))
}

// Not inlined.
function $IsPrefix'vec'$1_optional_aggregator_Integer''(v: Vec ($1_optional_aggregator_Integer), prefix: Vec ($1_optional_aggregator_Integer)): bool {
    LenVec(v) >= LenVec(prefix) &&
    (forall i: int:: InRangeVec(prefix, i) ==> $IsEqual'$1_optional_aggregator_Integer'(ReadVec(v, i), ReadVec(prefix, i)))
}

// Not inlined.
function $IsSuffix'vec'$1_optional_aggregator_Integer''(v: Vec ($1_optional_aggregator_Integer), suffix: Vec ($1_optional_aggregator_Integer)): bool {
    LenVec(v) >= LenVec(suffix) &&
    (forall i: int:: InRangeVec(suffix, i) ==> $IsEqual'$1_optional_aggregator_Integer'(ReadVec(v, LenVec(v) - LenVec(suffix) + i), ReadVec(suffix, i)))
}

// Not inlined.
function $IsValid'vec'$1_optional_aggregator_Integer''(v: Vec ($1_optional_aggregator_Integer)): bool {
    $IsValid'u64'(LenVec(v)) &&
    (forall i: int:: InRangeVec(v, i) ==> $IsValid'$1_optional_aggregator_Integer'(ReadVec(v, i)))
}


function {:inline} $ContainsVec'$1_optional_aggregator_Integer'(v: Vec ($1_optional_aggregator_Integer), e: $1_optional_aggregator_Integer): bool {
    (exists i: int :: $IsValid'u64'(i) && InRangeVec(v, i) && $IsEqual'$1_optional_aggregator_Integer'(ReadVec(v, i), e))
}

function $IndexOfVec'$1_optional_aggregator_Integer'(v: Vec ($1_optional_aggregator_Integer), e: $1_optional_aggregator_Integer): int;
axiom (forall v: Vec ($1_optional_aggregator_Integer), e: $1_optional_aggregator_Integer:: {$IndexOfVec'$1_optional_aggregator_Integer'(v, e)}
    (var i := $IndexOfVec'$1_optional_aggregator_Integer'(v, e);
     if (!$ContainsVec'$1_optional_aggregator_Integer'(v, e)) then i == -1
     else $IsValid'u64'(i) && InRangeVec(v, i) && $IsEqual'$1_optional_aggregator_Integer'(ReadVec(v, i), e) &&
        (forall j: int :: $IsValid'u64'(j) && j >= 0 && j < i ==> !$IsEqual'$1_optional_aggregator_Integer'(ReadVec(v, j), e))));


function {:inline} $RangeVec'$1_optional_aggregator_Integer'(v: Vec ($1_optional_aggregator_Integer)): $Range {
    $Range(0, LenVec(v))
}


function {:inline} $EmptyVec'$1_optional_aggregator_Integer'(): Vec ($1_optional_aggregator_Integer) {
    EmptyVec()
}

procedure {:inline 1} $1_vector_empty'$1_optional_aggregator_Integer'() returns (v: Vec ($1_optional_aggregator_Integer)) {
    v := EmptyVec();
}

function {:inline} $1_vector_$empty'$1_optional_aggregator_Integer'(): Vec ($1_optional_aggregator_Integer) {
    EmptyVec()
}

procedure {:inline 1} $1_vector_is_empty'$1_optional_aggregator_Integer'(v: Vec ($1_optional_aggregator_Integer)) returns (b: bool) {
    b := IsEmptyVec(v);
}

procedure {:inline 1} $1_vector_push_back'$1_optional_aggregator_Integer'(m: $Mutation (Vec ($1_optional_aggregator_Integer)), val: $1_optional_aggregator_Integer) returns (m': $Mutation (Vec ($1_optional_aggregator_Integer))) {
    m' := $UpdateMutation(m, ExtendVec($Dereference(m), val));
}

function {:inline} $1_vector_$push_back'$1_optional_aggregator_Integer'(v: Vec ($1_optional_aggregator_Integer), val: $1_optional_aggregator_Integer): Vec ($1_optional_aggregator_Integer) {
    ExtendVec(v, val)
}

procedure {:inline 1} $1_vector_pop_back'$1_optional_aggregator_Integer'(m: $Mutation (Vec ($1_optional_aggregator_Integer))) returns (e: $1_optional_aggregator_Integer, m': $Mutation (Vec ($1_optional_aggregator_Integer))) {
    var v: Vec ($1_optional_aggregator_Integer);
    var len: int;
    v := $Dereference(m);
    len := LenVec(v);
    if (len == 0) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, len-1);
    m' := $UpdateMutation(m, RemoveVec(v));
}

procedure {:inline 1} $1_vector_append'$1_optional_aggregator_Integer'(m: $Mutation (Vec ($1_optional_aggregator_Integer)), other: Vec ($1_optional_aggregator_Integer)) returns (m': $Mutation (Vec ($1_optional_aggregator_Integer))) {
    m' := $UpdateMutation(m, ConcatVec($Dereference(m), other));
}

procedure {:inline 1} $1_vector_reverse'$1_optional_aggregator_Integer'(m: $Mutation (Vec ($1_optional_aggregator_Integer))) returns (m': $Mutation (Vec ($1_optional_aggregator_Integer))) {
    m' := $UpdateMutation(m, ReverseVec($Dereference(m)));
}

procedure {:inline 1} $1_vector_reverse_append'$1_optional_aggregator_Integer'(m: $Mutation (Vec ($1_optional_aggregator_Integer)), other: Vec ($1_optional_aggregator_Integer)) returns (m': $Mutation (Vec ($1_optional_aggregator_Integer))) {
    m' := $UpdateMutation(m, ConcatVec($Dereference(m), ReverseVec(other)));
}

procedure {:inline 1} $1_vector_trim_reverse'$1_optional_aggregator_Integer'(m: $Mutation (Vec ($1_optional_aggregator_Integer)), new_len: int) returns (v: (Vec ($1_optional_aggregator_Integer)), m': $Mutation (Vec ($1_optional_aggregator_Integer))) {
    var len: int;
    v := $Dereference(m);
    if (LenVec(v) < new_len) {
        call $ExecFailureAbort();
        return;
    }
    v := SliceVec(v, new_len, LenVec(v));
    v := ReverseVec(v);
    m' := $UpdateMutation(m, SliceVec($Dereference(m), 0, new_len));
}

procedure {:inline 1} $1_vector_trim'$1_optional_aggregator_Integer'(m: $Mutation (Vec ($1_optional_aggregator_Integer)), new_len: int) returns (v: (Vec ($1_optional_aggregator_Integer)), m': $Mutation (Vec ($1_optional_aggregator_Integer))) {
    var len: int;
    v := $Dereference(m);
    if (LenVec(v) < new_len) {
        call $ExecFailureAbort();
        return;
    }
    v := SliceVec(v, new_len, LenVec(v));
    m' := $UpdateMutation(m, SliceVec($Dereference(m), 0, new_len));
}

procedure {:inline 1} $1_vector_reverse_slice'$1_optional_aggregator_Integer'(m: $Mutation (Vec ($1_optional_aggregator_Integer)), left: int, right: int) returns (m': $Mutation (Vec ($1_optional_aggregator_Integer))) {
    var left_vec: Vec ($1_optional_aggregator_Integer);
    var mid_vec: Vec ($1_optional_aggregator_Integer);
    var right_vec: Vec ($1_optional_aggregator_Integer);
    var v: Vec ($1_optional_aggregator_Integer);
    if (left > right) {
        call $ExecFailureAbort();
        return;
    }
    if (left == right) {
        m' := m;
        return;
    }
    v := $Dereference(m);
    if (!(right >= 0 && right <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    left_vec := SliceVec(v, 0, left);
    right_vec := SliceVec(v, right, LenVec(v));
    mid_vec := ReverseVec(SliceVec(v, left, right));
    m' := $UpdateMutation(m, ConcatVec(left_vec, ConcatVec(mid_vec, right_vec)));
}

procedure {:inline 1} $1_vector_rotate'$1_optional_aggregator_Integer'(m: $Mutation (Vec ($1_optional_aggregator_Integer)), rot: int) returns (n: int, m': $Mutation (Vec ($1_optional_aggregator_Integer))) {
    var v: Vec ($1_optional_aggregator_Integer);
    var len: int;
    var left_vec: Vec ($1_optional_aggregator_Integer);
    var right_vec: Vec ($1_optional_aggregator_Integer);
    v := $Dereference(m);
    if (!(rot >= 0 && rot <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    left_vec := SliceVec(v, 0, rot);
    right_vec := SliceVec(v, rot, LenVec(v));
    m' := $UpdateMutation(m, ConcatVec(right_vec, left_vec));
    n := LenVec(v) - rot;
}

procedure {:inline 1} $1_vector_rotate_slice'$1_optional_aggregator_Integer'(m: $Mutation (Vec ($1_optional_aggregator_Integer)), left: int, rot: int, right: int) returns (n: int, m': $Mutation (Vec ($1_optional_aggregator_Integer))) {
    var left_vec: Vec ($1_optional_aggregator_Integer);
    var mid_vec: Vec ($1_optional_aggregator_Integer);
    var right_vec: Vec ($1_optional_aggregator_Integer);
    var mid_left_vec: Vec ($1_optional_aggregator_Integer);
    var mid_right_vec: Vec ($1_optional_aggregator_Integer);
    var v: Vec ($1_optional_aggregator_Integer);
    v := $Dereference(m);
    if (!(left <= rot && rot <= right)) {
        call $ExecFailureAbort();
        return;
    }
    if (!(right >= 0 && right <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    v := $Dereference(m);
    left_vec := SliceVec(v, 0, left);
    right_vec := SliceVec(v, right, LenVec(v));
    mid_left_vec := SliceVec(v, left, rot);
    mid_right_vec := SliceVec(v, rot, right);
    mid_vec := ConcatVec(mid_right_vec, mid_left_vec);
    m' := $UpdateMutation(m, ConcatVec(left_vec, ConcatVec(mid_vec, right_vec)));
    n := left + (right - rot);
}

procedure {:inline 1} $1_vector_insert'$1_optional_aggregator_Integer'(m: $Mutation (Vec ($1_optional_aggregator_Integer)), i: int, e: $1_optional_aggregator_Integer) returns (m': $Mutation (Vec ($1_optional_aggregator_Integer))) {
    var left_vec: Vec ($1_optional_aggregator_Integer);
    var right_vec: Vec ($1_optional_aggregator_Integer);
    var v: Vec ($1_optional_aggregator_Integer);
    v := $Dereference(m);
    if (!(i >= 0 && i <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    if (i == LenVec(v)) {
        m' := $UpdateMutation(m, ExtendVec(v, e));
    } else {
        left_vec := ExtendVec(SliceVec(v, 0, i), e);
        right_vec := SliceVec(v, i, LenVec(v));
        m' := $UpdateMutation(m, ConcatVec(left_vec, right_vec));
    }
}

procedure {:inline 1} $1_vector_length'$1_optional_aggregator_Integer'(v: Vec ($1_optional_aggregator_Integer)) returns (l: int) {
    l := LenVec(v);
}

function {:inline} $1_vector_$length'$1_optional_aggregator_Integer'(v: Vec ($1_optional_aggregator_Integer)): int {
    LenVec(v)
}

procedure {:inline 1} $1_vector_borrow'$1_optional_aggregator_Integer'(v: Vec ($1_optional_aggregator_Integer), i: int) returns (dst: $1_optional_aggregator_Integer) {
    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    dst := ReadVec(v, i);
}

function {:inline} $1_vector_$borrow'$1_optional_aggregator_Integer'(v: Vec ($1_optional_aggregator_Integer), i: int): $1_optional_aggregator_Integer {
    ReadVec(v, i)
}

procedure {:inline 1} $1_vector_borrow_mut'$1_optional_aggregator_Integer'(m: $Mutation (Vec ($1_optional_aggregator_Integer)), index: int)
returns (dst: $Mutation ($1_optional_aggregator_Integer), m': $Mutation (Vec ($1_optional_aggregator_Integer)))
{
    var v: Vec ($1_optional_aggregator_Integer);
    v := $Dereference(m);
    if (!InRangeVec(v, index)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Mutation(m->l, ExtendVec(m->p, index), ReadVec(v, index));
    m' := m;
}

function {:inline} $1_vector_$borrow_mut'$1_optional_aggregator_Integer'(v: Vec ($1_optional_aggregator_Integer), i: int): $1_optional_aggregator_Integer {
    ReadVec(v, i)
}

procedure {:inline 1} $1_vector_destroy_empty'$1_optional_aggregator_Integer'(v: Vec ($1_optional_aggregator_Integer)) {
    if (!IsEmptyVec(v)) {
      call $ExecFailureAbort();
    }
}

procedure {:inline 1} $1_vector_swap'$1_optional_aggregator_Integer'(m: $Mutation (Vec ($1_optional_aggregator_Integer)), i: int, j: int) returns (m': $Mutation (Vec ($1_optional_aggregator_Integer)))
{
    var v: Vec ($1_optional_aggregator_Integer);
    v := $Dereference(m);
    if (!InRangeVec(v, i) || !InRangeVec(v, j)) {
        call $ExecFailureAbort();
        return;
    }
    m' := $UpdateMutation(m, SwapVec(v, i, j));
}

function {:inline} $1_vector_$swap'$1_optional_aggregator_Integer'(v: Vec ($1_optional_aggregator_Integer), i: int, j: int): Vec ($1_optional_aggregator_Integer) {
    SwapVec(v, i, j)
}

procedure {:inline 1} $1_vector_remove'$1_optional_aggregator_Integer'(m: $Mutation (Vec ($1_optional_aggregator_Integer)), i: int) returns (e: $1_optional_aggregator_Integer, m': $Mutation (Vec ($1_optional_aggregator_Integer)))
{
    var v: Vec ($1_optional_aggregator_Integer);

    v := $Dereference(m);

    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, i);
    m' := $UpdateMutation(m, RemoveAtVec(v, i));
}

procedure {:inline 1} $1_vector_swap_remove'$1_optional_aggregator_Integer'(m: $Mutation (Vec ($1_optional_aggregator_Integer)), i: int) returns (e: $1_optional_aggregator_Integer, m': $Mutation (Vec ($1_optional_aggregator_Integer)))
{
    var len: int;
    var v: Vec ($1_optional_aggregator_Integer);

    v := $Dereference(m);
    len := LenVec(v);
    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, i);
    m' := $UpdateMutation(m, RemoveVec(SwapVec(v, i, len-1)));
}

procedure {:inline 1} $1_vector_contains'$1_optional_aggregator_Integer'(v: Vec ($1_optional_aggregator_Integer), e: $1_optional_aggregator_Integer) returns (res: bool)  {
    res := $ContainsVec'$1_optional_aggregator_Integer'(v, e);
}

procedure {:inline 1}
$1_vector_index_of'$1_optional_aggregator_Integer'(v: Vec ($1_optional_aggregator_Integer), e: $1_optional_aggregator_Integer) returns (res1: bool, res2: int) {
    res2 := $IndexOfVec'$1_optional_aggregator_Integer'(v, e);
    if (res2 >= 0) {
        res1 := true;
    } else {
        res1 := false;
        res2 := 0;
    }
}


// ----------------------------------------------------------------------------------
// Native Vector implementation for element type `$1_optional_aggregator_OptionalAggregator`

// Not inlined. It appears faster this way.
function $IsEqual'vec'$1_optional_aggregator_OptionalAggregator''(v1: Vec ($1_optional_aggregator_OptionalAggregator), v2: Vec ($1_optional_aggregator_OptionalAggregator)): bool {
    LenVec(v1) == LenVec(v2) &&
    (forall i: int:: InRangeVec(v1, i) ==> $IsEqual'$1_optional_aggregator_OptionalAggregator'(ReadVec(v1, i), ReadVec(v2, i)))
}

// Not inlined.
function $IsPrefix'vec'$1_optional_aggregator_OptionalAggregator''(v: Vec ($1_optional_aggregator_OptionalAggregator), prefix: Vec ($1_optional_aggregator_OptionalAggregator)): bool {
    LenVec(v) >= LenVec(prefix) &&
    (forall i: int:: InRangeVec(prefix, i) ==> $IsEqual'$1_optional_aggregator_OptionalAggregator'(ReadVec(v, i), ReadVec(prefix, i)))
}

// Not inlined.
function $IsSuffix'vec'$1_optional_aggregator_OptionalAggregator''(v: Vec ($1_optional_aggregator_OptionalAggregator), suffix: Vec ($1_optional_aggregator_OptionalAggregator)): bool {
    LenVec(v) >= LenVec(suffix) &&
    (forall i: int:: InRangeVec(suffix, i) ==> $IsEqual'$1_optional_aggregator_OptionalAggregator'(ReadVec(v, LenVec(v) - LenVec(suffix) + i), ReadVec(suffix, i)))
}

// Not inlined.
function $IsValid'vec'$1_optional_aggregator_OptionalAggregator''(v: Vec ($1_optional_aggregator_OptionalAggregator)): bool {
    $IsValid'u64'(LenVec(v)) &&
    (forall i: int:: InRangeVec(v, i) ==> $IsValid'$1_optional_aggregator_OptionalAggregator'(ReadVec(v, i)))
}


function {:inline} $ContainsVec'$1_optional_aggregator_OptionalAggregator'(v: Vec ($1_optional_aggregator_OptionalAggregator), e: $1_optional_aggregator_OptionalAggregator): bool {
    (exists i: int :: $IsValid'u64'(i) && InRangeVec(v, i) && $IsEqual'$1_optional_aggregator_OptionalAggregator'(ReadVec(v, i), e))
}

function $IndexOfVec'$1_optional_aggregator_OptionalAggregator'(v: Vec ($1_optional_aggregator_OptionalAggregator), e: $1_optional_aggregator_OptionalAggregator): int;
axiom (forall v: Vec ($1_optional_aggregator_OptionalAggregator), e: $1_optional_aggregator_OptionalAggregator:: {$IndexOfVec'$1_optional_aggregator_OptionalAggregator'(v, e)}
    (var i := $IndexOfVec'$1_optional_aggregator_OptionalAggregator'(v, e);
     if (!$ContainsVec'$1_optional_aggregator_OptionalAggregator'(v, e)) then i == -1
     else $IsValid'u64'(i) && InRangeVec(v, i) && $IsEqual'$1_optional_aggregator_OptionalAggregator'(ReadVec(v, i), e) &&
        (forall j: int :: $IsValid'u64'(j) && j >= 0 && j < i ==> !$IsEqual'$1_optional_aggregator_OptionalAggregator'(ReadVec(v, j), e))));


function {:inline} $RangeVec'$1_optional_aggregator_OptionalAggregator'(v: Vec ($1_optional_aggregator_OptionalAggregator)): $Range {
    $Range(0, LenVec(v))
}


function {:inline} $EmptyVec'$1_optional_aggregator_OptionalAggregator'(): Vec ($1_optional_aggregator_OptionalAggregator) {
    EmptyVec()
}

procedure {:inline 1} $1_vector_empty'$1_optional_aggregator_OptionalAggregator'() returns (v: Vec ($1_optional_aggregator_OptionalAggregator)) {
    v := EmptyVec();
}

function {:inline} $1_vector_$empty'$1_optional_aggregator_OptionalAggregator'(): Vec ($1_optional_aggregator_OptionalAggregator) {
    EmptyVec()
}

procedure {:inline 1} $1_vector_is_empty'$1_optional_aggregator_OptionalAggregator'(v: Vec ($1_optional_aggregator_OptionalAggregator)) returns (b: bool) {
    b := IsEmptyVec(v);
}

procedure {:inline 1} $1_vector_push_back'$1_optional_aggregator_OptionalAggregator'(m: $Mutation (Vec ($1_optional_aggregator_OptionalAggregator)), val: $1_optional_aggregator_OptionalAggregator) returns (m': $Mutation (Vec ($1_optional_aggregator_OptionalAggregator))) {
    m' := $UpdateMutation(m, ExtendVec($Dereference(m), val));
}

function {:inline} $1_vector_$push_back'$1_optional_aggregator_OptionalAggregator'(v: Vec ($1_optional_aggregator_OptionalAggregator), val: $1_optional_aggregator_OptionalAggregator): Vec ($1_optional_aggregator_OptionalAggregator) {
    ExtendVec(v, val)
}

procedure {:inline 1} $1_vector_pop_back'$1_optional_aggregator_OptionalAggregator'(m: $Mutation (Vec ($1_optional_aggregator_OptionalAggregator))) returns (e: $1_optional_aggregator_OptionalAggregator, m': $Mutation (Vec ($1_optional_aggregator_OptionalAggregator))) {
    var v: Vec ($1_optional_aggregator_OptionalAggregator);
    var len: int;
    v := $Dereference(m);
    len := LenVec(v);
    if (len == 0) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, len-1);
    m' := $UpdateMutation(m, RemoveVec(v));
}

procedure {:inline 1} $1_vector_append'$1_optional_aggregator_OptionalAggregator'(m: $Mutation (Vec ($1_optional_aggregator_OptionalAggregator)), other: Vec ($1_optional_aggregator_OptionalAggregator)) returns (m': $Mutation (Vec ($1_optional_aggregator_OptionalAggregator))) {
    m' := $UpdateMutation(m, ConcatVec($Dereference(m), other));
}

procedure {:inline 1} $1_vector_reverse'$1_optional_aggregator_OptionalAggregator'(m: $Mutation (Vec ($1_optional_aggregator_OptionalAggregator))) returns (m': $Mutation (Vec ($1_optional_aggregator_OptionalAggregator))) {
    m' := $UpdateMutation(m, ReverseVec($Dereference(m)));
}

procedure {:inline 1} $1_vector_reverse_append'$1_optional_aggregator_OptionalAggregator'(m: $Mutation (Vec ($1_optional_aggregator_OptionalAggregator)), other: Vec ($1_optional_aggregator_OptionalAggregator)) returns (m': $Mutation (Vec ($1_optional_aggregator_OptionalAggregator))) {
    m' := $UpdateMutation(m, ConcatVec($Dereference(m), ReverseVec(other)));
}

procedure {:inline 1} $1_vector_trim_reverse'$1_optional_aggregator_OptionalAggregator'(m: $Mutation (Vec ($1_optional_aggregator_OptionalAggregator)), new_len: int) returns (v: (Vec ($1_optional_aggregator_OptionalAggregator)), m': $Mutation (Vec ($1_optional_aggregator_OptionalAggregator))) {
    var len: int;
    v := $Dereference(m);
    if (LenVec(v) < new_len) {
        call $ExecFailureAbort();
        return;
    }
    v := SliceVec(v, new_len, LenVec(v));
    v := ReverseVec(v);
    m' := $UpdateMutation(m, SliceVec($Dereference(m), 0, new_len));
}

procedure {:inline 1} $1_vector_trim'$1_optional_aggregator_OptionalAggregator'(m: $Mutation (Vec ($1_optional_aggregator_OptionalAggregator)), new_len: int) returns (v: (Vec ($1_optional_aggregator_OptionalAggregator)), m': $Mutation (Vec ($1_optional_aggregator_OptionalAggregator))) {
    var len: int;
    v := $Dereference(m);
    if (LenVec(v) < new_len) {
        call $ExecFailureAbort();
        return;
    }
    v := SliceVec(v, new_len, LenVec(v));
    m' := $UpdateMutation(m, SliceVec($Dereference(m), 0, new_len));
}

procedure {:inline 1} $1_vector_reverse_slice'$1_optional_aggregator_OptionalAggregator'(m: $Mutation (Vec ($1_optional_aggregator_OptionalAggregator)), left: int, right: int) returns (m': $Mutation (Vec ($1_optional_aggregator_OptionalAggregator))) {
    var left_vec: Vec ($1_optional_aggregator_OptionalAggregator);
    var mid_vec: Vec ($1_optional_aggregator_OptionalAggregator);
    var right_vec: Vec ($1_optional_aggregator_OptionalAggregator);
    var v: Vec ($1_optional_aggregator_OptionalAggregator);
    if (left > right) {
        call $ExecFailureAbort();
        return;
    }
    if (left == right) {
        m' := m;
        return;
    }
    v := $Dereference(m);
    if (!(right >= 0 && right <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    left_vec := SliceVec(v, 0, left);
    right_vec := SliceVec(v, right, LenVec(v));
    mid_vec := ReverseVec(SliceVec(v, left, right));
    m' := $UpdateMutation(m, ConcatVec(left_vec, ConcatVec(mid_vec, right_vec)));
}

procedure {:inline 1} $1_vector_rotate'$1_optional_aggregator_OptionalAggregator'(m: $Mutation (Vec ($1_optional_aggregator_OptionalAggregator)), rot: int) returns (n: int, m': $Mutation (Vec ($1_optional_aggregator_OptionalAggregator))) {
    var v: Vec ($1_optional_aggregator_OptionalAggregator);
    var len: int;
    var left_vec: Vec ($1_optional_aggregator_OptionalAggregator);
    var right_vec: Vec ($1_optional_aggregator_OptionalAggregator);
    v := $Dereference(m);
    if (!(rot >= 0 && rot <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    left_vec := SliceVec(v, 0, rot);
    right_vec := SliceVec(v, rot, LenVec(v));
    m' := $UpdateMutation(m, ConcatVec(right_vec, left_vec));
    n := LenVec(v) - rot;
}

procedure {:inline 1} $1_vector_rotate_slice'$1_optional_aggregator_OptionalAggregator'(m: $Mutation (Vec ($1_optional_aggregator_OptionalAggregator)), left: int, rot: int, right: int) returns (n: int, m': $Mutation (Vec ($1_optional_aggregator_OptionalAggregator))) {
    var left_vec: Vec ($1_optional_aggregator_OptionalAggregator);
    var mid_vec: Vec ($1_optional_aggregator_OptionalAggregator);
    var right_vec: Vec ($1_optional_aggregator_OptionalAggregator);
    var mid_left_vec: Vec ($1_optional_aggregator_OptionalAggregator);
    var mid_right_vec: Vec ($1_optional_aggregator_OptionalAggregator);
    var v: Vec ($1_optional_aggregator_OptionalAggregator);
    v := $Dereference(m);
    if (!(left <= rot && rot <= right)) {
        call $ExecFailureAbort();
        return;
    }
    if (!(right >= 0 && right <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    v := $Dereference(m);
    left_vec := SliceVec(v, 0, left);
    right_vec := SliceVec(v, right, LenVec(v));
    mid_left_vec := SliceVec(v, left, rot);
    mid_right_vec := SliceVec(v, rot, right);
    mid_vec := ConcatVec(mid_right_vec, mid_left_vec);
    m' := $UpdateMutation(m, ConcatVec(left_vec, ConcatVec(mid_vec, right_vec)));
    n := left + (right - rot);
}

procedure {:inline 1} $1_vector_insert'$1_optional_aggregator_OptionalAggregator'(m: $Mutation (Vec ($1_optional_aggregator_OptionalAggregator)), i: int, e: $1_optional_aggregator_OptionalAggregator) returns (m': $Mutation (Vec ($1_optional_aggregator_OptionalAggregator))) {
    var left_vec: Vec ($1_optional_aggregator_OptionalAggregator);
    var right_vec: Vec ($1_optional_aggregator_OptionalAggregator);
    var v: Vec ($1_optional_aggregator_OptionalAggregator);
    v := $Dereference(m);
    if (!(i >= 0 && i <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    if (i == LenVec(v)) {
        m' := $UpdateMutation(m, ExtendVec(v, e));
    } else {
        left_vec := ExtendVec(SliceVec(v, 0, i), e);
        right_vec := SliceVec(v, i, LenVec(v));
        m' := $UpdateMutation(m, ConcatVec(left_vec, right_vec));
    }
}

procedure {:inline 1} $1_vector_length'$1_optional_aggregator_OptionalAggregator'(v: Vec ($1_optional_aggregator_OptionalAggregator)) returns (l: int) {
    l := LenVec(v);
}

function {:inline} $1_vector_$length'$1_optional_aggregator_OptionalAggregator'(v: Vec ($1_optional_aggregator_OptionalAggregator)): int {
    LenVec(v)
}

procedure {:inline 1} $1_vector_borrow'$1_optional_aggregator_OptionalAggregator'(v: Vec ($1_optional_aggregator_OptionalAggregator), i: int) returns (dst: $1_optional_aggregator_OptionalAggregator) {
    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    dst := ReadVec(v, i);
}

function {:inline} $1_vector_$borrow'$1_optional_aggregator_OptionalAggregator'(v: Vec ($1_optional_aggregator_OptionalAggregator), i: int): $1_optional_aggregator_OptionalAggregator {
    ReadVec(v, i)
}

procedure {:inline 1} $1_vector_borrow_mut'$1_optional_aggregator_OptionalAggregator'(m: $Mutation (Vec ($1_optional_aggregator_OptionalAggregator)), index: int)
returns (dst: $Mutation ($1_optional_aggregator_OptionalAggregator), m': $Mutation (Vec ($1_optional_aggregator_OptionalAggregator)))
{
    var v: Vec ($1_optional_aggregator_OptionalAggregator);
    v := $Dereference(m);
    if (!InRangeVec(v, index)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Mutation(m->l, ExtendVec(m->p, index), ReadVec(v, index));
    m' := m;
}

function {:inline} $1_vector_$borrow_mut'$1_optional_aggregator_OptionalAggregator'(v: Vec ($1_optional_aggregator_OptionalAggregator), i: int): $1_optional_aggregator_OptionalAggregator {
    ReadVec(v, i)
}

procedure {:inline 1} $1_vector_destroy_empty'$1_optional_aggregator_OptionalAggregator'(v: Vec ($1_optional_aggregator_OptionalAggregator)) {
    if (!IsEmptyVec(v)) {
      call $ExecFailureAbort();
    }
}

procedure {:inline 1} $1_vector_swap'$1_optional_aggregator_OptionalAggregator'(m: $Mutation (Vec ($1_optional_aggregator_OptionalAggregator)), i: int, j: int) returns (m': $Mutation (Vec ($1_optional_aggregator_OptionalAggregator)))
{
    var v: Vec ($1_optional_aggregator_OptionalAggregator);
    v := $Dereference(m);
    if (!InRangeVec(v, i) || !InRangeVec(v, j)) {
        call $ExecFailureAbort();
        return;
    }
    m' := $UpdateMutation(m, SwapVec(v, i, j));
}

function {:inline} $1_vector_$swap'$1_optional_aggregator_OptionalAggregator'(v: Vec ($1_optional_aggregator_OptionalAggregator), i: int, j: int): Vec ($1_optional_aggregator_OptionalAggregator) {
    SwapVec(v, i, j)
}

procedure {:inline 1} $1_vector_remove'$1_optional_aggregator_OptionalAggregator'(m: $Mutation (Vec ($1_optional_aggregator_OptionalAggregator)), i: int) returns (e: $1_optional_aggregator_OptionalAggregator, m': $Mutation (Vec ($1_optional_aggregator_OptionalAggregator)))
{
    var v: Vec ($1_optional_aggregator_OptionalAggregator);

    v := $Dereference(m);

    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, i);
    m' := $UpdateMutation(m, RemoveAtVec(v, i));
}

procedure {:inline 1} $1_vector_swap_remove'$1_optional_aggregator_OptionalAggregator'(m: $Mutation (Vec ($1_optional_aggregator_OptionalAggregator)), i: int) returns (e: $1_optional_aggregator_OptionalAggregator, m': $Mutation (Vec ($1_optional_aggregator_OptionalAggregator)))
{
    var len: int;
    var v: Vec ($1_optional_aggregator_OptionalAggregator);

    v := $Dereference(m);
    len := LenVec(v);
    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, i);
    m' := $UpdateMutation(m, RemoveVec(SwapVec(v, i, len-1)));
}

procedure {:inline 1} $1_vector_contains'$1_optional_aggregator_OptionalAggregator'(v: Vec ($1_optional_aggregator_OptionalAggregator), e: $1_optional_aggregator_OptionalAggregator) returns (res: bool)  {
    res := $ContainsVec'$1_optional_aggregator_OptionalAggregator'(v, e);
}

procedure {:inline 1}
$1_vector_index_of'$1_optional_aggregator_OptionalAggregator'(v: Vec ($1_optional_aggregator_OptionalAggregator), e: $1_optional_aggregator_OptionalAggregator) returns (res1: bool, res2: int) {
    res2 := $IndexOfVec'$1_optional_aggregator_OptionalAggregator'(v, e);
    if (res2 >= 0) {
        res1 := true;
    } else {
        res1 := false;
        res2 := 0;
    }
}


// ----------------------------------------------------------------------------------
// Native Vector implementation for element type `address`

// Not inlined. It appears faster this way.
function $IsEqual'vec'address''(v1: Vec (int), v2: Vec (int)): bool {
    LenVec(v1) == LenVec(v2) &&
    (forall i: int:: InRangeVec(v1, i) ==> $IsEqual'address'(ReadVec(v1, i), ReadVec(v2, i)))
}

// Not inlined.
function $IsPrefix'vec'address''(v: Vec (int), prefix: Vec (int)): bool {
    LenVec(v) >= LenVec(prefix) &&
    (forall i: int:: InRangeVec(prefix, i) ==> $IsEqual'address'(ReadVec(v, i), ReadVec(prefix, i)))
}

// Not inlined.
function $IsSuffix'vec'address''(v: Vec (int), suffix: Vec (int)): bool {
    LenVec(v) >= LenVec(suffix) &&
    (forall i: int:: InRangeVec(suffix, i) ==> $IsEqual'address'(ReadVec(v, LenVec(v) - LenVec(suffix) + i), ReadVec(suffix, i)))
}

// Not inlined.
function $IsValid'vec'address''(v: Vec (int)): bool {
    $IsValid'u64'(LenVec(v)) &&
    (forall i: int:: InRangeVec(v, i) ==> $IsValid'address'(ReadVec(v, i)))
}


function {:inline} $ContainsVec'address'(v: Vec (int), e: int): bool {
    (exists i: int :: $IsValid'u64'(i) && InRangeVec(v, i) && $IsEqual'address'(ReadVec(v, i), e))
}

function $IndexOfVec'address'(v: Vec (int), e: int): int;
axiom (forall v: Vec (int), e: int:: {$IndexOfVec'address'(v, e)}
    (var i := $IndexOfVec'address'(v, e);
     if (!$ContainsVec'address'(v, e)) then i == -1
     else $IsValid'u64'(i) && InRangeVec(v, i) && $IsEqual'address'(ReadVec(v, i), e) &&
        (forall j: int :: $IsValid'u64'(j) && j >= 0 && j < i ==> !$IsEqual'address'(ReadVec(v, j), e))));


function {:inline} $RangeVec'address'(v: Vec (int)): $Range {
    $Range(0, LenVec(v))
}


function {:inline} $EmptyVec'address'(): Vec (int) {
    EmptyVec()
}

procedure {:inline 1} $1_vector_empty'address'() returns (v: Vec (int)) {
    v := EmptyVec();
}

function {:inline} $1_vector_$empty'address'(): Vec (int) {
    EmptyVec()
}

procedure {:inline 1} $1_vector_is_empty'address'(v: Vec (int)) returns (b: bool) {
    b := IsEmptyVec(v);
}

procedure {:inline 1} $1_vector_push_back'address'(m: $Mutation (Vec (int)), val: int) returns (m': $Mutation (Vec (int))) {
    m' := $UpdateMutation(m, ExtendVec($Dereference(m), val));
}

function {:inline} $1_vector_$push_back'address'(v: Vec (int), val: int): Vec (int) {
    ExtendVec(v, val)
}

procedure {:inline 1} $1_vector_pop_back'address'(m: $Mutation (Vec (int))) returns (e: int, m': $Mutation (Vec (int))) {
    var v: Vec (int);
    var len: int;
    v := $Dereference(m);
    len := LenVec(v);
    if (len == 0) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, len-1);
    m' := $UpdateMutation(m, RemoveVec(v));
}

procedure {:inline 1} $1_vector_append'address'(m: $Mutation (Vec (int)), other: Vec (int)) returns (m': $Mutation (Vec (int))) {
    m' := $UpdateMutation(m, ConcatVec($Dereference(m), other));
}

procedure {:inline 1} $1_vector_reverse'address'(m: $Mutation (Vec (int))) returns (m': $Mutation (Vec (int))) {
    m' := $UpdateMutation(m, ReverseVec($Dereference(m)));
}

procedure {:inline 1} $1_vector_reverse_append'address'(m: $Mutation (Vec (int)), other: Vec (int)) returns (m': $Mutation (Vec (int))) {
    m' := $UpdateMutation(m, ConcatVec($Dereference(m), ReverseVec(other)));
}

procedure {:inline 1} $1_vector_trim_reverse'address'(m: $Mutation (Vec (int)), new_len: int) returns (v: (Vec (int)), m': $Mutation (Vec (int))) {
    var len: int;
    v := $Dereference(m);
    if (LenVec(v) < new_len) {
        call $ExecFailureAbort();
        return;
    }
    v := SliceVec(v, new_len, LenVec(v));
    v := ReverseVec(v);
    m' := $UpdateMutation(m, SliceVec($Dereference(m), 0, new_len));
}

procedure {:inline 1} $1_vector_trim'address'(m: $Mutation (Vec (int)), new_len: int) returns (v: (Vec (int)), m': $Mutation (Vec (int))) {
    var len: int;
    v := $Dereference(m);
    if (LenVec(v) < new_len) {
        call $ExecFailureAbort();
        return;
    }
    v := SliceVec(v, new_len, LenVec(v));
    m' := $UpdateMutation(m, SliceVec($Dereference(m), 0, new_len));
}

procedure {:inline 1} $1_vector_reverse_slice'address'(m: $Mutation (Vec (int)), left: int, right: int) returns (m': $Mutation (Vec (int))) {
    var left_vec: Vec (int);
    var mid_vec: Vec (int);
    var right_vec: Vec (int);
    var v: Vec (int);
    if (left > right) {
        call $ExecFailureAbort();
        return;
    }
    if (left == right) {
        m' := m;
        return;
    }
    v := $Dereference(m);
    if (!(right >= 0 && right <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    left_vec := SliceVec(v, 0, left);
    right_vec := SliceVec(v, right, LenVec(v));
    mid_vec := ReverseVec(SliceVec(v, left, right));
    m' := $UpdateMutation(m, ConcatVec(left_vec, ConcatVec(mid_vec, right_vec)));
}

procedure {:inline 1} $1_vector_rotate'address'(m: $Mutation (Vec (int)), rot: int) returns (n: int, m': $Mutation (Vec (int))) {
    var v: Vec (int);
    var len: int;
    var left_vec: Vec (int);
    var right_vec: Vec (int);
    v := $Dereference(m);
    if (!(rot >= 0 && rot <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    left_vec := SliceVec(v, 0, rot);
    right_vec := SliceVec(v, rot, LenVec(v));
    m' := $UpdateMutation(m, ConcatVec(right_vec, left_vec));
    n := LenVec(v) - rot;
}

procedure {:inline 1} $1_vector_rotate_slice'address'(m: $Mutation (Vec (int)), left: int, rot: int, right: int) returns (n: int, m': $Mutation (Vec (int))) {
    var left_vec: Vec (int);
    var mid_vec: Vec (int);
    var right_vec: Vec (int);
    var mid_left_vec: Vec (int);
    var mid_right_vec: Vec (int);
    var v: Vec (int);
    v := $Dereference(m);
    if (!(left <= rot && rot <= right)) {
        call $ExecFailureAbort();
        return;
    }
    if (!(right >= 0 && right <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    v := $Dereference(m);
    left_vec := SliceVec(v, 0, left);
    right_vec := SliceVec(v, right, LenVec(v));
    mid_left_vec := SliceVec(v, left, rot);
    mid_right_vec := SliceVec(v, rot, right);
    mid_vec := ConcatVec(mid_right_vec, mid_left_vec);
    m' := $UpdateMutation(m, ConcatVec(left_vec, ConcatVec(mid_vec, right_vec)));
    n := left + (right - rot);
}

procedure {:inline 1} $1_vector_insert'address'(m: $Mutation (Vec (int)), i: int, e: int) returns (m': $Mutation (Vec (int))) {
    var left_vec: Vec (int);
    var right_vec: Vec (int);
    var v: Vec (int);
    v := $Dereference(m);
    if (!(i >= 0 && i <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    if (i == LenVec(v)) {
        m' := $UpdateMutation(m, ExtendVec(v, e));
    } else {
        left_vec := ExtendVec(SliceVec(v, 0, i), e);
        right_vec := SliceVec(v, i, LenVec(v));
        m' := $UpdateMutation(m, ConcatVec(left_vec, right_vec));
    }
}

procedure {:inline 1} $1_vector_length'address'(v: Vec (int)) returns (l: int) {
    l := LenVec(v);
}

function {:inline} $1_vector_$length'address'(v: Vec (int)): int {
    LenVec(v)
}

procedure {:inline 1} $1_vector_borrow'address'(v: Vec (int), i: int) returns (dst: int) {
    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    dst := ReadVec(v, i);
}

function {:inline} $1_vector_$borrow'address'(v: Vec (int), i: int): int {
    ReadVec(v, i)
}

procedure {:inline 1} $1_vector_borrow_mut'address'(m: $Mutation (Vec (int)), index: int)
returns (dst: $Mutation (int), m': $Mutation (Vec (int)))
{
    var v: Vec (int);
    v := $Dereference(m);
    if (!InRangeVec(v, index)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Mutation(m->l, ExtendVec(m->p, index), ReadVec(v, index));
    m' := m;
}

function {:inline} $1_vector_$borrow_mut'address'(v: Vec (int), i: int): int {
    ReadVec(v, i)
}

procedure {:inline 1} $1_vector_destroy_empty'address'(v: Vec (int)) {
    if (!IsEmptyVec(v)) {
      call $ExecFailureAbort();
    }
}

procedure {:inline 1} $1_vector_swap'address'(m: $Mutation (Vec (int)), i: int, j: int) returns (m': $Mutation (Vec (int)))
{
    var v: Vec (int);
    v := $Dereference(m);
    if (!InRangeVec(v, i) || !InRangeVec(v, j)) {
        call $ExecFailureAbort();
        return;
    }
    m' := $UpdateMutation(m, SwapVec(v, i, j));
}

function {:inline} $1_vector_$swap'address'(v: Vec (int), i: int, j: int): Vec (int) {
    SwapVec(v, i, j)
}

procedure {:inline 1} $1_vector_remove'address'(m: $Mutation (Vec (int)), i: int) returns (e: int, m': $Mutation (Vec (int)))
{
    var v: Vec (int);

    v := $Dereference(m);

    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, i);
    m' := $UpdateMutation(m, RemoveAtVec(v, i));
}

procedure {:inline 1} $1_vector_swap_remove'address'(m: $Mutation (Vec (int)), i: int) returns (e: int, m': $Mutation (Vec (int)))
{
    var len: int;
    var v: Vec (int);

    v := $Dereference(m);
    len := LenVec(v);
    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, i);
    m' := $UpdateMutation(m, RemoveVec(SwapVec(v, i, len-1)));
}

procedure {:inline 1} $1_vector_contains'address'(v: Vec (int), e: int) returns (res: bool)  {
    res := $ContainsVec'address'(v, e);
}

procedure {:inline 1}
$1_vector_index_of'address'(v: Vec (int), e: int) returns (res1: bool, res2: int) {
    res2 := $IndexOfVec'address'(v, e);
    if (res2 >= 0) {
        res1 := true;
    } else {
        res1 := false;
        res2 := 0;
    }
}


// ----------------------------------------------------------------------------------
// Native Vector implementation for element type `u64`

// Not inlined. It appears faster this way.
function $IsEqual'vec'u64''(v1: Vec (int), v2: Vec (int)): bool {
    LenVec(v1) == LenVec(v2) &&
    (forall i: int:: InRangeVec(v1, i) ==> $IsEqual'u64'(ReadVec(v1, i), ReadVec(v2, i)))
}

// Not inlined.
function $IsPrefix'vec'u64''(v: Vec (int), prefix: Vec (int)): bool {
    LenVec(v) >= LenVec(prefix) &&
    (forall i: int:: InRangeVec(prefix, i) ==> $IsEqual'u64'(ReadVec(v, i), ReadVec(prefix, i)))
}

// Not inlined.
function $IsSuffix'vec'u64''(v: Vec (int), suffix: Vec (int)): bool {
    LenVec(v) >= LenVec(suffix) &&
    (forall i: int:: InRangeVec(suffix, i) ==> $IsEqual'u64'(ReadVec(v, LenVec(v) - LenVec(suffix) + i), ReadVec(suffix, i)))
}

// Not inlined.
function $IsValid'vec'u64''(v: Vec (int)): bool {
    $IsValid'u64'(LenVec(v)) &&
    (forall i: int:: InRangeVec(v, i) ==> $IsValid'u64'(ReadVec(v, i)))
}


function {:inline} $ContainsVec'u64'(v: Vec (int), e: int): bool {
    (exists i: int :: $IsValid'u64'(i) && InRangeVec(v, i) && $IsEqual'u64'(ReadVec(v, i), e))
}

function $IndexOfVec'u64'(v: Vec (int), e: int): int;
axiom (forall v: Vec (int), e: int:: {$IndexOfVec'u64'(v, e)}
    (var i := $IndexOfVec'u64'(v, e);
     if (!$ContainsVec'u64'(v, e)) then i == -1
     else $IsValid'u64'(i) && InRangeVec(v, i) && $IsEqual'u64'(ReadVec(v, i), e) &&
        (forall j: int :: $IsValid'u64'(j) && j >= 0 && j < i ==> !$IsEqual'u64'(ReadVec(v, j), e))));


function {:inline} $RangeVec'u64'(v: Vec (int)): $Range {
    $Range(0, LenVec(v))
}


function {:inline} $EmptyVec'u64'(): Vec (int) {
    EmptyVec()
}

procedure {:inline 1} $1_vector_empty'u64'() returns (v: Vec (int)) {
    v := EmptyVec();
}

function {:inline} $1_vector_$empty'u64'(): Vec (int) {
    EmptyVec()
}

procedure {:inline 1} $1_vector_is_empty'u64'(v: Vec (int)) returns (b: bool) {
    b := IsEmptyVec(v);
}

procedure {:inline 1} $1_vector_push_back'u64'(m: $Mutation (Vec (int)), val: int) returns (m': $Mutation (Vec (int))) {
    m' := $UpdateMutation(m, ExtendVec($Dereference(m), val));
}

function {:inline} $1_vector_$push_back'u64'(v: Vec (int), val: int): Vec (int) {
    ExtendVec(v, val)
}

procedure {:inline 1} $1_vector_pop_back'u64'(m: $Mutation (Vec (int))) returns (e: int, m': $Mutation (Vec (int))) {
    var v: Vec (int);
    var len: int;
    v := $Dereference(m);
    len := LenVec(v);
    if (len == 0) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, len-1);
    m' := $UpdateMutation(m, RemoveVec(v));
}

procedure {:inline 1} $1_vector_append'u64'(m: $Mutation (Vec (int)), other: Vec (int)) returns (m': $Mutation (Vec (int))) {
    m' := $UpdateMutation(m, ConcatVec($Dereference(m), other));
}

procedure {:inline 1} $1_vector_reverse'u64'(m: $Mutation (Vec (int))) returns (m': $Mutation (Vec (int))) {
    m' := $UpdateMutation(m, ReverseVec($Dereference(m)));
}

procedure {:inline 1} $1_vector_reverse_append'u64'(m: $Mutation (Vec (int)), other: Vec (int)) returns (m': $Mutation (Vec (int))) {
    m' := $UpdateMutation(m, ConcatVec($Dereference(m), ReverseVec(other)));
}

procedure {:inline 1} $1_vector_trim_reverse'u64'(m: $Mutation (Vec (int)), new_len: int) returns (v: (Vec (int)), m': $Mutation (Vec (int))) {
    var len: int;
    v := $Dereference(m);
    if (LenVec(v) < new_len) {
        call $ExecFailureAbort();
        return;
    }
    v := SliceVec(v, new_len, LenVec(v));
    v := ReverseVec(v);
    m' := $UpdateMutation(m, SliceVec($Dereference(m), 0, new_len));
}

procedure {:inline 1} $1_vector_trim'u64'(m: $Mutation (Vec (int)), new_len: int) returns (v: (Vec (int)), m': $Mutation (Vec (int))) {
    var len: int;
    v := $Dereference(m);
    if (LenVec(v) < new_len) {
        call $ExecFailureAbort();
        return;
    }
    v := SliceVec(v, new_len, LenVec(v));
    m' := $UpdateMutation(m, SliceVec($Dereference(m), 0, new_len));
}

procedure {:inline 1} $1_vector_reverse_slice'u64'(m: $Mutation (Vec (int)), left: int, right: int) returns (m': $Mutation (Vec (int))) {
    var left_vec: Vec (int);
    var mid_vec: Vec (int);
    var right_vec: Vec (int);
    var v: Vec (int);
    if (left > right) {
        call $ExecFailureAbort();
        return;
    }
    if (left == right) {
        m' := m;
        return;
    }
    v := $Dereference(m);
    if (!(right >= 0 && right <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    left_vec := SliceVec(v, 0, left);
    right_vec := SliceVec(v, right, LenVec(v));
    mid_vec := ReverseVec(SliceVec(v, left, right));
    m' := $UpdateMutation(m, ConcatVec(left_vec, ConcatVec(mid_vec, right_vec)));
}

procedure {:inline 1} $1_vector_rotate'u64'(m: $Mutation (Vec (int)), rot: int) returns (n: int, m': $Mutation (Vec (int))) {
    var v: Vec (int);
    var len: int;
    var left_vec: Vec (int);
    var right_vec: Vec (int);
    v := $Dereference(m);
    if (!(rot >= 0 && rot <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    left_vec := SliceVec(v, 0, rot);
    right_vec := SliceVec(v, rot, LenVec(v));
    m' := $UpdateMutation(m, ConcatVec(right_vec, left_vec));
    n := LenVec(v) - rot;
}

procedure {:inline 1} $1_vector_rotate_slice'u64'(m: $Mutation (Vec (int)), left: int, rot: int, right: int) returns (n: int, m': $Mutation (Vec (int))) {
    var left_vec: Vec (int);
    var mid_vec: Vec (int);
    var right_vec: Vec (int);
    var mid_left_vec: Vec (int);
    var mid_right_vec: Vec (int);
    var v: Vec (int);
    v := $Dereference(m);
    if (!(left <= rot && rot <= right)) {
        call $ExecFailureAbort();
        return;
    }
    if (!(right >= 0 && right <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    v := $Dereference(m);
    left_vec := SliceVec(v, 0, left);
    right_vec := SliceVec(v, right, LenVec(v));
    mid_left_vec := SliceVec(v, left, rot);
    mid_right_vec := SliceVec(v, rot, right);
    mid_vec := ConcatVec(mid_right_vec, mid_left_vec);
    m' := $UpdateMutation(m, ConcatVec(left_vec, ConcatVec(mid_vec, right_vec)));
    n := left + (right - rot);
}

procedure {:inline 1} $1_vector_insert'u64'(m: $Mutation (Vec (int)), i: int, e: int) returns (m': $Mutation (Vec (int))) {
    var left_vec: Vec (int);
    var right_vec: Vec (int);
    var v: Vec (int);
    v := $Dereference(m);
    if (!(i >= 0 && i <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    if (i == LenVec(v)) {
        m' := $UpdateMutation(m, ExtendVec(v, e));
    } else {
        left_vec := ExtendVec(SliceVec(v, 0, i), e);
        right_vec := SliceVec(v, i, LenVec(v));
        m' := $UpdateMutation(m, ConcatVec(left_vec, right_vec));
    }
}

procedure {:inline 1} $1_vector_length'u64'(v: Vec (int)) returns (l: int) {
    l := LenVec(v);
}

function {:inline} $1_vector_$length'u64'(v: Vec (int)): int {
    LenVec(v)
}

procedure {:inline 1} $1_vector_borrow'u64'(v: Vec (int), i: int) returns (dst: int) {
    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    dst := ReadVec(v, i);
}

function {:inline} $1_vector_$borrow'u64'(v: Vec (int), i: int): int {
    ReadVec(v, i)
}

procedure {:inline 1} $1_vector_borrow_mut'u64'(m: $Mutation (Vec (int)), index: int)
returns (dst: $Mutation (int), m': $Mutation (Vec (int)))
{
    var v: Vec (int);
    v := $Dereference(m);
    if (!InRangeVec(v, index)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Mutation(m->l, ExtendVec(m->p, index), ReadVec(v, index));
    m' := m;
}

function {:inline} $1_vector_$borrow_mut'u64'(v: Vec (int), i: int): int {
    ReadVec(v, i)
}

procedure {:inline 1} $1_vector_destroy_empty'u64'(v: Vec (int)) {
    if (!IsEmptyVec(v)) {
      call $ExecFailureAbort();
    }
}

procedure {:inline 1} $1_vector_swap'u64'(m: $Mutation (Vec (int)), i: int, j: int) returns (m': $Mutation (Vec (int)))
{
    var v: Vec (int);
    v := $Dereference(m);
    if (!InRangeVec(v, i) || !InRangeVec(v, j)) {
        call $ExecFailureAbort();
        return;
    }
    m' := $UpdateMutation(m, SwapVec(v, i, j));
}

function {:inline} $1_vector_$swap'u64'(v: Vec (int), i: int, j: int): Vec (int) {
    SwapVec(v, i, j)
}

procedure {:inline 1} $1_vector_remove'u64'(m: $Mutation (Vec (int)), i: int) returns (e: int, m': $Mutation (Vec (int)))
{
    var v: Vec (int);

    v := $Dereference(m);

    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, i);
    m' := $UpdateMutation(m, RemoveAtVec(v, i));
}

procedure {:inline 1} $1_vector_swap_remove'u64'(m: $Mutation (Vec (int)), i: int) returns (e: int, m': $Mutation (Vec (int)))
{
    var len: int;
    var v: Vec (int);

    v := $Dereference(m);
    len := LenVec(v);
    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, i);
    m' := $UpdateMutation(m, RemoveVec(SwapVec(v, i, len-1)));
}

procedure {:inline 1} $1_vector_contains'u64'(v: Vec (int), e: int) returns (res: bool)  {
    res := $ContainsVec'u64'(v, e);
}

procedure {:inline 1}
$1_vector_index_of'u64'(v: Vec (int), e: int) returns (res1: bool, res2: int) {
    res2 := $IndexOfVec'u64'(v, e);
    if (res2 >= 0) {
        res1 := true;
    } else {
        res1 := false;
        res2 := 0;
    }
}


// ----------------------------------------------------------------------------------
// Native Vector implementation for element type `u8`

// Not inlined. It appears faster this way.
function $IsEqual'vec'u8''(v1: Vec (int), v2: Vec (int)): bool {
    LenVec(v1) == LenVec(v2) &&
    (forall i: int:: InRangeVec(v1, i) ==> $IsEqual'u8'(ReadVec(v1, i), ReadVec(v2, i)))
}

// Not inlined.
function $IsPrefix'vec'u8''(v: Vec (int), prefix: Vec (int)): bool {
    LenVec(v) >= LenVec(prefix) &&
    (forall i: int:: InRangeVec(prefix, i) ==> $IsEqual'u8'(ReadVec(v, i), ReadVec(prefix, i)))
}

// Not inlined.
function $IsSuffix'vec'u8''(v: Vec (int), suffix: Vec (int)): bool {
    LenVec(v) >= LenVec(suffix) &&
    (forall i: int:: InRangeVec(suffix, i) ==> $IsEqual'u8'(ReadVec(v, LenVec(v) - LenVec(suffix) + i), ReadVec(suffix, i)))
}

// Not inlined.
function $IsValid'vec'u8''(v: Vec (int)): bool {
    $IsValid'u64'(LenVec(v)) &&
    (forall i: int:: InRangeVec(v, i) ==> $IsValid'u8'(ReadVec(v, i)))
}


function {:inline} $ContainsVec'u8'(v: Vec (int), e: int): bool {
    (exists i: int :: $IsValid'u64'(i) && InRangeVec(v, i) && $IsEqual'u8'(ReadVec(v, i), e))
}

function $IndexOfVec'u8'(v: Vec (int), e: int): int;
axiom (forall v: Vec (int), e: int:: {$IndexOfVec'u8'(v, e)}
    (var i := $IndexOfVec'u8'(v, e);
     if (!$ContainsVec'u8'(v, e)) then i == -1
     else $IsValid'u64'(i) && InRangeVec(v, i) && $IsEqual'u8'(ReadVec(v, i), e) &&
        (forall j: int :: $IsValid'u64'(j) && j >= 0 && j < i ==> !$IsEqual'u8'(ReadVec(v, j), e))));


function {:inline} $RangeVec'u8'(v: Vec (int)): $Range {
    $Range(0, LenVec(v))
}


function {:inline} $EmptyVec'u8'(): Vec (int) {
    EmptyVec()
}

procedure {:inline 1} $1_vector_empty'u8'() returns (v: Vec (int)) {
    v := EmptyVec();
}

function {:inline} $1_vector_$empty'u8'(): Vec (int) {
    EmptyVec()
}

procedure {:inline 1} $1_vector_is_empty'u8'(v: Vec (int)) returns (b: bool) {
    b := IsEmptyVec(v);
}

procedure {:inline 1} $1_vector_push_back'u8'(m: $Mutation (Vec (int)), val: int) returns (m': $Mutation (Vec (int))) {
    m' := $UpdateMutation(m, ExtendVec($Dereference(m), val));
}

function {:inline} $1_vector_$push_back'u8'(v: Vec (int), val: int): Vec (int) {
    ExtendVec(v, val)
}

procedure {:inline 1} $1_vector_pop_back'u8'(m: $Mutation (Vec (int))) returns (e: int, m': $Mutation (Vec (int))) {
    var v: Vec (int);
    var len: int;
    v := $Dereference(m);
    len := LenVec(v);
    if (len == 0) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, len-1);
    m' := $UpdateMutation(m, RemoveVec(v));
}

procedure {:inline 1} $1_vector_append'u8'(m: $Mutation (Vec (int)), other: Vec (int)) returns (m': $Mutation (Vec (int))) {
    m' := $UpdateMutation(m, ConcatVec($Dereference(m), other));
}

procedure {:inline 1} $1_vector_reverse'u8'(m: $Mutation (Vec (int))) returns (m': $Mutation (Vec (int))) {
    m' := $UpdateMutation(m, ReverseVec($Dereference(m)));
}

procedure {:inline 1} $1_vector_reverse_append'u8'(m: $Mutation (Vec (int)), other: Vec (int)) returns (m': $Mutation (Vec (int))) {
    m' := $UpdateMutation(m, ConcatVec($Dereference(m), ReverseVec(other)));
}

procedure {:inline 1} $1_vector_trim_reverse'u8'(m: $Mutation (Vec (int)), new_len: int) returns (v: (Vec (int)), m': $Mutation (Vec (int))) {
    var len: int;
    v := $Dereference(m);
    if (LenVec(v) < new_len) {
        call $ExecFailureAbort();
        return;
    }
    v := SliceVec(v, new_len, LenVec(v));
    v := ReverseVec(v);
    m' := $UpdateMutation(m, SliceVec($Dereference(m), 0, new_len));
}

procedure {:inline 1} $1_vector_trim'u8'(m: $Mutation (Vec (int)), new_len: int) returns (v: (Vec (int)), m': $Mutation (Vec (int))) {
    var len: int;
    v := $Dereference(m);
    if (LenVec(v) < new_len) {
        call $ExecFailureAbort();
        return;
    }
    v := SliceVec(v, new_len, LenVec(v));
    m' := $UpdateMutation(m, SliceVec($Dereference(m), 0, new_len));
}

procedure {:inline 1} $1_vector_reverse_slice'u8'(m: $Mutation (Vec (int)), left: int, right: int) returns (m': $Mutation (Vec (int))) {
    var left_vec: Vec (int);
    var mid_vec: Vec (int);
    var right_vec: Vec (int);
    var v: Vec (int);
    if (left > right) {
        call $ExecFailureAbort();
        return;
    }
    if (left == right) {
        m' := m;
        return;
    }
    v := $Dereference(m);
    if (!(right >= 0 && right <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    left_vec := SliceVec(v, 0, left);
    right_vec := SliceVec(v, right, LenVec(v));
    mid_vec := ReverseVec(SliceVec(v, left, right));
    m' := $UpdateMutation(m, ConcatVec(left_vec, ConcatVec(mid_vec, right_vec)));
}

procedure {:inline 1} $1_vector_rotate'u8'(m: $Mutation (Vec (int)), rot: int) returns (n: int, m': $Mutation (Vec (int))) {
    var v: Vec (int);
    var len: int;
    var left_vec: Vec (int);
    var right_vec: Vec (int);
    v := $Dereference(m);
    if (!(rot >= 0 && rot <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    left_vec := SliceVec(v, 0, rot);
    right_vec := SliceVec(v, rot, LenVec(v));
    m' := $UpdateMutation(m, ConcatVec(right_vec, left_vec));
    n := LenVec(v) - rot;
}

procedure {:inline 1} $1_vector_rotate_slice'u8'(m: $Mutation (Vec (int)), left: int, rot: int, right: int) returns (n: int, m': $Mutation (Vec (int))) {
    var left_vec: Vec (int);
    var mid_vec: Vec (int);
    var right_vec: Vec (int);
    var mid_left_vec: Vec (int);
    var mid_right_vec: Vec (int);
    var v: Vec (int);
    v := $Dereference(m);
    if (!(left <= rot && rot <= right)) {
        call $ExecFailureAbort();
        return;
    }
    if (!(right >= 0 && right <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    v := $Dereference(m);
    left_vec := SliceVec(v, 0, left);
    right_vec := SliceVec(v, right, LenVec(v));
    mid_left_vec := SliceVec(v, left, rot);
    mid_right_vec := SliceVec(v, rot, right);
    mid_vec := ConcatVec(mid_right_vec, mid_left_vec);
    m' := $UpdateMutation(m, ConcatVec(left_vec, ConcatVec(mid_vec, right_vec)));
    n := left + (right - rot);
}

procedure {:inline 1} $1_vector_insert'u8'(m: $Mutation (Vec (int)), i: int, e: int) returns (m': $Mutation (Vec (int))) {
    var left_vec: Vec (int);
    var right_vec: Vec (int);
    var v: Vec (int);
    v := $Dereference(m);
    if (!(i >= 0 && i <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    if (i == LenVec(v)) {
        m' := $UpdateMutation(m, ExtendVec(v, e));
    } else {
        left_vec := ExtendVec(SliceVec(v, 0, i), e);
        right_vec := SliceVec(v, i, LenVec(v));
        m' := $UpdateMutation(m, ConcatVec(left_vec, right_vec));
    }
}

procedure {:inline 1} $1_vector_length'u8'(v: Vec (int)) returns (l: int) {
    l := LenVec(v);
}

function {:inline} $1_vector_$length'u8'(v: Vec (int)): int {
    LenVec(v)
}

procedure {:inline 1} $1_vector_borrow'u8'(v: Vec (int), i: int) returns (dst: int) {
    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    dst := ReadVec(v, i);
}

function {:inline} $1_vector_$borrow'u8'(v: Vec (int), i: int): int {
    ReadVec(v, i)
}

procedure {:inline 1} $1_vector_borrow_mut'u8'(m: $Mutation (Vec (int)), index: int)
returns (dst: $Mutation (int), m': $Mutation (Vec (int)))
{
    var v: Vec (int);
    v := $Dereference(m);
    if (!InRangeVec(v, index)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Mutation(m->l, ExtendVec(m->p, index), ReadVec(v, index));
    m' := m;
}

function {:inline} $1_vector_$borrow_mut'u8'(v: Vec (int), i: int): int {
    ReadVec(v, i)
}

procedure {:inline 1} $1_vector_destroy_empty'u8'(v: Vec (int)) {
    if (!IsEmptyVec(v)) {
      call $ExecFailureAbort();
    }
}

procedure {:inline 1} $1_vector_swap'u8'(m: $Mutation (Vec (int)), i: int, j: int) returns (m': $Mutation (Vec (int)))
{
    var v: Vec (int);
    v := $Dereference(m);
    if (!InRangeVec(v, i) || !InRangeVec(v, j)) {
        call $ExecFailureAbort();
        return;
    }
    m' := $UpdateMutation(m, SwapVec(v, i, j));
}

function {:inline} $1_vector_$swap'u8'(v: Vec (int), i: int, j: int): Vec (int) {
    SwapVec(v, i, j)
}

procedure {:inline 1} $1_vector_remove'u8'(m: $Mutation (Vec (int)), i: int) returns (e: int, m': $Mutation (Vec (int)))
{
    var v: Vec (int);

    v := $Dereference(m);

    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, i);
    m' := $UpdateMutation(m, RemoveAtVec(v, i));
}

procedure {:inline 1} $1_vector_swap_remove'u8'(m: $Mutation (Vec (int)), i: int) returns (e: int, m': $Mutation (Vec (int)))
{
    var len: int;
    var v: Vec (int);

    v := $Dereference(m);
    len := LenVec(v);
    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, i);
    m' := $UpdateMutation(m, RemoveVec(SwapVec(v, i, len-1)));
}

procedure {:inline 1} $1_vector_contains'u8'(v: Vec (int), e: int) returns (res: bool)  {
    res := $ContainsVec'u8'(v, e);
}

procedure {:inline 1}
$1_vector_index_of'u8'(v: Vec (int), e: int) returns (res1: bool, res2: int) {
    res2 := $IndexOfVec'u8'(v, e);
    if (res2 >= 0) {
        res1 := true;
    } else {
        res1 := false;
        res2 := 0;
    }
}


// ----------------------------------------------------------------------------------
// Native Vector implementation for element type `bv64`

// Not inlined. It appears faster this way.
function $IsEqual'vec'bv64''(v1: Vec (bv64), v2: Vec (bv64)): bool {
    LenVec(v1) == LenVec(v2) &&
    (forall i: int:: InRangeVec(v1, i) ==> $IsEqual'bv64'(ReadVec(v1, i), ReadVec(v2, i)))
}

// Not inlined.
function $IsPrefix'vec'bv64''(v: Vec (bv64), prefix: Vec (bv64)): bool {
    LenVec(v) >= LenVec(prefix) &&
    (forall i: int:: InRangeVec(prefix, i) ==> $IsEqual'bv64'(ReadVec(v, i), ReadVec(prefix, i)))
}

// Not inlined.
function $IsSuffix'vec'bv64''(v: Vec (bv64), suffix: Vec (bv64)): bool {
    LenVec(v) >= LenVec(suffix) &&
    (forall i: int:: InRangeVec(suffix, i) ==> $IsEqual'bv64'(ReadVec(v, LenVec(v) - LenVec(suffix) + i), ReadVec(suffix, i)))
}

// Not inlined.
function $IsValid'vec'bv64''(v: Vec (bv64)): bool {
    $IsValid'u64'(LenVec(v)) &&
    (forall i: int:: InRangeVec(v, i) ==> $IsValid'bv64'(ReadVec(v, i)))
}


function {:inline} $ContainsVec'bv64'(v: Vec (bv64), e: bv64): bool {
    (exists i: int :: $IsValid'u64'(i) && InRangeVec(v, i) && $IsEqual'bv64'(ReadVec(v, i), e))
}

function $IndexOfVec'bv64'(v: Vec (bv64), e: bv64): int;
axiom (forall v: Vec (bv64), e: bv64:: {$IndexOfVec'bv64'(v, e)}
    (var i := $IndexOfVec'bv64'(v, e);
     if (!$ContainsVec'bv64'(v, e)) then i == -1
     else $IsValid'u64'(i) && InRangeVec(v, i) && $IsEqual'bv64'(ReadVec(v, i), e) &&
        (forall j: int :: $IsValid'u64'(j) && j >= 0 && j < i ==> !$IsEqual'bv64'(ReadVec(v, j), e))));


function {:inline} $RangeVec'bv64'(v: Vec (bv64)): $Range {
    $Range(0, LenVec(v))
}


function {:inline} $EmptyVec'bv64'(): Vec (bv64) {
    EmptyVec()
}

procedure {:inline 1} $1_vector_empty'bv64'() returns (v: Vec (bv64)) {
    v := EmptyVec();
}

function {:inline} $1_vector_$empty'bv64'(): Vec (bv64) {
    EmptyVec()
}

procedure {:inline 1} $1_vector_is_empty'bv64'(v: Vec (bv64)) returns (b: bool) {
    b := IsEmptyVec(v);
}

procedure {:inline 1} $1_vector_push_back'bv64'(m: $Mutation (Vec (bv64)), val: bv64) returns (m': $Mutation (Vec (bv64))) {
    m' := $UpdateMutation(m, ExtendVec($Dereference(m), val));
}

function {:inline} $1_vector_$push_back'bv64'(v: Vec (bv64), val: bv64): Vec (bv64) {
    ExtendVec(v, val)
}

procedure {:inline 1} $1_vector_pop_back'bv64'(m: $Mutation (Vec (bv64))) returns (e: bv64, m': $Mutation (Vec (bv64))) {
    var v: Vec (bv64);
    var len: int;
    v := $Dereference(m);
    len := LenVec(v);
    if (len == 0) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, len-1);
    m' := $UpdateMutation(m, RemoveVec(v));
}

procedure {:inline 1} $1_vector_append'bv64'(m: $Mutation (Vec (bv64)), other: Vec (bv64)) returns (m': $Mutation (Vec (bv64))) {
    m' := $UpdateMutation(m, ConcatVec($Dereference(m), other));
}

procedure {:inline 1} $1_vector_reverse'bv64'(m: $Mutation (Vec (bv64))) returns (m': $Mutation (Vec (bv64))) {
    m' := $UpdateMutation(m, ReverseVec($Dereference(m)));
}

procedure {:inline 1} $1_vector_reverse_append'bv64'(m: $Mutation (Vec (bv64)), other: Vec (bv64)) returns (m': $Mutation (Vec (bv64))) {
    m' := $UpdateMutation(m, ConcatVec($Dereference(m), ReverseVec(other)));
}

procedure {:inline 1} $1_vector_trim_reverse'bv64'(m: $Mutation (Vec (bv64)), new_len: int) returns (v: (Vec (bv64)), m': $Mutation (Vec (bv64))) {
    var len: int;
    v := $Dereference(m);
    if (LenVec(v) < new_len) {
        call $ExecFailureAbort();
        return;
    }
    v := SliceVec(v, new_len, LenVec(v));
    v := ReverseVec(v);
    m' := $UpdateMutation(m, SliceVec($Dereference(m), 0, new_len));
}

procedure {:inline 1} $1_vector_trim'bv64'(m: $Mutation (Vec (bv64)), new_len: int) returns (v: (Vec (bv64)), m': $Mutation (Vec (bv64))) {
    var len: int;
    v := $Dereference(m);
    if (LenVec(v) < new_len) {
        call $ExecFailureAbort();
        return;
    }
    v := SliceVec(v, new_len, LenVec(v));
    m' := $UpdateMutation(m, SliceVec($Dereference(m), 0, new_len));
}

procedure {:inline 1} $1_vector_reverse_slice'bv64'(m: $Mutation (Vec (bv64)), left: int, right: int) returns (m': $Mutation (Vec (bv64))) {
    var left_vec: Vec (bv64);
    var mid_vec: Vec (bv64);
    var right_vec: Vec (bv64);
    var v: Vec (bv64);
    if (left > right) {
        call $ExecFailureAbort();
        return;
    }
    if (left == right) {
        m' := m;
        return;
    }
    v := $Dereference(m);
    if (!(right >= 0 && right <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    left_vec := SliceVec(v, 0, left);
    right_vec := SliceVec(v, right, LenVec(v));
    mid_vec := ReverseVec(SliceVec(v, left, right));
    m' := $UpdateMutation(m, ConcatVec(left_vec, ConcatVec(mid_vec, right_vec)));
}

procedure {:inline 1} $1_vector_rotate'bv64'(m: $Mutation (Vec (bv64)), rot: int) returns (n: int, m': $Mutation (Vec (bv64))) {
    var v: Vec (bv64);
    var len: int;
    var left_vec: Vec (bv64);
    var right_vec: Vec (bv64);
    v := $Dereference(m);
    if (!(rot >= 0 && rot <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    left_vec := SliceVec(v, 0, rot);
    right_vec := SliceVec(v, rot, LenVec(v));
    m' := $UpdateMutation(m, ConcatVec(right_vec, left_vec));
    n := LenVec(v) - rot;
}

procedure {:inline 1} $1_vector_rotate_slice'bv64'(m: $Mutation (Vec (bv64)), left: int, rot: int, right: int) returns (n: int, m': $Mutation (Vec (bv64))) {
    var left_vec: Vec (bv64);
    var mid_vec: Vec (bv64);
    var right_vec: Vec (bv64);
    var mid_left_vec: Vec (bv64);
    var mid_right_vec: Vec (bv64);
    var v: Vec (bv64);
    v := $Dereference(m);
    if (!(left <= rot && rot <= right)) {
        call $ExecFailureAbort();
        return;
    }
    if (!(right >= 0 && right <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    v := $Dereference(m);
    left_vec := SliceVec(v, 0, left);
    right_vec := SliceVec(v, right, LenVec(v));
    mid_left_vec := SliceVec(v, left, rot);
    mid_right_vec := SliceVec(v, rot, right);
    mid_vec := ConcatVec(mid_right_vec, mid_left_vec);
    m' := $UpdateMutation(m, ConcatVec(left_vec, ConcatVec(mid_vec, right_vec)));
    n := left + (right - rot);
}

procedure {:inline 1} $1_vector_insert'bv64'(m: $Mutation (Vec (bv64)), i: int, e: bv64) returns (m': $Mutation (Vec (bv64))) {
    var left_vec: Vec (bv64);
    var right_vec: Vec (bv64);
    var v: Vec (bv64);
    v := $Dereference(m);
    if (!(i >= 0 && i <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    if (i == LenVec(v)) {
        m' := $UpdateMutation(m, ExtendVec(v, e));
    } else {
        left_vec := ExtendVec(SliceVec(v, 0, i), e);
        right_vec := SliceVec(v, i, LenVec(v));
        m' := $UpdateMutation(m, ConcatVec(left_vec, right_vec));
    }
}

procedure {:inline 1} $1_vector_length'bv64'(v: Vec (bv64)) returns (l: int) {
    l := LenVec(v);
}

function {:inline} $1_vector_$length'bv64'(v: Vec (bv64)): int {
    LenVec(v)
}

procedure {:inline 1} $1_vector_borrow'bv64'(v: Vec (bv64), i: int) returns (dst: bv64) {
    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    dst := ReadVec(v, i);
}

function {:inline} $1_vector_$borrow'bv64'(v: Vec (bv64), i: int): bv64 {
    ReadVec(v, i)
}

procedure {:inline 1} $1_vector_borrow_mut'bv64'(m: $Mutation (Vec (bv64)), index: int)
returns (dst: $Mutation (bv64), m': $Mutation (Vec (bv64)))
{
    var v: Vec (bv64);
    v := $Dereference(m);
    if (!InRangeVec(v, index)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Mutation(m->l, ExtendVec(m->p, index), ReadVec(v, index));
    m' := m;
}

function {:inline} $1_vector_$borrow_mut'bv64'(v: Vec (bv64), i: int): bv64 {
    ReadVec(v, i)
}

procedure {:inline 1} $1_vector_destroy_empty'bv64'(v: Vec (bv64)) {
    if (!IsEmptyVec(v)) {
      call $ExecFailureAbort();
    }
}

procedure {:inline 1} $1_vector_swap'bv64'(m: $Mutation (Vec (bv64)), i: int, j: int) returns (m': $Mutation (Vec (bv64)))
{
    var v: Vec (bv64);
    v := $Dereference(m);
    if (!InRangeVec(v, i) || !InRangeVec(v, j)) {
        call $ExecFailureAbort();
        return;
    }
    m' := $UpdateMutation(m, SwapVec(v, i, j));
}

function {:inline} $1_vector_$swap'bv64'(v: Vec (bv64), i: int, j: int): Vec (bv64) {
    SwapVec(v, i, j)
}

procedure {:inline 1} $1_vector_remove'bv64'(m: $Mutation (Vec (bv64)), i: int) returns (e: bv64, m': $Mutation (Vec (bv64)))
{
    var v: Vec (bv64);

    v := $Dereference(m);

    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, i);
    m' := $UpdateMutation(m, RemoveAtVec(v, i));
}

procedure {:inline 1} $1_vector_swap_remove'bv64'(m: $Mutation (Vec (bv64)), i: int) returns (e: bv64, m': $Mutation (Vec (bv64)))
{
    var len: int;
    var v: Vec (bv64);

    v := $Dereference(m);
    len := LenVec(v);
    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, i);
    m' := $UpdateMutation(m, RemoveVec(SwapVec(v, i, len-1)));
}

procedure {:inline 1} $1_vector_contains'bv64'(v: Vec (bv64), e: bv64) returns (res: bool)  {
    res := $ContainsVec'bv64'(v, e);
}

procedure {:inline 1}
$1_vector_index_of'bv64'(v: Vec (bv64), e: bv64) returns (res1: bool, res2: int) {
    res2 := $IndexOfVec'bv64'(v, e);
    if (res2 >= 0) {
        res1 := true;
    } else {
        res1 := false;
        res2 := 0;
    }
}


// ----------------------------------------------------------------------------------
// Native Vector implementation for element type `bv8`

// Not inlined. It appears faster this way.
function $IsEqual'vec'bv8''(v1: Vec (bv8), v2: Vec (bv8)): bool {
    LenVec(v1) == LenVec(v2) &&
    (forall i: int:: InRangeVec(v1, i) ==> $IsEqual'bv8'(ReadVec(v1, i), ReadVec(v2, i)))
}

// Not inlined.
function $IsPrefix'vec'bv8''(v: Vec (bv8), prefix: Vec (bv8)): bool {
    LenVec(v) >= LenVec(prefix) &&
    (forall i: int:: InRangeVec(prefix, i) ==> $IsEqual'bv8'(ReadVec(v, i), ReadVec(prefix, i)))
}

// Not inlined.
function $IsSuffix'vec'bv8''(v: Vec (bv8), suffix: Vec (bv8)): bool {
    LenVec(v) >= LenVec(suffix) &&
    (forall i: int:: InRangeVec(suffix, i) ==> $IsEqual'bv8'(ReadVec(v, LenVec(v) - LenVec(suffix) + i), ReadVec(suffix, i)))
}

// Not inlined.
function $IsValid'vec'bv8''(v: Vec (bv8)): bool {
    $IsValid'u64'(LenVec(v)) &&
    (forall i: int:: InRangeVec(v, i) ==> $IsValid'bv8'(ReadVec(v, i)))
}


function {:inline} $ContainsVec'bv8'(v: Vec (bv8), e: bv8): bool {
    (exists i: int :: $IsValid'u64'(i) && InRangeVec(v, i) && $IsEqual'bv8'(ReadVec(v, i), e))
}

function $IndexOfVec'bv8'(v: Vec (bv8), e: bv8): int;
axiom (forall v: Vec (bv8), e: bv8:: {$IndexOfVec'bv8'(v, e)}
    (var i := $IndexOfVec'bv8'(v, e);
     if (!$ContainsVec'bv8'(v, e)) then i == -1
     else $IsValid'u64'(i) && InRangeVec(v, i) && $IsEqual'bv8'(ReadVec(v, i), e) &&
        (forall j: int :: $IsValid'u64'(j) && j >= 0 && j < i ==> !$IsEqual'bv8'(ReadVec(v, j), e))));


function {:inline} $RangeVec'bv8'(v: Vec (bv8)): $Range {
    $Range(0, LenVec(v))
}


function {:inline} $EmptyVec'bv8'(): Vec (bv8) {
    EmptyVec()
}

procedure {:inline 1} $1_vector_empty'bv8'() returns (v: Vec (bv8)) {
    v := EmptyVec();
}

function {:inline} $1_vector_$empty'bv8'(): Vec (bv8) {
    EmptyVec()
}

procedure {:inline 1} $1_vector_is_empty'bv8'(v: Vec (bv8)) returns (b: bool) {
    b := IsEmptyVec(v);
}

procedure {:inline 1} $1_vector_push_back'bv8'(m: $Mutation (Vec (bv8)), val: bv8) returns (m': $Mutation (Vec (bv8))) {
    m' := $UpdateMutation(m, ExtendVec($Dereference(m), val));
}

function {:inline} $1_vector_$push_back'bv8'(v: Vec (bv8), val: bv8): Vec (bv8) {
    ExtendVec(v, val)
}

procedure {:inline 1} $1_vector_pop_back'bv8'(m: $Mutation (Vec (bv8))) returns (e: bv8, m': $Mutation (Vec (bv8))) {
    var v: Vec (bv8);
    var len: int;
    v := $Dereference(m);
    len := LenVec(v);
    if (len == 0) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, len-1);
    m' := $UpdateMutation(m, RemoveVec(v));
}

procedure {:inline 1} $1_vector_append'bv8'(m: $Mutation (Vec (bv8)), other: Vec (bv8)) returns (m': $Mutation (Vec (bv8))) {
    m' := $UpdateMutation(m, ConcatVec($Dereference(m), other));
}

procedure {:inline 1} $1_vector_reverse'bv8'(m: $Mutation (Vec (bv8))) returns (m': $Mutation (Vec (bv8))) {
    m' := $UpdateMutation(m, ReverseVec($Dereference(m)));
}

procedure {:inline 1} $1_vector_reverse_append'bv8'(m: $Mutation (Vec (bv8)), other: Vec (bv8)) returns (m': $Mutation (Vec (bv8))) {
    m' := $UpdateMutation(m, ConcatVec($Dereference(m), ReverseVec(other)));
}

procedure {:inline 1} $1_vector_trim_reverse'bv8'(m: $Mutation (Vec (bv8)), new_len: int) returns (v: (Vec (bv8)), m': $Mutation (Vec (bv8))) {
    var len: int;
    v := $Dereference(m);
    if (LenVec(v) < new_len) {
        call $ExecFailureAbort();
        return;
    }
    v := SliceVec(v, new_len, LenVec(v));
    v := ReverseVec(v);
    m' := $UpdateMutation(m, SliceVec($Dereference(m), 0, new_len));
}

procedure {:inline 1} $1_vector_trim'bv8'(m: $Mutation (Vec (bv8)), new_len: int) returns (v: (Vec (bv8)), m': $Mutation (Vec (bv8))) {
    var len: int;
    v := $Dereference(m);
    if (LenVec(v) < new_len) {
        call $ExecFailureAbort();
        return;
    }
    v := SliceVec(v, new_len, LenVec(v));
    m' := $UpdateMutation(m, SliceVec($Dereference(m), 0, new_len));
}

procedure {:inline 1} $1_vector_reverse_slice'bv8'(m: $Mutation (Vec (bv8)), left: int, right: int) returns (m': $Mutation (Vec (bv8))) {
    var left_vec: Vec (bv8);
    var mid_vec: Vec (bv8);
    var right_vec: Vec (bv8);
    var v: Vec (bv8);
    if (left > right) {
        call $ExecFailureAbort();
        return;
    }
    if (left == right) {
        m' := m;
        return;
    }
    v := $Dereference(m);
    if (!(right >= 0 && right <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    left_vec := SliceVec(v, 0, left);
    right_vec := SliceVec(v, right, LenVec(v));
    mid_vec := ReverseVec(SliceVec(v, left, right));
    m' := $UpdateMutation(m, ConcatVec(left_vec, ConcatVec(mid_vec, right_vec)));
}

procedure {:inline 1} $1_vector_rotate'bv8'(m: $Mutation (Vec (bv8)), rot: int) returns (n: int, m': $Mutation (Vec (bv8))) {
    var v: Vec (bv8);
    var len: int;
    var left_vec: Vec (bv8);
    var right_vec: Vec (bv8);
    v := $Dereference(m);
    if (!(rot >= 0 && rot <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    left_vec := SliceVec(v, 0, rot);
    right_vec := SliceVec(v, rot, LenVec(v));
    m' := $UpdateMutation(m, ConcatVec(right_vec, left_vec));
    n := LenVec(v) - rot;
}

procedure {:inline 1} $1_vector_rotate_slice'bv8'(m: $Mutation (Vec (bv8)), left: int, rot: int, right: int) returns (n: int, m': $Mutation (Vec (bv8))) {
    var left_vec: Vec (bv8);
    var mid_vec: Vec (bv8);
    var right_vec: Vec (bv8);
    var mid_left_vec: Vec (bv8);
    var mid_right_vec: Vec (bv8);
    var v: Vec (bv8);
    v := $Dereference(m);
    if (!(left <= rot && rot <= right)) {
        call $ExecFailureAbort();
        return;
    }
    if (!(right >= 0 && right <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    v := $Dereference(m);
    left_vec := SliceVec(v, 0, left);
    right_vec := SliceVec(v, right, LenVec(v));
    mid_left_vec := SliceVec(v, left, rot);
    mid_right_vec := SliceVec(v, rot, right);
    mid_vec := ConcatVec(mid_right_vec, mid_left_vec);
    m' := $UpdateMutation(m, ConcatVec(left_vec, ConcatVec(mid_vec, right_vec)));
    n := left + (right - rot);
}

procedure {:inline 1} $1_vector_insert'bv8'(m: $Mutation (Vec (bv8)), i: int, e: bv8) returns (m': $Mutation (Vec (bv8))) {
    var left_vec: Vec (bv8);
    var right_vec: Vec (bv8);
    var v: Vec (bv8);
    v := $Dereference(m);
    if (!(i >= 0 && i <= LenVec(v))) {
        call $ExecFailureAbort();
        return;
    }
    if (i == LenVec(v)) {
        m' := $UpdateMutation(m, ExtendVec(v, e));
    } else {
        left_vec := ExtendVec(SliceVec(v, 0, i), e);
        right_vec := SliceVec(v, i, LenVec(v));
        m' := $UpdateMutation(m, ConcatVec(left_vec, right_vec));
    }
}

procedure {:inline 1} $1_vector_length'bv8'(v: Vec (bv8)) returns (l: int) {
    l := LenVec(v);
}

function {:inline} $1_vector_$length'bv8'(v: Vec (bv8)): int {
    LenVec(v)
}

procedure {:inline 1} $1_vector_borrow'bv8'(v: Vec (bv8), i: int) returns (dst: bv8) {
    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    dst := ReadVec(v, i);
}

function {:inline} $1_vector_$borrow'bv8'(v: Vec (bv8), i: int): bv8 {
    ReadVec(v, i)
}

procedure {:inline 1} $1_vector_borrow_mut'bv8'(m: $Mutation (Vec (bv8)), index: int)
returns (dst: $Mutation (bv8), m': $Mutation (Vec (bv8)))
{
    var v: Vec (bv8);
    v := $Dereference(m);
    if (!InRangeVec(v, index)) {
        call $ExecFailureAbort();
        return;
    }
    dst := $Mutation(m->l, ExtendVec(m->p, index), ReadVec(v, index));
    m' := m;
}

function {:inline} $1_vector_$borrow_mut'bv8'(v: Vec (bv8), i: int): bv8 {
    ReadVec(v, i)
}

procedure {:inline 1} $1_vector_destroy_empty'bv8'(v: Vec (bv8)) {
    if (!IsEmptyVec(v)) {
      call $ExecFailureAbort();
    }
}

procedure {:inline 1} $1_vector_swap'bv8'(m: $Mutation (Vec (bv8)), i: int, j: int) returns (m': $Mutation (Vec (bv8)))
{
    var v: Vec (bv8);
    v := $Dereference(m);
    if (!InRangeVec(v, i) || !InRangeVec(v, j)) {
        call $ExecFailureAbort();
        return;
    }
    m' := $UpdateMutation(m, SwapVec(v, i, j));
}

function {:inline} $1_vector_$swap'bv8'(v: Vec (bv8), i: int, j: int): Vec (bv8) {
    SwapVec(v, i, j)
}

procedure {:inline 1} $1_vector_remove'bv8'(m: $Mutation (Vec (bv8)), i: int) returns (e: bv8, m': $Mutation (Vec (bv8)))
{
    var v: Vec (bv8);

    v := $Dereference(m);

    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, i);
    m' := $UpdateMutation(m, RemoveAtVec(v, i));
}

procedure {:inline 1} $1_vector_swap_remove'bv8'(m: $Mutation (Vec (bv8)), i: int) returns (e: bv8, m': $Mutation (Vec (bv8)))
{
    var len: int;
    var v: Vec (bv8);

    v := $Dereference(m);
    len := LenVec(v);
    if (!InRangeVec(v, i)) {
        call $ExecFailureAbort();
        return;
    }
    e := ReadVec(v, i);
    m' := $UpdateMutation(m, RemoveVec(SwapVec(v, i, len-1)));
}

procedure {:inline 1} $1_vector_contains'bv8'(v: Vec (bv8), e: bv8) returns (res: bool)  {
    res := $ContainsVec'bv8'(v, e);
}

procedure {:inline 1}
$1_vector_index_of'bv8'(v: Vec (bv8), e: bv8) returns (res1: bool, res2: int) {
    res2 := $IndexOfVec'bv8'(v, e);
    if (res2 >= 0) {
        res1 := true;
    } else {
        res1 := false;
        res2 := 0;
    }
}


// ==================================================================================
// Native Table

// ----------------------------------------------------------------------------------
// Native Table key encoding for type `u64`

function $EncodeKey'u64'(k: int): int;
axiom (
  forall k1, k2: int :: {$EncodeKey'u64'(k1), $EncodeKey'u64'(k2)}
    $IsEqual'u64'(k1, k2) <==> $EncodeKey'u64'(k1) == $EncodeKey'u64'(k2)
);


// ----------------------------------------------------------------------------------
// Native Table key encoding for type `address`

function $EncodeKey'address'(k: int): int;
axiom (
  forall k1, k2: int :: {$EncodeKey'address'(k1), $EncodeKey'address'(k2)}
    $IsEqual'address'(k1, k2) <==> $EncodeKey'address'(k1) == $EncodeKey'address'(k2)
);


// ----------------------------------------------------------------------------------
// Native Table implementation for type `(u64,bool)`

function $IsEqual'$1_table_Table'u64_bool''(t1: Table int (bool), t2: Table int (bool)): bool {
    LenTable(t1) == LenTable(t2) &&
    (forall k: int :: ContainsTable(t1, k) <==> ContainsTable(t2, k)) &&
    (forall k: int :: ContainsTable(t1, k) ==> GetTable(t1, k) == GetTable(t2, k)) &&
    (forall k: int :: ContainsTable(t2, k) ==> GetTable(t1, k) == GetTable(t2, k))
}

// Not inlined.
function $IsValid'$1_table_Table'u64_bool''(t: Table int (bool)): bool {
    $IsValid'u64'(LenTable(t)) &&
    (forall i: int:: ContainsTable(t, i) ==> $IsValid'bool'(GetTable(t, i)))
}
procedure {:inline 2} $1_table_new'u64_bool'() returns (v: Table int (bool)) {
    v := EmptyTable();
}
procedure {:inline 2} $1_table_destroy'u64_bool'(t: Table int (bool)) {
    if (LenTable(t) != 0) {
        call $Abort($StdError(1/*INVALID_STATE*/, 102/*ENOT_EMPTY*/));
    }
}
procedure {:inline 2} $1_table_contains'u64_bool'(t: (Table int (bool)), k: int) returns (r: bool) {
    r := ContainsTable(t, $EncodeKey'u64'(k));
}
procedure {:inline 2} $1_table_add'u64_bool'(m: $Mutation (Table int (bool)), k: int, v: bool) returns (m': $Mutation(Table int (bool))) {
    var enc_k: int;
    var t: Table int (bool);
    enc_k := $EncodeKey'u64'(k);
    t := $Dereference(m);
    if (ContainsTable(t, enc_k)) {
        call $Abort($StdError(7/*INVALID_ARGUMENTS*/, 100/*EALREADY_EXISTS*/));
    } else {
        m' := $UpdateMutation(m, AddTable(t, enc_k, v));
    }
}
procedure {:inline 2} $1_table_upsert'u64_bool'(m: $Mutation (Table int (bool)), k: int, v: bool) returns (m': $Mutation(Table int (bool))) {
    var enc_k: int;
    var t: Table int (bool);
    enc_k := $EncodeKey'u64'(k);
    t := $Dereference(m);
    if (ContainsTable(t, enc_k)) {
        m' := $UpdateMutation(m, UpdateTable(t, enc_k, v));
    } else {
        m' := $UpdateMutation(m, AddTable(t, enc_k, v));
    }
}
procedure {:inline 2} $1_table_remove'u64_bool'(m: $Mutation (Table int (bool)), k: int)
returns (v: bool, m': $Mutation(Table int (bool))) {
    var enc_k: int;
    var t: Table int (bool);
    enc_k := $EncodeKey'u64'(k);
    t := $Dereference(m);
    if (!ContainsTable(t, enc_k)) {
        call $Abort($StdError(7/*INVALID_ARGUMENTS*/, 101/*ENOT_FOUND*/));
    } else {
        v := GetTable(t, enc_k);
        m' := $UpdateMutation(m, RemoveTable(t, enc_k));
    }
}
procedure {:inline 2} $1_table_borrow'u64_bool'(t: Table int (bool), k: int) returns (v: bool) {
    var enc_k: int;
    enc_k := $EncodeKey'u64'(k);
    if (!ContainsTable(t, enc_k)) {
        call $Abort($StdError(7/*INVALID_ARGUMENTS*/, 101/*ENOT_FOUND*/));
    } else {
        v := GetTable(t, $EncodeKey'u64'(k));
    }
}
procedure {:inline 2} $1_table_borrow_mut'u64_bool'(m: $Mutation (Table int (bool)), k: int)
returns (dst: $Mutation (bool), m': $Mutation (Table int (bool))) {
    var enc_k: int;
    var t: Table int (bool);
    enc_k := $EncodeKey'u64'(k);
    t := $Dereference(m);
    if (!ContainsTable(t, enc_k)) {
        call $Abort($StdError(7/*INVALID_ARGUMENTS*/, 101/*ENOT_FOUND*/));
    } else {
        dst := $Mutation(m->l, ExtendVec(m->p, enc_k), GetTable(t, enc_k));
        m' := m;
    }
}
procedure {:inline 2} $1_table_borrow_mut_with_default'u64_bool'(m: $Mutation (Table int (bool)), k: int, default: bool)
returns (dst: $Mutation (bool), m': $Mutation (Table int (bool))) {
    var enc_k: int;
    var t: Table int (bool);
    var t': Table int (bool);
    enc_k := $EncodeKey'u64'(k);
    t := $Dereference(m);
    if (!ContainsTable(t, enc_k)) {
        m' := $UpdateMutation(m, AddTable(t, enc_k, default));
        t' := $Dereference(m');
        dst := $Mutation(m'->l, ExtendVec(m'->p, enc_k), GetTable(t', enc_k));
    } else {
        dst := $Mutation(m->l, ExtendVec(m->p, enc_k), GetTable(t, enc_k));
        m' := m;
    }
}
function {:inline} $1_table_spec_contains'u64_bool'(t: (Table int (bool)), k: int): bool {
    ContainsTable(t, $EncodeKey'u64'(k))
}
function {:inline} $1_table_spec_set'u64_bool'(t: Table int (bool), k: int, v: bool): Table int (bool) {
    (var enc_k := $EncodeKey'u64'(k);
    if (ContainsTable(t, enc_k)) then
        UpdateTable(t, enc_k, v)
    else
        AddTable(t, enc_k, v))
}
function {:inline} $1_table_spec_remove'u64_bool'(t: Table int (bool), k: int): Table int (bool) {
    RemoveTable(t, $EncodeKey'u64'(k))
}
function {:inline} $1_table_spec_get'u64_bool'(t: Table int (bool), k: int): bool {
    GetTable(t, $EncodeKey'u64'(k))
}



// ----------------------------------------------------------------------------------
// Native Table implementation for type `(u64,u64)`

function $IsEqual'$1_table_Table'u64_u64''(t1: Table int (int), t2: Table int (int)): bool {
    LenTable(t1) == LenTable(t2) &&
    (forall k: int :: ContainsTable(t1, k) <==> ContainsTable(t2, k)) &&
    (forall k: int :: ContainsTable(t1, k) ==> GetTable(t1, k) == GetTable(t2, k)) &&
    (forall k: int :: ContainsTable(t2, k) ==> GetTable(t1, k) == GetTable(t2, k))
}

// Not inlined.
function $IsValid'$1_table_Table'u64_u64''(t: Table int (int)): bool {
    $IsValid'u64'(LenTable(t)) &&
    (forall i: int:: ContainsTable(t, i) ==> $IsValid'u64'(GetTable(t, i)))
}
procedure {:inline 2} $1_table_new'u64_u64'() returns (v: Table int (int)) {
    v := EmptyTable();
}
procedure {:inline 2} $1_table_destroy'u64_u64'(t: Table int (int)) {
    if (LenTable(t) != 0) {
        call $Abort($StdError(1/*INVALID_STATE*/, 102/*ENOT_EMPTY*/));
    }
}
procedure {:inline 2} $1_table_contains'u64_u64'(t: (Table int (int)), k: int) returns (r: bool) {
    r := ContainsTable(t, $EncodeKey'u64'(k));
}
procedure {:inline 2} $1_table_add'u64_u64'(m: $Mutation (Table int (int)), k: int, v: int) returns (m': $Mutation(Table int (int))) {
    var enc_k: int;
    var t: Table int (int);
    enc_k := $EncodeKey'u64'(k);
    t := $Dereference(m);
    if (ContainsTable(t, enc_k)) {
        call $Abort($StdError(7/*INVALID_ARGUMENTS*/, 100/*EALREADY_EXISTS*/));
    } else {
        m' := $UpdateMutation(m, AddTable(t, enc_k, v));
    }
}
procedure {:inline 2} $1_table_upsert'u64_u64'(m: $Mutation (Table int (int)), k: int, v: int) returns (m': $Mutation(Table int (int))) {
    var enc_k: int;
    var t: Table int (int);
    enc_k := $EncodeKey'u64'(k);
    t := $Dereference(m);
    if (ContainsTable(t, enc_k)) {
        m' := $UpdateMutation(m, UpdateTable(t, enc_k, v));
    } else {
        m' := $UpdateMutation(m, AddTable(t, enc_k, v));
    }
}
procedure {:inline 2} $1_table_remove'u64_u64'(m: $Mutation (Table int (int)), k: int)
returns (v: int, m': $Mutation(Table int (int))) {
    var enc_k: int;
    var t: Table int (int);
    enc_k := $EncodeKey'u64'(k);
    t := $Dereference(m);
    if (!ContainsTable(t, enc_k)) {
        call $Abort($StdError(7/*INVALID_ARGUMENTS*/, 101/*ENOT_FOUND*/));
    } else {
        v := GetTable(t, enc_k);
        m' := $UpdateMutation(m, RemoveTable(t, enc_k));
    }
}
procedure {:inline 2} $1_table_borrow'u64_u64'(t: Table int (int), k: int) returns (v: int) {
    var enc_k: int;
    enc_k := $EncodeKey'u64'(k);
    if (!ContainsTable(t, enc_k)) {
        call $Abort($StdError(7/*INVALID_ARGUMENTS*/, 101/*ENOT_FOUND*/));
    } else {
        v := GetTable(t, $EncodeKey'u64'(k));
    }
}
procedure {:inline 2} $1_table_borrow_mut'u64_u64'(m: $Mutation (Table int (int)), k: int)
returns (dst: $Mutation (int), m': $Mutation (Table int (int))) {
    var enc_k: int;
    var t: Table int (int);
    enc_k := $EncodeKey'u64'(k);
    t := $Dereference(m);
    if (!ContainsTable(t, enc_k)) {
        call $Abort($StdError(7/*INVALID_ARGUMENTS*/, 101/*ENOT_FOUND*/));
    } else {
        dst := $Mutation(m->l, ExtendVec(m->p, enc_k), GetTable(t, enc_k));
        m' := m;
    }
}
procedure {:inline 2} $1_table_borrow_mut_with_default'u64_u64'(m: $Mutation (Table int (int)), k: int, default: int)
returns (dst: $Mutation (int), m': $Mutation (Table int (int))) {
    var enc_k: int;
    var t: Table int (int);
    var t': Table int (int);
    enc_k := $EncodeKey'u64'(k);
    t := $Dereference(m);
    if (!ContainsTable(t, enc_k)) {
        m' := $UpdateMutation(m, AddTable(t, enc_k, default));
        t' := $Dereference(m');
        dst := $Mutation(m'->l, ExtendVec(m'->p, enc_k), GetTable(t', enc_k));
    } else {
        dst := $Mutation(m->l, ExtendVec(m->p, enc_k), GetTable(t, enc_k));
        m' := m;
    }
}
function {:inline} $1_table_spec_contains'u64_u64'(t: (Table int (int)), k: int): bool {
    ContainsTable(t, $EncodeKey'u64'(k))
}
function {:inline} $1_table_spec_set'u64_u64'(t: Table int (int), k: int, v: int): Table int (int) {
    (var enc_k := $EncodeKey'u64'(k);
    if (ContainsTable(t, enc_k)) then
        UpdateTable(t, enc_k, v)
    else
        AddTable(t, enc_k, v))
}
function {:inline} $1_table_spec_remove'u64_u64'(t: Table int (int), k: int): Table int (int) {
    RemoveTable(t, $EncodeKey'u64'(k))
}
function {:inline} $1_table_spec_get'u64_u64'(t: Table int (int), k: int): int {
    GetTable(t, $EncodeKey'u64'(k))
}



// ----------------------------------------------------------------------------------
// Native Table implementation for type `(u64,vec'u64')`

function $IsEqual'$1_table_Table'u64_vec'u64'''(t1: Table int (Vec (int)), t2: Table int (Vec (int))): bool {
    LenTable(t1) == LenTable(t2) &&
    (forall k: int :: ContainsTable(t1, k) <==> ContainsTable(t2, k)) &&
    (forall k: int :: ContainsTable(t1, k) ==> GetTable(t1, k) == GetTable(t2, k)) &&
    (forall k: int :: ContainsTable(t2, k) ==> GetTable(t1, k) == GetTable(t2, k))
}

// Not inlined.
function $IsValid'$1_table_Table'u64_vec'u64'''(t: Table int (Vec (int))): bool {
    $IsValid'u64'(LenTable(t)) &&
    (forall i: int:: ContainsTable(t, i) ==> $IsValid'vec'u64''(GetTable(t, i)))
}
procedure {:inline 2} $1_table_new'u64_vec'u64''() returns (v: Table int (Vec (int))) {
    v := EmptyTable();
}
procedure {:inline 2} $1_table_destroy'u64_vec'u64''(t: Table int (Vec (int))) {
    if (LenTable(t) != 0) {
        call $Abort($StdError(1/*INVALID_STATE*/, 102/*ENOT_EMPTY*/));
    }
}
procedure {:inline 2} $1_table_contains'u64_vec'u64''(t: (Table int (Vec (int))), k: int) returns (r: bool) {
    r := ContainsTable(t, $EncodeKey'u64'(k));
}
procedure {:inline 2} $1_table_add'u64_vec'u64''(m: $Mutation (Table int (Vec (int))), k: int, v: Vec (int)) returns (m': $Mutation(Table int (Vec (int)))) {
    var enc_k: int;
    var t: Table int (Vec (int));
    enc_k := $EncodeKey'u64'(k);
    t := $Dereference(m);
    if (ContainsTable(t, enc_k)) {
        call $Abort($StdError(7/*INVALID_ARGUMENTS*/, 100/*EALREADY_EXISTS*/));
    } else {
        m' := $UpdateMutation(m, AddTable(t, enc_k, v));
    }
}
procedure {:inline 2} $1_table_upsert'u64_vec'u64''(m: $Mutation (Table int (Vec (int))), k: int, v: Vec (int)) returns (m': $Mutation(Table int (Vec (int)))) {
    var enc_k: int;
    var t: Table int (Vec (int));
    enc_k := $EncodeKey'u64'(k);
    t := $Dereference(m);
    if (ContainsTable(t, enc_k)) {
        m' := $UpdateMutation(m, UpdateTable(t, enc_k, v));
    } else {
        m' := $UpdateMutation(m, AddTable(t, enc_k, v));
    }
}
procedure {:inline 2} $1_table_remove'u64_vec'u64''(m: $Mutation (Table int (Vec (int))), k: int)
returns (v: Vec (int), m': $Mutation(Table int (Vec (int)))) {
    var enc_k: int;
    var t: Table int (Vec (int));
    enc_k := $EncodeKey'u64'(k);
    t := $Dereference(m);
    if (!ContainsTable(t, enc_k)) {
        call $Abort($StdError(7/*INVALID_ARGUMENTS*/, 101/*ENOT_FOUND*/));
    } else {
        v := GetTable(t, enc_k);
        m' := $UpdateMutation(m, RemoveTable(t, enc_k));
    }
}
procedure {:inline 2} $1_table_borrow'u64_vec'u64''(t: Table int (Vec (int)), k: int) returns (v: Vec (int)) {
    var enc_k: int;
    enc_k := $EncodeKey'u64'(k);
    if (!ContainsTable(t, enc_k)) {
        call $Abort($StdError(7/*INVALID_ARGUMENTS*/, 101/*ENOT_FOUND*/));
    } else {
        v := GetTable(t, $EncodeKey'u64'(k));
    }
}
procedure {:inline 2} $1_table_borrow_mut'u64_vec'u64''(m: $Mutation (Table int (Vec (int))), k: int)
returns (dst: $Mutation (Vec (int)), m': $Mutation (Table int (Vec (int)))) {
    var enc_k: int;
    var t: Table int (Vec (int));
    enc_k := $EncodeKey'u64'(k);
    t := $Dereference(m);
    if (!ContainsTable(t, enc_k)) {
        call $Abort($StdError(7/*INVALID_ARGUMENTS*/, 101/*ENOT_FOUND*/));
    } else {
        dst := $Mutation(m->l, ExtendVec(m->p, enc_k), GetTable(t, enc_k));
        m' := m;
    }
}
procedure {:inline 2} $1_table_borrow_mut_with_default'u64_vec'u64''(m: $Mutation (Table int (Vec (int))), k: int, default: Vec (int))
returns (dst: $Mutation (Vec (int)), m': $Mutation (Table int (Vec (int)))) {
    var enc_k: int;
    var t: Table int (Vec (int));
    var t': Table int (Vec (int));
    enc_k := $EncodeKey'u64'(k);
    t := $Dereference(m);
    if (!ContainsTable(t, enc_k)) {
        m' := $UpdateMutation(m, AddTable(t, enc_k, default));
        t' := $Dereference(m');
        dst := $Mutation(m'->l, ExtendVec(m'->p, enc_k), GetTable(t', enc_k));
    } else {
        dst := $Mutation(m->l, ExtendVec(m->p, enc_k), GetTable(t, enc_k));
        m' := m;
    }
}
function {:inline} $1_table_spec_contains'u64_vec'u64''(t: (Table int (Vec (int))), k: int): bool {
    ContainsTable(t, $EncodeKey'u64'(k))
}
function {:inline} $1_table_spec_set'u64_vec'u64''(t: Table int (Vec (int)), k: int, v: Vec (int)): Table int (Vec (int)) {
    (var enc_k := $EncodeKey'u64'(k);
    if (ContainsTable(t, enc_k)) then
        UpdateTable(t, enc_k, v)
    else
        AddTable(t, enc_k, v))
}
function {:inline} $1_table_spec_remove'u64_vec'u64''(t: Table int (Vec (int)), k: int): Table int (Vec (int)) {
    RemoveTable(t, $EncodeKey'u64'(k))
}
function {:inline} $1_table_spec_get'u64_vec'u64''(t: Table int (Vec (int)), k: int): Vec (int) {
    GetTable(t, $EncodeKey'u64'(k))
}



// ----------------------------------------------------------------------------------
// Native Table implementation for type `(address,address)`

function $IsEqual'$1_table_Table'address_address''(t1: Table int (int), t2: Table int (int)): bool {
    LenTable(t1) == LenTable(t2) &&
    (forall k: int :: ContainsTable(t1, k) <==> ContainsTable(t2, k)) &&
    (forall k: int :: ContainsTable(t1, k) ==> GetTable(t1, k) == GetTable(t2, k)) &&
    (forall k: int :: ContainsTable(t2, k) ==> GetTable(t1, k) == GetTable(t2, k))
}

// Not inlined.
function $IsValid'$1_table_Table'address_address''(t: Table int (int)): bool {
    $IsValid'u64'(LenTable(t)) &&
    (forall i: int:: ContainsTable(t, i) ==> $IsValid'address'(GetTable(t, i)))
}
procedure {:inline 2} $1_table_new'address_address'() returns (v: Table int (int)) {
    v := EmptyTable();
}
procedure {:inline 2} $1_table_destroy'address_address'(t: Table int (int)) {
    if (LenTable(t) != 0) {
        call $Abort($StdError(1/*INVALID_STATE*/, 102/*ENOT_EMPTY*/));
    }
}
procedure {:inline 2} $1_table_contains'address_address'(t: (Table int (int)), k: int) returns (r: bool) {
    r := ContainsTable(t, $EncodeKey'address'(k));
}
procedure {:inline 2} $1_table_add'address_address'(m: $Mutation (Table int (int)), k: int, v: int) returns (m': $Mutation(Table int (int))) {
    var enc_k: int;
    var t: Table int (int);
    enc_k := $EncodeKey'address'(k);
    t := $Dereference(m);
    if (ContainsTable(t, enc_k)) {
        call $Abort($StdError(7/*INVALID_ARGUMENTS*/, 100/*EALREADY_EXISTS*/));
    } else {
        m' := $UpdateMutation(m, AddTable(t, enc_k, v));
    }
}
procedure {:inline 2} $1_table_upsert'address_address'(m: $Mutation (Table int (int)), k: int, v: int) returns (m': $Mutation(Table int (int))) {
    var enc_k: int;
    var t: Table int (int);
    enc_k := $EncodeKey'address'(k);
    t := $Dereference(m);
    if (ContainsTable(t, enc_k)) {
        m' := $UpdateMutation(m, UpdateTable(t, enc_k, v));
    } else {
        m' := $UpdateMutation(m, AddTable(t, enc_k, v));
    }
}
procedure {:inline 2} $1_table_remove'address_address'(m: $Mutation (Table int (int)), k: int)
returns (v: int, m': $Mutation(Table int (int))) {
    var enc_k: int;
    var t: Table int (int);
    enc_k := $EncodeKey'address'(k);
    t := $Dereference(m);
    if (!ContainsTable(t, enc_k)) {
        call $Abort($StdError(7/*INVALID_ARGUMENTS*/, 101/*ENOT_FOUND*/));
    } else {
        v := GetTable(t, enc_k);
        m' := $UpdateMutation(m, RemoveTable(t, enc_k));
    }
}
procedure {:inline 2} $1_table_borrow'address_address'(t: Table int (int), k: int) returns (v: int) {
    var enc_k: int;
    enc_k := $EncodeKey'address'(k);
    if (!ContainsTable(t, enc_k)) {
        call $Abort($StdError(7/*INVALID_ARGUMENTS*/, 101/*ENOT_FOUND*/));
    } else {
        v := GetTable(t, $EncodeKey'address'(k));
    }
}
procedure {:inline 2} $1_table_borrow_mut'address_address'(m: $Mutation (Table int (int)), k: int)
returns (dst: $Mutation (int), m': $Mutation (Table int (int))) {
    var enc_k: int;
    var t: Table int (int);
    enc_k := $EncodeKey'address'(k);
    t := $Dereference(m);
    if (!ContainsTable(t, enc_k)) {
        call $Abort($StdError(7/*INVALID_ARGUMENTS*/, 101/*ENOT_FOUND*/));
    } else {
        dst := $Mutation(m->l, ExtendVec(m->p, enc_k), GetTable(t, enc_k));
        m' := m;
    }
}
procedure {:inline 2} $1_table_borrow_mut_with_default'address_address'(m: $Mutation (Table int (int)), k: int, default: int)
returns (dst: $Mutation (int), m': $Mutation (Table int (int))) {
    var enc_k: int;
    var t: Table int (int);
    var t': Table int (int);
    enc_k := $EncodeKey'address'(k);
    t := $Dereference(m);
    if (!ContainsTable(t, enc_k)) {
        m' := $UpdateMutation(m, AddTable(t, enc_k, default));
        t' := $Dereference(m');
        dst := $Mutation(m'->l, ExtendVec(m'->p, enc_k), GetTable(t', enc_k));
    } else {
        dst := $Mutation(m->l, ExtendVec(m->p, enc_k), GetTable(t, enc_k));
        m' := m;
    }
}
function {:inline} $1_table_spec_contains'address_address'(t: (Table int (int)), k: int): bool {
    ContainsTable(t, $EncodeKey'address'(k))
}
function {:inline} $1_table_spec_set'address_address'(t: Table int (int), k: int, v: int): Table int (int) {
    (var enc_k := $EncodeKey'address'(k);
    if (ContainsTable(t, enc_k)) then
        UpdateTable(t, enc_k, v)
    else
        AddTable(t, enc_k, v))
}
function {:inline} $1_table_spec_remove'address_address'(t: Table int (int), k: int): Table int (int) {
    RemoveTable(t, $EncodeKey'address'(k))
}
function {:inline} $1_table_spec_get'address_address'(t: Table int (int), k: int): int {
    GetTable(t, $EncodeKey'address'(k))
}



// ==================================================================================
// Native Hash

// Hash is modeled as an otherwise uninterpreted injection.
// In truth, it is not an injection since the domain has greater cardinality
// (arbitrary length vectors) than the co-domain (vectors of length 32).  But it is
// common to assume in code there are no hash collisions in practice.  Fortunately,
// Boogie is not smart enough to recognized that there is an inconsistency.
// FIXME: If we were using a reliable extensional theory of arrays, and if we could use ==
// instead of $IsEqual, we might be able to avoid so many quantified formulas by
// using a sha2_inverse function in the ensures conditions of Hash_sha2_256 to
// assert that sha2/3 are injections without using global quantified axioms.


function $1_hash_sha2(val: Vec int): Vec int;

// This says that Hash_sha2 is bijective.
axiom (forall v1,v2: Vec int :: {$1_hash_sha2(v1), $1_hash_sha2(v2)}
       $IsEqual'vec'u8''(v1, v2) <==> $IsEqual'vec'u8''($1_hash_sha2(v1), $1_hash_sha2(v2)));

procedure $1_hash_sha2_256(val: Vec int) returns (res: Vec int);
ensures res == $1_hash_sha2(val);     // returns Hash_sha2 Value
ensures $IsValid'vec'u8''(res);    // result is a legal vector of U8s.
ensures LenVec(res) == 32;               // result is 32 bytes.

// Spec version of Move native function.
function {:inline} $1_hash_$sha2_256(val: Vec int): Vec int {
    $1_hash_sha2(val)
}

// similarly for Hash_sha3
function $1_hash_sha3(val: Vec int): Vec int;

axiom (forall v1,v2: Vec int :: {$1_hash_sha3(v1), $1_hash_sha3(v2)}
       $IsEqual'vec'u8''(v1, v2) <==> $IsEqual'vec'u8''($1_hash_sha3(v1), $1_hash_sha3(v2)));

procedure $1_hash_sha3_256(val: Vec int) returns (res: Vec int);
ensures res == $1_hash_sha3(val);     // returns Hash_sha3 Value
ensures $IsValid'vec'u8''(res);    // result is a legal vector of U8s.
ensures LenVec(res) == 32;               // result is 32 bytes.

// Spec version of Move native function.
function {:inline} $1_hash_$sha3_256(val: Vec int): Vec int {
    $1_hash_sha3(val)
}

// ==================================================================================
// Native string

// TODO: correct implementation of strings

procedure {:inline 1} $1_string_internal_check_utf8(x: Vec int) returns (r: bool) {
}

procedure {:inline 1} $1_string_internal_sub_string(x: Vec int, i: int, j: int) returns (r: Vec int) {
}

procedure {:inline 1} $1_string_internal_index_of(x: Vec int, y: Vec int) returns (r: int) {
}

procedure {:inline 1} $1_string_internal_is_char_boundary(x: Vec int, i: int) returns (r: bool) {
}




// ==================================================================================
// Native diem_account

procedure {:inline 1} $1_DiemAccount_create_signer(
  addr: int
) returns (signer: $signer) {
    // A signer is currently identical to an address.
    signer := $signer(addr);
}

procedure {:inline 1} $1_DiemAccount_destroy_signer(
  signer: $signer
) {
  return;
}

// ==================================================================================
// Native account

procedure {:inline 1} $1_Account_create_signer(
  addr: int
) returns (signer: $signer) {
    // A signer is currently identical to an address.
    signer := $signer(addr);
}

// ==================================================================================
// Native Signer

datatype $signer {
    $signer($addr: int)
}
function {:inline} $IsValid'signer'(s: $signer): bool {
    $IsValid'address'(s->$addr)
}
function {:inline} $IsEqual'signer'(s1: $signer, s2: $signer): bool {
    s1 == s2
}

procedure {:inline 1} $1_signer_borrow_address(signer: $signer) returns (res: int) {
    res := signer->$addr;
}

function {:inline} $1_signer_$borrow_address(signer: $signer): int
{
    signer->$addr
}

function $1_signer_is_txn_signer(s: $signer): bool;

function $1_signer_is_txn_signer_addr(a: int): bool;


// ==================================================================================
// Native signature

// Signature related functionality is handled via uninterpreted functions. This is sound
// currently because we verify every code path based on signature verification with
// an arbitrary interpretation.

function $1_Signature_$ed25519_validate_pubkey(public_key: Vec int): bool;
function $1_Signature_$ed25519_verify(signature: Vec int, public_key: Vec int, message: Vec int): bool;

// Needed because we do not have extensional equality:
axiom (forall k1, k2: Vec int ::
    {$1_Signature_$ed25519_validate_pubkey(k1), $1_Signature_$ed25519_validate_pubkey(k2)}
    $IsEqual'vec'u8''(k1, k2) ==> $1_Signature_$ed25519_validate_pubkey(k1) == $1_Signature_$ed25519_validate_pubkey(k2));
axiom (forall s1, s2, k1, k2, m1, m2: Vec int ::
    {$1_Signature_$ed25519_verify(s1, k1, m1), $1_Signature_$ed25519_verify(s2, k2, m2)}
    $IsEqual'vec'u8''(s1, s2) && $IsEqual'vec'u8''(k1, k2) && $IsEqual'vec'u8''(m1, m2)
    ==> $1_Signature_$ed25519_verify(s1, k1, m1) == $1_Signature_$ed25519_verify(s2, k2, m2));


procedure {:inline 1} $1_Signature_ed25519_validate_pubkey(public_key: Vec int) returns (res: bool) {
    res := $1_Signature_$ed25519_validate_pubkey(public_key);
}

procedure {:inline 1} $1_Signature_ed25519_verify(
        signature: Vec int, public_key: Vec int, message: Vec int) returns (res: bool) {
    res := $1_Signature_$ed25519_verify(signature, public_key, message);
}


// ==================================================================================
// Native bcs::serialize

// ----------------------------------------------------------------------------------
// Native BCS implementation for element type `address`

// Serialize is modeled as an uninterpreted function, with an additional
// axiom to say it's an injection.

function $1_bcs_serialize'address'(v: int): Vec int;

axiom (forall v1, v2: int :: {$1_bcs_serialize'address'(v1), $1_bcs_serialize'address'(v2)}
   $IsEqual'address'(v1, v2) <==> $IsEqual'vec'u8''($1_bcs_serialize'address'(v1), $1_bcs_serialize'address'(v2)));

// This says that serialize returns a non-empty vec<u8>

axiom (forall v: int :: {$1_bcs_serialize'address'(v)}
     ( var r := $1_bcs_serialize'address'(v); $IsValid'vec'u8''(r) && LenVec(r) > 0 ));


procedure $1_bcs_to_bytes'address'(v: int) returns (res: Vec int);
ensures res == $1_bcs_serialize'address'(v);

function {:inline} $1_bcs_$to_bytes'address'(v: int): Vec int {
    $1_bcs_serialize'address'(v)
}

// Serialized addresses should have the same length.
const $serialized_address_len: int;
// Serialized addresses should have the same length
axiom (forall v: int :: {$1_bcs_serialize'address'(v)}
     ( var r := $1_bcs_serialize'address'(v); LenVec(r) == $serialized_address_len));




// ==================================================================================
// Native Event module



procedure {:inline 1} $InitEventStore() {
}

// ============================================================================================
// Type Reflection on Type Parameters

datatype $TypeParamInfo {
    $TypeParamBool(),
    $TypeParamU8(),
    $TypeParamU16(),
    $TypeParamU32(),
    $TypeParamU64(),
    $TypeParamU128(),
    $TypeParamU256(),
    $TypeParamAddress(),
    $TypeParamSigner(),
    $TypeParamVector(e: $TypeParamInfo),
    $TypeParamStruct(a: int, m: Vec int, s: Vec int)
}



//==================================
// Begin Translation

function $TypeName(t: $TypeParamInfo): Vec int;
axiom (forall t: $TypeParamInfo :: {$TypeName(t)} t is $TypeParamBool ==> $IsEqual'vec'u8''($TypeName(t), Vec(DefaultVecMap()[0 := 98][1 := 111][2 := 111][3 := 108], 4)));
axiom (forall t: $TypeParamInfo :: {$TypeName(t)} $IsEqual'vec'u8''($TypeName(t), Vec(DefaultVecMap()[0 := 98][1 := 111][2 := 111][3 := 108], 4)) ==> t is $TypeParamBool);
axiom (forall t: $TypeParamInfo :: {$TypeName(t)} t is $TypeParamU8 ==> $IsEqual'vec'u8''($TypeName(t), Vec(DefaultVecMap()[0 := 117][1 := 56], 2)));
axiom (forall t: $TypeParamInfo :: {$TypeName(t)} $IsEqual'vec'u8''($TypeName(t), Vec(DefaultVecMap()[0 := 117][1 := 56], 2)) ==> t is $TypeParamU8);
axiom (forall t: $TypeParamInfo :: {$TypeName(t)} t is $TypeParamU16 ==> $IsEqual'vec'u8''($TypeName(t), Vec(DefaultVecMap()[0 := 117][1 := 49][2 := 54], 3)));
axiom (forall t: $TypeParamInfo :: {$TypeName(t)} $IsEqual'vec'u8''($TypeName(t), Vec(DefaultVecMap()[0 := 117][1 := 49][2 := 54], 3)) ==> t is $TypeParamU16);
axiom (forall t: $TypeParamInfo :: {$TypeName(t)} t is $TypeParamU32 ==> $IsEqual'vec'u8''($TypeName(t), Vec(DefaultVecMap()[0 := 117][1 := 51][2 := 50], 3)));
axiom (forall t: $TypeParamInfo :: {$TypeName(t)} $IsEqual'vec'u8''($TypeName(t), Vec(DefaultVecMap()[0 := 117][1 := 51][2 := 50], 3)) ==> t is $TypeParamU32);
axiom (forall t: $TypeParamInfo :: {$TypeName(t)} t is $TypeParamU64 ==> $IsEqual'vec'u8''($TypeName(t), Vec(DefaultVecMap()[0 := 117][1 := 54][2 := 52], 3)));
axiom (forall t: $TypeParamInfo :: {$TypeName(t)} $IsEqual'vec'u8''($TypeName(t), Vec(DefaultVecMap()[0 := 117][1 := 54][2 := 52], 3)) ==> t is $TypeParamU64);
axiom (forall t: $TypeParamInfo :: {$TypeName(t)} t is $TypeParamU128 ==> $IsEqual'vec'u8''($TypeName(t), Vec(DefaultVecMap()[0 := 117][1 := 49][2 := 50][3 := 56], 4)));
axiom (forall t: $TypeParamInfo :: {$TypeName(t)} $IsEqual'vec'u8''($TypeName(t), Vec(DefaultVecMap()[0 := 117][1 := 49][2 := 50][3 := 56], 4)) ==> t is $TypeParamU128);
axiom (forall t: $TypeParamInfo :: {$TypeName(t)} t is $TypeParamU256 ==> $IsEqual'vec'u8''($TypeName(t), Vec(DefaultVecMap()[0 := 117][1 := 50][2 := 53][3 := 54], 4)));
axiom (forall t: $TypeParamInfo :: {$TypeName(t)} $IsEqual'vec'u8''($TypeName(t), Vec(DefaultVecMap()[0 := 117][1 := 50][2 := 53][3 := 54], 4)) ==> t is $TypeParamU256);
axiom (forall t: $TypeParamInfo :: {$TypeName(t)} t is $TypeParamAddress ==> $IsEqual'vec'u8''($TypeName(t), Vec(DefaultVecMap()[0 := 97][1 := 100][2 := 100][3 := 114][4 := 101][5 := 115][6 := 115], 7)));
axiom (forall t: $TypeParamInfo :: {$TypeName(t)} $IsEqual'vec'u8''($TypeName(t), Vec(DefaultVecMap()[0 := 97][1 := 100][2 := 100][3 := 114][4 := 101][5 := 115][6 := 115], 7)) ==> t is $TypeParamAddress);
axiom (forall t: $TypeParamInfo :: {$TypeName(t)} t is $TypeParamSigner ==> $IsEqual'vec'u8''($TypeName(t), Vec(DefaultVecMap()[0 := 115][1 := 105][2 := 103][3 := 110][4 := 101][5 := 114], 6)));
axiom (forall t: $TypeParamInfo :: {$TypeName(t)} $IsEqual'vec'u8''($TypeName(t), Vec(DefaultVecMap()[0 := 115][1 := 105][2 := 103][3 := 110][4 := 101][5 := 114], 6)) ==> t is $TypeParamSigner);
axiom (forall t: $TypeParamInfo :: {$TypeName(t)} t is $TypeParamVector ==> $IsEqual'vec'u8''($TypeName(t), ConcatVec(ConcatVec(Vec(DefaultVecMap()[0 := 118][1 := 101][2 := 99][3 := 116][4 := 111][5 := 114][6 := 60], 7), $TypeName(t->e)), Vec(DefaultVecMap()[0 := 62], 1))));
axiom (forall t: $TypeParamInfo :: {$TypeName(t)} ($IsPrefix'vec'u8''($TypeName(t), Vec(DefaultVecMap()[0 := 118][1 := 101][2 := 99][3 := 116][4 := 111][5 := 114][6 := 60], 7)) && $IsSuffix'vec'u8''($TypeName(t), Vec(DefaultVecMap()[0 := 62], 1))) ==> t is $TypeParamVector);
axiom (forall t: $TypeParamInfo :: {$TypeName(t)} t is $TypeParamStruct ==> $IsEqual'vec'u8''($TypeName(t), ConcatVec(ConcatVec(ConcatVec(ConcatVec(ConcatVec(Vec(DefaultVecMap()[0 := 48][1 := 120], 2), MakeVec1(t->a)), Vec(DefaultVecMap()[0 := 58][1 := 58], 2)), t->m), Vec(DefaultVecMap()[0 := 58][1 := 58], 2)), t->s)));
axiom (forall t: $TypeParamInfo :: {$TypeName(t)} $IsPrefix'vec'u8''($TypeName(t), Vec(DefaultVecMap()[0 := 48][1 := 120], 2)) ==> t is $TypeParamVector);


// Given Types for Type Parameters

type #0;
function {:inline} $IsEqual'#0'(x1: #0, x2: #0): bool { x1 == x2 }
function {:inline} $IsValid'#0'(x: #0): bool { true }
var #0_info: $TypeParamInfo;
var #0_$memory: $Memory #0;

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <bool>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'bool'(b1), $1_from_bcs_deserializable'bool'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <u8>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'u8'(b1), $1_from_bcs_deserializable'u8'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <u64>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'u64'(b1), $1_from_bcs_deserializable'u64'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <u128>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'u128'(b1), $1_from_bcs_deserializable'u128'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <u256>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'u256'(b1), $1_from_bcs_deserializable'u256'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <address>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'address'(b1), $1_from_bcs_deserializable'address'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <signer>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'signer'(b1), $1_from_bcs_deserializable'signer'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <vector<u8>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'vec'u8''(b1), $1_from_bcs_deserializable'vec'u8''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <vector<u64>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'vec'u64''(b1), $1_from_bcs_deserializable'vec'u64''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <vector<address>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'vec'address''(b1), $1_from_bcs_deserializable'vec'address''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <vector<aggregator::Aggregator>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'vec'$1_aggregator_Aggregator''(b1), $1_from_bcs_deserializable'vec'$1_aggregator_Aggregator''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <vector<optional_aggregator::Integer>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'vec'$1_optional_aggregator_Integer''(b1), $1_from_bcs_deserializable'vec'$1_optional_aggregator_Integer''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <vector<optional_aggregator::OptionalAggregator>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'vec'$1_optional_aggregator_OptionalAggregator''(b1), $1_from_bcs_deserializable'vec'$1_optional_aggregator_OptionalAggregator''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <vector<#0>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'vec'#0''(b1), $1_from_bcs_deserializable'vec'#0''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <table::Table<u64, bool>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_table_Table'u64_bool''(b1), $1_from_bcs_deserializable'$1_table_Table'u64_bool''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <table::Table<u64, u64>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_table_Table'u64_u64''(b1), $1_from_bcs_deserializable'$1_table_Table'u64_u64''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <table::Table<u64, vector<u64>>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_table_Table'u64_vec'u64'''(b1), $1_from_bcs_deserializable'$1_table_Table'u64_vec'u64'''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <table::Table<address, address>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_table_Table'address_address''(b1), $1_from_bcs_deserializable'$1_table_Table'address_address''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <option::Option<address>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_option_Option'address''(b1), $1_from_bcs_deserializable'$1_option_Option'address''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <option::Option<aggregator::Aggregator>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_option_Option'$1_aggregator_Aggregator''(b1), $1_from_bcs_deserializable'$1_option_Option'$1_aggregator_Aggregator''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <option::Option<optional_aggregator::Integer>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_option_Option'$1_optional_aggregator_Integer''(b1), $1_from_bcs_deserializable'$1_option_Option'$1_optional_aggregator_Integer''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <option::Option<optional_aggregator::OptionalAggregator>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_option_Option'$1_optional_aggregator_OptionalAggregator''(b1), $1_from_bcs_deserializable'$1_option_Option'$1_optional_aggregator_OptionalAggregator''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <string::String>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_string_String'(b1), $1_from_bcs_deserializable'$1_string_String'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <type_info::TypeInfo>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_type_info_TypeInfo'(b1), $1_from_bcs_deserializable'$1_type_info_TypeInfo'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <aggregator::Aggregator>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_aggregator_Aggregator'(b1), $1_from_bcs_deserializable'$1_aggregator_Aggregator'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <optional_aggregator::Integer>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_optional_aggregator_Integer'(b1), $1_from_bcs_deserializable'$1_optional_aggregator_Integer'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <optional_aggregator::OptionalAggregator>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_optional_aggregator_OptionalAggregator'(b1), $1_from_bcs_deserializable'$1_optional_aggregator_OptionalAggregator'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <guid::GUID>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_guid_GUID'(b1), $1_from_bcs_deserializable'$1_guid_GUID'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <guid::ID>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_guid_ID'(b1), $1_from_bcs_deserializable'$1_guid_ID'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <event::EventHandle<account::CoinRegisterEvent>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_event_EventHandle'$1_account_CoinRegisterEvent''(b1), $1_from_bcs_deserializable'$1_event_EventHandle'$1_account_CoinRegisterEvent''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <event::EventHandle<account::KeyRotationEvent>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_event_EventHandle'$1_account_KeyRotationEvent''(b1), $1_from_bcs_deserializable'$1_event_EventHandle'$1_account_KeyRotationEvent''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <event::EventHandle<coin::DepositEvent>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_event_EventHandle'$1_coin_DepositEvent''(b1), $1_from_bcs_deserializable'$1_event_EventHandle'$1_coin_DepositEvent''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <event::EventHandle<coin::WithdrawEvent>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_event_EventHandle'$1_coin_WithdrawEvent''(b1), $1_from_bcs_deserializable'$1_event_EventHandle'$1_coin_WithdrawEvent''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <account::Account>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_account_Account'(b1), $1_from_bcs_deserializable'$1_account_Account'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <account::CapabilityOffer<account::RotationCapability>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_account_CapabilityOffer'$1_account_RotationCapability''(b1), $1_from_bcs_deserializable'$1_account_CapabilityOffer'$1_account_RotationCapability''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <account::CapabilityOffer<account::SignerCapability>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_account_CapabilityOffer'$1_account_SignerCapability''(b1), $1_from_bcs_deserializable'$1_account_CapabilityOffer'$1_account_SignerCapability''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <account::CoinRegisterEvent>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_account_CoinRegisterEvent'(b1), $1_from_bcs_deserializable'$1_account_CoinRegisterEvent'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <account::SignerCapability>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_account_SignerCapability'(b1), $1_from_bcs_deserializable'$1_account_SignerCapability'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <coin::Coin<aptos_coin::AptosCoin>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_coin_Coin'$1_aptos_coin_AptosCoin''(b1), $1_from_bcs_deserializable'$1_coin_Coin'$1_aptos_coin_AptosCoin''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <coin::Coin<#0>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_coin_Coin'#0''(b1), $1_from_bcs_deserializable'$1_coin_Coin'#0''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <coin::CoinInfo<aptos_coin::AptosCoin>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''(b1), $1_from_bcs_deserializable'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <coin::CoinInfo<#0>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_coin_CoinInfo'#0''(b1), $1_from_bcs_deserializable'$1_coin_CoinInfo'#0''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <coin::CoinStore<aptos_coin::AptosCoin>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''(b1), $1_from_bcs_deserializable'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <coin::CoinStore<#0>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_coin_CoinStore'#0''(b1), $1_from_bcs_deserializable'$1_coin_CoinStore'#0''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <coin::DepositEvent>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_coin_DepositEvent'(b1), $1_from_bcs_deserializable'$1_coin_DepositEvent'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <coin::WithdrawEvent>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_coin_WithdrawEvent'(b1), $1_from_bcs_deserializable'$1_coin_WithdrawEvent'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <coin::Ghost$supply<aptos_coin::AptosCoin>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''(b1), $1_from_bcs_deserializable'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <coin::Ghost$supply<#0>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_coin_Ghost$supply'#0''(b1), $1_from_bcs_deserializable'$1_coin_Ghost$supply'#0''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <coin::Ghost$aggregate_supply<aptos_coin::AptosCoin>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''(b1), $1_from_bcs_deserializable'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <coin::Ghost$aggregate_supply<#0>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_coin_Ghost$aggregate_supply'#0''(b1), $1_from_bcs_deserializable'$1_coin_Ghost$aggregate_supply'#0''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <aptos_coin::AptosCoin>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_aptos_coin_AptosCoin'(b1), $1_from_bcs_deserializable'$1_aptos_coin_AptosCoin'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <Bbay::Owner>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_Bbay_Owner'(b1), $1_from_bcs_deserializable'$1_Bbay_Owner'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <Bbay::Products>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_Bbay_Products'(b1), $1_from_bcs_deserializable'$1_Bbay_Products'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <Bbay::ResourceAccountSignerCap>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_Bbay_ResourceAccountSignerCap'(b1), $1_from_bcs_deserializable'$1_Bbay_ResourceAccountSignerCap'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <Bbay::User>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'$1_Bbay_User'(b1), $1_from_bcs_deserializable'$1_Bbay_User'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:18:9+124, instance <#0>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserializable'#0'(b1), $1_from_bcs_deserializable'#0'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <bool>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'bool'($1_from_bcs_deserialize'bool'(b1), $1_from_bcs_deserialize'bool'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <u8>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'u8'($1_from_bcs_deserialize'u8'(b1), $1_from_bcs_deserialize'u8'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <u64>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'u64'($1_from_bcs_deserialize'u64'(b1), $1_from_bcs_deserialize'u64'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <u128>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'u128'($1_from_bcs_deserialize'u128'(b1), $1_from_bcs_deserialize'u128'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <u256>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'u256'($1_from_bcs_deserialize'u256'(b1), $1_from_bcs_deserialize'u256'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <address>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'address'($1_from_bcs_deserialize'address'(b1), $1_from_bcs_deserialize'address'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <signer>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'signer'($1_from_bcs_deserialize'signer'(b1), $1_from_bcs_deserialize'signer'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <vector<u8>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'vec'u8''($1_from_bcs_deserialize'vec'u8''(b1), $1_from_bcs_deserialize'vec'u8''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <vector<u64>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'vec'u64''($1_from_bcs_deserialize'vec'u64''(b1), $1_from_bcs_deserialize'vec'u64''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <vector<address>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'vec'address''($1_from_bcs_deserialize'vec'address''(b1), $1_from_bcs_deserialize'vec'address''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <vector<aggregator::Aggregator>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'vec'$1_aggregator_Aggregator''($1_from_bcs_deserialize'vec'$1_aggregator_Aggregator''(b1), $1_from_bcs_deserialize'vec'$1_aggregator_Aggregator''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <vector<optional_aggregator::Integer>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'vec'$1_optional_aggregator_Integer''($1_from_bcs_deserialize'vec'$1_optional_aggregator_Integer''(b1), $1_from_bcs_deserialize'vec'$1_optional_aggregator_Integer''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <vector<optional_aggregator::OptionalAggregator>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'vec'$1_optional_aggregator_OptionalAggregator''($1_from_bcs_deserialize'vec'$1_optional_aggregator_OptionalAggregator''(b1), $1_from_bcs_deserialize'vec'$1_optional_aggregator_OptionalAggregator''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <vector<#0>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'vec'#0''($1_from_bcs_deserialize'vec'#0''(b1), $1_from_bcs_deserialize'vec'#0''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <table::Table<u64, bool>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_table_Table'u64_bool''($1_from_bcs_deserialize'$1_table_Table'u64_bool''(b1), $1_from_bcs_deserialize'$1_table_Table'u64_bool''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <table::Table<u64, u64>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_table_Table'u64_u64''($1_from_bcs_deserialize'$1_table_Table'u64_u64''(b1), $1_from_bcs_deserialize'$1_table_Table'u64_u64''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <table::Table<u64, vector<u64>>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_table_Table'u64_vec'u64'''($1_from_bcs_deserialize'$1_table_Table'u64_vec'u64'''(b1), $1_from_bcs_deserialize'$1_table_Table'u64_vec'u64'''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <table::Table<address, address>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_table_Table'address_address''($1_from_bcs_deserialize'$1_table_Table'address_address''(b1), $1_from_bcs_deserialize'$1_table_Table'address_address''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <option::Option<address>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_option_Option'address''($1_from_bcs_deserialize'$1_option_Option'address''(b1), $1_from_bcs_deserialize'$1_option_Option'address''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <option::Option<aggregator::Aggregator>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_option_Option'$1_aggregator_Aggregator''($1_from_bcs_deserialize'$1_option_Option'$1_aggregator_Aggregator''(b1), $1_from_bcs_deserialize'$1_option_Option'$1_aggregator_Aggregator''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <option::Option<optional_aggregator::Integer>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_option_Option'$1_optional_aggregator_Integer''($1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_Integer''(b1), $1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_Integer''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <option::Option<optional_aggregator::OptionalAggregator>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_option_Option'$1_optional_aggregator_OptionalAggregator''($1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_OptionalAggregator''(b1), $1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_OptionalAggregator''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <string::String>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_string_String'($1_from_bcs_deserialize'$1_string_String'(b1), $1_from_bcs_deserialize'$1_string_String'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <type_info::TypeInfo>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_type_info_TypeInfo'($1_from_bcs_deserialize'$1_type_info_TypeInfo'(b1), $1_from_bcs_deserialize'$1_type_info_TypeInfo'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <aggregator::Aggregator>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_aggregator_Aggregator'($1_from_bcs_deserialize'$1_aggregator_Aggregator'(b1), $1_from_bcs_deserialize'$1_aggregator_Aggregator'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <optional_aggregator::Integer>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_optional_aggregator_Integer'($1_from_bcs_deserialize'$1_optional_aggregator_Integer'(b1), $1_from_bcs_deserialize'$1_optional_aggregator_Integer'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <optional_aggregator::OptionalAggregator>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_optional_aggregator_OptionalAggregator'($1_from_bcs_deserialize'$1_optional_aggregator_OptionalAggregator'(b1), $1_from_bcs_deserialize'$1_optional_aggregator_OptionalAggregator'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <guid::GUID>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_guid_GUID'($1_from_bcs_deserialize'$1_guid_GUID'(b1), $1_from_bcs_deserialize'$1_guid_GUID'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <guid::ID>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_guid_ID'($1_from_bcs_deserialize'$1_guid_ID'(b1), $1_from_bcs_deserialize'$1_guid_ID'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <event::EventHandle<account::CoinRegisterEvent>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_event_EventHandle'$1_account_CoinRegisterEvent''($1_from_bcs_deserialize'$1_event_EventHandle'$1_account_CoinRegisterEvent''(b1), $1_from_bcs_deserialize'$1_event_EventHandle'$1_account_CoinRegisterEvent''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <event::EventHandle<account::KeyRotationEvent>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_event_EventHandle'$1_account_KeyRotationEvent''($1_from_bcs_deserialize'$1_event_EventHandle'$1_account_KeyRotationEvent''(b1), $1_from_bcs_deserialize'$1_event_EventHandle'$1_account_KeyRotationEvent''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <event::EventHandle<coin::DepositEvent>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_event_EventHandle'$1_coin_DepositEvent''($1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_DepositEvent''(b1), $1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_DepositEvent''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <event::EventHandle<coin::WithdrawEvent>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_event_EventHandle'$1_coin_WithdrawEvent''($1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_WithdrawEvent''(b1), $1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_WithdrawEvent''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <account::Account>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_account_Account'($1_from_bcs_deserialize'$1_account_Account'(b1), $1_from_bcs_deserialize'$1_account_Account'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <account::CapabilityOffer<account::RotationCapability>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_account_CapabilityOffer'$1_account_RotationCapability''($1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_RotationCapability''(b1), $1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_RotationCapability''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <account::CapabilityOffer<account::SignerCapability>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_account_CapabilityOffer'$1_account_SignerCapability''($1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_SignerCapability''(b1), $1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_SignerCapability''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <account::CoinRegisterEvent>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_account_CoinRegisterEvent'($1_from_bcs_deserialize'$1_account_CoinRegisterEvent'(b1), $1_from_bcs_deserialize'$1_account_CoinRegisterEvent'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <account::SignerCapability>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_account_SignerCapability'($1_from_bcs_deserialize'$1_account_SignerCapability'(b1), $1_from_bcs_deserialize'$1_account_SignerCapability'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <coin::Coin<aptos_coin::AptosCoin>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_coin_Coin'$1_aptos_coin_AptosCoin''($1_from_bcs_deserialize'$1_coin_Coin'$1_aptos_coin_AptosCoin''(b1), $1_from_bcs_deserialize'$1_coin_Coin'$1_aptos_coin_AptosCoin''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <coin::Coin<#0>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_coin_Coin'#0''($1_from_bcs_deserialize'$1_coin_Coin'#0''(b1), $1_from_bcs_deserialize'$1_coin_Coin'#0''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <coin::CoinInfo<aptos_coin::AptosCoin>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''($1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''(b1), $1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <coin::CoinInfo<#0>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_coin_CoinInfo'#0''($1_from_bcs_deserialize'$1_coin_CoinInfo'#0''(b1), $1_from_bcs_deserialize'$1_coin_CoinInfo'#0''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <coin::CoinStore<aptos_coin::AptosCoin>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''($1_from_bcs_deserialize'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''(b1), $1_from_bcs_deserialize'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <coin::CoinStore<#0>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_coin_CoinStore'#0''($1_from_bcs_deserialize'$1_coin_CoinStore'#0''(b1), $1_from_bcs_deserialize'$1_coin_CoinStore'#0''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <coin::DepositEvent>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_coin_DepositEvent'($1_from_bcs_deserialize'$1_coin_DepositEvent'(b1), $1_from_bcs_deserialize'$1_coin_DepositEvent'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <coin::WithdrawEvent>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_coin_WithdrawEvent'($1_from_bcs_deserialize'$1_coin_WithdrawEvent'(b1), $1_from_bcs_deserialize'$1_coin_WithdrawEvent'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <coin::Ghost$supply<aptos_coin::AptosCoin>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''($1_from_bcs_deserialize'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''(b1), $1_from_bcs_deserialize'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <coin::Ghost$supply<#0>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_coin_Ghost$supply'#0''($1_from_bcs_deserialize'$1_coin_Ghost$supply'#0''(b1), $1_from_bcs_deserialize'$1_coin_Ghost$supply'#0''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <coin::Ghost$aggregate_supply<aptos_coin::AptosCoin>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''($1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''(b1), $1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <coin::Ghost$aggregate_supply<#0>>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_coin_Ghost$aggregate_supply'#0''($1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'#0''(b1), $1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'#0''(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <aptos_coin::AptosCoin>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_aptos_coin_AptosCoin'($1_from_bcs_deserialize'$1_aptos_coin_AptosCoin'(b1), $1_from_bcs_deserialize'$1_aptos_coin_AptosCoin'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <Bbay::Owner>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_Bbay_Owner'($1_from_bcs_deserialize'$1_Bbay_Owner'(b1), $1_from_bcs_deserialize'$1_Bbay_Owner'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <Bbay::Products>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_Bbay_Products'($1_from_bcs_deserialize'$1_Bbay_Products'(b1), $1_from_bcs_deserialize'$1_Bbay_Products'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <Bbay::ResourceAccountSignerCap>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_Bbay_ResourceAccountSignerCap'($1_from_bcs_deserialize'$1_Bbay_ResourceAccountSignerCap'(b1), $1_from_bcs_deserialize'$1_Bbay_ResourceAccountSignerCap'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <Bbay::User>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'$1_Bbay_User'($1_from_bcs_deserialize'$1_Bbay_User'(b1), $1_from_bcs_deserialize'$1_Bbay_User'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:21:9+118, instance <#0>
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''(b1, b2) ==> $IsEqual'#0'($1_from_bcs_deserialize'#0'(b1), $1_from_bcs_deserialize'#0'(b2)))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/hash.spec.move:8:9+113
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''($1_aptos_hash_spec_keccak256(b1), $1_aptos_hash_spec_keccak256(b2)) ==> $IsEqual'vec'u8''(b1, b2))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/hash.spec.move:13:9+129
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''($1_aptos_hash_spec_sha2_512_internal(b1), $1_aptos_hash_spec_sha2_512_internal(b2)) ==> $IsEqual'vec'u8''(b1, b2))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/hash.spec.move:18:9+129
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''($1_aptos_hash_spec_sha3_512_internal(b1), $1_aptos_hash_spec_sha3_512_internal(b2)) ==> $IsEqual'vec'u8''(b1, b2))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/hash.spec.move:23:9+131
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''($1_aptos_hash_spec_ripemd160_internal(b1), $1_aptos_hash_spec_ripemd160_internal(b2)) ==> $IsEqual'vec'u8''(b1, b2))));

// axiom at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/hash.spec.move:28:9+135
axiom (forall b1: Vec (int), b2: Vec (int) :: $IsValid'vec'u8''(b1) ==> $IsValid'vec'u8''(b2) ==> (($IsEqual'vec'u8''($1_aptos_hash_spec_blake2b_256_internal(b1), $1_aptos_hash_spec_blake2b_256_internal(b2)) ==> $IsEqual'vec'u8''(b1, b2))));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/vector.move:146:5+86
function {:inline} $1_vector_$is_empty'address'(v: Vec (int)): bool {
    $IsEqual'u64'($1_vector_$length'address'(v), 0)
}

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/vector.move:146:5+86
function {:inline} $1_vector_$is_empty'$1_aggregator_Aggregator'(v: Vec ($1_aggregator_Aggregator)): bool {
    $IsEqual'u64'($1_vector_$length'$1_aggregator_Aggregator'(v), 0)
}

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/vector.move:146:5+86
function {:inline} $1_vector_$is_empty'$1_optional_aggregator_Integer'(v: Vec ($1_optional_aggregator_Integer)): bool {
    $IsEqual'u64'($1_vector_$length'$1_optional_aggregator_Integer'(v), 0)
}

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/signer.move:12:5+77
function {:inline} $1_signer_$address_of(s: $signer): int {
    $1_signer_$borrow_address(s)
}

// fun signer::address_of [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/signer.move:12:5+77
procedure {:inline 1} $1_signer_address_of(_$t0: $signer) returns ($ret0: int)
{
    // declare local variables
    var $t1: int;
    var $t2: int;
    var $t0: $signer;
    var $temp_0'address': int;
    var $temp_0'signer': $signer;
    $t0 := _$t0;

    // bytecode translation starts here
    // trace_local[s]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/signer.move:12:5+1
    assume {:print "$at(13,395,396)"} true;
    assume {:print "$track_local(2,0,0):", $t0} $t0 == $t0;

    // $t1 := signer::borrow_address($t0) on_abort goto L2 with $t2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/signer.move:13:10+17
    assume {:print "$at(13,449,466)"} true;
    call $t1 := $1_signer_borrow_address($t0);
    if ($abort_flag) {
        assume {:print "$at(13,449,466)"} true;
        $t2 := $abort_code;
        assume {:print "$track_abort(2,0):", $t2} $t2 == $t2;
        goto L2;
    }

    // trace_return[0]($t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/signer.move:13:9+18
    assume {:print "$track_return(2,0,0):", $t1} $t1 == $t1;

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/signer.move:14:5+1
    assume {:print "$at(13,471,472)"} true;
L1:

    // return $t1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/signer.move:14:5+1
    assume {:print "$at(13,471,472)"} true;
    $ret0 := $t1;
    return;

    // label L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/signer.move:14:5+1
L2:

    // abort($t2) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/signer.move:14:5+1
    assume {:print "$at(13,471,472)"} true;
    $abort_code := $t2;
    $abort_flag := true;
    return;

}

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/option.move:102:5+145
function {:inline} $1_option_$borrow'$1_aggregator_Aggregator'(t: $1_option_Option'$1_aggregator_Aggregator'): $1_aggregator_Aggregator {
    $1_vector_$borrow'$1_aggregator_Aggregator'(t->$vec, 0)
}

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/option.move:102:5+145
function {:inline} $1_option_$borrow'$1_optional_aggregator_Integer'(t: $1_option_Option'$1_optional_aggregator_Integer'): $1_optional_aggregator_Integer {
    $1_vector_$borrow'$1_optional_aggregator_Integer'(t->$vec, 0)
}

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/option.move:61:5+95
function {:inline} $1_option_$is_none'$1_aggregator_Aggregator'(t: $1_option_Option'$1_aggregator_Aggregator'): bool {
    $1_vector_$is_empty'$1_aggregator_Aggregator'(t->$vec)
}

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/option.move:61:5+95
function {:inline} $1_option_$is_none'$1_optional_aggregator_Integer'(t: $1_option_Option'$1_optional_aggregator_Integer'): bool {
    $1_vector_$is_empty'$1_optional_aggregator_Integer'(t->$vec)
}

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/option.move:74:5+96
function {:inline} $1_option_$is_some'$1_aggregator_Aggregator'(t: $1_option_Option'$1_aggregator_Aggregator'): bool {
    !$1_vector_$is_empty'$1_aggregator_Aggregator'(t->$vec)
}

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/option.move:74:5+96
function {:inline} $1_option_$is_some'$1_optional_aggregator_Integer'(t: $1_option_Option'$1_optional_aggregator_Integer'): bool {
    !$1_vector_$is_empty'$1_optional_aggregator_Integer'(t->$vec)
}

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/option.move:34:10+78
function {:inline} $1_option_spec_none'address'(): $1_option_Option'address' {
    $1_option_Option'address'($EmptyVec'address'())
}

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/option.move:47:10+89
function {:inline} $1_option_spec_some'address'(e: int): $1_option_Option'address' {
    $1_option_Option'address'(MakeVec1(e))
}

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/option.move:69:10+91
function {:inline} $1_option_spec_is_none'address'(t: $1_option_Option'address'): bool {
    $1_vector_$is_empty'address'(t->$vec)
}

// struct option::Option<address> at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/option.move:7:5+81
datatype $1_option_Option'address' {
    $1_option_Option'address'($vec: Vec (int))
}
function {:inline} $Update'$1_option_Option'address''_vec(s: $1_option_Option'address', x: Vec (int)): $1_option_Option'address' {
    $1_option_Option'address'(x)
}
function $IsValid'$1_option_Option'address''(s: $1_option_Option'address'): bool {
    $IsValid'vec'address''(s->$vec)
}
function {:inline} $IsEqual'$1_option_Option'address''(s1: $1_option_Option'address', s2: $1_option_Option'address'): bool {
    $IsEqual'vec'address''(s1->$vec, s2->$vec)}

// struct option::Option<aggregator::Aggregator> at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/option.move:7:5+81
datatype $1_option_Option'$1_aggregator_Aggregator' {
    $1_option_Option'$1_aggregator_Aggregator'($vec: Vec ($1_aggregator_Aggregator))
}
function {:inline} $Update'$1_option_Option'$1_aggregator_Aggregator''_vec(s: $1_option_Option'$1_aggregator_Aggregator', x: Vec ($1_aggregator_Aggregator)): $1_option_Option'$1_aggregator_Aggregator' {
    $1_option_Option'$1_aggregator_Aggregator'(x)
}
function $IsValid'$1_option_Option'$1_aggregator_Aggregator''(s: $1_option_Option'$1_aggregator_Aggregator'): bool {
    $IsValid'vec'$1_aggregator_Aggregator''(s->$vec)
}
function {:inline} $IsEqual'$1_option_Option'$1_aggregator_Aggregator''(s1: $1_option_Option'$1_aggregator_Aggregator', s2: $1_option_Option'$1_aggregator_Aggregator'): bool {
    $IsEqual'vec'$1_aggregator_Aggregator''(s1->$vec, s2->$vec)}

// struct option::Option<optional_aggregator::Integer> at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/option.move:7:5+81
datatype $1_option_Option'$1_optional_aggregator_Integer' {
    $1_option_Option'$1_optional_aggregator_Integer'($vec: Vec ($1_optional_aggregator_Integer))
}
function {:inline} $Update'$1_option_Option'$1_optional_aggregator_Integer''_vec(s: $1_option_Option'$1_optional_aggregator_Integer', x: Vec ($1_optional_aggregator_Integer)): $1_option_Option'$1_optional_aggregator_Integer' {
    $1_option_Option'$1_optional_aggregator_Integer'(x)
}
function $IsValid'$1_option_Option'$1_optional_aggregator_Integer''(s: $1_option_Option'$1_optional_aggregator_Integer'): bool {
    $IsValid'vec'$1_optional_aggregator_Integer''(s->$vec)
}
function {:inline} $IsEqual'$1_option_Option'$1_optional_aggregator_Integer''(s1: $1_option_Option'$1_optional_aggregator_Integer', s2: $1_option_Option'$1_optional_aggregator_Integer'): bool {
    $IsEqual'vec'$1_optional_aggregator_Integer''(s1->$vec, s2->$vec)}

// struct option::Option<optional_aggregator::OptionalAggregator> at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/option.move:7:5+81
datatype $1_option_Option'$1_optional_aggregator_OptionalAggregator' {
    $1_option_Option'$1_optional_aggregator_OptionalAggregator'($vec: Vec ($1_optional_aggregator_OptionalAggregator))
}
function {:inline} $Update'$1_option_Option'$1_optional_aggregator_OptionalAggregator''_vec(s: $1_option_Option'$1_optional_aggregator_OptionalAggregator', x: Vec ($1_optional_aggregator_OptionalAggregator)): $1_option_Option'$1_optional_aggregator_OptionalAggregator' {
    $1_option_Option'$1_optional_aggregator_OptionalAggregator'(x)
}
function $IsValid'$1_option_Option'$1_optional_aggregator_OptionalAggregator''(s: $1_option_Option'$1_optional_aggregator_OptionalAggregator'): bool {
    $IsValid'vec'$1_optional_aggregator_OptionalAggregator''(s->$vec)
}
function {:inline} $IsEqual'$1_option_Option'$1_optional_aggregator_OptionalAggregator''(s1: $1_option_Option'$1_optional_aggregator_OptionalAggregator', s2: $1_option_Option'$1_optional_aggregator_OptionalAggregator'): bool {
    $IsEqual'vec'$1_optional_aggregator_OptionalAggregator''(s1->$vec, s2->$vec)}

// struct string::String at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/string.move:13:5+70
datatype $1_string_String {
    $1_string_String($bytes: Vec (int))
}
function {:inline} $Update'$1_string_String'_bytes(s: $1_string_String, x: Vec (int)): $1_string_String {
    $1_string_String(x)
}
function $IsValid'$1_string_String'(s: $1_string_String): bool {
    $IsValid'vec'u8''(s->$bytes)
}
function {:inline} $IsEqual'$1_string_String'(s1: $1_string_String, s2: $1_string_String): bool {
    $IsEqual'vec'u8''(s1->$bytes, s2->$bytes)}

// fun error::already_exists [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:83:3+71
procedure {:inline 1} $1_error_already_exists(_$t0: int) returns ($ret0: int)
{
    // declare local variables
    var $t1: int;
    var $t2: int;
    var $t3: int;
    var $t0: int;
    var $temp_0'u64': int;
    $t0 := _$t0;

    // bytecode translation starts here
    // trace_local[r]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:83:3+1
    assume {:print "$at(9,3585,3586)"} true;
    assume {:print "$track_local(5,1,0):", $t0} $t0 == $t0;

    // $t1 := 8 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:83:54+14
    $t1 := 8;
    assume $IsValid'u64'($t1);

    // assume Identical($t2, Shl($t1, 16)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:69:5+29
    assume {:print "$at(9,2844,2873)"} true;
    assume ($t2 == $shlU64($t1, 16));

    // $t3 := opaque begin: error::canonical($t1, $t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:83:44+28
    assume {:print "$at(9,3626,3654)"} true;

    // assume WellFormed($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:83:44+28
    assume $IsValid'u64'($t3);

    // assume Eq<u64>($t3, $t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:83:44+28
    assume $IsEqual'u64'($t3, $t1);

    // $t3 := opaque end: error::canonical($t1, $t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:83:44+28

    // trace_return[0]($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:83:44+28
    assume {:print "$track_return(5,1,0):", $t3} $t3 == $t3;

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:83:73+1
L1:

    // return $t3 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:83:73+1
    assume {:print "$at(9,3655,3656)"} true;
    $ret0 := $t3;
    return;

}

// fun error::invalid_argument [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:76:3+76
procedure {:inline 1} $1_error_invalid_argument(_$t0: int) returns ($ret0: int)
{
    // declare local variables
    var $t1: int;
    var $t2: int;
    var $t3: int;
    var $t0: int;
    var $temp_0'u64': int;
    $t0 := _$t0;

    // bytecode translation starts here
    // trace_local[r]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:76:3+1
    assume {:print "$at(9,3082,3083)"} true;
    assume {:print "$track_local(5,4,0):", $t0} $t0 == $t0;

    // $t1 := 1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:76:57+16
    $t1 := 1;
    assume $IsValid'u64'($t1);

    // assume Identical($t2, Shl($t1, 16)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:69:5+29
    assume {:print "$at(9,2844,2873)"} true;
    assume ($t2 == $shlU64($t1, 16));

    // $t3 := opaque begin: error::canonical($t1, $t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:76:47+30
    assume {:print "$at(9,3126,3156)"} true;

    // assume WellFormed($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:76:47+30
    assume $IsValid'u64'($t3);

    // assume Eq<u64>($t3, $t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:76:47+30
    assume $IsEqual'u64'($t3, $t1);

    // $t3 := opaque end: error::canonical($t1, $t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:76:47+30

    // trace_return[0]($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:76:47+30
    assume {:print "$track_return(5,4,0):", $t3} $t3 == $t3;

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:76:78+1
L1:

    // return $t3 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:76:78+1
    assume {:print "$at(9,3157,3158)"} true;
    $ret0 := $t3;
    return;

}

// fun error::invalid_state [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:78:3+70
procedure {:inline 1} $1_error_invalid_state(_$t0: int) returns ($ret0: int)
{
    // declare local variables
    var $t1: int;
    var $t2: int;
    var $t3: int;
    var $t0: int;
    var $temp_0'u64': int;
    $t0 := _$t0;

    // bytecode translation starts here
    // trace_local[r]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:78:3+1
    assume {:print "$at(9,3232,3233)"} true;
    assume {:print "$track_local(5,5,0):", $t0} $t0 == $t0;

    // $t1 := 3 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:78:54+13
    $t1 := 3;
    assume $IsValid'u64'($t1);

    // assume Identical($t2, Shl($t1, 16)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:69:5+29
    assume {:print "$at(9,2844,2873)"} true;
    assume ($t2 == $shlU64($t1, 16));

    // $t3 := opaque begin: error::canonical($t1, $t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:78:44+27
    assume {:print "$at(9,3273,3300)"} true;

    // assume WellFormed($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:78:44+27
    assume $IsValid'u64'($t3);

    // assume Eq<u64>($t3, $t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:78:44+27
    assume $IsEqual'u64'($t3, $t1);

    // $t3 := opaque end: error::canonical($t1, $t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:78:44+27

    // trace_return[0]($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:78:44+27
    assume {:print "$track_return(5,5,0):", $t3} $t3 == $t3;

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:78:72+1
L1:

    // return $t3 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:78:72+1
    assume {:print "$at(9,3301,3302)"} true;
    $ret0 := $t3;
    return;

}

// fun error::not_found [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:81:3+61
procedure {:inline 1} $1_error_not_found(_$t0: int) returns ($ret0: int)
{
    // declare local variables
    var $t1: int;
    var $t2: int;
    var $t3: int;
    var $t0: int;
    var $temp_0'u64': int;
    $t0 := _$t0;

    // bytecode translation starts here
    // trace_local[r]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:81:3+1
    assume {:print "$at(9,3461,3462)"} true;
    assume {:print "$track_local(5,6,0):", $t0} $t0 == $t0;

    // $t1 := 6 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:81:49+9
    $t1 := 6;
    assume $IsValid'u64'($t1);

    // assume Identical($t2, Shl($t1, 16)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:69:5+29
    assume {:print "$at(9,2844,2873)"} true;
    assume ($t2 == $shlU64($t1, 16));

    // $t3 := opaque begin: error::canonical($t1, $t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:81:39+23
    assume {:print "$at(9,3497,3520)"} true;

    // assume WellFormed($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:81:39+23
    assume $IsValid'u64'($t3);

    // assume Eq<u64>($t3, $t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:81:39+23
    assume $IsEqual'u64'($t3, $t1);

    // $t3 := opaque end: error::canonical($t1, $t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:81:39+23

    // trace_return[0]($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:81:39+23
    assume {:print "$track_return(5,6,0):", $t3} $t3 == $t3;

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:81:63+1
L1:

    // return $t3 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:81:63+1
    assume {:print "$at(9,3521,3522)"} true;
    $ret0 := $t3;
    return;

}

// fun error::out_of_range [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:77:3+68
procedure {:inline 1} $1_error_out_of_range(_$t0: int) returns ($ret0: int)
{
    // declare local variables
    var $t1: int;
    var $t2: int;
    var $t3: int;
    var $t0: int;
    var $temp_0'u64': int;
    $t0 := _$t0;

    // bytecode translation starts here
    // trace_local[r]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:77:3+1
    assume {:print "$at(9,3161,3162)"} true;
    assume {:print "$track_local(5,8,0):", $t0} $t0 == $t0;

    // $t1 := 2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:77:53+12
    $t1 := 2;
    assume $IsValid'u64'($t1);

    // assume Identical($t2, Shl($t1, 16)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:69:5+29
    assume {:print "$at(9,2844,2873)"} true;
    assume ($t2 == $shlU64($t1, 16));

    // $t3 := opaque begin: error::canonical($t1, $t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:77:43+26
    assume {:print "$at(9,3201,3227)"} true;

    // assume WellFormed($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:77:43+26
    assume $IsValid'u64'($t3);

    // assume Eq<u64>($t3, $t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:77:43+26
    assume $IsEqual'u64'($t3, $t1);

    // $t3 := opaque end: error::canonical($t1, $t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:77:43+26

    // trace_return[0]($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:77:43+26
    assume {:print "$track_return(5,8,0):", $t3} $t3 == $t3;

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:77:70+1
L1:

    // return $t3 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:77:70+1
    assume {:print "$at(9,3228,3229)"} true;
    $ret0 := $t3;
    return;

}

// fun error::permission_denied [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:80:3+77
procedure {:inline 1} $1_error_permission_denied(_$t0: int) returns ($ret0: int)
{
    // declare local variables
    var $t1: int;
    var $t2: int;
    var $t3: int;
    var $t0: int;
    var $temp_0'u64': int;
    $t0 := _$t0;

    // bytecode translation starts here
    // trace_local[r]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:80:3+1
    assume {:print "$at(9,3381,3382)"} true;
    assume {:print "$track_local(5,9,0):", $t0} $t0 == $t0;

    // $t1 := 5 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:80:57+17
    $t1 := 5;
    assume $IsValid'u64'($t1);

    // assume Identical($t2, Shl($t1, 16)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:69:5+29
    assume {:print "$at(9,2844,2873)"} true;
    assume ($t2 == $shlU64($t1, 16));

    // $t3 := opaque begin: error::canonical($t1, $t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:80:47+31
    assume {:print "$at(9,3425,3456)"} true;

    // assume WellFormed($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:80:47+31
    assume $IsValid'u64'($t3);

    // assume Eq<u64>($t3, $t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:80:47+31
    assume $IsEqual'u64'($t3, $t1);

    // $t3 := opaque end: error::canonical($t1, $t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:80:47+31

    // trace_return[0]($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:80:47+31
    assume {:print "$track_return(5,9,0):", $t3} $t3 == $t3;

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:80:79+1
L1:

    // return $t3 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/../move-stdlib/sources/error.move:80:79+1
    assume {:print "$at(9,3457,3458)"} true;
    $ret0 := $t3;
    return;

}

// struct type_info::TypeInfo at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/type_info.move:17:5+145
datatype $1_type_info_TypeInfo {
    $1_type_info_TypeInfo($account_address: int, $module_name: Vec (int), $struct_name: Vec (int))
}
function {:inline} $Update'$1_type_info_TypeInfo'_account_address(s: $1_type_info_TypeInfo, x: int): $1_type_info_TypeInfo {
    $1_type_info_TypeInfo(x, s->$module_name, s->$struct_name)
}
function {:inline} $Update'$1_type_info_TypeInfo'_module_name(s: $1_type_info_TypeInfo, x: Vec (int)): $1_type_info_TypeInfo {
    $1_type_info_TypeInfo(s->$account_address, x, s->$struct_name)
}
function {:inline} $Update'$1_type_info_TypeInfo'_struct_name(s: $1_type_info_TypeInfo, x: Vec (int)): $1_type_info_TypeInfo {
    $1_type_info_TypeInfo(s->$account_address, s->$module_name, x)
}
function $IsValid'$1_type_info_TypeInfo'(s: $1_type_info_TypeInfo): bool {
    $IsValid'address'(s->$account_address)
      && $IsValid'vec'u8''(s->$module_name)
      && $IsValid'vec'u8''(s->$struct_name)
}
function {:inline} $IsEqual'$1_type_info_TypeInfo'(s1: $1_type_info_TypeInfo, s2: $1_type_info_TypeInfo): bool {
    $IsEqual'address'(s1->$account_address, s2->$account_address)
    && $IsEqual'vec'u8''(s1->$module_name, s2->$module_name)
    && $IsEqual'vec'u8''(s1->$struct_name, s2->$struct_name)}

// struct optional_aggregator::Integer at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/aggregator/optional_aggregator.move:20:5+74
datatype $1_optional_aggregator_Integer {
    $1_optional_aggregator_Integer($value: int, $limit: int)
}
function {:inline} $Update'$1_optional_aggregator_Integer'_value(s: $1_optional_aggregator_Integer, x: int): $1_optional_aggregator_Integer {
    $1_optional_aggregator_Integer(x, s->$limit)
}
function {:inline} $Update'$1_optional_aggregator_Integer'_limit(s: $1_optional_aggregator_Integer, x: int): $1_optional_aggregator_Integer {
    $1_optional_aggregator_Integer(s->$value, x)
}
function $IsValid'$1_optional_aggregator_Integer'(s: $1_optional_aggregator_Integer): bool {
    $IsValid'u128'(s->$value)
      && $IsValid'u128'(s->$limit)
}
function {:inline} $IsEqual'$1_optional_aggregator_Integer'(s1: $1_optional_aggregator_Integer, s2: $1_optional_aggregator_Integer): bool {
    s1 == s2
}

// struct optional_aggregator::OptionalAggregator at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/aggregator/optional_aggregator.move:64:5+175
datatype $1_optional_aggregator_OptionalAggregator {
    $1_optional_aggregator_OptionalAggregator($aggregator: $1_option_Option'$1_aggregator_Aggregator', $integer: $1_option_Option'$1_optional_aggregator_Integer')
}
function {:inline} $Update'$1_optional_aggregator_OptionalAggregator'_aggregator(s: $1_optional_aggregator_OptionalAggregator, x: $1_option_Option'$1_aggregator_Aggregator'): $1_optional_aggregator_OptionalAggregator {
    $1_optional_aggregator_OptionalAggregator(x, s->$integer)
}
function {:inline} $Update'$1_optional_aggregator_OptionalAggregator'_integer(s: $1_optional_aggregator_OptionalAggregator, x: $1_option_Option'$1_optional_aggregator_Integer'): $1_optional_aggregator_OptionalAggregator {
    $1_optional_aggregator_OptionalAggregator(s->$aggregator, x)
}
function $IsValid'$1_optional_aggregator_OptionalAggregator'(s: $1_optional_aggregator_OptionalAggregator): bool {
    $IsValid'$1_option_Option'$1_aggregator_Aggregator''(s->$aggregator)
      && $IsValid'$1_option_Option'$1_optional_aggregator_Integer''(s->$integer)
}
function {:inline} $IsEqual'$1_optional_aggregator_OptionalAggregator'(s1: $1_optional_aggregator_OptionalAggregator, s2: $1_optional_aggregator_OptionalAggregator): bool {
    $IsEqual'$1_option_Option'$1_aggregator_Aggregator''(s1->$aggregator, s2->$aggregator)
    && $IsEqual'$1_option_Option'$1_optional_aggregator_Integer''(s1->$integer, s2->$integer)}

// struct guid::GUID at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/guid.move:7:5+50
datatype $1_guid_GUID {
    $1_guid_GUID($id: $1_guid_ID)
}
function {:inline} $Update'$1_guid_GUID'_id(s: $1_guid_GUID, x: $1_guid_ID): $1_guid_GUID {
    $1_guid_GUID(x)
}
function $IsValid'$1_guid_GUID'(s: $1_guid_GUID): bool {
    $IsValid'$1_guid_ID'(s->$id)
}
function {:inline} $IsEqual'$1_guid_GUID'(s1: $1_guid_GUID, s2: $1_guid_GUID): bool {
    s1 == s2
}

// struct guid::ID at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/guid.move:12:5+209
datatype $1_guid_ID {
    $1_guid_ID($creation_num: int, $addr: int)
}
function {:inline} $Update'$1_guid_ID'_creation_num(s: $1_guid_ID, x: int): $1_guid_ID {
    $1_guid_ID(x, s->$addr)
}
function {:inline} $Update'$1_guid_ID'_addr(s: $1_guid_ID, x: int): $1_guid_ID {
    $1_guid_ID(s->$creation_num, x)
}
function $IsValid'$1_guid_ID'(s: $1_guid_ID): bool {
    $IsValid'u64'(s->$creation_num)
      && $IsValid'address'(s->$addr)
}
function {:inline} $IsEqual'$1_guid_ID'(s1: $1_guid_ID, s2: $1_guid_ID): bool {
    s1 == s2
}

// fun guid::create [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/guid.move:23:5+286
procedure {:inline 1} $1_guid_create(_$t0: int, _$t1: $Mutation (int)) returns ($ret0: $1_guid_GUID, $ret1: $Mutation (int))
{
    // declare local variables
    var $t2: int;
    var $t3: int;
    var $t4: int;
    var $t5: int;
    var $t6: int;
    var $t7: $1_guid_ID;
    var $t8: $1_guid_GUID;
    var $t0: int;
    var $t1: $Mutation (int);
    var $temp_0'$1_guid_GUID': $1_guid_GUID;
    var $temp_0'address': int;
    var $temp_0'u64': int;
    $t0 := _$t0;
    $t1 := _$t1;

    // bytecode translation starts here
    // trace_local[addr]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/guid.move:23:5+1
    assume {:print "$at(129,836,837)"} true;
    assume {:print "$track_local(13,0,0):", $t0} $t0 == $t0;

    // trace_local[creation_num_ref]($t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/guid.move:23:5+1
    $temp_0'u64' := $Dereference($t1);
    assume {:print "$track_local(13,0,1):", $temp_0'u64'} $temp_0'u64' == $temp_0'u64';

    // $t3 := read_ref($t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/guid.move:24:28+17
    assume {:print "$at(129,940,957)"} true;
    $t3 := $Dereference($t1);

    // trace_local[creation_num]($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/guid.move:24:13+12
    assume {:print "$track_local(13,0,2):", $t3} $t3 == $t3;

    // $t4 := 1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/guid.move:25:44+1
    assume {:print "$at(129,1002,1003)"} true;
    $t4 := 1;
    assume $IsValid'u64'($t4);

    // $t5 := +($t3, $t4) on_abort goto L2 with $t6 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/guid.move:25:42+1
    call $t5 := $AddU64($t3, $t4);
    if ($abort_flag) {
        assume {:print "$at(129,1000,1001)"} true;
        $t6 := $abort_code;
        assume {:print "$track_abort(13,0):", $t6} $t6 == $t6;
        goto L2;
    }

    // write_ref($t1, $t5) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/guid.move:25:9+36
    $t1 := $UpdateMutation($t1, $t5);

    // $t7 := pack guid::ID($t3, $t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/guid.move:27:17+70
    assume {:print "$at(129,1036,1106)"} true;
    $t7 := $1_guid_ID($t3, $t0);

    // $t8 := pack guid::GUID($t7) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/guid.move:26:9+103
    assume {:print "$at(129,1013,1116)"} true;
    $t8 := $1_guid_GUID($t7);

    // trace_return[0]($t8) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/guid.move:26:9+103
    assume {:print "$track_return(13,0,0):", $t8} $t8 == $t8;

    // trace_local[creation_num_ref]($t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/guid.move:26:9+103
    $temp_0'u64' := $Dereference($t1);
    assume {:print "$track_local(13,0,1):", $temp_0'u64'} $temp_0'u64' == $temp_0'u64';

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/guid.move:32:5+1
    assume {:print "$at(129,1121,1122)"} true;
L1:

    // return $t8 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/guid.move:32:5+1
    assume {:print "$at(129,1121,1122)"} true;
    $ret0 := $t8;
    $ret1 := $t1;
    return;

    // label L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/guid.move:32:5+1
L2:

    // abort($t6) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/guid.move:32:5+1
    assume {:print "$at(129,1121,1122)"} true;
    $abort_code := $t6;
    $abort_flag := true;
    return;

}

// struct event::EventHandle<account::CoinRegisterEvent> at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:34:5+224
datatype $1_event_EventHandle'$1_account_CoinRegisterEvent' {
    $1_event_EventHandle'$1_account_CoinRegisterEvent'($counter: int, $guid: $1_guid_GUID)
}
function {:inline} $Update'$1_event_EventHandle'$1_account_CoinRegisterEvent''_counter(s: $1_event_EventHandle'$1_account_CoinRegisterEvent', x: int): $1_event_EventHandle'$1_account_CoinRegisterEvent' {
    $1_event_EventHandle'$1_account_CoinRegisterEvent'(x, s->$guid)
}
function {:inline} $Update'$1_event_EventHandle'$1_account_CoinRegisterEvent''_guid(s: $1_event_EventHandle'$1_account_CoinRegisterEvent', x: $1_guid_GUID): $1_event_EventHandle'$1_account_CoinRegisterEvent' {
    $1_event_EventHandle'$1_account_CoinRegisterEvent'(s->$counter, x)
}
function $IsValid'$1_event_EventHandle'$1_account_CoinRegisterEvent''(s: $1_event_EventHandle'$1_account_CoinRegisterEvent'): bool {
    $IsValid'u64'(s->$counter)
      && $IsValid'$1_guid_GUID'(s->$guid)
}
function {:inline} $IsEqual'$1_event_EventHandle'$1_account_CoinRegisterEvent''(s1: $1_event_EventHandle'$1_account_CoinRegisterEvent', s2: $1_event_EventHandle'$1_account_CoinRegisterEvent'): bool {
    s1 == s2
}

// struct event::EventHandle<account::KeyRotationEvent> at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:34:5+224
datatype $1_event_EventHandle'$1_account_KeyRotationEvent' {
    $1_event_EventHandle'$1_account_KeyRotationEvent'($counter: int, $guid: $1_guid_GUID)
}
function {:inline} $Update'$1_event_EventHandle'$1_account_KeyRotationEvent''_counter(s: $1_event_EventHandle'$1_account_KeyRotationEvent', x: int): $1_event_EventHandle'$1_account_KeyRotationEvent' {
    $1_event_EventHandle'$1_account_KeyRotationEvent'(x, s->$guid)
}
function {:inline} $Update'$1_event_EventHandle'$1_account_KeyRotationEvent''_guid(s: $1_event_EventHandle'$1_account_KeyRotationEvent', x: $1_guid_GUID): $1_event_EventHandle'$1_account_KeyRotationEvent' {
    $1_event_EventHandle'$1_account_KeyRotationEvent'(s->$counter, x)
}
function $IsValid'$1_event_EventHandle'$1_account_KeyRotationEvent''(s: $1_event_EventHandle'$1_account_KeyRotationEvent'): bool {
    $IsValid'u64'(s->$counter)
      && $IsValid'$1_guid_GUID'(s->$guid)
}
function {:inline} $IsEqual'$1_event_EventHandle'$1_account_KeyRotationEvent''(s1: $1_event_EventHandle'$1_account_KeyRotationEvent', s2: $1_event_EventHandle'$1_account_KeyRotationEvent'): bool {
    s1 == s2
}

// struct event::EventHandle<coin::DepositEvent> at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:34:5+224
datatype $1_event_EventHandle'$1_coin_DepositEvent' {
    $1_event_EventHandle'$1_coin_DepositEvent'($counter: int, $guid: $1_guid_GUID)
}
function {:inline} $Update'$1_event_EventHandle'$1_coin_DepositEvent''_counter(s: $1_event_EventHandle'$1_coin_DepositEvent', x: int): $1_event_EventHandle'$1_coin_DepositEvent' {
    $1_event_EventHandle'$1_coin_DepositEvent'(x, s->$guid)
}
function {:inline} $Update'$1_event_EventHandle'$1_coin_DepositEvent''_guid(s: $1_event_EventHandle'$1_coin_DepositEvent', x: $1_guid_GUID): $1_event_EventHandle'$1_coin_DepositEvent' {
    $1_event_EventHandle'$1_coin_DepositEvent'(s->$counter, x)
}
function $IsValid'$1_event_EventHandle'$1_coin_DepositEvent''(s: $1_event_EventHandle'$1_coin_DepositEvent'): bool {
    $IsValid'u64'(s->$counter)
      && $IsValid'$1_guid_GUID'(s->$guid)
}
function {:inline} $IsEqual'$1_event_EventHandle'$1_coin_DepositEvent''(s1: $1_event_EventHandle'$1_coin_DepositEvent', s2: $1_event_EventHandle'$1_coin_DepositEvent'): bool {
    s1 == s2
}

// struct event::EventHandle<coin::WithdrawEvent> at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:34:5+224
datatype $1_event_EventHandle'$1_coin_WithdrawEvent' {
    $1_event_EventHandle'$1_coin_WithdrawEvent'($counter: int, $guid: $1_guid_GUID)
}
function {:inline} $Update'$1_event_EventHandle'$1_coin_WithdrawEvent''_counter(s: $1_event_EventHandle'$1_coin_WithdrawEvent', x: int): $1_event_EventHandle'$1_coin_WithdrawEvent' {
    $1_event_EventHandle'$1_coin_WithdrawEvent'(x, s->$guid)
}
function {:inline} $Update'$1_event_EventHandle'$1_coin_WithdrawEvent''_guid(s: $1_event_EventHandle'$1_coin_WithdrawEvent', x: $1_guid_GUID): $1_event_EventHandle'$1_coin_WithdrawEvent' {
    $1_event_EventHandle'$1_coin_WithdrawEvent'(s->$counter, x)
}
function $IsValid'$1_event_EventHandle'$1_coin_WithdrawEvent''(s: $1_event_EventHandle'$1_coin_WithdrawEvent'): bool {
    $IsValid'u64'(s->$counter)
      && $IsValid'$1_guid_GUID'(s->$guid)
}
function {:inline} $IsEqual'$1_event_EventHandle'$1_coin_WithdrawEvent''(s1: $1_event_EventHandle'$1_coin_WithdrawEvent', s2: $1_event_EventHandle'$1_coin_WithdrawEvent'): bool {
    s1 == s2
}

// fun event::new_event_handle<account::CoinRegisterEvent> [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:43:5+165
procedure {:inline 1} $1_event_new_event_handle'$1_account_CoinRegisterEvent'(_$t0: $1_guid_GUID) returns ($ret0: $1_event_EventHandle'$1_account_CoinRegisterEvent')
{
    // declare local variables
    var $t1: int;
    var $t2: $1_event_EventHandle'$1_account_CoinRegisterEvent';
    var $t0: $1_guid_GUID;
    var $temp_0'$1_event_EventHandle'$1_account_CoinRegisterEvent'': $1_event_EventHandle'$1_account_CoinRegisterEvent';
    var $temp_0'$1_guid_GUID': $1_guid_GUID;
    $t0 := _$t0;

    // bytecode translation starts here
    // trace_local[guid]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:43:5+1
    assume {:print "$at(121,1543,1544)"} true;
    assume {:print "$track_local(14,5,0):", $t0} $t0 == $t0;

    // $t1 := 0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:45:22+1
    assume {:print "$at(121,1672,1673)"} true;
    $t1 := 0;
    assume $IsValid'u64'($t1);

    // $t2 := pack event::EventHandle<#0>($t1, $t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:44:9+68
    assume {:print "$at(121,1634,1702)"} true;
    $t2 := $1_event_EventHandle'$1_account_CoinRegisterEvent'($t1, $t0);

    // trace_return[0]($t2) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:44:9+68
    assume {:print "$track_return(14,5,0):", $t2} $t2 == $t2;

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:48:5+1
    assume {:print "$at(121,1707,1708)"} true;
L1:

    // return $t2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:48:5+1
    assume {:print "$at(121,1707,1708)"} true;
    $ret0 := $t2;
    return;

}

// fun event::new_event_handle<account::KeyRotationEvent> [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:43:5+165
procedure {:inline 1} $1_event_new_event_handle'$1_account_KeyRotationEvent'(_$t0: $1_guid_GUID) returns ($ret0: $1_event_EventHandle'$1_account_KeyRotationEvent')
{
    // declare local variables
    var $t1: int;
    var $t2: $1_event_EventHandle'$1_account_KeyRotationEvent';
    var $t0: $1_guid_GUID;
    var $temp_0'$1_event_EventHandle'$1_account_KeyRotationEvent'': $1_event_EventHandle'$1_account_KeyRotationEvent';
    var $temp_0'$1_guid_GUID': $1_guid_GUID;
    $t0 := _$t0;

    // bytecode translation starts here
    // trace_local[guid]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:43:5+1
    assume {:print "$at(121,1543,1544)"} true;
    assume {:print "$track_local(14,5,0):", $t0} $t0 == $t0;

    // $t1 := 0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:45:22+1
    assume {:print "$at(121,1672,1673)"} true;
    $t1 := 0;
    assume $IsValid'u64'($t1);

    // $t2 := pack event::EventHandle<#0>($t1, $t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:44:9+68
    assume {:print "$at(121,1634,1702)"} true;
    $t2 := $1_event_EventHandle'$1_account_KeyRotationEvent'($t1, $t0);

    // trace_return[0]($t2) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:44:9+68
    assume {:print "$track_return(14,5,0):", $t2} $t2 == $t2;

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:48:5+1
    assume {:print "$at(121,1707,1708)"} true;
L1:

    // return $t2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:48:5+1
    assume {:print "$at(121,1707,1708)"} true;
    $ret0 := $t2;
    return;

}

// fun event::new_event_handle<coin::DepositEvent> [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:43:5+165
procedure {:inline 1} $1_event_new_event_handle'$1_coin_DepositEvent'(_$t0: $1_guid_GUID) returns ($ret0: $1_event_EventHandle'$1_coin_DepositEvent')
{
    // declare local variables
    var $t1: int;
    var $t2: $1_event_EventHandle'$1_coin_DepositEvent';
    var $t0: $1_guid_GUID;
    var $temp_0'$1_event_EventHandle'$1_coin_DepositEvent'': $1_event_EventHandle'$1_coin_DepositEvent';
    var $temp_0'$1_guid_GUID': $1_guid_GUID;
    $t0 := _$t0;

    // bytecode translation starts here
    // trace_local[guid]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:43:5+1
    assume {:print "$at(121,1543,1544)"} true;
    assume {:print "$track_local(14,5,0):", $t0} $t0 == $t0;

    // $t1 := 0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:45:22+1
    assume {:print "$at(121,1672,1673)"} true;
    $t1 := 0;
    assume $IsValid'u64'($t1);

    // $t2 := pack event::EventHandle<#0>($t1, $t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:44:9+68
    assume {:print "$at(121,1634,1702)"} true;
    $t2 := $1_event_EventHandle'$1_coin_DepositEvent'($t1, $t0);

    // trace_return[0]($t2) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:44:9+68
    assume {:print "$track_return(14,5,0):", $t2} $t2 == $t2;

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:48:5+1
    assume {:print "$at(121,1707,1708)"} true;
L1:

    // return $t2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:48:5+1
    assume {:print "$at(121,1707,1708)"} true;
    $ret0 := $t2;
    return;

}

// fun event::new_event_handle<coin::WithdrawEvent> [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:43:5+165
procedure {:inline 1} $1_event_new_event_handle'$1_coin_WithdrawEvent'(_$t0: $1_guid_GUID) returns ($ret0: $1_event_EventHandle'$1_coin_WithdrawEvent')
{
    // declare local variables
    var $t1: int;
    var $t2: $1_event_EventHandle'$1_coin_WithdrawEvent';
    var $t0: $1_guid_GUID;
    var $temp_0'$1_event_EventHandle'$1_coin_WithdrawEvent'': $1_event_EventHandle'$1_coin_WithdrawEvent';
    var $temp_0'$1_guid_GUID': $1_guid_GUID;
    $t0 := _$t0;

    // bytecode translation starts here
    // trace_local[guid]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:43:5+1
    assume {:print "$at(121,1543,1544)"} true;
    assume {:print "$track_local(14,5,0):", $t0} $t0 == $t0;

    // $t1 := 0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:45:22+1
    assume {:print "$at(121,1672,1673)"} true;
    $t1 := 0;
    assume $IsValid'u64'($t1);

    // $t2 := pack event::EventHandle<#0>($t1, $t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:44:9+68
    assume {:print "$at(121,1634,1702)"} true;
    $t2 := $1_event_EventHandle'$1_coin_WithdrawEvent'($t1, $t0);

    // trace_return[0]($t2) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:44:9+68
    assume {:print "$track_return(14,5,0):", $t2} $t2 == $t2;

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:48:5+1
    assume {:print "$at(121,1707,1708)"} true;
L1:

    // return $t2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/event.move:48:5+1
    assume {:print "$at(121,1707,1708)"} true;
    $ret0 := $t2;
    return;

}

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'bool'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'bool'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'u8'(bytes: Vec (int)): int;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'u8'(bytes);
$IsValid'u8'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'u64'(bytes: Vec (int)): int;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'u64'(bytes);
$IsValid'u64'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'u128'(bytes: Vec (int)): int;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'u128'(bytes);
$IsValid'u128'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'u256'(bytes: Vec (int)): int;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'u256'(bytes);
$IsValid'u256'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'address'(bytes: Vec (int)): int;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'address'(bytes);
$IsValid'address'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'signer'(bytes: Vec (int)): $signer;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'signer'(bytes);
$IsValid'signer'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'vec'u8''(bytes: Vec (int)): Vec (int);
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'vec'u8''(bytes);
$IsValid'vec'u8''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'vec'u64''(bytes: Vec (int)): Vec (int);
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'vec'u64''(bytes);
$IsValid'vec'u64''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'vec'address''(bytes: Vec (int)): Vec (int);
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'vec'address''(bytes);
$IsValid'vec'address''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'vec'$1_aggregator_Aggregator''(bytes: Vec (int)): Vec ($1_aggregator_Aggregator);
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'vec'$1_aggregator_Aggregator''(bytes);
$IsValid'vec'$1_aggregator_Aggregator''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'vec'$1_optional_aggregator_Integer''(bytes: Vec (int)): Vec ($1_optional_aggregator_Integer);
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'vec'$1_optional_aggregator_Integer''(bytes);
$IsValid'vec'$1_optional_aggregator_Integer''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'vec'$1_optional_aggregator_OptionalAggregator''(bytes: Vec (int)): Vec ($1_optional_aggregator_OptionalAggregator);
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'vec'$1_optional_aggregator_OptionalAggregator''(bytes);
$IsValid'vec'$1_optional_aggregator_OptionalAggregator''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'vec'#0''(bytes: Vec (int)): Vec (#0);
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'vec'#0''(bytes);
$IsValid'vec'#0''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_table_Table'u64_bool''(bytes: Vec (int)): Table int (bool);
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_table_Table'u64_bool''(bytes);
$IsValid'$1_table_Table'u64_bool''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_table_Table'u64_u64''(bytes: Vec (int)): Table int (int);
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_table_Table'u64_u64''(bytes);
$IsValid'$1_table_Table'u64_u64''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_table_Table'u64_vec'u64'''(bytes: Vec (int)): Table int (Vec (int));
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_table_Table'u64_vec'u64'''(bytes);
$IsValid'$1_table_Table'u64_vec'u64'''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_table_Table'address_address''(bytes: Vec (int)): Table int (int);
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_table_Table'address_address''(bytes);
$IsValid'$1_table_Table'address_address''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_option_Option'address''(bytes: Vec (int)): $1_option_Option'address';
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_option_Option'address''(bytes);
$IsValid'$1_option_Option'address''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_option_Option'$1_aggregator_Aggregator''(bytes: Vec (int)): $1_option_Option'$1_aggregator_Aggregator';
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_option_Option'$1_aggregator_Aggregator''(bytes);
$IsValid'$1_option_Option'$1_aggregator_Aggregator''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_Integer''(bytes: Vec (int)): $1_option_Option'$1_optional_aggregator_Integer';
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_Integer''(bytes);
$IsValid'$1_option_Option'$1_optional_aggregator_Integer''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_OptionalAggregator''(bytes: Vec (int)): $1_option_Option'$1_optional_aggregator_OptionalAggregator';
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_option_Option'$1_optional_aggregator_OptionalAggregator''(bytes);
$IsValid'$1_option_Option'$1_optional_aggregator_OptionalAggregator''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_string_String'(bytes: Vec (int)): $1_string_String;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_string_String'(bytes);
$IsValid'$1_string_String'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_type_info_TypeInfo'(bytes: Vec (int)): $1_type_info_TypeInfo;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_type_info_TypeInfo'(bytes);
$IsValid'$1_type_info_TypeInfo'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_aggregator_Aggregator'(bytes: Vec (int)): $1_aggregator_Aggregator;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_aggregator_Aggregator'(bytes);
$IsValid'$1_aggregator_Aggregator'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_optional_aggregator_Integer'(bytes: Vec (int)): $1_optional_aggregator_Integer;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_optional_aggregator_Integer'(bytes);
$IsValid'$1_optional_aggregator_Integer'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_optional_aggregator_OptionalAggregator'(bytes: Vec (int)): $1_optional_aggregator_OptionalAggregator;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_optional_aggregator_OptionalAggregator'(bytes);
$IsValid'$1_optional_aggregator_OptionalAggregator'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_guid_GUID'(bytes: Vec (int)): $1_guid_GUID;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_guid_GUID'(bytes);
$IsValid'$1_guid_GUID'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_guid_ID'(bytes: Vec (int)): $1_guid_ID;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_guid_ID'(bytes);
$IsValid'$1_guid_ID'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_event_EventHandle'$1_account_CoinRegisterEvent''(bytes: Vec (int)): $1_event_EventHandle'$1_account_CoinRegisterEvent';
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_event_EventHandle'$1_account_CoinRegisterEvent''(bytes);
$IsValid'$1_event_EventHandle'$1_account_CoinRegisterEvent''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_event_EventHandle'$1_account_KeyRotationEvent''(bytes: Vec (int)): $1_event_EventHandle'$1_account_KeyRotationEvent';
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_event_EventHandle'$1_account_KeyRotationEvent''(bytes);
$IsValid'$1_event_EventHandle'$1_account_KeyRotationEvent''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_DepositEvent''(bytes: Vec (int)): $1_event_EventHandle'$1_coin_DepositEvent';
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_DepositEvent''(bytes);
$IsValid'$1_event_EventHandle'$1_coin_DepositEvent''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_WithdrawEvent''(bytes: Vec (int)): $1_event_EventHandle'$1_coin_WithdrawEvent';
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_event_EventHandle'$1_coin_WithdrawEvent''(bytes);
$IsValid'$1_event_EventHandle'$1_coin_WithdrawEvent''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_account_Account'(bytes: Vec (int)): $1_account_Account;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_account_Account'(bytes);
$IsValid'$1_account_Account'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_RotationCapability''(bytes: Vec (int)): $1_account_CapabilityOffer'$1_account_RotationCapability';
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_RotationCapability''(bytes);
$IsValid'$1_account_CapabilityOffer'$1_account_RotationCapability''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_SignerCapability''(bytes: Vec (int)): $1_account_CapabilityOffer'$1_account_SignerCapability';
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_account_CapabilityOffer'$1_account_SignerCapability''(bytes);
$IsValid'$1_account_CapabilityOffer'$1_account_SignerCapability''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_account_CoinRegisterEvent'(bytes: Vec (int)): $1_account_CoinRegisterEvent;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_account_CoinRegisterEvent'(bytes);
$IsValid'$1_account_CoinRegisterEvent'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_account_SignerCapability'(bytes: Vec (int)): $1_account_SignerCapability;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_account_SignerCapability'(bytes);
$IsValid'$1_account_SignerCapability'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_coin_Coin'$1_aptos_coin_AptosCoin''(bytes: Vec (int)): $1_coin_Coin'$1_aptos_coin_AptosCoin';
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_coin_Coin'$1_aptos_coin_AptosCoin''(bytes);
$IsValid'$1_coin_Coin'$1_aptos_coin_AptosCoin''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_coin_Coin'#0''(bytes: Vec (int)): $1_coin_Coin'#0';
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_coin_Coin'#0''(bytes);
$IsValid'$1_coin_Coin'#0''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''(bytes: Vec (int)): $1_coin_CoinInfo'$1_aptos_coin_AptosCoin';
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''(bytes);
$IsValid'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_coin_CoinInfo'#0''(bytes: Vec (int)): $1_coin_CoinInfo'#0';
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_coin_CoinInfo'#0''(bytes);
$IsValid'$1_coin_CoinInfo'#0''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''(bytes: Vec (int)): $1_coin_CoinStore'$1_aptos_coin_AptosCoin';
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''(bytes);
$IsValid'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_coin_CoinStore'#0''(bytes: Vec (int)): $1_coin_CoinStore'#0';
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_coin_CoinStore'#0''(bytes);
$IsValid'$1_coin_CoinStore'#0''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_coin_DepositEvent'(bytes: Vec (int)): $1_coin_DepositEvent;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_coin_DepositEvent'(bytes);
$IsValid'$1_coin_DepositEvent'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_coin_WithdrawEvent'(bytes: Vec (int)): $1_coin_WithdrawEvent;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_coin_WithdrawEvent'(bytes);
$IsValid'$1_coin_WithdrawEvent'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''(bytes: Vec (int)): $1_coin_Ghost$supply'$1_aptos_coin_AptosCoin';
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''(bytes);
$IsValid'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_coin_Ghost$supply'#0''(bytes: Vec (int)): $1_coin_Ghost$supply'#0';
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_coin_Ghost$supply'#0''(bytes);
$IsValid'$1_coin_Ghost$supply'#0''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''(bytes: Vec (int)): $1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin';
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''(bytes);
$IsValid'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'#0''(bytes: Vec (int)): $1_coin_Ghost$aggregate_supply'#0';
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_coin_Ghost$aggregate_supply'#0''(bytes);
$IsValid'$1_coin_Ghost$aggregate_supply'#0''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_aptos_coin_AptosCoin'(bytes: Vec (int)): $1_aptos_coin_AptosCoin;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_aptos_coin_AptosCoin'(bytes);
$IsValid'$1_aptos_coin_AptosCoin'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_Bbay_Owner'(bytes: Vec (int)): $1_Bbay_Owner;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_Bbay_Owner'(bytes);
$IsValid'$1_Bbay_Owner'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_Bbay_Products'(bytes: Vec (int)): $1_Bbay_Products;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_Bbay_Products'(bytes);
$IsValid'$1_Bbay_Products'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_Bbay_ResourceAccountSignerCap'(bytes: Vec (int)): $1_Bbay_ResourceAccountSignerCap;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_Bbay_ResourceAccountSignerCap'(bytes);
$IsValid'$1_Bbay_ResourceAccountSignerCap'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'$1_Bbay_User'(bytes: Vec (int)): $1_Bbay_User;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'$1_Bbay_User'(bytes);
$IsValid'$1_Bbay_User'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:7:9+41
function  $1_from_bcs_deserialize'#0'(bytes: Vec (int)): #0;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserialize'#0'(bytes);
$IsValid'#0'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'bool'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'bool'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'u8'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'u8'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'u64'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'u64'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'u128'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'u128'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'u256'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'u256'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'address'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'address'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'signer'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'signer'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'vec'u8''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'vec'u8''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'vec'u64''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'vec'u64''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'vec'address''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'vec'address''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'vec'$1_aggregator_Aggregator''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'vec'$1_aggregator_Aggregator''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'vec'$1_optional_aggregator_Integer''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'vec'$1_optional_aggregator_Integer''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'vec'$1_optional_aggregator_OptionalAggregator''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'vec'$1_optional_aggregator_OptionalAggregator''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'vec'#0''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'vec'#0''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_table_Table'u64_bool''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_table_Table'u64_bool''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_table_Table'u64_u64''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_table_Table'u64_u64''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_table_Table'u64_vec'u64'''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_table_Table'u64_vec'u64'''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_table_Table'address_address''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_table_Table'address_address''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_option_Option'address''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_option_Option'address''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_option_Option'$1_aggregator_Aggregator''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_option_Option'$1_aggregator_Aggregator''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_option_Option'$1_optional_aggregator_Integer''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_option_Option'$1_optional_aggregator_Integer''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_option_Option'$1_optional_aggregator_OptionalAggregator''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_option_Option'$1_optional_aggregator_OptionalAggregator''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_string_String'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_string_String'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_type_info_TypeInfo'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_type_info_TypeInfo'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_aggregator_Aggregator'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_aggregator_Aggregator'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_optional_aggregator_Integer'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_optional_aggregator_Integer'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_optional_aggregator_OptionalAggregator'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_optional_aggregator_OptionalAggregator'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_guid_GUID'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_guid_GUID'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_guid_ID'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_guid_ID'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_event_EventHandle'$1_account_CoinRegisterEvent''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_event_EventHandle'$1_account_CoinRegisterEvent''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_event_EventHandle'$1_account_KeyRotationEvent''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_event_EventHandle'$1_account_KeyRotationEvent''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_event_EventHandle'$1_coin_DepositEvent''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_event_EventHandle'$1_coin_DepositEvent''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_event_EventHandle'$1_coin_WithdrawEvent''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_event_EventHandle'$1_coin_WithdrawEvent''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_account_Account'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_account_Account'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_account_CapabilityOffer'$1_account_RotationCapability''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_account_CapabilityOffer'$1_account_RotationCapability''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_account_CapabilityOffer'$1_account_SignerCapability''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_account_CapabilityOffer'$1_account_SignerCapability''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_account_CoinRegisterEvent'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_account_CoinRegisterEvent'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_account_SignerCapability'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_account_SignerCapability'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_coin_Coin'$1_aptos_coin_AptosCoin''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_coin_Coin'$1_aptos_coin_AptosCoin''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_coin_Coin'#0''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_coin_Coin'#0''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_coin_CoinInfo'#0''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_coin_CoinInfo'#0''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_coin_CoinStore'#0''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_coin_CoinStore'#0''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_coin_DepositEvent'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_coin_DepositEvent'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_coin_WithdrawEvent'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_coin_WithdrawEvent'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_coin_Ghost$supply'#0''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_coin_Ghost$supply'#0''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_coin_Ghost$aggregate_supply'#0''(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_coin_Ghost$aggregate_supply'#0''(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_aptos_coin_AptosCoin'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_aptos_coin_AptosCoin'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_Bbay_Owner'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_Bbay_Owner'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_Bbay_Products'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_Bbay_Products'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_Bbay_ResourceAccountSignerCap'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_Bbay_ResourceAccountSignerCap'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'$1_Bbay_User'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'$1_Bbay_User'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/from_bcs.spec.move:11:9+47
function  $1_from_bcs_deserializable'#0'(bytes: Vec (int)): bool;
axiom (forall bytes: Vec (int) ::
(var $$res := $1_from_bcs_deserializable'#0'(bytes);
$IsValid'bool'($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:447:10+77
function  $1_account_spec_create_resource_address(source: int, seed: Vec (int)): int;
axiom (forall source: int, seed: Vec (int) ::
(var $$res := $1_account_spec_create_resource_address(source, seed);
$IsValid'address'($$res)));

// struct account::Account at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:27:5+401
datatype $1_account_Account {
    $1_account_Account($authentication_key: Vec (int), $sequence_number: int, $guid_creation_num: int, $coin_register_events: $1_event_EventHandle'$1_account_CoinRegisterEvent', $key_rotation_events: $1_event_EventHandle'$1_account_KeyRotationEvent', $rotation_capability_offer: $1_account_CapabilityOffer'$1_account_RotationCapability', $signer_capability_offer: $1_account_CapabilityOffer'$1_account_SignerCapability')
}
function {:inline} $Update'$1_account_Account'_authentication_key(s: $1_account_Account, x: Vec (int)): $1_account_Account {
    $1_account_Account(x, s->$sequence_number, s->$guid_creation_num, s->$coin_register_events, s->$key_rotation_events, s->$rotation_capability_offer, s->$signer_capability_offer)
}
function {:inline} $Update'$1_account_Account'_sequence_number(s: $1_account_Account, x: int): $1_account_Account {
    $1_account_Account(s->$authentication_key, x, s->$guid_creation_num, s->$coin_register_events, s->$key_rotation_events, s->$rotation_capability_offer, s->$signer_capability_offer)
}
function {:inline} $Update'$1_account_Account'_guid_creation_num(s: $1_account_Account, x: int): $1_account_Account {
    $1_account_Account(s->$authentication_key, s->$sequence_number, x, s->$coin_register_events, s->$key_rotation_events, s->$rotation_capability_offer, s->$signer_capability_offer)
}
function {:inline} $Update'$1_account_Account'_coin_register_events(s: $1_account_Account, x: $1_event_EventHandle'$1_account_CoinRegisterEvent'): $1_account_Account {
    $1_account_Account(s->$authentication_key, s->$sequence_number, s->$guid_creation_num, x, s->$key_rotation_events, s->$rotation_capability_offer, s->$signer_capability_offer)
}
function {:inline} $Update'$1_account_Account'_key_rotation_events(s: $1_account_Account, x: $1_event_EventHandle'$1_account_KeyRotationEvent'): $1_account_Account {
    $1_account_Account(s->$authentication_key, s->$sequence_number, s->$guid_creation_num, s->$coin_register_events, x, s->$rotation_capability_offer, s->$signer_capability_offer)
}
function {:inline} $Update'$1_account_Account'_rotation_capability_offer(s: $1_account_Account, x: $1_account_CapabilityOffer'$1_account_RotationCapability'): $1_account_Account {
    $1_account_Account(s->$authentication_key, s->$sequence_number, s->$guid_creation_num, s->$coin_register_events, s->$key_rotation_events, x, s->$signer_capability_offer)
}
function {:inline} $Update'$1_account_Account'_signer_capability_offer(s: $1_account_Account, x: $1_account_CapabilityOffer'$1_account_SignerCapability'): $1_account_Account {
    $1_account_Account(s->$authentication_key, s->$sequence_number, s->$guid_creation_num, s->$coin_register_events, s->$key_rotation_events, s->$rotation_capability_offer, x)
}
function $IsValid'$1_account_Account'(s: $1_account_Account): bool {
    $IsValid'vec'u8''(s->$authentication_key)
      && $IsValid'u64'(s->$sequence_number)
      && $IsValid'u64'(s->$guid_creation_num)
      && $IsValid'$1_event_EventHandle'$1_account_CoinRegisterEvent''(s->$coin_register_events)
      && $IsValid'$1_event_EventHandle'$1_account_KeyRotationEvent''(s->$key_rotation_events)
      && $IsValid'$1_account_CapabilityOffer'$1_account_RotationCapability''(s->$rotation_capability_offer)
      && $IsValid'$1_account_CapabilityOffer'$1_account_SignerCapability''(s->$signer_capability_offer)
}
function {:inline} $IsEqual'$1_account_Account'(s1: $1_account_Account, s2: $1_account_Account): bool {
    $IsEqual'vec'u8''(s1->$authentication_key, s2->$authentication_key)
    && $IsEqual'u64'(s1->$sequence_number, s2->$sequence_number)
    && $IsEqual'u64'(s1->$guid_creation_num, s2->$guid_creation_num)
    && $IsEqual'$1_event_EventHandle'$1_account_CoinRegisterEvent''(s1->$coin_register_events, s2->$coin_register_events)
    && $IsEqual'$1_event_EventHandle'$1_account_KeyRotationEvent''(s1->$key_rotation_events, s2->$key_rotation_events)
    && $IsEqual'$1_account_CapabilityOffer'$1_account_RotationCapability''(s1->$rotation_capability_offer, s2->$rotation_capability_offer)
    && $IsEqual'$1_account_CapabilityOffer'$1_account_SignerCapability''(s1->$signer_capability_offer, s2->$signer_capability_offer)}
var $1_account_Account_$memory: $Memory $1_account_Account;

// struct account::CapabilityOffer<account::RotationCapability> at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:46:5+68
datatype $1_account_CapabilityOffer'$1_account_RotationCapability' {
    $1_account_CapabilityOffer'$1_account_RotationCapability'($for: $1_option_Option'address')
}
function {:inline} $Update'$1_account_CapabilityOffer'$1_account_RotationCapability''_for(s: $1_account_CapabilityOffer'$1_account_RotationCapability', x: $1_option_Option'address'): $1_account_CapabilityOffer'$1_account_RotationCapability' {
    $1_account_CapabilityOffer'$1_account_RotationCapability'(x)
}
function $IsValid'$1_account_CapabilityOffer'$1_account_RotationCapability''(s: $1_account_CapabilityOffer'$1_account_RotationCapability'): bool {
    $IsValid'$1_option_Option'address''(s->$for)
}
function {:inline} $IsEqual'$1_account_CapabilityOffer'$1_account_RotationCapability''(s1: $1_account_CapabilityOffer'$1_account_RotationCapability', s2: $1_account_CapabilityOffer'$1_account_RotationCapability'): bool {
    $IsEqual'$1_option_Option'address''(s1->$for, s2->$for)}

// struct account::CapabilityOffer<account::SignerCapability> at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:46:5+68
datatype $1_account_CapabilityOffer'$1_account_SignerCapability' {
    $1_account_CapabilityOffer'$1_account_SignerCapability'($for: $1_option_Option'address')
}
function {:inline} $Update'$1_account_CapabilityOffer'$1_account_SignerCapability''_for(s: $1_account_CapabilityOffer'$1_account_SignerCapability', x: $1_option_Option'address'): $1_account_CapabilityOffer'$1_account_SignerCapability' {
    $1_account_CapabilityOffer'$1_account_SignerCapability'(x)
}
function $IsValid'$1_account_CapabilityOffer'$1_account_SignerCapability''(s: $1_account_CapabilityOffer'$1_account_SignerCapability'): bool {
    $IsValid'$1_option_Option'address''(s->$for)
}
function {:inline} $IsEqual'$1_account_CapabilityOffer'$1_account_SignerCapability''(s1: $1_account_CapabilityOffer'$1_account_SignerCapability', s2: $1_account_CapabilityOffer'$1_account_SignerCapability'): bool {
    $IsEqual'$1_option_Option'address''(s1->$for, s2->$for)}

// struct account::CoinRegisterEvent at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:42:5+77
datatype $1_account_CoinRegisterEvent {
    $1_account_CoinRegisterEvent($type_info: $1_type_info_TypeInfo)
}
function {:inline} $Update'$1_account_CoinRegisterEvent'_type_info(s: $1_account_CoinRegisterEvent, x: $1_type_info_TypeInfo): $1_account_CoinRegisterEvent {
    $1_account_CoinRegisterEvent(x)
}
function $IsValid'$1_account_CoinRegisterEvent'(s: $1_account_CoinRegisterEvent): bool {
    $IsValid'$1_type_info_TypeInfo'(s->$type_info)
}
function {:inline} $IsEqual'$1_account_CoinRegisterEvent'(s1: $1_account_CoinRegisterEvent, s2: $1_account_CoinRegisterEvent): bool {
    $IsEqual'$1_type_info_TypeInfo'(s1->$type_info, s2->$type_info)}

// struct account::KeyRotationEvent at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:37:5+135
datatype $1_account_KeyRotationEvent {
    $1_account_KeyRotationEvent($old_authentication_key: Vec (int), $new_authentication_key: Vec (int))
}
function {:inline} $Update'$1_account_KeyRotationEvent'_old_authentication_key(s: $1_account_KeyRotationEvent, x: Vec (int)): $1_account_KeyRotationEvent {
    $1_account_KeyRotationEvent(x, s->$new_authentication_key)
}
function {:inline} $Update'$1_account_KeyRotationEvent'_new_authentication_key(s: $1_account_KeyRotationEvent, x: Vec (int)): $1_account_KeyRotationEvent {
    $1_account_KeyRotationEvent(s->$old_authentication_key, x)
}
function $IsValid'$1_account_KeyRotationEvent'(s: $1_account_KeyRotationEvent): bool {
    $IsValid'vec'u8''(s->$old_authentication_key)
      && $IsValid'vec'u8''(s->$new_authentication_key)
}
function {:inline} $IsEqual'$1_account_KeyRotationEvent'(s1: $1_account_KeyRotationEvent, s2: $1_account_KeyRotationEvent): bool {
    $IsEqual'vec'u8''(s1->$old_authentication_key, s2->$old_authentication_key)
    && $IsEqual'vec'u8''(s1->$new_authentication_key, s2->$new_authentication_key)}

// struct account::RotationCapability at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:48:5+62
datatype $1_account_RotationCapability {
    $1_account_RotationCapability($account: int)
}
function {:inline} $Update'$1_account_RotationCapability'_account(s: $1_account_RotationCapability, x: int): $1_account_RotationCapability {
    $1_account_RotationCapability(x)
}
function $IsValid'$1_account_RotationCapability'(s: $1_account_RotationCapability): bool {
    $IsValid'address'(s->$account)
}
function {:inline} $IsEqual'$1_account_RotationCapability'(s1: $1_account_RotationCapability, s2: $1_account_RotationCapability): bool {
    s1 == s2
}

// struct account::SignerCapability at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:50:5+60
datatype $1_account_SignerCapability {
    $1_account_SignerCapability($account: int)
}
function {:inline} $Update'$1_account_SignerCapability'_account(s: $1_account_SignerCapability, x: int): $1_account_SignerCapability {
    $1_account_SignerCapability(x)
}
function $IsValid'$1_account_SignerCapability'(s: $1_account_SignerCapability): bool {
    $IsValid'address'(s->$account)
}
function {:inline} $IsEqual'$1_account_SignerCapability'(s1: $1_account_SignerCapability, s2: $1_account_SignerCapability): bool {
    s1 == s2
}

// fun account::new_event_handle<coin::DepositEvent> [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:697:5+157
procedure {:inline 1} $1_account_new_event_handle'$1_coin_DepositEvent'(_$t0: $signer) returns ($ret0: $1_event_EventHandle'$1_coin_DepositEvent')
{
    // declare local variables
    var $t1: int;
    var $t2: $1_account_Account;
    var $t3: int;
    var $t4: int;
    var $t5: $1_account_Account;
    var $t6: $1_guid_GUID;
    var $t7: int;
    var $t8: $1_event_EventHandle'$1_coin_DepositEvent';
    var $t0: $signer;
    var $temp_0'$1_event_EventHandle'$1_coin_DepositEvent'': $1_event_EventHandle'$1_coin_DepositEvent';
    var $temp_0'signer': $signer;
    $t0 := _$t0;

    // bytecode translation starts here
    // assume Identical($t1, signer::$address_of($t0)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:504:9+39
    assume {:print "$at(82,24284,24323)"} true;
    assume ($t1 == $1_signer_$address_of($t0));

    // assume Identical($t2, global<account::Account>($t1)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:505:9+36
    assume {:print "$at(82,24332,24368)"} true;
    assume ($t2 == $ResourceValue($1_account_Account_$memory, $t1));

    // trace_local[account]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:697:5+1
    assume {:print "$at(81,39402,39403)"} true;
    assume {:print "$track_local(21,21,0):", $t0} $t0 == $t0;

    // assume Identical($t3, signer::$address_of($t0)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:489:9+46
    assume {:print "$at(82,23683,23729)"} true;
    assume ($t3 == $1_signer_$address_of($t0));

    // assume Identical($t4, signer::$address_of($t0)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:504:9+39
    assume {:print "$at(82,24284,24323)"} true;
    assume ($t4 == $1_signer_$address_of($t0));

    // assume Identical($t5, global<account::Account>($t4)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:505:9+36
    assume {:print "$at(82,24332,24368)"} true;
    assume ($t5 == $ResourceValue($1_account_Account_$memory, $t4));

    // $t6 := account::create_guid($t0) on_abort goto L2 with $t7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:698:33+20
    assume {:print "$at(81,39532,39552)"} true;
    call $t6 := $1_account_create_guid($t0);
    if ($abort_flag) {
        assume {:print "$at(81,39532,39552)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(21,21):", $t7} $t7 == $t7;
        goto L2;
    }

    // $t8 := event::new_event_handle<#0>($t6) on_abort goto L2 with $t7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:698:9+45
    call $t8 := $1_event_new_event_handle'$1_coin_DepositEvent'($t6);
    if ($abort_flag) {
        assume {:print "$at(81,39508,39553)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(21,21):", $t7} $t7 == $t7;
        goto L2;
    }

    // trace_return[0]($t8) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:698:9+45
    assume {:print "$track_return(21,21,0):", $t8} $t8 == $t8;

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:699:5+1
    assume {:print "$at(81,39558,39559)"} true;
L1:

    // return $t8 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:699:5+1
    assume {:print "$at(81,39558,39559)"} true;
    $ret0 := $t8;
    return;

    // label L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:699:5+1
L2:

    // abort($t7) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:699:5+1
    assume {:print "$at(81,39558,39559)"} true;
    $abort_code := $t7;
    $abort_flag := true;
    return;

}

// fun account::new_event_handle<coin::WithdrawEvent> [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:697:5+157
procedure {:inline 1} $1_account_new_event_handle'$1_coin_WithdrawEvent'(_$t0: $signer) returns ($ret0: $1_event_EventHandle'$1_coin_WithdrawEvent')
{
    // declare local variables
    var $t1: int;
    var $t2: $1_account_Account;
    var $t3: int;
    var $t4: int;
    var $t5: $1_account_Account;
    var $t6: $1_guid_GUID;
    var $t7: int;
    var $t8: $1_event_EventHandle'$1_coin_WithdrawEvent';
    var $t0: $signer;
    var $temp_0'$1_event_EventHandle'$1_coin_WithdrawEvent'': $1_event_EventHandle'$1_coin_WithdrawEvent';
    var $temp_0'signer': $signer;
    $t0 := _$t0;

    // bytecode translation starts here
    // assume Identical($t1, signer::$address_of($t0)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:504:9+39
    assume {:print "$at(82,24284,24323)"} true;
    assume ($t1 == $1_signer_$address_of($t0));

    // assume Identical($t2, global<account::Account>($t1)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:505:9+36
    assume {:print "$at(82,24332,24368)"} true;
    assume ($t2 == $ResourceValue($1_account_Account_$memory, $t1));

    // trace_local[account]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:697:5+1
    assume {:print "$at(81,39402,39403)"} true;
    assume {:print "$track_local(21,21,0):", $t0} $t0 == $t0;

    // assume Identical($t3, signer::$address_of($t0)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:489:9+46
    assume {:print "$at(82,23683,23729)"} true;
    assume ($t3 == $1_signer_$address_of($t0));

    // assume Identical($t4, signer::$address_of($t0)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:504:9+39
    assume {:print "$at(82,24284,24323)"} true;
    assume ($t4 == $1_signer_$address_of($t0));

    // assume Identical($t5, global<account::Account>($t4)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:505:9+36
    assume {:print "$at(82,24332,24368)"} true;
    assume ($t5 == $ResourceValue($1_account_Account_$memory, $t4));

    // $t6 := account::create_guid($t0) on_abort goto L2 with $t7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:698:33+20
    assume {:print "$at(81,39532,39552)"} true;
    call $t6 := $1_account_create_guid($t0);
    if ($abort_flag) {
        assume {:print "$at(81,39532,39552)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(21,21):", $t7} $t7 == $t7;
        goto L2;
    }

    // $t8 := event::new_event_handle<#0>($t6) on_abort goto L2 with $t7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:698:9+45
    call $t8 := $1_event_new_event_handle'$1_coin_WithdrawEvent'($t6);
    if ($abort_flag) {
        assume {:print "$at(81,39508,39553)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(21,21):", $t7} $t7 == $t7;
        goto L2;
    }

    // trace_return[0]($t8) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:698:9+45
    assume {:print "$track_return(21,21,0):", $t8} $t8 == $t8;

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:699:5+1
    assume {:print "$at(81,39558,39559)"} true;
L1:

    // return $t8 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:699:5+1
    assume {:print "$at(81,39558,39559)"} true;
    $ret0 := $t8;
    return;

    // label L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:699:5+1
L2:

    // abort($t7) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:699:5+1
    assume {:print "$at(81,39558,39559)"} true;
    $abort_code := $t7;
    $abort_flag := true;
    return;

}

// fun account::create_account_unchecked [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:198:5+1182
procedure {:inline 1} $1_account_create_account_unchecked(_$t0: int) returns ($ret0: $signer)
{
    // declare local variables
    var $t1: Vec (int);
    var $t2: $1_event_EventHandle'$1_account_CoinRegisterEvent';
    var $t3: int;
    var $t4: $1_event_EventHandle'$1_account_KeyRotationEvent';
    var $t5: $signer;
    var $t6: Vec (int);
    var $t7: $signer;
    var $t8: Vec (int);
    var $t9: int;
    var $t10: int;
    var $t11: int;
    var $t12: bool;
    var $t13: int;
    var $t14: int;
    var $t15: int;
    var $t16: $Mutation (int);
    var $t17: $1_guid_GUID;
    var $t18: $1_event_EventHandle'$1_account_CoinRegisterEvent';
    var $t19: $Mutation (int);
    var $t20: $1_guid_GUID;
    var $t21: $1_event_EventHandle'$1_account_KeyRotationEvent';
    var $t22: int;
    var $t23: int;
    var $t24: $1_option_Option'address';
    var $t25: $1_account_CapabilityOffer'$1_account_RotationCapability';
    var $t26: $1_option_Option'address';
    var $t27: $1_account_CapabilityOffer'$1_account_SignerCapability';
    var $t28: $1_account_Account;
    var $t0: int;
    var $temp_0'$1_event_EventHandle'$1_account_CoinRegisterEvent'': $1_event_EventHandle'$1_account_CoinRegisterEvent';
    var $temp_0'$1_event_EventHandle'$1_account_KeyRotationEvent'': $1_event_EventHandle'$1_account_KeyRotationEvent';
    var $temp_0'address': int;
    var $temp_0'signer': $signer;
    var $temp_0'u64': int;
    var $temp_0'vec'u8'': Vec (int);
    $t0 := _$t0;

    // bytecode translation starts here
    // assume Identical($t6, bcs::$to_bytes<address>($t0)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:54:9+45
    assume {:print "$at(82,2155,2200)"} true;
    assume ($t6 == $1_bcs_$to_bytes'address'($t0));

    // trace_local[new_address]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:198:5+1
    assume {:print "$at(81,10394,10395)"} true;
    assume {:print "$track_local(21,3,0):", $t0} $t0 == $t0;

    // $t7 := opaque begin: create_signer::create_signer($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:199:27+26
    assume {:print "$at(81,10481,10507)"} true;

    // assume WellFormed($t7) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:199:27+26
    assume $IsValid'signer'($t7) && $1_signer_is_txn_signer($t7) && $1_signer_is_txn_signer_addr($t7->$addr);

    // assume Eq<address>(signer::$address_of($t7), $t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:199:27+26
    assume $IsEqual'address'($1_signer_$address_of($t7), $t0);

    // $t7 := opaque end: create_signer::create_signer($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:199:27+26

    // trace_local[new_account]($t7) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:199:13+11
    assume {:print "$track_local(21,3,5):", $t7} $t7 == $t7;

    // $t8 := bcs::to_bytes<address>($t0) on_abort goto L4 with $t9 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:200:34+27
    assume {:print "$at(81,10542,10569)"} true;
    call $t8 := $1_bcs_to_bytes'address'($t0);
    if ($abort_flag) {
        assume {:print "$at(81,10542,10569)"} true;
        $t9 := $abort_code;
        assume {:print "$track_abort(21,3):", $t9} $t9 == $t9;
        goto L4;
    }

    // trace_local[authentication_key]($t8) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:200:13+18
    assume {:print "$track_local(21,3,1):", $t8} $t8 == $t8;

    // $t10 := vector::length<u8>($t8) on_abort goto L4 with $t9 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:202:13+35
    assume {:print "$at(81,10600,10635)"} true;
    call $t10 := $1_vector_length'u8'($t8);
    if ($abort_flag) {
        assume {:print "$at(81,10600,10635)"} true;
        $t9 := $abort_code;
        assume {:print "$track_abort(21,3):", $t9} $t9 == $t9;
        goto L4;
    }

    // $t11 := 32 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:202:52+2
    $t11 := 32;
    assume $IsValid'u64'($t11);

    // $t12 := ==($t10, $t11) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:202:49+2
    $t12 := $IsEqual'u64'($t10, $t11);

    // if ($t12) goto L1 else goto L0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:201:9+140
    assume {:print "$at(81,10579,10719)"} true;
    if ($t12) { goto L1; } else { goto L0; }

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:201:9+140
L1:

    // goto L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:201:9+140
    assume {:print "$at(81,10579,10719)"} true;
    goto L2;

    // label L0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:203:37+29
    assume {:print "$at(81,10679,10708)"} true;
L0:

    // $t13 := 4 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:203:37+29
    assume {:print "$at(81,10679,10708)"} true;
    $t13 := 4;
    assume $IsValid'u64'($t13);

    // $t14 := error::invalid_argument($t13) on_abort goto L4 with $t9 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:203:13+54
    call $t14 := $1_error_invalid_argument($t13);
    if ($abort_flag) {
        assume {:print "$at(81,10655,10709)"} true;
        $t9 := $abort_code;
        assume {:print "$track_abort(21,3):", $t9} $t9 == $t9;
        goto L4;
    }

    // trace_abort($t14) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:201:9+140
    assume {:print "$at(81,10579,10719)"} true;
    assume {:print "$track_abort(21,3):", $t14} $t14 == $t14;

    // $t9 := move($t14) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:201:9+140
    $t9 := $t14;

    // goto L4 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:201:9+140
    goto L4;

    // label L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:206:33+1
    assume {:print "$at(81,10754,10755)"} true;
L2:

    // $t15 := 0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:206:33+1
    assume {:print "$at(81,10754,10755)"} true;
    $t15 := 0;
    assume $IsValid'u64'($t15);

    // $t3 := $t15 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:206:13+17
    $t3 := $t15;

    // trace_local[guid_creation_num]($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:206:13+17
    assume {:print "$track_local(21,3,3):", $t3} $t3 == $t3;

    // $t16 := borrow_local($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:208:55+22
    assume {:print "$at(81,10812,10834)"} true;
    $t16 := $Mutation($Local(3), EmptyVec(), $t3);

    // $t17 := guid::create($t0, $t16) on_abort goto L4 with $t9 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:208:29+49
    call $t17,$t16 := $1_guid_create($t0, $t16);
    if ($abort_flag) {
        assume {:print "$at(81,10786,10835)"} true;
        $t9 := $abort_code;
        assume {:print "$track_abort(21,3):", $t9} $t9 == $t9;
        goto L4;
    }

    // write_back[LocalRoot($t3)@]($t16) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:208:29+49
    $t3 := $Dereference($t16);

    // trace_local[guid_creation_num]($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:208:29+49
    assume {:print "$track_local(21,3,3):", $t3} $t3 == $t3;

    // $t18 := event::new_event_handle<account::CoinRegisterEvent>($t17) on_abort goto L4 with $t9 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:209:36+57
    assume {:print "$at(81,10872,10929)"} true;
    call $t18 := $1_event_new_event_handle'$1_account_CoinRegisterEvent'($t17);
    if ($abort_flag) {
        assume {:print "$at(81,10872,10929)"} true;
        $t9 := $abort_code;
        assume {:print "$track_abort(21,3):", $t9} $t9 == $t9;
        goto L4;
    }

    // trace_local[coin_register_events]($t18) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:209:13+20
    assume {:print "$track_local(21,3,2):", $t18} $t18 == $t18;

    // $t19 := borrow_local($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:211:59+22
    assume {:print "$at(81,10990,11012)"} true;
    $t19 := $Mutation($Local(3), EmptyVec(), $t3);

    // $t20 := guid::create($t0, $t19) on_abort goto L4 with $t9 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:211:33+49
    call $t20,$t19 := $1_guid_create($t0, $t19);
    if ($abort_flag) {
        assume {:print "$at(81,10964,11013)"} true;
        $t9 := $abort_code;
        assume {:print "$track_abort(21,3):", $t9} $t9 == $t9;
        goto L4;
    }

    // write_back[LocalRoot($t3)@]($t19) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:211:33+49
    $t3 := $Dereference($t19);

    // trace_local[guid_creation_num]($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:211:33+49
    assume {:print "$track_local(21,3,3):", $t3} $t3 == $t3;

    // $t21 := event::new_event_handle<account::KeyRotationEvent>($t20) on_abort goto L4 with $t9 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:212:35+60
    assume {:print "$at(81,11049,11109)"} true;
    call $t21 := $1_event_new_event_handle'$1_account_KeyRotationEvent'($t20);
    if ($abort_flag) {
        assume {:print "$at(81,11049,11109)"} true;
        $t9 := $abort_code;
        assume {:print "$track_abort(21,3):", $t9} $t9 == $t9;
        goto L4;
    }

    // trace_local[key_rotation_events]($t21) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:212:13+19
    assume {:print "$track_local(21,3,4):", $t21} $t21 == $t21;

    // $t22 := 0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:218:34+1
    assume {:print "$at(81,11246,11247)"} true;
    $t22 := 0;
    assume $IsValid'u64'($t22);

    // $t23 := move($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:219:17+17
    assume {:print "$at(81,11265,11282)"} true;
    $t23 := $t3;

    // $t24 := opaque begin: option::none<address>() at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:222:67+14
    assume {:print "$at(81,11425,11439)"} true;

    // assume And(WellFormed($t24), Le(Len<address>(select option::Option.vec($t24)), 1)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:222:67+14
    assume ($IsValid'$1_option_Option'address''($t24) && (LenVec($t24->$vec) <= 1));

    // assume Eq<option::Option<address>>($t24, option::spec_none<address>()) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:222:67+14
    assume $IsEqual'$1_option_Option'address''($t24, $1_option_spec_none'address'());

    // $t24 := opaque end: option::none<address>() at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:222:67+14

    // $t25 := pack account::CapabilityOffer<account::RotationCapability>($t24) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:222:44+39
    $t25 := $1_account_CapabilityOffer'$1_account_RotationCapability'($t24);

    // $t26 := opaque begin: option::none<address>() at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:223:65+14
    assume {:print "$at(81,11507,11521)"} true;

    // assume And(WellFormed($t26), Le(Len<address>(select option::Option.vec($t26)), 1)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:223:65+14
    assume ($IsValid'$1_option_Option'address''($t26) && (LenVec($t26->$vec) <= 1));

    // assume Eq<option::Option<address>>($t26, option::spec_none<address>()) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:223:65+14
    assume $IsEqual'$1_option_Option'address''($t26, $1_option_spec_none'address'());

    // $t26 := opaque end: option::none<address>() at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:223:65+14

    // $t27 := pack account::CapabilityOffer<account::SignerCapability>($t26) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:223:42+39
    $t27 := $1_account_CapabilityOffer'$1_account_SignerCapability'($t26);

    // $t28 := pack account::Account($t8, $t22, $t23, $t18, $t21, $t25, $t27) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:216:13+371
    assume {:print "$at(81,11167,11538)"} true;
    $t28 := $1_account_Account($t8, $t22, $t23, $t18, $t21, $t25, $t27);

    // move_to<account::Account>($t28, $t7) on_abort goto L4 with $t9 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:214:9+7
    assume {:print "$at(81,11120,11127)"} true;
    if ($ResourceExists($1_account_Account_$memory, $t7->$addr)) {
        call $ExecFailureAbort();
    } else {
        $1_account_Account_$memory := $ResourceUpdate($1_account_Account_$memory, $t7->$addr, $t28);
    }
    if ($abort_flag) {
        assume {:print "$at(81,11120,11127)"} true;
        $t9 := $abort_code;
        assume {:print "$track_abort(21,3):", $t9} $t9 == $t9;
        goto L4;
    }

    // trace_return[0]($t7) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:227:9+11
    assume {:print "$at(81,11559,11570)"} true;
    assume {:print "$track_return(21,3,0):", $t7} $t7 == $t7;

    // label L3 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:228:5+1
    assume {:print "$at(81,11575,11576)"} true;
L3:

    // return $t7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:228:5+1
    assume {:print "$at(81,11575,11576)"} true;
    $ret0 := $t7;
    return;

    // label L4 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:228:5+1
L4:

    // abort($t9) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:228:5+1
    assume {:print "$at(81,11575,11576)"} true;
    $abort_code := $t9;
    $abort_flag := true;
    return;

}

// fun account::create_guid [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:682:5+436
procedure {:inline 1} $1_account_create_guid(_$t0: $signer) returns ($ret0: $1_guid_GUID)
{
    // declare local variables
    var $t1: $Mutation ($1_account_Account);
    var $t2: int;
    var $t3: $1_guid_GUID;
    var $t4: int;
    var $t5: int;
    var $t6: $1_account_Account;
    var $t7: int;
    var $t8: int;
    var $t9: $Mutation ($1_account_Account);
    var $t10: $Mutation (int);
    var $t11: $1_guid_GUID;
    var $t12: int;
    var $t13: int;
    var $t14: bool;
    var $t15: int;
    var $t16: int;
    var $t0: $signer;
    var $1_account_Account_$modifies: [int]bool;
    var $temp_0'$1_account_Account': $1_account_Account;
    var $temp_0'$1_guid_GUID': $1_guid_GUID;
    var $temp_0'address': int;
    var $temp_0'signer': $signer;
    $t0 := _$t0;

    // bytecode translation starts here
    // assume Identical($t4, signer::$address_of($t0)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:489:9+46
    assume {:print "$at(82,23683,23729)"} true;
    assume ($t4 == $1_signer_$address_of($t0));

    // assume Identical($t5, signer::$address_of($t0)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:504:9+39
    assume {:print "$at(82,24284,24323)"} true;
    assume ($t5 == $1_signer_$address_of($t0));

    // assume Identical($t6, global<account::Account>($t5)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:505:9+36
    assume {:print "$at(82,24332,24368)"} true;
    assume ($t6 == $ResourceValue($1_account_Account_$memory, $t5));

    // trace_local[account_signer]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:682:5+1
    assume {:print "$at(81,38766,38767)"} true;
    assume {:print "$track_local(21,6,0):", $t0} $t0 == $t0;

    // $t7 := signer::address_of($t0) on_abort goto L4 with $t8 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:683:20+34
    assume {:print "$at(81,38864,38898)"} true;
    call $t7 := $1_signer_address_of($t0);
    if ($abort_flag) {
        assume {:print "$at(81,38864,38898)"} true;
        $t8 := $abort_code;
        assume {:print "$track_abort(21,6):", $t8} $t8 == $t8;
        goto L4;
    }

    // trace_local[addr]($t7) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:683:13+4
    assume {:print "$track_local(21,6,2):", $t7} $t7 == $t7;

    // $t9 := borrow_global<account::Account>($t7) on_abort goto L4 with $t8 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:684:23+17
    assume {:print "$at(81,38922,38939)"} true;
    if (!$ResourceExists($1_account_Account_$memory, $t7)) {
        call $ExecFailureAbort();
    } else {
        $t9 := $Mutation($Global($t7), EmptyVec(), $ResourceValue($1_account_Account_$memory, $t7));
    }
    if ($abort_flag) {
        assume {:print "$at(81,38922,38939)"} true;
        $t8 := $abort_code;
        assume {:print "$track_abort(21,6):", $t8} $t8 == $t8;
        goto L4;
    }

    // trace_local[account]($t9) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:684:13+7
    $temp_0'$1_account_Account' := $Dereference($t9);
    assume {:print "$track_local(21,6,1):", $temp_0'$1_account_Account'} $temp_0'$1_account_Account' == $temp_0'$1_account_Account';

    // $t10 := borrow_field<account::Account>.guid_creation_num($t9) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:685:39+30
    assume {:print "$at(81,38994,39024)"} true;
    $t10 := $ChildMutation($t9, 2, $Dereference($t9)->$guid_creation_num);

    // $t11 := guid::create($t7, $t10) on_abort goto L4 with $t8 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:685:20+50
    call $t11,$t10 := $1_guid_create($t7, $t10);
    if ($abort_flag) {
        assume {:print "$at(81,38975,39025)"} true;
        $t8 := $abort_code;
        assume {:print "$track_abort(21,6):", $t8} $t8 == $t8;
        goto L4;
    }

    // write_back[Reference($t9).guid_creation_num (u64)]($t10) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:685:20+50
    $t9 := $UpdateMutation($t9, $Update'$1_account_Account'_guid_creation_num($Dereference($t9), $Dereference($t10)));

    // trace_local[guid]($t11) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:685:13+4
    assume {:print "$track_local(21,6,3):", $t11} $t11 == $t11;

    // $t12 := get_field<account::Account>.guid_creation_num($t9) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:687:13+25
    assume {:print "$at(81,39056,39081)"} true;
    $t12 := $Dereference($t9)->$guid_creation_num;

    // pack_ref_deep($t9) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:687:13+25

    // write_back[account::Account@]($t9) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:687:13+25
    $1_account_Account_$memory := $ResourceUpdate($1_account_Account_$memory, $GlobalLocationAddress($t9),
        $Dereference($t9));

    // $t13 := 1125899906842624 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:687:41+21
    $t13 := 1125899906842624;
    assume $IsValid'u64'($t13);

    // $t14 := <($t12, $t13) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:687:39+1
    call $t14 := $Lt($t12, $t13);

    // if ($t14) goto L1 else goto L0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:686:9+147
    assume {:print "$at(81,39035,39182)"} true;
    if ($t14) { goto L1; } else { goto L0; }

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:686:9+147
L1:

    // goto L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:686:9+147
    assume {:print "$at(81,39035,39182)"} true;
    goto L2;

    // label L0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:688:33+31
    assume {:print "$at(81,39139,39170)"} true;
L0:

    // $t15 := 20 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:688:33+31
    assume {:print "$at(81,39139,39170)"} true;
    $t15 := 20;
    assume $IsValid'u64'($t15);

    // $t16 := error::out_of_range($t15) on_abort goto L4 with $t8 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:688:13+52
    call $t16 := $1_error_out_of_range($t15);
    if ($abort_flag) {
        assume {:print "$at(81,39119,39171)"} true;
        $t8 := $abort_code;
        assume {:print "$track_abort(21,6):", $t8} $t8 == $t8;
        goto L4;
    }

    // trace_abort($t16) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:686:9+147
    assume {:print "$at(81,39035,39182)"} true;
    assume {:print "$track_abort(21,6):", $t16} $t16 == $t16;

    // $t8 := move($t16) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:686:9+147
    $t8 := $t16;

    // goto L4 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:686:9+147
    goto L4;

    // label L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:690:9+4
    assume {:print "$at(81,39192,39196)"} true;
L2:

    // trace_return[0]($t11) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:690:9+4
    assume {:print "$at(81,39192,39196)"} true;
    assume {:print "$track_return(21,6,0):", $t11} $t11 == $t11;

    // label L3 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:691:5+1
    assume {:print "$at(81,39201,39202)"} true;
L3:

    // return $t11 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:691:5+1
    assume {:print "$at(81,39201,39202)"} true;
    $ret0 := $t11;
    return;

    // label L4 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:691:5+1
L4:

    // abort($t8) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:691:5+1
    assume {:print "$at(81,39201,39202)"} true;
    $abort_code := $t8;
    $abort_flag := true;
    return;

}

// fun account::create_resource_account [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:630:5+1378
procedure {:inline 1} $1_account_create_resource_account(_$t0: $signer, _$t1: Vec (int)) returns ($ret0: $signer, $ret1: $1_account_SignerCapability)
{
    // declare local variables
    var $t2: int;
    var $t3: $signer;
    var $t4: $1_account_Account;
    var $t5: $Mutation ($1_account_Account);
    var $t6: $signer;
    var $t7: int;
    var $t8: $1_account_SignerCapability;
    var $t9: int;
    var $t10: int;
    var $t11: $1_account_Account;
    var $t12: Vec (int);
    var $t13: int;
    var $t14: int;
    var $t15: int;
    var $t16: bool;
    var $t17: $1_account_Account;
    var $t18: $1_account_CapabilityOffer'$1_account_SignerCapability';
    var $t19: $1_option_Option'address';
    var $t20: bool;
    var $t21: int;
    var $t22: int;
    var $t23: int;
    var $t24: int;
    var $t25: bool;
    var $t26: int;
    var $t27: int;
    var $t28: Vec (int);
    var $t29: Vec (int);
    var $t30: int;
    var $t31: $Mutation ($1_account_Account);
    var $t32: $1_option_Option'address';
    var $t33: $Mutation ($1_account_CapabilityOffer'$1_account_SignerCapability');
    var $t34: $Mutation ($1_option_Option'address');
    var $t35: $1_account_SignerCapability;
    var $t0: $signer;
    var $t1: Vec (int);
    var $temp_0'$1_account_Account': $1_account_Account;
    var $temp_0'$1_account_SignerCapability': $1_account_SignerCapability;
    var $temp_0'address': int;
    var $temp_0'signer': $signer;
    var $temp_0'vec'u8'': Vec (int);
    $t0 := _$t0;
    $t1 := _$t1;

    // bytecode translation starts here
    // assume Identical($t9, signer::$address_of($t0)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:450:9+45
    assume {:print "$at(82,22000,22045)"} true;
    assume ($t9 == $1_signer_$address_of($t0));

    // assume Identical($t10, account::spec_create_resource_address($t9, $t1)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:451:9+68
    assume {:print "$at(82,22054,22122)"} true;
    assume ($t10 == $1_account_spec_create_resource_address($t9, $t1));

    // assume Identical($t11, global<account::Account>($t10)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:524:9+45
    assume {:print "$at(82,25038,25083)"} true;
    assume ($t11 == $ResourceValue($1_account_Account_$memory, $t10));

    // assume Identical($t12, bcs::$to_bytes<address>($t10)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:54:9+45
    assume {:print "$at(82,2155,2200)"} true;
    assume ($t12 == $1_bcs_$to_bytes'address'($t10));

    // trace_local[source]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:630:5+1
    assume {:print "$at(81,36461,36462)"} true;
    assume {:print "$track_local(21,7,0):", $t0} $t0 == $t0;

    // trace_local[seed]($t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:630:5+1
    assume {:print "$track_local(21,7,1):", $t1} $t1 == $t1;

    // $t13 := signer::address_of($t0) on_abort goto L10 with $t14 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:631:54+26
    assume {:print "$at(81,36631,36657)"} true;
    call $t13 := $1_signer_address_of($t0);
    if ($abort_flag) {
        assume {:print "$at(81,36631,36657)"} true;
        $t14 := $abort_code;
        assume {:print "$track_abort(21,7):", $t14} $t14 == $t14;
        goto L10;
    }

    // $t15 := opaque begin: account::create_resource_address($t13, $t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:631:29+58

    // assume WellFormed($t15) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:631:29+58
    assume $IsValid'address'($t15);

    // assume Eq<address>($t15, account::spec_create_resource_address($t13, $t1)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:631:29+58
    assume $IsEqual'address'($t15, $1_account_spec_create_resource_address($t13, $t1));

    // $t15 := opaque end: account::create_resource_address($t13, $t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:631:29+58

    // trace_local[resource_addr]($t15) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:631:13+13
    assume {:print "$track_local(21,7,7):", $t15} $t15 == $t15;

    // $t16 := account::exists_at($t15) on_abort goto L10 with $t14 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:632:28+24
    assume {:print "$at(81,36693,36717)"} true;
    call $t16 := $1_account_exists_at($t15);
    if ($abort_flag) {
        assume {:print "$at(81,36693,36717)"} true;
        $t14 := $abort_code;
        assume {:print "$track_abort(21,7):", $t14} $t14 == $t14;
        goto L10;
    }

    // if ($t16) goto L1 else goto L0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:632:24+532
    if ($t16) { goto L1; } else { goto L0; }

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:633:50+13
    assume {:print "$at(81,36770,36783)"} true;
L1:

    // $t17 := get_global<account::Account>($t15) on_abort goto L10 with $t14 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:633:27+13
    assume {:print "$at(81,36747,36760)"} true;
    if (!$ResourceExists($1_account_Account_$memory, $t15)) {
        call $ExecFailureAbort();
    } else {
        $t17 := $ResourceValue($1_account_Account_$memory, $t15);
    }
    if ($abort_flag) {
        assume {:print "$at(81,36747,36760)"} true;
        $t14 := $abort_code;
        assume {:print "$track_abort(21,7):", $t14} $t14 == $t14;
        goto L10;
    }

    // trace_local[account]($t17) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:633:17+7
    assume {:print "$track_local(21,7,4):", $t17} $t17 == $t17;

    // $t18 := get_field<account::Account>.signer_capability_offer($t17) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:635:34+31
    assume {:print "$at(81,36840,36871)"} true;
    $t18 := $t17->$signer_capability_offer;

    // $t19 := get_field<account::CapabilityOffer<account::SignerCapability>>.for($t18) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:635:33+36
    $t19 := $t18->$for;

    // $t20 := opaque begin: option::is_none<address>($t19) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:635:17+53

    // assume WellFormed($t20) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:635:17+53
    assume $IsValid'bool'($t20);

    // assume Eq<bool>($t20, option::spec_is_none<address>($t19)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:635:17+53
    assume $IsEqual'bool'($t20, $1_option_spec_is_none'address'($t19));

    // $t20 := opaque end: option::is_none<address>($t19) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:635:17+53

    // if ($t20) goto L3 else goto L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:634:13+159
    assume {:print "$at(81,36798,36957)"} true;
    if ($t20) { goto L3; } else { goto L2; }

    // label L3 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:634:13+159
L3:

    // goto L4 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:634:13+159
    assume {:print "$at(81,36798,36957)"} true;
    goto L4;

    // label L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:634:13+159
L2:

    // $t21 := 15 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:636:39+25
    assume {:print "$at(81,36916,36941)"} true;
    $t21 := 15;
    assume $IsValid'u64'($t21);

    // $t22 := error::already_exists($t21) on_abort goto L10 with $t14 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:636:17+48
    call $t22 := $1_error_already_exists($t21);
    if ($abort_flag) {
        assume {:print "$at(81,36894,36942)"} true;
        $t14 := $abort_code;
        assume {:print "$track_abort(21,7):", $t14} $t14 == $t14;
        goto L10;
    }

    // trace_abort($t22) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:634:13+159
    assume {:print "$at(81,36798,36957)"} true;
    assume {:print "$track_abort(21,7):", $t22} $t22 == $t22;

    // $t14 := move($t22) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:634:13+159
    $t14 := $t22;

    // goto L10 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:634:13+159
    goto L10;

    // label L4 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:639:17+7
    assume {:print "$at(81,36996,37003)"} true;
L4:

    // $t23 := get_field<account::Account>.sequence_number($t17) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:639:17+23
    assume {:print "$at(81,36996,37019)"} true;
    $t23 := $t17->$sequence_number;

    // $t24 := 0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:639:44+1
    $t24 := 0;
    assume $IsValid'u64'($t24);

    // $t25 := ==($t23, $t24) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:639:41+2
    $t25 := $IsEqual'u64'($t23, $t24);

    // if ($t25) goto L6 else goto L5 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:638:13+129
    assume {:print "$at(81,36971,37100)"} true;
    if ($t25) { goto L6; } else { goto L5; }

    // label L6 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:638:13+129
L6:

    // goto L7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:638:13+129
    assume {:print "$at(81,36971,37100)"} true;
    goto L7;

    // label L5 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:640:38+21
    assume {:print "$at(81,37063,37084)"} true;
L5:

    // $t26 := 16 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:640:38+21
    assume {:print "$at(81,37063,37084)"} true;
    $t26 := 16;
    assume $IsValid'u64'($t26);

    // $t27 := error::invalid_state($t26) on_abort goto L10 with $t14 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:640:17+43
    call $t27 := $1_error_invalid_state($t26);
    if ($abort_flag) {
        assume {:print "$at(81,37042,37085)"} true;
        $t14 := $abort_code;
        assume {:print "$track_abort(21,7):", $t14} $t14 == $t14;
        goto L10;
    }

    // trace_abort($t27) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:638:13+129
    assume {:print "$at(81,36971,37100)"} true;
    assume {:print "$track_abort(21,7):", $t27} $t27 == $t27;

    // $t14 := move($t27) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:638:13+129
    $t14 := $t27;

    // goto L10 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:638:13+129
    goto L10;

    // label L7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:642:27+13
    assume {:print "$at(81,37128,37141)"} true;
L7:

    // $t3 := opaque begin: create_signer::create_signer($t15) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:642:13+28
    assume {:print "$at(81,37114,37142)"} true;

    // assume WellFormed($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:642:13+28
    assume $IsValid'signer'($t3) && $1_signer_is_txn_signer($t3) && $1_signer_is_txn_signer_addr($t3->$addr);

    // assume Eq<address>(signer::$address_of($t3), $t15) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:642:13+28
    assume $IsEqual'address'($1_signer_$address_of($t3), $t15);

    // $t3 := opaque end: create_signer::create_signer($t15) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:642:13+28

    // goto L8 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:632:24+532
    assume {:print "$at(81,36689,37221)"} true;
    goto L8;

    // label L0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:644:38+13
    assume {:print "$at(81,37197,37210)"} true;
L0:

    // assume Identical($t28, bcs::$to_bytes<address>($t15)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:54:9+45
    assume {:print "$at(82,2155,2200)"} true;
    assume ($t28 == $1_bcs_$to_bytes'address'($t15));

    // $t3 := account::create_account_unchecked($t15) on_abort goto L10 with $t14 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:644:13+39
    assume {:print "$at(81,37172,37211)"} true;
    call $t3 := $1_account_create_account_unchecked($t15);
    if ($abort_flag) {
        assume {:print "$at(81,37172,37211)"} true;
        $t14 := $abort_code;
        assume {:print "$track_abort(21,7):", $t14} $t14 == $t14;
        goto L10;
    }

    // label L8 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:632:24+532
    assume {:print "$at(81,36689,37221)"} true;
L8:

    // trace_local[resource]($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:632:13+8
    assume {:print "$at(81,36678,36686)"} true;
    assume {:print "$track_local(21,7,6):", $t3} $t3 == $t3;

    // $t29 := [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:650:55+13
    assume {:print "$at(81,37576,37589)"} true;
    $t29 := ConcatVec(ConcatVec(ConcatVec(ConcatVec(ConcatVec(ConcatVec(ConcatVec(MakeVec4(0, 0, 0, 0), MakeVec4(0, 0, 0, 0)), MakeVec4(0, 0, 0, 0)), MakeVec4(0, 0, 0, 0)), MakeVec4(0, 0, 0, 0)), MakeVec4(0, 0, 0, 0)), MakeVec4(0, 0, 0, 0)), MakeVec4(0, 0, 0, 0));
    assume $IsValid'vec'u8''($t29);

    // assume Identical($t30, signer::$address_of($t3)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:89:9+39
    assume {:print "$at(82,3568,3607)"} true;
    assume ($t30 == $1_signer_$address_of($t3));

    // account::rotate_authentication_key_internal($t3, $t29) on_abort goto L10 with $t14 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:650:9+60
    assume {:print "$at(81,37530,37590)"} true;
    call $1_account_rotate_authentication_key_internal($t3, $t29);
    if ($abort_flag) {
        assume {:print "$at(81,37530,37590)"} true;
        $t14 := $abort_code;
        assume {:print "$track_abort(21,7):", $t14} $t14 == $t14;
        goto L10;
    }

    // $t31 := borrow_global<account::Account>($t15) on_abort goto L10 with $t14 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:652:23+17
    assume {:print "$at(81,37615,37632)"} true;
    if (!$ResourceExists($1_account_Account_$memory, $t15)) {
        call $ExecFailureAbort();
    } else {
        $t31 := $Mutation($Global($t15), EmptyVec(), $ResourceValue($1_account_Account_$memory, $t15));
    }
    if ($abort_flag) {
        assume {:print "$at(81,37615,37632)"} true;
        $t14 := $abort_code;
        assume {:print "$track_abort(21,7):", $t14} $t14 == $t14;
        goto L10;
    }

    // trace_local[account#3]($t31) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:652:13+7
    $temp_0'$1_account_Account' := $Dereference($t31);
    assume {:print "$track_local(21,7,5):", $temp_0'$1_account_Account'} $temp_0'$1_account_Account' == $temp_0'$1_account_Account';

    // $t32 := opaque begin: option::some<address>($t15) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:653:47+27
    assume {:print "$at(81,37704,37731)"} true;

    // assume And(WellFormed($t32), Le(Len<address>(select option::Option.vec($t32)), 1)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:653:47+27
    assume ($IsValid'$1_option_Option'address''($t32) && (LenVec($t32->$vec) <= 1));

    // assume Eq<option::Option<address>>($t32, option::spec_some<address>($t15)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:653:47+27
    assume $IsEqual'$1_option_Option'address''($t32, $1_option_spec_some'address'($t15));

    // $t32 := opaque end: option::some<address>($t15) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:653:47+27

    // $t33 := borrow_field<account::Account>.signer_capability_offer($t31) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:653:9+31
    $t33 := $ChildMutation($t31, 6, $Dereference($t31)->$signer_capability_offer);

    // $t34 := borrow_field<account::CapabilityOffer<account::SignerCapability>>.for($t33) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:653:9+35
    $t34 := $ChildMutation($t33, 0, $Dereference($t33)->$for);

    // write_ref($t34, $t32) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:653:9+65
    $t34 := $UpdateMutation($t34, $t32);

    // write_back[Reference($t33).for (option::Option<address>)]($t34) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:653:9+65
    $t33 := $UpdateMutation($t33, $Update'$1_account_CapabilityOffer'$1_account_SignerCapability''_for($Dereference($t33), $Dereference($t34)));

    // write_back[Reference($t31).signer_capability_offer (account::CapabilityOffer<account::SignerCapability>)]($t33) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:653:9+65
    $t31 := $UpdateMutation($t31, $Update'$1_account_Account'_signer_capability_offer($Dereference($t31), $Dereference($t33)));

    // pack_ref_deep($t31) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:653:9+65

    // write_back[account::Account@]($t31) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:653:9+65
    $1_account_Account_$memory := $ResourceUpdate($1_account_Account_$memory, $GlobalLocationAddress($t31),
        $Dereference($t31));

    // $t35 := pack account::SignerCapability($t15) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:654:26+43
    assume {:print "$at(81,37758,37801)"} true;
    $t35 := $1_account_SignerCapability($t15);

    // trace_local[signer_cap]($t35) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:654:13+10
    assume {:print "$track_local(21,7,8):", $t35} $t35 == $t35;

    // trace_return[0]($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:655:9+22
    assume {:print "$at(81,37811,37833)"} true;
    assume {:print "$track_return(21,7,0):", $t3} $t3 == $t3;

    // trace_return[1]($t35) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:655:9+22
    assume {:print "$track_return(21,7,1):", $t35} $t35 == $t35;

    // label L9 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:656:5+1
    assume {:print "$at(81,37838,37839)"} true;
L9:

    // return ($t3, $t35) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:656:5+1
    assume {:print "$at(81,37838,37839)"} true;
    $ret0 := $t3;
    $ret1 := $t35;
    return;

    // label L10 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:656:5+1
L10:

    // abort($t14) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:656:5+1
    assume {:print "$at(81,37838,37839)"} true;
    $abort_code := $t14;
    $abort_flag := true;
    return;

}

// fun account::create_signer_with_capability [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:735:5+156
procedure {:inline 1} $1_account_create_signer_with_capability(_$t0: $1_account_SignerCapability) returns ($ret0: $signer)
{
    // declare local variables
    var $t1: int;
    var $t2: int;
    var $t3: $signer;
    var $t0: $1_account_SignerCapability;
    var $temp_0'$1_account_SignerCapability': $1_account_SignerCapability;
    var $temp_0'signer': $signer;
    $t0 := _$t0;

    // bytecode translation starts here
    // assume Identical($t1, select account::SignerCapability.account($t0)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:518:9+30
    assume {:print "$at(82,24860,24890)"} true;
    assume ($t1 == $t0->$account);

    // trace_local[capability]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:735:5+1
    assume {:print "$at(81,41007,41008)"} true;
    assume {:print "$track_local(21,9,0):", $t0} $t0 == $t0;

    // $t2 := get_field<account::SignerCapability>.account($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:736:20+19
    assume {:print "$at(81,41108,41127)"} true;
    $t2 := $t0->$account;

    // $t3 := opaque begin: create_signer::create_signer($t2) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:737:9+20
    assume {:print "$at(81,41137,41157)"} true;

    // assume WellFormed($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:737:9+20
    assume $IsValid'signer'($t3) && $1_signer_is_txn_signer($t3) && $1_signer_is_txn_signer_addr($t3->$addr);

    // assume Eq<address>(signer::$address_of($t3), $t2) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:737:9+20
    assume $IsEqual'address'($1_signer_$address_of($t3), $t2);

    // $t3 := opaque end: create_signer::create_signer($t2) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:737:9+20

    // trace_return[0]($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:737:9+20
    assume {:print "$track_return(21,9,0):", $t3} $t3 == $t3;

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:738:5+1
    assume {:print "$at(81,41162,41163)"} true;
L1:

    // return $t3 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:738:5+1
    assume {:print "$at(81,41162,41163)"} true;
    $ret0 := $t3;
    return;

}

// fun account::exists_at [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:231:5+79
procedure {:inline 1} $1_account_exists_at(_$t0: int) returns ($ret0: bool)
{
    // declare local variables
    var $t1: bool;
    var $t0: int;
    var $temp_0'address': int;
    var $temp_0'bool': bool;
    $t0 := _$t0;

    // bytecode translation starts here
    // trace_local[addr]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:231:5+1
    assume {:print "$at(81,11594,11595)"} true;
    assume {:print "$track_local(21,10,0):", $t0} $t0 == $t0;

    // $t1 := exists<account::Account>($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:232:9+6
    assume {:print "$at(81,11646,11652)"} true;
    $t1 := $ResourceExists($1_account_Account_$memory, $t0);

    // trace_return[0]($t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:232:9+21
    assume {:print "$track_return(21,10,0):", $t1} $t1 == $t1;

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:233:5+1
    assume {:print "$at(81,11672,11673)"} true;
L1:

    // return $t1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:233:5+1
    assume {:print "$at(81,11672,11673)"} true;
    $ret0 := $t1;
    return;

}

// fun account::register_coin<aptos_coin::AptosCoin> [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:705:5+364
procedure {:inline 1} $1_account_register_coin'$1_aptos_coin_AptosCoin'(_$t0: int) returns ()
{
    // declare local variables
    var $t1: $Mutation ($1_account_Account);
    var $t2: int;
    var $t3: $Mutation ($1_event_EventHandle'$1_account_CoinRegisterEvent');
    var $t4: $1_type_info_TypeInfo;
    var $t5: $1_account_CoinRegisterEvent;
    var $t0: int;
    var $1_account_Account_$modifies: [int]bool;
    var $temp_0'address': int;
    $t0 := _$t0;

    // bytecode translation starts here
    // trace_local[account_addr]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:705:5+1
    assume {:print "$at(81,39759,39760)"} true;
    assume {:print "$track_local(21,24,0):", $t0} $t0 == $t0;

    // $t1 := borrow_global<account::Account>($t0) on_abort goto L2 with $t2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:706:23+17
    assume {:print "$at(81,39866,39883)"} true;
    if (!$ResourceExists($1_account_Account_$memory, $t0)) {
        call $ExecFailureAbort();
    } else {
        $t1 := $Mutation($Global($t0), EmptyVec(), $ResourceValue($1_account_Account_$memory, $t0));
    }
    if ($abort_flag) {
        assume {:print "$at(81,39866,39883)"} true;
        $t2 := $abort_code;
        assume {:print "$track_abort(21,24):", $t2} $t2 == $t2;
        goto L2;
    }

    // $t3 := borrow_field<account::Account>.coin_register_events($t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:708:13+33
    assume {:print "$at(81,39966,39999)"} true;
    $t3 := $ChildMutation($t1, 3, $Dereference($t1)->$coin_register_events);

    // $t4 := type_info::type_of<#0>() on_abort goto L2 with $t2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:710:28+30
    assume {:print "$at(81,40060,40090)"} true;
    if (!true) {
        call $ExecFailureAbort();
    }
    else {
        $t4 := $1_type_info_TypeInfo(1, Vec(DefaultVecMap()[0 := 97][1 := 112][2 := 116][3 := 111][4 := 115][5 := 95][6 := 99][7 := 111][8 := 105][9 := 110], 10), Vec(DefaultVecMap()[0 := 65][1 := 112][2 := 116][3 := 111][4 := 115][5 := 67][6 := 111][7 := 105][8 := 110], 9));
    }
    if ($abort_flag) {
        assume {:print "$at(81,40060,40090)"} true;
        $t2 := $abort_code;
        assume {:print "$track_abort(21,24):", $t2} $t2 == $t2;
        goto L2;
    }

    // $t5 := pack account::CoinRegisterEvent($t4) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:709:13+92
    assume {:print "$at(81,40013,40105)"} true;
    $t5 := $1_account_CoinRegisterEvent($t4);

    // opaque begin: event::emit_event<account::CoinRegisterEvent>($t3, $t5) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:707:9+200
    assume {:print "$at(81,39916,40116)"} true;

    // opaque end: event::emit_event<account::CoinRegisterEvent>($t3, $t5) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:707:9+200

    // write_back[Reference($t1).coin_register_events (event::EventHandle<account::CoinRegisterEvent>)]($t3) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:707:9+200
    $t1 := $UpdateMutation($t1, $Update'$1_account_Account'_coin_register_events($Dereference($t1), $Dereference($t3)));

    // pack_ref_deep($t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:707:9+200

    // write_back[account::Account@]($t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:707:9+200
    $1_account_Account_$memory := $ResourceUpdate($1_account_Account_$memory, $GlobalLocationAddress($t1),
        $Dereference($t1));

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:713:5+1
    assume {:print "$at(81,40122,40123)"} true;
L1:

    // return () at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:713:5+1
    assume {:print "$at(81,40122,40123)"} true;
    return;

    // label L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:713:5+1
L2:

    // abort($t2) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:713:5+1
    assume {:print "$at(81,40122,40123)"} true;
    $abort_code := $t2;
    $abort_flag := true;
    return;

}

// fun account::rotate_authentication_key_internal [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:263:5+516
procedure {:inline 1} $1_account_rotate_authentication_key_internal(_$t0: $signer, _$t1: Vec (int)) returns ()
{
    // declare local variables
    var $t2: $Mutation ($1_account_Account);
    var $t3: int;
    var $t4: int;
    var $t5: int;
    var $t6: int;
    var $t7: bool;
    var $t8: int;
    var $t9: int;
    var $t10: int;
    var $t11: int;
    var $t12: bool;
    var $t13: int;
    var $t14: int;
    var $t15: $Mutation ($1_account_Account);
    var $t16: $Mutation (Vec (int));
    var $t0: $signer;
    var $t1: Vec (int);
    var $1_account_Account_$modifies: [int]bool;
    var $temp_0'$1_account_Account': $1_account_Account;
    var $temp_0'address': int;
    var $temp_0'signer': $signer;
    var $temp_0'vec'u8'': Vec (int);
    $t0 := _$t0;
    $t1 := _$t1;

    // bytecode translation starts here
    // assume Identical($t4, signer::$address_of($t0)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:89:9+39
    assume {:print "$at(82,3568,3607)"} true;
    assume ($t4 == $1_signer_$address_of($t0));

    // trace_local[account]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:263:5+1
    assume {:print "$at(81,12652,12653)"} true;
    assume {:print "$track_local(21,30,0):", $t0} $t0 == $t0;

    // trace_local[new_auth_key]($t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:263:5+1
    assume {:print "$track_local(21,30,1):", $t1} $t1 == $t1;

    // $t5 := signer::address_of($t0) on_abort goto L7 with $t6 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:264:20+27
    assume {:print "$at(81,12788,12815)"} true;
    call $t5 := $1_signer_address_of($t0);
    if ($abort_flag) {
        assume {:print "$at(81,12788,12815)"} true;
        $t6 := $abort_code;
        assume {:print "$track_abort(21,30):", $t6} $t6 == $t6;
        goto L7;
    }

    // trace_local[addr]($t5) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:264:13+4
    assume {:print "$track_local(21,30,3):", $t5} $t5 == $t5;

    // $t7 := account::exists_at($t5) on_abort goto L7 with $t6 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:265:17+15
    assume {:print "$at(81,12833,12848)"} true;
    call $t7 := $1_account_exists_at($t5);
    if ($abort_flag) {
        assume {:print "$at(81,12833,12848)"} true;
        $t6 := $abort_code;
        assume {:print "$track_abort(21,30):", $t6} $t6 == $t6;
        goto L7;
    }

    // if ($t7) goto L1 else goto L0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:265:9+67
    if ($t7) { goto L1; } else { goto L0; }

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:265:9+67
L1:

    // goto L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:265:9+67
    assume {:print "$at(81,12825,12892)"} true;
    goto L2;

    // label L0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:265:51+23
L0:

    // $t8 := 2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:265:51+23
    assume {:print "$at(81,12867,12890)"} true;
    $t8 := 2;
    assume $IsValid'u64'($t8);

    // $t9 := error::not_found($t8) on_abort goto L7 with $t6 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:265:34+41
    call $t9 := $1_error_not_found($t8);
    if ($abort_flag) {
        assume {:print "$at(81,12850,12891)"} true;
        $t6 := $abort_code;
        assume {:print "$track_abort(21,30):", $t6} $t6 == $t6;
        goto L7;
    }

    // trace_abort($t9) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:265:9+67
    assume {:print "$at(81,12825,12892)"} true;
    assume {:print "$track_abort(21,30):", $t9} $t9 == $t9;

    // $t6 := move($t9) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:265:9+67
    $t6 := $t9;

    // goto L7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:265:9+67
    goto L7;

    // label L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:267:28+13
    assume {:print "$at(81,12938,12951)"} true;
L2:

    // $t10 := vector::length<u8>($t1) on_abort goto L7 with $t6 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:267:13+29
    assume {:print "$at(81,12923,12952)"} true;
    call $t10 := $1_vector_length'u8'($t1);
    if ($abort_flag) {
        assume {:print "$at(81,12923,12952)"} true;
        $t6 := $abort_code;
        assume {:print "$track_abort(21,30):", $t6} $t6 == $t6;
        goto L7;
    }

    // $t11 := 32 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:267:46+2
    $t11 := 32;
    assume $IsValid'u64'($t11);

    // $t12 := ==($t10, $t11) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:267:43+2
    $t12 := $IsEqual'u64'($t10, $t11);

    // if ($t12) goto L4 else goto L3 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:266:9+134
    assume {:print "$at(81,12902,13036)"} true;
    if ($t12) { goto L4; } else { goto L3; }

    // label L4 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:266:9+134
L4:

    // goto L5 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:266:9+134
    assume {:print "$at(81,12902,13036)"} true;
    goto L5;

    // label L3 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:268:37+29
    assume {:print "$at(81,12996,13025)"} true;
L3:

    // $t13 := 4 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:268:37+29
    assume {:print "$at(81,12996,13025)"} true;
    $t13 := 4;
    assume $IsValid'u64'($t13);

    // $t14 := error::invalid_argument($t13) on_abort goto L7 with $t6 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:268:13+54
    call $t14 := $1_error_invalid_argument($t13);
    if ($abort_flag) {
        assume {:print "$at(81,12972,13026)"} true;
        $t6 := $abort_code;
        assume {:print "$track_abort(21,30):", $t6} $t6 == $t6;
        goto L7;
    }

    // trace_abort($t14) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:266:9+134
    assume {:print "$at(81,12902,13036)"} true;
    assume {:print "$track_abort(21,30):", $t14} $t14 == $t14;

    // $t6 := move($t14) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:266:9+134
    $t6 := $t14;

    // goto L7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:266:9+134
    goto L7;

    // label L5 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:270:59+4
    assume {:print "$at(81,13096,13100)"} true;
L5:

    // $t15 := borrow_global<account::Account>($t5) on_abort goto L7 with $t6 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:270:32+17
    assume {:print "$at(81,13069,13086)"} true;
    if (!$ResourceExists($1_account_Account_$memory, $t5)) {
        call $ExecFailureAbort();
    } else {
        $t15 := $Mutation($Global($t5), EmptyVec(), $ResourceValue($1_account_Account_$memory, $t5));
    }
    if ($abort_flag) {
        assume {:print "$at(81,13069,13086)"} true;
        $t6 := $abort_code;
        assume {:print "$track_abort(21,30):", $t6} $t6 == $t6;
        goto L7;
    }

    // trace_local[account_resource]($t15) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:270:13+16
    $temp_0'$1_account_Account' := $Dereference($t15);
    assume {:print "$track_local(21,30,2):", $temp_0'$1_account_Account'} $temp_0'$1_account_Account' == $temp_0'$1_account_Account';

    // $t16 := borrow_field<account::Account>.authentication_key($t15) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:271:9+35
    assume {:print "$at(81,13111,13146)"} true;
    $t16 := $ChildMutation($t15, 0, $Dereference($t15)->$authentication_key);

    // write_ref($t16, $t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:271:9+50
    $t16 := $UpdateMutation($t16, $t1);

    // write_back[Reference($t15).authentication_key (vector<u8>)]($t16) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:271:9+50
    $t15 := $UpdateMutation($t15, $Update'$1_account_Account'_authentication_key($Dereference($t15), $Dereference($t16)));

    // pack_ref_deep($t15) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:271:9+50

    // write_back[account::Account@]($t15) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:271:9+50
    $1_account_Account_$memory := $ResourceUpdate($1_account_Account_$memory, $GlobalLocationAddress($t15),
        $Dereference($t15));

    // label L6 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:272:5+1
    assume {:print "$at(81,13167,13168)"} true;
L6:

    // return () at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:272:5+1
    assume {:print "$at(81,13167,13168)"} true;
    return;

    // label L7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:272:5+1
L7:

    // abort($t6) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.move:272:5+1
    assume {:print "$at(81,13167,13168)"} true;
    $abort_code := $t6;
    $abort_flag := true;
    return;

}

// struct coin::Coin<aptos_coin::AptosCoin> at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:74:5+112
datatype $1_coin_Coin'$1_aptos_coin_AptosCoin' {
    $1_coin_Coin'$1_aptos_coin_AptosCoin'($value: int)
}
function {:inline} $Update'$1_coin_Coin'$1_aptos_coin_AptosCoin''_value(s: $1_coin_Coin'$1_aptos_coin_AptosCoin', x: int): $1_coin_Coin'$1_aptos_coin_AptosCoin' {
    $1_coin_Coin'$1_aptos_coin_AptosCoin'(x)
}
function $IsValid'$1_coin_Coin'$1_aptos_coin_AptosCoin''(s: $1_coin_Coin'$1_aptos_coin_AptosCoin'): bool {
    $IsValid'u64'(s->$value)
}
function {:inline} $IsEqual'$1_coin_Coin'$1_aptos_coin_AptosCoin''(s1: $1_coin_Coin'$1_aptos_coin_AptosCoin', s2: $1_coin_Coin'$1_aptos_coin_AptosCoin'): bool {
    s1 == s2
}

// struct coin::Coin<#0> at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:74:5+112
datatype $1_coin_Coin'#0' {
    $1_coin_Coin'#0'($value: int)
}
function {:inline} $Update'$1_coin_Coin'#0''_value(s: $1_coin_Coin'#0', x: int): $1_coin_Coin'#0' {
    $1_coin_Coin'#0'(x)
}
function $IsValid'$1_coin_Coin'#0''(s: $1_coin_Coin'#0'): bool {
    $IsValid'u64'(s->$value)
}
function {:inline} $IsEqual'$1_coin_Coin'#0''(s1: $1_coin_Coin'#0', s2: $1_coin_Coin'#0'): bool {
    s1 == s2
}

// struct coin::CoinInfo<aptos_coin::AptosCoin> at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:109:5+564
datatype $1_coin_CoinInfo'$1_aptos_coin_AptosCoin' {
    $1_coin_CoinInfo'$1_aptos_coin_AptosCoin'($name: $1_string_String, $symbol: $1_string_String, $decimals: int, $supply: $1_option_Option'$1_optional_aggregator_OptionalAggregator')
}
function {:inline} $Update'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''_name(s: $1_coin_CoinInfo'$1_aptos_coin_AptosCoin', x: $1_string_String): $1_coin_CoinInfo'$1_aptos_coin_AptosCoin' {
    $1_coin_CoinInfo'$1_aptos_coin_AptosCoin'(x, s->$symbol, s->$decimals, s->$supply)
}
function {:inline} $Update'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''_symbol(s: $1_coin_CoinInfo'$1_aptos_coin_AptosCoin', x: $1_string_String): $1_coin_CoinInfo'$1_aptos_coin_AptosCoin' {
    $1_coin_CoinInfo'$1_aptos_coin_AptosCoin'(s->$name, x, s->$decimals, s->$supply)
}
function {:inline} $Update'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''_decimals(s: $1_coin_CoinInfo'$1_aptos_coin_AptosCoin', x: int): $1_coin_CoinInfo'$1_aptos_coin_AptosCoin' {
    $1_coin_CoinInfo'$1_aptos_coin_AptosCoin'(s->$name, s->$symbol, x, s->$supply)
}
function {:inline} $Update'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''_supply(s: $1_coin_CoinInfo'$1_aptos_coin_AptosCoin', x: $1_option_Option'$1_optional_aggregator_OptionalAggregator'): $1_coin_CoinInfo'$1_aptos_coin_AptosCoin' {
    $1_coin_CoinInfo'$1_aptos_coin_AptosCoin'(s->$name, s->$symbol, s->$decimals, x)
}
function $IsValid'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''(s: $1_coin_CoinInfo'$1_aptos_coin_AptosCoin'): bool {
    $IsValid'$1_string_String'(s->$name)
      && $IsValid'$1_string_String'(s->$symbol)
      && $IsValid'u8'(s->$decimals)
      && $IsValid'$1_option_Option'$1_optional_aggregator_OptionalAggregator''(s->$supply)
}
function {:inline} $IsEqual'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''(s1: $1_coin_CoinInfo'$1_aptos_coin_AptosCoin', s2: $1_coin_CoinInfo'$1_aptos_coin_AptosCoin'): bool {
    $IsEqual'$1_string_String'(s1->$name, s2->$name)
    && $IsEqual'$1_string_String'(s1->$symbol, s2->$symbol)
    && $IsEqual'u8'(s1->$decimals, s2->$decimals)
    && $IsEqual'$1_option_Option'$1_optional_aggregator_OptionalAggregator''(s1->$supply, s2->$supply)}
var $1_coin_CoinInfo'$1_aptos_coin_AptosCoin'_$memory: $Memory $1_coin_CoinInfo'$1_aptos_coin_AptosCoin';

// struct coin::CoinInfo<#0> at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:109:5+564
datatype $1_coin_CoinInfo'#0' {
    $1_coin_CoinInfo'#0'($name: $1_string_String, $symbol: $1_string_String, $decimals: int, $supply: $1_option_Option'$1_optional_aggregator_OptionalAggregator')
}
function {:inline} $Update'$1_coin_CoinInfo'#0''_name(s: $1_coin_CoinInfo'#0', x: $1_string_String): $1_coin_CoinInfo'#0' {
    $1_coin_CoinInfo'#0'(x, s->$symbol, s->$decimals, s->$supply)
}
function {:inline} $Update'$1_coin_CoinInfo'#0''_symbol(s: $1_coin_CoinInfo'#0', x: $1_string_String): $1_coin_CoinInfo'#0' {
    $1_coin_CoinInfo'#0'(s->$name, x, s->$decimals, s->$supply)
}
function {:inline} $Update'$1_coin_CoinInfo'#0''_decimals(s: $1_coin_CoinInfo'#0', x: int): $1_coin_CoinInfo'#0' {
    $1_coin_CoinInfo'#0'(s->$name, s->$symbol, x, s->$supply)
}
function {:inline} $Update'$1_coin_CoinInfo'#0''_supply(s: $1_coin_CoinInfo'#0', x: $1_option_Option'$1_optional_aggregator_OptionalAggregator'): $1_coin_CoinInfo'#0' {
    $1_coin_CoinInfo'#0'(s->$name, s->$symbol, s->$decimals, x)
}
function $IsValid'$1_coin_CoinInfo'#0''(s: $1_coin_CoinInfo'#0'): bool {
    $IsValid'$1_string_String'(s->$name)
      && $IsValid'$1_string_String'(s->$symbol)
      && $IsValid'u8'(s->$decimals)
      && $IsValid'$1_option_Option'$1_optional_aggregator_OptionalAggregator''(s->$supply)
}
function {:inline} $IsEqual'$1_coin_CoinInfo'#0''(s1: $1_coin_CoinInfo'#0', s2: $1_coin_CoinInfo'#0'): bool {
    $IsEqual'$1_string_String'(s1->$name, s2->$name)
    && $IsEqual'$1_string_String'(s1->$symbol, s2->$symbol)
    && $IsEqual'u8'(s1->$decimals, s2->$decimals)
    && $IsEqual'$1_option_Option'$1_optional_aggregator_OptionalAggregator''(s1->$supply, s2->$supply)}
var $1_coin_CoinInfo'#0'_$memory: $Memory $1_coin_CoinInfo'#0';

// struct coin::CoinStore<aptos_coin::AptosCoin> at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:92:5+206
datatype $1_coin_CoinStore'$1_aptos_coin_AptosCoin' {
    $1_coin_CoinStore'$1_aptos_coin_AptosCoin'($coin: $1_coin_Coin'$1_aptos_coin_AptosCoin', $frozen: bool, $deposit_events: $1_event_EventHandle'$1_coin_DepositEvent', $withdraw_events: $1_event_EventHandle'$1_coin_WithdrawEvent')
}
function {:inline} $Update'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''_coin(s: $1_coin_CoinStore'$1_aptos_coin_AptosCoin', x: $1_coin_Coin'$1_aptos_coin_AptosCoin'): $1_coin_CoinStore'$1_aptos_coin_AptosCoin' {
    $1_coin_CoinStore'$1_aptos_coin_AptosCoin'(x, s->$frozen, s->$deposit_events, s->$withdraw_events)
}
function {:inline} $Update'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''_frozen(s: $1_coin_CoinStore'$1_aptos_coin_AptosCoin', x: bool): $1_coin_CoinStore'$1_aptos_coin_AptosCoin' {
    $1_coin_CoinStore'$1_aptos_coin_AptosCoin'(s->$coin, x, s->$deposit_events, s->$withdraw_events)
}
function {:inline} $Update'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''_deposit_events(s: $1_coin_CoinStore'$1_aptos_coin_AptosCoin', x: $1_event_EventHandle'$1_coin_DepositEvent'): $1_coin_CoinStore'$1_aptos_coin_AptosCoin' {
    $1_coin_CoinStore'$1_aptos_coin_AptosCoin'(s->$coin, s->$frozen, x, s->$withdraw_events)
}
function {:inline} $Update'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''_withdraw_events(s: $1_coin_CoinStore'$1_aptos_coin_AptosCoin', x: $1_event_EventHandle'$1_coin_WithdrawEvent'): $1_coin_CoinStore'$1_aptos_coin_AptosCoin' {
    $1_coin_CoinStore'$1_aptos_coin_AptosCoin'(s->$coin, s->$frozen, s->$deposit_events, x)
}
function $IsValid'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''(s: $1_coin_CoinStore'$1_aptos_coin_AptosCoin'): bool {
    $IsValid'$1_coin_Coin'$1_aptos_coin_AptosCoin''(s->$coin)
      && $IsValid'bool'(s->$frozen)
      && $IsValid'$1_event_EventHandle'$1_coin_DepositEvent''(s->$deposit_events)
      && $IsValid'$1_event_EventHandle'$1_coin_WithdrawEvent''(s->$withdraw_events)
}
function {:inline} $IsEqual'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''(s1: $1_coin_CoinStore'$1_aptos_coin_AptosCoin', s2: $1_coin_CoinStore'$1_aptos_coin_AptosCoin'): bool {
    s1 == s2
}
var $1_coin_CoinStore'$1_aptos_coin_AptosCoin'_$memory: $Memory $1_coin_CoinStore'$1_aptos_coin_AptosCoin';

// struct coin::CoinStore<#0> at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:92:5+206
datatype $1_coin_CoinStore'#0' {
    $1_coin_CoinStore'#0'($coin: $1_coin_Coin'#0', $frozen: bool, $deposit_events: $1_event_EventHandle'$1_coin_DepositEvent', $withdraw_events: $1_event_EventHandle'$1_coin_WithdrawEvent')
}
function {:inline} $Update'$1_coin_CoinStore'#0''_coin(s: $1_coin_CoinStore'#0', x: $1_coin_Coin'#0'): $1_coin_CoinStore'#0' {
    $1_coin_CoinStore'#0'(x, s->$frozen, s->$deposit_events, s->$withdraw_events)
}
function {:inline} $Update'$1_coin_CoinStore'#0''_frozen(s: $1_coin_CoinStore'#0', x: bool): $1_coin_CoinStore'#0' {
    $1_coin_CoinStore'#0'(s->$coin, x, s->$deposit_events, s->$withdraw_events)
}
function {:inline} $Update'$1_coin_CoinStore'#0''_deposit_events(s: $1_coin_CoinStore'#0', x: $1_event_EventHandle'$1_coin_DepositEvent'): $1_coin_CoinStore'#0' {
    $1_coin_CoinStore'#0'(s->$coin, s->$frozen, x, s->$withdraw_events)
}
function {:inline} $Update'$1_coin_CoinStore'#0''_withdraw_events(s: $1_coin_CoinStore'#0', x: $1_event_EventHandle'$1_coin_WithdrawEvent'): $1_coin_CoinStore'#0' {
    $1_coin_CoinStore'#0'(s->$coin, s->$frozen, s->$deposit_events, x)
}
function $IsValid'$1_coin_CoinStore'#0''(s: $1_coin_CoinStore'#0'): bool {
    $IsValid'$1_coin_Coin'#0''(s->$coin)
      && $IsValid'bool'(s->$frozen)
      && $IsValid'$1_event_EventHandle'$1_coin_DepositEvent''(s->$deposit_events)
      && $IsValid'$1_event_EventHandle'$1_coin_WithdrawEvent''(s->$withdraw_events)
}
function {:inline} $IsEqual'$1_coin_CoinStore'#0''(s1: $1_coin_CoinStore'#0', s2: $1_coin_CoinStore'#0'): bool {
    s1 == s2
}
var $1_coin_CoinStore'#0'_$memory: $Memory $1_coin_CoinStore'#0';

// struct coin::DepositEvent at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:123:5+64
datatype $1_coin_DepositEvent {
    $1_coin_DepositEvent($amount: int)
}
function {:inline} $Update'$1_coin_DepositEvent'_amount(s: $1_coin_DepositEvent, x: int): $1_coin_DepositEvent {
    $1_coin_DepositEvent(x)
}
function $IsValid'$1_coin_DepositEvent'(s: $1_coin_DepositEvent): bool {
    $IsValid'u64'(s->$amount)
}
function {:inline} $IsEqual'$1_coin_DepositEvent'(s1: $1_coin_DepositEvent, s2: $1_coin_DepositEvent): bool {
    s1 == s2
}

// struct coin::WithdrawEvent at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:128:5+65
datatype $1_coin_WithdrawEvent {
    $1_coin_WithdrawEvent($amount: int)
}
function {:inline} $Update'$1_coin_WithdrawEvent'_amount(s: $1_coin_WithdrawEvent, x: int): $1_coin_WithdrawEvent {
    $1_coin_WithdrawEvent(x)
}
function $IsValid'$1_coin_WithdrawEvent'(s: $1_coin_WithdrawEvent): bool {
    $IsValid'u64'(s->$amount)
}
function {:inline} $IsEqual'$1_coin_WithdrawEvent'(s1: $1_coin_WithdrawEvent, s2: $1_coin_WithdrawEvent): bool {
    s1 == s2
}

// struct coin::Ghost$supply<aptos_coin::AptosCoin> at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:4:9+29
datatype $1_coin_Ghost$supply'$1_aptos_coin_AptosCoin' {
    $1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'($v: int)
}
function {:inline} $Update'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''_v(s: $1_coin_Ghost$supply'$1_aptos_coin_AptosCoin', x: int): $1_coin_Ghost$supply'$1_aptos_coin_AptosCoin' {
    $1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'(x)
}
function $IsValid'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''(s: $1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'): bool {
    $IsValid'num'(s->$v)
}
function {:inline} $IsEqual'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''(s1: $1_coin_Ghost$supply'$1_aptos_coin_AptosCoin', s2: $1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'): bool {
    s1 == s2
}
var $1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'_$memory: $Memory $1_coin_Ghost$supply'$1_aptos_coin_AptosCoin';

// struct coin::Ghost$supply<#0> at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:4:9+29
datatype $1_coin_Ghost$supply'#0' {
    $1_coin_Ghost$supply'#0'($v: int)
}
function {:inline} $Update'$1_coin_Ghost$supply'#0''_v(s: $1_coin_Ghost$supply'#0', x: int): $1_coin_Ghost$supply'#0' {
    $1_coin_Ghost$supply'#0'(x)
}
function $IsValid'$1_coin_Ghost$supply'#0''(s: $1_coin_Ghost$supply'#0'): bool {
    $IsValid'num'(s->$v)
}
function {:inline} $IsEqual'$1_coin_Ghost$supply'#0''(s1: $1_coin_Ghost$supply'#0', s2: $1_coin_Ghost$supply'#0'): bool {
    s1 == s2
}
var $1_coin_Ghost$supply'#0'_$memory: $Memory $1_coin_Ghost$supply'#0';

// struct coin::Ghost$aggregate_supply<aptos_coin::AptosCoin> at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:5:9+39
datatype $1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin' {
    $1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'($v: int)
}
function {:inline} $Update'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''_v(s: $1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin', x: int): $1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin' {
    $1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'(x)
}
function $IsValid'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''(s: $1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'): bool {
    $IsValid'num'(s->$v)
}
function {:inline} $IsEqual'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''(s1: $1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin', s2: $1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'): bool {
    s1 == s2
}
var $1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'_$memory: $Memory $1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin';

// struct coin::Ghost$aggregate_supply<#0> at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:5:9+39
datatype $1_coin_Ghost$aggregate_supply'#0' {
    $1_coin_Ghost$aggregate_supply'#0'($v: int)
}
function {:inline} $Update'$1_coin_Ghost$aggregate_supply'#0''_v(s: $1_coin_Ghost$aggregate_supply'#0', x: int): $1_coin_Ghost$aggregate_supply'#0' {
    $1_coin_Ghost$aggregate_supply'#0'(x)
}
function $IsValid'$1_coin_Ghost$aggregate_supply'#0''(s: $1_coin_Ghost$aggregate_supply'#0'): bool {
    $IsValid'num'(s->$v)
}
function {:inline} $IsEqual'$1_coin_Ghost$aggregate_supply'#0''(s1: $1_coin_Ghost$aggregate_supply'#0', s2: $1_coin_Ghost$aggregate_supply'#0'): bool {
    s1 == s2
}
var $1_coin_Ghost$aggregate_supply'#0'_$memory: $Memory $1_coin_Ghost$aggregate_supply'#0';

// fun coin::extract<#0> [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:393:5+434
procedure {:inline 1} $1_coin_extract'#0'(_$t0: $Mutation ($1_coin_Coin'#0'), _$t1: int) returns ($ret0: $1_coin_Coin'#0', $ret1: $Mutation ($1_coin_Coin'#0'))
{
    // declare local variables
    var $t2: $1_option_Option'$1_optional_aggregator_OptionalAggregator';
    var $t3: int;
    var $t4: bool;
    var $t5: int;
    var $t6: int;
    var $t7: int;
    var $t8: $1_coin_Ghost$supply'#0';
    var $t9: int;
    var $t10: $Mutation ($1_coin_Ghost$supply'#0');
    var $t11: int;
    var $t12: int;
    var $t13: $Mutation (int);
    var $t14: $1_coin_Ghost$supply'#0';
    var $t15: int;
    var $t16: $Mutation ($1_coin_Ghost$supply'#0');
    var $t17: $1_coin_Coin'#0';
    var $t0: $Mutation ($1_coin_Coin'#0');
    var $t1: int;
    var $temp_0'$1_coin_Coin'#0'': $1_coin_Coin'#0';
    var $temp_0'u64': int;
    $t0 := _$t0;
    $t1 := _$t1;

    // bytecode translation starts here
    // assume Identical($t2, select coin::CoinInfo.supply(global<coin::CoinInfo<#0>>(select type_info::TypeInfo.account_address(type_info::$type_of<#0>())))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:32:9+99
    assume {:print "$at(106,1664,1763)"} true;
    assume ($t2 == $ResourceValue($1_coin_CoinInfo'#0'_$memory, $1_type_info_TypeInfo(#0_info->a, #0_info->m, #0_info->s)->$account_address)->$supply);

    // trace_local[coin]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:393:5+1
    assume {:print "$at(105,14869,14870)"} true;
    $temp_0'$1_coin_Coin'#0'' := $Dereference($t0);
    assume {:print "$track_local(22,13,0):", $temp_0'$1_coin_Coin'#0''} $temp_0'$1_coin_Coin'#0'' == $temp_0'$1_coin_Coin'#0'';

    // trace_local[amount]($t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:393:5+1
    assume {:print "$track_local(22,13,1):", $t1} $t1 == $t1;

    // $t3 := get_field<coin::Coin<#0>>.value($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:394:17+10
    assume {:print "$at(105,14972,14982)"} true;
    $t3 := $Dereference($t0)->$value;

    // $t4 := >=($t3, $t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:394:28+2
    call $t4 := $Ge($t3, $t1);

    // if ($t4) goto L1 else goto L0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:394:9+77
    if ($t4) { goto L1; } else { goto L0; }

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:394:9+77
L1:

    // goto L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:394:9+77
    assume {:print "$at(105,14964,15041)"} true;
    goto L2;

    // label L0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:394:9+77
L0:

    // destroy($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:394:9+77
    assume {:print "$at(105,14964,15041)"} true;

    // $t5 := 6 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:394:63+21
    $t5 := 6;
    assume $IsValid'u64'($t5);

    // $t6 := error::invalid_argument($t5) on_abort goto L4 with $t7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:394:39+46
    call $t6 := $1_error_invalid_argument($t5);
    if ($abort_flag) {
        assume {:print "$at(105,14994,15040)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(22,13):", $t7} $t7 == $t7;
        goto L4;
    }

    // trace_abort($t6) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:394:9+77
    assume {:print "$at(105,14964,15041)"} true;
    assume {:print "$track_abort(22,13):", $t6} $t6 == $t6;

    // $t7 := move($t6) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:394:9+77
    $t7 := $t6;

    // goto L4 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:394:9+77
    goto L4;

    // label L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:395:9+81
    assume {:print "$at(105,15051,15132)"} true;
L2:

    // assume Identical($t8, pack coin::Ghost$supply<#0>(Sub(select coin::Ghost$supply.v<#0>(global<coin::Ghost$supply<#0>>(0x0)), $t1))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:396:13+52
    assume {:print "$at(105,15070,15122)"} true;
    assume ($t8 == $1_coin_Ghost$supply'#0'(($ResourceValue($1_coin_Ghost$supply'#0'_$memory, 0)->$v - $t1)));

    // assume Identical($t9, 0x0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:396:13+52
    assume ($t9 == 0);

    // $t10 := borrow_global<coin::Ghost$supply<#0>>($t9) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:396:13+52
    if (!$ResourceExists($1_coin_Ghost$supply'#0'_$memory, $t9)) {
        call $ExecFailureAbort();
    } else {
        $t10 := $Mutation($Global($t9), EmptyVec(), $ResourceValue($1_coin_Ghost$supply'#0'_$memory, $t9));
    }

    // write_ref($t10, $t8) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:396:13+52
    $t10 := $UpdateMutation($t10, $t8);

    // write_back[coin::Ghost$supply<#0>@]($t10) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:396:13+52
    $1_coin_Ghost$supply'#0'_$memory := $ResourceUpdate($1_coin_Ghost$supply'#0'_$memory, $GlobalLocationAddress($t10),
        $Dereference($t10));

    // $t11 := get_field<coin::Coin<#0>>.value($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:398:22+10
    assume {:print "$at(105,15155,15165)"} true;
    $t11 := $Dereference($t0)->$value;

    // $t12 := -($t11, $t1) on_abort goto L4 with $t7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:398:33+1
    call $t12 := $Sub($t11, $t1);
    if ($abort_flag) {
        assume {:print "$at(105,15166,15167)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(22,13):", $t7} $t7 == $t7;
        goto L4;
    }

    // $t13 := borrow_field<coin::Coin<#0>>.value($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:398:9+10
    $t13 := $ChildMutation($t0, 0, $Dereference($t0)->$value);

    // write_ref($t13, $t12) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:398:9+32
    $t13 := $UpdateMutation($t13, $t12);

    // write_back[Reference($t0).value (u64)]($t13) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:398:9+32
    $t0 := $UpdateMutation($t0, $Update'$1_coin_Coin'#0''_value($Dereference($t0), $Dereference($t13)));

    // trace_local[coin]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:398:9+32
    $temp_0'$1_coin_Coin'#0'' := $Dereference($t0);
    assume {:print "$track_local(22,13,0):", $temp_0'$1_coin_Coin'#0''} $temp_0'$1_coin_Coin'#0'' == $temp_0'$1_coin_Coin'#0'';

    // assume Identical($t14, pack coin::Ghost$supply<#0>(Add(select coin::Ghost$supply.v<#0>(global<coin::Ghost$supply<#0>>(0x0)), $t1))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:400:13+52
    assume {:print "$at(105,15203,15255)"} true;
    assume ($t14 == $1_coin_Ghost$supply'#0'(($ResourceValue($1_coin_Ghost$supply'#0'_$memory, 0)->$v + $t1)));

    // assume Identical($t15, 0x0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:400:13+52
    assume ($t15 == 0);

    // $t16 := borrow_global<coin::Ghost$supply<#0>>($t15) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:400:13+52
    if (!$ResourceExists($1_coin_Ghost$supply'#0'_$memory, $t15)) {
        call $ExecFailureAbort();
    } else {
        $t16 := $Mutation($Global($t15), EmptyVec(), $ResourceValue($1_coin_Ghost$supply'#0'_$memory, $t15));
    }

    // write_ref($t16, $t14) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:400:13+52
    $t16 := $UpdateMutation($t16, $t14);

    // write_back[coin::Ghost$supply<#0>@]($t16) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:400:13+52
    $1_coin_Ghost$supply'#0'_$memory := $ResourceUpdate($1_coin_Ghost$supply'#0'_$memory, $GlobalLocationAddress($t16),
        $Dereference($t16));

    // $t17 := pack coin::Coin<#0>($t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:402:9+22
    assume {:print "$at(105,15275,15297)"} true;
    $t17 := $1_coin_Coin'#0'($t1);

    // trace_return[0]($t17) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:402:9+22
    assume {:print "$track_return(22,13,0):", $t17} $t17 == $t17;

    // trace_local[coin]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:402:9+22
    $temp_0'$1_coin_Coin'#0'' := $Dereference($t0);
    assume {:print "$track_local(22,13,0):", $temp_0'$1_coin_Coin'#0''} $temp_0'$1_coin_Coin'#0'' == $temp_0'$1_coin_Coin'#0'';

    // label L3 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:403:5+1
    assume {:print "$at(105,15302,15303)"} true;
L3:

    // return $t17 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:403:5+1
    assume {:print "$at(105,15302,15303)"} true;
    $ret0 := $t17;
    $ret1 := $t0;
    return;

    // label L4 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:403:5+1
L4:

    // abort($t7) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:403:5+1
    assume {:print "$at(105,15302,15303)"} true;
    $abort_code := $t7;
    $abort_flag := true;
    return;

}

// fun coin::deposit<#0> [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:348:5+621
procedure {:inline 1} $1_coin_deposit'#0'(_$t0: int, _$t1: $1_coin_Coin'#0') returns ()
{
    // declare local variables
    var $t2: $Mutation ($1_coin_CoinStore'#0');
    var $t3: $1_option_Option'$1_optional_aggregator_OptionalAggregator';
    var $t4: $1_coin_CoinStore'#0';
    var $t5: $1_option_Option'$1_optional_aggregator_OptionalAggregator';
    var $t6: bool;
    var $t7: int;
    var $t8: int;
    var $t9: int;
    var $t10: $Mutation ($1_coin_CoinStore'#0');
    var $t11: bool;
    var $t12: bool;
    var $t13: int;
    var $t14: int;
    var $t15: $Mutation ($1_event_EventHandle'$1_coin_DepositEvent');
    var $t16: int;
    var $t17: $1_coin_DepositEvent;
    var $t18: $Mutation ($1_coin_Coin'#0');
    var $t19: $1_option_Option'$1_optional_aggregator_OptionalAggregator';
    var $t0: int;
    var $t1: $1_coin_Coin'#0';
    var $1_coin_CoinInfo'#0'_$modifies: [int]bool;
    var $temp_0'$1_coin_Coin'#0'': $1_coin_Coin'#0';
    var $temp_0'$1_coin_CoinStore'#0'': $1_coin_CoinStore'#0';
    var $temp_0'address': int;
    $t0 := _$t0;
    $t1 := _$t1;

    // bytecode translation starts here
    // assume Identical($t3, select coin::CoinInfo.supply(global<coin::CoinInfo<#0>>(select type_info::TypeInfo.account_address(type_info::$type_of<#0>())))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:32:9+99
    assume {:print "$at(106,1664,1763)"} true;
    assume ($t3 == $ResourceValue($1_coin_CoinInfo'#0'_$memory, $1_type_info_TypeInfo(#0_info->a, #0_info->m, #0_info->s)->$account_address)->$supply);

    // assume Identical($t4, global<coin::CoinStore<#0>>($t0)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:197:9+59
    assume {:print "$at(106,8462,8521)"} true;
    assume ($t4 == $ResourceValue($1_coin_CoinStore'#0'_$memory, $t0));

    // trace_local[account_addr]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:348:5+1
    assume {:print "$at(105,13036,13037)"} true;
    assume {:print "$track_local(22,7,0):", $t0} $t0 == $t0;

    // trace_local[coin]($t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:348:5+1
    assume {:print "$track_local(22,7,1):", $t1} $t1 == $t1;

    // assume Identical($t5, select coin::CoinInfo.supply(global<coin::CoinInfo<#0>>(select type_info::TypeInfo.account_address(type_info::$type_of<#0>())))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:32:9+99
    assume {:print "$at(106,1664,1763)"} true;
    assume ($t5 == $ResourceValue($1_coin_CoinInfo'#0'_$memory, $1_type_info_TypeInfo(#0_info->a, #0_info->m, #0_info->s)->$account_address)->$supply);

    // $t6 := coin::is_account_registered<#0>($t0) on_abort goto L7 with $t7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:350:13+45
    assume {:print "$at(105,13160,13205)"} true;
    call $t6 := $1_coin_is_account_registered'#0'($t0);
    if ($abort_flag) {
        assume {:print "$at(105,13160,13205)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(22,7):", $t7} $t7 == $t7;
        goto L7;
    }

    // if ($t6) goto L1 else goto L0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:349:9+134
    assume {:print "$at(105,13139,13273)"} true;
    if ($t6) { goto L1; } else { goto L0; }

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:349:9+134
L1:

    // goto L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:349:9+134
    assume {:print "$at(105,13139,13273)"} true;
    goto L2;

    // label L0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:351:30+25
    assume {:print "$at(105,13236,13261)"} true;
L0:

    // $t8 := 5 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:351:30+25
    assume {:print "$at(105,13236,13261)"} true;
    $t8 := 5;
    assume $IsValid'u64'($t8);

    // $t9 := error::not_found($t8) on_abort goto L7 with $t7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:351:13+43
    call $t9 := $1_error_not_found($t8);
    if ($abort_flag) {
        assume {:print "$at(105,13219,13262)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(22,7):", $t7} $t7 == $t7;
        goto L7;
    }

    // trace_abort($t9) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:349:9+134
    assume {:print "$at(105,13139,13273)"} true;
    assume {:print "$track_abort(22,7):", $t9} $t9 == $t9;

    // $t7 := move($t9) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:349:9+134
    $t7 := $t9;

    // goto L7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:349:9+134
    goto L7;

    // label L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:354:65+12
    assume {:print "$at(105,13340,13352)"} true;
L2:

    // $t10 := borrow_global<coin::CoinStore<#0>>($t0) on_abort goto L7 with $t7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:354:26+17
    assume {:print "$at(105,13301,13318)"} true;
    if (!$ResourceExists($1_coin_CoinStore'#0'_$memory, $t0)) {
        call $ExecFailureAbort();
    } else {
        $t10 := $Mutation($Global($t0), EmptyVec(), $ResourceValue($1_coin_CoinStore'#0'_$memory, $t0));
    }
    if ($abort_flag) {
        assume {:print "$at(105,13301,13318)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(22,7):", $t7} $t7 == $t7;
        goto L7;
    }

    // trace_local[coin_store]($t10) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:354:13+10
    $temp_0'$1_coin_CoinStore'#0'' := $Dereference($t10);
    assume {:print "$track_local(22,7,2):", $temp_0'$1_coin_CoinStore'#0''} $temp_0'$1_coin_CoinStore'#0'' == $temp_0'$1_coin_CoinStore'#0'';

    // $t11 := get_field<coin::CoinStore<#0>>.frozen($t10) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:356:14+17
    assume {:print "$at(105,13385,13402)"} true;
    $t11 := $Dereference($t10)->$frozen;

    // $t12 := !($t11) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:356:13+1
    call $t12 := $Not($t11);

    // if ($t12) goto L4 else goto L3 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:355:9+97
    assume {:print "$at(105,13363,13460)"} true;
    if ($t12) { goto L4; } else { goto L3; }

    // label L4 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:355:9+97
L4:

    // goto L5 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:355:9+97
    assume {:print "$at(105,13363,13460)"} true;
    goto L5;

    // label L3 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:355:9+97
L3:

    // destroy($t10) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:355:9+97
    assume {:print "$at(105,13363,13460)"} true;

    // $t13 := 10 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:357:38+7
    assume {:print "$at(105,13441,13448)"} true;
    $t13 := 10;
    assume $IsValid'u64'($t13);

    // $t14 := error::permission_denied($t13) on_abort goto L7 with $t7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:357:13+33
    call $t14 := $1_error_permission_denied($t13);
    if ($abort_flag) {
        assume {:print "$at(105,13416,13449)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(22,7):", $t7} $t7 == $t7;
        goto L7;
    }

    // trace_abort($t14) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:355:9+97
    assume {:print "$at(105,13363,13460)"} true;
    assume {:print "$track_abort(22,7):", $t14} $t14 == $t14;

    // $t7 := move($t14) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:355:9+97
    $t7 := $t14;

    // goto L7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:355:9+97
    goto L7;

    // label L5 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:361:18+10
    assume {:print "$at(105,13521,13531)"} true;
L5:

    // $t15 := borrow_field<coin::CoinStore<#0>>.deposit_events($t10) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:361:13+30
    assume {:print "$at(105,13516,13546)"} true;
    $t15 := $ChildMutation($t10, 2, $Dereference($t10)->$deposit_events);

    // $t16 := get_field<coin::Coin<#0>>.value($t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:362:36+10
    assume {:print "$at(105,13583,13593)"} true;
    $t16 := $t1->$value;

    // $t17 := pack coin::DepositEvent($t16) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:362:13+35
    $t17 := $1_coin_DepositEvent($t16);

    // opaque begin: event::emit_event<coin::DepositEvent>($t15, $t17) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:360:9+135
    assume {:print "$at(105,13471,13606)"} true;

    // opaque end: event::emit_event<coin::DepositEvent>($t15, $t17) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:360:9+135

    // write_back[Reference($t10).deposit_events (event::EventHandle<coin::DepositEvent>)]($t15) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:360:9+135
    $t10 := $UpdateMutation($t10, $Update'$1_coin_CoinStore'#0''_deposit_events($Dereference($t10), $Dereference($t15)));

    // $t18 := borrow_field<coin::CoinStore<#0>>.coin($t10) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:365:15+20
    assume {:print "$at(105,13623,13643)"} true;
    $t18 := $ChildMutation($t10, 0, $Dereference($t10)->$coin);

    // assume Identical($t19, select coin::CoinInfo.supply(global<coin::CoinInfo<#0>>(select type_info::TypeInfo.account_address(type_info::$type_of<#0>())))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:32:9+99
    assume {:print "$at(106,1664,1763)"} true;
    assume ($t19 == $ResourceValue($1_coin_CoinInfo'#0'_$memory, $1_type_info_TypeInfo(#0_info->a, #0_info->m, #0_info->s)->$account_address)->$supply);

    // coin::merge<#0>($t18, $t1) on_abort goto L7 with $t7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:365:9+33
    assume {:print "$at(105,13617,13650)"} true;
    call $t18 := $1_coin_merge'#0'($t18, $t1);
    if ($abort_flag) {
        assume {:print "$at(105,13617,13650)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(22,7):", $t7} $t7 == $t7;
        goto L7;
    }

    // write_back[Reference($t10).coin (coin::Coin<#0>)]($t18) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:365:9+33
    $t10 := $UpdateMutation($t10, $Update'$1_coin_CoinStore'#0''_coin($Dereference($t10), $Dereference($t18)));

    // write_back[coin::CoinStore<#0>@]($t10) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:365:9+33
    $1_coin_CoinStore'#0'_$memory := $ResourceUpdate($1_coin_CoinStore'#0'_$memory, $GlobalLocationAddress($t10),
        $Dereference($t10));

    // label L6 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:366:5+1
    assume {:print "$at(105,13656,13657)"} true;
L6:

    // return () at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:366:5+1
    assume {:print "$at(105,13656,13657)"} true;
    return;

    // label L7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:366:5+1
L7:

    // abort($t7) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:366:5+1
    assume {:print "$at(105,13656,13657)"} true;
    $abort_code := $t7;
    $abort_flag := true;
    return;

}

// fun coin::is_account_registered<aptos_coin::AptosCoin> [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:266:5+129
procedure {:inline 1} $1_coin_is_account_registered'$1_aptos_coin_AptosCoin'(_$t0: int) returns ($ret0: bool)
{
    // declare local variables
    var $t1: $1_option_Option'$1_optional_aggregator_OptionalAggregator';
    var $t2: bool;
    var $t0: int;
    var $temp_0'address': int;
    var $temp_0'bool': bool;
    $t0 := _$t0;

    // bytecode translation starts here
    // assume Identical($t1, select coin::CoinInfo.supply(global<coin::CoinInfo<#0>>(select type_info::TypeInfo.account_address(type_info::$type_of<#0>())))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:32:9+99
    assume {:print "$at(106,1664,1763)"} true;
    assume ($t1 == $ResourceValue($1_coin_CoinInfo'$1_aptos_coin_AptosCoin'_$memory, $1_type_info_TypeInfo(1, Vec(DefaultVecMap()[0 := 97][1 := 112][2 := 116][3 := 111][4 := 115][5 := 95][6 := 99][7 := 111][8 := 105][9 := 110], 10), Vec(DefaultVecMap()[0 := 65][1 := 112][2 := 116][3 := 111][4 := 115][5 := 67][6 := 111][7 := 105][8 := 110], 9))->$account_address)->$supply);

    // trace_local[account_addr]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:266:5+1
    assume {:print "$at(105,9762,9763)"} true;
    assume {:print "$track_local(22,22,0):", $t0} $t0 == $t0;

    // $t2 := exists<coin::CoinStore<#0>>($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:267:9+6
    assume {:print "$at(105,9844,9850)"} true;
    $t2 := $ResourceExists($1_coin_CoinStore'$1_aptos_coin_AptosCoin'_$memory, $t0);

    // trace_return[0]($t2) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:267:9+41
    assume {:print "$track_return(22,22,0):", $t2} $t2 == $t2;

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:268:5+1
    assume {:print "$at(105,9890,9891)"} true;
L1:

    // return $t2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:268:5+1
    assume {:print "$at(105,9890,9891)"} true;
    $ret0 := $t2;
    return;

}

// fun coin::is_account_registered<#0> [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:266:5+129
procedure {:inline 1} $1_coin_is_account_registered'#0'(_$t0: int) returns ($ret0: bool)
{
    // declare local variables
    var $t1: $1_option_Option'$1_optional_aggregator_OptionalAggregator';
    var $t2: bool;
    var $t0: int;
    var $temp_0'address': int;
    var $temp_0'bool': bool;
    $t0 := _$t0;

    // bytecode translation starts here
    // assume Identical($t1, select coin::CoinInfo.supply(global<coin::CoinInfo<#0>>(select type_info::TypeInfo.account_address(type_info::$type_of<#0>())))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:32:9+99
    assume {:print "$at(106,1664,1763)"} true;
    assume ($t1 == $ResourceValue($1_coin_CoinInfo'#0'_$memory, $1_type_info_TypeInfo(#0_info->a, #0_info->m, #0_info->s)->$account_address)->$supply);

    // trace_local[account_addr]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:266:5+1
    assume {:print "$at(105,9762,9763)"} true;
    assume {:print "$track_local(22,22,0):", $t0} $t0 == $t0;

    // $t2 := exists<coin::CoinStore<#0>>($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:267:9+6
    assume {:print "$at(105,9844,9850)"} true;
    $t2 := $ResourceExists($1_coin_CoinStore'#0'_$memory, $t0);

    // trace_return[0]($t2) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:267:9+41
    assume {:print "$track_return(22,22,0):", $t2} $t2 == $t2;

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:268:5+1
    assume {:print "$at(105,9890,9891)"} true;
L1:

    // return $t2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:268:5+1
    assume {:print "$at(105,9890,9891)"} true;
    $ret0 := $t2;
    return;

}

// fun coin::merge<#0> [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:527:5+469
procedure {:inline 1} $1_coin_merge'#0'(_$t0: $Mutation ($1_coin_Coin'#0'), _$t1: $1_coin_Coin'#0') returns ($ret0: $Mutation ($1_coin_Coin'#0'))
{
    // declare local variables
    var $t2: int;
    var $t3: $1_option_Option'$1_optional_aggregator_OptionalAggregator';
    var $t4: $1_coin_Ghost$supply'#0';
    var $t5: int;
    var $t6: $Mutation ($1_coin_Ghost$supply'#0');
    var $t7: int;
    var $t8: $1_coin_Ghost$supply'#0';
    var $t9: int;
    var $t10: $Mutation ($1_coin_Ghost$supply'#0');
    var $t11: int;
    var $t12: int;
    var $t13: int;
    var $t14: $Mutation (int);
    var $t0: $Mutation ($1_coin_Coin'#0');
    var $t1: $1_coin_Coin'#0';
    var $temp_0'$1_coin_Coin'#0'': $1_coin_Coin'#0';
    var $temp_0'u64': int;
    $t0 := _$t0;
    $t1 := _$t1;

    // bytecode translation starts here
    // assume Identical($t3, select coin::CoinInfo.supply(global<coin::CoinInfo<#0>>(select type_info::TypeInfo.account_address(type_info::$type_of<#0>())))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:32:9+99
    assume {:print "$at(106,1664,1763)"} true;
    assume ($t3 == $ResourceValue($1_coin_CoinInfo'#0'_$memory, $1_type_info_TypeInfo(#0_info->a, #0_info->m, #0_info->s)->$account_address)->$supply);

    // trace_local[dst_coin]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:527:5+1
    assume {:print "$at(105,20263,20264)"} true;
    $temp_0'$1_coin_Coin'#0'' := $Dereference($t0);
    assume {:print "$track_local(22,26,0):", $temp_0'$1_coin_Coin'#0''} $temp_0'$1_coin_Coin'#0'' == $temp_0'$1_coin_Coin'#0'';

    // trace_local[source_coin]($t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:527:5+1
    assume {:print "$track_local(22,26,1):", $t1} $t1 == $t1;

    // assume Le(Add(select coin::Coin.value($t0), select coin::Coin.value($t1)), 18446744073709551615) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:529:13+53
    assume {:print "$at(105,20379,20432)"} true;
    assume (($Dereference($t0)->$value + $t1->$value) <= 18446744073709551615);

    // assume Identical($t4, pack coin::Ghost$supply<#0>(Sub(select coin::Ghost$supply.v<#0>(global<coin::Ghost$supply<#0>>(0x0)), select coin::Coin.value($t1)))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:532:13+63
    assume {:print "$at(105,20471,20534)"} true;
    assume ($t4 == $1_coin_Ghost$supply'#0'(($ResourceValue($1_coin_Ghost$supply'#0'_$memory, 0)->$v - $t1->$value)));

    // assume Identical($t5, 0x0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:532:13+63
    assume ($t5 == 0);

    // $t6 := borrow_global<coin::Ghost$supply<#0>>($t5) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:532:13+63
    if (!$ResourceExists($1_coin_Ghost$supply'#0'_$memory, $t5)) {
        call $ExecFailureAbort();
    } else {
        $t6 := $Mutation($Global($t5), EmptyVec(), $ResourceValue($1_coin_Ghost$supply'#0'_$memory, $t5));
    }

    // write_ref($t6, $t4) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:532:13+63
    $t6 := $UpdateMutation($t6, $t4);

    // write_back[coin::Ghost$supply<#0>@]($t6) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:532:13+63
    $1_coin_Ghost$supply'#0'_$memory := $ResourceUpdate($1_coin_Ghost$supply'#0'_$memory, $GlobalLocationAddress($t6),
        $Dereference($t6));

    // $t7 := unpack coin::Coin<#0>($t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:534:13+14
    assume {:print "$at(105,20558,20572)"} true;
    $t7 := $t1->$value;

    // trace_local[value]($t7) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:534:20+5
    assume {:print "$track_local(22,26,2):", $t7} $t7 == $t7;

    // assume Identical($t8, pack coin::Ghost$supply<#0>(Add(select coin::Ghost$supply.v<#0>(global<coin::Ghost$supply<#0>>(0x0)), $t7))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:536:13+51
    assume {:print "$at(105,20615,20666)"} true;
    assume ($t8 == $1_coin_Ghost$supply'#0'(($ResourceValue($1_coin_Ghost$supply'#0'_$memory, 0)->$v + $t7)));

    // assume Identical($t9, 0x0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:536:13+51
    assume ($t9 == 0);

    // $t10 := borrow_global<coin::Ghost$supply<#0>>($t9) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:536:13+51
    if (!$ResourceExists($1_coin_Ghost$supply'#0'_$memory, $t9)) {
        call $ExecFailureAbort();
    } else {
        $t10 := $Mutation($Global($t9), EmptyVec(), $ResourceValue($1_coin_Ghost$supply'#0'_$memory, $t9));
    }

    // write_ref($t10, $t8) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:536:13+51
    $t10 := $UpdateMutation($t10, $t8);

    // write_back[coin::Ghost$supply<#0>@]($t10) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:536:13+51
    $1_coin_Ghost$supply'#0'_$memory := $ResourceUpdate($1_coin_Ghost$supply'#0'_$memory, $GlobalLocationAddress($t10),
        $Dereference($t10));

    // $t11 := get_field<coin::Coin<#0>>.value($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:538:26+14
    assume {:print "$at(105,20703,20717)"} true;
    $t11 := $Dereference($t0)->$value;

    // $t12 := +($t11, $t7) on_abort goto L2 with $t13 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:538:41+1
    call $t12 := $AddU64($t11, $t7);
    if ($abort_flag) {
        assume {:print "$at(105,20718,20719)"} true;
        $t13 := $abort_code;
        assume {:print "$track_abort(22,26):", $t13} $t13 == $t13;
        goto L2;
    }

    // $t14 := borrow_field<coin::Coin<#0>>.value($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:538:9+14
    $t14 := $ChildMutation($t0, 0, $Dereference($t0)->$value);

    // write_ref($t14, $t12) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:538:9+39
    $t14 := $UpdateMutation($t14, $t12);

    // write_back[Reference($t0).value (u64)]($t14) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:538:9+39
    $t0 := $UpdateMutation($t0, $Update'$1_coin_Coin'#0''_value($Dereference($t0), $Dereference($t14)));

    // trace_local[dst_coin]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:538:9+39
    $temp_0'$1_coin_Coin'#0'' := $Dereference($t0);
    assume {:print "$track_local(22,26,0):", $temp_0'$1_coin_Coin'#0''} $temp_0'$1_coin_Coin'#0'' == $temp_0'$1_coin_Coin'#0'';

    // trace_local[dst_coin]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:538:48+1
    $temp_0'$1_coin_Coin'#0'' := $Dereference($t0);
    assume {:print "$track_local(22,26,0):", $temp_0'$1_coin_Coin'#0''} $temp_0'$1_coin_Coin'#0'' == $temp_0'$1_coin_Coin'#0'';

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:539:5+1
    assume {:print "$at(105,20731,20732)"} true;
L1:

    // return () at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:539:5+1
    assume {:print "$at(105,20731,20732)"} true;
    $ret0 := $t0;
    return;

    // label L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:539:5+1
L2:

    // abort($t13) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:539:5+1
    assume {:print "$at(105,20731,20732)"} true;
    $abort_code := $t13;
    $abort_flag := true;
    return;

}

// fun coin::register<aptos_coin::AptosCoin> [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:573:5+664
procedure {:inline 1} $1_coin_register'$1_aptos_coin_AptosCoin'(_$t0: $signer) returns ()
{
    // declare local variables
    var $t1: int;
    var $t2: $1_coin_CoinStore'$1_aptos_coin_AptosCoin';
    var $t3: $1_option_Option'$1_optional_aggregator_OptionalAggregator';
    var $t4: int;
    var $t5: $1_account_Account;
    var $t6: int;
    var $t7: int;
    var $t8: $1_option_Option'$1_optional_aggregator_OptionalAggregator';
    var $t9: bool;
    var $t10: int;
    var $t11: $1_coin_Coin'$1_aptos_coin_AptosCoin';
    var $t12: bool;
    var $t13: int;
    var $t14: $1_account_Account;
    var $t15: $1_event_EventHandle'$1_coin_DepositEvent';
    var $t16: int;
    var $t17: $1_account_Account;
    var $t18: $1_event_EventHandle'$1_coin_WithdrawEvent';
    var $t19: $1_coin_CoinStore'$1_aptos_coin_AptosCoin';
    var $t0: $signer;
    var $temp_0'$1_coin_CoinStore'$1_aptos_coin_AptosCoin'': $1_coin_CoinStore'$1_aptos_coin_AptosCoin';
    var $temp_0'address': int;
    var $temp_0'signer': $signer;
    $t0 := _$t0;

    // bytecode translation starts here
    // assume Identical($t3, select coin::CoinInfo.supply(global<coin::CoinInfo<#0>>(select type_info::TypeInfo.account_address(type_info::$type_of<#0>())))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:32:9+99
    assume {:print "$at(106,1664,1763)"} true;
    assume ($t3 == $ResourceValue($1_coin_CoinInfo'$1_aptos_coin_AptosCoin'_$memory, $1_type_info_TypeInfo(1, Vec(DefaultVecMap()[0 := 97][1 := 112][2 := 116][3 := 111][4 := 115][5 := 95][6 := 99][7 := 111][8 := 105][9 := 110], 10), Vec(DefaultVecMap()[0 := 65][1 := 112][2 := 116][3 := 111][4 := 115][5 := 67][6 := 111][7 := 105][8 := 110], 9))->$account_address)->$supply);

    // assume Identical($t4, signer::$address_of($t0)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:358:9+47
    assume {:print "$at(106,15395,15442)"} true;
    assume ($t4 == $1_signer_$address_of($t0));

    // assume Identical($t5, global<account::Account>($t4)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:359:9+49
    assume {:print "$at(106,15451,15500)"} true;
    assume ($t5 == $ResourceValue($1_account_Account_$memory, $t4));

    // trace_local[account]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:573:5+1
    assume {:print "$at(105,22139,22140)"} true;
    assume {:print "$track_local(22,30,0):", $t0} $t0 == $t0;

    // $t6 := signer::address_of($t0) on_abort goto L3 with $t7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:574:28+27
    assume {:print "$at(105,22216,22243)"} true;
    call $t6 := $1_signer_address_of($t0);
    if ($abort_flag) {
        assume {:print "$at(105,22216,22243)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(22,30):", $t7} $t7 == $t7;
        goto L3;
    }

    // trace_local[account_addr]($t6) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:574:13+12
    assume {:print "$track_local(22,30,1):", $t6} $t6 == $t6;

    // assume Identical($t8, select coin::CoinInfo.supply(global<coin::CoinInfo<#0>>(select type_info::TypeInfo.account_address(type_info::$type_of<#0>())))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:32:9+99
    assume {:print "$at(106,1664,1763)"} true;
    assume ($t8 == $ResourceValue($1_coin_CoinInfo'$1_aptos_coin_AptosCoin'_$memory, $1_type_info_TypeInfo(1, Vec(DefaultVecMap()[0 := 97][1 := 112][2 := 116][3 := 111][4 := 115][5 := 95][6 := 99][7 := 111][8 := 105][9 := 110], 10), Vec(DefaultVecMap()[0 := 65][1 := 112][2 := 116][3 := 111][4 := 115][5 := 67][6 := 111][7 := 105][8 := 110], 9))->$account_address)->$supply);

    // $t9 := coin::is_account_registered<#0>($t6) on_abort goto L3 with $t7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:576:13+45
    assume {:print "$at(105,22344,22389)"} true;
    call $t9 := $1_coin_is_account_registered'$1_aptos_coin_AptosCoin'($t6);
    if ($abort_flag) {
        assume {:print "$at(105,22344,22389)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(22,30):", $t7} $t7 == $t7;
        goto L3;
    }

    // if ($t9) goto L1 else goto L0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:576:9+81
    if ($t9) { goto L1; } else { goto L0; }

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:577:13+6
    assume {:print "$at(105,22405,22411)"} true;
L1:

    // goto L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:577:13+6
    assume {:print "$at(105,22405,22411)"} true;
    goto L2;

    // label L0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:580:42+12
    assume {:print "$at(105,22465,22477)"} true;
L0:

    // account::register_coin<#0>($t6) on_abort goto L3 with $t7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:580:9+46
    assume {:print "$at(105,22432,22478)"} true;
    call $1_account_register_coin'$1_aptos_coin_AptosCoin'($t6);
    if ($abort_flag) {
        assume {:print "$at(105,22432,22478)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(22,30):", $t7} $t7 == $t7;
        goto L3;
    }

    // $t10 := 0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:582:33+1
    assume {:print "$at(105,22559,22560)"} true;
    $t10 := 0;
    assume $IsValid'u64'($t10);

    // $t11 := pack coin::Coin<#0>($t10) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:582:19+17
    $t11 := $1_coin_Coin'$1_aptos_coin_AptosCoin'($t10);

    // $t12 := false at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:583:21+5
    assume {:print "$at(105,22584,22589)"} true;
    $t12 := false;
    assume $IsValid'bool'($t12);

    // assume Identical($t13, signer::$address_of($t0)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:504:9+39
    assume {:print "$at(82,24284,24323)"} true;
    assume ($t13 == $1_signer_$address_of($t0));

    // assume Identical($t14, global<account::Account>($t13)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:505:9+36
    assume {:print "$at(82,24332,24368)"} true;
    assume ($t14 == $ResourceValue($1_account_Account_$memory, $t13));

    // $t15 := account::new_event_handle<coin::DepositEvent>($t0) on_abort goto L3 with $t7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:584:29+48
    assume {:print "$at(105,22619,22667)"} true;
    call $t15 := $1_account_new_event_handle'$1_coin_DepositEvent'($t0);
    if ($abort_flag) {
        assume {:print "$at(105,22619,22667)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(22,30):", $t7} $t7 == $t7;
        goto L3;
    }

    // assume Identical($t16, signer::$address_of($t0)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:504:9+39
    assume {:print "$at(82,24284,24323)"} true;
    assume ($t16 == $1_signer_$address_of($t0));

    // assume Identical($t17, global<account::Account>($t16)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:505:9+36
    assume {:print "$at(82,24332,24368)"} true;
    assume ($t17 == $ResourceValue($1_account_Account_$memory, $t16));

    // $t18 := account::new_event_handle<coin::WithdrawEvent>($t0) on_abort goto L3 with $t7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:585:30+49
    assume {:print "$at(105,22698,22747)"} true;
    call $t18 := $1_account_new_event_handle'$1_coin_WithdrawEvent'($t0);
    if ($abort_flag) {
        assume {:print "$at(105,22698,22747)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(22,30):", $t7} $t7 == $t7;
        goto L3;
    }

    // $t19 := pack coin::CoinStore<#0>($t11, $t12, $t15, $t18) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:581:26+253
    assume {:print "$at(105,22505,22758)"} true;
    $t19 := $1_coin_CoinStore'$1_aptos_coin_AptosCoin'($t11, $t12, $t15, $t18);

    // trace_local[coin_store]($t19) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:581:13+10
    assume {:print "$track_local(22,30,2):", $t19} $t19 == $t19;

    // move_to<coin::CoinStore<#0>>($t19, $t0) on_abort goto L3 with $t7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:587:9+7
    assume {:print "$at(105,22768,22775)"} true;
    if ($ResourceExists($1_coin_CoinStore'$1_aptos_coin_AptosCoin'_$memory, $t0->$addr)) {
        call $ExecFailureAbort();
    } else {
        $1_coin_CoinStore'$1_aptos_coin_AptosCoin'_$memory := $ResourceUpdate($1_coin_CoinStore'$1_aptos_coin_AptosCoin'_$memory, $t0->$addr, $t19);
    }
    if ($abort_flag) {
        assume {:print "$at(105,22768,22775)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(22,30):", $t7} $t7 == $t7;
        goto L3;
    }

    // label L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:588:5+1
    assume {:print "$at(105,22802,22803)"} true;
L2:

    // return () at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:588:5+1
    assume {:print "$at(105,22802,22803)"} true;
    return;

    // label L3 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:588:5+1
L3:

    // abort($t7) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:588:5+1
    assume {:print "$at(105,22802,22803)"} true;
    $abort_code := $t7;
    $abort_flag := true;
    return;

}

// fun coin::transfer<#0> [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:591:5+214
procedure {:inline 1} $1_coin_transfer'#0'(_$t0: $signer, _$t1: int, _$t2: int) returns ()
{
    // declare local variables
    var $t3: $1_coin_Coin'#0';
    var $t4: $1_option_Option'$1_optional_aggregator_OptionalAggregator';
    var $t5: int;
    var $t6: $1_coin_CoinStore'#0';
    var $t7: $1_coin_CoinStore'#0';
    var $t8: $1_option_Option'$1_optional_aggregator_OptionalAggregator';
    var $t9: int;
    var $t10: $1_coin_CoinStore'#0';
    var $t11: int;
    var $t12: int;
    var $t13: $1_coin_CoinStore'#0';
    var $t14: int;
    var $t15: $1_coin_Coin'#0';
    var $t16: int;
    var $t17: $1_option_Option'$1_optional_aggregator_OptionalAggregator';
    var $t18: $1_coin_CoinStore'#0';
    var $t0: $signer;
    var $t1: int;
    var $t2: int;
    var $temp_0'$1_coin_Coin'#0'': $1_coin_Coin'#0';
    var $temp_0'address': int;
    var $temp_0'signer': $signer;
    var $temp_0'u64': int;
    $t0 := _$t0;
    $t1 := _$t1;
    $t2 := _$t2;

    // bytecode translation starts here
    // assume Identical($t4, select coin::CoinInfo.supply(global<coin::CoinInfo<#0>>(select type_info::TypeInfo.account_address(type_info::$type_of<#0>())))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:32:9+99
    assume {:print "$at(106,1664,1763)"} true;
    assume ($t4 == $ResourceValue($1_coin_CoinInfo'#0'_$memory, $1_type_info_TypeInfo(#0_info->a, #0_info->m, #0_info->s)->$account_address)->$supply);

    // assume Identical($t5, signer::$address_of($t0)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:375:9+49
    assume {:print "$at(106,16245,16294)"} true;
    assume ($t5 == $1_signer_$address_of($t0));

    // assume Identical($t6, global<coin::CoinStore<#0>>($t5)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:376:9+69
    assume {:print "$at(106,16303,16372)"} true;
    assume ($t6 == $ResourceValue($1_coin_CoinStore'#0'_$memory, $t5));

    // assume Identical($t7, global<coin::CoinStore<#0>>($t1)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:378:9+52
    assume {:print "$at(106,16469,16521)"} true;
    assume ($t7 == $ResourceValue($1_coin_CoinStore'#0'_$memory, $t1));

    // trace_local[from]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:591:5+1
    assume {:print "$at(105,22877,22878)"} true;
    assume {:print "$track_local(22,33,0):", $t0} $t0 == $t0;

    // trace_local[to]($t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:591:5+1
    assume {:print "$track_local(22,33,1):", $t1} $t1 == $t1;

    // trace_local[amount]($t2) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:591:5+1
    assume {:print "$track_local(22,33,2):", $t2} $t2 == $t2;

    // assume Identical($t8, select coin::CoinInfo.supply(global<coin::CoinInfo<#0>>(select type_info::TypeInfo.account_address(type_info::$type_of<#0>())))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:32:9+99
    assume {:print "$at(106,1664,1763)"} true;
    assume ($t8 == $ResourceValue($1_coin_CoinInfo'#0'_$memory, $1_type_info_TypeInfo(#0_info->a, #0_info->m, #0_info->s)->$account_address)->$supply);

    // assume Identical($t9, signer::$address_of($t0)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:400:9+47
    assume {:print "$at(106,17476,17523)"} true;
    assume ($t9 == $1_signer_$address_of($t0));

    // assume Identical($t10, global<coin::CoinStore<#0>>($t9)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:401:9+59
    assume {:print "$at(106,17532,17591)"} true;
    assume ($t10 == $ResourceValue($1_coin_CoinStore'#0'_$memory, $t9));

    // assume Identical($t11, select coin::Coin.value(select coin::CoinStore.coin($t10))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:402:9+36
    assume {:print "$at(106,17600,17636)"} true;
    assume ($t11 == $t10->$coin->$value);

    // assume Identical($t12, signer::$address_of($t0)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:410:9+47
    assume {:print "$at(106,17930,17977)"} true;
    assume ($t12 == $1_signer_$address_of($t0));

    // assume Identical($t13, global<coin::CoinStore<#0>>($t12)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:411:9+59
    assume {:print "$at(106,17986,18045)"} true;
    assume ($t13 == $ResourceValue($1_coin_CoinStore'#0'_$memory, $t12));

    // assume Identical($t14, select coin::Coin.value(select coin::CoinStore.coin($t13))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:412:9+36
    assume {:print "$at(106,18054,18090)"} true;
    assume ($t14 == $t13->$coin->$value);

    // $t15 := coin::withdraw<#0>($t0, $t2) on_abort goto L2 with $t16 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:596:20+32
    assume {:print "$at(105,23025,23057)"} true;
    call $t15 := $1_coin_withdraw'#0'($t0, $t2);
    if ($abort_flag) {
        assume {:print "$at(105,23025,23057)"} true;
        $t16 := $abort_code;
        assume {:print "$track_abort(22,33):", $t16} $t16 == $t16;
        goto L2;
    }

    // trace_local[coin]($t15) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:596:13+4
    assume {:print "$track_local(22,33,3):", $t15} $t15 == $t15;

    // assume Identical($t17, select coin::CoinInfo.supply(global<coin::CoinInfo<#0>>(select type_info::TypeInfo.account_address(type_info::$type_of<#0>())))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:32:9+99
    assume {:print "$at(106,1664,1763)"} true;
    assume ($t17 == $ResourceValue($1_coin_CoinInfo'#0'_$memory, $1_type_info_TypeInfo(#0_info->a, #0_info->m, #0_info->s)->$account_address)->$supply);

    // assume Identical($t18, global<coin::CoinStore<#0>>($t1)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:197:9+59
    assume {:print "$at(106,8462,8521)"} true;
    assume ($t18 == $ResourceValue($1_coin_CoinStore'#0'_$memory, $t1));

    // coin::deposit<#0>($t1, $t15) on_abort goto L2 with $t16 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:597:9+17
    assume {:print "$at(105,23067,23084)"} true;
    call $1_coin_deposit'#0'($t1, $t15);
    if ($abort_flag) {
        assume {:print "$at(105,23067,23084)"} true;
        $t16 := $abort_code;
        assume {:print "$track_abort(22,33):", $t16} $t16 == $t16;
        goto L2;
    }

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:598:5+1
    assume {:print "$at(105,23090,23091)"} true;
L1:

    // return () at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:598:5+1
    assume {:print "$at(105,23090,23091)"} true;
    return;

    // label L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:598:5+1
L2:

    // abort($t16) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:598:5+1
    assume {:print "$at(105,23090,23091)"} true;
    $abort_code := $t16;
    $abort_flag := true;
    return;

}

// fun coin::withdraw<#0> [baseline] at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:606:5+697
procedure {:inline 1} $1_coin_withdraw'#0'(_$t0: $signer, _$t1: int) returns ($ret0: $1_coin_Coin'#0')
{
    // declare local variables
    var $t2: int;
    var $t3: $Mutation ($1_coin_CoinStore'#0');
    var $t4: $1_option_Option'$1_optional_aggregator_OptionalAggregator';
    var $t5: int;
    var $t6: $1_coin_CoinStore'#0';
    var $t7: int;
    var $t8: int;
    var $t9: $1_coin_CoinStore'#0';
    var $t10: int;
    var $t11: int;
    var $t12: int;
    var $t13: $1_option_Option'$1_optional_aggregator_OptionalAggregator';
    var $t14: bool;
    var $t15: int;
    var $t16: int;
    var $t17: $Mutation ($1_coin_CoinStore'#0');
    var $t18: bool;
    var $t19: bool;
    var $t20: int;
    var $t21: int;
    var $t22: $Mutation ($1_event_EventHandle'$1_coin_WithdrawEvent');
    var $t23: $1_coin_WithdrawEvent;
    var $t24: $Mutation ($1_coin_Coin'#0');
    var $t25: $1_option_Option'$1_optional_aggregator_OptionalAggregator';
    var $t26: $1_coin_Coin'#0';
    var $t0: $signer;
    var $t1: int;
    var $1_coin_CoinStore'#0'_$modifies: [int]bool;
    var $temp_0'$1_coin_Coin'#0'': $1_coin_Coin'#0';
    var $temp_0'$1_coin_CoinStore'#0'': $1_coin_CoinStore'#0';
    var $temp_0'address': int;
    var $temp_0'signer': $signer;
    var $temp_0'u64': int;
    $t0 := _$t0;
    $t1 := _$t1;

    // bytecode translation starts here
    // assume Identical($t4, select coin::CoinInfo.supply(global<coin::CoinInfo<#0>>(select type_info::TypeInfo.account_address(type_info::$type_of<#0>())))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:32:9+99
    assume {:print "$at(106,1664,1763)"} true;
    assume ($t4 == $ResourceValue($1_coin_CoinInfo'#0'_$memory, $1_type_info_TypeInfo(#0_info->a, #0_info->m, #0_info->s)->$account_address)->$supply);

    // assume Identical($t5, signer::$address_of($t0)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:400:9+47
    assume {:print "$at(106,17476,17523)"} true;
    assume ($t5 == $1_signer_$address_of($t0));

    // assume Identical($t6, global<coin::CoinStore<#0>>($t5)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:401:9+59
    assume {:print "$at(106,17532,17591)"} true;
    assume ($t6 == $ResourceValue($1_coin_CoinStore'#0'_$memory, $t5));

    // assume Identical($t7, select coin::Coin.value(select coin::CoinStore.coin($t6))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:402:9+36
    assume {:print "$at(106,17600,17636)"} true;
    assume ($t7 == $t6->$coin->$value);

    // assume Identical($t8, signer::$address_of($t0)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:410:9+47
    assume {:print "$at(106,17930,17977)"} true;
    assume ($t8 == $1_signer_$address_of($t0));

    // assume Identical($t9, global<coin::CoinStore<#0>>($t8)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:411:9+59
    assume {:print "$at(106,17986,18045)"} true;
    assume ($t9 == $ResourceValue($1_coin_CoinStore'#0'_$memory, $t8));

    // assume Identical($t10, select coin::Coin.value(select coin::CoinStore.coin($t9))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:412:9+36
    assume {:print "$at(106,18054,18090)"} true;
    assume ($t10 == $t9->$coin->$value);

    // trace_local[account]($t0) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:606:5+1
    assume {:print "$at(105,23311,23312)"} true;
    assume {:print "$track_local(22,37,0):", $t0} $t0 == $t0;

    // trace_local[amount]($t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:606:5+1
    assume {:print "$track_local(22,37,1):", $t1} $t1 == $t1;

    // $t11 := signer::address_of($t0) on_abort goto L7 with $t12 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:610:28+27
    assume {:print "$at(105,23459,23486)"} true;
    call $t11 := $1_signer_address_of($t0);
    if ($abort_flag) {
        assume {:print "$at(105,23459,23486)"} true;
        $t12 := $abort_code;
        assume {:print "$track_abort(22,37):", $t12} $t12 == $t12;
        goto L7;
    }

    // trace_local[account_addr]($t11) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:610:13+12
    assume {:print "$track_local(22,37,2):", $t11} $t11 == $t11;

    // assume Identical($t13, select coin::CoinInfo.supply(global<coin::CoinInfo<#0>>(select type_info::TypeInfo.account_address(type_info::$type_of<#0>())))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:32:9+99
    assume {:print "$at(106,1664,1763)"} true;
    assume ($t13 == $ResourceValue($1_coin_CoinInfo'#0'_$memory, $1_type_info_TypeInfo(#0_info->a, #0_info->m, #0_info->s)->$account_address)->$supply);

    // $t14 := coin::is_account_registered<#0>($t11) on_abort goto L7 with $t12 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:612:13+45
    assume {:print "$at(105,23517,23562)"} true;
    call $t14 := $1_coin_is_account_registered'#0'($t11);
    if ($abort_flag) {
        assume {:print "$at(105,23517,23562)"} true;
        $t12 := $abort_code;
        assume {:print "$track_abort(22,37):", $t12} $t12 == $t12;
        goto L7;
    }

    // if ($t14) goto L1 else goto L0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:611:9+134
    assume {:print "$at(105,23496,23630)"} true;
    if ($t14) { goto L1; } else { goto L0; }

    // label L1 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:611:9+134
L1:

    // goto L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:611:9+134
    assume {:print "$at(105,23496,23630)"} true;
    goto L2;

    // label L0 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:613:30+25
    assume {:print "$at(105,23593,23618)"} true;
L0:

    // $t15 := 5 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:613:30+25
    assume {:print "$at(105,23593,23618)"} true;
    $t15 := 5;
    assume $IsValid'u64'($t15);

    // $t16 := error::not_found($t15) on_abort goto L7 with $t12 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:613:13+43
    call $t16 := $1_error_not_found($t15);
    if ($abort_flag) {
        assume {:print "$at(105,23576,23619)"} true;
        $t12 := $abort_code;
        assume {:print "$track_abort(22,37):", $t12} $t12 == $t12;
        goto L7;
    }

    // trace_abort($t16) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:611:9+134
    assume {:print "$at(105,23496,23630)"} true;
    assume {:print "$track_abort(22,37):", $t16} $t16 == $t16;

    // $t12 := move($t16) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:611:9+134
    $t12 := $t16;

    // goto L7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:611:9+134
    goto L7;

    // label L2 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:616:65+12
    assume {:print "$at(105,23697,23709)"} true;
L2:

    // $t17 := borrow_global<coin::CoinStore<#0>>($t11) on_abort goto L7 with $t12 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:616:26+17
    assume {:print "$at(105,23658,23675)"} true;
    if (!$ResourceExists($1_coin_CoinStore'#0'_$memory, $t11)) {
        call $ExecFailureAbort();
    } else {
        $t17 := $Mutation($Global($t11), EmptyVec(), $ResourceValue($1_coin_CoinStore'#0'_$memory, $t11));
    }
    if ($abort_flag) {
        assume {:print "$at(105,23658,23675)"} true;
        $t12 := $abort_code;
        assume {:print "$track_abort(22,37):", $t12} $t12 == $t12;
        goto L7;
    }

    // trace_local[coin_store]($t17) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:616:13+10
    $temp_0'$1_coin_CoinStore'#0'' := $Dereference($t17);
    assume {:print "$track_local(22,37,3):", $temp_0'$1_coin_CoinStore'#0''} $temp_0'$1_coin_CoinStore'#0'' == $temp_0'$1_coin_CoinStore'#0'';

    // $t18 := get_field<coin::CoinStore<#0>>.frozen($t17) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:618:14+17
    assume {:print "$at(105,23742,23759)"} true;
    $t18 := $Dereference($t17)->$frozen;

    // $t19 := !($t18) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:618:13+1
    call $t19 := $Not($t18);

    // if ($t19) goto L4 else goto L3 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:617:9+97
    assume {:print "$at(105,23720,23817)"} true;
    if ($t19) { goto L4; } else { goto L3; }

    // label L4 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:617:9+97
L4:

    // goto L5 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:617:9+97
    assume {:print "$at(105,23720,23817)"} true;
    goto L5;

    // label L3 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:617:9+97
L3:

    // destroy($t17) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:617:9+97
    assume {:print "$at(105,23720,23817)"} true;

    // $t20 := 10 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:619:38+7
    assume {:print "$at(105,23798,23805)"} true;
    $t20 := 10;
    assume $IsValid'u64'($t20);

    // $t21 := error::permission_denied($t20) on_abort goto L7 with $t12 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:619:13+33
    call $t21 := $1_error_permission_denied($t20);
    if ($abort_flag) {
        assume {:print "$at(105,23773,23806)"} true;
        $t12 := $abort_code;
        assume {:print "$track_abort(22,37):", $t12} $t12 == $t12;
        goto L7;
    }

    // trace_abort($t21) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:617:9+97
    assume {:print "$at(105,23720,23817)"} true;
    assume {:print "$track_abort(22,37):", $t21} $t21 == $t21;

    // $t12 := move($t21) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:617:9+97
    $t12 := $t21;

    // goto L7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:617:9+97
    goto L7;

    // label L5 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:623:18+10
    assume {:print "$at(105,23879,23889)"} true;
L5:

    // $t22 := borrow_field<coin::CoinStore<#0>>.withdraw_events($t17) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:623:13+31
    assume {:print "$at(105,23874,23905)"} true;
    $t22 := $ChildMutation($t17, 3, $Dereference($t17)->$withdraw_events);

    // $t23 := pack coin::WithdrawEvent($t1) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:624:13+24
    assume {:print "$at(105,23919,23943)"} true;
    $t23 := $1_coin_WithdrawEvent($t1);

    // opaque begin: event::emit_event<coin::WithdrawEvent>($t22, $t23) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:622:9+126
    assume {:print "$at(105,23828,23954)"} true;

    // opaque end: event::emit_event<coin::WithdrawEvent>($t22, $t23) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:622:9+126

    // write_back[Reference($t17).withdraw_events (event::EventHandle<coin::WithdrawEvent>)]($t22) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:622:9+126
    $t17 := $UpdateMutation($t17, $Update'$1_coin_CoinStore'#0''_withdraw_events($Dereference($t17), $Dereference($t22)));

    // $t24 := borrow_field<coin::CoinStore<#0>>.coin($t17) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:627:17+20
    assume {:print "$at(105,23973,23993)"} true;
    $t24 := $ChildMutation($t17, 0, $Dereference($t17)->$coin);

    // assume Identical($t25, select coin::CoinInfo.supply(global<coin::CoinInfo<#0>>(select type_info::TypeInfo.account_address(type_info::$type_of<#0>())))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:32:9+99
    assume {:print "$at(106,1664,1763)"} true;
    assume ($t25 == $ResourceValue($1_coin_CoinInfo'#0'_$memory, $1_type_info_TypeInfo(#0_info->a, #0_info->m, #0_info->s)->$account_address)->$supply);

    // $t26 := coin::extract<#0>($t24, $t1) on_abort goto L7 with $t12 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:627:9+37
    assume {:print "$at(105,23965,24002)"} true;
    call $t26,$t24 := $1_coin_extract'#0'($t24, $t1);
    if ($abort_flag) {
        assume {:print "$at(105,23965,24002)"} true;
        $t12 := $abort_code;
        assume {:print "$track_abort(22,37):", $t12} $t12 == $t12;
        goto L7;
    }

    // write_back[Reference($t17).coin (coin::Coin<#0>)]($t24) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:627:9+37
    $t17 := $UpdateMutation($t17, $Update'$1_coin_CoinStore'#0''_coin($Dereference($t17), $Dereference($t24)));

    // write_back[coin::CoinStore<#0>@]($t17) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:627:9+37
    $1_coin_CoinStore'#0'_$memory := $ResourceUpdate($1_coin_CoinStore'#0'_$memory, $GlobalLocationAddress($t17),
        $Dereference($t17));

    // trace_return[0]($t26) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:627:9+37
    assume {:print "$track_return(22,37,0):", $t26} $t26 == $t26;

    // label L6 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:628:5+1
    assume {:print "$at(105,24007,24008)"} true;
L6:

    // return $t26 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:628:5+1
    assume {:print "$at(105,24007,24008)"} true;
    $ret0 := $t26;
    return;

    // label L7 at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:628:5+1
L7:

    // abort($t12) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.move:628:5+1
    assume {:print "$at(105,24007,24008)"} true;
    $abort_code := $t12;
    $abort_flag := true;
    return;

}

// struct aptos_coin::AptosCoin at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/aptos_coin.move:22:5+27
datatype $1_aptos_coin_AptosCoin {
    $1_aptos_coin_AptosCoin($dummy_field: bool)
}
function {:inline} $Update'$1_aptos_coin_AptosCoin'_dummy_field(s: $1_aptos_coin_AptosCoin, x: bool): $1_aptos_coin_AptosCoin {
    $1_aptos_coin_AptosCoin(x)
}
function $IsValid'$1_aptos_coin_AptosCoin'(s: $1_aptos_coin_AptosCoin): bool {
    $IsValid'bool'(s->$dummy_field)
}
function {:inline} $IsEqual'$1_aptos_coin_AptosCoin'(s1: $1_aptos_coin_AptosCoin, s2: $1_aptos_coin_AptosCoin): bool {
    s1 == s2
}
var $1_aptos_coin_AptosCoin_$memory: $Memory $1_aptos_coin_AptosCoin;

// struct Bbay::Owner at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:24:5+168
datatype $1_Bbay_Owner {
    $1_Bbay_Owner($owner_address: int, $user_count: int, $num_of_products_added: int, $resource_account: Table int (int))
}
function {:inline} $Update'$1_Bbay_Owner'_owner_address(s: $1_Bbay_Owner, x: int): $1_Bbay_Owner {
    $1_Bbay_Owner(x, s->$user_count, s->$num_of_products_added, s->$resource_account)
}
function {:inline} $Update'$1_Bbay_Owner'_user_count(s: $1_Bbay_Owner, x: int): $1_Bbay_Owner {
    $1_Bbay_Owner(s->$owner_address, x, s->$num_of_products_added, s->$resource_account)
}
function {:inline} $Update'$1_Bbay_Owner'_num_of_products_added(s: $1_Bbay_Owner, x: int): $1_Bbay_Owner {
    $1_Bbay_Owner(s->$owner_address, s->$user_count, x, s->$resource_account)
}
function {:inline} $Update'$1_Bbay_Owner'_resource_account(s: $1_Bbay_Owner, x: Table int (int)): $1_Bbay_Owner {
    $1_Bbay_Owner(s->$owner_address, s->$user_count, s->$num_of_products_added, x)
}
function $IsValid'$1_Bbay_Owner'(s: $1_Bbay_Owner): bool {
    $IsValid'address'(s->$owner_address)
      && $IsValid'u64'(s->$user_count)
      && $IsValid'u64'(s->$num_of_products_added)
      && $IsValid'$1_table_Table'address_address''(s->$resource_account)
}
function {:inline} $IsEqual'$1_Bbay_Owner'(s1: $1_Bbay_Owner, s2: $1_Bbay_Owner): bool {
    s1 == s2
}
var $1_Bbay_Owner_$memory: $Memory $1_Bbay_Owner;

// struct Bbay::Products at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:35:5+251
datatype $1_Bbay_Products {
    $1_Bbay_Products($sr_number: Table int (int), $item_id: Vec (int), $item_name: Table int (Vec (int)), $item_sold: Table int (bool), $item_price: Table int (int), $item_on_selling: Table int (bool))
}
function {:inline} $Update'$1_Bbay_Products'_sr_number(s: $1_Bbay_Products, x: Table int (int)): $1_Bbay_Products {
    $1_Bbay_Products(x, s->$item_id, s->$item_name, s->$item_sold, s->$item_price, s->$item_on_selling)
}
function {:inline} $Update'$1_Bbay_Products'_item_id(s: $1_Bbay_Products, x: Vec (int)): $1_Bbay_Products {
    $1_Bbay_Products(s->$sr_number, x, s->$item_name, s->$item_sold, s->$item_price, s->$item_on_selling)
}
function {:inline} $Update'$1_Bbay_Products'_item_name(s: $1_Bbay_Products, x: Table int (Vec (int))): $1_Bbay_Products {
    $1_Bbay_Products(s->$sr_number, s->$item_id, x, s->$item_sold, s->$item_price, s->$item_on_selling)
}
function {:inline} $Update'$1_Bbay_Products'_item_sold(s: $1_Bbay_Products, x: Table int (bool)): $1_Bbay_Products {
    $1_Bbay_Products(s->$sr_number, s->$item_id, s->$item_name, x, s->$item_price, s->$item_on_selling)
}
function {:inline} $Update'$1_Bbay_Products'_item_price(s: $1_Bbay_Products, x: Table int (int)): $1_Bbay_Products {
    $1_Bbay_Products(s->$sr_number, s->$item_id, s->$item_name, s->$item_sold, x, s->$item_on_selling)
}
function {:inline} $Update'$1_Bbay_Products'_item_on_selling(s: $1_Bbay_Products, x: Table int (bool)): $1_Bbay_Products {
    $1_Bbay_Products(s->$sr_number, s->$item_id, s->$item_name, s->$item_sold, s->$item_price, x)
}
function $IsValid'$1_Bbay_Products'(s: $1_Bbay_Products): bool {
    $IsValid'$1_table_Table'u64_u64''(s->$sr_number)
      && $IsValid'vec'u64''(s->$item_id)
      && $IsValid'$1_table_Table'u64_vec'u64'''(s->$item_name)
      && $IsValid'$1_table_Table'u64_bool''(s->$item_sold)
      && $IsValid'$1_table_Table'u64_u64''(s->$item_price)
      && $IsValid'$1_table_Table'u64_bool''(s->$item_on_selling)
}
function {:inline} $IsEqual'$1_Bbay_Products'(s1: $1_Bbay_Products, s2: $1_Bbay_Products): bool {
    $IsEqual'$1_table_Table'u64_u64''(s1->$sr_number, s2->$sr_number)
    && $IsEqual'vec'u64''(s1->$item_id, s2->$item_id)
    && $IsEqual'$1_table_Table'u64_vec'u64'''(s1->$item_name, s2->$item_name)
    && $IsEqual'$1_table_Table'u64_bool''(s1->$item_sold, s2->$item_sold)
    && $IsEqual'$1_table_Table'u64_u64''(s1->$item_price, s2->$item_price)
    && $IsEqual'$1_table_Table'u64_bool''(s1->$item_on_selling, s2->$item_on_selling)}
var $1_Bbay_Products_$memory: $Memory $1_Bbay_Products;

// struct Bbay::ResourceAccountSignerCap at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:31:5+94
datatype $1_Bbay_ResourceAccountSignerCap {
    $1_Bbay_ResourceAccountSignerCap($signer_cap: $1_account_SignerCapability)
}
function {:inline} $Update'$1_Bbay_ResourceAccountSignerCap'_signer_cap(s: $1_Bbay_ResourceAccountSignerCap, x: $1_account_SignerCapability): $1_Bbay_ResourceAccountSignerCap {
    $1_Bbay_ResourceAccountSignerCap(x)
}
function $IsValid'$1_Bbay_ResourceAccountSignerCap'(s: $1_Bbay_ResourceAccountSignerCap): bool {
    $IsValid'$1_account_SignerCapability'(s->$signer_cap)
}
function {:inline} $IsEqual'$1_Bbay_ResourceAccountSignerCap'(s1: $1_Bbay_ResourceAccountSignerCap, s2: $1_Bbay_ResourceAccountSignerCap): bool {
    s1 == s2
}
var $1_Bbay_ResourceAccountSignerCap_$memory: $Memory $1_Bbay_ResourceAccountSignerCap;

// struct Bbay::User at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:45:5+148
datatype $1_Bbay_User {
    $1_Bbay_User($user_id: int, $orders: Vec (int), $order_status: Vec (int), $payment_status: Vec (int))
}
function {:inline} $Update'$1_Bbay_User'_user_id(s: $1_Bbay_User, x: int): $1_Bbay_User {
    $1_Bbay_User(x, s->$orders, s->$order_status, s->$payment_status)
}
function {:inline} $Update'$1_Bbay_User'_orders(s: $1_Bbay_User, x: Vec (int)): $1_Bbay_User {
    $1_Bbay_User(s->$user_id, x, s->$order_status, s->$payment_status)
}
function {:inline} $Update'$1_Bbay_User'_order_status(s: $1_Bbay_User, x: Vec (int)): $1_Bbay_User {
    $1_Bbay_User(s->$user_id, s->$orders, x, s->$payment_status)
}
function {:inline} $Update'$1_Bbay_User'_payment_status(s: $1_Bbay_User, x: Vec (int)): $1_Bbay_User {
    $1_Bbay_User(s->$user_id, s->$orders, s->$order_status, x)
}
function $IsValid'$1_Bbay_User'(s: $1_Bbay_User): bool {
    $IsValid'u64'(s->$user_id)
      && $IsValid'vec'u64''(s->$orders)
      && $IsValid'vec'u64''(s->$order_status)
      && $IsValid'vec'u64''(s->$payment_status)
}
function {:inline} $IsEqual'$1_Bbay_User'(s1: $1_Bbay_User, s2: $1_Bbay_User): bool {
    $IsEqual'u64'(s1->$user_id, s2->$user_id)
    && $IsEqual'vec'u64''(s1->$orders, s2->$orders)
    && $IsEqual'vec'u64''(s1->$order_status, s2->$order_status)
    && $IsEqual'vec'u64''(s1->$payment_status, s2->$payment_status)}
var $1_Bbay_User_$memory: $Memory $1_Bbay_User;

// fun Bbay::add_items [verification] at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:96:5+1192
procedure {:timeLimit 40} $1_Bbay_add_items$verify(_$t0: $signer, _$t1: int, _$t2: Vec (int), _$t3: int, _$t4: int, _$t5: bool) returns ()
{
    // declare local variables
    var $t6: int;
    var $t7: $Mutation (int);
    var $t8: $Mutation ($1_Bbay_Owner);
    var $t9: $Mutation ($1_Bbay_Products);
    var $t10: int;
    var $t11: int;
    var $t12: int;
    var $t13: $Mutation ($1_Bbay_Owner);
    var $t14: Table int (int);
    var $t15: int;
    var $t16: int;
    var $t17: $Mutation ($1_Bbay_Products);
    var $t18: $Mutation (int);
    var $t19: int;
    var $t20: int;
    var $t21: bool;
    var $t22: int;
    var $t23: bool;
    var $t24: int;
    var $t25: int;
    var $t26: int;
    var $t27: int;
    var $t28: int;
    var $t29: $Mutation (Table int (int));
    var $t30: $Mutation (Table int (int));
    var $t31: $Mutation (Table int (bool));
    var $t32: $Mutation (Vec (int));
    var $t33: $Mutation (Table int (Vec (int)));
    var $t34: $Mutation (Table int (bool));
    var $t35: bool;
    var $t0: $signer;
    var $t1: int;
    var $t2: Vec (int);
    var $t3: int;
    var $t4: int;
    var $t5: bool;
    var $temp_0'$1_Bbay_Owner': $1_Bbay_Owner;
    var $temp_0'$1_Bbay_Products': $1_Bbay_Products;
    var $temp_0'bool': bool;
    var $temp_0'signer': $signer;
    var $temp_0'u64': int;
    var $temp_0'vec'u64'': Vec (int);
    $t0 := _$t0;
    $t1 := _$t1;
    $t2 := _$t2;
    $t3 := _$t3;
    $t4 := _$t4;
    $t5 := _$t5;

    // verification entrypoint assumptions
    call $InitVerification();

    // bytecode translation starts here
    // assume WellFormed($t0) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:96:5+1
    assume {:print "$at(2,2706,2707)"} true;
    assume $IsValid'signer'($t0) && $1_signer_is_txn_signer($t0) && $1_signer_is_txn_signer_addr($t0->$addr);

    // assume WellFormed($t1) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:96:5+1
    assume $IsValid'u64'($t1);

    // assume WellFormed($t2) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:96:5+1
    assume $IsValid'vec'u64''($t2);

    // assume WellFormed($t3) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:96:5+1
    assume $IsValid'u64'($t3);

    // assume WellFormed($t4) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:96:5+1
    assume $IsValid'u64'($t4);

    // assume WellFormed($t5) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:96:5+1
    assume $IsValid'bool'($t5);

    // assume forall $rsc: Bbay::Owner: ResourceDomain<Bbay::Owner>(): WellFormed($rsc) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:96:5+1
    assume (forall $a_0: int :: {$ResourceValue($1_Bbay_Owner_$memory, $a_0)}(var $rsc := $ResourceValue($1_Bbay_Owner_$memory, $a_0);
    ($IsValid'$1_Bbay_Owner'($rsc))));

    // assume forall $rsc: Bbay::Products: ResourceDomain<Bbay::Products>(): WellFormed($rsc) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:96:5+1
    assume (forall $a_0: int :: {$ResourceValue($1_Bbay_Products_$memory, $a_0)}(var $rsc := $ResourceValue($1_Bbay_Products_$memory, $a_0);
    ($IsValid'$1_Bbay_Products'($rsc))));

    // trace_local[account]($t0) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:96:5+1
    assume {:print "$track_local(24,0,0):", $t0} $t0 == $t0;

    // trace_local[item_id]($t1) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:96:5+1
    assume {:print "$track_local(24,0,1):", $t1} $t1 == $t1;

    // trace_local[item_name]($t2) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:96:5+1
    assume {:print "$track_local(24,0,2):", $t2} $t2 == $t2;

    // trace_local[item_quantity]($t3) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:96:5+1
    assume {:print "$track_local(24,0,3):", $t3} $t3 == $t3;

    // trace_local[item_price]($t4) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:96:5+1
    assume {:print "$track_local(24,0,4):", $t4} $t4 == $t4;

    // trace_local[selling_status]($t5) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:96:5+1
    assume {:print "$track_local(24,0,5):", $t5} $t5 == $t5;

    // $t10 := 0 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:104:17+1
    assume {:print "$at(2,2938,2939)"} true;
    $t10 := 0;
    assume $IsValid'u64'($t10);

    // trace_local[i]($t10) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:104:13+1
    assume {:print "$track_local(24,0,6):", $t10} $t10 == $t10;

    // $t11 := signer::address_of($t0) on_abort goto L8 with $t12 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:105:51+27
    assume {:print "$at(2,2991,3018)"} true;
    call $t11 := $1_signer_address_of($t0);
    if ($abort_flag) {
        assume {:print "$at(2,2991,3018)"} true;
        $t12 := $abort_code;
        assume {:print "$track_abort(24,0):", $t12} $t12 == $t12;
        goto L8;
    }

    // $t13 := borrow_global<Bbay::Owner>($t11) on_abort goto L8 with $t12 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:105:26+17
    if (!$ResourceExists($1_Bbay_Owner_$memory, $t11)) {
        call $ExecFailureAbort();
    } else {
        $t13 := $Mutation($Global($t11), EmptyVec(), $ResourceValue($1_Bbay_Owner_$memory, $t11));
    }
    if ($abort_flag) {
        assume {:print "$at(2,2966,2983)"} true;
        $t12 := $abort_code;
        assume {:print "$track_abort(24,0):", $t12} $t12 == $t12;
        goto L8;
    }

    // trace_local[owner_data]($t13) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:105:13+10
    $temp_0'$1_Bbay_Owner' := $Dereference($t13);
    assume {:print "$track_local(24,0,8):", $temp_0'$1_Bbay_Owner'} $temp_0'$1_Bbay_Owner' == $temp_0'$1_Bbay_Owner';

    // $t14 := get_field<Bbay::Owner>.resource_account($t13) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:106:47+28
    assume {:print "$at(2,3067,3095)"} true;
    $t14 := $Dereference($t13)->$resource_account;

    // $t15 := signer::address_of($t0) on_abort goto L8 with $t12 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:106:76+27
    call $t15 := $1_signer_address_of($t0);
    if ($abort_flag) {
        assume {:print "$at(2,3096,3123)"} true;
        $t12 := $abort_code;
        assume {:print "$track_abort(24,0):", $t12} $t12 == $t12;
        goto L8;
    }

    // $t16 := table::borrow<address, address>($t14, $t15) on_abort goto L8 with $t12 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:106:33+71
    call $t16 := $1_table_borrow'address_address'($t14, $t15);
    if ($abort_flag) {
        assume {:print "$at(2,3053,3124)"} true;
        $t12 := $abort_code;
        assume {:print "$track_abort(24,0):", $t12} $t12 == $t12;
        goto L8;
    }

    // $t17 := borrow_global<Bbay::Products>($t16) on_abort goto L8 with $t12 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:107:28+17
    assume {:print "$at(2,3154,3171)"} true;
    if (!$ResourceExists($1_Bbay_Products_$memory, $t16)) {
        call $ExecFailureAbort();
    } else {
        $t17 := $Mutation($Global($t16), EmptyVec(), $ResourceValue($1_Bbay_Products_$memory, $t16));
    }
    if ($abort_flag) {
        assume {:print "$at(2,3154,3171)"} true;
        $t12 := $abort_code;
        assume {:print "$track_abort(24,0):", $t12} $t12 == $t12;
        goto L8;
    }

    // trace_local[product_data]($t17) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:107:13+12
    $temp_0'$1_Bbay_Products' := $Dereference($t17);
    assume {:print "$track_local(24,0,9):", $temp_0'$1_Bbay_Products'} $temp_0'$1_Bbay_Products' == $temp_0'$1_Bbay_Products';

    // $t18 := borrow_field<Bbay::Owner>.num_of_products_added($t13) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:108:31+37
    assume {:print "$at(2,3231,3268)"} true;
    $t18 := $ChildMutation($t13, 2, $Dereference($t13)->$num_of_products_added);

    // trace_local[num_of_products]($t18) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:108:13+15
    $temp_0'u64' := $Dereference($t18);
    assume {:print "$track_local(24,0,7):", $temp_0'u64'} $temp_0'u64' == $temp_0'u64';

    // label L5 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    assume {:print "$at(2,3284,3285)"} true;
L5:

    // $t6 := havoc[val]() at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    assume {:print "$at(2,3284,3285)"} true;
    havoc $t6;

    // assume WellFormed($t6) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    assume $IsValid'u64'($t6);

    // $t19 := havoc[val]() at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    havoc $t19;

    // assume WellFormed($t19) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    assume $IsValid'u64'($t19);

    // $t20 := havoc[val]() at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    havoc $t20;

    // assume WellFormed($t20) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    assume $IsValid'u64'($t20);

    // $t21 := havoc[val]() at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    havoc $t21;

    // assume WellFormed($t21) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    assume $IsValid'bool'($t21);

    // $t22 := havoc[val]() at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    havoc $t22;

    // assume WellFormed($t22) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    assume $IsValid'u64'($t22);

    // $t23 := havoc[val]() at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    havoc $t23;

    // assume WellFormed($t23) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    assume $IsValid'bool'($t23);

    // $t24 := havoc[val]() at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    havoc $t24;

    // assume WellFormed($t24) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    assume $IsValid'u64'($t24);

    // $t25 := havoc[val]() at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    havoc $t25;

    // assume WellFormed($t25) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    assume $IsValid'u64'($t25);

    // $t26 := havoc[val]() at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    havoc $t26;

    // assume WellFormed($t26) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    assume $IsValid'u64'($t26);

    // $t27 := havoc[val]() at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    havoc $t27;

    // assume WellFormed($t27) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    assume $IsValid'u64'($t27);

    // $t28 := havoc[val]() at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    havoc $t28;

    // assume WellFormed($t28) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    assume $IsValid'u64'($t28);

    // $t17 := havoc[mut]() at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    havoc $temp_0'$1_Bbay_Products';
    $t17 := $UpdateMutation($t17, $temp_0'$1_Bbay_Products');

    // assume WellFormed($t17) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    assume $IsValid'$1_Bbay_Products'($Dereference($t17));

    // $t18 := havoc[mut]() at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    havoc $temp_0'u64';
    $t18 := $UpdateMutation($t18, $temp_0'u64');

    // assume WellFormed($t18) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    assume $IsValid'u64'($Dereference($t18));

    // $t29 := havoc[mut_all]() at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    havoc $t29;

    // assume WellFormed($t29) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    assume $IsValid'$1_table_Table'u64_u64''($Dereference($t29));

    // $t30 := havoc[mut_all]() at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    havoc $t30;

    // assume WellFormed($t30) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    assume $IsValid'$1_table_Table'u64_u64''($Dereference($t30));

    // $t31 := havoc[mut_all]() at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    havoc $t31;

    // assume WellFormed($t31) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    assume $IsValid'$1_table_Table'u64_bool''($Dereference($t31));

    // trace_local[i]($t6) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    assume {:print "$info(): enter loop, variable(s) i havocked and reassigned"} true;
    assume {:print "$track_local(24,0,6):", $t6} $t6 == $t6;

    // assume Not(AbortFlag()) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:15+1
    assume !$abort_flag;

    // $t19 := read_ref($t18) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:20+16
    $t19 := $Dereference($t18);

    // $t20 := +($t19, $t3) on_abort goto L8 with $t12 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:37+1
    call $t20 := $AddU64($t19, $t3);
    if ($abort_flag) {
        assume {:print "$at(2,3306,3307)"} true;
        $t12 := $abort_code;
        assume {:print "$track_abort(24,0):", $t12} $t12 == $t12;
        goto L8;
    }

    // $t21 := <=($t6, $t20) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:17+2
    call $t21 := $Le($t6, $t20);

    // if ($t21) goto L9 else goto L0 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:9+416
    if ($t21) { goto L9; } else { goto L0; }

    // label L1 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:109:9+416
L1:

    // label L2 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:111:16+1
    assume {:print "$at(2,3353,3354)"} true;
L2:

    // $t22 := read_ref($t18) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:111:20+16
    assume {:print "$at(2,3357,3373)"} true;
    $t22 := $Dereference($t18);

    // $t23 := >($t6, $t22) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:111:18+1
    call $t23 := $Gt($t6, $t22);

    // if ($t23) goto L4 else goto L10 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:111:13+258
    if ($t23) { goto L4; } else { goto L10; }

    // label L4 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:113:29+12
    assume {:print "$at(2,3417,3429)"} true;
L4:

    // $t29 := borrow_field<Bbay::Products>.sr_number($t17) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:113:24+27
    assume {:print "$at(2,3412,3439)"} true;
    $t29 := $ChildMutation($t17, 0, $Dereference($t17)->$sr_number);

    // table::add<u64, u64>($t29, $t6, $t1) on_abort goto L8 with $t12 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:113:13+49
    call $t29 := $1_table_add'u64_u64'($t29, $t6, $t1);
    if ($abort_flag) {
        assume {:print "$at(2,3401,3450)"} true;
        $t12 := $abort_code;
        assume {:print "$track_abort(24,0):", $t12} $t12 == $t12;
        goto L8;
    }

    // write_back[Reference($t17).sr_number (table::Table<u64, u64>)]($t29) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:113:13+49
    $t17 := $UpdateMutation($t17, $Update'$1_Bbay_Products'_sr_number($Dereference($t17), $Dereference($t29)));

    // $t30 := borrow_field<Bbay::Products>.item_price($t17) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:114:24+28
    assume {:print "$at(2,3475,3503)"} true;
    $t30 := $ChildMutation($t17, 4, $Dereference($t17)->$item_price);

    // table::add<u64, u64>($t30, $t6, $t4) on_abort goto L8 with $t12 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:114:13+53
    call $t30 := $1_table_add'u64_u64'($t30, $t6, $t4);
    if ($abort_flag) {
        assume {:print "$at(2,3464,3517)"} true;
        $t12 := $abort_code;
        assume {:print "$track_abort(24,0):", $t12} $t12 == $t12;
        goto L8;
    }

    // write_back[Reference($t17).item_price (table::Table<u64, u64>)]($t30) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:114:13+53
    $t17 := $UpdateMutation($t17, $Update'$1_Bbay_Products'_item_price($Dereference($t17), $Dereference($t30)));

    // $t31 := borrow_field<Bbay::Products>.item_on_selling($t17) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:115:24+33
    assume {:print "$at(2,3542,3575)"} true;
    $t31 := $ChildMutation($t17, 5, $Dereference($t17)->$item_on_selling);

    // table::add<u64, bool>($t31, $t6, $t5) on_abort goto L8 with $t12 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:115:13+62
    call $t31 := $1_table_add'u64_bool'($t31, $t6, $t5);
    if ($abort_flag) {
        assume {:print "$at(2,3531,3593)"} true;
        $t12 := $abort_code;
        assume {:print "$track_abort(24,0):", $t12} $t12 == $t12;
        goto L8;
    }

    // write_back[Reference($t17).item_on_selling (table::Table<u64, bool>)]($t31) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:115:13+62
    $t17 := $UpdateMutation($t17, $Update'$1_Bbay_Products'_item_on_selling($Dereference($t17), $Dereference($t31)));

    // label L3 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:117:33+15
    assume {:print "$at(2,3642,3657)"} true;
L3:

    // $t24 := read_ref($t18) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:117:32+16
    assume {:print "$at(2,3641,3657)"} true;
    $t24 := $Dereference($t18);

    // $t25 := 1 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:117:51+1
    $t25 := 1;
    assume $IsValid'u64'($t25);

    // $t26 := +($t24, $t25) on_abort goto L8 with $t12 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:117:49+1
    call $t26 := $AddU64($t24, $t25);
    if ($abort_flag) {
        assume {:print "$at(2,3658,3659)"} true;
        $t12 := $abort_code;
        assume {:print "$track_abort(24,0):", $t12} $t12 == $t12;
        goto L8;
    }

    // write_ref($t18, $t26) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:117:13+39
    $t18 := $UpdateMutation($t18, $t26);

    // $t27 := 1 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:118:19+1
    assume {:print "$at(2,3681,3682)"} true;
    $t27 := 1;
    assume $IsValid'u64'($t27);

    // $t28 := +($t6, $t27) on_abort goto L8 with $t12 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:118:18+1
    call $t28 := $AddU64($t6, $t27);
    if ($abort_flag) {
        assume {:print "$at(2,3680,3681)"} true;
        $t12 := $abort_code;
        assume {:print "$track_abort(24,0):", $t12} $t12 == $t12;
        goto L8;
    }

    // trace_local[i]($t28) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:118:13+1
    assume {:print "$track_local(24,0,6):", $t28} $t28 == $t28;

    // goto L6 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:118:20+1
    goto L6;

    // label L0 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:121:9+53
    assume {:print "$at(2,3704,3757)"} true;
L0:

    // write_back[Reference($t13).num_of_products_added (u64)]($t18) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:121:9+53
    assume {:print "$at(2,3704,3757)"} true;
    $t13 := $UpdateMutation($t13, $Update'$1_Bbay_Owner'_num_of_products_added($Dereference($t13), $Dereference($t18)));

    // write_back[Bbay::Owner@]($t13) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:121:9+53
    $1_Bbay_Owner_$memory := $ResourceUpdate($1_Bbay_Owner_$memory, $GlobalLocationAddress($t13),
        $Dereference($t13));

    // destroy($t18) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:121:9+53

    // $t32 := borrow_field<Bbay::Products>.item_id($t17) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:121:27+25
    $t32 := $ChildMutation($t17, 1, $Dereference($t17)->$item_id);

    // vector::push_back<u64>($t32, $t1) on_abort goto L8 with $t12 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:121:9+53
    call $t32 := $1_vector_push_back'u64'($t32, $t1);
    if ($abort_flag) {
        assume {:print "$at(2,3704,3757)"} true;
        $t12 := $abort_code;
        assume {:print "$track_abort(24,0):", $t12} $t12 == $t12;
        goto L8;
    }

    // write_back[Reference($t17).item_id (vector<u64>)]($t32) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:121:9+53
    $t17 := $UpdateMutation($t17, $Update'$1_Bbay_Products'_item_id($Dereference($t17), $Dereference($t32)));

    // $t33 := borrow_field<Bbay::Products>.item_name($t17) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:122:20+27
    assume {:print "$at(2,3778,3805)"} true;
    $t33 := $ChildMutation($t17, 2, $Dereference($t17)->$item_name);

    // table::add<u64, vector<u64>>($t33, $t1, $t2) on_abort goto L8 with $t12 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:122:9+59
    call $t33 := $1_table_add'u64_vec'u64''($t33, $t1, $t2);
    if ($abort_flag) {
        assume {:print "$at(2,3767,3826)"} true;
        $t12 := $abort_code;
        assume {:print "$track_abort(24,0):", $t12} $t12 == $t12;
        goto L8;
    }

    // write_back[Reference($t17).item_name (table::Table<u64, vector<u64>>)]($t33) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:122:9+59
    $t17 := $UpdateMutation($t17, $Update'$1_Bbay_Products'_item_name($Dereference($t17), $Dereference($t33)));

    // $t34 := borrow_field<Bbay::Products>.item_sold($t17) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:123:20+27
    assume {:print "$at(2,3847,3874)"} true;
    $t34 := $ChildMutation($t17, 3, $Dereference($t17)->$item_sold);

    // $t35 := false at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:123:57+5
    $t35 := false;
    assume $IsValid'bool'($t35);

    // table::add<u64, bool>($t34, $t1, $t35) on_abort goto L8 with $t12 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:123:9+54
    call $t34 := $1_table_add'u64_bool'($t34, $t1, $t35);
    if ($abort_flag) {
        assume {:print "$at(2,3836,3890)"} true;
        $t12 := $abort_code;
        assume {:print "$track_abort(24,0):", $t12} $t12 == $t12;
        goto L8;
    }

    // write_back[Reference($t17).item_sold (table::Table<u64, bool>)]($t34) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:123:9+54
    $t17 := $UpdateMutation($t17, $Update'$1_Bbay_Products'_item_sold($Dereference($t17), $Dereference($t34)));

    // write_back[Bbay::Products@]($t17) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:123:9+54
    $1_Bbay_Products_$memory := $ResourceUpdate($1_Bbay_Products_$memory, $GlobalLocationAddress($t17),
        $Dereference($t17));

    // goto L7 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:123:63+1
    goto L7;

    // label L6 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:121:9+53
    // Loop invariant checking block for the loop started with header: L5
    assume {:print "$at(2,3704,3757)"} true;
L6:

    // stop() at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:121:9+53
    assume {:print "$at(2,3704,3757)"} true;
    assume false;
    return;

    // label L7 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:125:5+1
    assume {:print "$at(2,3897,3898)"} true;
L7:

    // return () at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:125:5+1
    assume {:print "$at(2,3897,3898)"} true;
    return;

    // label L8 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:125:5+1
L8:

    // abort($t12) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:125:5+1
    assume {:print "$at(2,3897,3898)"} true;
    $abort_code := $t12;
    $abort_flag := true;
    return;

    // label L9 at <internal>:1:1+10
    assume {:print "$at(1,0,10)"} true;
L9:

    // destroy($t13) at <internal>:1:1+10
    assume {:print "$at(1,0,10)"} true;

    // goto L1 at <internal>:1:1+10
    goto L1;

    // label L10 at <internal>:1:1+10
L10:

    // destroy($t17) at <internal>:1:1+10
    assume {:print "$at(1,0,10)"} true;

    // goto L3 at <internal>:1:1+10
    goto L3;

}

// fun Bbay::get_resource_account [baseline] at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:153:5+196
procedure {:inline 1} $1_Bbay_get_resource_account(_$t0: int) returns ($ret0: int)
{
    // declare local variables
    var $t1: int;
    var $t2: $1_Bbay_Owner;
    var $t3: int;
    var $t4: Table int (int);
    var $t5: int;
    var $t0: int;
    var $temp_0'address': int;
    $t0 := _$t0;

    // bytecode translation starts here
    // trace_local[addr]($t0) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:153:5+1
    assume {:print "$at(2,5228,5229)"} true;
    assume {:print "$track_local(24,1,0):", $t0} $t0 == $t0;

    // $t1 := 0x1a at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:154:49+6
    assume {:print "$at(2,5349,5355)"} true;
    $t1 := 26;
    assume $IsValid'address'($t1);

    // $t2 := get_global<Bbay::Owner>($t1) on_abort goto L2 with $t3 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:154:28+13
    if (!$ResourceExists($1_Bbay_Owner_$memory, $t1)) {
        call $ExecFailureAbort();
    } else {
        $t2 := $ResourceValue($1_Bbay_Owner_$memory, $t1);
    }
    if ($abort_flag) {
        assume {:print "$at(2,5328,5341)"} true;
        $t3 := $abort_code;
        assume {:print "$track_abort(24,1):", $t3} $t3 == $t3;
        goto L2;
    }

    // $t4 := get_field<Bbay::Owner>.resource_account($t2) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:155:24+30
    assume {:print "$at(2,5381,5411)"} true;
    $t4 := $t2->$resource_account;

    // $t5 := table::borrow<address, address>($t4, $t0) on_abort goto L2 with $t3 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:155:10+51
    call $t5 := $1_table_borrow'address_address'($t4, $t0);
    if ($abort_flag) {
        assume {:print "$at(2,5367,5418)"} true;
        $t3 := $abort_code;
        assume {:print "$track_abort(24,1):", $t3} $t3 == $t3;
        goto L2;
    }

    // trace_return[0]($t5) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:155:9+52
    assume {:print "$track_return(24,1,0):", $t5} $t5 == $t5;

    // label L1 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:156:5+1
    assume {:print "$at(2,5423,5424)"} true;
L1:

    // return $t5 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:156:5+1
    assume {:print "$at(2,5423,5424)"} true;
    $ret0 := $t5;
    return;

    // label L2 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:156:5+1
L2:

    // abort($t3) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:156:5+1
    assume {:print "$at(2,5423,5424)"} true;
    $abort_code := $t3;
    $abort_flag := true;
    return;

}

// fun Bbay::get_resource_account [verification] at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:153:5+196
procedure {:timeLimit 40} $1_Bbay_get_resource_account$verify(_$t0: int) returns ($ret0: int)
{
    // declare local variables
    var $t1: int;
    var $t2: $1_Bbay_Owner;
    var $t3: int;
    var $t4: Table int (int);
    var $t5: int;
    var $t0: int;
    var $temp_0'address': int;
    $t0 := _$t0;

    // verification entrypoint assumptions
    call $InitVerification();

    // bytecode translation starts here
    // assume WellFormed($t0) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:153:5+1
    assume {:print "$at(2,5228,5229)"} true;
    assume $IsValid'address'($t0);

    // assume forall $rsc: Bbay::Owner: ResourceDomain<Bbay::Owner>(): WellFormed($rsc) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:153:5+1
    assume (forall $a_0: int :: {$ResourceValue($1_Bbay_Owner_$memory, $a_0)}(var $rsc := $ResourceValue($1_Bbay_Owner_$memory, $a_0);
    ($IsValid'$1_Bbay_Owner'($rsc))));

    // trace_local[addr]($t0) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:153:5+1
    assume {:print "$track_local(24,1,0):", $t0} $t0 == $t0;

    // $t1 := 0x1a at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:154:49+6
    assume {:print "$at(2,5349,5355)"} true;
    $t1 := 26;
    assume $IsValid'address'($t1);

    // $t2 := get_global<Bbay::Owner>($t1) on_abort goto L2 with $t3 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:154:28+13
    if (!$ResourceExists($1_Bbay_Owner_$memory, $t1)) {
        call $ExecFailureAbort();
    } else {
        $t2 := $ResourceValue($1_Bbay_Owner_$memory, $t1);
    }
    if ($abort_flag) {
        assume {:print "$at(2,5328,5341)"} true;
        $t3 := $abort_code;
        assume {:print "$track_abort(24,1):", $t3} $t3 == $t3;
        goto L2;
    }

    // $t4 := get_field<Bbay::Owner>.resource_account($t2) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:155:24+30
    assume {:print "$at(2,5381,5411)"} true;
    $t4 := $t2->$resource_account;

    // $t5 := table::borrow<address, address>($t4, $t0) on_abort goto L2 with $t3 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:155:10+51
    call $t5 := $1_table_borrow'address_address'($t4, $t0);
    if ($abort_flag) {
        assume {:print "$at(2,5367,5418)"} true;
        $t3 := $abort_code;
        assume {:print "$track_abort(24,1):", $t3} $t3 == $t3;
        goto L2;
    }

    // trace_return[0]($t5) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:155:9+52
    assume {:print "$track_return(24,1,0):", $t5} $t5 == $t5;

    // label L1 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:156:5+1
    assume {:print "$at(2,5423,5424)"} true;
L1:

    // return $t5 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:156:5+1
    assume {:print "$at(2,5423,5424)"} true;
    $ret0 := $t5;
    return;

    // label L2 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:156:5+1
L2:

    // abort($t3) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:156:5+1
    assume {:print "$at(2,5423,5424)"} true;
    $abort_code := $t3;
    $abort_flag := true;
    return;

}

// fun Bbay::init_module [verification] at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:64:5+259
procedure {:timeLimit 40} $1_Bbay_init_module$verify(_$t0: $signer) returns ()
{
    // declare local variables
    var $t1: int;
    var $t2: int;
    var $t3: int;
    var $t4: int;
    var $t5: Table int (int);
    var $t6: $1_Bbay_Owner;
    var $t0: $signer;
    var $temp_0'signer': $signer;
    $t0 := _$t0;

    // verification entrypoint assumptions
    call $InitVerification();

    // bytecode translation starts here
    // assume WellFormed($t0) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:64:5+1
    assume {:print "$at(2,1594,1595)"} true;
    assume $IsValid'signer'($t0) && $1_signer_is_txn_signer($t0) && $1_signer_is_txn_signer_addr($t0->$addr);

    // assume forall $rsc: Bbay::Owner: ResourceDomain<Bbay::Owner>(): WellFormed($rsc) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:64:5+1
    assume (forall $a_0: int :: {$ResourceValue($1_Bbay_Owner_$memory, $a_0)}(var $rsc := $ResourceValue($1_Bbay_Owner_$memory, $a_0);
    ($IsValid'$1_Bbay_Owner'($rsc))));

    // trace_local[account]($t0) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:64:5+1
    assume {:print "$track_local(24,2,0):", $t0} $t0 == $t0;

    // $t1 := signer::address_of($t0) on_abort goto L2 with $t2 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:67:28+27
    assume {:print "$at(2,1698,1725)"} true;
    call $t1 := $1_signer_address_of($t0);
    if ($abort_flag) {
        assume {:print "$at(2,1698,1725)"} true;
        $t2 := $abort_code;
        assume {:print "$track_abort(24,2):", $t2} $t2 == $t2;
        goto L2;
    }

    // $t3 := 0 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:68:25+1
    assume {:print "$at(2,1751,1752)"} true;
    $t3 := 0;
    assume $IsValid'u64'($t3);

    // $t4 := 0 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:69:35+1
    assume {:print "$at(2,1788,1789)"} true;
    $t4 := 0;
    assume $IsValid'u64'($t4);

    // $t5 := table::new<address, address>() on_abort goto L2 with $t2 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:70:32+12
    assume {:print "$at(2,1822,1834)"} true;
    call $t5 := $1_table_new'address_address'();
    if ($abort_flag) {
        assume {:print "$at(2,1822,1834)"} true;
        $t2 := $abort_code;
        assume {:print "$track_abort(24,2):", $t2} $t2 == $t2;
        goto L2;
    }

    // $t6 := pack Bbay::Owner($t1, $t3, $t4, $t5) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:66:26+182
    assume {:print "$at(2,1663,1845)"} true;
    $t6 := $1_Bbay_Owner($t1, $t3, $t4, $t5);

    // move_to<Bbay::Owner>($t6, $t0) on_abort goto L2 with $t2 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:66:9+7
    if ($ResourceExists($1_Bbay_Owner_$memory, $t0->$addr)) {
        call $ExecFailureAbort();
    } else {
        $1_Bbay_Owner_$memory := $ResourceUpdate($1_Bbay_Owner_$memory, $t0->$addr, $t6);
    }
    if ($abort_flag) {
        assume {:print "$at(2,1646,1653)"} true;
        $t2 := $abort_code;
        assume {:print "$track_abort(24,2):", $t2} $t2 == $t2;
        goto L2;
    }

    // label L1 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:72:5+1
    assume {:print "$at(2,1852,1853)"} true;
L1:

    // return () at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:72:5+1
    assume {:print "$at(2,1852,1853)"} true;
    return;

    // label L2 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:72:5+1
L2:

    // abort($t2) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:72:5+1
    assume {:print "$at(2,1852,1853)"} true;
    $abort_code := $t2;
    $abort_flag := true;
    return;

}

// fun Bbay::order [verification] at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:128:5+995
procedure {:timeLimit 40} $1_Bbay_order$verify(_$t0: $signer, _$t1: int, _$t2: int, _$t3: bool) returns ()
{
    // declare local variables
    var $t4: $1_Bbay_Products;
    var $t5: int;
    var $t6: $signer;
    var $t7: $Mutation ($1_Bbay_User);
    var $t8: int;
    var $t9: int;
    var $t10: int;
    var $t11: $1_Bbay_ResourceAccountSignerCap;
    var $t12: $1_account_SignerCapability;
    var $t13: int;
    var $t14: $signer;
    var $t15: $Mutation ($1_Bbay_User);
    var $t16: int;
    var $t17: $1_Bbay_Products;
    var $t18: $Mutation (Vec (int));
    var $t19: $Mutation (Vec (int));
    var $t20: int;
    var $t21: bool;
    var $t22: bool;
    var $t23: int;
    var $t24: Table int (int);
    var $t25: int;
    var $t26: $1_option_Option'$1_optional_aggregator_OptionalAggregator';
    var $t27: int;
    var $t28: $1_coin_CoinStore'#0';
    var $t29: $1_coin_CoinStore'#0';
    var $t30: $Mutation (Vec (int));
    var $t31: int;
    var $t32: $Mutation (Vec (int));
    var $t33: int;
    var $t0: $signer;
    var $t1: int;
    var $t2: int;
    var $t3: bool;
    var $temp_0'$1_Bbay_Products': $1_Bbay_Products;
    var $temp_0'$1_Bbay_User': $1_Bbay_User;
    var $temp_0'address': int;
    var $temp_0'bool': bool;
    var $temp_0'signer': $signer;
    var $temp_0'u64': int;
    $t0 := _$t0;
    $t1 := _$t1;
    $t2 := _$t2;
    $t3 := _$t3;

    // verification entrypoint assumptions
    call $InitVerification();

    // bytecode translation starts here
    // assume WellFormed($t0) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:128:5+1
    assume {:print "$at(2,3905,3906)"} true;
    assume $IsValid'signer'($t0) && $1_signer_is_txn_signer($t0) && $1_signer_is_txn_signer_addr($t0->$addr);

    // assume WellFormed($t1) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:128:5+1
    assume $IsValid'u64'($t1);

    // assume WellFormed($t2) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:128:5+1
    assume $IsValid'u64'($t2);

    // assume WellFormed($t3) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:128:5+1
    assume $IsValid'bool'($t3);

    // assume forall $rsc: coin::CoinInfo<#0>: ResourceDomain<coin::CoinInfo<#0>>(): And(WellFormed($rsc), And(Le(Len<optional_aggregator::OptionalAggregator>(select option::Option.vec(select coin::CoinInfo.supply($rsc))), 1), forall $elem: optional_aggregator::OptionalAggregator: select option::Option.vec(select coin::CoinInfo.supply($rsc)): And(And(And(And(And(Iff(option::$is_some<aggregator::Aggregator>(select optional_aggregator::OptionalAggregator.aggregator($elem)), option::$is_none<optional_aggregator::Integer>(select optional_aggregator::OptionalAggregator.integer($elem))), Iff(option::$is_some<optional_aggregator::Integer>(select optional_aggregator::OptionalAggregator.integer($elem)), option::$is_none<aggregator::Aggregator>(select optional_aggregator::OptionalAggregator.aggregator($elem)))), Implies(option::$is_some<optional_aggregator::Integer>(select optional_aggregator::OptionalAggregator.integer($elem)), Le(select optional_aggregator::Integer.value(option::$borrow<optional_aggregator::Integer>(select optional_aggregator::OptionalAggregator.integer($elem))), select optional_aggregator::Integer.limit(option::$borrow<optional_aggregator::Integer>(select optional_aggregator::OptionalAggregator.integer($elem)))))), Implies(option::$is_some<aggregator::Aggregator>(select optional_aggregator::OptionalAggregator.aggregator($elem)), Le(aggregator::spec_aggregator_get_val(option::$borrow<aggregator::Aggregator>(select optional_aggregator::OptionalAggregator.aggregator($elem))), aggregator::spec_get_limit(option::$borrow<aggregator::Aggregator>(select optional_aggregator::OptionalAggregator.aggregator($elem)))))), Le(Len<aggregator::Aggregator>(select option::Option.vec(select optional_aggregator::OptionalAggregator.aggregator($elem))), 1)), Le(Len<optional_aggregator::Integer>(select option::Option.vec(select optional_aggregator::OptionalAggregator.integer($elem))), 1)))) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:128:5+1
    assume (forall $a_0: int :: {$ResourceValue($1_coin_CoinInfo'#0'_$memory, $a_0)}(var $rsc := $ResourceValue($1_coin_CoinInfo'#0'_$memory, $a_0);
    (($IsValid'$1_coin_CoinInfo'#0''($rsc) && ((LenVec($rsc->$supply->$vec) <= 1) && (var $range_1 := $rsc->$supply->$vec; (forall $i_2: int :: InRangeVec($range_1, $i_2) ==> (var $elem := ReadVec($range_1, $i_2);
    ((((((($1_option_$is_some'$1_aggregator_Aggregator'($elem->$aggregator) <==> $1_option_$is_none'$1_optional_aggregator_Integer'($elem->$integer)) && ($1_option_$is_some'$1_optional_aggregator_Integer'($elem->$integer) <==> $1_option_$is_none'$1_aggregator_Aggregator'($elem->$aggregator))) && ($1_option_$is_some'$1_optional_aggregator_Integer'($elem->$integer) ==> ($1_option_$borrow'$1_optional_aggregator_Integer'($elem->$integer)->$value <= $1_option_$borrow'$1_optional_aggregator_Integer'($elem->$integer)->$limit))) && ($1_option_$is_some'$1_aggregator_Aggregator'($elem->$aggregator) ==> ($1_aggregator_spec_aggregator_get_val($1_option_$borrow'$1_aggregator_Aggregator'($elem->$aggregator)) <= $1_aggregator_spec_get_limit($1_option_$borrow'$1_aggregator_Aggregator'($elem->$aggregator))))) && (LenVec($elem->$aggregator->$vec) <= 1)) && (LenVec($elem->$integer->$vec) <= 1)))))))))));

    // assume forall $rsc: coin::CoinStore<#0>: ResourceDomain<coin::CoinStore<#0>>(): WellFormed($rsc) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:128:5+1
    assume (forall $a_0: int :: {$ResourceValue($1_coin_CoinStore'#0'_$memory, $a_0)}(var $rsc := $ResourceValue($1_coin_CoinStore'#0'_$memory, $a_0);
    ($IsValid'$1_coin_CoinStore'#0''($rsc))));

    // assume forall $rsc: coin::Ghost$supply<#0>: ResourceDomain<coin::Ghost$supply<#0>>(): WellFormed($rsc) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:128:5+1
    assume (forall $a_0: int :: {$ResourceValue($1_coin_Ghost$supply'#0'_$memory, $a_0)}(var $rsc := $ResourceValue($1_coin_Ghost$supply'#0'_$memory, $a_0);
    ($IsValid'$1_coin_Ghost$supply'#0''($rsc))));

    // assume exists<coin::Ghost$supply<#0>>(0x0) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:128:5+1
    assume $ResourceExists($1_coin_Ghost$supply'#0'_$memory, 0);

    // assume forall $rsc: coin::Ghost$aggregate_supply<#0>: ResourceDomain<coin::Ghost$aggregate_supply<#0>>(): WellFormed($rsc) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:128:5+1
    assume (forall $a_0: int :: {$ResourceValue($1_coin_Ghost$aggregate_supply'#0'_$memory, $a_0)}(var $rsc := $ResourceValue($1_coin_Ghost$aggregate_supply'#0'_$memory, $a_0);
    ($IsValid'$1_coin_Ghost$aggregate_supply'#0''($rsc))));

    // assume exists<coin::Ghost$aggregate_supply<#0>>(0x0) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:128:5+1
    assume $ResourceExists($1_coin_Ghost$aggregate_supply'#0'_$memory, 0);

    // assume forall $rsc: Bbay::Owner: ResourceDomain<Bbay::Owner>(): WellFormed($rsc) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:128:5+1
    assume (forall $a_0: int :: {$ResourceValue($1_Bbay_Owner_$memory, $a_0)}(var $rsc := $ResourceValue($1_Bbay_Owner_$memory, $a_0);
    ($IsValid'$1_Bbay_Owner'($rsc))));

    // assume forall $rsc: Bbay::Products: ResourceDomain<Bbay::Products>(): WellFormed($rsc) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:128:5+1
    assume (forall $a_0: int :: {$ResourceValue($1_Bbay_Products_$memory, $a_0)}(var $rsc := $ResourceValue($1_Bbay_Products_$memory, $a_0);
    ($IsValid'$1_Bbay_Products'($rsc))));

    // assume forall $rsc: Bbay::ResourceAccountSignerCap: ResourceDomain<Bbay::ResourceAccountSignerCap>(): WellFormed($rsc) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:128:5+1
    assume (forall $a_0: int :: {$ResourceValue($1_Bbay_ResourceAccountSignerCap_$memory, $a_0)}(var $rsc := $ResourceValue($1_Bbay_ResourceAccountSignerCap_$memory, $a_0);
    ($IsValid'$1_Bbay_ResourceAccountSignerCap'($rsc))));

    // assume forall $rsc: Bbay::User: ResourceDomain<Bbay::User>(): WellFormed($rsc) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:128:5+1
    assume (forall $a_0: int :: {$ResourceValue($1_Bbay_User_$memory, $a_0)}(var $rsc := $ResourceValue($1_Bbay_User_$memory, $a_0);
    ($IsValid'$1_Bbay_User'($rsc))));

    // trace_local[account]($t0) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:128:5+1
    assume {:print "$track_local(24,3,0):", $t0} $t0 == $t0;

    // trace_local[item_id]($t1) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:128:5+1
    assume {:print "$track_local(24,3,1):", $t1} $t1 == $t1;

    // trace_local[sr_no]($t2) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:128:5+1
    assume {:print "$track_local(24,3,2):", $t2} $t2 == $t2;

    // trace_local[prepaid]($t3) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:128:5+1
    assume {:print "$track_local(24,3,3):", $t3} $t3 == $t3;

    // $t8 := signer::address_of($t0) on_abort goto L4 with $t9 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:129:53+27
    assume {:print "$at(2,4097,4124)"} true;
    call $t8 := $1_signer_address_of($t0);
    if ($abort_flag) {
        assume {:print "$at(2,4097,4124)"} true;
        $t9 := $abort_code;
        assume {:print "$track_abort(24,3):", $t9} $t9 == $t9;
        goto L4;
    }

    // $t10 := Bbay::get_resource_account($t8) on_abort goto L4 with $t9 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:129:32+49
    call $t10 := $1_Bbay_get_resource_account($t8);
    if ($abort_flag) {
        assume {:print "$at(2,4076,4125)"} true;
        $t9 := $abort_code;
        assume {:print "$track_abort(24,3):", $t9} $t9 == $t9;
        goto L4;
    }

    // trace_local[resource_account]($t10) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:129:13+16
    assume {:print "$track_local(24,3,5):", $t10} $t10 == $t10;

    // $t11 := get_global<Bbay::ResourceAccountSignerCap>($t10) on_abort goto L4 with $t9 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:130:26+13
    assume {:print "$at(2,4152,4165)"} true;
    if (!$ResourceExists($1_Bbay_ResourceAccountSignerCap_$memory, $t10)) {
        call $ExecFailureAbort();
    } else {
        $t11 := $ResourceValue($1_Bbay_ResourceAccountSignerCap_$memory, $t10);
    }
    if ($abort_flag) {
        assume {:print "$at(2,4152,4165)"} true;
        $t9 := $abort_code;
        assume {:print "$track_abort(24,3):", $t9} $t9 == $t9;
        goto L4;
    }

    // $t12 := get_field<Bbay::ResourceAccountSignerCap>.signer_cap($t11) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:131:78+22
    assume {:print "$at(2,4288,4310)"} true;
    $t12 := $t11->$signer_cap;

    // assume Identical($t13, select account::SignerCapability.account($t12)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:518:9+30
    assume {:print "$at(82,24860,24890)"} true;
    assume ($t13 == $t12->$account);

    // $t14 := account::create_signer_with_capability($t12) on_abort goto L4 with $t9 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:131:39+62
    assume {:print "$at(2,4249,4311)"} true;
    call $t14 := $1_account_create_signer_with_capability($t12);
    if ($abort_flag) {
        assume {:print "$at(2,4249,4311)"} true;
        $t9 := $abort_code;
        assume {:print "$track_abort(24,3):", $t9} $t9 == $t9;
        goto L4;
    }

    // trace_local[resource_account_signer]($t14) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:131:13+23
    assume {:print "$track_local(24,3,6):", $t14} $t14 == $t14;

    // $t15 := borrow_global<Bbay::User>($t10) on_abort goto L4 with $t9 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:132:25+17
    assume {:print "$at(2,4337,4354)"} true;
    if (!$ResourceExists($1_Bbay_User_$memory, $t10)) {
        call $ExecFailureAbort();
    } else {
        $t15 := $Mutation($Global($t10), EmptyVec(), $ResourceValue($1_Bbay_User_$memory, $t10));
    }
    if ($abort_flag) {
        assume {:print "$at(2,4337,4354)"} true;
        $t9 := $abort_code;
        assume {:print "$track_abort(24,3):", $t9} $t9 == $t9;
        goto L4;
    }

    // trace_local[user_data]($t15) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:132:13+9
    $temp_0'$1_Bbay_User' := $Dereference($t15);
    assume {:print "$track_local(24,3,7):", $temp_0'$1_Bbay_User'} $temp_0'$1_Bbay_User' == $temp_0'$1_Bbay_User';

    // $t16 := 0x1a at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:133:52+6
    assume {:print "$at(2,4431,4437)"} true;
    $t16 := 26;
    assume $IsValid'address'($t16);

    // $t17 := get_global<Bbay::Products>($t16) on_abort goto L4 with $t9 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:133:28+13
    if (!$ResourceExists($1_Bbay_Products_$memory, $t16)) {
        call $ExecFailureAbort();
    } else {
        $t17 := $ResourceValue($1_Bbay_Products_$memory, $t16);
    }
    if ($abort_flag) {
        assume {:print "$at(2,4407,4420)"} true;
        $t9 := $abort_code;
        assume {:print "$track_abort(24,3):", $t9} $t9 == $t9;
        goto L4;
    }

    // trace_local[product_data]($t17) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:133:13+12
    assume {:print "$track_local(24,3,4):", $t17} $t17 == $t17;

    // $t18 := borrow_field<Bbay::User>.orders($t15) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:134:27+21
    assume {:print "$at(2,4466,4487)"} true;
    $t18 := $ChildMutation($t15, 1, $Dereference($t15)->$orders);

    // vector::push_back<u64>($t18, $t1) on_abort goto L4 with $t9 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:134:9+48
    call $t18 := $1_vector_push_back'u64'($t18, $t1);
    if ($abort_flag) {
        assume {:print "$at(2,4448,4496)"} true;
        $t9 := $abort_code;
        assume {:print "$track_abort(24,3):", $t9} $t9 == $t9;
        goto L4;
    }

    // write_back[Reference($t15).orders (vector<u64>)]($t18) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:134:9+48
    $t15 := $UpdateMutation($t15, $Update'$1_Bbay_User'_orders($Dereference($t15), $Dereference($t18)));

    // $t19 := borrow_field<Bbay::User>.order_status($t15) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:135:27+27
    assume {:print "$at(2,4524,4551)"} true;
    $t19 := $ChildMutation($t15, 2, $Dereference($t15)->$order_status);

    // $t20 := 1 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:135:55+12
    $t20 := 1;
    assume $IsValid'u64'($t20);

    // vector::push_back<u64>($t19, $t20) on_abort goto L4 with $t9 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:135:9+59
    call $t19 := $1_vector_push_back'u64'($t19, $t20);
    if ($abort_flag) {
        assume {:print "$at(2,4506,4565)"} true;
        $t9 := $abort_code;
        assume {:print "$track_abort(24,3):", $t9} $t9 == $t9;
        goto L4;
    }

    // write_back[Reference($t15).order_status (vector<u64>)]($t19) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:135:9+59
    $t15 := $UpdateMutation($t15, $Update'$1_Bbay_User'_order_status($Dereference($t15), $Dereference($t19)));

    // $t21 := true at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:136:23+4
    assume {:print "$at(2,4589,4593)"} true;
    $t21 := true;
    assume $IsValid'bool'($t21);

    // $t22 := ==($t3, $t21) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:136:20+2
    $t22 := $IsEqual'bool'($t3, $t21);

    // if ($t22) goto L1 else goto L0 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:136:9+317
    if ($t22) { goto L1; } else { goto L0; }

    // label L1 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:137:38+24
    assume {:print "$at(2,4633,4657)"} true;
L1:

    // $t23 := 0x1a at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:137:63+6
    assume {:print "$at(2,4658,4664)"} true;
    $t23 := 26;
    assume $IsValid'address'($t23);

    // $t24 := get_field<Bbay::Products>.item_price($t17) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:137:85+24
    $t24 := $t17->$item_price;

    // $t25 := table::borrow<u64, u64>($t24, $t2) on_abort goto L4 with $t9 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:137:71+45
    call $t25 := $1_table_borrow'u64_u64'($t24, $t2);
    if ($abort_flag) {
        assume {:print "$at(2,4666,4711)"} true;
        $t9 := $abort_code;
        assume {:print "$track_abort(24,3):", $t9} $t9 == $t9;
        goto L4;
    }

    // assume Identical($t26, select coin::CoinInfo.supply(global<coin::CoinInfo<#0>>(select type_info::TypeInfo.account_address(type_info::$type_of<#0>())))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:32:9+99
    assume {:print "$at(106,1664,1763)"} true;
    assume ($t26 == $ResourceValue($1_coin_CoinInfo'#0'_$memory, $1_type_info_TypeInfo(#0_info->a, #0_info->m, #0_info->s)->$account_address)->$supply);

    // assume Identical($t27, signer::$address_of($t14)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:375:9+49
    assume {:print "$at(106,16245,16294)"} true;
    assume ($t27 == $1_signer_$address_of($t14));

    // assume Identical($t28, global<coin::CoinStore<#0>>($t27)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:376:9+69
    assume {:print "$at(106,16303,16372)"} true;
    assume ($t28 == $ResourceValue($1_coin_CoinStore'#0'_$memory, $t27));

    // assume Identical($t29, global<coin::CoinStore<#0>>($t23)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:378:9+52
    assume {:print "$at(106,16469,16521)"} true;
    assume ($t29 == $ResourceValue($1_coin_CoinStore'#0'_$memory, $t23));

    // coin::transfer<#0>($t14, $t23, $t25) on_abort goto L4 with $t9 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:137:13+104
    assume {:print "$at(2,4608,4712)"} true;
    call $1_coin_transfer'#0'($t14, $t23, $t25);
    if ($abort_flag) {
        assume {:print "$at(2,4608,4712)"} true;
        $t9 := $abort_code;
        assume {:print "$track_abort(24,3):", $t9} $t9 == $t9;
        goto L4;
    }

    // $t30 := borrow_field<Bbay::User>.payment_status($t15) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:138:31+29
    assume {:print "$at(2,4744,4773)"} true;
    $t30 := $ChildMutation($t15, 3, $Dereference($t15)->$payment_status);

    // $t31 := 2 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:138:61+13
    $t31 := 2;
    assume $IsValid'u64'($t31);

    // vector::push_back<u64>($t30, $t31) on_abort goto L4 with $t9 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:138:13+62
    call $t30 := $1_vector_push_back'u64'($t30, $t31);
    if ($abort_flag) {
        assume {:print "$at(2,4726,4788)"} true;
        $t9 := $abort_code;
        assume {:print "$track_abort(24,3):", $t9} $t9 == $t9;
        goto L4;
    }

    // write_back[Reference($t15).payment_status (vector<u64>)]($t30) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:138:13+62
    $t15 := $UpdateMutation($t15, $Update'$1_Bbay_User'_payment_status($Dereference($t15), $Dereference($t30)));

    // write_back[Bbay::User@]($t15) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:138:13+62
    $1_Bbay_User_$memory := $ResourceUpdate($1_Bbay_User_$memory, $GlobalLocationAddress($t15),
        $Dereference($t15));

    // goto L2 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:138:75+1
    goto L2;

    // label L0 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:140:13+64
    assume {:print "$at(2,4817,4881)"} true;
L0:

    // $t32 := borrow_field<Bbay::User>.payment_status($t15) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:140:31+29
    assume {:print "$at(2,4835,4864)"} true;
    $t32 := $ChildMutation($t15, 3, $Dereference($t15)->$payment_status);

    // $t33 := 1 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:140:61+15
    $t33 := 1;
    assume $IsValid'u64'($t33);

    // vector::push_back<u64>($t32, $t33) on_abort goto L4 with $t9 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:140:13+64
    call $t32 := $1_vector_push_back'u64'($t32, $t33);
    if ($abort_flag) {
        assume {:print "$at(2,4817,4881)"} true;
        $t9 := $abort_code;
        assume {:print "$track_abort(24,3):", $t9} $t9 == $t9;
        goto L4;
    }

    // write_back[Reference($t15).payment_status (vector<u64>)]($t32) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:140:13+64
    $t15 := $UpdateMutation($t15, $Update'$1_Bbay_User'_payment_status($Dereference($t15), $Dereference($t32)));

    // write_back[Bbay::User@]($t15) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:140:13+64
    $1_Bbay_User_$memory := $ResourceUpdate($1_Bbay_User_$memory, $GlobalLocationAddress($t15),
        $Dereference($t15));

    // label L2 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:141:10+1
    assume {:print "$at(2,4892,4893)"} true;
L2:

    // label L3 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:143:5+1
    assume {:print "$at(2,4899,4900)"} true;
L3:

    // return () at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:143:5+1
    assume {:print "$at(2,4899,4900)"} true;
    return;

    // label L4 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:143:5+1
L4:

    // abort($t9) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:143:5+1
    assume {:print "$at(2,4899,4900)"} true;
    $abort_code := $t9;
    $abort_flag := true;
    return;

}

// fun Bbay::register_account [verification] at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:74:5+840
procedure {:timeLimit 40} $1_Bbay_register_account$verify(_$t0: $signer, _$t1: Vec (int)) returns ()
{
    // declare local variables
    var $t2: $Mutation ($1_Bbay_Owner);
    var $t3: $signer;
    var $t4: $1_account_SignerCapability;
    var $t5: int;
    var $t6: $Mutation ($1_Bbay_Owner);
    var $t7: int;
    var $t8: int;
    var $t9: int;
    var $t10: int;
    var $t11: $Mutation (int);
    var $t12: int;
    var $t13: int;
    var $t14: $1_account_Account;
    var $t15: Vec (int);
    var $t16: $signer;
    var $t17: $1_account_SignerCapability;
    var $t18: int;
    var $t19: Vec (int);
    var $t20: Vec (int);
    var $t21: Vec (int);
    var $t22: $1_Bbay_User;
    var $t23: $1_option_Option'$1_optional_aggregator_OptionalAggregator';
    var $t24: int;
    var $t25: $1_account_Account;
    var $t26: $1_Bbay_ResourceAccountSignerCap;
    var $t0: $signer;
    var $t1: Vec (int);
    var $temp_0'$1_Bbay_Owner': $1_Bbay_Owner;
    var $temp_0'$1_account_SignerCapability': $1_account_SignerCapability;
    var $temp_0'signer': $signer;
    var $temp_0'vec'u8'': Vec (int);
    $t0 := _$t0;
    $t1 := _$t1;

    // verification entrypoint assumptions
    call $InitVerification();

    // bytecode translation starts here
    // assume WellFormed($t0) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:74:5+1
    assume {:print "$at(2,1859,1860)"} true;
    assume $IsValid'signer'($t0) && $1_signer_is_txn_signer($t0) && $1_signer_is_txn_signer_addr($t0->$addr);

    // assume WellFormed($t1) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:74:5+1
    assume $IsValid'vec'u8''($t1);

    // assume forall $rsc: account::Account: ResourceDomain<account::Account>(): And(WellFormed($rsc), And(Le(Len<address>(select option::Option.vec(select account::CapabilityOffer.for(select account::Account.rotation_capability_offer($rsc)))), 1), Le(Len<address>(select option::Option.vec(select account::CapabilityOffer.for(select account::Account.signer_capability_offer($rsc)))), 1))) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:74:5+1
    assume (forall $a_0: int :: {$ResourceValue($1_account_Account_$memory, $a_0)}(var $rsc := $ResourceValue($1_account_Account_$memory, $a_0);
    (($IsValid'$1_account_Account'($rsc) && ((LenVec($rsc->$rotation_capability_offer->$for->$vec) <= 1) && (LenVec($rsc->$signer_capability_offer->$for->$vec) <= 1))))));

    // assume forall $rsc: coin::CoinInfo<aptos_coin::AptosCoin>: ResourceDomain<coin::CoinInfo<aptos_coin::AptosCoin>>(): And(WellFormed($rsc), And(Le(Len<optional_aggregator::OptionalAggregator>(select option::Option.vec(select coin::CoinInfo.supply($rsc))), 1), forall $elem: optional_aggregator::OptionalAggregator: select option::Option.vec(select coin::CoinInfo.supply($rsc)): And(And(And(And(And(Iff(option::$is_some<aggregator::Aggregator>(select optional_aggregator::OptionalAggregator.aggregator($elem)), option::$is_none<optional_aggregator::Integer>(select optional_aggregator::OptionalAggregator.integer($elem))), Iff(option::$is_some<optional_aggregator::Integer>(select optional_aggregator::OptionalAggregator.integer($elem)), option::$is_none<aggregator::Aggregator>(select optional_aggregator::OptionalAggregator.aggregator($elem)))), Implies(option::$is_some<optional_aggregator::Integer>(select optional_aggregator::OptionalAggregator.integer($elem)), Le(select optional_aggregator::Integer.value(option::$borrow<optional_aggregator::Integer>(select optional_aggregator::OptionalAggregator.integer($elem))), select optional_aggregator::Integer.limit(option::$borrow<optional_aggregator::Integer>(select optional_aggregator::OptionalAggregator.integer($elem)))))), Implies(option::$is_some<aggregator::Aggregator>(select optional_aggregator::OptionalAggregator.aggregator($elem)), Le(aggregator::spec_aggregator_get_val(option::$borrow<aggregator::Aggregator>(select optional_aggregator::OptionalAggregator.aggregator($elem))), aggregator::spec_get_limit(option::$borrow<aggregator::Aggregator>(select optional_aggregator::OptionalAggregator.aggregator($elem)))))), Le(Len<aggregator::Aggregator>(select option::Option.vec(select optional_aggregator::OptionalAggregator.aggregator($elem))), 1)), Le(Len<optional_aggregator::Integer>(select option::Option.vec(select optional_aggregator::OptionalAggregator.integer($elem))), 1)))) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:74:5+1
    assume (forall $a_0: int :: {$ResourceValue($1_coin_CoinInfo'$1_aptos_coin_AptosCoin'_$memory, $a_0)}(var $rsc := $ResourceValue($1_coin_CoinInfo'$1_aptos_coin_AptosCoin'_$memory, $a_0);
    (($IsValid'$1_coin_CoinInfo'$1_aptos_coin_AptosCoin''($rsc) && ((LenVec($rsc->$supply->$vec) <= 1) && (var $range_1 := $rsc->$supply->$vec; (forall $i_2: int :: InRangeVec($range_1, $i_2) ==> (var $elem := ReadVec($range_1, $i_2);
    ((((((($1_option_$is_some'$1_aggregator_Aggregator'($elem->$aggregator) <==> $1_option_$is_none'$1_optional_aggregator_Integer'($elem->$integer)) && ($1_option_$is_some'$1_optional_aggregator_Integer'($elem->$integer) <==> $1_option_$is_none'$1_aggregator_Aggregator'($elem->$aggregator))) && ($1_option_$is_some'$1_optional_aggregator_Integer'($elem->$integer) ==> ($1_option_$borrow'$1_optional_aggregator_Integer'($elem->$integer)->$value <= $1_option_$borrow'$1_optional_aggregator_Integer'($elem->$integer)->$limit))) && ($1_option_$is_some'$1_aggregator_Aggregator'($elem->$aggregator) ==> ($1_aggregator_spec_aggregator_get_val($1_option_$borrow'$1_aggregator_Aggregator'($elem->$aggregator)) <= $1_aggregator_spec_get_limit($1_option_$borrow'$1_aggregator_Aggregator'($elem->$aggregator))))) && (LenVec($elem->$aggregator->$vec) <= 1)) && (LenVec($elem->$integer->$vec) <= 1)))))))))));

    // assume forall $rsc: coin::CoinStore<aptos_coin::AptosCoin>: ResourceDomain<coin::CoinStore<aptos_coin::AptosCoin>>(): WellFormed($rsc) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:74:5+1
    assume (forall $a_0: int :: {$ResourceValue($1_coin_CoinStore'$1_aptos_coin_AptosCoin'_$memory, $a_0)}(var $rsc := $ResourceValue($1_coin_CoinStore'$1_aptos_coin_AptosCoin'_$memory, $a_0);
    ($IsValid'$1_coin_CoinStore'$1_aptos_coin_AptosCoin''($rsc))));

    // assume forall $rsc: coin::Ghost$supply<aptos_coin::AptosCoin>: ResourceDomain<coin::Ghost$supply<aptos_coin::AptosCoin>>(): WellFormed($rsc) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:74:5+1
    assume (forall $a_0: int :: {$ResourceValue($1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'_$memory, $a_0)}(var $rsc := $ResourceValue($1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'_$memory, $a_0);
    ($IsValid'$1_coin_Ghost$supply'$1_aptos_coin_AptosCoin''($rsc))));

    // assume exists<coin::Ghost$supply<aptos_coin::AptosCoin>>(0x0) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:74:5+1
    assume $ResourceExists($1_coin_Ghost$supply'$1_aptos_coin_AptosCoin'_$memory, 0);

    // assume forall $rsc: coin::Ghost$aggregate_supply<aptos_coin::AptosCoin>: ResourceDomain<coin::Ghost$aggregate_supply<aptos_coin::AptosCoin>>(): WellFormed($rsc) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:74:5+1
    assume (forall $a_0: int :: {$ResourceValue($1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'_$memory, $a_0)}(var $rsc := $ResourceValue($1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'_$memory, $a_0);
    ($IsValid'$1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin''($rsc))));

    // assume exists<coin::Ghost$aggregate_supply<aptos_coin::AptosCoin>>(0x0) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:74:5+1
    assume $ResourceExists($1_coin_Ghost$aggregate_supply'$1_aptos_coin_AptosCoin'_$memory, 0);

    // assume forall $rsc: Bbay::Owner: ResourceDomain<Bbay::Owner>(): WellFormed($rsc) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:74:5+1
    assume (forall $a_0: int :: {$ResourceValue($1_Bbay_Owner_$memory, $a_0)}(var $rsc := $ResourceValue($1_Bbay_Owner_$memory, $a_0);
    ($IsValid'$1_Bbay_Owner'($rsc))));

    // assume forall $rsc: Bbay::ResourceAccountSignerCap: ResourceDomain<Bbay::ResourceAccountSignerCap>(): WellFormed($rsc) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:74:5+1
    assume (forall $a_0: int :: {$ResourceValue($1_Bbay_ResourceAccountSignerCap_$memory, $a_0)}(var $rsc := $ResourceValue($1_Bbay_ResourceAccountSignerCap_$memory, $a_0);
    ($IsValid'$1_Bbay_ResourceAccountSignerCap'($rsc))));

    // assume forall $rsc: Bbay::User: ResourceDomain<Bbay::User>(): WellFormed($rsc) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:74:5+1
    assume (forall $a_0: int :: {$ResourceValue($1_Bbay_User_$memory, $a_0)}(var $rsc := $ResourceValue($1_Bbay_User_$memory, $a_0);
    ($IsValid'$1_Bbay_User'($rsc))));

    // trace_local[account]($t0) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:74:5+1
    assume {:print "$track_local(24,4,0):", $t0} $t0 == $t0;

    // trace_local[seed]($t1) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:74:5+1
    assume {:print "$track_local(24,4,1):", $t1} $t1 == $t1;

    // $t5 := 0x1a at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:75:51+6
    assume {:print "$at(2,1993,1999)"} true;
    $t5 := 26;
    assume $IsValid'address'($t5);

    // $t6 := borrow_global<Bbay::Owner>($t5) on_abort goto L2 with $t7 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:75:26+17
    if (!$ResourceExists($1_Bbay_Owner_$memory, $t5)) {
        call $ExecFailureAbort();
    } else {
        $t6 := $Mutation($Global($t5), EmptyVec(), $ResourceValue($1_Bbay_Owner_$memory, $t5));
    }
    if ($abort_flag) {
        assume {:print "$at(2,1968,1985)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(24,4):", $t7} $t7 == $t7;
        goto L2;
    }

    // trace_local[owner_data]($t6) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:75:13+10
    $temp_0'$1_Bbay_Owner' := $Dereference($t6);
    assume {:print "$track_local(24,4,2):", $temp_0'$1_Bbay_Owner'} $temp_0'$1_Bbay_Owner' == $temp_0'$1_Bbay_Owner';

    // $t8 := get_field<Bbay::Owner>.user_count($t6) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:76:33+21
    assume {:print "$at(2,2034,2055)"} true;
    $t8 := $Dereference($t6)->$user_count;

    // $t9 := 1 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:76:56+1
    $t9 := 1;
    assume $IsValid'u64'($t9);

    // $t10 := +($t8, $t9) on_abort goto L2 with $t7 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:76:55+1
    call $t10 := $AddU64($t8, $t9);
    if ($abort_flag) {
        assume {:print "$at(2,2056,2057)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(24,4):", $t7} $t7 == $t7;
        goto L2;
    }

    // $t11 := borrow_field<Bbay::Owner>.user_count($t6) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:76:9+21
    $t11 := $ChildMutation($t6, 1, $Dereference($t6)->$user_count);

    // write_ref($t11, $t10) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:76:9+48
    $t11 := $UpdateMutation($t11, $t10);

    // write_back[Reference($t6).user_count (u64)]($t11) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:76:9+48
    $t6 := $UpdateMutation($t6, $Update'$1_Bbay_Owner'_user_count($Dereference($t6), $Dereference($t11)));

    // assume Identical($t12, signer::$address_of($t0)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:450:9+45
    assume {:print "$at(82,22000,22045)"} true;
    assume ($t12 == $1_signer_$address_of($t0));

    // assume Identical($t13, account::spec_create_resource_address($t12, $t1)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:451:9+68
    assume {:print "$at(82,22054,22122)"} true;
    assume ($t13 == $1_account_spec_create_resource_address($t12, $t1));

    // assume Identical($t14, global<account::Account>($t13)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:524:9+45
    assume {:print "$at(82,25038,25083)"} true;
    assume ($t14 == $ResourceValue($1_account_Account_$memory, $t13));

    // assume Identical($t15, bcs::$to_bytes<address>($t13)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/account.spec.move:54:9+45
    assume {:print "$at(82,2155,2200)"} true;
    assume ($t15 == $1_bcs_$to_bytes'address'($t13));

    // ($t16, $t17) := account::create_resource_account($t0, $t1) on_abort goto L2 with $t7 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:80:63+47
    assume {:print "$at(2,2234,2281)"} true;
    call $t16,$t17 := $1_account_create_resource_account($t0, $t1);
    if ($abort_flag) {
        assume {:print "$at(2,2234,2281)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(24,4):", $t7} $t7 == $t7;
        goto L2;
    }

    // trace_local[resource_account_signer_cap]($t17) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:80:32+27
    assume {:print "$track_local(24,4,4):", $t17} $t17 == $t17;

    // trace_local[resource_account]($t16) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:80:14+16
    assume {:print "$track_local(24,4,3):", $t16} $t16 == $t16;

    // $t18 := get_field<Bbay::Owner>.user_count($t6) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:82:22+21
    assume {:print "$at(2,2344,2365)"} true;
    $t18 := $Dereference($t6)->$user_count;

    // write_back[Bbay::Owner@]($t6) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:82:22+21
    $1_Bbay_Owner_$memory := $ResourceUpdate($1_Bbay_Owner_$memory, $GlobalLocationAddress($t6),
        $Dereference($t6));

    // $t19 := vector::empty<u64>() on_abort goto L2 with $t7 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:83:21+15
    assume {:print "$at(2,2387,2402)"} true;
    call $t19 := $1_vector_empty'u64'();
    if ($abort_flag) {
        assume {:print "$at(2,2387,2402)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(24,4):", $t7} $t7 == $t7;
        goto L2;
    }

    // $t20 := vector::empty<u64>() on_abort goto L2 with $t7 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:84:27+15
    assume {:print "$at(2,2430,2445)"} true;
    call $t20 := $1_vector_empty'u64'();
    if ($abort_flag) {
        assume {:print "$at(2,2430,2445)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(24,4):", $t7} $t7 == $t7;
        goto L2;
    }

    // $t21 := vector::empty<u64>() on_abort goto L2 with $t7 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:85:29+15
    assume {:print "$at(2,2475,2490)"} true;
    call $t21 := $1_vector_empty'u64'();
    if ($abort_flag) {
        assume {:print "$at(2,2475,2490)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(24,4):", $t7} $t7 == $t7;
        goto L2;
    }

    // $t22 := pack Bbay::User($t18, $t19, $t20, $t21) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:81:35+184
    assume {:print "$at(2,2317,2501)"} true;
    $t22 := $1_Bbay_User($t18, $t19, $t20, $t21);

    // move_to<Bbay::User>($t22, $t16) on_abort goto L2 with $t7 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:81:9+7
    if ($ResourceExists($1_Bbay_User_$memory, $t16->$addr)) {
        call $ExecFailureAbort();
    } else {
        $1_Bbay_User_$memory := $ResourceUpdate($1_Bbay_User_$memory, $t16->$addr, $t22);
    }
    if ($abort_flag) {
        assume {:print "$at(2,2291,2298)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(24,4):", $t7} $t7 == $t7;
        goto L2;
    }

    // assume Identical($t23, select coin::CoinInfo.supply(global<coin::CoinInfo<aptos_coin::AptosCoin>>(select type_info::TypeInfo.account_address(type_info::$type_of<aptos_coin::AptosCoin>())))) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:32:9+99
    assume {:print "$at(106,1664,1763)"} true;
    assume ($t23 == $ResourceValue($1_coin_CoinInfo'$1_aptos_coin_AptosCoin'_$memory, $1_type_info_TypeInfo(1, Vec(DefaultVecMap()[0 := 97][1 := 112][2 := 116][3 := 111][4 := 115][5 := 95][6 := 99][7 := 111][8 := 105][9 := 110], 10), Vec(DefaultVecMap()[0 := 65][1 := 112][2 := 116][3 := 111][4 := 115][5 := 67][6 := 111][7 := 105][8 := 110], 9))->$account_address)->$supply);

    // assume Identical($t24, signer::$address_of($t16)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:358:9+47
    assume {:print "$at(106,15395,15442)"} true;
    assume ($t24 == $1_signer_$address_of($t16));

    // assume Identical($t25, global<account::Account>($t24)) at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/sources/coin.spec.move:359:9+49
    assume {:print "$at(106,15451,15500)"} true;
    assume ($t25 == $ResourceValue($1_account_Account_$memory, $t24));

    // coin::register<aptos_coin::AptosCoin>($t16) on_abort goto L2 with $t7 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:88:9+44
    assume {:print "$at(2,2513,2557)"} true;
    call $1_coin_register'$1_aptos_coin_AptosCoin'($t16);
    if ($abort_flag) {
        assume {:print "$at(2,2513,2557)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(24,4):", $t7} $t7 == $t7;
        goto L2;
    }

    // $t26 := pack Bbay::ResourceAccountSignerCap($t17) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:89:36+88
    assume {:print "$at(2,2594,2682)"} true;
    $t26 := $1_Bbay_ResourceAccountSignerCap($t17);

    // move_to<Bbay::ResourceAccountSignerCap>($t26, $t16) on_abort goto L2 with $t7 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:89:9+7
    if ($ResourceExists($1_Bbay_ResourceAccountSignerCap_$memory, $t16->$addr)) {
        call $ExecFailureAbort();
    } else {
        $1_Bbay_ResourceAccountSignerCap_$memory := $ResourceUpdate($1_Bbay_ResourceAccountSignerCap_$memory, $t16->$addr, $t26);
    }
    if ($abort_flag) {
        assume {:print "$at(2,2567,2574)"} true;
        $t7 := $abort_code;
        assume {:print "$track_abort(24,4):", $t7} $t7 == $t7;
        goto L2;
    }

    // label L1 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:93:5+1
    assume {:print "$at(2,2698,2699)"} true;
L1:

    // return () at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:93:5+1
    assume {:print "$at(2,2698,2699)"} true;
    return;

    // label L2 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:93:5+1
L2:

    // abort($t7) at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:93:5+1
    assume {:print "$at(2,2698,2699)"} true;
    $abort_code := $t7;
    $abort_flag := true;
    return;

}

// fun Bbay::trigger_delivery [verification] at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:146:5+37
procedure {:timeLimit 40} $1_Bbay_trigger_delivery$verify() returns ()
{
    // declare local variables

    // verification entrypoint assumptions
    call $InitVerification();

    // bytecode translation starts here
    // label L1 at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:146:41+1
    assume {:print "$at(2,5205,5206)"} true;
L1:

    // return () at /home/codezeros/Desktop/move_aptos/Supply_chain/sources/supply_chain.move:146:41+1
    assume {:print "$at(2,5205,5206)"} true;
    return;

}

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/hash.spec.move:7:9+50
function  $1_aptos_hash_spec_keccak256(bytes: Vec (int)): Vec (int);
axiom (forall bytes: Vec (int) ::
(var $$res := $1_aptos_hash_spec_keccak256(bytes);
$IsValid'vec'u8''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/hash.spec.move:12:9+58
function  $1_aptos_hash_spec_sha2_512_internal(bytes: Vec (int)): Vec (int);
axiom (forall bytes: Vec (int) ::
(var $$res := $1_aptos_hash_spec_sha2_512_internal(bytes);
$IsValid'vec'u8''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/hash.spec.move:17:9+58
function  $1_aptos_hash_spec_sha3_512_internal(bytes: Vec (int)): Vec (int);
axiom (forall bytes: Vec (int) ::
(var $$res := $1_aptos_hash_spec_sha3_512_internal(bytes);
$IsValid'vec'u8''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/hash.spec.move:22:9+59
function  $1_aptos_hash_spec_ripemd160_internal(bytes: Vec (int)): Vec (int);
axiom (forall bytes: Vec (int) ::
(var $$res := $1_aptos_hash_spec_ripemd160_internal(bytes);
$IsValid'vec'u8''($$res)));

// spec fun at /home/codezeros/.move/https___github_com_aptos-labs_aptos-core_git_mainnet/aptos-move/framework/aptos-framework/../aptos-stdlib/sources/hash.spec.move:27:9+61
function  $1_aptos_hash_spec_blake2b_256_internal(bytes: Vec (int)): Vec (int);
axiom (forall bytes: Vec (int) ::
(var $$res := $1_aptos_hash_spec_blake2b_256_internal(bytes);
$IsValid'vec'u8''($$res)));
