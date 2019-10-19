# author: Kaan Eraslan
# license: see, LICENSE
# test edge.nim

import unittest
import os

from vertex import Vertex, newVertex
from vertex import compare2Vertices
from edge import Edge, newEdge, compare2Edges, isVertexIncident
import json


test "Instantiate an Edge":
    let jdata1 = newJBool(true)
    let jdata2 = newJBool(false)
    let ve1 = newVertex(vid = uint(3), data = jdata1)
    let ve2 = newVertex(vid = uint(2), data = jdata2)
    let e1 = Edge(v1: ve1, v2: ve2, id: uint(86))
    let compe = newEdge(vertex1 = ve1, vertex2 = ve2, uint(86))
    check(e1 == compe)

test "is vertex incident with edge true":
    let jdata1 = newJBool(true)
    let jdata2 = newJBool(false)
    let ve1 = newVertex(vid = uint(3), data = jdata1)
    let ve2 = newVertex(vid = uint(2), data = jdata2)
    let ve3 = newVertex(vid = uint(2), data = jdata2)
    let e1 = Edge(v1: ve1, v2: ve2, id: uint(86))
    let compval = isVertexIncident(e1, ve3)
    check(compval)

test "is vertex incident with edge false":
    let jdata1 = newJBool(true)
    let jdata2 = newJBool(false)
    let ve1 = newVertex(vid = uint(3), data = jdata1)
    let ve2 = newVertex(vid = uint(2), data = jdata2)
    let ve3 = newVertex(vid = uint(4), data = jdata2)
    let e1 = Edge(v1: ve1, v2: ve2, id: uint(86))
    let compval = isVertexIncident(e1, ve3)
    check(not compval)

test "compare two edges true":
    let jdata1 = newJBool(true)
    let jdata2 = newJBool(false)
    let ve1 = newVertex(vid = uint(3), data = jdata1)
    let ve2 = newVertex(vid = uint(2), data = jdata2)
    let ve3 = newVertex(vid = uint(4), data = jdata2)
    let e1 = Edge(v1: ve1, v2: ve2, id: uint(86))
    let e2 = newEdge(vertex1 = ve1, vertex2 = ve2, uint(86))
    let compval = compare2Edges(e1, e2)
    check(compval)

test "compare two edges false":
    let jdata1 = newJBool(true)
    let jdata2 = newJBool(false)
    let ve1 = newVertex(vid = uint(3), data = jdata1)
    let ve2 = newVertex(vid = uint(2), data = jdata2)
    let ve3 = newVertex(vid = uint(4), data = jdata2)
    let e1 = Edge(v1: ve1, v2: ve2, id: uint(86))
    let e2 = newEdge(vertex1 = ve1, vertex2 = ve3, uint(86))
    let compval = compare2Edges(e1, e2)
    check(not compval)

