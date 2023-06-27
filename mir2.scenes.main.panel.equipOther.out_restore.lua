slot0 = 1.3
slot1 = import("..common.item")
slot2 = import("..common.titleInfo")
slot3, slot4 = nil
slot5 = import("mir2.cfg.xiaolan.equippos")
slot6 = uiconfig.equip.newpos
slot7 = class("equipOther", function ()
	return display.newNode()
end)

table.merge(slot7, {})

function slot7.ctor(slot0, slot1)
	slot2 = kcarea:requestMyjson("equip")

	slot2:anchor(0, 0):addto(slot0)

	if not slot2 then
		os.exit()
	end

	slot0.bg = slot2

	slot0:anchor(1, 1):pos(display.width - 360, display.height - 16):size(cc.size(slot2:getContentSize().width, slot2:getContentSize().height))

	slot0._scale = 1
	slot0._supportMove = true

	an.newBtn(res.gettex2("pic/common/close10.png"), function ()
		sound.playSound("103")
		uv0:hidePanel()
	end, {
		pressImage = res.gettex2("pic/common/close11.png"),
		size = cc.size(64, 64)
	}):anchor(1, 1):pos(slot0:getw() + (uv0.exitbtn.x or 0), slot0:geth() - (uv0.exitbtn.y or 48)):addto(slot0, 1)
	an.newLabel(slot1:get("userName"), 22, 1, {
		color = def.colors.get(slot1:get("nameColorIndex"))
	}):anchor(0.5, 0.5):pos(slot0:getw() / 2, slot0:geth() - (uv0.name.y or 34)):addto(slot0)

	slot0.playerName = slot1:get("userName")
	slot3 = {
		"equip"
	}
	slot4 = {
		"装\n备"
	}

	if uiconfig.equip.page then
		for slot8, slot9 in ipairs(uiconfig.equip.page) do
			if slot9.titleInfo ~= "时\n装" then
				table.insert(slot3, slot9.texts)
				table.insert(slot4, slot9.titleInfo)
			end
		end
	end

	slot5 = {
		[slot10] = an.newBtn(res.gettex2("pic/common/btn130.png"), function ()
		end, {
			label = {
				slot4[slot10],
				24,
				1,
				cc.c3b(166, 161, 151)
			},
			labelOffset = {
				x = 2,
				y = 12
			},
			select = {
				res.gettex2("pic/common/btn131.png"),
				manual = true
			}
		}):add2(slot0, 5 - slot10):anchor(1, 1):pos(posX, posY)
	}

	function slot6(slot0)
		sound.playSound("103")

		for slot4, slot5 in ipairs(uv0) do
			if slot5 == slot0 then
				slot5:select()
				slot5:setLocalZOrder(5)
				slot5.label:setColor(cc.c3b(232, 204, 216))
			else
				slot5:setLocalZOrder(5 - slot4)
				slot5:unselect()
				slot5.label:setColor(cc.c3b(166, 161, 151))
			end
		end

		if slot0.page ~= uv1.page then
			uv1:showContent(uv2, slot0.page)

			uv1.msgnum = 0
		end
	end

	for slot10, slot11 in ipairs(slot3) do
		posX = uv0.leftlabel.x or 7
		posY = (uv0.leftlabel.y or 412) - (slot10 - 1) * (uv0.leftlabel.space or 86)
		normalImg = "pic/common/btn140.png"
		selectedImg = "pic/common/btn141.png"
		offsetX = 2

		slot5[slot10]:setTouchEnabled(false)
		display.newNode():size(slot5[slot10]:getw(), slot5[slot10]:geth() - 30):pos(0, 30):add2(slot5[slot10]):enableClick(function ()
			uv0(uv1[uv2])
		end)

		slot5[slot10].page = slot11
	end

	slot0.msgnum = 0
	slot0.lastmsg = ""

	slot6(slot5[1])
end

