extends RefCounted

class_name EmbeddingResponse

var _index: int = 0
var _emebdding: Array[float] = []
var _prompt_tokens: int = 0
var _total_tokens: int = 0

func index() -> int:
	return self._index

func embedding() -> Array[float]:
	return self._emebdding
	
func prompt_tokens() -> int:
	return self._prompt_tokens

func total_tokens() -> int:
	return self._total_tokens


func _init(index: int = 0, embedding: Array[float] = [], prompt_tokens: int = 0, total_tokens: int = 0):
	self._index = index
	self._emebdding = embedding
	self._prompt_tokens = prompt_tokens
	self._total_tokens = total_tokens

func _process_data(serialized_data: String) -> void:
	if serialized_data.is_empty():
		printerr("Serialized data is empty.")
		return 
	
	var dictionary = JSON.parse_string(serialized_data)
	
	self._index = dictionary["data"][0]["index"]
	self._embedding = dictionary["data"][0]["embedding"]
	self._prompt_tokens = dictionary["usage"]["prompt_tokens"]
	self._total_tokens = dictionary["usage"]["total_tokens"]
