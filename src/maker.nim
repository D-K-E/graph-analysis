## maker of graph, vertex, edge
from vertex import Vertex, newVertex
from edge import Edge, newEdge
from graph import Graph, newGraph
import json

type
    JsonGraphElement[T] = object
        id: uint
        data: T
        edgeId: uint

proc newJGraphElement(keyId: uint,
                      data: JsonNodeKind,
                      edgeId: uint): JsonGraphElement =
    ## new json graph element
    new(result)
    result.id = keyId
    result.data = data
    result.edgeId = edgeId

proc makeVertexFromJGraphElement(el: JsonGraphElement): Vertex =
    ## make vertex from json graph element
    return newVertex(el.id, el.data)

proc makeEdgeFrom2JEl(el1: JsonGraphElement,
                      el2: JsonGraphElement): Edge =
    ## make edge from json graph elements
    let v1 = makeVertexFromJGraphElement(el1)
    let v2 = makeVertexFromJGraphElement(el1)
    return newEdge(v1, v2, el1.edgeId)

proc makeJElementsFromJArray(els: JsonNode): seq[JsonGraphElement] =
    ## make a sequence of vertices from json graph elements
    for el in els.items():
        let vid: uint = uint(el.getOrDefault("id"))
        let eid: uint = uint(el.getOrDefault("edgeId"))
        let data: JsonNodeKind = el.getOrDefault("data")
        result.add(newJGraphElement[JsonNodeKind](vid, data, eid))

proc makeVerticesFromJElements(els: seq[JsonGraphElement]): seq[Vertex] =
    ## make vertices from json graph elements
    for el in els:
        result.add(makeVertexFromJGraphElement(el))

proc makeEdgesFromJElements(els: seq[JsonGraphElement]): seq[Edge] =
    ## make edges from json graph elements
    var tempEl: JsonGraphElement = els.pop()
    while len(els) > 0:
        for el in els:
            if el.edgeId == tempEl.edgeId:
                result.add(makeEdgeFrom2JEl(el, tempEl))
        tempEl = els.pop()

proc makeGraphFromJElements(els: seq[JsonGraphElement]): Graph =
    ## make graph from json graph elements
    let vertices: seq[Vertex] = makeVerticesFromJElements(els)
    let edges: seq[Edge] = makeEdgesFromJElements(els)
    return newGraph(edges, vertices)

proc makeGraphFromFile*(filename: string): Graph =
    ## make graph from json file
    let jn: JsonNode = json.parseFile(filename)
    var jelements: seq[JsonGraphElement] = makeJElementsFromJArray(jn)
    return makeGraphFromJElements(jelements)

