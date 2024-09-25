extends TemplateBase

class_name Template

var _configuration: Configuration

var _temperature: float
var _frequency_penalty: float
var _presence_penalty: float
var _log_probs: bool = false
var _max_completion_tokens: int
var _n_choices: int
var _tools: Array[Tool]
var _response_format: String
var _streaming: bool

func _init(configuration: Configuration, temperature: float, frequency_penalty: float,
presence_penalty: float, log_probs: bool, max_completion_tokens: int, n_choices: int,
tools: Array[Tool], response_format: String, streaming: bool):
	self._configuration = configuration
	self._temperature = temperature
	self._frequency_penalty = frequency_penalty
	self._presence_penalty = presence_penalty
	self._log_probs = log_probs
	self._max_completion_tokens = max_completion_tokens
	self._n_choices = n_choices
	self._tools = tools
	self._response_format = response_format
	self._streaming = streaming

# in this one just have a virtual that constructs and in base you have the http request buildup
func get_response() -> void:
	print(self._url)
	print(self._method)
	var headers = PackedStringArray([
		self._content_type,
		self._authorization_bearer.format({"api": self._configuration.api_key})])
	var msgs = self._static_context + self._message_data
	print(msgs)
	print(headers)
	print(JSON.stringify(self._message_data))
	#self.request(self._url, self._custom_headers, self._method, JSON.stringify(self._message_data))
#var _gpt_model: String = "gpt-4"
#var _message_data: Dictionary = {"model" : self._gpt_model, "messages" : []}

func construct_data():
	var data: Dictionary = {}
	
	
"""
curl https://api.openai.com/v1/chat/completions \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $OPENAI_API_KEY" \
-d '{
  "model": "gpt-4o",
  "messages": [
	{
	  "role": "user",
	  "content": "What'\''s the weather like in Boston today?"
	}
  ],
  "tools": [
	{
	  "type": "function",
	  "function": {
		"name": "get_current_weather",
		"description": "Get the current weather in a given location",
		"parameters": {
		  "type": "object",
		  "properties": {
			"location": {
			  "type": "string",
			  "description": "The city and state, e.g. San Francisco, CA"
			},
			"unit": {
			  "type": "string",
			  "enum": ["celsius", "fahrenheit"]
			}
		  },
		  "required": ["location"]
		}
	  }
	}
  ],
  "tool_choice": "auto"
}'

	"logprobs": true,
	"top_logprobs": 2

"""
