$workingdir = Get-Location
$mountPath = Join-Path $workingdir "mount"

$apps=@( 	
	"9E2F88E3.Twitter"
	"ClearChannelRadioDigital.iHeartRadio"
	"Flipboard.Flipboard"
	"king.com.CandyCrushSodaSaga"
	"Microsoft.3DBuilder"
	"Microsoft.BingFinance"
	"Microsoft.BingNews"
	"Microsoft.BingSports"
	"Microsoft.BingWeather"
	"Microsoft.CommsPhone"
	"Microsoft.Getstarted"
	"Microsoft.Messaging"
	"Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
	"Microsoft.Office.OneNote"
	"Microsoft.Office.Sway"
	"Microsoft.People"
	"Microsoft.SkypeApp"
	"Microsoft.Windows.Phone"
	#"Microsoft.Windows.Photos"
	"Microsoft.WindowsAlarms"
	#"Microsoft.WindowsCalculator"
	"Microsoft.WindowsCamera"
	"Microsoft.WindowsMaps"
	"Microsoft.WindowsPhone"
	"Microsoft.WindowsSoundRecorder"
	"Microsoft.XboxApp"
	"Microsoft.ZuneMusic"
	"Microsoft.ZuneVideo"
	"microsoft.windowscommunicationsapps"
	"Microsoft.MinecraftUWP"
	"ShazamEntertainmentLtd.Shazam"		
)

foreach ($app in $apps) {	
	Get-AppXProvisionedPackage -path $mountPath | where DisplayName -EQ $app | Remove-AppxProvisionedPackage
    }