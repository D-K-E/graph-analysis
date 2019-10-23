## immutable edge object for nim

from vertex import Vertex, newVertex, compare2Vertices
from vdata import VertexData, newVNull, toString

type
    Edge* = object
        fromVId*: string
        toVId*: string
        id*: string
        data*: VertexData

proc toString*(e: Edge): string =
    ## string representation of an edge
    var mess = "Edge: from vertex: " & e.fromVId & ", to " & e.toVId 
    mess = mess & ", id: " & e.id & ", data: " & toString(e.data)
    return mess

proc newEdge*(fromVertex: Vertex,
              toVertex: Vertex,
              eid: string,
              data: VertexData = newVNull()): Edge =
    ## make a new edge
    return Edge(fromVId: fromVertex.id,
                toVId: toVertex.id,
                id: eid, data: data)

proc compare2Edges*(e1: Edge, e2: Edge): bool =
    ## is edges same
    let fV1Cmp = bool(e1.fromVId == e2.fromVId)
    let fV2Cmp = bool(e1.toVId == e2.toVId)
    let idCmp = e1.id == e2.id
    let dataCmp = e1.data == e2.data
    return bool(fV1Cmp and fV2Cmp and idCmp and dataCmp)

proc isVertexIncident*(edge: Edge, vertex: Vertex): bool =
    ## is vertex incident
    let firstV1Cmp = bool(edge.fromVId == vertex.id)
    let firstV2Cmp = bool(edge.toVId == vertex.id)
    return bool(firstV1Cmp or firstV2Cmp)


