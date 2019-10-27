# test maker.nim

import unittest
import os

#from maker import makeGraphFromFile
import maker
import vdata
import xmlparser
import xmltree

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

    echo "------------------"
    echo "Maker tests ended:"
    echo "------------------"

