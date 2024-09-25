extends RefCounted

class_name Completion

var _configuration: Configuration

const _max_n_choices: int = 10

var _temperature: float = 1.0
var _frequency_penalty: float = 0.0
var _presence_penalty: float = 0.0
var _log_probs: bool = false
var _max_completion_tokens: int = -1 # not viable
var _n_choices: int = 1
var _tools: Array[Tool] = []
var _response_format: String = "" 
var _streaming: bool = false

func _init(configuration: Configuration):
	self._configuration = configuration

func with_temperature(value: float) -> void:
	self._temperature = clampf(value, 0.0, 2.0)

func with_frequency_penalty(value: float) -> void:
	self._frequency_penalty = clampf(value, -2.0, 2.0)

func with_presence_penalty(value: float) -> void:
	self._presence_penalty = clampf(value, -2.0, 2.0)
	
func with_log_probs(value: bool) -> void:
	self._log_probs = value
	
func with_max_completion_tokens(value: int) -> void:
	self._max_completion_tokens = value
	
func with_n_choices(value: int) -> void:
	self._n_choices = clampf(value, 1, _max_n_choices)
	
func with_tool(value: Tool) -> void:
	self._tools.append(value)

func with_tools(values: Array[Tool]) -> void:
	if values.size() < 1:
		return
	self._tools.append(values)

func with_response_format(value: String) -> void:
	if JSON.parse_string(value) != null:
		self._response_format = value

func with_streaming(value: bool) -> void:
	self._streaming = value

func get_template() -> TemplateBase: # here it could be possible to return either Template or StreamingTemplate -> think if interface needed
	return Template.new(self._configuration, self._temperature, self._frequency_penalty,
	self._presence_penalty, self._log_probs, self._max_completion_tokens, self._n_choices, 
	self._tools, self._response_format, self._streaming)