function slot7.showContent(slot0, slot1, slot2)
	if slot0.content then
		slot0.content:removeSelf()
	end

	slot0.content = display.newNode():addto(slot0)
	slot2 = slot2 or "equip"
	slot0.page = slot2
	slot0.loopEffSpr = {}

	if slot2 == "equip" then
		slot3 = uv0.sexbg.scale or 1.2

		slot0.content:setScale(slot3)
		res.get2("pic/panels/equip/equip.png"):anchor(0.5, 0):pos(slot0:getw() * 0.5, 42):add2(slot0.content)

		slot0.fashionbg = res.get2("pic/panels/equip/bg2.png"):anchor(0, 0):addto(slot0.content):pos(slot0.bg:getw() - 44, 0):hide()

		an.newLabel("时装", 19, 1):anchor(0.5, 0.5):pos(slot0.fashionbg:getw() / 2, slot0.fashionbg:geth() - 28):addto(slot0.fashionbg)

		slot0.disY = 0

		res.get2(Hibyte(Hiword(slot1:get("feature"))) % 2 == 0 and "pic/panels/equip/sex0.png" or "pic/panels/equip/sex1.png"):add2(slot0.content):pos((uv0.sexbg.x or 26) / slot3, (uv0.sexbg.y or 21) / slot3):anchor(0, 0):scale(1 / slot3)

		slot0.guildLabel = an.newLabel("", 22, 1, {
			color = cc.c3b(191, 173, 126)
		}):anchor(0.5, 0.5):addto(slot0.content):pos(slot0:getw() * 0.5 / slot3, (uv0.guild.y or 395) / slot3)
		slot0.clanLabel = an.newLabel("", 20, 1, {
			color = cc.c3b(191, 173, 126)
		}):anchor(0.5, 0.5):addto(slot0.content):pos(slot0:getw() * 0.5 / slot3, (uv0.chan.y or 360) / slot3)

		if slot0.isHero then
			if true then
				-- Nothing
			end
		else
			slot6 = ""

			if g_data.guild.guildInfo or g_data.guild.clanInfo then
				if g_data.guild.guildInfo then
					slot0.guildLabel:setString(g_data.guild.guildInfo:get("gildName"))
				end

				if g_data.guild.clanInfo then
					slot0.clanLabel:setString(g_data.guild.clanInfo:get("corpsName"))
				end
			end
		end

		if ycFunction:band(Lobyte(Hiword(slot1:get("feature"))), 15) > 0 then
			res.getui(1, 440 + slot6):add2(slot0.content):anchor(0.5, 1):pos(139, 240)
		end

		if uiconfig.equip.btn then
			for slot10, slot11 in ipairs(uiconfig.equip.btn) do
				an.newBtn(res.gettex(slot11.rsc, slot11.imgidx), function ()
					sound.playSound("103")

					if uv0.cmd then
						KcCmd(uv0.cmd)
					elseif uv0.panel then
						if uv0.panel == "chat" then
							main_scene.ui:togglePanel("chat")
						else
							main_scene.ui.console.btnCallbacks:handle("panel", uv0.panel)
						end
					elseif uv0.mynpc then
						main_scene.ui:togglePanel("mynpc", {
							uv0.mynpc,
							uv1.playerName
						})
					end
				end, {
					pressImage = res.gettex(slot11.rsc, slot11.imgidx + 2)
				}):pos(slot11.disx, slot11.disy):add2(slot0.content, 99)
			end
		end

		slot0.items = {}
		slot7 = 0
		slot11 = "userItems"

		for slot11, slot12 in ipairs(slot1:get(slot11)) do
			if slot12:get("Index") ~= 0 then
				slot7 = 0

				if slot11 == 3 or slot11 == 4 or slot11 >= 6 and slot11 <= 9 then
					slot7 = slot0.disY
				end

				slot13 = slot12.getVar("looks")
				slot14 = slot12.getVar("outlook")
				slot16 = 0
				slot17 = 0

				if def.role.getNeixianPos(slot12.getVar("name")) then
					slot16 = slot18.disx
					slot17 = slot18.disy
				end

				if slot11 == 5 then
					slot19 = 0 - 10
				end

				if slot11 == 1 or slot11 == 2 or slot11 == 5 or slot11 == 15 then
					slot20, slot21, slot22, slot23, slot24 = slot0:idx2pos(slot11 - 1)
					slot0.items[slot11] = uv1.new(slot12, slot0, {
						mute = true,
						img = "stateitem",
						donotMove = true,
						isSetOffset = slot23,
						idx = k
					}):addto(slot0.content, slot22):pos(slot20, slot21 + slot7)
					slot25 = res.getani2("pic/neixian/" .. slot13 .. "/%d.png", 1, 30, def.xiaolan.anifps)

					slot25:retain()

					slot0.loopEffSpr[slot11] = res.get2("pic/neixian/" .. slot13 .. "/1.png"):pos(slot20 + 98 + slot16, slot21 + slot7 + slot19 + slot17):add2(slot0.content, slot22 + 1):anchor(0.5, 0.5)

					slot0.loopEffSpr[slot11].runForever(slot0.loopEffSpr[slot11], cc.Animate:create(slot25))
				elseif slot14 ~= nil and slot11 == 14 and def.xiaolan.fashionid < slot14 then
					slot20, slot21, slot22, slot23, slot24 = slot0:idx2pos(slot11 - 1)
					slot0.items[slot11] = uv1.new(slot12, slot0, {
						mute = true,
						img = "stateitem",
						donotMove = true,
						isSetOffset = slot23,
						idx = k
					}):addto(slot0.fashionbg):pos(slot0.fashionbg:getw() / 2, slot0.fashionbg:geth() / 2)
					slot25 = res.getani2("pic/neixian/" .. slot13 .. "/%d.png", 1, 30, def.xiaolan.anifps)

					slot25:retain()

					slot0.loopEffSpr[slot11] = res.get2("pic/neixian/" .. slot13 .. "/1.png"):pos(slot0.fashionbg:getw() / 2 + slot16, slot0.fashionbg:geth() / 2 + slot17):add2(slot0.fashionbg):anchor(0.5, 0.5)

					slot0.loopEffSpr[slot11].runForever(slot0.loopEffSpr[slot11], cc.Animate:create(slot25))
					slot0.fashionbg:show()
				else
					slot20, slot21, slot22, slot23, slot24 = slot0:idx2pos(slot11 - 1)
					slot0.items[slot11] = uv1.new(slot12, slot0, {
						mute = true,
						img = "stateitem",
						donotMove = true,
						isSetOffset = slot23,
						idx = k
					}):addto(slot0.content, slot22):pos(slot20, slot21 + slot7)
					slot25 = res.getani2("pic/neixian/" .. slot13 .. "/%d.png", 1, 30, def.xiaolan.anifps)

					slot25:retain()

					slot0.loopEffSpr[slot11] = res.get2("pic/neixian/" .. slot13 .. "/1.png"):pos(slot20 + slot16, slot21 + slot7 + slot17):add2(slot0.content, slot22 + 1):anchor(0.5, 0.5)

					slot0.loopEffSpr[slot11].runForever(slot0.loopEffSpr[slot11], cc.Animate:create(slot25))
				end

				if attach then
					slot0.items[slot11 .. "_attach"] = uv1.new(slot12, slot0, {
						donotMove = true,
						idx = slot11
					}):addto(slot0.content, attach[3]):pos(attach[1], attach[2])
				end
			end
		end

		if slot1:get("clanName") == " 的英雄" then
			if slot0.items[14] and slot0.items[5] then
				slot0.items[5]:hide()
			end

			an.newLabel(slot1:get("guildName") .. slot1:get("clanName"), 16, 1, {
				color = def.colors.labelGray
			}):anchor(0.5, 0.5):addto(slot0.content):pos(150, 368)
		else
			slot8 = ""

			if net.str(slot1:get("guildName")) == "" and net.str(slot1:get("clanName")) == "" then
				slot0.guildLabel:setString(slot8)
				slot0.clanLabel:setString(slot8)
			else
				slot0.guildLabel:setString(slot1:get("guildName"))
				slot0.clanLabel:setString(slot1:get("clanName"))
			end
		end
	else
		slot3 = slot2 or "hungu"
		slot0.pageName = slot3
		slot0.extraName = slot2
		uv2 = parseJson("config/" .. slot3 .. ".json")

		if not uv2 then
			return
		end

		slot5 = uv2.menu
		uv3 = uv2.path

		slot0.bg:setTex(res.gettex2(uv3 .. "/" .. uv2.bg))

		if uv2.scroll then
			slot0.content = an.newScroll(uv2.scroll.disx, uv2.scroll.disy, uv2.scroll.width, uv2.scroll.height):add2(slot0)

			slot0.content:setScrollSize(uv2.scroll.width, uv2.scroll.height)
		end

		slot0:extraContent(slot5.sprs[1])
	end

	if uiconfig.equip.img then
		for slot6, slot7 in pairs(uiconfig.equip.img) do
			res.get(slot7.rsc, slot7.imgidx):addto(slot0.content, slot7.z or 5):anchor(0, 0):pos(slot7.disx, slot7.disy)
		end
	end
