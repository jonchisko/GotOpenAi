extends HTTPRequest # TODO HTTP CLIENT CLASS NOT HTTP REQUEST

class_name OpenAiRequestBase


const _url: String = "https://api.openai.com/v1/chat/completions"
const _content_type: String = "Content-Type: application/json"
const _authorization_bearer: String = "Authorization: Bearer {key}"
const _method: HTTPClient.Method = HTTPClient.METHOD_POST


func request_data(url: String, headers: PackedStringArray, method: HTTPClient.Method, request_data: Dictionary) -> void:
	pass
