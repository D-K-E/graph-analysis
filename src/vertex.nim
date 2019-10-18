## immutable vertex object for nim
import system

type VertexData* = SomeNumber | bool | string | char | seq[string] | seq[SomeNumber]

type
    Vertex*[T: VertexData] = object
        id*: uint
        data*: T

proc newVertex*[T: VertexData](vid: uint, data: T): Vertex[T] =
    ## make a new vertex
    return Vertex[T](id: vid, data: data)
