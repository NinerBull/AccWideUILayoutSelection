local L = LibStub("AceLocale-3.0"):GetLocale("AccWideUIAceAddonLocale")


function AccWideUIAceAddon:ExportProfile()

	if not InCombatLockdown() then
	
		-- Window
		local thisExportWindow = AccWideUIAceAddon.AceGUI:Create("Frame")
		thisExportWindow:SetCallback("OnClose", function(thisWidget) 
			AccWideUIAceAddon.AceGUI:Release(thisWidget) 
		end)
		
		thisExportWindow:SetTitle(L["ACCWUI_ADDONNAME"] .. " - " .. L["ACCWUI_IE_EXPORT"])
		thisExportWindow:SetLayout("Flow")
		thisExportWindow:SetStatusText(L["ACCWUI_ADCOM_CURRENT"] .. ": " .. AccWideUIAceAddon.db:GetCurrentProfile())
		
		-- Serialize and compress the profile table
		local thisExportTable = CopyTable(self.db.profile)
		local thisExportTableEx = self.LibSerialize:Serialize(thisExportTable)
		local thisExportTableExCD = self.LibDeflate:CompressDeflate(thisExportTableEx)
		local thisExportTableExCDPT = self.LibDeflate:EncodeForPrint(thisExportTableExCD)

		-- Description Text
		thisExportWindow.TextLine1 = AccWideUIAceAddon.AceGUI:Create("Label")
		thisExportWindow.TextLine1:SetFontObject("GameFontWhiteLarge")
		thisExportWindow.TextLine1:SetText(L["ACCWUI_IE_EXPORT_DESC"])
		thisExportWindow.TextLine1:SetFullWidth(true)
		
		thisExportWindow:AddChild(thisExportWindow.TextLine1)
		
		-- Create Big Text Box
		thisExportWindow.BigTextBox = AccWideUIAceAddon.AceGUI:Create("MultiLineEditBox")
		thisExportWindow.BigTextBox:SetFullWidth(true)
		thisExportWindow.BigTextBox:SetFullHeight(true)
		thisExportWindow.BigTextBox:SetLabel(L["ACCWUI_IE_EXPORTSTRING"])
		thisExportWindow.BigTextBox:DisableButton(true)
		thisExportWindow.BigTextBox:SetText(thisExportTableExCDPT)
		thisExportWindow.BigTextBox:HighlightText()
		
		thisExportWindow:AddChild(thisExportWindow.BigTextBox)
	
	else
	
		self:Print(L["ACCWUI_WAIT_TILL_COMBAT2"])
	
	end
	

end



function AccWideUIAceAddon:ImportProfile()

	if not InCombatLockdown() then
	
		-- Window
		local thisImportWindow = self.AceGUI:Create("Frame")
		thisImportWindow:SetCallback("OnClose", function(thisWidget) 
			self.AceGUI:Release(thisWidget) 
		end)
		
		thisImportWindow:SetTitle(L["ACCWUI_ADDONNAME"] .. " - " .. L["ACCWUI_IE_IMPORT"])
		thisImportWindow:SetLayout("Flow")
		thisImportWindow:SetStatusText(L["ACCWUI_ADCOM_CURRENT"] .. ": " .. self.db:GetCurrentProfile())
		

		-- Description Text
		thisImportWindow.TextLine1 = self.AceGUI:Create("Label")
		thisImportWindow.TextLine1:SetFontObject("GameFontWhiteLarge")
		thisImportWindow.TextLine1:SetText(L["ACCWUI_IE_IMPORT_DESC"])
		thisImportWindow.TextLine1:SetFullWidth(true)
		
		thisImportWindow:AddChild(thisImportWindow.TextLine1)
		
		-- Create Big Text Box
		thisImportWindow.BigTextBox = self.AceGUI:Create("MultiLineEditBox")
		thisImportWindow.BigTextBox:SetFullWidth(true)
		thisImportWindow.BigTextBox:SetNumLines(22)
		thisImportWindow.BigTextBox:SetLabel(L["ACCWUI_IE_IMPORTSTRING"])
		thisImportWindow.BigTextBox:DisableButton(true)
		
		thisImportWindow:AddChild(thisImportWindow.BigTextBox)
		
		-- Add Button
		thisImportWindow.SaveButton = self.AceGUI:Create("Button")
		thisImportWindow.SaveButton:SetWidth(320)
		thisImportWindow.SaveButton:SetText(L["ACCWUI_IE_IMPORT"])
		thisImportWindow.SaveButton:SetCallback("OnClick", function() 
		
			if not InCombatLockdown() then
			
				local thisImportTableExCDPT = self.LibDeflate:DecodeForPrint(thisImportWindow.BigTextBox:GetText())
				local thisImportTableExCD = self.LibDeflate:DecompressDeflate(thisImportTableExCDPT)
				
				if thisImportTableExCD then
					local thisImportTableEx, thisImportTableExData = self.LibSerialize:Deserialize(thisImportTableExCD)
					
					if thisImportTableEx then
					
						if type(thisImportTableExData) == "table" then
							--Import it!
							self.db.profile = thisImportTableExData
							
							self:Print(L["ACCWUI_IE_IMPORT_SUCCESS"])
							
							if (self.db.global.disableAutoSaveLoad == false) then
								AccWideUIAceAddon:ForceLoadSettings() 
							end
							
							self.AceGUI:Release(thisImportWindow) 
						else
							self:Print(L["ACCWUI_IE_IMPORT_FAIL"])
						end
					else
						self:Print(L["ACCWUI_IE_IMPORT_FAIL"])
					end
					
				else
					self:Print(L["ACCWUI_IE_IMPORT_FAIL"])
				end
			
			else
				self:Print(L["ACCWUI_WAIT_TILL_COMBAT2"])
			end
			
		end)
		
		thisImportWindow:AddChild(thisImportWindow.SaveButton)
		
	
	else
	
		self:Print(L["ACCWUI_WAIT_TILL_COMBAT2"])
	
	end
	

end