extends Node

class_name GotOpenAi

func _ready() -> void:
	print("Start init node of GotOpenAi")
	
	var toolA: Tool = FunctionToolBuilder.new("sum")\
	.with_description("Sums two values.")\
	.with_property(
		PropertyBuilder.new("a", PropertyTypes.Type.NumberJson)\
			.build(), true)\
	.with_property(
		PropertyBuilder.new("b", PropertyTypes.Type.NumberJson)\
			.build(), true)\
	.build()
	
	var toolB: Tool = FunctionToolBuilder.new("div")\
	.with_description("Divides two values.")\
	.with_property(
		PropertyBuilder.new("a", PropertyTypes.Type.NumberJson)\
			.with_description("Number to be divided.").build(), true)\
	.with_property(
		PropertyBuilder.new("b", PropertyTypes.Type.NumberJson)\
			.with_description("Number that divides.").build(), false)\
	.build()
	
	var configuration: Configuration = Configuration.new("gpt-3", "api_key")
	
	var gpt_object: TemplateBase = Completion.new(configuration)\
	.with_tool(toolA)\
	.with_tool(toolB)\
	.get_template()
	
	gpt_object.append_static_context("system", "You are a math teacher.")
	gpt_object.append_static_context_dictionary({"role": "system", 
	"message": "You should help your students."})
	gpt_object.append_message("user", 
	"How to calculate a diferential of a linear function?")
	
	gpt_object.get_reply()
