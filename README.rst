################
Graph Analysis
################

.. image:: https://travis-ci.com/D-K-E/graph-analysis.svg?branch=master
    :target: https://travis-ci.com/D-K-E/graph-analysis

A repo on analysis of graphs as in graph theory.

The goal is to concentrate on analysis rather than io. A small subset of
GraphML format is assumed for specification of graphs. You can find a sample
of it in tests folder. All graphs are immutable once they are created.
Functions are going to be documented and referenced as they are added. Very
experimental stuff do not put anywhere near production code.

Currently almost all functionality is deals with undirected graphs.

Here are the current set of functions defined in analyzer:

- find order

- find the number of vertices

- find the number of edges

- get edge set for a given vertex from a graph

- check if a graph is complete: all vertices are pairwise adjacent

- check if a given graph is a proper subgraph of another graph
- check if a given graph is a subgraph of another graph

- Hypergraph structure is also added. Some extensions to graphml for dealing
  with directed hypergraphs are also added.
