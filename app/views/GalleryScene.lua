-- 图籍场景

local GalleryScene = class("GalleryScene", cc.load("mvc").ViewBase)
local audio = require('audio')

function GalleryScene:onCreate()
	-- 添加背景
	local bg = cc.Sprite:create('PhotoGalleryBackground.png') -- 这张图没有合并到整图中，所以单独使用
    bg:move(display.center)
    :addTo(self)
    :setLocalZOrder(-1)

    -- 关闭按钮
    local closeMenu = self:createMenu(
    	'GalleryOffNormal.png', 
    	'GalleryOffSelected.png', 
    	cc.p(display.cx + 580, display.cy + 320),
    	function()
            audio.playButtonEffect()
	    	self:getApp():enterScene('MainScene')
	    end)
    closeMenu:setLocalZOrder(1)
    

    -- 怪物列表
    local listView = ccui.ListView:create()
    listView:setDirection(ccui.ScrollViewDir.vertical) -- 设置方向
    listView:setBounceEnabled(true) -- 设置回弹
    listView:setTouchEnabled(true) -- 设置是否可以点击
    listView:setSize(cc.size(445, 500))
    listView:setPosition(0, display.height / 4)
    bg:add(listView) -- listView:addTo(bg)

    -- 设置列表模版
    local defaultButton = ccui.Button:create(
        "Cell_0.png", 
        "CellSel_0.png", 
        "",
        ccui.TextureResType.plistType
    )
    local defaultSize = defaultButton:getSize()
    local defaultItem = ccui.Layout:create()
    defaultItem:setTouchEnabled(true) -- 设置item可以点击
    defaultItem:setContentSize(defaultSize)
    defaultButton:setPosition(
        cc.p(defaultSize.width * 0.5, defaultSize.height * 0.5)
    ) 
    defaultItem:add(defaultButton)
    listView:setItemModel(defaultItem)


    -- 怪物详情页面
    local detailPic = cc.Sprite:createWithSpriteFrame(
        display.newSpriteFrame('ManWood.png')
    )
    detailPic:move(display.cx + 50, display.cy):addTo(bg)
    local detailTxtBg = cc.Sprite:createWithSpriteFrame(
        display.newSpriteFrame('Text.png')
    )
    detailTxtBg:move(display.cx + 460, display.cy):addTo(bg)
    local detailLabel = cc.LabelTTF:create('木\n桩\n怪', '', 30)
    detailLabel:move(display.cx + 265, display.cy - 120)
        :addTo(bg)
        :setVisible(true)
    detailLabel:setColor(cc.c3b(0, 255, 255))

    local monsters = {
        { name = '木\n桩\n怪', png = 'ManWood.png'},
        { name = '狮\n子\n怪', png = 'ManLion.png'},
        { name = '石\n头\n怪', png = 'ManStone.png'},
        { name = '???', png = ''}
    }

    local function onTapMonster(ref, type)
        if type == ccui.TouchEventType.ended then
            audio.playButtonEffect()
            
            if ref.png == nil or ref.png == '' then
                detailPic:setVisible(false)
            else
                detailPic:setVisible(true)
                local spriteFrame = display.newSpriteFrame(ref.png)
                detailPic:setSpriteFrame(spriteFrame)
            end
            detailLabel:setString(ref.name)
        end
    end

    for i = 0, 3 do
        local normal = string.format("CellSel_%d.png", i)
        local selected = string.format('Cell_%d.png', i)
        local item = self:createListItem(normal, selected, defaultSize, onTapMonster)
        local monster = monsters[i+1]
        item.set('name', monster.name)
        item.set('png', monster.png)
        listView:pushBackCustomItem(item)
    end
end

function GalleryScene:createListItem(normalPath, selectedPath, size, callback)
    local button = ccui.Button:create(normalPath, selectedPath, "", ccui.TextureResType.plistType)
    button:setScale9Enabled(true)
    button:setContentSize(size)
    button:setPosition(cc.p(size.width * 0.5, size.height * 0.5))
    if callback ~= nil then
        button:addTouchEventListener(callback)
    end
    local item = ccui.Layout:create()
    item:setSize(size)
    item:addChild(button)
    item.set = function(key, val)
        button[key] = val
    end
    return item
end

return GalleryScene