## immutable graph object for nim

from edge import Edge
from vertex import Vertex, VertexData

type
    Graph*[T: VertexData] = object
        edges*: seq[Edge[T]]
        vertices*: seq[Vertex[T]]
        id*: uint

proc newGraph*[T: VertexData](es: seq[Edge[T]], 
                              vs: seq[Vertex[T]], gid: uint): Graph[T] =
    ## make a new graph
    return Graph[T](edges: es, vertices: vs, id: gid)
