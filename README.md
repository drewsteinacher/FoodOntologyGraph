# FoodOntologyGraph
A Visualization of the Food Ontology available in the Wolfram Language

![Home page](https://raw.githubusercontent.com/drewsteinacher/FoodOntologyGraph/master/Files/OntologyGraph_NoLegend_Medium.png)

## Ontology Graph Description
The nodes of the ontology graph are food-related [Wolfram Knowledgebase](https://reference.wolfram.com/language/guide/KnowledgeRepresentationAndAccess.html) entity types (e.g. ["FoodType"](https://reference.wolfram.com/language/ref/interpreter/FoodType.html), ["Food"](https://reference.wolfram.com/language/ref/interpreter/Food.html)) or [Wolfram Language](https://www.wolfram.com/language/) data types (e.g. [List](https://reference.wolfram.com/language/ref/List.html), [Quantity](https://reference.wolfram.com/language/ref/Quantity.html)).
The edges of the graph are the properties of the entity types, which connect entity types to other entity types or data types.

## Graph construction
The complete code to create the ontology graph itself can be found in the [data collection](https://www.wolframcloud.com/objects/andrews/FoodOntologyGraph/OntologyGraph_GatherData.nb) and [construction](https://www.wolframcloud.com/objects/andrews/FoodOntologyGraph/OntologyGraph_Construction.nb) notebooks.

## Website
The code for creating and deploying [the website](https://www.wolframcloud.com/objects/andrews/FoodOntologyGraph/Home), hosted in the [Wolfram Cloud](https://www.wolfram.com/cloud/), can be seen in the [deployment notebook](https://raw.githubusercontent.com/drewsteinacher/FoodOntologyGraph/master/DeploySite.nb) (right-click and hit "Save link as..." to download).
