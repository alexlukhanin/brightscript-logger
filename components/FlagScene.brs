'*** Flagscene - is the place where logger code could be checked

'--------------------------------------
' @MARK: Init
'--------------------------------------
sub init()
	m.top.signalBeacon("AppLaunchComplete")

	print "Glory to Ukraine!"
	print "Glory to the heroes!"

	print "Press 'Home' key to exit"

	testLogger()
end sub

sub prepareVariables()
	m.invalidVar = invalid
	m.numberVar = 123
	m.stringVar = "string"
	m.booleanVar = true
	m.arrayVar = [1, 2, 3]
	m.objectVar = { "key1": "value1", "key2": "value2" }

	m.translationTest = [0, 200]
	m.backgroundUp = m.top.findNode("backgroundUp")
end sub

' -------------------------
' @MARK: Test Function
' -------------------------

sub testLogger()
	prepareVariables()

	'simple log messages
	logger().info("Test info message")
	logger().warning("Test warning message")
	logger().error("Test error message")
	logger().debug("Test debug message")

	'log messages with arguments
	logger().info("Test info message with arguments", {
		"m.invalidVar": m.invalidVar,
		"m.numberVar": m.numberVar,
		"m.stringVar": m.stringVar
	})

	logger().warning("Test warning message with arguments", {
		"m.booleanVar": m.booleanVar,
		"m.arrayVar": m.arrayVar,
		"m.objectVar": m.objectVar
	})

	logger().error("Test error message with arguments", {
		"m.translationTest": m.translationTest,
		"m.backgroundUp": m.backgroundUp
	})

	' this message should not be displayed because debug logging is disabled
	' it's useful to just change the value of enabled to hide/show debug messages
	logger().debug("Test debug message with arguments", {
		"m.invalidVar": m.invalidVar,
		"m.numberVar": m.numberVar,
		"m.stringVar": m.stringVar,
		"m.booleanVar": m.booleanVar,
		"m.arrayVar": m.arrayVar,
		"m.objectVar": m.objectVar,
		"m.translationTest": m.translationTest,
		"m.backgroundUp": m.backgroundUp
	}, false)

	' this message should be displayed because enabled is true
	logger().debug("Test debug message with arguments", {
		"m.invalidVar": m.invalidVar,
		"m.numberVar": m.numberVar,
		"m.stringVar": m.stringVar,
		"m.booleanVar": m.booleanVar,
		"m.arrayVar": m.arrayVar,
		"m.objectVar": m.objectVar,
		"m.translationTest": m.translationTest,
		"m.backgroundUp": m.backgroundUp
	}, true)



end sub