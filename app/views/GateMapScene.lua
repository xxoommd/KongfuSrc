local GateMapScene = class("GateMapScene", cc.load("mvc").ViewBase)
local audio = require('audio')


function GateMapScene:onCreate()
	-- 添加背景
	cc.Sprite:createWithSpriteFrame(display.newSpriteFrame('GateMapBG.png'))
    :move(display.center)
    :addTo(self)

    self:createMenu('Gate_1.png', 'Gate_1.png', cc.p(display.cx, display.cy + 70), function()
    	self:getApp():enterScene('BattleScene')
    end)

    -- 添加关闭按钮
    local closePos = cc.p(display.width - 47, display.height - 44)
    self:createMenu('CloseNormal.png', 'CloseSelected.png', closePos, function()
    	audio.playButtonEffect()
    	self:getApp():enterScene('MainScene')
    end)

end



return GateMapScene