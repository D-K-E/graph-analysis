# author: Kaan Eraslan
# license: see, LICENSE
# test analyzer.nim

import unittest
import os

from vertex import compare2Vertices
from vertex import Vertex
from edge import Edge, compare2Edges
from graph import Graph, newGraph, isVertexContained, isEdgeContained
from graph import areVerticesContained, areEdgesContained
from graph import compare2Graphs4Equality
from maker import makeGraphFromFile
from analyzer import findGraphOrder
from analyzer import findNumberOfEdges
from analyzer import findNumberOfVertices
from analyzer import getEdgeSetForVertex
from analyzer import isGraphComplete
from analyzer import isSubgraph
from analyzer import isProperSubgraph
from analyzer import isInducedSubgraph

suite "analyzer.nim tests":

    echo "-----------------------"
    echo "Analyzer tests started:"
    echo "-----------------------"

    let cdir: string = os.getCurrentDir()
    let tdir: string = os.joinPath(cdir, "tests")
    let gpath1: string = os.joinPath(tdir, "graph-test.json")
    let gpath2: string = os.joinPath(tdir, "complete-graph-test.json")
    assert os.fileExists(gpath1)
    assert os.fileExists(gpath2)
    let mygraph: Graph = makeGraphFromFile(gpath1)
    let completeGraph: Graph = makeGraphFromFile(gpath2)

    test "test graph order":

        let gorder = findGraphOrder(mygraph)
        check(gorder == 10)

    test "test graph vertex number":
        let gvertexNb = findNumberOfVertices(mygraph)
        check(gvertexNb == 10)

    test "test graph edge number":
        let gedgeNb = findNumberOfEdges(mygraph)
        check(gedgeNb == 5)

    test "test get edge set for vertex":
        let es = getEdgeSetForVertex(mygraph,

    echo "---------------------"
    echo "Analyzer tests ended:"
    echo "---------------------"


