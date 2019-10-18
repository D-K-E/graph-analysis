# test maker.nim

import unittest

#from maker import makeGraphFromFile
from graph import Graph, newGraph
from vertex import Vertex, newVertex
from edge import Edge, newEdge

# test "make graph from file":
#    let vertices = @[newVertex(vid = 3, data = 231),
#                    newVertex(vid = 5, data = "foo"),
#                    newVertex(vid = 7, data = 18.9),
#                    newVertex(vid = 6, data = true),
#                    newVertex(vid = 30, data = false),
#                    newVertex(vid = 31, data = "bar"),
#                    newVertex(vid = 38, data = "my graph string"),
#                    newVertex(vid = 33, data = 131),
#                    newVertex(vid = 2, data = 8888),
#                    newVertex(vid = 3, data = 21.1),
#                    newVertex(vid = 1, data = 41.45)]
#   let edges = @[newEdge(vertices[0], vertices[2], eid = 13),
#                 newEdge(vertices[1], vertices[3], eid = 5),
#                 newEdge(vertices[4], vertices[6], eid = 23),
#                 newEdge(vertices[5], vertices[7], eid = 52),
#                 newEdge(vertices[8], vertices[9], eid = 63)]
#   let compareGraph: Graph = newGraph(edges, vertices)
#   let madeGraph: Graph = makeGraphFromFile("graph-test.json")
#   check(madeGraph == compareGraph)

test "Instantiate a vertex":
    let v = Vertex["Foo"](id: 1, data: "Foo")
    let compv = newVertex["Foo"](vid = uint(1), data = "Foo")
    check(v == compv)

test "Instantiate an Edge":
    let ve1 = newVertex[false](vid = uint(3), data = false)
    let ve2 = newVertex[true](vid = uint(2), data = true)
    let e1 = Edge[ve1.data](v1: ve1, v2: ve2, id: uint(86))
    let compe = newEdge[ve1.data](vertex1 = ve1, vertex2 = ve2, uint(86))
    check(e1 == compe)

test "Instantiate a Graph with string":
    let ve1 = newVertex[""](vid = uint(3), data = "oh string")
    let ve2 = newVertex[""](vid = uint(2), data = "booo string")
    let e1 = Edge[ve1.data](v1: ve1, v2: ve2, id: uint(86))
    let ve3 = newVertex[""](vid = uint(5), data = "my string")
    let ve4 = newVertex[""](vid = uint(4), data = "your string")
    let e2 = Edge[ve3.data](v1: ve3, v2: ve4, id: uint(88))
    let myg = Graph[ve3.data](edges: @[e1, e2], vertices: @[ve1, ve2, ve3, ve4],
                    id: uint(63))
    let compg = newGraph[ve3.data](es = @[e1, e2], vs = @[ve1, ve2, ve3, ve4],
                         gid = uint(63))
    check(myg == compg)

test "Instantiate a Graph with int":
    let ve1 = newVertex[23](vid = uint(3), data = 23)
    let ve2 = newVertex[13](vid = uint(2), data = 18)
    let e1 = Edge[ve1.data](v1: ve1, v2: ve2, id: uint(86))
    let ve3 = newVertex[86](vid = uint(5), data = 888)
    let ve4 = newVertex[46](vid = uint(4), data = 32323)
    let e2 = Edge[ve3.data](v1: ve3, v2: ve4, id: uint(88))
    let myg = Graph[ve3.data](edges: @[e1, e2], vertices: @[ve1, ve2, ve3, ve4],
                    id: uint(63))
    let compg = newGraph[ve3.data](es = @[e1, e2], vs = @[ve1, ve2, ve3, ve4],
                         gid = uint(63))
    check(myg == compg)

test "Instantiate a Graph with float":
    let ve1 = newVertex[23.42](vid = uint(3), data = 23.42)
    let ve2 = newVertex[13.42](vid = uint(2), data = 18.42)
    let e1 = Edge[ve1.data](v1: ve1, v2: ve2, id: uint(86))
    let ve3 = newVertex[86.42](vid = uint(5), data = 888.42)
    let ve4 = newVertex[46.42](vid = uint(4), data = 32323.48)
    let e2 = Edge[ve3.data](v1: ve3, v2: ve4, id: uint(88))
    let myg = Graph[ve3.data](edges: @[e1, e2], vertices: @[ve1, ve2, ve3, ve4],
                    id: uint(63))
    let compg = newGraph[ve3.data](es = @[e1, e2], vs = @[ve1, ve2, ve3, ve4],
                         gid = uint(63))
    check(myg == compg)

