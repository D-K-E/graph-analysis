# author: Kaan Eraslan
# license: see, LICENSE
# test edge.nim

import unittest
import os

from vertex import Vertex, newVertex
from vertex import compare2Vertices
from vdata import VertexData, newVString
from vdata import newVBool, newVNull
from vdata import toString
from edge import toString
from edge import Edge, newEdge, compare2Edges, isVertexIncident
import json


suite "Test Edge object":

    echo "-------------------"
    echo "Edge tests started:"
    echo "-------------------"

    setup:
        let jdata1 = newVBool(true)
        let jdata2 = newVBool(false)
        let ve1 = newVertex(vid = $(3), data = jdata1)
        let ve2 = newVertex(vid = $(2), data = jdata2)
        let ve3 = newVertex(vid = $(4), data = jdata2)

    test "Instantiate an Edge":
        let e1 = Edge(fromVId: ve1.id, toVId: ve2.id, id: $(86),
                      data: newVString("my string"))
        let compe = newEdge(fromVertex = ve1, toVertex = ve2, eid = $(86),
                            data = newVString("my string"))
        echo "my edges"
        echo toString(e1)
        echo toString(compe)
        check(e1 == compe)

    test "is vertex incident with edge true":
        let e1 = Edge(fromVId: ve1.id, toVId: ve2.id, id: $(86),
                      data: newVNull())
        let compval = isVertexIncident(e1, ve2)
        check(compval)

    test "is vertex incident with edge false":
        let e1 = Edge(fromVId: ve1.id, toVId: ve2.id, id: $(86),
                      data: newVNull())
        let compval = isVertexIncident(e1, ve3)
        check(not compval)

    test "compare two edges true":
        let e1 = Edge(fromVId: ve1.id, toVId: ve2.id, id: $(86),
                      data: newVNull())
        let e2 = newEdge(fromVertex = ve1, toVertex = ve2, eid = $(86),
                            data = newVNull())
        let compval = compare2Edges(e1, e2)
        check(compval == true)

    test "compare two edges false":
        let e1 = Edge(fromVId: ve1.id, toVId: ve2.id, id: $(86),
                      data: newVNull())
        let e2 = newEdge(fromVertex = ve1, toVertex = ve3, eid = $(86),
                            data = newVNull())
        let compval = compare2Edges(e1, e2)
        check(not compval)

    echo "-----------------"
    echo "Edge tests ended:"
    echo "-----------------"

