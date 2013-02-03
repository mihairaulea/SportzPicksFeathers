package view.util 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	
	import flash.geom.Point;
	import flash.text.engine.*;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
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
	
	import feathers.controls.renderers.PredictionListRenderer;
	
	import model.PredictionConfirmVA;
	import model.AnswerVA;
	
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
						
			if (includeBackBtn) 
			{
				header.addChild(backBtn);
				backBtn.addEventListener( Event.TRIGGERED, backHandler );
				this.backCallback = backCallback;
			}
			
			return header;
		}
		
		public function refreshBackCallback(backCallback:Function)
		{
			this.backCallback = backCallback;
		}
		
		private function backHandler(e:Event)
		{
			trace("calling back from common assets screen");
			backCallback.call(); 
		}
		
		
		public function getVsHeader():Sprite
		{
			var vsHeader:Sprite = new Sprite();
			
			var headToHeadBackground:Image;
			var myProfilePic:Image;
			var opponentProfilePic:Image;
			var vsImage:Image;
			var myName:TextFieldTextRenderer;
			var opponentName:TextFieldTextRenderer;
			
			headToHeadBackground = new Image( Assets.getAssetsTexture("h2h_bg") );
			vsHeader.addChild(headToHeadBackground);
			
			vsImage = new Image( Assets.getAssetsTexture("vs") );
			vsHeader.addChild(vsImage);
			vsImage.x = 145;
			vsImage.y = 20;
			
			myProfilePic = new Image(Assets.getAssetsTexture("profilePic"));	
			myProfilePic.x = 20;
			myProfilePic.y = 20;
			myProfilePic.width = 45;
			myProfilePic.height = 45;
			vsHeader.addChild(myProfilePic);
			
			opponentProfilePic = new Image(Assets.getAssetsTexture("profilePic"));
			opponentProfilePic.x = 255;
			opponentProfilePic.y = 20;
			opponentProfilePic.width = 45;
			opponentProfilePic.height = 45;
			vsHeader.addChild(opponentProfilePic);
			
			myName = new TextFieldTextRenderer();
			myName.textFormat = FontFactory.getTextFormat(0,13,0xE6E6E6);
			myName.embedFonts = true;
			myName.x = 20;
			myName.maxWidth = 105;
			vsHeader.addChild(myName);
			myName.text = "XXXXXX";
			
			opponentName = new TextFieldTextRenderer();
			opponentName.textFormat = FontFactory.getTextFormat(0,13,0xE6E6E6);
			opponentName.textFormat.align = "right";
			opponentName.embedFonts = true;
			opponentName.width = 105;
			opponentName.x = 195;
			opponentName.text = "YYYYYY";
			vsHeader.addChild(opponentName);
			
			return vsHeader;			
		}
		
		public function getScoreStrip(smallText:String, largeText:String, points1Text:String, points2Text:String):Sprite
		{
			var scoreStrip:Sprite = new Sprite();
			
			var backgroundImage:Quad = new Quad(320, 33, 0x000000);
			scoreStrip.addChild(backgroundImage);
			
			var smallTextRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			smallTextRenderer.width = 181;
			smallTextRenderer.height = 12.5;
			smallTextRenderer.x = 66;
			smallTextRenderer.y = 4;
			smallTextRenderer.textFormat = FontFactory.getTextFormat(6,11,0xE6E6E6);;
			smallTextRenderer.textFormat.align = "center";
			smallTextRenderer.embedFonts = true;
			scoreStrip.addChild(smallTextRenderer);
			smallTextRenderer.text = smallText;
			
			var largeTextRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			largeTextRenderer.width = 181;
			largeTextRenderer.height = 12.5;
			largeTextRenderer.x = 66;
			largeTextRenderer.y = 14;
			largeTextRenderer.textFormat = FontFactory.getTextFormat(6,13,0xE6E6E6);
			largeTextRenderer.textFormat.align = "center";
			largeTextRenderer.embedFonts = true;
			scoreStrip.addChild(largeTextRenderer);
			largeTextRenderer.text = largeText;
			
			var points1:TextFieldTextRenderer = new TextFieldTextRenderer();
			points1.width = 55;
			points1.height = 20;
			points1.x = 15;
			points1.y = 4.4;
			points1.textFormat = FontFactory.getTextFormat(1,20,0xE6E6E6);
			points1.textFormat.align = "center";
			points1.embedFonts = true;
			scoreStrip.addChild(points1);
			points1.text = points1Text;
			
			var points2:TextFieldTextRenderer = new TextFieldTextRenderer();
			points2.width = 55;
			points2.height = 20;
			points2.x = 250;
			points2.y = 4.4;
			points2.textFormat = FontFactory.getTextFormat(1,20,0xE6E6E6);
			points2.textFormat.align = "center";
			points2.embedFonts = true;
			scoreStrip.addChild(points2);
			points2.text = points2Text;
			
			return scoreStrip;			
		}
		
		public function getChallengeSentPanel(challengeSentString:String,plusSign:String,amountPoints:String):Sprite
		{
			var challengeSent:Sprite = new Sprite();
			
			var backgroundPanel:Image = new Image( Assets.getAssetsTexture("chal_sent_panel", 2));
			challengeSent.addChild(backgroundPanel);
			
			var challengeSentText:TextFieldTextRenderer = new TextFieldTextRenderer();
			challengeSentText.width = 300;
			challengeSentText.height = 20;
			challengeSentText.x = 0;
			challengeSentText.y = 61.5;
			challengeSentText.textFormat = FontFactory.getTextFormat(1,18,0x4D4D4D);
			challengeSentText.textFormat.align = "center";
			challengeSentText.embedFonts = true;
			challengeSent.addChild(challengeSentText);
			challengeSentText.text = challengeSentString;
			
			
			var plusTextField:TextFieldTextRenderer = new TextFieldTextRenderer();
			plusTextField.width = 22;
			plusTextField.height = 19;
			plusTextField.x = 122.5;
			plusTextField.y = 102;
			plusTextField.textFormat = FontFactory.getTextFormat(1,20,0x4D4D4D);
			plusTextField.textFormat.align = "center";
			plusTextField.embedFonts = true;
			challengeSent.addChild(plusTextField);
			plusTextField.text = plusSign;
			
			var pointsTextField:TextFieldTextRenderer = new TextFieldTextRenderer();
			pointsTextField.width = 33;
			pointsTextField.height = 19;
			pointsTextField.x = 154;
			pointsTextField.y = 104;
			pointsTextField.textFormat = FontFactory.getTextFormat(1,20,0x4D4D4D);
			pointsTextField.textFormat.align = "center";
			pointsTextField.embedFonts = true;
			challengeSent.addChild(pointsTextField);
			pointsTextField.text = amountPoints;
			
			return challengeSent;
		}
		
		public function getMiniTitle():Sprite
		{
			var miniTitle:Sprite = new Sprite();
			
			var backgroundSmall:Quad;
			var miniSportIcon:Image;
			var eventName:TextFieldTextRenderer;
			
			backgroundSmall = new Quad(320, 20, 0x000000);
			miniTitle.addChild(backgroundSmall);
			
			miniSportIcon = new Image(Assets.getAssetsTexture("h2h_soccer_icon"));
			miniTitle.addChild(miniSportIcon);
			miniSportIcon.x = 75;
			miniSportIcon.y = 2;
			miniSportIcon.width = 16;
			miniSportIcon.height = 13.5;
			
			eventName = new TextFieldTextRenderer();
			eventName.width = 254;
			eventName.height = 16;
			eventName.x = 44;
			eventName.y = 0;
			eventName.textFormat = FontFactory.getTextFormat(4,12,0xC6C4C4);
			eventName.textFormat.align = "center";
			eventName.embedFonts = true;
			miniTitle.addChild(eventName);
			eventName.text = "Champions League : Today 3pm";
			
			return miniTitle;			
		}
		
		public function getQuestionRenderer(questionText:String):TextFieldTextRenderer
		{
			var result:TextFieldTextRenderer = new TextFieldTextRenderer();
			
			if(questionText.length < 30)
			{
			result.width = 320;
			result.height = 55;
			result.x = 0;
			result.y = 116;
			result.textFormat = FontFactory.getTextFormat(1,25,0xFFFFFF);
			result.textFormat.align = "center";
			result.embedFonts = true;
			result.text = questionText;
			}
			else
			{
			result.width = 320;
			result.height = 140;
			result.x = 0;
			result.y = 100;
			result.textFormat = FontFactory.getTextFormat(1,25,0xFFFFFF);
			result.textFormat.align = "center";
			result.embedFonts = true;
			result.text = questionText;
			}
			
			return result;
		}
				
		private function getAnswerItem(id:int, type:int, question:String, points:String):Button
		{
			
			var button:Button = new Button();
			
			button.defaultSkin = new Image( Assets.getAssetsTexture("answer_bg_mid", 2) );
			button.downSkin = new Image( Assets.getAssetsTexture("answer_bg_mid_press", 2) );				
				
			var answerRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			answerRenderer.width = 400;
			answerRenderer.height = 44;
			answerRenderer.x = 20;
			answerRenderer.y = 15;
			answerRenderer.textFormat = FontFactory.getTextFormat(1,20,0x333333);;
			answerRenderer.textFormat.align = "left";
			answerRenderer.embedFonts = true;
			button.addChild(answerRenderer);
			answerRenderer.text = question;
			
			var pointsRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			pointsRenderer.width = 300;
			pointsRenderer.height = 44;
			pointsRenderer.x = 253;
			pointsRenderer.y = 16.5;
			pointsRenderer.textFormat = FontFactory.getTextFormat(1,13,0x515162);;
			pointsRenderer.textFormat.align = "left";
			pointsRenderer.embedFonts = true;
			button.addChild(pointsRenderer);
			pointsRenderer.text = points +"pts";
			
			
			return button;
		}
		
		public function getChallengesList( arrayOfChallenges:Vector.<PredictionConfirmVA>, myMaxPoints:Number, opponentMaxPoints:Number, noCoinsDoubleDown:Number ):Sprite
		{
			var challengesList:Sprite = new Sprite();
			
			var backgroundList:Image = new Image( Assets.getAssetsTexture("results_bg", 2) );
			challengesList.addChild(backgroundList);
			
			for (var i:int = 0; i < arrayOfChallenges.length; i++)
			{
				var challengeLine:Sprite = getChallengeLine(arrayOfChallenges[i]);
				challengesList.addChild(challengeLine);
				challengeLine.y = i * 35;
			}
			
			var maxPointsLine:Sprite = getMaxPointsLine(String(myMaxPoints), String(opponentMaxPoints), String(noCoinsDoubleDown));
			maxPointsLine.y = 55;
			challengeLine.addChild(maxPointsLine);
			
			return challengesList;
		}
		
		private function getChallengeLine(prediction:PredictionConfirmVA):Sprite
		{
			var line:Sprite = new Sprite();
			
			var myPredictionTextField:TextFieldTextRenderer = new TextFieldTextRenderer();			
			myPredictionTextField.text = prediction.myPrediction;
			myPredictionTextField.width = 100;
			myPredictionTextField.height = 14;
			myPredictionTextField.x = 20;
			myPredictionTextField.y = 6;
			myPredictionTextField.textFormat = FontFactory.getTextFormat(2, 14, 0x333333);
			myPredictionTextField.textFormat.align = "left";
			myPredictionTextField.embedFonts = true;
			line.addChild(myPredictionTextField);
			
			var predictionTextFieldMultiLine:TextFieldTextRenderer = new TextFieldTextRenderer();			
			if(prediction.prediction.search("\n")!=-1) predictionTextFieldMultiLine.text = prediction.prediction;
			predictionTextFieldMultiLine.width = 100;
			predictionTextFieldMultiLine.height = 40;
			predictionTextFieldMultiLine.x = 110;
			predictionTextFieldMultiLine.y = -1;
			predictionTextFieldMultiLine.textFormat = FontFactory.getTextFormat(1, 14, 0x333333);
			predictionTextFieldMultiLine.textFormat.align = "center";
			predictionTextFieldMultiLine.embedFonts = true;
			line.addChild(predictionTextFieldMultiLine);
			
			var predictionTextField:TextFieldTextRenderer = new TextFieldTextRenderer();			
			if(prediction.prediction.search("\n")==-1) predictionTextField.text = prediction.prediction;
			predictionTextField.width = 100;
			predictionTextField.height = 20;
			predictionTextField.x = 110;
			predictionTextField.y = 6;
			predictionTextField.textFormat = FontFactory.getTextFormat(1, 14, 0x333333);
			predictionTextField.textFormat.align = "center";
			predictionTextField.embedFonts = true;
			line.addChild(predictionTextField);
			
			var opponentPredicitionTextField:TextFieldTextRenderer = new TextFieldTextRenderer();			
			opponentPredicitionTextField.text = prediction.opponentPrediction;
			opponentPredicitionTextField.width = 100;
			opponentPredicitionTextField.height = 14;
			opponentPredicitionTextField.x = 201;
			opponentPredicitionTextField.y = 6;
			opponentPredicitionTextField.textFormat = FontFactory.getTextFormat(2, 14, 0x333333);
			opponentPredicitionTextField.textFormat.align = "right";
			opponentPredicitionTextField.embedFonts = true;
			line.addChild(opponentPredicitionTextField);
						
			return line;
		}
		
		private function getMaxPointsLine(myMaxPoints:String, opponentMaxPoints:String, coinsAmount:String):Sprite
		{
			var maxPointsLine:Sprite = new Sprite();
			
			var myMaxPointsTitle:TextFieldTextRenderer = new TextFieldTextRenderer();
			myMaxPointsTitle.text = "MAX POINTS";
			myMaxPointsTitle.width = 100;
			myMaxPointsTitle.height = 14;
			myMaxPointsTitle.x = 20;
			myMaxPointsTitle.y = 9;
			myMaxPointsTitle.textFormat = FontFactory.getTextFormat(2, 9, 0x4D4D4D);
			myMaxPointsTitle.textFormat.align = "left";
			myMaxPointsTitle.embedFonts = true;
			maxPointsLine.addChild(myMaxPointsTitle);
			
			var opponentMaxPointsTitle:TextFieldTextRenderer = new TextFieldTextRenderer();
			opponentMaxPointsTitle.text = "MAX POINTS";
			opponentMaxPointsTitle.width = 100;
			opponentMaxPointsTitle.height = 14;
			opponentMaxPointsTitle.x = 200;
			opponentMaxPointsTitle.y = 9;
			opponentMaxPointsTitle.textFormat = FontFactory.getTextFormat(2, 9, 0x4D4D4D);
			opponentMaxPointsTitle.textFormat.align = "right";
			opponentMaxPointsTitle.embedFonts = true;
			maxPointsLine.addChild(opponentMaxPointsTitle);
			
			
			var myMaxPointsDisplay:TextFieldTextRenderer = new TextFieldTextRenderer();
			myMaxPointsDisplay.text = myMaxPoints;
			myMaxPointsDisplay.width = 42;
			myMaxPointsDisplay.height = 22;
			myMaxPointsDisplay.x = 20;
			myMaxPointsDisplay.y = 19;
			myMaxPointsDisplay.textFormat = FontFactory.getTextFormat(2, 20, 0x000000);
			myMaxPointsDisplay.textFormat.align = "left";
			myMaxPointsDisplay.embedFonts = true;
			maxPointsLine.addChild(myMaxPointsDisplay);
						
			var opponentMaxPointsDisplay:TextFieldTextRenderer = new TextFieldTextRenderer();
			opponentMaxPointsDisplay.text = opponentMaxPoints;
			opponentMaxPointsDisplay.width = 52;
			opponentMaxPointsDisplay.height = 22;
			opponentMaxPointsDisplay.x = 249;
			opponentMaxPointsDisplay.y = 19;
			opponentMaxPointsDisplay.textFormat = FontFactory.getTextFormat(2, 20, 0x000000);
			opponentMaxPointsDisplay.textFormat.align = "right";
			opponentMaxPointsDisplay.embedFonts = true;
			maxPointsLine.addChild(opponentMaxPointsDisplay);
			
			var ddBtn:Button = new Button();
			ddBtn.defaultSkin = new Image(Assets.getAssetsTexture("dd_btn", 2));
			ddBtn.downSkin = new Image(Assets.getAssetsTexture("dd_btn_press", 2));
			maxPointsLine.addChild(ddBtn);
			ddBtn.width = ddBtn.defaultSkin.width;
			ddBtn.height= ddBtn.defaultSkin.height;
			ddBtn.x = 81;
			ddBtn.y = 4;
			
			var doubleDownText:TextFieldTextRenderer = new TextFieldTextRenderer();
			doubleDownText.text = "Double down";
			doubleDownText.width = 92;
			doubleDownText.height = 22;
			doubleDownText.x = 20;
			doubleDownText.y = 2;
			doubleDownText.textFormat = FontFactory.getTextFormat(1, 16, 0x4D4D4D);
			doubleDownText.textFormat.align = "left";
			doubleDownText.embedFonts = true;
			ddBtn.addChild(doubleDownText);
			
			var x2Max:TextFieldTextRenderer = new TextFieldTextRenderer();
			x2Max.text = "x2 your max points";
			x2Max.width = 92;
			x2Max.height = 22;
			x2Max.x = 20;
			x2Max.y = 17;
			x2Max.textFormat = FontFactory.getTextFormat(2, 10, 0x4D4D4D);
			x2Max.textFormat.align = "left";
			x2Max.embedFonts = true;
			ddBtn.addChild(x2Max);
			
			var smallCoinImage:Image = new Image(Assets.getAssetsTexture("coin"));
			smallCoinImage.x = 112;
			smallCoinImage.y = 9;
			smallCoinImage.width = 20;
			smallCoinImage.height = 20;
			ddBtn.addChild(smallCoinImage);			
			
			var coinsText:TextFieldTextRenderer = new TextFieldTextRenderer();
			coinsText.text = coinsAmount;
			coinsText.width = 92;
			coinsText.height = 22;
			coinsText.x = 132;
			coinsText.y = 7;
			coinsText.textFormat = FontFactory.getTextFormat(1, 16, 0x4D4D4D);
			coinsText.textFormat.align = "left";
			coinsText.embedFonts = true;
			ddBtn.addChild(coinsText);
			
			return maxPointsLine;
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
			
			goBtn.addEventListener( Event.TRIGGERED, goCallback );
			
			return goBtn;
		}
		
		public function refreshGoCallback(goCallback:Function)
		{
			
		}
		
		public function getInputField(defaultText:String, paddingLeft:int, paddingTop:int, eraseAllOnFocus:Boolean):TextInput
		{			
			var inputField:TextInput = new TextInput();
			var inputBackImage2:Image = new Image(Assets.getAssetsTexture("form_field"));
			
			inputField.backgroundSkin = inputBackImage2;
			inputField.textEditorFactory = getTextInputField;
			inputField.paddingLeft = paddingLeft;
			inputField.paddingTop = paddingTop;
			inputField.text = defaultText;
			//inputFieldInit = true;
						
			if (eraseAllOnFocus)
				inputField.addEventListener("focusIn", inputFocusHandler);
			//else
				//inputField.removeEventListener("focusIn", inputFocusHandler);
							
			return inputField;
		}
			
		public function getPopularEventButton(id:int,day:String, time:String, team1:String, team2:String,callback:Function):Button
		{
			var result:Button= new Button();
			
			var codeButton:int = id + 1;
			var code:String;
			if (codeButton == 2 || codeButton == 3) code = "2_3";
			else
			code = String(codeButton);
			
			result.defaultSkin = new Image(Assets.getAssetsTexture("pop_event_btn"+code));
			result.downSkin    = new Image(Assets.getAssetsTexture("pop_event_btn"+code+"_press"));
				
			result.width = result.defaultSkin.width;
			result.height = result.defaultSkin.height;
			
			var dayTimeText:TextFieldTextRenderer = new TextFieldTextRenderer();
			var team1Team2Text:TextFieldTextRenderer = new TextFieldTextRenderer();
			
			dayTimeText.text = day + "\n" + time;
			dayTimeText.width = 80;
			dayTimeText.height = 41;
			dayTimeText.x = 9;
			dayTimeText.y = 8;
			dayTimeText.textFormat = FontFactory.getTextFormat(2, 15, 0x808080);
			dayTimeText.embedFonts = true;
			dayTimeText.textFormat.leading = 2;
			
			team1Team2Text.text = team1 + "\n" + team2;
			team1Team2Text.width = 150;
			team1Team2Text.height = 41;
			team1Team2Text.x = 100;
			team1Team2Text.y = 8;
			team1Team2Text.textFormat = FontFactory.getTextFormat(1, 15, 0x4d4d4d);
			team1Team2Text.embedFonts = true;
			team1Team2Text.textFormat.leading = 1.2;
			
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
				
		private function getTextInputField():StageTextTextEditor
		{
			var label:StageTextTextEditor = new StageTextTextEditor();
			
			label.color = 0xB3B3B3;
			label.fontFamily = "Helvetica";
			label.fontSize = 11*DeviceConstants.SCALE;
			label.fontWeight = FontWeight.BOLD;
			
			return label;
		}
		
		private function inputFocusHandler(e:Event):void
		{
			TextInput(e.target).text = "";
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