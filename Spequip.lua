local Spequip = CreateFrame('Frame')
Spequip:RegisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
Spequip:SetScript('OnEvent', function()
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

	if(not talentIndex) then return end
	for index = 1, GetNumEquipmentSets() do
		local name = GetEquipmentSetInfo(index)
		if(name == talentIndex or name == mostPointsName) then
			return EquipmentManager_EquipSet(name)
		end
	end

	print('|cffff8080Spequip:|r Unable to match equipment set to', mostPointsName, '(' .. talentIndex .. ')')
end)
