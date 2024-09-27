extends RefCounted

class_name FunctionToolBuilder

const _property_key: String = "properties"
const _required_key: String = "required"

var _name: String = ""
var _description: String = ""
var _parameters: Dictionary = {"type": PropertyTypes.json_object_to_string(PropertyTypes.Type.ObjectJson)}
var _strict: bool = false 

static func new(name: String) -> FunctionToolBuilder:
	return FunctionToolBuilder.new(name)

func _init(name: String):
	self._name = name
	
func with_description(value: String) -> FunctionToolBuilder:
	self._description = value
	return self
	
func with_property(value: Property) -> FunctionToolBuilder:
	if not self._parameters.has(self._property_key):
		self._parameters[self._property_key] = {}
	
	if value.required:
		if not self._parameters.has(self._required_key):
			self._parameters[self._required_key] = []
		self._parameters[self._required_key].append(value.name)
	
	self._parameters[self._property_key][value.name] = value.get_property_data()
	
	return self
	
func with_properties(values: Array[Property]) -> FunctionToolBuilder:
	for value in values:
		self.with_property(value)
		
	return self
	
func with_strict() -> FunctionToolBuilder:
	self._strict = true
	return self
	
func build() -> FunctionTool:
	return FunctionTool.new(self._name, self._description, self._parameters, self._strict)
