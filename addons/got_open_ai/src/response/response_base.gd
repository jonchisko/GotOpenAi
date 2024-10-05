extends RefCounted

class_name ResponseBase

var _data: Dictionary

# TODO just delete this

func _init(serialized_json: String = "") -> void:
	if not serialized_json.is_empty():
		self._data = JSON.parse_string(serialized_json)
	self._data = {}

func get_data_by_key(key: String) -> Object:
	if self._data.has(key):
		return self.data[key]
	printerr("No key found.")
	return null
