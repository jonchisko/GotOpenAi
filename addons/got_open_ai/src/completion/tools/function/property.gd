extends RefCounted

class_name Property

var _name: String
var _type: PropertyTypes.Type
var _description: String
var _enum_values: Array[String]
var _required: bool

var name: String:
	get:
		return self._name
		
var required: bool:
	get:
		return self._required

func _init(name: String, type: PropertyTypes.Type, description: String, _enum_values: Array[String], required: bool):
	self._name = name
	self._type = type
	self._description = description
	self._enum_values = _enum_values
	self._required = required

func get_property_data(with_name: bool = false) -> Dictionary:
	if with_name:
		return self._construct_dictionary_representation()
	return self._construct_dictionary_representation()[self._name]

func _to_string():
	return JSON.stringify(self._construct_dictionary_representation())
	
func _construct_dictionary_representation() -> Dictionary:
	var data: Dictionary = {}
	
	data[self._name] = {}
	data[self._name]["type"] = PropertyTypes.json_object_to_string(self._type)
	
	if not self._description.is_empty():
		data[self._name]["description"] = self._description
	if not self._enum_values.is_empty():
		data[self._name]["enum"] = self._enum_values

	return data
