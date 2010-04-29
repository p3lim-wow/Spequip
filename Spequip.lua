local function OnEvent()
	local talentIndex
	local mostPoints = -1
	local mostPointsName

	for index = 1, GetNumTalentTabs() do
		local name, _, points = GetTalentTabInfo(index)
		talentIndex = (talentIndex and talentIndex .. '/' or '') .. points

		if(points > mostPoints) then
			mostPoints = points
			mostPointsName = name
		end
	end

	for index = 1, GetNumEquipmentSets() do
		local name = GetEquipmentSetInfo(index)
		if(name == talentIndex or name == mostPointsName) then
			return EquipmentManager_EquipSet(name)
		end
	end

	print('|cffff8080Spequip:|r Unable to match equipment set to', mostPointsName, '(' .. talentString .. ')')
end

local Spequip = CreateFrame('Frame')
Spequip:RegisterEvent('PLAYER_LOGIN')
Spequip:SetScript('OnEvent', function(self, event)
	self:UnregisterEvent(event)
	self:RegisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
	self:SetScript('OnEvent', OnEvent)
end)
