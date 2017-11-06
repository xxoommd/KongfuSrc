local BattleScene = class("BattleScene", cc.load("mvc").ViewBase)
local audio = require('audio')
local hero = require('app.models.hero')

local ZERO_POINT = cc.p(0, 0)

function BattleScene:onCreate()
    -- 添加背景
    self:addBackground()

    -- 添加控制
    self:addControllers()

    -- 添加英雄
    self:addHero()

    -- 帧刷新
    -- self:scheduleUpdateWithPriorityLua(self.update, 0)
end

function BattleScene:createMap(name)
    return cc.Sprite:createWithSpriteFrame(display.newSpriteFrame(name))
end

function BattleScene:addBackground()
    local closeMenu = self:createMenu(
        'OffNormal.png', 
        'OffSelected.png', 
        cc.p(display.width - 43.5, display.height - 42),
        function()
            audio.playButtonEffect()
            self:getApp():enterScene('MainScene')
        end)
    closeMenu:setLocalZOrder(1)

    cc.Sprite:createWithSpriteFrame(display.newSpriteFrame('bgmap1.png'))
    :move(display.center)
    :addTo(self)

    local map1 = self:createMap('MapMiddle1.png')
    local map2 = self:createMap('MapGround1.png')
    local map3 = self:createMap('MapBefore1.png')

    map1:setAnchorPoint(ZERO_POINT)
    map1:setTag(11)
    map2:setAnchorPoint(ZERO_POINT)
    map3:setAnchorPoint(ZERO_POINT)

    local parallax = cc.ParallaxNode:create()
    parallax:addChild(map1, 1, cc.p(1.18, 0), cc.p(0, 360))
    parallax:addChild(map2, 2, cc.p(1, 0), ZERO_POINT);
    parallax:addChild(map3, 3, cc.p(0.7, 0), ZERO_POINT);
    
    self:setAnchorPoint(ZERO_POINT)
    self:addChild(parallax)
end

function BattleScene:addControllers()
    -- 左移键  
    local backBtn = ccui.Button:create('directionNormal.png', 'directionSelected.png', "", ccui.TextureResType.plistType)
    backBtn:setPosition(cc.p(117, 70))
    self:addChild(backBtn)
    backBtn:addTouchEventListener(function(ref, type)
        if type == ccui.TouchEventType.began then
            print('touch began')
        elseif type == ccui.TouchEventType.moved then
            print('touch moved')
        elseif type == ccui.TouchEventType.ended then
            print('touch ended')
        elseif type == ccui.TouchEventType.canceled then
            print('touch canceled')
        end
    end)

    local forwardBtn = ccui.Button:create('directForNor.png', 'directForSel.png', "", ccui.TextureResType.plistType)
    forwardBtn:setPosition(cc.p(304, 70))
    self:addChild(forwardBtn)
    forwardBtn:addTouchEventListener(function(ref, type)
        if type == ccui.TouchEventType.began then
            print('touch began')
        elseif type == ccui.TouchEventType.moved then
            print('touch moved')
        elseif type == ccui.TouchEventType.ended then
            print('touch ended')
        elseif type == ccui.TouchEventType.canceled then
            print('touch canceled')
        end
    end)

    -- 攻击
    local attackBg = cc.Sprite:createWithSpriteFrame(display.newSpriteFrame('quan.png'))
    local attackSz = attackBg:getContentSize()
    attackBg:setPosition(cc.p(display.width - 230, 76))
    local attackBtn = ccui.Button:create('fist.png', 'fist.png', '', ccui.TextureResType.plistType)
    attackBtn:setPosition(attackSz.width * 0.5, attackSz.height * 0.5)
    attackBg:add(attackBtn)
    attackBtn:addTouchEventListener(function(ref, type)
        if type == ccui.TouchEventType.ended then
            print( "attack!!!" )
            hero:startFistAnimation()
        end
    end)
    self:add(attackBg)
end

function BattleScene:update()
end

function BattleScene:addHero()
    hero:initSprite()
    hero:setPosition(cc.p(100, 360))
    self:addChild(hero)
end


return BattleScene