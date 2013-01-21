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
	import view.util.CommonAssetsScreen;
	import view.util.FontFactory;
	
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
	
	import flash.utils.setTimeout;
	 
	public class LobbyScreen extends Screen
	{
		private var commonAssets:CommonAssetsScreen;
		
		private var smallLogo:Image;
		private var logoBackground:Image;
		private var navBarShadow:Image;
		private var menuBtn:Button;
		
		private var coinsDisplayAndBtn:Button;
		private var coinsTextFormat:TextFormat;
		
		private var timerBackground:Image;
		
		private var textFormat1:TextFormat;
		private var textFormat2:TextFormat;
		
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
			commonAssets = CommonAssetsScreen.getInstance();
			logoBackground = new Image( Assets.getAssetsTexture("nav_bar") );
			
			coinsDisplayAndBtn = new Button();
			coinsDisplayAndBtn.defaultSkin = new Image(Assets.getAssetsTexture("coins_hud"));
			coinsDisplayAndBtn.downSkin    = new Image(Assets.getAssetsTexture("coins_hud_press"));
			coinsDisplayAndBtn.label = "XXXXX";
			coinsDisplayAndBtn.labelOffsetY = 7;
			coinsDisplayAndBtn.labelFactory = getCoinsTextRenderer;
			
			menuBtn = new Button();
			days = new TextFieldTextRenderer();
			hours = new TextFieldTextRenderer();
			mins = new TextFieldTextRenderer();
			secs = new TextFieldTextRenderer();
			daysTextField = new TextFieldTextRenderer();
			hoursTextField = new TextFieldTextRenderer();
			minsTextField = new TextFieldTextRenderer();
			secsTextField = new TextFieldTextRenderer();
			startNewGameButton = new Button();
			
			textFormat1 = FontFactory.getTextFormat(2, 11, 0xE6E6E6);
			textFormat2 = FontFactory.getTextFormat(5, 44, 0xE24B37);
			
			challengesList = new List();
		}
		
		override protected function initialize():void
		{			
			
			addChild(logoBackground);
					
			addChild(coinsDisplayAndBtn);
			
			smallLogo = new Image(Assets.getAssetsTexture("logo_small"));
			addChild(smallLogo);
			
			menuBtn.defaultSkin = new Image(Assets.getAssetsTexture("menu_icon"));
			menuBtn.downSkin = new Image(Assets.getAssetsTexture("menu_icon_press"));
			addChild(menuBtn);
						
			//countdown
			timerBackground = new Image( Assets.getAssetsTexture("timer_bg") );
			addChild(timerBackground);
			
			tournamentEndsInTextField = new TextFieldTextRenderer();
			tournamentEndsInTextField.textFormat = FontFactory.getTextFormat(2,11,0xE6E6E6);
			tournamentEndsInTextField.embedFonts = true;
			addChild(tournamentEndsInTextField);
			tournamentEndsInTextField.text = "TOURNAMENT ENDS IN:";
			
			days.textFormat = textFormat1
			days.embedFonts = true;
			addChild(days);
			days.text = "DAYS";
			
			hours.textFormat = textFormat1;
			hours.embedFonts = true;
			addChild(hours);
			hours.text = "HOURS";
			
			mins.textFormat = textFormat1;
			mins.embedFonts = true;
			addChild(mins);
			mins.text = "MINS";
			
			secs.textFormat = textFormat1;
			secs.embedFonts = true;
			addChild(secs);
			secs.text = "SECS";
			
			daysTextField.textFormat = textFormat2;
			daysTextField.embedFonts = true;
			addChild(daysTextField);
						
			hoursTextField.textFormat = textFormat2;
			hoursTextField.embedFonts = true;
			addChild(hoursTextField);
			
			minsTextField.textFormat = textFormat2;
			minsTextField.embedFonts = true;
			addChild(minsTextField);
			
			secsTextField.textFormat = textFormat2;
			secsTextField.embedFonts = true;
			addChild(secsTextField);
			
			daysTextField.text = hoursTextField.text = minsTextField.text = secsTextField.text = "00";
				
			startNewGameButton = commonAssets.getStartNewGameButton();
			startNewGameButton.addEventListener(starling.events.Event.TRIGGERED, startNewGameHandler);
			addChild(startNewGameButton);
		}
		
		private function startNewGameHandler(e:starling.events.Event):void
		{
			dispatchEvent(new starling.events.Event("onPushStart"));
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
			
			//data
			countdownClass = CountdownClass.getInstance();
			dataRetrieval = DataRetrieval.getInstance();
			dataRetrieval.addEventListener(DataRetrieval.LOBBY_DATA_RECEIVED, lobbyDataReceivedHandler);
			
			//debug countdown
			setTimeout(setCountdown, 300);		
			//list
			setTimeout(setList, 400);			
			
			//dataRetrieval.requestLobbyData( AppState.MY_USER_ID );
		}
		
		private function setCountdown()
		{
			countdownClass.startCountingFromDaysHoursMinsSecondsFormat( [1,2,43,23], updateDaysHoursMinsSecondsDisplay);
		}
				
		private function setList()
		{
			challengesList.itemRendererType = CustomLobbyItemRenderer;
			challengesList.y = startNewGameButton.y + startNewGameButton.defaultSkin.height;
			challengesList.width = this.actualWidth;
			challengesList.height = this.actualHeight - (logoBackground.height + timerBackground.height + startNewGameButton.defaultSkin.height);
			addChild(challengesList);
			
			challengesList.addEventListener(starling.events.Event.CHANGE, listChangedHandler);
			// dummy data!!!
			//{isNewChallenge:"false" ,playerPicture:"", playerName:"", playerPoints:"", myPoints:"", noTicks:"",noCups:""}		
			challengesList.dataProvider = new ListCollection(
			[
				{ text: "Milk" },
				{ text: "Eggs"},
				{ text: "Bread"},
				{ text: "Chicken"},
			]);
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
				
		private function getCoinsTextRenderer():ITextRenderer
		{
			var goLabel:TextFieldTextRenderer = new TextFieldTextRenderer();
			
			goLabel.textFormat = FontFactory.getTextFormat(0, 15, 0xFFFFFF);
			goLabel.embedFonts = true;
			
			return goLabel;
		}
		
		override protected function screen_removedFromStageHandler(event:starling.events.Event):void
		{
			super.screen_removedFromStageHandler(event);
		}
		
	}

}