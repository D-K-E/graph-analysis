## an aggregate of functions for analysing a graph

# author: Kaan Eraslan
# license: see, LICENSE
import graph
import vertex
import edge
import vdata
import sets
import sequtils

##[


* All terminology and formula are taken from 
  Reinhard Diestel, Graph Theory, 5th edition, 2017, Springer, Berlin


]##

# Graph Analysis Methods

proc getAllPossibleEdges(g: Graph): HashSet[Edge] =
    ## obtain two element subsets from vertices of graph
    var vs = newSeq[Vertex]()
    for vert in g.vertices:
        vs.add(vert)
    let vertCombined = zip(vs, vs)
    var eset = initHashSet[Edge]()
    for vtplIndex in countup(0, vertCombined.len() - 1):
        let vtpl = vertCombined[vtplIndex]
        let firstVertice = vtpl.a
        let secondVertice = vtpl.b
        let eid = "edge-" & $(vtplIndex)
        let e = newEdge(fromVertex = firstVertice, toVertex = secondVertice,
                        eid = eid)
        eset.incl(e)
    return eset

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
    if g1.contains(subGraph) == true:
        return true
    return false

proc isProperSubgraph*(g1: Graph, subGraph: Graph): bool =
    ## is g2 proper subgraph of g1
    if g1 == subGraph:
        return false
    if g1.contains(subGraph) == false:
        return false
    return true

proc getSpanningGraph(g: Graph, vs: HashSet[Vertex]): Graph =
    ## get the graph that vertex set spans in G.
    if g.contains(vs) == false:
        raise newException(
            ValueError,
            "Vertex set: " & $(vs) & " is not contained by graph"
        )
    var idset = initHashSet[string]()
    for v in vs:
        idset.incl(v.id)
    var eset = initHashSet[Edge]()
    for v in vs:
        let es = getEdgeSetForVertex(g, v)
        for e in es:
            # G' contains all the edges xy ∈ E of G.
            let fromVertexId = e.fromVId
            let toVertexId = e.toVId
            if fromVertexId in idset and toVertexId in idset:
                # x, y ∈ V'
                eset.incl(e)
    return Graph(edges: eset, vertices: vs,
    id: "~" & g.id & "=:" & g.id & "[V']", edgeBehaviour: g.edgeBehaviour)



proc isInducedSubgraph*(g1: Graph, subGraph: Graph): bool =
    ## subGraph is an induced subgraph of G from page 4
    if isSubgraph(g1, subGraph) == false:
        # G' ⊆ G
        return false
    let vs = subGraph.vertices
    let sg = getSpanningGraph(g1, vs)
    return sg == subGraph

proc isSpanningSubGraph*(g1: Graph, subGraph: Graph): bool =
    ## does subGraph span G or not
    if isInducedSubgraph(g1, subGraph) == false:
        # G' ⊆ G
        return false
    return bool(subGraph.vertices == g1.vertices)

proc symmetricVertexDiff(g: Graph, vset: HashSet[Vertex]): HashSet[Vertex] =
    ## symmetric vertex difference
    ## vertices that are not part of intersection.
    return sets.symmetricDifference(g.vertices, vset)

proc symmetricVertexDiff(g: Graph, v: Vertex): HashSet[Vertex] =
    ## symmetric vertex difference
    ## vertices that are not part of intersection.
    let vset = toHashSet([v])
    return symmetricVertexDiff(g, vset)

proc symmetricEdgeDiff(g: Graph, eset: HashSet[Edge]): HashSet[Edge] =
    ## symmetric edge difference
    ## edge that are not part of intersection.
    return sets.symmetricDifference(g.edges, eset)

proc symmetricEdgeDiff(g: Graph, e: Edge): HashSet[Edge] =
    ## symmetric vertex difference
    ## edges that are not part of intersection.
    let eset = toHashSet([e])
    return symmetricEdgeDiff(g, eset)

proc `-`*(g: Graph, vset: HashSet[Vertex]): Graph =
    ## symmetric difference
    let nvset = symmetricVertexDiff(g, vset)
    var neset = initHashSet[Edge]()
    for vert in nvset:
        let eset = getEdgeSetForVertex(g, vert)
        for e in eset:
            neset.incl(e)
    return Graph(id: g.id, edgeBehaviour: g.edgeBehaviour,
    edges: neset, vertices: nvset)

proc `-`*(g: Graph, v: Vertex): Graph =
    ## symmetric difference with vertex graph
    let vset = toHashSet([v])
    return g - vset

proc `-`*(g: Graph, eset: HashSet[Edge]): Graph =
    ## new graph
    let neset = symmetricEdgeDiff(g, eset)
    return Graph(id: g.id, edgeBehaviour: g.edgeBehaviour,
    edges: neset, vertices: g.vertices)

proc `-`*(g: Graph, e: Edge): Graph =
    ## symmetric difference with vertex graph
    let eset = toHashSet([e])
    return g - eset

proc `-`*(g1: Graph, g2: Graph): Graph =
    ## symmetric difference with graph
    return g1 - g2.vertices

proc getGraphComplement(g: Graph): Graph =
    ## get complement of graph
    let allEdges = getAllPossibleEdges(g)
    let eset = sets.symmetricDifference(allEdges, g.edges)
    return Graph(id: "~" & g.id, edges: eset, vertices: g.vertices,
    edgeBehaviour: g.edgeBehaviour)

# end Graph Analysis
