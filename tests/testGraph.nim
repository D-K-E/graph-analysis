# author: Kaan Eraslan
# license: see, LICENSE
# test vertex.nim

import unittest
import os

import edge
import graph
import vertex
import vdata
import json
import sets


suite "graph.nim tests":

    echo "--------------------"
    echo "Graph tests started:"
    echo "--------------------"

    let jdata1 = newVString("oh string")
    let jdata2 = newVString("booo string")
    let jdata3 = newVString("my string")
    let jdata4 = newVString("your string")
    let ve1 = newVertex(vid = $(3), data = jdata1)
    let ve2 = newVertex(vid = $(2), data = jdata2)
    let e1 = newEdge(fromVertex = ve1, toVertex = ve2, eid = $(86))
    let ve3 = newVertex(vid = $(5), data = jdata3)
    let ve4 = newVertex(vid = $(4), data = jdata4)
    let e2 = newEdge(fromVertex = ve3, toVertex = ve4, eid = $(88))

    test "Instantiate a Graph":
        let edata = toHashSet[Edge]([e1, e2])
        let vdata1 = toHashSet[Vertex]([ve1, ve2, ve3, ve4])
        
        let myg = Graph(edges: edata,
                        vertices: vdata1,
                        id: $(63))
        let compg = newGraph(es = edata,
                             vs = vdata1,
                             gid = $(63))
        check(myg == compg)

    test "is vertex contained in graph true":
        let ve5 = newVertex(vid = $(2), data = jdata2)
        let myg = Graph(edges: toHashSet([e1, e2]),
                        vertices: toHashSet([ve1, ve2, ve3, ve4]),
                        id: $(63))
        check(myg.contains(ve5))


    test "is vertex contained in graph false":
        let ve5 = newVertex(vid = $(2123), data = jdata2)
        let myg = Graph(edges: toHashSet([e1, e2]),
                        vertices: toHashSet([ve1, ve2, ve3, ve4]),
                        id: $(63))
        let cmpv = contains(myg, ve5)
        check(not cmpv)

    test "are vertices contained in graph true":
        let ve5 = newVertex(vid = $(2), data = jdata2)
        let ve6 = newVertex(vid = $(3), data = jdata1)
        let myg = Graph(edges: toHashSet([e1, e2]),
                        vertices: toHashSet([ve1, ve2, ve3, ve4]),
                        id: $(63))
        let cmpv = contains(myg, toHashSet([ve5, ve6]))
        check(cmpv)


    test "are vertices contained in graph true":
        let ve5 = newVertex(vid = $(21231), data = jdata2)
        let ve6 = newVertex(vid = $(3), data = jdata1)
        let myg = Graph(edges: toHashSet([e1, e2]),
                        vertices: toHashSet([ve1, ve2, ve3, ve4]),
                        id: $(63))
        let cmpv = contains(myg, toHashSet([ve5, ve6]))
        check(not cmpv)

    test "is edge contained in a Graph true":
        let e3 = newEdge(fromVertex = ve3, toVertex = ve4, eid = $(88))
        let myg = Graph(edges: toHashSet([e1, e2]),
                        vertices: toHashSet([ve1, ve2, ve3, ve4]),
                        id: $(63))
        check(myg.contains(e3))

    test "is edge contained in a Graph false":
        let e3 = newEdge(fromVertex = ve1, toVertex = ve4, eid = $(88))
        let myg = Graph(edges: toHashSet([e1, e2]),
                        vertices: toHashSet([ve1, ve2, ve3, ve4]),
                        id: $(63))
        check(myg.contains(e3) == false)


    test "are edges contained in a Graph false":
        let e3 = newEdge(fromVertex = ve1, toVertex = ve4, eid = $(88))
        let e4 = newEdge(fromVertex = ve2, toVertex = ve4, eid = $(88))
        let myg = Graph(edges: toHashSet([e1, e2]),
                        vertices: toHashSet([ve1, ve2, ve3, ve4]),
                        id: $(63))
        check(contains(myg, toHashSet([e3, e4])) == false)

    test "are edges contained in a Graph true":
        let e3 = newEdge(fromVertex = ve3, toVertex = ve4, eid = $(88))
        let e4 = newEdge(fromVertex = ve3, toVertex = ve4, eid = $(88))
        let myg = Graph(edges: toHashSet([e1, e2]),
                        vertices: toHashSet([ve1, ve2, ve3, ve4]),
                        id: $(63))
        check(myg.contains(toHashSet([e3, e4])))


    test "compare a Graph with another graph true":
        let myg = Graph(edges: toHashSet([e1, e2]),
                        vertices: toHashSet([ve1, ve2, ve3, ve4]),
                        id: $(63))
        let compg = newGraph(es = toHashSet([e1, e2]),
                             vs = toHashSet([ve1, ve2, ve3, ve4]),
                             gid = $(63))
        check(myg == compg)


    test "compare a Graph with another graph false":
        let e3 = newEdge(fromVertex = ve1, toVertex = ve2, eid = $(8653))
        let ve3 = newVertex(vid = $(5), data = jdata3)
        let ve4 = newVertex(vid = $(4), data = jdata4)
        let e2 = newEdge(fromVertex = ve3, toVertex = ve4, eid = $(88))
        let myg = Graph(edges: toHashSet([e1, e2]),
                        vertices: toHashSet([ve1, ve2, ve3, ve4]),
                        id: $(63))
        let compg = newGraph(es = toHashSet([e1, e3]),
                             vs = toHashSet([ve1, ve2, ve3, ve4]),
                             gid = $(63))
        check(myg != compg)

    echo "------------------"
    echo "Graph tests ended:"
    echo "------------------"


