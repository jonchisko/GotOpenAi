extends RefCounted

class_name Message

var role: String
var content: String
var refusal: String
var tool_id: String
var tool_calls: Array[ToolCall]


func _init(role: String, content: String, refusal: String, tool_id: String, tool_calls: Array[ToolCall]):
	self.role = role
	self.content = content
	self.refusal = refusal
	self.tool_id = tool_id
	self.tool_calls = tool_calls

func get_dictionary_form() -> Dictionary:
	var result = {"role": self.role}
	
	if not self.content.is_empty():
		result["content"] = self.content
		
	if not self.refusal.is_empty():
		result["refusal"] = self.refusal
		
	if not self.tool_id.is_empty():
		result["tool_id"] = self.tool_id
		
	if not self.tool_calls.is_empty():
		result["tool_calls"] = JSON.stringify(self.tool_calls)
		
	return result
