# tests vdata.nim
# author: Kaan Eraslan
# license: see, LICENSE

import vdata
import tables
import unittest

suite "test vdata.nim":

    echo "------------------------"
    echo "VertexData tests starts:"
    echo "------------------------"

    test "start vertex data null":
        let vnl = vdata.newVNull()
        check(vnl of vdata.VertexData)

    test "start vertex data string":
        let vns = vdata.newVString(s = "my string")
        check(vns of vdata.VertexData)

    test "start vertex data int":
        let vd = vdata.newVInt(nb = int(1235861))
        check(vd of vdata.VertexData)

    test "start vertex data biggest int":
        let vd = vdata.newVInt(nb = BiggestInt(1235861))
        check(vd of vdata.VertexData)

    test "start vertex data bool":
        let vd = vdata.newVBool(b = true)
        check(vd of vdata.VertexData)

    test "start vertex data float":
        let vd = vdata.newVFloat(f = 0.432)
        check(vd of vdata.VertexData)

    test "start vertex data object":
        var mytable: OrderedTable[string, VertexData]
        mytable.add("my key string", newVInt(135))
        let vd = vdata.newVObject(mytable)
        check(vd of vdata.VertexData)

    test "start vertex data array":
        let vd1 = vdata.newVString(s = "my string")
        let vd2 = vdata.newVInt(nb = int(1235861))
        let vd = vdata.newVArray(arr = @[vd1, vd2])
        check(vd of vdata.VertexData)

    test "get vertex data string":
        let vd = vdata.newVString(s = "my string")
        check(vd.getStr() == "my string")

    test "get vertex data int":
        let vd = vdata.newVInt(nb = int(1235861))
        check(vd.getInt() == 1235861)

    test "get vertex data bool":
        let vd = vdata.newVBool(b = true)
        check(vd.getBool() == true)

    test "get vertex data float":
        let vd = vdata.newVFloat(f = 0.432)
        check(vd.getFloat() == 0.432)

    test "start vertex data object":
        var mytable: OrderedTable[string, VertexData]
        mytable.add("my key string", newVInt(135))
        let vd = vdata.newVObject(fs = mytable)
        let myobj = getObject(vd)
        check(myobj == mytable)

    test "start vertex data array":
        let vd1 = vdata.newVString(s = "my string")
        let vd2 = vdata.newVInt(nb = int(1235861))
        let vd = vdata.newVArray(arr = @[vd1, vd2])
        let myarr = vdata.getArray(node = vd)
        check(myarr == @[vd1, vd2])

    test "test vertex data length":
        let vd1 = vdata.newVString(s = "my string")
        let vd2 = vdata.newVString(s = "my stripl")
        let vd3 = vdata.newVString(s = "stripl")
        let vd4 = vdata.newVArray(arr = @[vd1, vd2])
        let vd5 = vdata.newVArray(arr = @[vd3, vd2])
        var mytable1: OrderedTable[string, VertexData]
        var mytable2: OrderedTable[string, VertexData]
        mytable1.add("my key string", newVInt(135))
        mytable2.add("key string", newVInt(15))
        let vd6 = vdata.newVObject(fs = mytable1)
        let vd7 = vdata.newVObject(fs = mytable2)
        check(vd1.len() == vd2.len())
        check(vd4.len() == vd5.len())
        check(vd6.len() == vd7.len())

    test "test vertex data equality":
        let vd1 = vdata.newVString(s = "my string")
        let vd2 = vdata.newVString(s = "my string")
        var mytable1: OrderedTable[string, VertexData]
        mytable1.add("my key string", newVInt(135))
        let vd3 = vdata.newVObject(fs = mytable1)
        let vd4 = vdata.newVObject(fs = mytable1)
        let vd5 = vdata.newVFloat(f = 0.432)
        let vd6 = vdata.newVFloat(f = 0.432)
        let vd7 = vdata.newVInt(nb = int(1235861))
        let vd8 = vdata.newVInt(nb = int(1235861))
        let vd9 = vdata.newVBool(b = true)
        let vd10 = vdata.newVBool(b = true)
        let vd11 = vdata.newVArray(arr = @[vd1, vd2])
        let vd12 = vdata.newVArray(arr = @[vd1, vd2])
        let vd13 = vdata.newVNull()
        let vd14 = vdata.newVNull()
        check(vd1 == vd2)
        check(vd3 == vd4)
        check(vd5 == vd6)
        check(vd7 == vd8)
        check(vd9 == vd10)
        check(vd11 == vd12)
        check(vd13 == vd14)
        check(vd1 != vd14)

    echo "-----------------------"
    echo "VertexData tests ended:"
    echo "-----------------------"

