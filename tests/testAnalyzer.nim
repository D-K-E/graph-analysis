# author: Kaan Eraslan
# license: see, LICENSE
# test analyzer.nim

import unittest
import os

import vertex # holds vertex object and some operators based on it
import edge # holds edge objects and some operators based on it
import graph # holds graph objects and some operators based on it
import maker # graph maker
import vdata # VertexData related
import sets # hash set related
import tables # ordered table related
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
    let gdir: string = os.joinPath(tdir, "graphs")
    let gpath1: string = os.joinPath(gdir, "graphml-test.xml")
    let gpath2: string = os.joinPath(gdir, "graphml-test-2.xml")
    let gpath3: string = os.joinPath(gdir, "graphml-not-complete.xml")
    let gpath4: string = os.joinPath(gdir, "graphml-test-1-sub.xml")
    let gpath5: string = os.joinPath(gdir, "graphml-test-1-notsub.xml")
    let gpath6: string = os.joinPath(gdir, "simple-graphml.xml")
    let gpath7: string = os.joinPath(gdir, "simple-graphml-induced.xml")
    let gpath8: string = os.joinPath(gdir, "simple-graphml-not-induced.xml")
    assert os.fileExists(gpath1)
    assert os.fileExists(gpath2)
    assert os.fileExists(gpath3)
    assert os.fileExists(gpath4)
    assert os.fileExists(gpath5)
    assert os.fileExists(gpath6)
    assert os.fileExists(gpath7)
    assert os.fileExists(gpath8)
    let mygraph: Graph = makeGraphFromFile(gpath1)
    let completeGraph: Graph = makeGraphFromFile(gpath2)
    let notCompleteGraph: Graph = makeGraphFromFile(gpath3)
    let subGr: Graph = makeGraphFromFile(gpath4)
    let notSubGr: Graph = makeGraphFromFile(gpath5)
    let simpleGr: Graph = makeGraphFromFile(gpath6)
    let inducedGr: Graph = makeGraphFromFile(gpath7)
    let notInducedGr: Graph = makeGraphFromFile(gpath8)

    test "test graph order":

        let gorder = findGraphOrder(mygraph)
        check(gorder == 6)

    test "test graph vertex number":
        let gvertexNb = findNumberOfVertices(mygraph)
        check(gvertexNb == 6)

    test "test graph edge number":
        let gedgeNb = findNumberOfEdges(mygraph)
        check(gedgeNb == 7)

    test "test get edge set for vertex":
        let myvert = Vertex(id: "n1", data: newVNull())
        let eset = getEdgeSetForVertex(gr = mygraph, vert = myvert)
        var vstbl1 = initOrderedTable[string, VertexData]()
        vstbl1["weight"] = newVData(arr = @[newVFloat(1.0)])
        let vd1 = newVData(vstbl1)
        let e1 = Edge(fromVId: "n0", toVId: "n1", data: vd1, id: "e1")
        var vstbl2 = initOrderedTable[string, VertexData]()
        vstbl2["weight"] = newVData(arr = @[newVFloat(2.0)])
        let vd2 = newVData(vstbl2)
        let e2 = Edge(fromVId: "n1", toVId: "n3", data: vd2, id: "e2")
        var edgeSet = initHashSet[Edge]()
        edgeSet.incl(e2)
        edgeSet.incl(e1)
        check(eset == edgeSet)

    test "is graph complete":
        let isComplete = isGraphComplete(mygraph)
        let isNotComplete = isGraphComplete(notCompleteGraph)
        check(isComplete == true)
        check(isNotComplete == false)

    test "test is subgraph":
        let isSubgraphG1 = isSubgraph(mygraph, subGr)
        let isSubgraphG2 = isSubgraph(mygraph, mygraph)
        let isNotSubgraphG = isSubgraph(mygraph, notSubGr)
        check(isSubgraphG1 == true)
        check(isSubgraphG2 == true)
        check(isNotSubgraphG == false)

    test "test is proper subgraph":
        let isSubgraphG1 = isProperSubgraph(mygraph, subGr)
        let isSubgraphG2 = isProperSubgraph(mygraph, mygraph)
        let isNotSubgraphG = isProperSubgraph(mygraph, notSubGr)
        check(isSubgraphG1 == true)
        check(isSubgraphG2 == false)
        check(isNotSubgraphG == false)

    test "test is induced subgraph":
        let isInd = isInducedSubgraph(simpleGr, inducedGr)
        let notIsInd = isInducedSubgraph(simpleGr, notInducedGr)
        check(isInd == true)
        check(notIsInd == false)
 
    echo "---------------------"
    echo "Analyzer tests ended:"
    echo "---------------------"


