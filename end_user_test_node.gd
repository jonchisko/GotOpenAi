extends Node

@export
var api_key: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	
	var gpt_object: TemplateBase = GotOpenAi.GetPreviewCompletion()\
	.with_tool(toolA)\
	.with_tool(toolB)\
	.get_template()
	
	gpt_object.append_static_context("system", "You are a math teacher.")
	gpt_object.append_static_context_dictionary({"role": "system", 
	"message": "You should help your students."})
	gpt_object.append_message("user", 
	"How to calculate a diferential of a linear function?")
	
	gpt_object.get_reply()
	
	# should fail
	#var gpt_fail_object = GotOpenAi.GetGptCompletion()
	var user_configuration = UserConfiguration.new(self.api_key) # TODO it s up to the dev from where the api will be read
	# for his solution
	# the user at the end will need to enter it in UI. 
	GotOpenAi.user_configuration = user_configuration
	var _gpt_fail_object = GotOpenAi.GetGptCompletion()
	
	
	var data = "{\"key\": [102020, 1122, 221]}"
	var d = JSON.parse_string(data)
	print(d)
	print(d["key"])
	print(type_string(typeof(d["key"])))
	print(d["key"] is Array)
	print(d["key"][1])
	print(type_string(typeof(d["key"][1])))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
