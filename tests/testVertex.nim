# author: Kaan Eraslan
# license: see, LICENSE
# test vertex.nim

import unittest
import os

import vertex
import vdata
import tables

suite "vertex.nim tests":

    echo "---------------------"
    echo "Vertex tests started:"
    echo "---------------------"

    test "Instantiate a vertex as a string":
        let jdata = newVString("Foo")
        let v = Vertex(id: $(1), data: jdata)
        let compv = newVertex(vid = $(1), data = jdata)
        check(v == compv)

    test "Instantiate a vertex as an integer":
        let jdata = newVInt(23)
        let v = Vertex(id: $(1), data: jdata)
        let compv = newVertex(vid = $(1), data = jdata)
        check(v == compv)

    test "Instantiate a vertex as a float":
        let jdata = newVFloat(23.864)
        let v = Vertex(id: $(1), data: jdata)
        let compv = newVertex(vid = $(1), data = jdata)
        check(v == compv)

    test "Instantiate a vertex as a nil":
        let jdata = newVNull()
        let v = Vertex(id: $(1), data: jdata)
        let compv = newVertex(vid = $(1), data = jdata)
        check(v == compv)

    test "Instantiate a vertex as a bool":
        let jdata = newVBool(true)
        let v = Vertex(id: $(1), data: jdata)
        let compv = newVertex(vid = $(1), data = jdata)
        check(v == compv)

    test "Instantiate a vertex as a VObject":
        var mytable: OrderedTable[string, vdata.VertexData]
        mytable.add("my key string", newVInt(135))
        let vd = vdata.newVObject(fs = mytable)

        let v = Vertex(id: $(1), data: vd)
        let compv = newVertex(vid = $(1), data = vd)
        check(v == compv)

    test "Instantiate a vertex as a JArray":
        let vd1 = vdata.newVString(s = "my string")
        let vd2 = vdata.newVInt(nb = int(1235861))
        let vd = vdata.newVArray(arr = @[vd1, vd2])
        let v = Vertex(id: $(1), data: vd)
        let compv = newVertex(vid = $(1), data = vd)
        check(v == compv)

    test "check compare 2 vertices true":
        let vd1 = vdata.newVString(s = "my string")
        let vd2 = vdata.newVInt(nb = int(1235861))
        let vd = vdata.newVArray(arr = @[vd1, vd2])

        let v1 = Vertex(id: $(1), data: vd)
        let v2 = Vertex(id: $(2), data: vd)
        let compv = newVertex(vid = $(1), data = vd)
        check(v1 == compv)
        check(v2 != compv)

    echo "-------------------"
    echo "Vertex tests ended:"
    echo "-------------------"