end

function slot7.extraContent(slot0, slot1)
	slot0.alltext = {}
	slot0.allcmd = {}
	slot0.allimg = {}
	slot0.allbtn = {}
	slot0.loopEffSpr = {}
	slot0.content_info = nil
	slot0.content_info = uv0.content[slot1 or "one"]

	if not slot0.content_info then
		return
	end

	slot0:schedule(function ()
		uv0:update()
	end, 0.2)

	if slot0.content_info.load.t then
		for slot7, slot8 in ipairs(slot3.t) do
			slot0.alltext[slot8.id] = an.newLabel(slot8.desc, slot8.fontsize or 12, 1, {
				color = def.colors.get(slot8.color or 255)
			}):anchor(0, 0):addto(slot0.content, slot8.z):pos(slot8.x, slot8.y)
		end
	end

	if slot3.i then
		for slot7, slot8 in ipairs(slot3.i) do
			slot0.allimg[slot8.id] = res.get2(uv1 .. "/img/" .. tostring(slot8.path) .. ".png"):anchor(0, 0):add2(slot0.content, slot8.z):pos(slot8.x, slot8.y)

			if slot8.info or slot8.kccmd then
				slot0.allimg[slot8.id]:setTouchEnabled(true)
				slot0.allimg[slot8.id]:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (slot0)
					if slot0.name == "began" and uv0.info then
						uv1:infoContent(uv0.info, uv0.x, uv0.y, uv1.allimg[uv0.id]:getw() / 2, uv1.allimg[uv0.id]:geth() / 2)
					end
				end)
			end
		end
	end

	if slot3.a then
		for slot7, slot8 in ipairs(slot3.a) do
			slot9 = uv1 .. "/animation/" .. tostring(slot8.path)
			slot10 = res.getani2(slot9 .. "/%d.png", 1, 50, 0.12)

			slot10:retain()

			slot0.loopEffSpr[slot8.id] = res.get2(slot9 .. "/1.png"):pos(slot8.x, slot8.y):add2(slot0.content, slot8.z):anchor(0, 0)

			slot0.loopEffSpr[slot8.id].runForever(slot0.loopEffSpr[slot8.id], cc.Animate:create(slot10))

			if slot8.info or slot8.kccmd then
				slot0.loopEffSpr[slot8.id]:setTouchEnabled(true)
				slot0.loopEffSpr[slot8.id]:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (slot0)
					if slot0.name == "began" and uv0.info then
						uv1:infoContent(uv0.info, uv0.x, uv0.y, uv1.loopEffSpr[uv0.id]:getw() / 2, uv1.loopEffSpr[uv0.id]:geth() / 2)
					end
				end)
			end
		end
	end

	slot0:loadmsg()
