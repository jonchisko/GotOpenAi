extends HTTPRequest

class_name TemplateBase

const _url: String = "https://api.openai.com/v1/chat/completions"
const _content_type: String = "Content-Type: application/json"
const _authorization_bearer: String = "Authorization: Bearer {key}"
const _method: HTTPClient.Method = HTTPClient.METHOD_POST

const _role_key: String = "role"
const _content_key: String = "content"
const _model_key: String = "model"
const _message_key: String = "messages"

var _static_context: Array[Dictionary]
var _message_data: Array[Dictionary]

func get_response() -> void:
	pass

func append_static_context(role: String, content: String) -> TemplateBase:
	self._append_message(role, content, self._static_context)
	return self

func append_static_context_dictionary(role_content: Dictionary) -> TemplateBase:
	self._append_message_dictionary(role_content, self._static_context)
	return self

func append_static_contexts(static_contexts: Array[Dictionary]) -> TemplateBase:
	for static_context in static_contexts:
		self.append_static_context_dictionary(static_context)
	return self

func clear_static_context() -> TemplateBase:
	self._static_context.clear()
	return self 

func append_message(role: String, content: String) -> TemplateBase:
	self._append_message(role, content, self._message_data)
	return self
	
func append_message_dictionary(role_content: Dictionary) -> TemplateBase:
	self._append_message_dictionary(role_content, self._message_data)
	return self
	
func append_messages(messages: Array[Dictionary]) -> TemplateBase:
	for message in messages:
		self.append_message_dictionary(message)
	return self

func remove_newest_message() -> TemplateBase:
	self._message_data.pop_back()
	return self
	
func remove_oldest_message() -> TemplateBase:
	self._message_data.pop_front()
	return self
	
func clear_all_messages() -> TemplateBase:
	self._message_data.clear()
	return self

func show_messages() -> String:
	return JSON.stringify(self._message_data)

func _append_message(role: String, content: String, data: Array[Dictionary]) -> void:
	data.append({self._role_key: role, self._content_key: content})
	
func _append_message_dictionary(role_content: Dictionary, data: Array[Dictionary]) -> void:
	if not role_content.has(self._role_key) or not role_content.has(self._content_key):
			return
	data.append(role_content)
