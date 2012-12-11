package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import starling.core.Starling;
	import feathers.themes.*;
	import view.View;
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var starling:Starling = new Starling(View, stage);
			//starling.simulateMultitouch = true; // Mobile testing
			//starling.enableErrorChecking = false;
			//starling.showStatsAt();
			starling.start();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			
		}
		
	}
	
}