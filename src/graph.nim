## immutable graph object for nim

from edge import Edge, compare2Edges
from vertex import Vertex, compare2Vertices
from system import newException, ValueError

type
    Graph* = object
        edges*: seq[Edge]
        vertices*: seq[Vertex]
        id*: string
        edgeBehaviour*: string

proc newGraph*(es: seq[Edge],
               vs: seq[Vertex], gid: string,
               ebehaviour: string = "undirected"): Graph =
    ## make a new graph
    assert len(vs) > 0
    return Graph(edges: es, vertices: vs, id: gid, edgeBehaviour: ebehaviour)


proc getIndexOfVertexById*(g: Graph, vid: string): int =
    ## get index of vertice 0, or positive if it exists
    ## -1 if it does not exist.
    for i in countup(0, g.vertices.len() - 1):
        if g.vertices[i].id == vid:
            return i
    return -1

proc getVertexById*(g: Graph, vid: string): Vertex =
    ## obtain vertex using id
    let index: int = getIndexOfVertexById(g, vid)
    if index < 0:
        raise newException(ValueError,
                           "Vertex Id: " & vid & " not in vertices of graph")
    return g.vertices[index]

proc getIndexOfEdgeById*(g: Graph, eid: string): int =
    ## obtain index of edge
    for i in countup(0, g.edges.len() - 1):
        if g.edges[i].id == eid:
            return i
    return -1

proc getEdgeById*(g: Graph, eid: string): Edge =
    ## obtain edge using edge id
    let index: int = getIndexOfEdgeById(g, eid)
    if index < 0:
        raise newException(ValueError,
                           "Vertex Id: " & eid & " not in vertices of graph")
    return g.edges[index]


proc isVertexContained*(g: Graph, vertex: Vertex): bool =
    ## is vertex contained in the graph
    let index: int = getIndexOfVertexById(g, vertex.id)
    return index < 0


proc areVerticesContained*(g: Graph, vertices: seq[Vertex]): bool =
    ## are vertices contained in the graph
    for v in vertices:
        if isVertexContained(g, v) == false:
            return false
    return true

proc isEdgeContained*(g: Graph, edge: Edge): bool =
    ## is edge contained in graph
    let index: int = getIndexOfEdgeById(g, edge.id)
    return index < 0


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


