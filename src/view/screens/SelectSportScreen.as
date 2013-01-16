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
	import flash.events.Event;
	import starling.display.Sprite;
	import starling.display.Image;
	import flash.text.TextRenderer;
	import starling.events.*;
	import starling.events.Event;
	
	import feathers.controls.Screen;
	import feathers.controls.Button;
	import feathers.controls.TextInput;
	import feathers.controls.text.*;
	import feathers.system.DeviceCapabilities;
	import feathers.controls.renderers.*;
	
	import flash.text.TextFormat;
	import feathers.core.*;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
			
	import view.util.*; 
	 
	public class SelectSportScreen extends Screen
	{
		
		private var commonAssetsScreen:CommonAssetsScreen;
				
		private var header:Sprite;
		
		private var nflIcon:Button;
		private var soccerIcon:Button;
		private var baseballIcon:Button;
		private var nhlIcon:Button;
		private var golfIcon:Button;
		private var tennisIcon:Button;
		
		private var shadow:Image;
		
		public function SelectSportScreen() 
		{
			commonAssetsScreen = CommonAssetsScreen.getInstance();
		}
		
		override protected function initialize():void
		{
			header = commonAssetsScreen.getHeader("Select Sport",true, headerBackButtonHandler, true, coinsCallbackHandler);
			addChild( header );
			
			shadow = new Image(Assets.getAssetsTexture("shadow"));
			addChild(shadow);
			shadow.y = 403 - 55;
			
			nflIcon = commonAssetsScreen.getSportButton(null, "NFL");
			soccerIcon = commonAssetsScreen.getSportButton(null, "Soccer");
			baseballIcon = commonAssetsScreen.getSportButton(null, "Baseball");
			nhlIcon = commonAssetsScreen.getSportButton(null, "NFL");
			golfIcon = commonAssetsScreen.getSportButton(null, "Golf");
			tennisIcon = commonAssetsScreen.getSportButton(null, "Tennis");
			
			addChild(nflIcon);
			nflIcon.x = 10;
			nflIcon.y = 73.5;
			addChild(soccerIcon);
			soccerIcon.x = 159.25;
			soccerIcon.y = 73.5;
			addChild(baseballIcon);
			baseballIcon.x = 10;
			baseballIcon.y = 171.5;
			addChild(nhlIcon);
			nhlIcon.x = 159.25;
			nhlIcon.y = 171.5;
			addChild(golfIcon);
			golfIcon.x = 10;
			golfIcon.y = 270;
			addChild(tennisIcon);
			tennisIcon.x = 159.25;
			tennisIcon.y = 270;
			
		}
		
		private function eventSelected(eventId:int):void
		{
			trace("selected event with id :" + eventId);
		}
		
		private function headerBackButtonHandler(e:starling.events.Event)
		{
			trace("back handler");
		}
		
		private function coinsCallbackHandler(e:starling.events.Event)
		{
			trace("coins callback");
		}
		
		override protected function draw():void
		{		
			
		}
		
	}

}