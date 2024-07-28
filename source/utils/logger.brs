' 2024 Oleksandr Lukhanin alex.lukhanin@hotmail.com

'Brightscript Logger service for logging messages to the console with log level


'   logger().error() : case when an error occurs
'   logger().warning() : case when a warning occurs
'   logger().info() : case when an information message occurs
'   logger().debug() : case when a debug message occurs


function logger()
	return {

		"top": m.top

		' -------------------------
		' @MARK: public methods
		' -------------------------

		' -------------------------
		' @function error
		' @desc - Log an error message
		' @params {string} - msg - message
		' @params {object} - args - arguments
		' @returns {void}
		' -------------------------
		"error": sub(msg as string, args = {} as object)
			m._handleLogLevel("ERROR", msg, args)
		end sub

		' -------------------------
		' @function warning
		' @desc - Log a warning message
		' @params {string} - msg - message
		' @params {object} - args - arguments
		' @returns {void}
		' -------------------------
		"warning": sub(msg as string, args = {} as object)
			m._handleLogLevel("WARNING", msg, args)
		end sub

		' -------------------------
		' @function info
		' @desc - Log an info message
		' @params {string} - msg - message
		' @params {object} - args - arguments
		' @returns {void}
		' -------------------------
		"info": sub(msg as string, args = {} as object)
			m._handleLogLevel("INFO", msg, args)
		end sub

		' -------------------------
		' @function debug
		' @desc - Log a debug message
		' @params {string} - msg - message
		' @params {object} - args - arguments
		' @params {boolean} - enabled - enable/disable debug logging
		' @returns {void}
		' -------------------------
		"debug": sub(msg as string, args = {} as object, enabled = true as boolean)
			if not enabled then return
			m._handleLogLevel("DEBUG", msg, args)
		end sub

		' -------------------------
		' @MARK: private methods
		' -------------------------

		'-------------------------
		' @function _handleLogLevel
		' @desc - Handle log level - PRIVATE - DO NOT USE outside of the logger
		' @params {string} - logLevel - log level
		' @params {string} - msg - message
		' @params {object} - args - arguments
		' @returns {void}
		'-------------------------
		"_handleLogLevel": sub(logLevel as string, msg, args)
			m._printLogMessage(logLevel, msg)
			if isAAHasKeys(args)
				if args.Count() = 1
					m._printArgument(args)
				else
					m._printArguments(args)
				end if
			end if
			print " "
		end sub

		'-------------------------
		' @function _printLogMessage
		' @desc - Print log message - PRIVATE - DO NOT USE outside of the logger
		' @params {string} - logLevel - log level
		' @params {string} - msg - message
		' @returns {void}
		'-------------------------
		"_printLogMessage": sub (logLevel as string, msg as string)
			if isValid(m.top)
				componentId = m.top.subType()
			else
				componentId = " ~ "
			end if

			enhance = m._logEnhance(logLevel)
			print enhance.prefix;
			print logLevel; " *** "; componentId; " *** "; msg;
			print enhance.suffix;
		end sub

		'-------------------------
		' @function _logEnhance
		' @desc - Enhance log message, handles prefixes and suffixes for log messages
		' 		- PRIVATE - DO NOT USE outside of the logger
		' @params {string} - logLevel - log level
		' @returns {object} - prefix and suffix
		'-------------------------
		"_logEnhance": function(logLevel as string) as object
			prefixes = {
				"DEBUG": "##### ***  ",
				"ERROR": ">> ",
				"INFO": ":: ",
				"WARNING": ":: "
			}
			prefix = prefixes[logLevel]
			if not isNotEmptyString(prefix)
				prefix = ""
			end if

			return { prefix: prefix, suffix: "" }
		end function

		'-------------------------
		' @function _printArgument
		' @desc - Print argument - when it's only one!!! - PRIVATE - DO NOT USE outside of the logger
		' @params {object} - args - arguments
		' @returns {void}
		'-------------------------
		"_printArgument": sub(args)
			for each item in args.Items()
				print " | " ; item.key ; " = " ; item.value ; " "
			end for
		end sub

		'-------------------------
		' @function _printArguments
		' @desc - Print arguments - PRIVATE - DO NOT USE outside of the logger
		' @params {object} - args - arguments, when there are more than one
		' @returns {void}
		'-------------------------
		"_printArguments": sub(args = {} as object)
			print ""
			for each item in args.Items()
				print "---> " ; item.key ; " = " ; item.value ; " "
			end for
			print "================================================== "
		end sub
	}
end function

' -------------------------
' @MARK: Helper methods/functions
' -------------------------

' -------------------------
' @function isValid
' @desc - Check if the value is valid
' @params {dynamic} - value
' @returns {boolean} - true if the value is valid, otherwise - false
' -------------------------
function isValid(value as dynamic) as boolean
	return Type(value) <> "<uninitialized>" and value <> invalid
end function

' -------------------------
' @function isNotEmptyString
' @desc - Check if the value is a non-empty string
' @params {dynamic} - value
' @returns {boolean} - true if the value is a non-empty string, otherwise - false
' -------------------------
function isNotEmptyString(value as dynamic) as boolean
	return isString(value) and Len(value) > 0
end function

' -------------------------
' @function isString
' @desc - Check if the value is a string
' @params {dynamic} - value
' @returns {boolean} - true if the value is a string, otherwise - false
' -------------------------
function isString(value as dynamic) as boolean
	return isValid(value) and GetInterface(value, "ifString") <> invalid
end function

' -------------------------
' @function isAA
' @desc - Check if the value is an associative array
' @params {dynamic} - value
' @returns {boolean} - true if the value is an associative array, otherwise - false
' -------------------------
function isAA(value as dynamic) as boolean
	return isValid(value) and Type(value) = "roAssociativeArray"
end function

' -------------------------
' @function isAAHasKeys
' @desc - Check if the associative array has keys
' @params {dynamic} - value
' @returns {boolean} - true if the associative array has keys, otherwise - false
' -------------------------
function isAAHasKeys(value as dynamic) as boolean
	return isAA(value) and (value.DoesExist("count") or value.Count() > 0)
end function