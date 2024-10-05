extends RefCounted

class_name Embedding


var _configuration: ApiConfiguration
var _open_ai_request: OpenAiRequestBase

var _model: String = "gpt-3"
var _encoding_format: String = "float"

func _init(configuration: ApiConfiguration, open_ai_request: OpenAiRequestBase, model: String, encoding_format: String):
	self._configuration = configuration
	self._open_ai_request = open_ai_request
	self._model = model
	self._encoding_format = encoding_format

func get_embedding(text: String) -> EmbeddingResponse:
	var response: String = self._open_ai_request.request_data(
		self._configuration.url(),
		self._configuration.get_content_authorization_header(), 
		self._configuration.method(), 
		self._create_request_data(text))
		
	var response_data = _process_data(response)
	
	return response_data
	
func _create_request_data(text: String) -> Dictionary:
	var data: Dictionary = {}
	data["model"] = self._model
	data["encoding_format"] = self._encoding_format
	data["input"] = text
	
	return data
	
func _process_data(serialized_data: String) -> EmbeddingResponse:
	if serialized_data.is_empty():
		print("Serialized data is empty.")
		return 
	
	var dictionary = JSON.parse_string(serialized_data)
	
	var index = dictionary["data"][0]["index"]
	var embedding = dictionary["data"][0]["embedding"]
	var prompt_tokens = dictionary["usage"]["prompt_tokens"]
	var total_tokens = dictionary["usage"]["total_tokens"]
	
	return EmbeddingResponse.new(index, embedding, prompt_tokens, total_tokens)
