extends RefCounted

class_name PropertyBuilder

var _name: String = ""
var _type: PropertyTypes.Type = PropertyTypes.Type.ObjectJson
var _description: String = ""
var _enum_values: Array[String] = []
var _required: bool = false

func _init(name: String, type: PropertyTypes.Type):
	self._name = name
	self._type = type
	
func with_description(value: String):
	self._description = value

func with_enum_values(value: Array[String]):
	self._enum_values = value
	
func with_required(value: bool):
	self._required = value

func build() -> Property:
	return Property.new(self._name, self._type, self._description, self._enum_values, self._required)
