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
	import starling.events.*;
	
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
			
	import view.util.*; 
	 
	public class HeadToHeadScreen extends Screen
	{
		
		private var logoBackground:Image;
		private var navBarShadow:Image;
		private var headToHeadTextTitle:TextFieldTextRenderer;
		private var backBtn:Button;		
		private var coinsDisplayAndBtn:Button;
		
		private var headToHeadBackground:Image;
		private var myProfilePic:Image;
		private var opponentProfilePic:Image;
		private var vsImage:Image;
		private var myName:TextFieldTextRenderer;
		private var opponentName:TextFieldTextRenderer;
		
		private var scoreStrip:Image;
		private var myPointsTextField:TextFieldTextRenderer;
		private var opponentPointsTextField:TextFieldTextRenderer;
		private var timeRecurrence:TextFieldTextRenderer;
		private var scoreStripHeadToHead:TextFieldTextRenderer;
		
		private var startNewGameButton:Button;
	
		private var mathcesList:List;
		
		private var textFormatTitle:TextFormat;
		private var textFormatGoBtn:TextFormat;
		private var myNameTextFormat:TextFormat;
		private var opponentNameTextFormat:TextFormat;
		
		private var weeklyText:TextFieldTextRenderer;
		private var headToHeadText:TextFieldTextRenderer;
		//onChallengerSelected
		
		public function HeadToHeadScreen() 
		{
			
		}
		
		override protected function initialize():void
		{
			
			logoBackground = new Image( Assets.getAssetsTexture("nav_bar") );
			addChild(logoBackground);
			backBtn = new Button();
			backBtn.defaultSkin = new Image( Assets.getAssetsTexture("back_arrow") );
			backBtn.downSkin = new Image( Assets.getAssetsTexture("back_arrow_press") );
			addChild(backBtn);
			
			headToHeadTextTitle = new TextFieldTextRenderer();
			addChild(headToHeadTextTitle);
			headToHeadTextTitle.text = "Head to Head";
			headToHeadTextTitle.textFormat = FontFactory.getTextFormat(0,18,0xFFFFFF);
			headToHeadTextTitle.embedFonts = true;
			headToHeadTextTitle.validate();
					
			headToHeadBackground = new Image( Assets.getAssetsTexture("h2h_bg") );
			addChild(headToHeadBackground);
			vsImage = new Image( Assets.getAssetsTexture("vs") );
			addChild(vsImage);
			myProfilePic = new Image(Assets.getAssetsTexture("profilePic"));
			addChild(myProfilePic);
			opponentProfilePic = new Image(Assets.getAssetsTexture("profilePic"));
			addChild(opponentProfilePic);
			myName = new TextFieldTextRenderer();
			myName.textFormat = FontFactory.getTextFormat(0,13,0xE6E6E6);
			myName.embedFonts = true;
			myName.maxWidth = 100;
			addChild(myName);
			myName.validate();
			opponentName = new TextFieldTextRenderer();
			opponentName.textFormat = FontFactory.getTextFormat(0,13,0xE6E6E6);
			opponentName.textFormat.align = "right";
			opponentName.width = 100;
			opponentName.embedFonts = true;
			addChild(opponentName);
			opponentName.maxWidth = 100;
			opponentName.validate();
			
			scoreStrip = new Image( Assets.getAssetsTexture("score_strip") );
			addChild(scoreStrip);
			myPointsTextField = new TextFieldTextRenderer();
			myPointsTextField.width = 50;
			opponentPointsTextField = new TextFieldTextRenderer();
			opponentPointsTextField.width = 50;
			
			weeklyText = new TextFieldTextRenderer();
			addChild(weeklyText);
			weeklyText.text = "WEEKLY";
			weeklyText.textFormat = FontFactory.getTextFormat(2,11,0xE6E6E6);
			weeklyText.textFormat.align = "center";
			weeklyText.embedFonts = true;
			weeklyText.wordWrap = true;
						
			headToHeadText = new TextFieldTextRenderer();
			addChild(headToHeadText);
			headToHeadText.text = "HEAD TO HEAD";
			headToHeadText.textFormat = FontFactory.getTextFormat(2,14,0xE6E6E6);;
			headToHeadText.textFormat.align = "center";
			headToHeadText.embedFonts = true;
			headToHeadText.wordWrap = true;						
			
			startNewGameButton = CommonAssetsScreen.getInstance().getStartNewGameButton();
			addChild(startNewGameButton);
			
			mathcesList = new List();
			mathcesList.itemRendererType = CustomHeadToHeadRenderer;
			addChild(mathcesList);
			
			
			coinsDisplayAndBtn = new Button();
			coinsDisplayAndBtn.defaultSkin = new Image(Assets.getAssetsTexture("coins_hud"));
			coinsDisplayAndBtn.downSkin    = new Image(Assets.getAssetsTexture("coins_hud_press"));
			coinsDisplayAndBtn.label = "XXXX";
			coinsDisplayAndBtn.labelOffsetY = 7;
			coinsDisplayAndBtn.labelFactory = getCoinsTextRenderer;
			addChild(coinsDisplayAndBtn);
			coinsDisplayAndBtn.y = -4;
			coinsDisplayAndBtn.x = headToHeadBackground.width - coinsDisplayAndBtn.defaultSkin.width;
		}
		
		override protected function draw():void
		{
			headToHeadTextTitle.x = (logoBackground.width - headToHeadTextTitle.width)/2;
			headToHeadTextTitle.y = 10;
			backBtn.x = logoBackground.x + 5;
			backBtn.y = logoBackground.y + 2.5;
			backBtn.addEventListener(Event.TRIGGERED, backTriggeredHandler);
			
			headToHeadBackground.y = logoBackground.y + logoBackground.height;
			vsImage.x = headToHeadBackground.width - vsImage.width >> 1;
			
			myProfilePic.height = headToHeadBackground.height * 0.56;
			myProfilePic.scaleX = myProfilePic.scaleY;
			myProfilePic.x = headToHeadBackground.x + 15;
			myProfilePic.y = headToHeadBackground.y + headToHeadBackground.height - myProfilePic.height - 5; 
			
			opponentProfilePic.height = headToHeadBackground.height * 0.56;
			opponentProfilePic.scaleX = opponentProfilePic.scaleY;
			opponentProfilePic.x = headToHeadBackground.width - opponentProfilePic.width - 15;
			opponentProfilePic.y = myProfilePic.y;//headToHeadBackground.y + headToHeadBackground.height - opponentProfilePic.height - 5; 
						
			vsImage.y = myProfilePic.y;
			
			myName.x = myProfilePic.x;
			myName.y = headToHeadBackground.y + 5;
			myName.text = "XXXXXX";
			
			trace(opponentName.maxWidth + " op width");
			opponentName.x = headToHeadBackground.width - opponentName.maxWidth-15;
			opponentName.y = headToHeadBackground.y + 5;
			opponentName.text = "YYYYYY";
			
			scoreStrip.y = headToHeadBackground.y + headToHeadBackground.height;
			
			weeklyText.y = scoreStrip.y;		
			weeklyText.width = stage.stageWidth;
			
			headToHeadText.y = 123;
			headToHeadText.width = stage.stageWidth;
			
			myPointsTextField.x = myProfilePic.x + 6;
			myPointsTextField.y = scoreStrip.y + 5;
			myPointsTextField.text = "999";
			myPointsTextField.textFormat = myNameTextFormat;
			myPointsTextField.embedFonts = true;
			addChild(myPointsTextField);
			
			opponentPointsTextField.x = opponentProfilePic.x + 6; 
			opponentPointsTextField.y = myPointsTextField.y;
			opponentPointsTextField.text = "111";
			opponentPointsTextField.textFormat = myNameTextFormat;
			opponentPointsTextField.embedFonts = true;
			addChild(opponentPointsTextField);
			
			
			startNewGameButton.y = scoreStrip.y + scoreStrip.height;
			
			mathcesList.y = startNewGameButton.y + startNewGameButton.defaultSkin.height;
			mathcesList.width = this.actualWidth;
			mathcesList.height = this.actualHeight - (logoBackground.height + headToHeadBackground.height + vsImage.height + startNewGameButton.defaultSkin.height);
			
			
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
			]);
			
			mathcesList.dataProvider = groceryList;
		}
		
		private function backTriggeredHandler(e:Event)
		{
			dispatchEvent(new starling.events.Event("onBack"));
		}
		
		private function getGoBtnTextRenderer():ITextRenderer
		{
			var goLabel:TextFieldTextRenderer = new TextFieldTextRenderer();
			goLabel.width = 280;
			goLabel.textFormat = FontFactory.getTextFormat(0,20,0xFFFFFF);
			goLabel.embedFonts = true;
			
			return goLabel;
		}
		
		private function getCoinsTextRenderer():ITextRenderer
		{
			var goLabel:TextFieldTextRenderer = new TextFieldTextRenderer();
			
			goLabel.textFormat = FontFactory.getTextFormat(0, 15, 0xFFFFFF);
			goLabel.embedFonts = true;
			return goLabel;
		}
		
	}

}