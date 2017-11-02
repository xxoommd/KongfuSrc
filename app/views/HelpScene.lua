local HelpScene = class("HelpScene", cc.load("mvc").ViewBase)
local audio = require('audio')

function HelpScene:onCreate()
	-- 添加背景
	cc.Sprite:createWithSpriteFrame(display.newSpriteFrame('MainMenuBackground.png'))
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
end

return HelpScene