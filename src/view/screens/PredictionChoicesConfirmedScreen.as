package view.screens 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	
	import feathers.controls.Screen;
	import feathers.controls.text.TextFieldTextEditor;
	import feathers.core.ITextRenderer;
	import starling.display.Quad;
	import starling.events.*;
	import feathers.controls.Button;
	import feathers.controls.text.TextFieldTextRenderer;
	import starling.display.Sprite;
	import starling.display.Image;
	import feathers.controls.ImageLoader;
	import view.util.CommonAssetsScreen;
	import view.util.Assets;
	import view.util.FontFactory;
	
	import model.PredictionConfirmVA;
	 
	public class PredictionChoicesConfirmedScreen extends Screen
	{
		//assets
		private var commonAssets:CommonAssetsScreen;
		
		private var header:Sprite;
		
		private var miniTitle:Sprite;
		
		private var vsScreen:Sprite;
		
		
		private var scoreStrip:Sprite;
		
		private var challengeSentPanel:Sprite;
		
		
		
		public function PredictionChoicesConfirmedScreen () 
		{
			super();
			commonAssets = CommonAssetsScreen.getInstance();
		}
		
		override protected function initialize():void
		{			
			header = commonAssets.getHeader("Man Utd vs Chelsea", false, null, true,coinsCallbackFunction);
			addChild(header);
			
			miniTitle = commonAssets.getMiniTitle();
			addChild(miniTitle);
			miniTitle.y = 45;
			
			vsScreen = commonAssets.getVsHeader();
			addChild(vsScreen);
			vsScreen.y = 64;
			
			challengeSentPanel = commonAssets.getChallengesList(getPredictionSummary(), 288, 700, 50);
			addChild(challengeSentPanel);
			challengeSentPanel.y = vsScreen.y + vsScreen.height;
			
			var offsetCover:Quad = new Quad(320, 42, 0xf8f8f8);
			offsetCover.y = challengeSentPanel.y + challengeSentPanel.height-2;
			addChild(offsetCover);
			
			var sendChallenge:Button = new Button();
			sendChallenge.defaultSkin = new Image(Assets.getAssetsTexture("send_challenge_btn", 2));
			sendChallenge.downSkin = new Image(Assets.getAssetsTexture("send_challenge_btn_press", 2));
			addChild(sendChallenge);
			sendChallenge.y = 425;
			sendChallenge.label = "Send Challenge";
			sendChallenge.labelFactory = getSendLabel;
			sendChallenge.labelOffsetY = -5;
		}
		
		private function getSendLabel():ITextRenderer
		{
			var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			
			
			textRenderer.textFormat = FontFactory.getTextFormat(1, 20, 0xFFFFFF);
			textRenderer.textFormat.align = "left";
			textRenderer.embedFonts = true;
			
			return textRenderer;
		}
		
		private function coinsCallbackFunction()
		{
			trace("coins callback");
		}
		
		private function getPredictionSummary():Vector.<PredictionConfirmVA>
		{
			var vectorPredicitons:Vector.<PredictionConfirmVA> = new Vector.<PredictionConfirmVA>;
			
			//dummy generation
			for (var i:int = 0; i < 6; i++)
			{
				var predConfirmVA:PredictionConfirmVA = new PredictionConfirmVA();
				predConfirmVA.myPrediction = "Over 2.5";
				predConfirmVA.opponentPrediction = "Under 2.5";
				(Math.ceil(Math.random()*2) == 2) ? predConfirmVA.prediction = "Half time \nwinner" : predConfirmVA.prediction = "First scorer" ;
				vectorPredicitons.push(predConfirmVA);
			}
			
			return vectorPredicitons;
		}
				
		override protected function draw():void
		{						
			
		}
		
		override protected function screen_removedFromStageHandler(event:Event):void
		{
			super.screen_removedFromStageHandler(event);
			trace("screen removed from stage handler");
		}
		
		
	}

}