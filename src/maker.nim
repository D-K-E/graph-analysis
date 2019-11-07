## maker of graph, vertex, edge
from vertex import Vertex, newVertex
from edge import Edge, newEdge
from graph import Graph, newGraph
import sets # for hash set
import tables
import vdata
import xmltree
import xmlparser
from strutils import parseFloat, parseInt, parseBiggestInt, parseBool

## read a graphml file and parse it into a graph structure
#[
Example GraphML
<?xml version="1.0" encoding="UTF-8"?>
<graphml xmlns="http://graphml.graphdrawing.org/xmlns"  
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://graphml.graphdrawing.org/xmlns 
        http://graphml.graphdrawing.org/xmlns/1.0/graphml.xsd">
  <key id="d0" for="node" attr.name="color" attr.type="string">
    <default>yellow</default>
  </key>
  <key id="d1" for="edge" attr.name="weight" attr.type="double"/>
  <graph id="G" edgedefault="undirected">
    <node id="n0">
      <data key="d0">green</data>
    </node>
    <node id="n1"/>
    <node id="n2">
      <data key="d0">blue</data>
    </node>
    <node id="n3">
      <data key="d0">red</data>
    </node>
    <node id="n4"/>
    <node id="n5">
      <data key="d0">turquoise</data>
    </node>
    <edge id="e0" source="n0" target="n2">
      <data key="d1">1.0</data>
    </edge>
    <edge id="e1" source="n0" target="n1">
      <data key="d1">1.0</data>
    </edge>
    <edge id="e2" source="n1" target="n3">
      <data key="d1">2.0</data>
    </edge>
    <edge id="e3" source="n3" target="n2"/>
    <edge id="e4" source="n2" target="n4"/>
    <edge id="e5" source="n3" target="n5"/>
    <edge id="e6" source="n5" target="n4">
      <data key="d1">1.1</data>
    </edge>
  </graph>
</graphml>

]#

proc getNodeKeyVal(node: XmlNode, tname: string,
                   attrname: string): seq[XmlNode] =
    ## get node key value
    for keytag in node.findAll(tname, caseInsensitive = true):
        if keytag.attr("for") == attrname:
            result.add(keytag)

proc getNodeKeys*(node: XmlNode): seq[XmlNode] =
    ## get keys that are for node
    return getNodeKeyVal(node, tname = "key", attrname = "node")

proc getEdgeKeys*(node: XmlNode): seq[XmlNode] =
    ## get keys that are for edge
    return getNodeKeyVal(node, tname = "key", attrname = "edge")

proc getNodeKeyById*(dataNode: XmlNode, keyNodes: seq[XmlNode]): XmlNode =
    ## get node key by using id
    let idstr = dataNode.attr("key")
    for keyNode in keyNodes:
        let nodeId = keyNode.attr("id")
        if nodeId == idstr:
            return keyNode
    raise newException(ValueError, idstr & " is not found in keys")


proc castDataType*(node: XmlNode, key: XmlNode): VertexData =
    ## from key get attribute type and cast it to vertex data
    let nodeText = innerText(node)
    let dataType = key.attr("attr.type")
    var vd: VertexData
    case dataType
    of "double":
        let temp = parseFloat(nodeText)
        let vd: VertexData = newVFloat(temp)
        return vd
    of "float":
        let temp = parseFloat(nodeText)
        let vd: VertexData = newVFloat(temp)
        return vd
    of "int":
        let temp = parseInt(nodeText)
        let vd: VertexData = newVInt(temp)
        return vd
    of "long":
        let temp = parseBiggestInt(nodeText)
        let vd: VertexData = newVInt(temp)
        return vd
    of "boolean":
        let temp = parseBool(nodeText)
        let vd: VertexData = newVBool(temp)
        return vd
    of "string":
        let temp = $(nodeText)
        let vd: VertexData = newVString(temp)
        return vd
    else:
        raise newException(ValueError, dataType & " is unknown attribute type")
    return newVNull()

proc getNodeEdgeData*(edgeNode: XmlNode, nodeEdgeKeys: seq[
        XmlNode]): VertexData =
    ## create edge data
    var dataNodes: seq[XmlNode]
    edgeNode.findAll("data", dataNodes)
    if dataNodes.len() == 0:
        return newVNull()
    var dataTable = initOrderedTable[string, seq[VertexData]]()
    for dataNode in dataNodes:
        let keyNode = getNodeKeyById(dataNode, nodeEdgeKeys)
        let keyName = keyNode.attr("attr.name")
        let keyVData: vdata.VertexData = castDataType(dataNode, keyNode)
        if dataTable.hasKey(keyName) == true:
            dataTable[keyName].add(keyVData)
        else:
            dataTable[keyName] = @[keyVData]
    return flattenVTable(dataTable)

proc getEdgeFromEdgeNode*(edgeNode: XmlNode, keys: seq[XmlNode]): Edge =
    ## get edge from edge xml
    let edgeData = getNodeEdgeData(edgeNode, keys)
    let eid: string = edgeNode.attr("id")
    let source: string = edgeNode.attr("source")
    let target: string = edgeNode.attr("target")
    return Edge(fromVId: source, toVId: target, id: eid,
            data: edgeData)

proc getNodeFromNodeEl*(nodeEl: XmlNode, keys: seq[XmlNode]): Vertex =
    ## get node from node element
    let nodeData = getNodeEdgeData(nodeEl, keys)
    let vid: string = nodeEl.attr("id")
    return Vertex(id: vid, data: nodeData)

proc getEdgesFromGraphEl(mainNode: XmlNode): seq[Edge] =
    ## get edges from graph element
    let graphEl = mainNode.child("graph")
    let edgeKeys = getEdgeKeys(mainNode)
    var edgeNodes: seq[XmlNode]
    for el in graphEl:
        if el.tag() == "edge":
            let edge = getEdgeFromEdgeNode(el, edgeKeys)
            result.add(edge)

proc getNodesFromGraphEl(mainNode: XmlNode): seq[Vertex] =
    ## get vertices from graph element
    let graphEl = mainNode.child("graph")
    let vkeys = getNodeKeys(mainNode)
    var nodeEls: seq[XmlNode]
    for el in graphEl:
        if el.tag() == "node":
            let vert = getNodeFromNodeEl(el, vkeys)
            result.add(vert)

proc makeGraphFromGraphEl*(graphEl: XmlNode): Graph =
    ## make graph from graph element of graph ML
    let vertices = getNodesFromGraphEl(graphEl)
    let edges = getEdgesFromGraphEl(graphEl)
    let graphElement = graphEl.child("graph")
    let gid = graphElement.attr("id")
    let ebehaviour = graphElement.attr("edgedefault")
    return Graph(edges: toHashSet(edges), vertices: toHashSet(vertices),
    id: gid, edgeBehaviour: ebehaviour)

proc makeGraphFromFile*(filepath: string): Graph =
    ## make graph from xml path
    let graphXmlNode = loadXml(filepath)
    return makeGraphFromGraphEl(graphXmlNode)

proc makeGraphFromStr*(xmlstr: string): Graph =
    ## make graph from xml string
    let graphXmlNode = parseXml(xmlstr)
    return makeGraphFromGraphEl(graphXmlNode)
