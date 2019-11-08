## ``graph.nim`` module documentation
## immutable graph object for nim

import system
import sets
import edge
import vertex
import vdata
import hashes

type
    Graph* = object
        edges*: HashSet[Edge]
        vertices*: HashSet[Vertex]
        id*: string
        edgeBehaviour*: string

proc hash*(g: Graph): Hash =
    ## hash graph
    var h: Hash = 0
    for e in g.edges.items():
        h = h !& hash(e)
    for v in g.vertices.items():
        h = h !& hash(v)
    return !$h

proc newGraph*(es: HashSet[Edge],
               vs: HashSet[Vertex], gid: string,
               ebehaviour: string = "undirected"): Graph =
    ## make a new graph
    assert vs.len() > 0
    return Graph(edges: es, vertices: vs, id: gid, edgeBehaviour: ebehaviour)

proc getVertexById*(g: Graph, vid: string): Vertex =
    ## obtain vertex using id
    for vertex in g.vertices:
        if vertex.id == vid:
            return vertex
    raise newException(ValueError,
                       "Vertex Id: " & vid & " not in vertices of graph")

proc getEdgeById*(g: Graph, eid: string): Edge =
    ## obtain edge using edge id
    for edge in g.edges:
        if edge.id == eid:
            return edge
    #
    raise newException(ValueError,
                       "Vertex Id: " & eid & " not in vertices of graph")

proc contains*(g: Graph, id: string, isVertex: bool): bool =
    # check if graph contains a vertex or edge by id
    if isVertex == true:
        result = true
        try:
            let v = getVertexById(g, id)
        except ValueError:
            result = false
        except:
            raise
    else:
        result = true
        try:
            let e = getEdgeById(g, id)
        except ValueError:
            result = false
        except:
            raise


proc contains*(g: Graph, v: Vertex): bool =
    ## contains a vertex or not
    return g.vertices.contains(v)

proc contains*(g: Graph, vs: HashSet[Vertex]): bool =
    ## contains a vertex set or not
    for v in vs:
        if contains(g, v) == false:
            return false
    return true

proc contains*(g: Graph, edge: Edge): bool =
    ## contains an edge or not
    return g.edges.contains(edge)

proc contains*(g: Graph, es: HashSet[Edge]): bool =
    ## contains an edge set or not
    for e in es:
        if contains(g, e) == false:
            return false
    return true

proc contains*(g1: Graph, g2: Graph): bool =
    ## contains other graph or not
    return bool(g1.contains(g2.vertices) and g1.contains(g2.edges))


proc `==`*(g1: Graph, g2: Graph): bool =
    ## compare two graphs for equality of vertices and edges
    let cond1 = g1.vertices == g2.vertices
    let cond2 = g1.edges == g2.edges
    let cond3 = g1.edgeBehaviour == g2.edgeBehaviour
    return bool(cond1 and cond2 and cond3)
