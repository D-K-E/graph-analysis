## maker of graph, vertex, edge
from vertex import Vertex, newVertex
from edge import Edge, newEdge
from graph import Graph, newGraph
import json


proc sliceJArray(els: JsonNode, startIndex: int,
                 endIndex: int): seq[JsonNode] =
    ## slice json array returns a copy
    for i in countup(startIndex, endIndex):
        result.add(els[i])

proc sliceNodeSeq(els: seq[JsonNode], startIndex: int,
                  endIndex: int): seq[JsonNode] =
    ## slice json array returns a copy
    for i in countup(startIndex, endIndex):
        result.add(els[i])


proc makeVertexFromJGraphElement*(el: JsonNode): Vertex =
    ## make vertex from json graph element
    return newVertex(vid = uint(el["id"].getInt()), data = el["data"])

proc makeEdgeFrom2JEl*(el1: JsonNode,
                      el2: JsonNode): Edge =
    ## make edge from json graph elements
    let v1 = makeVertexFromJGraphElement(el1)
    let v2 = makeVertexFromJGraphElement(el2)
    return newEdge(v1, v2, uint(el1["edgeId"].getInt()))

proc makeVerticesFromJson*(els: JsonNode): seq[Vertex] =
    ## make a sequence of vertices from json graph elements
    assert els.kind == json.JArray
    var idset: seq[uint]
    var vertices: seq[Vertex]
    for el in els.items():
        let v: Vertex = makeVertexFromJGraphElement(el)
        if idset.contains(v.id) == false:
            idset.add(v.id)
            vertices.add(v)
    return vertices

proc makeEdgesFromJElements*(els: JsonNode): seq[Edge] =
    ## make edges from json graph elements
    assert els.kind == json.JArray
    var tempEl = els[0]
    var els = sliceJArray(els, startIndex = 1, endIndex = len(els) - 1)
    var idset: seq[uint]
    var edges: seq[Edge]
    while len(els) > 0:
        for el in els.items():
            if el["edgeId"] == tempEl["edgeId"]:
                var e: Edge = makeEdgeFrom2JEl(el, tempEl)
                if idset.contains(e.id) == false:
                    idset.add(e.id)
                    edges.add(e)
        tempEl = els[0]
        els = sliceNodeSeq(els, startIndex = 1, endIndex = len(els) - 1)
    return edges

proc makeGraphFromJElements*(jgraph: JsonNode): Graph =
    ## make graph from json graph elements
    let els: JsonNode = jgraph["data"]
    let graphId: JsonNode = jgraph["id"]
    let vertices: seq[Vertex] = makeVerticesFromJson(els)
    let edges: seq[Edge] = makeEdgesFromJElements(els)
    return newGraph(edges, vertices, uint(graphId.getInt()))

proc makeGraphFromFile*(filename: string): Graph =
    ## make graph from json file
    let jn: JsonNode = json.parseFile(filename)
    return makeGraphFromJElements(jn)
