<#
Purpose:       Script to remove many of the pre-loaded Microsoft Metro "modern app" bloatware. Called by Tron in Stage 2: De-bloat
               Add any AppX uninstall commands to this list to target them for removal
Requirements:  1. Administrator access
               2. Windows 8 and up
Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
Version:       1.2.2 + Add additional user-submitted entries
               1.2.1 * Fixed variable re-use, thanks to github:madbomb22
               1.2.0 * Implement removal process improvements, thanks to github:madbomb22
               1.1.8 + Add additional user-submitted entries
               1.1.7 + Add Microsoft.GetHelp
               1.1.6 ! Fix function evalution of * character. Thanks to u/madbomb122 and u/phant0md
               1.1.5 + Add Zune entries, thanks to /u/ComputeGuy
               1.1.4 + Add various entries, thanks to github:kronflux
               1.1.3 + Add various entries
               1.1.2 + Add Microsoft.WindowsFeedbackHub to active apps. Thanks to /u/Phaellow
                     + Add Microsoft.Microsoft3DViewer to inactive apps. Thanks to /u/Phaellow
               1.1.1 + Add missing entries Microsoft.OneConnect, Microsoft.WindowsReadingList. Thanks to /u/1nfestissumam
                     + Add Microsoft.MicrosoftStickyNotes to disabled list (user request)
                     - Move Microsoft.Windows.CloudExperienceHost and Windows.ContactSupport to disabled list due to erroring out
                     - Remove entry 9E2F88E3.Twitter (moved to Metro 3rd party list)
               1.1.0 * Update script to use cleaner removal function. Thanks to /u/madbomb122
               1.0.3 ! Fix typo in $PackagesToRemove array. Thanks to JegElsker
               1.0.2 - Remove Calendar and Mail app from active target list. Thanks to /u/Reynbou
               1.0.1 + Add script version and date variables to support automatic updates at Tron runtime
#>
$ErrorActionPreference = "SilentlyContinue"


########
# PREP #
########
$METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION = "1.2.2"
$METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_DATE = "2018-07-18"

# Needed for Removal
$AppxPackages = Get-AppxProvisionedPackage -online | select-object PackageName,Displayname
$ProPackageList = Get-AppxPackage -AllUsers | select-object PackageFullName, Name
$Script:AppxCount3rd = 0

# App Removal function
Function Remove-App([String]$AppName){
	If($AppxPackages.DisplayName -match $AppName -or $ProPackageList.Name -match $AppName ) {
		$PackageFullName = ($ProPackageList | where {$_.Name -like $AppName}).PackageFullName
		$ProPackageFullName = ($AppxPackages | where {$_.Displayname -like $AppName}).PackageName

		If($PackageFullName -is [array]){
			For($i=0 ;$i -lt $PackageFullName.Length ;$i++) {
				$Script:AppxCountMS++
				$Job = "TronScriptMS$AppxCountMS"
				$PackageF = $PackageFullName[$i]
				$ProPackage = $ProPackageFullName[$i]
				write-output "$AppxCountMS - $PackageF"
				Start-Job -Name $Job -ScriptBlock {
					Remove-AppxPackage -Package $using:PackageF | Out-null
					Remove-AppxProvisionedPackage -Online -PackageName $using:ProPackage | Out-null
				} | Out-null
			}
		} Else {
			$Script:AppxCountMS++
			$Job = "TronScriptMS$AppxCountMS"
			write-output "$AppxCountMS - $PackageFullName"
			Start-Job -Name $Job -ScriptBlock {
				Remove-AppxPackage -Package $using:PackageFullName | Out-null
				Remove-AppxProvisionedPackage -Online -PackageName $using:ProPackageFullName | Out-null
			} | Out-null
		}
	}
}

