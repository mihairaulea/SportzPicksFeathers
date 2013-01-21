package view.loading 
{
	/**
	 * ...
	 * @author ...
	 */
	
	import flash.display.Sprite; 
	import flash.text.*;
	
	public class LoadingScreen extends Sprite
	{
		
		public function LoadingScreen() 
		{
			var text:TextField = new TextField();
			text.backgroundColor = 0x000000;
			text.text = "Loading";
			addChild(text);
		}
		
	}

}