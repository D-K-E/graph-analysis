# test maker.nim

import unittest
import os

#from maker import makeGraphFromFile
import maker
import vdata
import edge
import vertex
import xmlparser
import xmltree
import tables

suite "maker.nim tests":

    echo "--------------------"
    echo "Maker tests started:"
    echo "--------------------"

    let cdir: string = os.getCurrentDir()
    let tdir: string = os.joinPath(cdir, "tests")
    let gpath1: string = os.joinPath(tdir, "graphml-test.xml")
    let gpath2: string = os.joinPath(tdir, "graphml-test-2.xml")
    assert os.fileExists(gpath1)
    assert os.fileExists(gpath2)

    test "Test get node key values":
        let node = xmlparser.loadXml(gpath1)
        let nodes = maker.getNodeKeys(node)
        let cmpnode = xmlparser.parseXml("<key id='d0' for='node' attr.name='color' attr.type='string'><default>yellow</default></key>")
        let cmpnodes = @[cmpnode]
        check($(nodes) == $(cmpnodes))

    test "check edge keys":
        let node = xmlparser.loadXml(gpath1)
        let nodes = maker.getEdgeKeys(node)
        let cmpnode = xmlparser.parseXml("<key id='d1' for='edge' attr.name='weight' attr.type='double'/>")
        let cmpnodes = @[cmpnode]
        check($(nodes) == $(cmpnodes))

    test "test get node key by id":
        let mynode = xmlparser.loadXml(gpath2)
        let nodeKeys = maker.getNodeKeys(mynode)
        let cmpnode1 = xmlparser.parseXml("<key id='d0' for='node' attr.name='color' attr.type='string'><default>yellow</default></key>")
        let cmpnode2 = xmlparser.parseXml("<data key='d0'>green</data>")
        let resnode = maker.getNodeKeyById(cmpnode2, nodeKeys)
        check($(resnode) == $(cmpnode1))

    test "cast data type node 2 vertex data float":

        let keyNode = xmlparser.parseXml(
            "<key id='d1' for='node' attr.name='weight' attr.type='double'><default>yellow</default></key>"
        )
        let dataNode = xmlparser.parseXml("<data key='d1'>1.0</data>")
        let myvdata = newVData(1.0)
        let cmpdata = castDataType(dataNode, keyNode)
        check(myvdata == cmpdata)

    test "cast data type node 2 vertex data string":

        let keyNode = xmlparser.parseXml(
            "<key id='d1' for='node' attr.name='color' attr.type='string'><default>yellow</default></key>"
        )
        let dataNode = xmlparser.parseXml("<data key='d1'>yellow</data>")
        let myvdata = newVData("yellow")
        let cmpdata = castDataType(dataNode, keyNode)
        check(myvdata == cmpdata)

    test "get edge from edge node":
        let mynode = xmlparser.loadXml(gpath2)
        let nodes = maker.getEdgeKeys(mynode)
        let mess = "<edge id='e1' source='n0' target='n1'><data"
        let mess2 = mess & " key='d1'>1.0</data></edge>"
        let edgenode = xmlparser.parseXml(mess2)
        let myedge = maker.getEdgeFromEdgeNode(edgenode, keys = nodes)
        var edata = initOrderedTable[string, seq[vdata.VertexData]]()
        let myseq = @[newVFloat(1.0)]
        edata["weight"] = myseq
        let cmpedge = edge.Edge(fromVId: "n0", toVId: "n1",
                                id: "e1", data: vdata.newVData(edata))
        check(myedge == cmpedge)

    test "test get node from node element of graph":
        let mynode = xmlparser.loadXml(gpath2)
        let nodeKeys = maker.getNodeKeys(mynode)
        let mess = "<node id='n2'><data"
        let mess2 = mess & " key='d0'>blue</data></node>"
        let node = xmlparser.parseXml(mess2)
        let vertex = maker.getNodeFromNodeEl(node, nodeKeys)
        var vidata = initOrderedTable[string, seq[vdata.VertexData]]()
        let myseq = @[newVData("blue")]
        vidata["color"] = myseq
        let nvertex = Vertex(id: "n2", data: newVData(vidata))
        check(vertex == nvertex)

    test "test make graph":
        let mynode = xmlparser.loadXml(gpath2)
        let grph = maker.makeGraphFromGraphEl(mynode)
        echo grph


    echo "------------------"
    echo "Maker tests ended:"
    echo "------------------"

