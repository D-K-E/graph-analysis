# author: Kaan Eraslan
# license: see, LICENSE
## an aggregate of functions for analysing a graph
import graph
import vertex
import edge
import vdata
import sets

#[
All terminology and formula are taken from
Reinhard Diestel, Graph Theory, 5th edition, 2017, Springer, Berlin
]#

proc findGraphOrder*(gr: Graph): int =
    ## find order of graph ==  number of its vertices
    return gr.vertices.len()

proc findNumberOfVertices*(g: Graph): int =
    ## find number of vertices
    return findGraphOrder(g)

proc findNumberOfEdges*(g: Graph): int =
    ## find number of edges in graph
    return len(g.edges)


proc getEdgeSetForVertex*(gr: Graph, vert: Vertex): HashSet[Edge] =
    var edgeSet = initHashSet[Edge]()
    for e in gr.edges:
        if isVertexIncident(e, vert) == true:
            edgeSet.incl(e)
    return edgeSet

proc isGraphComplete*(gr: Graph): bool =
    ## do all vertices are pairwise adjacent
    for v in gr.vertices:
        var verticeCheck = false
        for e in gr.edges:
            if edge.isVertexIncident(e, v) == true:
                verticeCheck = true
                break
        if verticeCheck == false:
            return false
        else:
            verticeCheck = false
    return true


proc isSubgraph*(g1: Graph, subGraph: Graph): bool =
    ## is g2 proper subgraph of g1
    if g1 == subGraph:
        return true
    if g1.contains(subGraph.edges) == false:
        return false
    if g1.contains(subGraph.vertices) == false:
        return false
    return true

proc isProperSubgraph*(g1: Graph, subGraph: Graph): bool =
    ## is g2 proper subgraph of g1
    if g1 == subGraph:
        return false
    if g1.contains(subGraph.edges) == false:
        return false
    if g1.contains(subGraph.vertices) == false:
        return false
    return true


proc isInducedSubgraph*(g1: Graph, subGraph: Graph): bool =
    ## is subgraph and induced subgraph
    if isSubgraph(g1, subGraph) == false:
        return false
