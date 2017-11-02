local SettingScene = class("SettingScene", cc.load("mvc").ViewBase)
local audio = require('audio')

function SettingScene:onCreate()
	-- 添加背景
    cc.Sprite:createWithSpriteFrame(display.newSpriteFrame("BGPicSet.png"))
    :move(display.center)
    :addTo(self)

    -- 添加关闭按钮
    local closePos = cc.p(display.width - 150, display.height - 100)
    self:createMenu("closeSetNormal.png", 
    	"closeSetSelected.png", 
    	closePos, 
    	function()
            audio.playButtonEffect()
    		self:getApp():enterScene("MainScene")
    	end)

    local saveBtn = self:createMenu(
        'SaveSettings.png',
        'SaveSettings.png',
        cc.p(display.cx + 40, display.cy - 190),
        function()
            audio.playButtonEffect()
            print('save...')
        end
    )

    local musicOn = audio.isMusicOn()
    local effectOn = audio.isEffectOn()

    -- 音乐和音效的开关
    self:createCheckBox('unchecked.png', 'Hook.png', cc.p(318, 457), function(ref, type)
        audio.playButtonEffect()
        
        if type == ccui.CheckBoxEventType.selected then
            audio.setMusicOn(true)
        elseif type == ccui.CheckBoxEventType.unselected then
            audio.setMusicOn(false)
        end
    end):setSelected(musicOn)

    self:createCheckBox('unchecked.png', 'Hook.png', cc.p(318, 357), function(ref, type)
        audio.playButtonEffect()

        if type == ccui.CheckBoxEventType.selected then
            audio.setEffectOn(true)
        elseif type == ccui.CheckBoxEventType.unselected then
            audio.setEffectOn(false)
        end
    end):setSelected(effectOn)

    -- 音乐和音效的进度条
    self:createSlider('bgBar.png', 'progressBar.png', 'ThumbBtn.png', cc.p(760, 457), function(ref, type)
        if type == ccui.SliderEventType.percentChanged then
            local volume = ref:getPercent()
            audio.setMusicVolume(volume)
        end
    end):setPercent(audio.getMusicVolume())

    self:createSlider('bgBar.png', 'progressBar.png', 'ThumbBtn.png', cc.p(760, 357), function(ref, type)
        if type == ccui.SliderEventType.percentChanged then
            local volume = ref:getPercent()
            audio.setEffectVolume(volume)
        end
    end):setPercent(audio.getEffectVolume())
end

function SettingScene:createCheckBox(bg, selected, pos, callback)
    local switch = ccui.CheckBox:create(bg, bg, selected, bg, bg, ccui.TextureResType.plistType)
    switch:setPosition(pos)
    switch:setEnabled(true)
    switch:addEventListener(callback)
    self:add(switch)
    return switch
end

function SettingScene:createSlider(bg, progress, ball, pos, callback)
    local slider = ccui.Slider:create()
    slider:loadBarTexture(bg, ccui.TextureResType.plistType)
    slider:loadProgressBarTexture(progress, ccui.TextureResType.plistType)
    slider:loadSlidBallTextures(ball, ball, ball, ccui.TextureResType.plistType)
    slider:setPosition(pos)
    slider:addTo(self)
    slider:addEventListener(callback)
    return slider
end

return SettingScene