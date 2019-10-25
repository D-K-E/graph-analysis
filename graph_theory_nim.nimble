# Package

version = "0.1.0"
author = "Kaan Eraslan"
description = "Simple library for dealing with graph analysis"
license = "GPL-3.0"
srcDir = "src"
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
