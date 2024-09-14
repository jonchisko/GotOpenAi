extends HTTPRequest

class_name Template

var _configuration: Configuration

var _temperature: float = 0.0
var _streaming: bool = false
var _static_context: String = ""

func _init(configuration: Configuration, temperature: float, streaming: bool, static_contex: String):
	self._configuration = configuration
	self._temperature = temperature
	self._streaming = streaming
	self._static_context = static_contex
	
