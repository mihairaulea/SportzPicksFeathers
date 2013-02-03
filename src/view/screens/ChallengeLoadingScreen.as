package view.screens 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	
	import feathers.controls.Screen;
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
	 
	public class ChallengeLoadingScreen extends Screen
	{
		//assets
		private var commonAssets:CommonAssetsScreen;
		
		private var header:Sprite;
		
		private var miniTitle:Sprite;
		
		private var vsScreen:Sprite;
		
		
		private var scoreStrip:Sprite;
		private var totalPointsStrip:Sprite;
		private var overallRankStrip:Sprite;
		
		private var loadingPanel:Image;
		private var loadingText:TextFieldTextRenderer;
		
		
		
		public function ChallengeLoadingScreen() 
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
			
			scoreStrip = commonAssets.getScoreStrip("WEEKLY", "HEAD TO HEAD", "588", "700");
			addChild(scoreStrip);
			scoreStrip.y = vsScreen.y + vsScreen.height + 1;
			
			totalPointsStrip = commonAssets.getScoreStrip("TOTAL", "POINTS", "3245", "5656");
			addChild(totalPointsStrip);
			totalPointsStrip.y = scoreStrip.y + scoreStrip.height + 1;
			
			overallRankStrip = commonAssets.getScoreStrip("OVERALL", "RANK", "5880", "7000");
			addChild(overallRankStrip);
			overallRankStrip.y = totalPointsStrip.y + totalPointsStrip.height + 1;
			
			loadingPanel = new Image( Assets.getAssetsTexture("loading_panel", 2));
			addChild(loadingPanel);
			loadingPanel.x = 10;
			loadingPanel.y = 249.5;
			
			loadingText = new TextFieldTextRenderer();
			loadingText.width = 93.5;
			loadingText.height = 13;
			loadingText.x = 113;
			loadingText.y = 378;
			loadingText.textFormat = FontFactory.getTextFormat(6,13.5,0x4D4D4D);
			loadingText.textFormat.align = "center";
			loadingText.embedFonts = true;
			addChild(loadingText);
			loadingText.text = "LOADING";
		}
		
		private function coinsCallbackFunction()
		{
			trace("coins callback");
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