###########
# EXECUTE #
###########
# Active identifiers
Remove-App "Microsoft.Advertising.Xaml"                # Advertising framework
Remove-App "Microsoft.BingFinance"                     # Money app - Financial news
Remove-App "Microsoft.BingFoodAndDrink"                # Food and Drink app
Remove-App "Microsoft.BingHealthAndFitness"            # Health and Fitness app
Remove-App "Microsoft.BingMaps"
Remove-App "Microsoft.BingNews"                        # Generic news app
Remove-App "Microsoft.BingSports"                      # Sports app - Sports news
Remove-App "Microsoft.BingTranslator"                  # Translator app - Bing Translate
Remove-App "Microsoft.BingTravel"                      # Travel app
Remove-App "Microsoft.CommsPhone"                      # Phone app
Remove-App "Microsoft.ConnectivityStore"
Remove-App "Microsoft.FreshPaint"                      # Canvas app
Remove-App "Microsoft.GetHelp"                         # Get Help link
Remove-App "Microsoft.Getstarted"                      # Get Started link
Remove-App "Microsoft.Messaging"                       # Messaging app
Remove-App "Microsoft.MicrosoftJackpot"                # Jackpot app
Remove-App "Microsoft.MicrosoftJigsaw"                 # Jigsaw app
Remove-App "Microsoft.MicrosoftMahjong"                # Advertising framework
Remove-App "Microsoft.MicrosoftOfficeHub"
Remove-App "Microsoft.MicrosoftPowerBIForWindows"      # Power BI app - Business analytics
Remove-App "Microsoft.MicrosoftSudoku"
Remove-App "Microsoft.MinecraftUWP"
Remove-App "Microsoft.MovieMoments"                    # imported from stage_2_de-bloat.bat
Remove-App "Microsoft.NetworkSpeedTest"
Remove-App "Microsoft.Office.OneNote"                  # Onenote app
Remove-App "Microsoft.Office.Sway"                     # Sway app
Remove-App "Microsoft.OneConnect"                      # OneConnect app
Remove-App "Microsoft.People"                          # People app
Remove-App "Microsoft.SkypeApp"                        # Get Skype link
Remove-App "Microsoft.SkypeWiFi"
Remove-App "Microsoft.Studios.Wordament"               # imported from stage_2_de-bloat.bat
Remove-App "Microsoft.WindowsFeedbackHub"              # Feedback app
Remove-App "Microsoft.WindowsReadingList"
Remove-App "Microsoft.Zune"                           # Zune collection of apps
Remove-App "Windows.CBSPreview"
Remove-App "Windows.ContactSupport"


# Inactive identifers
#Remove-App "Microsoft.Appconnector"                   # Not sure about this one
#Remove-App "Microsoft.BingWeather"                    # Weather app
#Remove-App "Microsoft.BioEnrollment"                  # not sure about this one
#Remove-App "Microsoft.Microsoft3DViewer"              # 3D model viewer
#Remove-App "Microsoft.MicrosoftSolitaireCollection"   # Solitaire collection
#Remove-App "Microsoft.MicrosoftStickyNotes"           # Pulled from active list due to user requests
#Remove-App "Microsoft.Windows.Photos"                 # Photos app
#Remove-App "Microsoft.WindowsAlarms"                  # Alarms and Clock app
#Remove-App "Microsoft.WindowsCalculator"              # Calculator app
#Remove-App "Microsoft.WindowsCamera"                  # Camera app
#Remove-App "Microsoft.WindowsMaps"                    # Maps app
#Remove-App "Microsoft.WindowsSoundRecorder"           # Sound Recorder app
#Remove-App "Microsoft.WindowsStore"                   # Windows Store
#Remove-App "Microsoft.windowscommunicationsapps"      # Calendar and Mail app
#Remove-App "Microsoft.MSPaint"                        # MS Paint (Paint 3D)
#Remove-App "Microsoft.ZuneMusic"
#Remove-App "Microsoft.ZuneVideo"
#Remove-App "Microsoft.Xbox*"
#Remove-App "Microsoft.Xbox.TCUI"
#Remove-App "Microsoft.XboxApp"
#Remove-App "Microsoft.XboxGameCallableUI"
#Remove-App "Microsoft.XboxGameOverlay"
#Remove-App "Microsoft.XboxGamingOverlay"
#Remove-App "Microsoft.XboxIdentityProvider"
#Remove-App "Microsoft.XboxSpeechToTextOverlay"

##########
# Finish #
##########
# DO NOT REMOVE OR CHANGE (needs to be at end of script)
# Waits for Apps to be removed before script closes
Write-Output 'Finishing app removal, please wait...'
Wait-Job -Name "TronScriptMS*" | Out-Null
Remove-Job -Name "TronScriptMS*" | Out-Null
