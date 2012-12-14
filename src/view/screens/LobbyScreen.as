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
	 
	public class LobbyScreen extends Screen
	{
		
		[Embed(source="../../assets/fonts/HelveticaNeueLTCom-BdCn.ttf", embedAsCFF="false", fontName="HelveticaNeueLTCom-BdCn", advancedAntiAliasing="true", mimeType = "application/x-font")]
		private static const helveticaNeue:Class;
		
		private var smallLogo:Image;
		private var logoBackground:Image;
		private var navBarShadow:Image;
		private var menuBtn:Button;
		
		/*
		private var coinIcon:Image;
		private var coinsBackground:Image;
		private var coinsCountTextFormat:TextFormat;
		private var coinsCountText:TextFieldTextRenderer;
		private var plusCoinsButton:Button;
		*/
		
		private var timerBackground:Image;
		private var timerInfoTextFormat:TextFormat;
		private var actualTimerTextFormat:TextFormat;
		private var textFormatGoBtn:TextFormat;
		
		private var tournamentEndsInTextField:TextFieldTextRenderer;
		private var daysTextField:TextFieldTextRenderer;
		private var hoursTextField:TextFieldTextRenderer;
		private var minsTextField:TextFieldTextRenderer;
		private var secsTextField:TextFieldTextRenderer;
		
		private var startNewGameButton:Button;
	
		private var challengesList:List;
		
		private static const EVENTS:Vector.<String> = new <String>
		[
		 "onChallengerSelected",
		];
		
		public function LobbyScreen() 
		{
			
		}
		
		override protected function initialize():void
		{
			// header
			//coinsCountTextFormat = new TextFormat("HelveticaNeueLTCom-BdCn", 16, 0xFFFFFF);
			textFormatGoBtn = new TextFormat("HelveticaNeueLTCom-BdCn", 18, 0xFFFFFF);
			
			logoBackground = new Image( Assets.getAssetsTexture("nav_bar") );
			addChild(logoBackground);
					
			smallLogo = new Image(Assets.getAssetsTexture("logo_small"));
			addChild(smallLogo);
			
			menuBtn = new Button();
			menuBtn.defaultSkin         = new Image(Assets.getAssetsTexture("menu_icon"));
			menuBtn.downSkin = new Image(Assets.getAssetsTexture("menu_icon_press"));
			addChild(menuBtn);
			
			/*
			coinsBackground = new Image(Assets.getAssetsTexture("coins_bg"));
			addChild(coinsBackground);
			
			coinIcon =  new Image(Assets.getAssetsTexture("coin"));
			addChild(coinIcon);
			
			coinsCountText = new TextFieldTextRenderer();
			coinsCountText.text = "123";
			coinsCountText.textFormat = coinsCountTextFormat;
			coinsCountText.embedFonts = true;
			addChild(coinsCountText);
			
			plusCoinsButton = new Button();
			plusCoinsButton.defaultSkin = new Image(Assets.getAssetsTexture("add_coins"));
			plusCoinsButton.downSkin    = new Image(Assets.getAssetsTexture("add_coins_press"));
			addChild(plusCoinsButton);
			*/
			
			//countdown
			timerBackground = new Image( Assets.getAssetsTexture("timer_bg") );
			addChild(timerBackground);
			
			startNewGameButton = new Button();
			startNewGameButton.defaultSkin = new Image( Assets.getAssetsTexture("start_btn") );
			startNewGameButton.downSkin    = new Image( Assets.getAssetsTexture("start_btn_press") );
			addChild(startNewGameButton);
			startNewGameButton.label = "Start a new game";
			startNewGameButton.labelFactory = getGoBtnTextRenderer;
			
			challengesList = new List();
			challengesList.itemRendererType = CustomLobbyItemRenderer;
			addChild(challengesList);
			challengesList.addEventListener(Event.CHANGE, listChangedHandler);
			
			//challengesList.itemRendererProperties.labelField = "text";
			//challengesList.itemRendererProperties.iconTextureField = "thumbnail";			
		}
		
		override protected function draw():void
		{
			smallLogo.x = (this.actualWidth - smallLogo.width) / 2;
			
			timerBackground.y = logoBackground.y + logoBackground.height;
			
			startNewGameButton.y = timerBackground.y + timerBackground.height;
			
			
			challengesList.y = startNewGameButton.y + startNewGameButton.defaultSkin.height;
			challengesList.width = this.actualWidth;
			challengesList.height = this.actualHeight - (logoBackground.height + timerBackground.height + startNewGameButton.height);
			
			var groceryList:ListCollection = new ListCollection(
			[
				{ label: "Milk"},
				{ label: "Eggs" },
				{ label: "Bread"},
				{ label: "Chicken"},
				{ label: "Bread"},
				{ label: "Chicken"},
				{ label: "Bread"},
				{ label: "Chicken"},
				{ label: "Bread"},
				{ label: "Chicken"},
				{ label: "Bread"},
				{ label: "Chicken"},
				{ label: "Bread"},
				{ label: "Chicken"},
				{ label: "Bread"},
				{ label: "Chicken"},
				{ label: "Bread"},
				{ label: "Chicken"},
				{ label: "Bread"},
				{ label: "Chicken"},
				{ label: "Bread"},
				{ label: "Chicken"},
			]);
			
			challengesList.dataProvider = groceryList;
			// dummy data!!!
			//{isNewChallenge:"false" ,playerPicture:"", playerName:"", playerPoints:"", myPoints:"", noTicks:"",noCups:""}
			
		}
		
		private function listChangedHandler(e:Event):void
		{
			trace("list index changed");
		}
		
		private function getGoBtnTextRenderer():ITextRenderer
		{
			var goLabel:TextFieldTextRenderer = new TextFieldTextRenderer();
			
			goLabel.textFormat = textFormatGoBtn;
			goLabel.embedFonts = true;
			
			return goLabel;
		}
		
	}

}