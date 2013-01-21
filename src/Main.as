package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.display.StageScaleMode;
	
	import starling.core.Starling;
    import starling.utils.RectangleUtil;
	import feathers.themes.*;
	import view.View;
	import view.util.DeviceConstants;
	import view.util.Assets;
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	public class Main extends Sprite 
	{
		
		private var starling:Starling;
		
		public function Main():void 
		{
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var viewPort:Rectangle;
			viewPort = RectangleUtil.fit( 
					new Rectangle(0,0,DeviceConstants.STAGE_WIDTH, DeviceConstants.STAGE_HEIGHT),
					new Rectangle(0,0,stage.fullScreenWidth, stage.fullScreenHeight)

			);
			starling = new Starling(View, stage, viewPort);
			starling.stage.stageWidth = DeviceConstants.STAGE_WIDTH;
			starling.stage.stageHeight = DeviceConstants.STAGE_HEIGHT;
			//starling.simulateMultitouch = true; // Mobile testing
			starling.enableErrorChecking = false;
			//starling.showStatsAt();
			starling.start();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			DeviceConstants.SCALE = starling.contentScaleFactor;
			trace(starling.contentScaleFactor + " content scale factor according to starling");
		}
		
	}
	
}