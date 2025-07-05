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
	
	var gpt_object: TemplateBase = $"../GotOpenAi".GetPreviewCompletion()\
	.with_log_probs(true)\
	.with_n_choices(2)\
	.with_max_completion_tokens(4)\
	.with_tool(toolA)\
	.with_tool(toolB)\
	.get_template()
	
	gpt_object.append_static_context("system", "You are a math teacher.")
	gpt_object.append_static_contexts([{"system": "You should help your students."}, {"system": "And do calcs step by step."}])
	gpt_object.append_message("user", 
	"How to calculate a diferential of a linear function?")
	
	await gpt_object.get_reply()
	
	print("DO ACTUAL REQUEST")
	# should fail
	#var gpt_fail_object = GotOpenAi.GetGptCompletion()
	var user_configuration = UserConfiguration.new(self.api_key)
	# for his solution
	# the user at the end will need to enter it in UI. 
	$"../GotOpenAi".user_configuration = user_configuration
	var _gpt_fail_object: TemplateBase = $"../GotOpenAi".GetGptCompletion()\
	.with_log_probs(true)\
	.with_n_choices(2)\
	.with_tool(toolA)\
	.with_tool(toolB)\
	.with_auto_tool_choice()\
	.get_template()
	
	var response: CompletionResponse = await _gpt_fail_object\
	.append_message("system", "You are a math teacher.")\
	.append_message("user", "How much is 2+2?")\
	.get_reply()
	
	print("Response:")
	
	var message: Message = response.choices()[0].message
	printt(message.get_dictionary_form(), "::::" + message.tool_calls[0].id)
	print(message)
	response = await _gpt_fail_object.append_message_with(message).append_tool_message(message.tool_calls[0].id, "4").get_reply()
	print(response.successful())
	print(response.choices())
	printt("RESULT", response.choices()[0].message.get_dictionary_form())
		
	
	
	print(response.successful())
	print(response.choices())
	print(response.choices().size())
	print(response.completion_tokens())
	print(response.completion_tokens_details())
	print(response.prompt_tokens())
	
	if not response.successful():
		return
	
	print("Usage of choices")
	var choice_0 = response.choices()[0]["message"]["content"]
	print(choice_0)
	
	print("Message 0")
	print(response.choices()[0].message.content)
	print(response.choices()[0].log_probs.content)
	
	print("Message 1")
	print(response.choices()[1].message.content)
	print(response.choices()[1].log_probs.content[0].logprob.token)
	print(response.choices()[1].log_probs.content[0].logprob.log)
	
	for msg in _gpt_fail_object.get_messages():
		print(msg.role, msg.content)
		
	for msg in _gpt_fail_object.get_context():
		print(msg.role, msg.content)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
