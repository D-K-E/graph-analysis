## immutable vertex object for nim
import system
import json


type
    Vertex* = object
        id*: uint
        data*: json.JsonNode

proc newVertex*(vid: uint, data: JsonNode): Vertex =
    ## make a new vertex
    return Vertex(id: vid, data: data)

proc compare2Vertices*(v1: Vertex, v2: Vertex): bool =
    ## compare the two vertices
    return bool(v1.id == v2.id and v1.data == v2.data)
