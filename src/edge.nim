## immutable edge object for nim

from vertex import Vertex, newVertex, compare2Vertices

type
    Edge* = object
        v1*: Vertex
        v2*: Vertex
        id*: uint

proc newEdge*(vertex1: Vertex,
              vertex2: Vertex, eid: uint): Edge =
    ## make a new edge
    return Edge(v1: vertex1, v2: vertex2, id: eid)

proc isVertexIncident*(edge: Edge, vertex: Vertex): bool =
    ## is vertex incident
    let firstV1Cmp = compare2Vertices(edge.v1, vertex)
    let firstV2Cmp = compare2Vertices(edge.v2, vertex)
    return bool(firstV1Cmp or firstV2Cmp)

proc compare2Edges*(e1: Edge, e2: Edge): bool =
    ## is edges same
    let firstV1Cmp = compare2Vertices(e1.v1, e2.v1)
    let firstV2Cmp = compare2Vertices(e1.v2, e2.v2)
    let idCmp = e1.id == e2.id
    return bool(firstV1Cmp and firstV2Cmp and idCmp)

