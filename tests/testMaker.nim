# test maker.nim

import unittest
import os

#from maker import makeGraphFromFile
import maker
import xmlparser
import xmltree

suite "maker.nim tests":

    echo "--------------------"
    echo "Maker tests started:"
    echo "--------------------"
    test "Test get node key values":
        let cdir: string = os.getCurrentDir()
        let tdir: string = os.joinPath(cdir, "tests")
        let gpath: string = os.joinPath(tdir, "graphml-test.xml")
        assert os.fileExists(gpath)
        echo "file exist"
        let node = xmlparser.loadXml(gpath)
        let nodes = maker.getNodeKeys(node)
        let cmpnode = xmlparser.parseXml("<key id='d0' for='node' attr.name='color' attr.type='string'><default>yellow</default></key>")
        let cmpnodes = @[cmpnode]
        check($(nodes) == $(cmpnodes))

    test "check edge keys":
        let cdir: string = os.getCurrentDir()
        let tdir: string = os.joinPath(cdir, "tests")
        let gpath: string = os.joinPath(tdir, "graphml-test.xml")
        assert os.fileExists(gpath)
        echo "file exist"
        let node = xmlparser.loadXml(gpath)
        let nodes = maker.getEdgeKeys(node)
        let cmpnode = xmlparser.parseXml("<key id='d1' for='edge' attr.name='weight' attr.type='double'/>")
        let cmpnodes = @[cmpnode]
        check($(nodes) == $(cmpnodes))

    echo "------------------"
    echo "Maker tests ended:"
    echo "------------------"

