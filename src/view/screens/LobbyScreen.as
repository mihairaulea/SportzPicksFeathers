package view.screens 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.controls.Screen;
	import feathers.layout.VerticalLayout;
	import starling.display.Image;
	import flash.text.TextField;
	import flash.text.TextRenderer;
	import starling.events.Event;
	import flash.events.Event;
	
	import feathers.controls.Screen;
	import feathers.controls.Button;
	import feathers.controls.TextInput;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.system.DeviceCapabilities;
	import feathers.controls.renderers.*;
	
	import flash.text.TextFormat;
	import feathers.core.ITextRenderer;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
			
	import view.util.Assets; 
	
	import model.AppState;
	import model.DataRetrieval;
	import model.CountdownClass;
	 
	public class LobbyScreen extends Screen
	{
		
		[Embed(source="../../assets/fonts/HelveticaNeueLTCom-BdCn.ttf", embedAsCFF="false", fontName="HelveticaNeueLTCom-BdCn", advancedAntiAliasing="true", mimeType = "application/x-font")]
		private static const helveticaNeue:Class;
		
		[Embed(source = "../../assets/fonts/HelveticaNeueLTCom-Cn.ttf", embedAsCFF="false", fontName="HelveticaNeueCondensed", advancedAntiAliasing="true", mimeType = "application/x-font")]
		private static const helveticaNeueCondensed:Class;
		
		[Embed(source="../../assets/fonts/HelveticaNeueLTCom-MdCn.ttf", embedAsCFF="false", fontName="HelveticaMedium", advancedAntiAliasing="true", mimeType = "application/x-font")]
		private static const helveticaNeueMed:Class;		
		
		[Embed(source="../../assets/fonts/DS-DIGIB.TTF", embedAsCFF="false", fontName="DigitalBold", advancedAntiAliasing="true", mimeType = "application/x-font")]
		private static const dsDigitalBold:Class;
		
		private var smallLogo:Image;
		private var logoBackground:Image;
		private var navBarShadow:Image;
		private var menuBtn:Button;
		
		private var coinsDisplayAndBtn:Button;
		private var coinsTextFormat:TextFormat;
		
		private var timerBackground:Image;
		private var timerInfoTextFormat:TextFormat;
		private var actualTimerTextFormat:TextFormat;
		private var textFormatGoBtn:TextFormat;
		private var timerAdditionalInfoTextFormat:TextFormat;
		
		private var tournamentEndsInTextField:TextFieldTextRenderer;
		private var daysTextField:TextFieldTextRenderer;
		private var hoursTextField:TextFieldTextRenderer;
		private var minsTextField:TextFieldTextRenderer;
		private var secsTextField:TextFieldTextRenderer;
		private var days:TextFieldTextRenderer;
		private var hours:TextFieldTextRenderer;
		private var mins:TextFieldTextRenderer;
		private var secs:TextFieldTextRenderer;
		
		private var startNewGameButton:Button;
	
		private var challengesList:List;
		
		//data
		private var dataRetrieval:DataRetrieval;
		private var appState:AppState;
		private var countdownClass:CountdownClass;
		
		private static const EVENTS:Vector.<String> = new <String>
		[
		 "onChallengerSelected",
		];
		
		public function LobbyScreen() 
		{
			
		}
		
		override protected function initialize():void
		{
			textFormatGoBtn = new TextFormat("HelveticaNeueLTCom-BdCn", 18, 0xFFFFFF);
			timerInfoTextFormat = new TextFormat("DigitalBold", 44, 0xE24B37);
			timerAdditionalInfoTextFormat = new TextFormat("HelveticaMedium", 11, 0x8f8d8d);
			
			logoBackground = new Image( Assets.getAssetsTexture("nav_bar") );
			addChild(logoBackground);
					
			coinsDisplayAndBtn = new Button();
			coinsDisplayAndBtn.defaultSkin = new Image(Assets.getAssetsTexture("coins_hud"));
			coinsDisplayAndBtn.downSkin    = new Image(Assets.getAssetsTexture("coins_hud_press"));
			coinsDisplayAndBtn.label = "XXXXX";
			coinsDisplayAndBtn.labelOffsetY = 7;
			coinsDisplayAndBtn.labelFactory = getCoinsTextRenderer;
			addChild(coinsDisplayAndBtn);
			
			smallLogo = new Image(Assets.getAssetsTexture("logo_small"));
			addChild(smallLogo);
			
			menuBtn = new Button();
			menuBtn.defaultSkin = new Image(Assets.getAssetsTexture("menu_icon"));
			menuBtn.downSkin = new Image(Assets.getAssetsTexture("menu_icon_press"));
			addChild(menuBtn);
						
			//countdown
			timerBackground = new Image( Assets.getAssetsTexture("timer_bg") );
			addChild(timerBackground);
			
			tournamentEndsInTextField = new TextFieldTextRenderer();
			tournamentEndsInTextField.textFormat = timerAdditionalInfoTextFormat;
			tournamentEndsInTextField.embedFonts = true;
			addChild(tournamentEndsInTextField);
			tournamentEndsInTextField.text = "TOURNAMENT ENDS IN:";
			
			days = new TextFieldTextRenderer();
			days.textFormat = timerAdditionalInfoTextFormat;
			days.textFormat.size = 10;
			days.embedFonts = true;
			addChild(days);
			days.text = "DAYS";
			
			hours = new TextFieldTextRenderer();
			hours.textFormat = timerAdditionalInfoTextFormat;
			hours.textFormat.size = 10;
			hours.embedFonts = true;
			addChild(hours);
			hours.text = "HOURS";
			
			mins = new TextFieldTextRenderer();
			mins.textFormat = timerAdditionalInfoTextFormat;
			mins.textFormat.size = 10;
			mins.embedFonts = true;
			addChild(mins);
			mins.text = "MINS";
			
			secs = new TextFieldTextRenderer();
			secs.textFormat = timerAdditionalInfoTextFormat;
			secs.textFormat.size = 10;
			secs.embedFonts = true;
			addChild(secs);
			secs.text = "SECS";
			
			daysTextField = new TextFieldTextRenderer();
			daysTextField.textFormat = timerInfoTextFormat;
			daysTextField.embedFonts = true;
			addChild(daysTextField);
			
			
			hoursTextField = new TextFieldTextRenderer();
			hoursTextField.textFormat = timerInfoTextFormat;
			hoursTextField.embedFonts = true;
			addChild(hoursTextField);
			
			minsTextField = new TextFieldTextRenderer();
			minsTextField.textFormat = timerInfoTextFormat;
			minsTextField.embedFonts = true;
			addChild(minsTextField);
			
			secsTextField = new TextFieldTextRenderer();
			secsTextField.textFormat = timerInfoTextFormat;
			secsTextField.embedFonts = true;
			addChild(secsTextField);
			
			daysTextField.text = hoursTextField.text = minsTextField.text = secsTextField.text = "00";
			
			startNewGameButton = new Button();
			startNewGameButton.defaultSkin = new Image( Assets.getAssetsTexture("start_btn") );
			startNewGameButton.downSkin    = new Image( Assets.getAssetsTexture("start_btn_press") );
			addChild(startNewGameButton);
			startNewGameButton.label = "Start a new game";
			startNewGameButton.labelOffsetX = -40;
			startNewGameButton.labelFactory = getGoBtnTextRenderer;
			
			challengesList = new List();
			challengesList.itemRendererType = CustomLobbyItemRenderer;
			addChild(challengesList);
			
			//challengesList.itemRendererProperties.labelField = "text";
			//challengesList.itemRendererProperties.iconTextureField = "thumbnail";		
			
			countdownClass = CountdownClass.getInstance();
			dataRetrieval = DataRetrieval.getInstance();
			dataRetrieval.addEventListener(DataRetrieval.LOBBY_DATA_RECEIVED, lobbyDataReceivedHandler);
		}
		
		public function updateDaysHoursMinsSecondsDisplay( array:Array )
		{
			array[0].toString().length != 1 ? daysTextField.text = array[0] : daysTextField.text = "0" + String(array[0]);
			array[1].toString().length != 1 ? hoursTextField.text = array[1] : hoursTextField.text = "0" + String(array[1]);
			array[2].toString().length != 1 ? minsTextField.text = array[2] : minsTextField.text = "0" + String(array[2]);
			array[3].toString().length != 1 ? secsTextField.text = array[3] : secsTextField.text = "0" + String(array[3]);
		}
		
		override protected function draw():void
		{
			smallLogo.x = (this.actualWidth - smallLogo.width) / 2;
				
			coinsDisplayAndBtn.y = -4;
			coinsDisplayAndBtn.x = actualWidth - coinsDisplayAndBtn.defaultSkin.width;
			
			timerBackground.y = logoBackground.y + logoBackground.height;
			
			tournamentEndsInTextField.x = 33;
			tournamentEndsInTextField.y = timerBackground.y + 20;
			
			daysTextField.y = hoursTextField.y = minsTextField.y = secsTextField.y = timerBackground.y + (timerBackground.height - 48) / 2; 
			
			daysTextField.x = tournamentEndsInTextField.x;
			days.x = daysTextField.x + 2;
			hoursTextField.x = tournamentEndsInTextField.x + 68;
			hours.x = hoursTextField.x + 2;
			minsTextField.x = tournamentEndsInTextField.x + 136;
			mins.x = minsTextField.x + 2;
			secsTextField.x = tournamentEndsInTextField.x + 204;
			secs.x = secsTextField.x + 2;
			
			days.y = hours.y = mins.y = secs.y = timerBackground.y + 65; 
			
			startNewGameButton.y = timerBackground.y + timerBackground.height;
			
			
			challengesList.y = startNewGameButton.y + startNewGameButton.defaultSkin.height;
			challengesList.width = this.actualWidth;
			challengesList.height = this.actualHeight - (logoBackground.height + timerBackground.height + startNewGameButton.defaultSkin.height);
						
			challengesList.addEventListener(starling.events.Event.CHANGE, listChangedHandler);
			// dummy data!!!
			//{isNewChallenge:"false" ,playerPicture:"", playerName:"", playerPoints:"", myPoints:"", noTicks:"",noCups:""}		
			dataRetrieval.requestLobbyData( AppState.MY_USER_ID );
		}
				
		private function lobbyDataReceivedHandler(e : flash.events.Event)
		{
			trace( dataRetrieval.lobbyInfo );
			trace( dataRetrieval.lobbyInfo.LobbyPageItems.length );
			coinsDisplayAndBtn.label = String(dataRetrieval.lobbyInfo.CoinsTotal);
			countdownClass.startCountingFromDaysHoursMinsSecondsFormat( [dataRetrieval.lobbyInfo.DaysLeft,dataRetrieval.lobbyInfo.HoursLeft,dataRetrieval.lobbyInfo.MinutesLeft,dataRetrieval.lobbyInfo.SecondsLeft], updateDaysHoursMinsSecondsDisplay);
			
			challengesList.dataProvider = new ListCollection(dataRetrieval.lobbyInfo.LobbyPageItems);
		}
				
		private function listChangedHandler(e : starling.events.Event):void
		{
			trace("list index changed");
			AppState.SELECTED_OPPONENT_ID = (challengesList.dataProvider.getItemAt(challengesList.selectedIndex).OpponentId);
			dispatchEvent(new starling.events.Event("onChallengerSelected"));
		}
		
		private function getGoBtnTextRenderer():ITextRenderer
		{
			var goLabel:TextFieldTextRenderer = new TextFieldTextRenderer();
			
			goLabel.textFormat = textFormatGoBtn;
			goLabel.embedFonts = true;
			
			return goLabel;
		}
		
		private function getCoinsTextRenderer():ITextRenderer
		{
			var goLabel:TextFieldTextRenderer = new TextFieldTextRenderer();
			
			goLabel.textFormat = textFormatGoBtn;
			goLabel.textFormat.size = 15;
			goLabel.textFormat.font = "HelveticaNeueCondensed";
			goLabel.embedFonts = true;
			
			return goLabel;
		}
		
	}

}