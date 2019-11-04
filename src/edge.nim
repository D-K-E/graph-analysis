## immutable edge object for nim

from vertex import Vertex, newVertex
import vdata
import hashes

type
    Edge* = object
        fromVId*: string
        toVId*: string
        id*: string
        data*: VertexData

proc toString*(e: Edge): string =
    ## string representation of an edge
    var mess = "Edge: from vertex: " & e.fromVId & ", to " & e.toVId 
    mess = mess & ", id: " & e.id & ", data: " & vdata.toString(e.data)
    return mess


proc `==`*(e1, e2: Edge): bool =
    ## compare two edges
    let fV1Cmp = bool(e1.fromVId == e2.fromVId)
    let fV2Cmp = bool(e1.toVId == e2.toVId)
    let idCmp = bool(e1.id == e2.id)
    let dataCmp = bool(e1.data == e2.data)
    return bool(fV1Cmp and fV2Cmp and idCmp and dataCmp)

proc hash*(e1: Edge): Hash =
    ## hash edge
    var h: Hash = 0
    h = h !& hash(e1.fromVId)
    h = h !& hash(e1.toVId)
    h = h !& hash(e1.id)
    h = h !& hash(e1.data)
    return h


proc newEdge*(fromVertex: Vertex,
              toVertex: Vertex,
              eid: string,
              data: VertexData = newVNull()): Edge =
    ## make a new edge
    return Edge(fromVId: fromVertex.id,
                toVId: toVertex.id,
                id: eid, data: data)

proc newEdge*(fromVertex: string, toVertex: string, eid: string,
              data: VertexData = newVNull()): Edge =
    return Edge(fromVId: fromVertex, toVId: toVertex, id: eid, data: data)

proc isVertexIncident*(edge: Edge, vertex: Vertex): bool =
    ## is vertex incident
    let firstV1Cmp = bool(edge.fromVId == vertex.id)
    let firstV2Cmp = bool(edge.toVId == vertex.id)
    return bool(firstV1Cmp or firstV2Cmp)


