## immutable edge object for nim

from vertex import Vertex, newVertex, VertexData

type
    Edge*[T: VertexData] = object
        v1*: Vertex[T]
        v2*: Vertex[T]
        id*: uint

proc newEdge*[T: VertexData](vertex1: Vertex[T],
                             vertex2: Vertex[T], eid: uint): Edge[T] =
        ## make a new edge
        return Edge[T](v1: vertex1, v2: vertex2, id: eid)
