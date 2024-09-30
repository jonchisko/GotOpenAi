extends OpenAiRequestBase

class_name OpenAiRequest


func request_data(url: String, headers: PackedStringArray, method: HTTPClient.Method, request_data: Dictionary) -> void:
	request(url, headers, method, JSON.stringify(request_data))
