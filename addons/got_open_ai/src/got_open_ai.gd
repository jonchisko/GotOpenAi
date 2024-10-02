extends Node

class_name GotOpenAi

static var user_configuration: UserConfiguration

static func GetPreviewCompletion() -> Completion:
	var api_configuration: ApiConfiguration = ApiConfigurationFactory.get_completion_configuration(UserConfiguration.new("api_key"))
	return Completion.new(api_configuration, DisplayRequest.new(), MessageManager.new())
	
static func GetGptCompletion() -> Completion:
	if user_configuration == null:
		printerr("User configuration is null. Set user configuration before requesting GptCompletion object.")
	var api_configuration: ApiConfiguration = ApiConfigurationFactory.get_completion_configuration(user_configuration)
	return Completion.new(api_configuration, OpenAiRequest.new(), MessageManager.new())

func _ready() -> void:
	print("Start init node of GotOpenAi")
