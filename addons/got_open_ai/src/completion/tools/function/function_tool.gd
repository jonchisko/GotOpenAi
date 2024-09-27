extends Tool

class_name FunctionTool

const _property_key: String = "properties"
const _required_key: String = "required"

var _parameters: Dictionary = {"type": PropertyTypes.json_object_to_string(PropertyTypes.Type.ObjectJson)}
var _strict: bool = false 

func _init(name: String, description: String, parameters: Dictionary, strict: bool):
	super(ToolTypes.Type.Function, name, description)
	self._parameters = parameters
	self._strict = strict
	
func get_tool_data() -> Dictionary:
	var data: Dictionary = {}
	data["type"] = ToolTypes.json_object_to_string(self._type)
	data[ToolTypes.json_object_to_string(self._type)] = {}
	
	data[ToolTypes.json_object_to_string(self._type)]["name"] = self._name
	data[ToolTypes.json_object_to_string(self._type)]["strict"] = self._strict
	
	if not self._description.is_empty():
		data[ToolTypes.json_object_to_string(self._type)]["description"] = self._description
		
	if self._parameters.size() > 1:
		data[ToolTypes.json_object_to_string(self._type)]["parameters"] = self._parameters
		
	return data