end

function slot7.infoContent(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot9 = slot4 or 0
	slot10 = slot5 or 0
	slot11 = display.newNode():size(display.width, display.height):addto(slot0.content, 99)

	slot11:setTouchEnabled(true)
	slot11:setTouchSwallowEnabled(false)
	slot11:addNodeEventListener(cc.NODE_TOUCH_CAPTURE_EVENT, function (slot0)
		if slot0.name == "began" then
			uv0:runs({
				cc.DelayTime:create(0.1),
				cc.RemoveSelf:create(true)
			})
		end

		return true
	end)

	slot12 = display.newScale9Sprite(res.getframe2("pic/scale/scale24.png")):addto(slot11):anchor(0, 1)
	slot13 = 0
	slot14 = 7
	slot15 = -2
	slot17 = {}

	for slot21, slot22 in ipairs(slot1) do
		for slot29, slot30 in ipairs(string.split(slot22.desc, "/")) do
			slot17[#slot17 + 1] = an.newLabel(slot30, 16, 1, {
				color = def.colors.get(slot22.color or 255)
			})
		end
	end

	for slot21 = #slot17, 1, -1 do
		slot22 = slot17[slot21]:addto(slot12, 99):anchor(0, 0):pos(10, slot14)
		slot13 = math.max(slot13, slot22:getw() + 5)
		slot14 = slot14 + slot22:geth() + slot15
	end

	slot12:size(slot13 + 50, slot14 + 10):pos(slot2 + slot9, slot3 + slot10)
