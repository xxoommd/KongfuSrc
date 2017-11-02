
local MainScene = class("MainScene", cc.load("mvc").ViewBase)
local audio = require('audio')

function MainScene:onCreate()
    -- 添加音乐音效

    audio.init()
    if audio.isMusicOn() and not audio.isMusicPlaying() then
        audio.playMusic('Sound/startBGM.mp3', true)
    end

    -- 添加背景
    cc.Sprite:createWithSpriteFrame(display.newSpriteFrame('MainMenuBackground.png'))
    :move(display.center)
    :addTo(self)
    
    -- 添加标题
    cc.Sprite:createWithSpriteFrame(display.newSpriteFrame("Title.png"))
    :move(display.cx - 222, display.cy + 186)
    :addTo(self)

    local challegePos = cc.p(display.cx - 240, display.cy - 250)
    local emgratedPos = cc.p(display.cx - 240, display.cy - 86)
    local photoGalleryPos = cc.p(display.width - 62, display.height - 73)
    local cheatsPos = cc.p(display.width - 62, display.height - 209)
    local settingPos = cc.p(display.width - 62, display.height - 346)
    local helpPos = cc.p(display.width - 62, display.height - 473)

    -- 添加挑战菜单

    self:createMenu("ChallengeNormal.png", "ChallengeSelected.png", challegePos, function()
        audio.playButtonEffect()
    end)

    -- 添加闯关菜单
    self:createMenu("EmigratedNormal.png", "EmigratedSelected.png", emgratedPos, function()
        audio.playButtonEffect()
        self:getApp():enterScene('GateMapScene')
    end)

    -- 添加图籍菜单
    self:createMenu("PhotoGalleryNormal.png", "PhotoGallerySelected.png", photoGalleryPos, function()
    	audio.playButtonEffect()
        self:getApp():enterScene('GalleryScene')
    end)

    -- 添加秘籍菜单
    self:createMenu("CheatsNormal.png", "CheatsSelected.png", cheatsPos, function()
    	audio.playButtonEffect()
        self:getApp():enterScene('CheatsScene')
    end)

    -- 添加设置菜单
    self:createMenu("SetNormal.png", "SetSelected.png", settingPos, function()
    	audio.playButtonEffect()
    	self:getApp():enterScene("SettingScene")
    end)

    -- 添加帮助菜单
    self:createMenu("HelpNormal.png", "HelpSelected.png", helpPos, function()
    	audio.playButtonEffect()
        self:getApp():enterScene('HelpScene')
    end)
end

return MainScene
