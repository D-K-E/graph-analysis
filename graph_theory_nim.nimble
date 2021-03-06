# Package

version = "0.1.0"
author = "Kaan Eraslan"
description = "Simple library for dealing with graph analysis"
license = "GPL-3.0"
srcdir = "src"
installExt = @["nim"]
bin = @["graph_theory_nim"]
binDir = "bin"



# Dependencies

requires "nim >= 0.20.2"

# Tasks

task testMaker, "Runs maker tests":
    exec "nim c -r tests/testMaker.nim"
    exec "rm tests/testMaker"

task testEdge, "Runs edge tests":
    exec "nim c -r tests/testEdge.nim"
    exec "rm tests/testEdge"

task testGraph, "Runs graph tests":
    exec "nim c -r tests/testGraph.nim"
    exec "rm tests/testGraph"

task testVertex, "Runs vertex tests":
    exec "nim c -r tests/testVertex.nim"
    exec "rm tests/testVertex"

task testAnalyzer, "Runs analyzer tests":
    exec "nim c -r tests/testAnalyzer.nim"
    exec "rm tests/testAnalyzer"

task testVdata, "Runs vdata tests":
    exec "nim c -r tests/testVData.nim"
    exec "rm tests/testVData"

task testConstructs, "Runs vdata, vertex, edge, graph tests":
    exec "nimble testVertex"
    exec "nimble testVdata"
    exec "nimble testEdge"
    exec "nimble testGraph"
    echo "All Done"


task makeEdgeDoc, "generates documentation for edge.nim":
    exec "nim doc src/edge.nim"
    exec "mv edge.html docs/edge.html"


task makeVertexDoc, "generates documentation for vertex.nim":
    exec "nim doc src/vertex.nim"
    exec "mv vertex.html docs/vertex.html"

task makeGraphDoc, "generates documentation for graph.nim":
    exec "nim doc src/graph.nim"
    exec "mv graph.html docs/graph.html"

task makeVdataDoc, "generates documentation for vdata.nim":
    exec "nim doc src/vdata.nim"
    exec "mv vdata.html docs/vdata.html"

task makeHyperedgeDoc, "generates documentation for hyperedge.nim":
    exec "nim doc src/hyperedge.nim"
    exec "mv hyperedge.html docs/hyperedge.html"

task makeMakerDoc, "generates documentation for maker.nim":
    exec "nim doc src/maker.nim"
    exec "mv maker.html docs/maker.html"

task makeAnalyzerDoc, "generates documentation for analyzer.nim":
    exec "nim doc src/analyzer.nim"
    exec "mv analyzer.html docs/analyzer.html"

task makeDocs, "generates documentation for source files":
    exec "nimble makeVdataDoc"
    exec "nimble makeVertexDoc"
    exec "nimble makeEdgeDoc"
    exec "nimble makeGraphDoc"
    exec "nimble makeHyperedgeDoc"
    exec "nimble makeMakerDoc"
    exec "nimble makeAnalyzerDoc"
