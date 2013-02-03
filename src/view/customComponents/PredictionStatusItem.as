package view.customComponents 
{
	
	import starling.display.*;
	import view.util.Assets;
	
	public class PredictionStatusItem extends Sprite
	{
		
		private var disabledPrediction:Image;
		private var enabledPrediction:Image;
		
		public function PredictionStatusItem() 
		{
			disabledPrediction = new Image(Assets.getAssetsTexture("progress_off", 2));
			addChild(disabledPrediction);
			enabledPrediction = new Image(Assets.getAssetsTexture("progress_on", 2));
			addChild(enabledPrediction);
			disabledPrediction.visible = enabledPrediction.visible = false;
		}
		
		public function enable()
		{			
			disabledPrediction.visible = false;
			enabledPrediction.visible = true;
		}
		
		public function disable()
		{
			disabledPrediction.visible = true;
			enabledPrediction.visible = false;			
		}
		
	}

}