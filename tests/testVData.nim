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

    echo "-----------------------"
    echo "VertexData tests ended:"
    echo "-----------------------"

