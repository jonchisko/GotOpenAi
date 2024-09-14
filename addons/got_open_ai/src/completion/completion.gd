extends RefCounted

class_name Completion

var _configuration: Configuration

var _temperature: float = 0.0
var _streaming: bool = false
var _static_context: String = ""

func _init(configuration: Configuration):
	self._configuration = configuration

func with_temperature(value: float) -> void:
	self._temperature = value

func with_streaming(value: bool) -> void:
	self._streaming = value
	
func with_static_context(value: String) -> void:
	self._static_context = value

func get_template() -> Template: # here it could be possible to return either Template or StreamingTemplate -> think if interface needed
	return Template.new(self._configuration, self._temperature, self._streaming, self._static_context)
