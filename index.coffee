###

  require("stratus-keyboard") "your-scope",
    "\n":        -> # select something...
    ".":         ->
    "Down":      ->
    "Control-s": -> # save a file...
    "Control-t": -> # open a tab...
    "otherwise": ->

###
_ = require 'underscore'


# Create or update a key binding scope.
# 
# scope - A string scope ("global" is also allowed).
# map   - A hash where the keys are key combos such has "C-s" or "Down".
# 
# Examples
# 
#   Keyboard "global",
#     "Control-s": -> alert "File saved"
#     "\n":        -> alert "You pressed enter"
#     "!":         -> alert "You pressed '!'"
#     "Alt-Control-Shift-d": -> alert "That was an alt-control-shift 'D'"
# 
# No return.
module.exports = Keyboard = (scope, map) ->
  isFunction = _.isFunction map
  # Update.
  if Keyboard.map[scope]
    if isFunction
      Keyboard.map[scope].otherwise = map
    else
      _.extend Keyboard.map[scope], map
  # New scope.
  else
    if isFunction
      Keyboard.map[scope] = {otherwise: map}
    else
      Keyboard.map[scope] = map
  return


# { scope name : { key : action } }
Keyboard.map = { global: {} }


Keyboard.modString = (event) ->
  s  = ""
  s += "Alt-"     if event.altKey
  s += "Control-" if event.ctrlKey
  s += "Shift-"   if event.shiftKey
  return s


# Get or set the current scope.
# 
# scope - If not passed, return the current scope. Otherwise, set it.
#         If `false`, set to "global" scope (optional).
# 
# Examples
# 
#   Keyboard.scope()
#   # => "global"
# 
#   Keyboard.scope "tree"
#   
#   Keyboard.scope()
#   # => "tree"
# 
#   Keyboard.scope false
#   
#   Keyboard.scope()
#   # => "global"
# 
# Return string if no argument is passed, otherwise don"t return.
Keyboard.scope = (scope) ->
  if _.isUndefined scope
    return @_scope
  else
    @_scope = scope || "global"


# Initialize scope to "global".
Keyboard.scope false


# Trigger the event corresponding with the given key combo in the current
# scope. If no action is assigned in the current scope, use the "global"
# scope.
# 
# key - A string key combo, such as "Control-Shift-n".
# 
# Returns the boolean value from the action. `false` means prevent default.
Keyboard.trigger = (key) ->
  scope   = @scope()
  action  = @map[scope][key]
  action ?= @map[scope]["otherwise"]
  if action
    v = action key
    action = null
    return false if !v
  
  if scope != "global"
    action  = @map["global"][key]
    action ?= @map["global"]["otherwise"]
  
  return if action then action?(key) else true


# Set a scope to the given input element whenever it gains focus, and
# set the focus back when the focus is lost.
# 
# $input - A jQuery input element.
# scope  - The scope to assign when focus is aquired.
# 
# Examples
# 
#   Keyboard.focus $("input"), "myinput"
# 
Keyboard.focus = ($input, scope) ->
  $input.on
    focus: =>
      #@prevScope = @scope()
      _.defer => @scope scope
      return
    # This screws up when blur is called after the new input's focus...
    blur: =>
      @scope false
      return


# TODO: there are a lot of gaps here...
Keyboard.keyMap =
  8: "Backspace"
  9:  "\t" # tab
  13: "\n" # enter
  16: "Shift"
  17: "Control"
  18: "Alt"
  20: "CapsLock"
  27: "Escape"
  32: " " # space
  33: "PageUp"
  34: "PageDown"
  35: "End"
  36: "Home"
  37: "Left"
  38: "Up"
  39: "Right"
  40: "Down"
  45: "Insert"
  46: "Delete"
  
  48: "0"
  49: "1"
  50: "2"
  51: "3"
  52: "4"
  53: "5"
  54: "6"
  55: "7"
  56: "8"
  57: "9"
  
  59: ";"
  
  65: "a"
  66: "b"
  67: "c"
  68: "d"
  69: "e"
  70: "f"
  71: "g"
  72: "h"
  73: "i"
  74: "j"
  75: "k"
  76: "l"
  77: "m"
  78: "n"
  79: "o"
  80: "p"
  81: "q"
  82: "r"
  83: "s"
  84: "t"
  85: "u"
  86: "v"
  87: "w"
  88: "x"
  89: "y"
  90: "z"
  
  # Num keypad
  96: "0"
  97: "1"
  98: "2"
  99: "3"
  100: "4"
  101: "5"
  102: "6"
  103: "7"
  104: "8"
  105: "9"
  106: "*"
  107: "+"
  109: "-"
  110: "."
  111: "/"
  
  186: ";"
  187: "="
  188: ","
  189: "-"
  190: "."
  191: "/"
  192: "`"
  
  219: "["
  220: "\\"
  221: "]"
  222: "'"
  
  "Shift-8":  "Backspace"
  "Shift-32": " "
  
  "Shift-48": ")"
  "Shift-49": "!"
  "Shift-50": "@"
  "Shift-51": "#"
  "Shift-52": "$"
  "Shift-53": "%"
  "Shift-54": "^"
  "Shift-55": "&"
  "Shift-56": "*"
  "Shift-57": "("
  
  "Shift-65": "A"
  "Shift-66": "B"
  "Shift-67": "C"
  "Shift-68": "D"
  "Shift-69": "E"
  "Shift-70": "F"
  "Shift-71": "G"
  "Shift-72": "H"
  "Shift-73": "I"
  "Shift-74": "J"
  "Shift-75": "K"
  "Shift-76": "L"
  "Shift-77": "M"
  "Shift-78": "N"
  "Shift-79": "O"
  "Shift-80": "P"
  "Shift-81": "Q"
  "Shift-82": "R"
  "Shift-83": "S"
  "Shift-84": "T"
  "Shift-85": "U"
  "Shift-86": "V"
  "Shift-87": "W"
  "Shift-88": "X"
  "Shift-89": "Y"
  "Shift-90": "Z"
  
  "Shift-186": ":"
  "Shift-187": "+"
  "Shift-188": "<"
  "Shift-189": "_"
  "Shift-190": ">"
  "Shift-191": "?"
  "Shift-192": "~"
  
  "Shift-219": "{"
  "Shift-220": "|"
  "Shift-221": "}"
  "Shift-222": '"'


return unless typeof(jQuery) != "undefined"
jQuery ($) ->
  $("body").on "keydown", (event) ->
    {which} = event
    mod     = Keyboard.modString(event)
    modKey  = Keyboard.keyMap[mod + which]
    baseKey = Keyboard.keyMap[which]
    key     = modKey || mod + baseKey
    
    # Toggle the modifier.
    if baseKey in ["Alt", "Control", "Shift"]
      return
    # Ignore cut/copy/paste and let the browser do its thing
    else if key in ["Control-x", "Control-c", "Control-v"]
      return
    else
      return Keyboard.trigger key


