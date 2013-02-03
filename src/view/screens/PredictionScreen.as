package view.screens 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	import feathers.controls.Screen;
	import model.AnswerVA;
	import starling.display.Quad;
	import starling.events.*;
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.controls.renderers.PredictionListRenderer;
	import starling.display.Sprite;
	import starling.display.Image;
	import feathers.controls.ImageLoader;
	import view.customComponents.PredictionStatusBar;
	import view.util.CommonAssetsScreen;
	import view.util.Assets;
	import view.util.FontFactory;
	import feathers.data.ListCollection;
	import view.customComponents.WheelChoose; 
	
	public class PredictionScreen extends Screen
	{
		//assets
		private var commonAssets:CommonAssetsScreen;
		
		private var newBackground:Image;
		private var header:Sprite;
		
		private var miniTitle:Sprite;
		
		private var predictionStatusBar:PredictionStatusBar = new PredictionStatusBar();
		
		private var questionText:TextFieldTextRenderer;
		
		private var wheelChoose:WheelChoose;
		
		private var predictionList:List;
		
		public function PredictionScreen() 
		{
			super();
			commonAssets = CommonAssetsScreen.getInstance();
		}
		
		override protected function initialize():void
		{			
			newBackground = new Image(Assets.getAssetsTexture("green_black_bg", 2));
			addChild(newBackground);
			
			header = commonAssets.getHeader("Man Utd vs Chelsea", false, null, true,coinsCallbackFunction);
			addChild(header);
			
			miniTitle = commonAssets.getMiniTitle();
			addChild(miniTitle);
			miniTitle.y = 45;
			
			questionText = commonAssets.getQuestionRenderer("Who will win?");
			addChild(questionText);
			
			wheelChoose = new WheelChoose();
			addChild(wheelChoose);
			wheelChoose.x = 0;
			wheelChoose.y = 169;
			
			predictionList = new List();
			
			addChild(predictionStatusBar);
			predictionStatusBar.init(6, 2);
			predictionStatusBar.setNoOfActiveElements(4);
			predictionStatusBar.x = 10;
			predictionStatusBar.y = 73;
		}
		
		private function coinsCallbackFunction()
		{
			trace("coins callback");
		}
		
		private function getQuestions():Vector.<AnswerVA>
		{
			var dummy:Vector.<AnswerVA> = new Vector.<AnswerVA>;
			
			for (var i:int = 0; i < 7; i++)
			{
					dummy[i] = new AnswerVA();
					dummy[i].answer = "Man Utd";
					dummy[i].points = String(i);
					
			}
			
			return dummy;
		}
		
		override protected function draw():void
		{					
			predictionList.itemRendererType = PredictionListRenderer;
			predictionList.dataProvider = new ListCollection(getQuestions());
			addChild(predictionList);
			predictionList.x = 10.5;
			predictionList.y = 230;
			predictionList.width = 300;
			predictionList.height = 250;
		}
		
		override protected function screen_removedFromStageHandler(event:Event):void
		{
			super.screen_removedFromStageHandler(event);
			trace("screen removed from stage handler");
		}
		
		
	}

}