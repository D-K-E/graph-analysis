# author: Kaan Eraslan
# license: see, LICENSE
# test vertex.nim

import unittest
import os

from vertex import Vertex, newVertex
from vertex import compare2Vertices
from edge import Edge, newEdge, compare2Edges
from graph import Graph, newGraph, isVertexContained, isEdgeContained
from graph import areVerticesContained, areEdgesContained
from graph import compare2Graphs4Equality
import json


test "Instantiate a Graph":
    let jdata1 = newJString("oh string")
    let jdata2 = newJString("booo string")
    let jdata3 = newJString("my string")
    let jdata4 = newJString("your string")
    let ve1 = newVertex(vid = uint(3), data = jdata1)
    let ve2 = newVertex(vid = uint(2), data = jdata2)
    let e1 = Edge(v1: ve1, v2: ve2, id: uint(86))
    let ve3 = newVertex(vid = uint(5), data = jdata3)
    let ve4 = newVertex(vid = uint(4), data = jdata4)
    let e2 = Edge(v1: ve3, v2: ve4, id: uint(88))
    let myg = Graph(edges: @[e1, e2],
                    vertices: @[ve1, ve2, ve3, ve4],
                    id: uint(63))
    let compg = newGraph(es = @[e1, e2],
                         vs = @[ve1, ve2, ve3, ve4],
                         gid = uint(63))
    check(myg == compg)


test "is vertex contained in graph true":
    let jdata1 = newJString("oh string")
    let jdata2 = newJString("booo string")
    let jdata3 = newJString("my string")
    let jdata4 = newJString("your string")
    let ve1 = newVertex(vid = uint(3), data = jdata1)
    let ve2 = newVertex(vid = uint(2), data = jdata2)
    let e1 = Edge(v1: ve1, v2: ve2, id: uint(86))
    let ve3 = newVertex(vid = uint(5), data = jdata3)
    let ve4 = newVertex(vid = uint(4), data = jdata4)
    let e2 = Edge(v1: ve3, v2: ve4, id: uint(88))
    let ve5 = newVertex(vid = uint(2), data = jdata2)
    let myg = Graph(edges: @[e1, e2],
                    vertices: @[ve1, ve2, ve3, ve4],
                    id: uint(63))
    let cmpv = isVertexContained(myg, ve5)
    check(cmpv)


test "is vertex contained in graph false":
    let jdata1 = newJString("oh string")
    let jdata2 = newJString("booo string")
    let jdata3 = newJString("my string")
    let jdata4 = newJString("your string")
    let ve1 = newVertex(vid = uint(3), data = jdata1)
    let ve2 = newVertex(vid = uint(2), data = jdata2)
    let e1 = Edge(v1: ve1, v2: ve2, id: uint(86))
    let ve3 = newVertex(vid = uint(5), data = jdata3)
    let ve4 = newVertex(vid = uint(4), data = jdata4)
    let e2 = Edge(v1: ve3, v2: ve4, id: uint(88))
    let ve5 = newVertex(vid = uint(2123), data = jdata2)
    let myg = Graph(edges: @[e1, e2],
                    vertices: @[ve1, ve2, ve3, ve4],
                    id: uint(63))
    let cmpv = isVertexContained(myg, ve5)
    check(not cmpv)

test "are vertices contained in graph true":
    let jdata1 = newJString("oh string")
    let jdata2 = newJString("booo string")
    let jdata3 = newJString("my string")
    let jdata4 = newJString("your string")
    let ve1 = newVertex(vid = uint(3), data = jdata1)
    let ve2 = newVertex(vid = uint(2), data = jdata2)
    let e1 = Edge(v1: ve1, v2: ve2, id: uint(86))
    let ve3 = newVertex(vid = uint(5), data = jdata3)
    let ve4 = newVertex(vid = uint(4), data = jdata4)
    let e2 = Edge(v1: ve3, v2: ve4, id: uint(88))
    let ve5 = newVertex(vid = uint(2), data = jdata2)
    let ve6 = newVertex(vid = uint(3), data = jdata1)
    let myg = Graph(edges: @[e1, e2],
                    vertices: @[ve1, ve2, ve3, ve4],
                    id: uint(63))
    let cmpv = areVerticesContained(myg, @[ve5, ve6])
    check(cmpv)


test "are vertices contained in graph true":
    let jdata1 = newJString("oh string")
    let jdata2 = newJString("booo string")
    let jdata3 = newJString("my string")
    let jdata4 = newJString("your string")
    let ve1 = newVertex(vid = uint(3), data = jdata1)
    let ve2 = newVertex(vid = uint(2), data = jdata2)
    let e1 = Edge(v1: ve1, v2: ve2, id: uint(86))
    let ve3 = newVertex(vid = uint(5), data = jdata3)
    let ve4 = newVertex(vid = uint(4), data = jdata4)
    let e2 = Edge(v1: ve3, v2: ve4, id: uint(88))
    let ve5 = newVertex(vid = uint(21231), data = jdata2)
    let ve6 = newVertex(vid = uint(3), data = jdata1)
    let myg = Graph(edges: @[e1, e2],
                    vertices: @[ve1, ve2, ve3, ve4],
                    id: uint(63))
    let cmpv = areVerticesContained(myg, @[ve5, ve6])
    check(not cmpv)

