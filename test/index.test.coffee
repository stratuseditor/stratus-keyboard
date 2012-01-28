should   = require 'should'
keyboard = require '../'

describe "keyboard", ->
  describe "()", ->
    describe "a new scope", ->
      keyboard "cheese", {"c": (-> 1)}
      it "creates the scope", ->
        keyboard.map.cheese.should.be
        keyboard.map.cheese.c.should.be.a "function"
      
    describe "an existing scope", ->
      keyboard "food", {"c": (-> 1)}
      keyboard "food", {"c": (-> 2), "b": (-> 3)}
      it "extends the scope", ->
        keyboard.map.food.c().should.eql 2
        keyboard.map.food.b().should.eql 3
    
    describe "pass a function", ->
      it "sets the `otherwise` property", ->
        keyboard "pickles", ((k) -> 2)
        keyboard.map.pickles.otherwise().should.eql 2
      
      it "sets the `otherwise` property", ->
        keyboard "carrots", {a: (-> 3)}
        keyboard "carrots", ((k) -> 2)
        keyboard.map.carrots.otherwise().should.eql 2
        keyboard.map.carrots.a().should.eql 3
  
  
  describe ".scope", ->
    describe "without passing a scope", ->
      it "sets the scope", ->
        keyboard.scope "freeze"
        keyboard.scope().should.eql "freeze"
    
    describe "passing true", ->
      it "sets the scope to global", ->
        keyboard.scope false
        keyboard.scope().should.eql "global"
    
    describe "passing a scope", ->
      it "sets the scope", ->
        keyboard.scope "freeze"
        keyboard.scope().should.eql "freeze"
  
  
  describe ".modString", ->
    describe "only Control", ->
      it "is the correct string", ->
        keyboard.modString({ctrlKey: true}).should.eql "Control-"
    
    describe "only Alt", ->
      it "is the correct string", ->
        keyboard.modString({altKey: true}).should.eql "Alt-"
    
    describe "only Shift", ->
      it "is the correct string", ->
        keyboard.modString({shiftKey: true}).should.eql "Shift-"
    
    describe "Control and Shift", ->
      it "is alphabetical", ->
        keyboard.modString({
          ctrlKey:  true
          shiftKey: true
        }).should.eql "Control-Shift-"
    
    describe "Alt, Control, and Shift", ->
      it "is alphabetical", ->
        keyboard.modString({
          ctrlKey:  true
          shiftKey: true
          altKey:   true
        }).should.eql "Alt-Control-Shift-"
  
  
  describe ".keyMap", ->
    it "is an object", ->
      keyboard.keyMap.should.be.a "object"
    
    describe "enter", ->
      it "is a '\\n'", ->
        keyboard.keyMap[13].should.eql "\n"
