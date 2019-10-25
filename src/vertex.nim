## immutable vertex object for nim
import system
import json
import vdata
import hashes

type
    Vertex* = object
        id*: string
        data*: vdata.VertexData

proc newVertex*(vid: string, data: VertexData): Vertex =
    ## make a new vertex
    return Vertex(id: vid, data: data)

proc `==`*(v1, v2: Vertex): bool =
    ## compare two vertices for equality
    return bool(v1.id == v2.id and v1.data == v2.data)

proc hash*(v1: Vertex): Hash =
    ## obtain hash value for vertex
    var h: Hash = 0
    h = h !& hash(v1.id)
    h = h !& hash(v1.data)
    return !$h
