# author: Kaan Eraslan
# license: see, LICENSE
# mimicks json from standard module

import tables
import hashes

type
    VertexDataKind* = enum ## enum object for holding vertex data
        VNull,
        VString,
        VBool,
        VFloat,
        VInt,
        VObject,
        VArray

    VertexData* = ref VertexDataObj
    VertexDataObj*{.acyclic.} = object
        case kind*: VertexDataKind
        of VString:
            str*: string
        of VInt:
            num*: BiggestInt
        of VBool:
            bval*: bool
        of VFloat:
            fnum*: float
        of VNull:
            nil
        of VObject:
            fields*: OrderedTable[string, VertexData]
        of VArray:
            elems*: seq[VertexData]

## basic operators

proc `$` (x: VertexData): string =
    return "Vertex data: " & $(x.kind) & $(x)

proc toString*(data: VertexData): string =
    ## vertex data string representation
    case data.kind
    of VString:
        return $(data.str)
    of VInt:
        return $(data.num)
    of VBool:
        return $(data.bval)
    of VFloat:
        return $(data.fnum)
    of VNull:
        return ""
    of VObject:
        return $(data.fields)
    of VArray:
        return $(data.elems)

proc `==`*(a, b: VertexData): bool =
    ## compare two vertex data
    if a.isNil:
        if b.isNil: return true
        return false
    elif b.isNil or a.kind != b.kind:
        return false
    else:
        case a.kind
        of VString:
            result = a.str == b.str
        of VInt:
            result = a.num == b.num
        of VFloat:
            result = a.fnum == b.fnum
        of VBool:
            result = a.bval == b.bval
        of VNull:
            result = true
        of VArray:
            result = a.elems == b.elems
        of VObject:
            if a.fields.len() != b.fields.len(): return false
            for key, val in a.fields:
                if not b.fields.hasKey(key): return false
                if b.fields[key] != val: return false
            result = true

proc len*(data: VertexData): int =
    ## return length of data
    case data.kind
    of VArray: return data.elems.len()
    of VObject: return data.fields.len()
    of VString: return data.str.len()
    else: return 0

proc hash*(data: VertexData): Hash =
    ## hash vertex data
    case data.kind
    of VArray: return hash(data.elems)
    of VObject:
        var h: Hash = 0
        for key, val in data.fields:
            h = h !& hash(key)
            h = h !& hash(val)
        return !$h
    of VInt: return hash(data.num)
    of VFloat: return hash(data.fnum)
    of VBool: return hash(data.bval)
    of VNull: return !$0
    of VString: return hash(data.str)

proc newVNull*(): VertexData =
    # new vertex data as null
    result = VertexData(kind: VNull)

proc newVInt*(nb: BiggestInt | int): VertexData =
    # new vertex data as int
    result = VertexData(kind: VInt, num: BiggestInt(nb))

proc newVString*(s: string): VertexData =
    # new vertex data as string
    result = VertexData(kind: VString, str: s)

proc newVBool*(b: bool): VertexData =
    # new vertex data as bool
    result = VertexData(kind: VBool, bval: b)

proc newVFloat*(f: float): VertexData =
    # new vertex data as float
    result = VertexData(kind: VFloat, fnum: f)

proc newVObject*(fs: OrderedTable[string, VertexData]): VertexData =
    # new vertex data as object
    result = VertexData(kind: VObject,
                        fields: fs)

proc newVArray*(arr: seq[VertexData]): VertexData =
    # new vertex data as array
    result = VertexData(kind: VArray, elems: arr)

proc getStr*(node: VertexData, default: string = ""): string =
    # retrieves text
    if node.isNil or node.kind != VString: return default
    else: return node.str

proc getInt*(node: VertexData, default: int = 0): int =
    # retrieves int
    if node.isNil or node.kind != VInt: return default
    else: return int(node.num)

proc getBiggestInt*(node: VertexData, default: BiggestInt = 0): BiggestInt =
    # retrieves BiggestInt
    if node.isNil or node.kind != VInt: return default
    else: return node.num

proc getFloat*(node: VertexData, default: float = 0): float =
    # retrieves float
    if node.isNil or node.kind != VFloat: return default
    else: return node.fnum

proc getBool*(node: VertexData, default: bool = false): bool =
    # retrieves boolean val
    if node.isNil or node.kind != VBool: return default
    else: return node.bval

proc getObject*(node: VertexData, default = initOrderedTable[string,
                                                             VertexData](4)
    ): OrderedTable[string, VertexData] =
    # retrieves object
    if node.isNil or node.kind != VObject: return default
    else: return node.fields

proc getArray*(node: VertexData, default: seq[VertexData] = @[]): seq[VertexData] =
    # retrieves vertex array
    if node.isNil or node.kind != VArray: return default
    else: return node.elems
