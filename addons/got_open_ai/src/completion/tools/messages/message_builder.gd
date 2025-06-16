extends RefCounted

class_name MessageBuilder

var _role: String = ""
var _content: String = ""
var _refusal: String = ""
var _tool_id: String = ""
var _tool_calls: Array[ToolCall] = []


func _init(role: String) -> void:
	self._role = role
	
func with_content(content: String) -> MessageBuilder:
	self._content = content
	return self
	
func with_refusal(refusal: String) -> MessageBuilder:
	self._refusal = refusal
	return self
	
func with_tool_id(tool_id: String) -> MessageBuilder:
	self._tool_id = tool_id
	return self
	
func with_tool_calls(tool_calls: Array[ToolCall]) -> MessageBuilder:
	self._tool_calls = tool_calls
	return self

func build() -> Message:
	return Message.new(self._role, self._content, self._refusal, self._tool_id, self._tool_calls)

func build_from_dict(data: Dictionary) -> Message:
	self.role = data["role"]
	self.content = self._process_optional(data, "content")
	self.refusal = self._process_optional(data, "refusal")
	self.tool_id = self._process_optional(data, "tool_id")
	self.tool_calls = self._process_tool_calls(data)
	
	return Message.new(self._role, self._content, self._refusal, self._tool_id, self._tool_calls)
	
func _process_optional(data: Dictionary, key: String) -> String:
	if not data.has(key) or data[key] == null:
		return ""
	return data[key]
	
func _process_tool_calls(data: Dictionary) -> Array[ToolCall]:
	var tools: Array[ToolCall] = []
	
	if not data.has("tool_calls") or data["tool_calls"] == null:
		return tools
	
	for tool in data["tool_calls"]:
		tools.push_back(ToolCall.new(tool))
	
	return tools
