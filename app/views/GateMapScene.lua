local GateMapScene = class("GateMapScene", cc.load("mvc").ViewBase)
local audio = require('audio')

local function createSelector()
	local selector = display.newLayer(cc.c4b(0, 255, 0, 0.3))
	selector:setIgnoreAnchorPointForPosition(false)

	local director = cc.Director:getInstance()
	local index = 0
	local lastIndex = 0
	local selectedItem = nil


	selector:setContentSize(cc.size(display.width, display.height * 0.6))
	selector:setAnchorPoint(cc.p(0.5, 0.5))

	-- 添加触摸功能(滑动效果)
	local function onTouchBegan(touch, event)
		print( 'touch began' )
	end

	local function onTouchMoved(touch, event)
		print( 'touch move' )
	end

	local function onTouchEnded(touch, event)
		print( 'touch ended' )
	end

	local listener = cc.EventListenerTouchOneByOne:create()
	listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
	listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
	director:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, selector)

	return selector
end

function GateMapScene:onCreate()
	-- 添加背景
	cc.Sprite:createWithSpriteFrame(display.newSpriteFrame('GateMapBG.png'))
    :move(display.center)
    :addTo(self)

    -- 添加关闭按钮
    local closePos = cc.p(display.width - 47, display.height - 44)
    self:createMenu('CloseNormal.png', 'CloseSelected.png', closePos, function()
    	audio.playButtonEffect()
    	self:getApp():enterScene('MainScene')
    end)

    -- 添加选关面板
    local selector = createSelector()
    selector:move(display.cx, display.cy + 74)
    self:addChild(selector)
end


return GateMapScene