test "is edge contained in a Graph true":
    let jdata1 = newJString("oh string")
    let jdata2 = newJString("booo string")
    let jdata3 = newJString("my string")
    let jdata4 = newJString("your string")
    let ve1 = newVertex(vid = uint(3), data = jdata1)
    let ve2 = newVertex(vid = uint(2), data = jdata2)
    let e1 = Edge(v1: ve1, v2: ve2, id: uint(86))
    let ve3 = newVertex(vid = uint(5), data = jdata3)
    let ve4 = newVertex(vid = uint(4), data = jdata4)
    let e2 = Edge(v1: ve3, v2: ve4, id: uint(88))
    let e3 = Edge(v1: ve3, v2: ve4, id: uint(88))
    let myg = Graph(edges: @[e1, e2],
                    vertices: @[ve1, ve2, ve3, ve4],
                    id: uint(63))
    let compv = isEdgeContained(myg, e3)
    check(compv)

test "is edge contained in a Graph false":
    let jdata1 = newJString("oh string")
    let jdata2 = newJString("booo string")
    let jdata3 = newJString("my string")
    let jdata4 = newJString("your string")
    let ve1 = newVertex(vid = uint(3), data = jdata1)
    let ve2 = newVertex(vid = uint(2), data = jdata2)
    let e1 = Edge(v1: ve1, v2: ve2, id: uint(86))
    let ve3 = newVertex(vid = uint(5), data = jdata3)
    let ve4 = newVertex(vid = uint(4), data = jdata4)
    let e2 = Edge(v1: ve3, v2: ve4, id: uint(88))
    let e3 = Edge(v1: ve1, v2: ve4, id: uint(88))
    let myg = Graph(edges: @[e1, e2],
                    vertices: @[ve1, ve2, ve3, ve4],
                    id: uint(63))
    let compv = isEdgeContained(myg, e3)
    check(not compv)


test "are edges contained in a Graph false":
    let jdata1 = newJString("oh string")
    let jdata2 = newJString("booo string")
    let jdata3 = newJString("my string")
    let jdata4 = newJString("your string")
    let ve1 = newVertex(vid = uint(3), data = jdata1)
    let ve2 = newVertex(vid = uint(2), data = jdata2)
    let e1 = Edge(v1: ve1, v2: ve2, id: uint(86))
    let ve3 = newVertex(vid = uint(5), data = jdata3)
    let ve4 = newVertex(vid = uint(4), data = jdata4)
    let e2 = Edge(v1: ve3, v2: ve4, id: uint(88))
    let e3 = Edge(v1: ve1, v2: ve4, id: uint(88))
    let e4 = Edge(v1: ve2, v2: ve4, id: uint(88))
    let myg = Graph(edges: @[e1, e2],
                    vertices: @[ve1, ve2, ve3, ve4],
                    id: uint(63))
    let compv = areEdgesContained(myg, @[e3, e4])
    check(not compv)

test "are edges contained in a Graph true":
    let jdata1 = newJString("oh string")
    let jdata2 = newJString("booo string")
    let jdata3 = newJString("my string")
    let jdata4 = newJString("your string")
    let ve1 = newVertex(vid = uint(3), data = jdata1)
    let ve2 = newVertex(vid = uint(2), data = jdata2)
    let e1 = Edge(v1: ve1, v2: ve2, id: uint(86))
    let ve3 = newVertex(vid = uint(5), data = jdata3)
    let ve4 = newVertex(vid = uint(4), data = jdata4)
    let e2 = Edge(v1: ve3, v2: ve4, id: uint(88))
    let e3 = Edge(v1: ve1, v2: ve2, id: uint(86))
    let e4 = Edge(v1: ve3, v2: ve4, id: uint(88))
    let myg = Graph(edges: @[e1, e2],
                    vertices: @[ve1, ve2, ve3, ve4],
                    id: uint(63))
    let compv = areEdgesContained(myg, @[e3, e4])
    check(compv)


test "compare a Graph with another graph true":
    let jdata1 = newJString("oh string")
    let jdata2 = newJString("booo string")
    let jdata3 = newJString("my string")
    let jdata4 = newJString("your string")
    let ve1 = newVertex(vid = uint(3), data = jdata1)
    let ve2 = newVertex(vid = uint(2), data = jdata2)
    let e1 = Edge(v1: ve1, v2: ve2, id: uint(86))
    let ve3 = newVertex(vid = uint(5), data = jdata3)
    let ve4 = newVertex(vid = uint(4), data = jdata4)
    let e2 = Edge(v1: ve3, v2: ve4, id: uint(88))
    let myg = Graph(edges: @[e1, e2],
                    vertices: @[ve1, ve2, ve3, ve4],
                    id: uint(63))
    let compg = newGraph(es = @[e1, e2],
                         vs = @[ve1, ve2, ve3, ve4],
                         gid = uint(63))
    let cmpv = compare2Graphs4Equality(myg, compg)
    check(cmpv)


test "compare a Graph with another graph false":
    let jdata1 = newJString("oh string")
    let jdata2 = newJString("booo string")
    let jdata3 = newJString("my string")
    let jdata4 = newJString("your string")
    let ve1 = newVertex(vid = uint(3), data = jdata1)
    let ve2 = newVertex(vid = uint(2), data = jdata2)
    let e1 = Edge(v1: ve1, v2: ve2, id: uint(86))
    let e3 = Edge(v1: ve1, v2: ve2, id: uint(8653))
    let ve3 = newVertex(vid = uint(5), data = jdata3)
    let ve4 = newVertex(vid = uint(4), data = jdata4)
    let e2 = Edge(v1: ve3, v2: ve4, id: uint(88))
    let myg = Graph(edges: @[e1, e2],
                    vertices: @[ve1, ve2, ve3, ve4],
                    id: uint(63))
    let compg = newGraph(es = @[e1, e3],
                         vs = @[ve1, ve2, ve3, ve4],
                         gid = uint(63))
    let cmpv = compare2Graphs(myg, compg)
    check(not cmpv)


