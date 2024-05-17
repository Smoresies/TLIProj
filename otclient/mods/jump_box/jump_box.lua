jumpboxButton = nil
jumpboxWindow = nil
-- Meant to get reference to created button in otui script
jumpPrompt = nil
-- global button position for movement/reset
buttonPosition = nil
-- global window pos to check jump button scrolling position
windowPos = nil

-- for random jumping
math.randomseed(os.time())

function init()
	-- Creates the actual module reference in top right of UI
	jumpboxButton = modules.client_topmenu.addRightToggleButton('jumpboxButton', tr('Jump Box'), '/jump_box/jump_box/jump_box', closing)
	jumpboxButton:setOn(false)
	
	jumpboxWindow = g_ui.displayUI('jump_box')
	jumpboxWindow:setVisible(false)

	--get help values
	allTabs = jumpboxWindow:recursiveGetChildById('allTabs')
	allTabs:setContentWidget(jumpboxWindow:getChildById('optionsTabContent'))
	
	jumpPrompt = g_ui.createWidget('Button')
	jumpPrompt:setOn(true)
	jumpPrompt:setVisible(true)
	jumpPrompt:setSize({width = 50, height = 25})
	jumpPrompt:setText("Jump!")
	
	jumpboxWindow:addChild(jumpPrompt)
	buttonPosReset()
	
	jumpPrompt.onClick = function()
	buttonPosReset()
	end
	
	-- ensure after init we start the jumping
	jump()
end


function terminate()
  jumpboxButton:destroy()
  jumpboxWindow:destroy()
end

function moveButton()
	buttonPosition = jumpPrompt:getPosition()
	buttonPosition.x = buttonPosition.x - 5
	jumpPrompt:setPosition(buttonPosition)
	posPrint()
end


function closing()
	if jumpboxButton:isOn() then
		jumpboxWindow:setVisible(false)
		jumpboxButton:setOn(false)
	else
		jumpboxWindow:setVisible(true)
		jumpboxButton:setOn(true)
	end
end

function buttonPosReset()
	windowPos = jumpboxWindow:getPosition()
	windowPos.x = windowPos.x + 200
	windowPos.y = windowPos.y + math.random(10, 200)
	jumpPrompt:setPosition(windowPos)
end

-- semi-recursive, sets an event to call itself after 100 milliseconds.
-- handles overall button moving requirements (moving, checking pos, resetting)
function jump()
	moveButton()
	
	if buttonPosition.x <= windowPos.x -200 then
		buttonPosReset()
	end
	
	-- unsure if scheduleEvent works alone, so just creating function.
	-- calls back after 100 milli
	scheduleEvent(function() jump() end, 100)
end

function posPrint()
	print("Window: " .. windowPos.x .. " " .. windowPos.y)
	print("Button: " .. buttonPosition.x .. " " .. buttonPosition.y)
end