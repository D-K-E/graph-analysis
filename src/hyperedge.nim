## immutable hyperedge object for nim
## still very experimental

from vertex import Vertex, newVertex
import vdata
import hashes
import sets # union, difference, hashset etc

type
    Hyperedge* = object
        fromVIds*: HashSet[string]
        toVIds*: HashSet[string]
        id*: string
        data*: VertexData

proc toString*(e: Hyperedge): string =
    ## string representation of an hyperedge
    var mess = "Hyperedge: from vertices: " & $(e.fromVIds)
    mess = mess & ", to " & $(e.toVIds)
    mess = mess & ", id: " & e.id & ", data: " & vdata.toString(e.data)
    return mess

proc `==`*(e1, e2: Hyperedge): bool =
    ## compare two edges
    let fV1Cmp = bool(e1.fromVIds == e2.fromVIds)
    let fV2Cmp = bool(e1.toVIds == e2.toVIds)
    let idCmp = bool(e1.id == e2.id)
    let dataCmp = bool(e1.data == e2.data)
    return bool(fV1Cmp and fV2Cmp and idCmp and dataCmp)

proc hash*(e1: Hyperedge): Hash =
    ## hash edge
    var h: Hash = 0
    h = h !& hash(e1.fromVIds)
    h = h !& hash(e1.toVIds)
    h = h !& hash(e1.id)
    h = h !& hash(e1.data)
    return h


proc newHyperedge*(fromVertices: HashSet[Vertex],
                   toVertices: HashSet[Vertex],
                   heid: string, data: VertexData = newVNull()): Hyperedge =
    ## make a new edge
    var fvertIds = initHashSet[string]()
    for v in fromVertices:
        fvertIds.incl(v.id)
    var tvertIds = initHashSet[string]()
    for v in toVertices:
        tvertIds.incl(v.id)
    return Hyperedge(fromVIds: fvertIds,
                toVIds: tvertIds,
                id: heid, data: data)

proc isHyperedgeIncident*(hyp1: Hyperedge, hyp2: Hyperedge): bool =
    ## are two hyperedges incident
    let vset1 = union(hyp1.fromVIds, hyp1.toVIds)
    let vset2 = union(hyp2.fromVIds, hyp2.toVIds)
    for v in vset2:
        if v in vset1:
            return true
    return false
