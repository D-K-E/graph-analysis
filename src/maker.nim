## maker of graph, vertex, edge
from vertex import Vertex, newVertex
from edge import Edge, newEdge
from graph import Graph, newGraph
import tables
import vdata
import xmltree
import xmlparser

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
    ## get keys that are for node
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
    let nodeText = node.text()
    let dataType = node.attr("attr.type")
    let vd: VertexData
    case dataType 
    of "double":
        let temp = float(dataType)
        let vd: VertexData = newVFloat(temp)
    of "float":
        let temp = float(dataType)
        let vd: VertexData = newVFloat(temp)
    of "int":
        let temp = int(dataType)
        let vd: VertexData = newVInt(temp)
    of "long":
        let temp = BiggestInt(dataType)
        let vd: VertexData = newVInt(temp)
    of "boolean":
        let temp = bool(dataType)
        let vd: VertexData = newVBool(temp)
    of "string":
        let temp = string(dataType)
        let vd: VertexData = newVString(temp)
    else:
        raise newException(ValueError, dataType & " is unknown attribute type")
    return vd

proc getEdgeData*(edgeNode: XmlNode, edgeKeys: seq[XmlNode]): VertexData =
    ## create edge data
    var dataNodes: seq[XmlNode]
    edgeNode.findAll("data", dataNodes)
    if dataNodes.len() == 0:
        return newVNull()
    var dataTable = initOrderedTable[string, seq[VertexData]]()
    for dataNode in dataNodes:
        let keyNode = getNodeKeyById(dataNode, edgeKeys)
        let keyName = keyNode.attr("attr.name")
        let keyVData = castDataType(dataNode, keyNode)
        dataTable[keyName].add(keyVData)
    return flattenVTable(dataTable)


