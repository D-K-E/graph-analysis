## immutable graph object for nim

from edge import Edge, compare2Edges
from vertex import Vertex, compare2Vertices
from system import newException, ValueError

type
    Graph* = object
        edges*: seq[Edge]
        vertices*: seq[Vertex]
        id*: uint

proc newGraph*(es: seq[Edge],
               vs: seq[Vertex], gid: uint): Graph =
    ## make a new graph
    assert len(vs) > 0
    return Graph(edges: es, vertices: vs, id: gid)

proc isVertexContained*(g: Graph, vertex: Vertex): bool =
    ## is vertex contained in the graph
    for v in g.vertices:
        if compare2Vertices(v, vertex) == true:
            return true
    return false

proc areVerticesContained*(g: Graph, vertices: seq[Vertex]): bool =
    ## are vertices contained in the graph
    for v in vertices:
        if isVertexContained(g, v) == false:
            return false
    return true

proc isEdgeContained*(g: Graph, edge: Edge): bool =
    ## is edge contained in graph
    for e in g.edges:
        if compare2Edges(e, edge) == true:
            return true
    return false

proc areEdgesContained*(g: Graph, edges: seq[Edge]): bool =
    ## are edges contained in graph
    for e in edges:
        if isEdgeContained(g, e) == false:
            return false
    return true

proc compare2Graphs4Equality*(g1: Graph, g2: Graph): bool =
    ## compare two graphs for equality of vertices and edges
    if len(g1.vertices) != len(g2.vertices):
        return false
    if areVerticesContained(g1, g2.vertices) == false:
        return false
    if areEdgesContained(g1, g2.edges) == false:
        return false
    return true


