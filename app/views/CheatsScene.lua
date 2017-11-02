-- 秘籍场景

local CheatsScene = class("CheatsScene", cc.load("mvc").ViewBase)
local audio = require('audio')

function CheatsScene:onCreate()
	-- 添加背景
	cc.Sprite:createWithSpriteFrame(display.newSpriteFrame('CheatsBackground.png'))
    :move(display.center)
    :addTo(self)

    -- 添加关闭按钮
    local closeMenu = self:createMenu(
    	'OffNormal.png', 
    	'OffSelected.png', 
    	cc.p(display.width - 164, display.height - 132),
    	function()
            audio.playButtonEffect()
	    	self:getApp():enterScene('MainScene')
	    end)
    closeMenu:setLocalZOrder(1)

    -- 添加秘籍精灵(重叠，通过switchMenu钮切换)
    local interfacePos = cc.p(display.cx, display.cy - 10)
    local interface1 = cc.Sprite:createWithSpriteFrame(
        display.newSpriteFrame('CheatsInterface1.png')
    )
	interface1:move(interfacePos):addTo(self):setVisible(true)
    local interface2 = cc.Sprite:createWithSpriteFrame(
        display.newSpriteFrame('CheatsInterface2.png')
    )
    interface2:move(interfacePos):addTo(self):setVisible(false)
    local interfaces = { interface1, interface2 }

    -- 添加切换按钮
    local index = 1 -- 当前的索引页
    local minIndex = 1 -- 最小索引页
    local maxIndex = #interfaces -- 最大页面数
    local switchMenu = self:createMenu(
    	'PageTurnNormal.png',
		'PageTurnSelected.png',
		cc.p(display.width - 55, display.height / 2 - 14),
		function()
            audio.playButtonEffect()
            -- 计算循环显示的索引
            index = index + 1
            if index > maxIndex then
                index = minIndex
            end

			for i, interface in ipairs( interfaces ) do
                interface:setVisible(i == index)
            end
		end
    )
end

return CheatsScene