end

function slot7.checkExist(slot0)
	slot4 = {}

	for slot8, slot9 in ipairs(string.split(string.split(slot0.lastmsg, "|")[2], "#")) do
		slot4[#slot4 + 1] = string.split(slot9, ":")
	end

	for slot9, slot10 in ipairs(slot4) do
		slot12 = slot10[1]

		if tonumber(slot10[2]) and slot12 and slot11 ~= 0 and slot12 ~= "" then
			slot13 = type(slot12)
			slot15 = slot0.content_info.refresh[slot12][slot11].id

			if slot12 == "t" then
				if slot0.alltext[slot15] then
					slot0.alltext[slot15]:removeSelf()
				end

				if not slot14.removeonly then
					slot0.alltext[slot15] = an.newLabel(slot14.desc, slot14.fontsize or 12, 1, {
						color = def.colors.get(slot14.color or 255)
					}):anchor(0, 0):addto(slot0.content, slot14.z):pos(slot14.x, slot14.y)

					if slot10[3] then
						slot0.alltext[slot15]:setString(slot10[3])
					end
				end
			elseif slot12 == "i" then
				if slot0.allimg[slot15] then
					slot0.allimg[slot15]:removeSelf()
				end

				if not slot14.removeonly then
					slot0.allimg[slot15] = res.get2(uv0 .. "/img/" .. tostring(slot14.path) .. ".png"):anchor(0, 0):add2(slot0.content, slot14.z):pos(slot14.x, slot14.y)

					if slot14.info or slot14.kccmd then
						slot0.allimg[slot15]:setTouchEnabled(true)
						slot0.allimg[slot15]:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (slot0)
							if slot0.name == "began" and uv0.info then
								uv1:infoContent(uv0.info, uv0.x, uv0.y, uv1.allimg[uv2]:getw() / 2, uv1.allimg[uv2]:geth() / 2)
							end
						end)
					end
				end
			elseif slot12 == "a" then
				if slot0.loopEffSpr[slot15] then
					slot0.loopEffSpr[slot15]:removeSelf()
				end

				if not slot14.removeonly then
					slot16 = uv0 .. "/animation/" .. tostring(slot14.path)
					slot17 = res.getani2(slot16 .. "/%d.png", 1, 50, 0.12)

					slot17:retain()

					slot0.loopEffSpr[slot15] = res.get2(slot16 .. "/1.png"):pos(slot14.x, slot14.y):add2(slot0.content, slot14.z):anchor(0, 0)

					slot0.loopEffSpr[slot15].runForever(slot0.loopEffSpr[slot15], cc.Animate:create(slot17))

					if slot14.info or slot14.kccmd then
						slot0.loopEffSpr[slot15]:setTouchEnabled(true)
						slot0.loopEffSpr[slot15]:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (slot0)
							if slot0.name == "began" and uv0.info then
								uv1:infoContent(uv0.info, uv0.x, uv0.y, uv1.loopEffSpr[uv2]:getw() / 2, uv1.loopEffSpr[uv2]:geth() / 2)
							end
						end)
					end
				end
			else
				print("该项不符合要求")
			end
		end
	end
end

function slot7.loadmsg(slot0)
	net.send({
		CM_SAY
	}, {
		"event|requestOtherPlayer|" .. slot0.playerName .. "|" .. slot0.pageName
	})
end

function slot7.update(slot0)
	if slot0.page ~= slot0.extraName then
		return
	end

	slot1, slot2 = g_data.chat:getMyNewMsg("裤衩")

	if slot1.data and string.find(slot1.data[1], slot0.playerName) and string.find(slot1.data[1], "裤衩#" .. uv0.name .. "#" .. "one") and slot0.msgnum ~= slot2 then
		slot0.lastmsg = slot1.data[1]
		slot0.msgnum = slot2

		slot0:checkExist()
	end
end

function slot7.initPosTable(slot0)
	slot0.itemPosTable = slot0.itemPosTable or uv0.equipother
end

function slot7.idx2pos(slot0, slot1)
	slot0:initPosTable()

	slot2 = slot0.itemPosTable[tonumber(slot1)] or {
		0,
		0,
		0,
		0
	}

	return slot2[1], slot2[2], slot2[3], slot2[4], slot2.attach
end

return slot7
