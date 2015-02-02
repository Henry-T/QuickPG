
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

    local ButtonClass = class("ButtonClass", function()
        return display.newNode()
    end)

    function ButtonClass:ButtonClassFunc()
    end

    local MyButtonClass = class("MyButtonClass", ButtonClass)

    function MyButtonClass:MyButtonClassFunc()
    end

    local button = ButtonClass.new()
    local myButton = MyButtonClass.new()

    print("\n\n")
    print("type of button:", type(button))
    print("tolua.type of button:", tolua.type(button))
    print("button is CCNode?", iskindof(button, "CCNode"))
    print("button is Button?", iskindof(button, "ButtonClass"))
    print("button is MyButton?", iskindof(button, "MyButtonClass"))

    print("\n\n")
    print("type of myButton:", type(myButton))
    print("tolua.type of myButton:", tolua.type(myButton))
    print("myButton is CCNode?", iskindof(myButton, "CCNode"))
    print("myButton is Button?", iskindof(myButton, "ButtonClass"))
    print("myButton is MyButton?", iskindof(myButton, "MyButtonClass"))
    print("\n\n")

    -- dump(tolua.getpeer(myButton))
end

function MainScene:onEnter()

end

function MainScene:onExit()
end

return MainScene
