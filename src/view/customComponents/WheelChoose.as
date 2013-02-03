package view.customComponents 
{
	
	import starling.display.*;
	import view.util.Assets;
	
	public class WheelChoose extends Sprite
	{
		
		private var wheelBackground:Image;
		
		public function WheelChoose() 
		{
			wheelBackground = new Image( Assets.getAssetsTexture("filter_wheel_bg", 2) );
			addChild(wheelBackground);
		}
		
	}

}