extends RefCounted

class_name TemplateBase

const _messages_key: String = "messages"

var _configuration: ApiConfiguration
var _open_ai_request: OpenAiRequestBase
var _message_manager: MessageManager

func _init(configuration: ApiConfiguration, open_ai_request: OpenAiRequestBase, message_manager: MessageManager):
	self._configuration = configuration
	self._open_ai_request = open_ai_request
	self._message_manager = message_manager

func construct_data() -> Dictionary:
	return {}

func get_reply() -> void:

	
	var data: Dictionary = {}
	
	data[self._messages_key] = self._message_manager.get_combined_message_data()
	
	var template_specific_data = self.construct_data()
	data.merge(template_specific_data)
	
	var serialized_data: String = self._open_ai_request.request_data(self._configuration.url(), self._configuration.get_content_authorization_header(), self._configuration.method(), data)
	var response: CompletionResponse = _process_response(serialized_data)
	#self._open_ai_request.request_completed.connect(_on_request_completed)
	
	#print(request_data)
	#self.request(self._url, headers, self._method, request_data)

func append_static_context(role: String, content: String) -> TemplateBase:
	self._message_manager.append_static_context(role, content)
	return self

func append_static_context_dictionary(role_content: Dictionary) -> TemplateBase:
	self._message_manager.append_static_context_dictionary(role_content)
	return self

func append_static_contexts(static_contexts: Array[Dictionary]) -> TemplateBase:
	self._message_manager.append_static_contexts(static_contexts)
	return self

func clear_static_context() -> TemplateBase:
	self._message_manager.clear_static_context()
	return self 

func prepend_message(role: String, content: String) -> TemplateBase:
	self._message_manager.prepend_message(role, content)
	return self
	
func prepend_message_dictionary(role_content: Dictionary) -> TemplateBase:
	self._message_manager.prepend_message_dictionary(role_content)
	return self
	
func prepend_messages(messages: Array[Dictionary]) -> TemplateBase:
	self._message_manager.prepend_messages(messages)
	return self

func append_message(role: String, content: String) -> TemplateBase:
	self._message_manager.append_message(role, content)
	return self
	
func append_message_dictionary(role_content: Dictionary) -> TemplateBase:
	self._message_manager.append_message_dictionary(role_content)
	return self
	
func append_messages(messages: Array[Dictionary]) -> TemplateBase:
	self._message_manager.append_messages(messages)
	return self

func remove_newest_message() -> TemplateBase:
	self._message_manager.remove_newest_message()
	return self
	
func remove_oldest_message() -> TemplateBase:
	self._message_manager.remove_oldest_message()
	return self
	
func clear_all_messages() -> TemplateBase:
	self._message_manager.clear_all_messages()
	return self

func show_messages() -> String:
	return self._message_manager.show_messages()
	
func _process_response(serialized_data: String) -> CompletionResponse:
	if serialized_data.is_empty():
		print("Serialized data is empty.")
		return null
	
	var dictionary = JSON.parse_string(serialized_data)
	
	var choices = dictionary["choices"]
	var prompt_tokens = dictionary["usage"]["prompt_tokens"]
	var completion_tokens = dictionary["usage"]["completion_tokens"]
	var total_tokens = dictionary["usage"]["total_tokens"]
	var completion_tokens_details = dictionary["usage"]["completion_tokens_details"]
	
	return CompletionResponse.new(choices, prompt_tokens, completion_tokens, total_tokens, completion_tokens_details)
