# test maker.nim

import unittest
import os
import json

#from maker import makeGraphFromFile
from graph import Graph, newGraph
from vertex import Vertex, newVertex
from vertex import compare2Vertices
from edge import Edge, newEdge, compare2Edges
from maker import makeVertexFromJGraphElement
from maker import makeEdgeFrom2JEl
from maker import makeVerticesFromJson
from maker import makeEdgesFromJElements
from maker import makeGraphFromJElements
from maker import makeGraphFromFile

test "test make vertex from json graph element":
    let jdata: JsonNode = parseJson("""{"id": 5, "data": "foo", "edgeId": 5}""")
    let jv = makeVertexFromJGraphElement(jdata)
    let ve1 = newVertex(vid = uint(5), data = newJString("foo"))
    let compval = compare2Vertices(jv, ve1)
    check(compval)

test "test make edge from json graph element":
    let jd1: JsonNode = parseJson("""{"id": 3, "data": "foo", "edgeId": 5}""")
    let jd2: JsonNode = parseJson("""{"id": 4, "data": "koo", "edgeId": 5}""")
    let e: Edge = makeEdgeFrom2JEl(jd1, jd2)
    let v1 = makeVertexFromJGraphElement(jd1)
    let v2 = makeVertexFromJGraphElement(jd2)
    let e2 = Edge(v1: v1, v2: v2, id: uint(5))
    check(e == e2)

test "test make vertices from json":
    let jd1: JsonNode = parseJson("""
    [
        {"id": 3, "data": "foo", "edgeId": 5},
        {"id": 4, "data": "koo", "edgeId": 5},
        {"id": 5, "data": "loo", "edgeId": 8},
        {"id": 6, "data": "poo", "edgeId": 8},
        {"id": 46, "data": "too", "edgeId": 9},
    ]
    """)
    let vs = makeVerticesFromJson(jd1)
    let newvs: seq[Vertex] = @[
        newVertex(vid = uint(3), data = newJString("foo")),
    newVertex(vid = uint(4), data = newJString("koo")),
    newVertex(vid = uint(5), data = newJString("loo")),
    newVertex(vid = uint(6), data = newJString("poo")),
    newVertex(vid = uint(46), data = newJString("too"))
    ]
    var checkval = true
    for i in countup(0, len(vs)-1):
        let nv: Vertex = newvs[i]
        let v: Vertex = vs[i]
        let compv = compare2Vertices(nv, v)
        if compv == false:
            checkval = false
    check(checkval)

test "make edges from json node":
    let jd1: JsonNode = parseJson("""
    [
        {"id": 3, "data": "foo", "edgeId": 5},
        {"id": 5, "data": "loo", "edgeId": 8},
        {"id": 46, "data": "too", "edgeId": 9},
        {"id": 6, "data": "poo", "edgeId": 8},
        {"id": 4, "data": "koo", "edgeId": 5},
    ]
    """)
    let es: seq[Edge] = makeEdgesFromJElements(jd1)
    let newes: seq[Edge] = @[
        newEdge(newVertex(vid = uint(4), data = newJString("koo")),
                newVertex(vid = uint(3), data = newJString("foo")), uint(5)),
        newEdge(newVertex(vid = uint(6), data = newJString("poo")),
                newVertex(vid = uint(5), data = newJString("loo")), uint(8))
    ]
    var checkval = true
    for i in countup(0, len(es)-1):
        let ne: Edge = newes[i]
        let e: Edge = es[i]
        let compv = compare2Edges(ne, e)
        if compv == false:
            checkval = false
    check(es == newes)

test "make graph from json elements":
    let jd1: JsonNode = parseJson("""
    {"id": 61,
    "data": [
        {"id": 3, "data": "foo", "edgeId": 5},
        {"id": 5, "data": "loo", "edgeId": 8},
        {"id": 46, "data": "too", "edgeId": 9},
        {"id": 6, "data": "poo", "edgeId": 8},
        {"id": 4, "data": "koo", "edgeId": 5},
    ]}
    """)
    let mygraph: Graph = makeGraphFromJElements(jd1)
    let es: seq[Edge] = makeEdgesFromJElements(jd1["data"])
    let vs: seq[Vertex] = makeVerticesFromJson(jd1["data"])
    let compg = newGraph(es, vs, uint(61))
    check(mygraph == compg)

test "make graph from file":
    let cdir: string = os.getCurrentDir()
    let tdir: string = os.joinPath(cdir, "tests")
    let gpath: string = os.joinPath(tdir, "graph-test.json")
    assert os.fileExists(gpath)
    let mygraph: Graph = makeGraphFromFile(gpath)
    let jd1: JsonNode = parseJson("""
    {"data": [{"id": 3, "data": 231, "edgeId": 13},
        {"id": 5, "data": "foo", "edgeId": 5},
        {"id": 7, "data": 18.9, "edgeId": 13},
        {"id": 6, "data": true, "edgeId": 5},
        {"id": 30,"data": false,"edgeId": 23},
        {"id": 31,"data": "bar","edgeId": 52},
        {"id": 38, "data": "my graph string", "edgeId": 23},
        {"id": 33,"data": 131,"edgeId": 52},
        {"id": 2,"data": 8888,"edgeId": 63},
        {"id": 3,"data": 21.1,"edgeId": 63},
        {"id": 1,"data": 41.45,"edgeId": 14}],
    "id": 61
    }
    """)
    let mg: Graph = makeGraphFromJElements(jd1)
    check(mygraph == mg)
