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
	 
	public class HeadToHeadScreen extends Screen
	{
		
		[Embed(source="../../assets/fonts/HelveticaNeueLTCom-BdCn.ttf", embedAsCFF="false", fontName="HelveticaNeueLTCom-BdCn", advancedAntiAliasing="true", mimeType = "application/x-font")]
		private static const helveticaNeueBold:Class;
		
		[Embed(source="../../assets/fonts/HelveticaNeueLTCom-Cn.ttf", embedAsCFF="false", fontName="HelveticaNeueLT", advancedAntiAliasing="true", mimeType = "application/x-font")]
		private static const helveticaNeue:Class;
		
		private var logoBackground:Image;
		private var navBarShadow:Image;
		private var headToHeadText:TextFieldTextRenderer;
		private var backBtn:Button;
		
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
		
		//onChallengerSelected
		
		public function HeadToHeadScreen() 
		{
			
		}
		
		override protected function initialize():void
		{
			textFormatGoBtn = new TextFormat("HelveticaNeueLTCom-BdCn", 18, 0xFFFFFF);
			textFormatTitle = new TextFormat("HelveticaNeueLT", 20, 0xFFFFFF);
			myNameTextFormat = new TextFormat("HelveticaNeueLT", 12, 0xE6E6E6);
			opponentNameTextFormat = new TextFormat("HelveticaNeueLT", 12, 0xE6E6E6); 
			opponentNameTextFormat.align = "right";
			
			logoBackground = new Image( Assets.getAssetsTexture("nav_bar") );
			addChild(logoBackground);
			backBtn = new Button();
			backBtn.defaultSkin = new Image( Assets.getAssetsTexture("back_arrow") );
			backBtn.downSkin = new Image( Assets.getAssetsTexture("back_arrow_press") );
			addChild(backBtn);
			
			headToHeadText = new TextFieldTextRenderer();
			addChild(headToHeadText);
			headToHeadText.text = "Head to Head";
			headToHeadText.textFormat = textFormatTitle;
			headToHeadText.embedFonts = true;
			headToHeadText.validate();
			
			headToHeadBackground = new Image( Assets.getAssetsTexture("h2h_bg") );
			addChild(headToHeadBackground);
			vsImage = new Image( Assets.getAssetsTexture("vs") );
			addChild(vsImage);
			myProfilePic = new Image(Assets.getAssetsTexture("profilePic"));
			addChild(myProfilePic);
			opponentProfilePic = new Image(Assets.getAssetsTexture("profilePic"));
			addChild(opponentProfilePic);
			myName = new TextFieldTextRenderer();
			myName.textFormat = myNameTextFormat;
			myName.embedFonts = true;
			myName.maxWidth = 100;
			addChild(myName);
			myName.validate();
			opponentName = new TextFieldTextRenderer();
			opponentName.textFormat = opponentNameTextFormat;
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
			
			startNewGameButton = new Button();
			startNewGameButton.defaultSkin = new Image( Assets.getAssetsTexture("start_btn") );
			startNewGameButton.downSkin    = new Image( Assets.getAssetsTexture("start_btn_press") );
			addChild(startNewGameButton);
			startNewGameButton.label = "Start a new game";
			startNewGameButton.labelFactory = getGoBtnTextRenderer;
			
			mathcesList = new List();
			mathcesList.itemRendererType = CustomHeadToHeadRenderer;
			addChild(mathcesList);
		}
		
		override protected function draw():void
		{
			headToHeadText.x = (logoBackground.width - headToHeadText.width)/2;
			headToHeadText.y = 10;
			backBtn.x = logoBackground.x + 5;
			backBtn.y = logoBackground.y + 2.5;
			
			headToHeadBackground.y = logoBackground.y + logoBackground.height;
			vsImage.x = headToHeadBackground.width - vsImage.width >> 1;
			vsImage.y = headToHeadBackground.y + (headToHeadBackground.height - vsImage.height) / 2;
			
			myProfilePic.height = headToHeadBackground.height * 0.56;
			myProfilePic.scaleX = myProfilePic.scaleY;
			myProfilePic.x = headToHeadBackground.x + 15;
			myProfilePic.y = headToHeadBackground.y + headToHeadBackground.height - myProfilePic.height - 5; 
			
			opponentProfilePic.height = headToHeadBackground.height * 0.56;
			opponentProfilePic.scaleX = opponentProfilePic.scaleY;
			opponentProfilePic.x = headToHeadBackground.width - opponentProfilePic.width - 15;
			opponentProfilePic.y = myProfilePic.y;//headToHeadBackground.y + headToHeadBackground.height - opponentProfilePic.height - 5; 
			
			myName.x = myProfilePic.x;
			myName.y = headToHeadBackground.y + 5;
			myName.text = "XXXXXX";
			
			trace(opponentName.maxWidth + " op width");
			opponentName.x = headToHeadBackground.width - opponentName.maxWidth-15;
			opponentName.y = headToHeadBackground.y + 5;
			opponentName.text = "YYYYYY";
			
			scoreStrip.y = headToHeadBackground.y + headToHeadBackground.height;
			
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
			mathcesList.height = this.actualHeight - (logoBackground.height + headToHeadBackground.height + vsImage.height + startNewGameButton.height);
			
			
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
			
			mathcesList.dataProvider = groceryList;
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