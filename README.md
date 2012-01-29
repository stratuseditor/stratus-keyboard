# Stratus:Keyboard

[![Build Status](https://secure.travis-ci.org/stratuseditor/stratus-keyboard.png)](http://travis-ci.org/stratuseditor/stratus-keyboard)

[Browserify](https://github.com/substack/node-browserify) module for scoped
keybindings, used by [Stratus Editor](http://stratuseditor.com/).

# Usage

    keyboard  = require "stratus-keyboard"
    
    # Configure the scope.
    keyboard "your-scope",
      "\n":        -> # select something...
      ".":         ->
      "Down":      ->
      "Control-s": -> # save a file...
      "Control-t": -> # open a tab...
      "otherwise": (key) ->
    
    # Set the scope.
    keyboard.scope "your-scope"
    
    # Get the current scope.
    keyboard.scope()
    # => "your-scope"

# License
See LICENSE.

