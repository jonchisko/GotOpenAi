extends GutTest

var _property_builder: PropertyBuilder

func before_each():
	_property_builder = PropertyBuilder.new(
		"DefaultName", 
		PropertyTypes.Type.NullJson)

#func after_each():
	#gut.p("ran teardown", 2)
#
#func before_all():
	#gut.p("ran run setup", 2)
#
#func after_all():
	#gut.p("ran run teardown", 2)

func test_create_default_basic_property():
	# Arrange
	var property: Property = _property_builder.build()
	var nullJson: String = PropertyTypes.json_object_to_string(PropertyTypes.Type.NullJson)
	# Act
	var data: Dictionary = property.get_property_data()
	
	# Assert
	assert_true(data.has("type"), "Type is missing from data.")
	assert_eq(nullJson, data["type"], "Type should be 'NullJson'.")
	
func test_create_default_basic_property_with_name():
	# Arrange
	var property: Property = _property_builder.build()
	var nullJson: String = PropertyTypes.json_object_to_string(PropertyTypes.Type.NullJson)
	var with_name_of_property: bool = true
	
	# Act
	var data: Dictionary = property.get_property_data(with_name_of_property)
	
	# Assert
	assert_true(data.has("DefaultName"), "Name is missing from data.")
	
	assert_true(data["DefaultName"].has("type"), "Type is missing from data.")
	assert_eq(nullJson, data["DefaultName"]["type"], "Type should be 'NullJson'.")
