extends RefCounted

class_name Configuration

# TODO remove the model and put it into the completion
# TODO add a static class that returns different configurations and put the values
# that are now in base template, there
var _model: String
var _api_key: String

var model: String:
	get:
		return self._model
		
var api_key: String:
	get:
		return self._api_key

func _init(model: String, api_key: String):
	self._model = model
	self._api_key = api_key
