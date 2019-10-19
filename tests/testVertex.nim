# author: Kaan Eraslan
# license: see, LICENSE
# test vertex.nim

import unittest
import os

from vertex import Vertex, newVertex
from vertex import compare2Vertices
import json

test "Instantiate a vertex as a string":
    let jdata = newJString("Foo")
    let v = Vertex(id: 1, data: jdata)
    let compv = newVertex(vid = uint(1), data = jdata)
    check(v == compv)

test "Instantiate a vertex as an integer":
    let jdata = newJInt(23)
    let v = Vertex(id: 1, data: jdata)
    let compv = newVertex(vid = uint(1), data = jdata)
    check(v == compv)

test "Instantiate a vertex as a float":
    let jdata = newJFloat(23.864)
    let v = Vertex(id: 1, data: jdata)
    let compv = newVertex(vid = uint(1), data = jdata)
    check(v == compv)

test "Instantiate a vertex as a nil":
    let jdata = newJNull()
    let v = Vertex(id: 1, data: jdata)
    let compv = newVertex(vid = uint(1), data = jdata)
    check(v == compv)

test "Instantiate a vertex as a bool":
    let jdata = newJBool(true)
    let v = Vertex(id: 1, data: jdata)
    let compv = newVertex(vid = uint(1), data = jdata)
    check(v == compv)

test "Instantiate a vertex as a JObject":
    let jdata = parseJson("""{"key": 3.14}""")
    let v = Vertex(id: 1, data: jdata)
    let compv = newVertex(vid = uint(1), data = jdata)
    check(v == compv)

test "Instantiate a vertex as a JArray":
    let jdata = parseJson("""["a", "b"]""")
    let v = Vertex(id: 1, data: jdata)
    let compv = newVertex(vid = uint(1), data = jdata)
    check(v == compv)

test "check compare 2 vertices true":
    let jdata = parseJson("""["a", "b"]""")
    let v = Vertex(id: uint(1), data: jdata)
    let compv = newVertex(vid = uint(1), data = jdata)
    let compb = compare2Vertices(v, compv)
    check(compb)

test "check compare 2 vertices false":
    let jdata = parseJson("""["a", "b"]""")
    let v = Vertex(id: uint(5), data: jdata)
    let compv = newVertex(vid = uint(1), data = jdata)
    let compb = compare2Vertices(v, compv)
    check(not compb)

