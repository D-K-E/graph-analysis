## immutable vertex object for nim
import system
import json
import vdata

type
    Vertex* = object
        id*: string
        data*: vdata.VertexData

proc newVertex*(vid: string, data: VertexData): Vertex =
    ## make a new vertex
    return Vertex(id: vid, data: data)

proc compare2Vertices*(v1: Vertex, v2: Vertex): bool =
    ## compare the two vertices
    return bool(v1.id == v2.id and v1.data == v2.data)
