extends RefCounted

class_name Completion

var _configuration: Configuration

var _temperature: float = 1.0
var _frequency_penalty: float = 0.0
var _presence_penalty: float = 0.0
var _log_probs: bool = false
var _max_completion_tokens: int = -1 # not viable
var _n_choices: int = 1
var _response_format: String = "" 
var _streaming: bool = false
var _static_context: String = ""

func _init(configuration: Configuration):
	self._configuration = configuration

func with_temperature(value: float) -> void:
	self._temperature = clampf(value, 0.0, 2.0)

func with_frequency_penalty(value: float) -> void:
	self._frequency_penalty = clampf(value, -2.0, 2.0)

func with_presence_penalty(value: float) -> void:
	self._frequency_penalty = clampf(value, -2.0, 2.0)

func with_streaming(value: bool) -> void:
	self._streaming = value
	
func with_static_context(value: String) -> void:
	self._static_context = value



func get_template() -> TemplateBase: # here it could be possible to return either Template or StreamingTemplate -> think if interface needed
	return Template.new(self._configuration, self._temperature, self._streaming, self._static_context)
