ClearAll["FoodOntologyGraph`*"];
ClearAll["FoodOntologyGraph`*`*"];

BeginPackage["FoodOntologyGraph`"];

DeploySite;

Begin["`Private`"];

DeploySite::usage = "DeploySite[dir_CloudObject] deploys the food ontology graph site to the given cloud object directory";
DeploySite::invalidroot = "Could not deploy. The given root `` is not a directory.";
DeploySite[root_CloudObject] := Module[
	{},
	If[DirectoryQ[root] || Not[FileExistsQ[root]],
		CopyFile[#, FileNameJoin[{root, FileNameTake[#]}]]& /@ FileNames["*.*", "Files"];
		CopyFile[#, FileNameJoin[{root, "ImageMaps", FileNameTake[#]}]]& /@ FileNames["*.*", "Files/ImageMaps"];
		KeyValueMap[
			CloudDeploy[#2, FileNameJoin[{root, #1}], Permissions -> "Public"]&,
			<|
				"Home" -> HomePage[root]
			|>
		],
		Message[DeploySite::invalidroot, root];
		$Failed
	]
];


HomePage[root_CloudObject] := Module[
	{},
	GalleryView[
		getHomePageContent[root],
		AppearanceRules -> <|
			"Title" -> column[{"An Ontology Graph of", "Computational Food Data"}, Alignment -> Center],
			"Description" -> getHomePageDescription[root],
			Pagination -> 2
		|>
	]
];

column[l_List, rest___] := Grid[List /@ l, rest];

getHomePageContent[root_CloudObject] := {
	<|
		"Content" -> "Food in Wolfram Language",
		"Description" -> Column[
			{
				Hyperlink["Ontology & Classification", CloudObject[FileNameJoin[{root, "FoodClassificationAndOntology.nb"}]]],
				Hyperlink["Nutrition Information", CloudObject[FileNameJoin[{root, "Nutrition.nb"}]]],
				Hyperlink["Physical and Chemical Data", CloudObject[FileNameJoin[{root, "PhysicalAndChemicalData.nb"}]]],
				Hyperlink["Packaged Food Ingredients", CloudObject[FileNameJoin[{root, "PackagedFoodIngredients.nb"}]]]
			}
		]
	|>,
	<|
		"Content" -> "Downloads and Code",
		"Description" -> Column[
			{
				Hyperlink["Graph with Legend", CloudObject[FileNameJoin[{root, "OntologyGraph_WithLegend_Medium_TwoColumn.pdf"}]]],
				Hyperlink["Graph Edge Table", CloudObject[FileNameJoin[{root, "OntologyGraph_EdgeTable.pdf"}]]],
				Hyperlink["Construction Notebook", CloudObject[FileNameJoin[{root, "OntologyGraph_Construction.nb"}]]],
				Hyperlink["Site Git Repository", "https://github.com/drewsteinacher/FoodOntologyGraph"],
				Hyperlink["Open Source Meal Tracker", "https://github.com/drewsteinacher/Meal-Tracker"]
			}
		]
	|>,
	<|
		"Content" -> "Wolfram Products",
		"Description" -> Column[
			{
				Hyperlink["Wolfram|Alpha", "http://www.wolframalpha.com"],
				Hyperlink["Wolfram|One", "http://www.wolfram.com/wolfram-one/"],
				Hyperlink["Wolfram Language", "http://www.wolfram.com/language/"],
				Hyperlink["Mathematica", "http://www.wolfram.com/mathematica/"],
				Hyperlink["Wolfram Cloud", "http://www.wolfram.com/cloud/"]
			}
		]
	|>,
	<|
		"Content" -> "More Information",
		"Description" -> Column[
			{
				Hyperlink["Wolfram Technology Conference 2017 Video", "http://www.wolfram.com/broadcast/video.php?c=430&p=5&v=2024"],
				Hyperlink["Wolfram Technology Conference 2016 Video", "http://www.wolfram.com/broadcast/video.php?c=423&v=1673"],
				Hyperlink["Wolfram Technology Conference 2015 Notebook", "http://library.wolfram.com/infocenter/Conferences/9330/"]
			}
		]
	|>

};



getHomePageDescription[root_CloudObject] := Module[
	{},
	column[
		{
			Style["A visualization of the food ontology available in the Wolfram Language", 20],
			Hyperlink[
				Import[CloudObject[FileNameJoin[{root, "ImageMaps", "imageMap.m"}]]],
				First @ CloudObject[FileNameJoin[{root, "OntologyGraph_NoLegend_Large.png"}]]
			],
			
			EmbeddedHTML[StringTemplate["<img src=\"``\">"][First @ FileNameJoin[{root, "OntologyGraph_Legend_Better.PNG"}]]],
			
			Row[
				{
					Style["View high-resolution images:", 18],
					Row[
						Style[#, 18]& /@ {
							Hyperlink["PNG", CloudObject[FileNameJoin[{root, "OntologyGraph_NoLegend_Large.png"}]]],
							Hyperlink["PDF", CloudObject[FileNameJoin[{root, "OntologyGraph_NoLegend_Large.pdf"}]]],
							Hyperlink["SVG", CloudObject[FileNameJoin[{root, "OntologyGraph_NoLegend_Large.svg"}]]]
						},
						Row[{Spacer[1], "|", Spacer[1]}]
					]
				},
				Spacer[2]
			],
			
			Row[
				{
					"See the",
					Hyperlink["construction notebook", CloudObject[FileNameJoin[{root, "OntologyGraph_Construction.nb"}]]],
					"for more details."
				},
				Spacer[1]
			] // Style[#, 18]&
		},
		Alignment -> Center
	]
];


End[];

EndPackage[];