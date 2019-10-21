# author: Kaan Eraslan
# license: see, LICENSE
## an aggregate of functions for analysing a graph
from graph import Graph, areEdgesContained, areVerticesContained
from graph import compare2Graphs4Equality
from vertex import Vertex
from edge import Edge
from edge import isVertexIncident

#[
All terminology and formula are taken from
Reinhard Diestel, Graph Theory, 5th edition, 2017, Springer, Berlin
]#

proc findGraphOrder*(gr: Graph): int =
    ## find order of graph ==  number of its vertices
    return len(gr.vertices)

proc findNumberOfVertices*(g: Graph): int =
    ## find number of vertices
    return findGraphOrder(g)

proc findNumberOfEdges*(g: Graph): int =
    ## find number of edges in graph
    return len(g.edges)


proc getEdgeSetForVertex*(gr: Graph, vert: Vertex): seq[Edge] =
    for e in gr.edges:
        if isVertexIncident(e, vert) == true:
            result.add(e)

proc isGraphComplete*(gr: Graph): bool =
    ## do all vertices are pairwise adjacent
    for v in gr.vertices:
        var verticeCheck = false
        for e in gr.edges:
            if isVertexIncident(e, v) == true:
                verticeCheck = true
                break
        if verticeCheck == false:
            return false
        else:
            verticeCheck = false
    return true


proc isSubgraph*(g1: Graph, subGraph: Graph): bool =
    ## is g2 proper subgraph of g1
    if compare2Graphs4Equality(g1, subGraph) == true:
        return true
    if areEdgesContained(g1, subGraph.edges) == false:
        return false
    if areVerticesContained(g1, subGraph.vertices) == false:
        return false
    return true

proc isProperSubgraph*(g1: Graph, subGraph: Graph): bool =
    ## is g2 proper subgraph of g1
    if compare2Graphs4Equality(g1, subGraph) == true:
        return false
    if areEdgesContained(g1, subGraph.edges) == false:
        return false
    if areVerticesContained(g1, subGraph.vertices) == false:
        return false
    return true


proc isInducedSubgraph*(g1: Graph, subGraph: Graph): bool =
    ## is subgraph and induced subgraph
    if isSubgraph(g1, subGraph) == false:
        return false
