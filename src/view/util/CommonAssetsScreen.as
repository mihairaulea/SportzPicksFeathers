package view.util 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	 
	import feathers.controls.ImageLoader;
	import feathers.controls.Screen;
	import feathers.core.ITextRenderer;
	import feathers.display.Scale3Image;
	//import feathers.display.Image;
	import flash.text.TextRenderer;
	import starling.events.Event;
	import starling.events.TouchEvent;
	
	import feathers.controls.Screen;
	//import feathers.controls.ScreenHeader;
	import feathers.controls.Button;
	import feathers.controls.text.*;
	import feathers.controls.*;
	import feathers.system.DeviceCapabilities;
	import feathers.core.*;
	
	import flash.text.TextFormat;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
			
	import view.util.Assets;
	import view.util.DeviceConstants;
	
	public class CommonAssetsScreen 
	{
		// HEADER
		private var logoBackground:Image;
		private var navBarShadow:Image;
		private var headerTitle:TextFieldTextRenderer;		
		private var textFormatTitle:TextFormat;
		private var backBtn:Button;
		private var backCallback:Function;
		
		private var coinsDisplay:Image;
		private var coinIcon:Image;
		private var coinsText:TextFieldTextRenderer;
		
		// START NEW GAME BUTTON
		
		// GO BTN
		private var goBtn:Button;
		private static var goBtnInit:Boolean = false;
		
		// INPUT
		private var inputField:TextInput;
		private static var inputFieldInit:Boolean = false;
				
		
		public static var instance:CommonAssetsScreen;
		private static var allowInstantiation:Boolean = false;
		
		public function CommonAssetsScreen() 
		{
			if (allowInstantiation == true)
			{
			
				textFormatTitle = FontFactory.getTextFormat(0, 18, 0xFFFFFF);
				textFormatTitle.align = "center";
				
				goBtn = new Button();
			}
		}
		
		public static function getInstance():CommonAssetsScreen
		{
			if (instance == null)
			{
				allowInstantiation = true;
				instance = new CommonAssetsScreen();
				allowInstantiation = false;
			}
			return instance;
		}
		
		public function getHeader(title:String, includeBackBtn:Boolean, backCallback:Function, includeCoins:Boolean, coinsCallback:Function = null):Sprite
		{
			var header:Sprite = new Sprite();
			var coinHud:Sprite = new Sprite();
			logoBackground = new Image( Assets.getAssetsTexture("nav_bar") );
			
				backBtn = new Button();
				backBtn.defaultSkin = new Image( Assets.getAssetsTexture("back_arrow") );
				backBtn.downSkin = new Image( Assets.getAssetsTexture("back_arrow_press") );
				
			header.addChild(logoBackground);
			headerTitle = new TextFieldTextRenderer();
			headerTitle.text = title;
			headerTitle.width = logoBackground.width;
			headerTitle.textFormat = textFormatTitle;
			headerTitle.embedFonts = true;
			headerTitle.validate();			
			headerTitle.x = (logoBackground.width - headerTitle.width)/2;
			headerTitle.y = 10;
			
			header.addChild(headerTitle);
			
			if (includeCoins)
			{
				coinsDisplay = new Image(Assets.getAssetsTexture("coins_bg_small"));
				coinIcon = new Image(Assets.getAssetsTexture("coin"));
				coinIcon.x = 2;
				coinIcon.y = 2;
				
				coinsText = getCoinsTextRenderer();
				coinsText.text = "999";
				coinsText.x = 25;
				coinsText.y = 2;
				
				
				coinHud.addChild(coinsDisplay);
				coinHud.addChild(coinIcon);
				coinHud.addChild(coinsText);
				
				header.addChild(coinHud);
				coinHud.x = 256.5;
				coinHud.y = 8.5;				
			}
			
			if (backCallback != null) 
			{
				backBtn.addEventListener( Event.TRIGGERED, backHandler );
				this.backCallback = backCallback;
			}
			if(includeBackBtn) header.addChild(backBtn);
			
			return header;
		}
		
		private function backHandler(e:Event)
		{
			backCallback.call(); 
		}
		
		public function getStartNewGameButton():Button
		{
			var startNewGameButton:Button;
			
			startNewGameButton = new Button();
			startNewGameButton.defaultSkin = new Image( Assets.getAssetsTexture("start_btn") );
			startNewGameButton.downSkin    = new Image( Assets.getAssetsTexture("start_btn_press") );
			startNewGameButton.label = "Start a new game";
			startNewGameButton.labelOffsetX = 49;
			startNewGameButton.labelFactory = getStartTextRenderer;		
			
			return startNewGameButton;
		}
		
		private function getStartTextRenderer():ITextRenderer
		{
			var goLabel:TextFieldTextRenderer = new TextFieldTextRenderer();
			goLabel.width = 280;
			goLabel.textFormat = FontFactory.getTextFormat(0, 20,0xFFFFFF);
			goLabel.embedFonts = true;
			
			return goLabel;
		}
		
		private function getCoinsTextRenderer():TextFieldTextRenderer
		{
			var goLabel:TextFieldTextRenderer = new TextFieldTextRenderer();
			
			goLabel.textFormat = FontFactory.getTextFormat(2, 16, 0xFFFFFF);
			goLabel.embedFonts = true;
			
			return goLabel;
		}
		
		public function getGoBtn(label:String, goCallback:Function):Button
		{
			if (goBtnInit == false)
			{
				goBtn.defaultSkin = new Image( Assets.getAssetsTexture("go_btn"));
				goBtn.downSkin = new Image( Assets.getAssetsTexture("go_btn_press"));
				goBtn.label = label;
				goBtn.labelOffsetY = -2;
				goBtn.labelFactory = getGoBtnTextRenderer;
				goBtn.validate();
				goBtn.addEventListener( Event.TRIGGERED, goCallback );
				goBtnInit = true;
			}
			
			return goBtn;
		}
		
		public function getInputField(defaultText:String, paddingLeft:int, paddingTop:int, eraseAllOnFocus:Boolean):TextInput
		{
			if (inputFieldInit == false)
			{
				inputField = new TextInput();
				var inputBackImage2:Image = new Image(Assets.getAssetsTexture("form_field"));
			
				inputField.backgroundSkin = inputBackImage2;
				inputField.textEditorFactory = getTextInputField;
				inputField.paddingLeft = paddingLeft;
				inputField.paddingTop = paddingTop;
				inputField.text = defaultText;
				inputField.validate();		
				inputFieldInit = true;
			}
			
			if (eraseAllOnFocus)
				inputField.addEventListener("focusIn", inputFocusHandler);
			else
				inputField.removeEventListener("focusIn", inputFocusHandler);
				
			return inputField;
		}
			
		public function getPopularEventButton(id:int,day:String, time:String, team1:String, team2:String,callback:Function):Button
		{
			var result:Button= new Button();
			
			result.defaultSkin = new Image(Assets.getAssetsTexture("pop_event_btn1"));
			result.downSkin    = new Image(Assets.getAssetsTexture("pop_event_btn1_press"));
				
			result.width = result.defaultSkin.width;
			result.height = result.defaultSkin.height;
			
			var dayTimeText:TextFieldTextRenderer = new TextFieldTextRenderer();
			var team1Team2Text:TextFieldTextRenderer = new TextFieldTextRenderer();
			
			dayTimeText.text = day + "\n" + time;
			dayTimeText.width = 80;
			dayTimeText.height = 41;
			dayTimeText.x = 9;
			dayTimeText.y = 11;
			dayTimeText.textFormat = FontFactory.getTextFormat(2, 15, 0x808080);
			dayTimeText.embedFonts = true;
			
			team1Team2Text.text = team1 + "\n" + team2;
			team1Team2Text.width = 150;
			team1Team2Text.height = 41;
			team1Team2Text.x = 100;
			team1Team2Text.y = 10;
			team1Team2Text.textFormat = FontFactory.getTextFormat(1, 15, 0x4d4d4d);
			team1Team2Text.embedFonts = true;
			
			result.label = "";
			result.addChild(dayTimeText);
			result.addChild(team1Team2Text);
			
			result.addEventListener(Event.TRIGGERED, function (e:Event) {
				callback.call(this,id);
			}
			);
			
			var icon:Image = new Image( Assets.getAssetsTexture("h2h_soccer_icon"));
			result.addChild(icon);
			icon.x = 58;
			icon.y = 12.5;
			
			return result;
		}
		
		private function getTextInputField():ITextEditor
		{
			var label:TextFieldTextEditor = new TextFieldTextEditor();
			
			label.textFormat = FontFactory.getTextFormat(0,15,0xB3B3B3);
			label.embedFonts = true;
			
			return label;
		}
		
		private function inputFocusHandler(e:Event):void
		{
			inputField.text = "";
		}
		
		private function getGoBtnTextRenderer():ITextRenderer
		{
			var goLabel:TextFieldTextRenderer = new TextFieldTextRenderer();
			
			goLabel.textFormat = FontFactory.getTextFormat(0, 20, 0xFFFFFF);
			goLabel.embedFonts = true;
			
			return goLabel;
		}
		
		public function getSportButton(sportIcon:Image, sportText:String):Button
		{
			var result:Button = new Button();
			
			result.defaultSkin = new Image(Assets.getAssetsTexture("sport_select_top_right"));
			result.downSkin = new Image(Assets.getAssetsTexture("sport_select_top_right_press"));
			result.label = "";
			
			var sportTextRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			sportTextRenderer.textFormat = FontFactory.getTextFormat(0, 17, 0x4d4d4d);
			sportTextRenderer.textFormat.align = "center";
			sportTextRenderer.embedFonts = true;
			sportTextRenderer.width = 150;
			sportTextRenderer.height = 21.5;
			sportTextRenderer.text = sportText;
			sportTextRenderer.y = 69.25;
			
			result.addChild( sportTextRenderer );
			sportIcon.x = 92/2;
			sportIcon.y = 49/2;
			result.addChild( sportIcon );
			
			return result;
		}
		
	}

}