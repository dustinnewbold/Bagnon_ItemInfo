--[[

	The MIT License (MIT)

	Copyright (c) 2023 Lars Norberg

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.

--]]
local Addon, Private =  ...
local Module = Bagnon:NewModule("Bagnon_Garbage")
local cache = {}

Private.cache[Module] = cache
Private.AddUpdater(Module, function(self)

	if (self.hasItem and BagnonItemInfo_DB.enableGarbage and self.info.quality == 0 and not self.info.locked) then

		local overlay = cache[self]
		if (not overlay) then
			overlay = self:CreateTexture()
			overlay.icon = self.icon or _G[self:GetName().."IconTexture"]
			overlay:Hide()
			overlay:SetDrawLayer("ARTWORK")
			overlay:SetAllPoints(overlay.icon)
			overlay:SetColorTexture(.04, .013333333, .004705882, .6)
			cache[self] = overlay
		end

		overlay:Show()
		SetItemButtonDesaturated(self, true)

	else
		local overlay = cache[self]
		if (overlay) then
			overlay:Hide()
			SetItemButtonDesaturated(self, self.info.locked)
		end
	end

end)

-- Also need to hook this to locked updates
hooksecurefunc(Bagnon.ItemSlot or Bagnon.Item, "SetLocked", Private.updatesByModule[Module])
