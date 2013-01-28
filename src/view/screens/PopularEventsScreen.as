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
	 
	public class PopularEventsScreen extends Screen
	{
		
		private var commonAssetsScreen:CommonAssetsScreen;
		
		private var header:Sprite;
		private var selectYourEventText:TextFieldTextRenderer;
		
		private var eventsArray:Array = new Array();
		
		private var shuffleButton:Button;
		private var shuffleText:TextFieldTextRenderer;
		private var coinsCost:TextFieldTextRenderer;
		
		private var seeAllEventsButton:Button;
		private var seeAllEventsText:TextFieldTextRenderer;					
		
		public function PopularEventsScreen() 
		{
			commonAssetsScreen = CommonAssetsScreen.getInstance();
			
			shuffleText = new TextFieldTextRenderer();
			shuffleText.textFormat = FontFactory.getTextFormat(0, 18, 0xFFFFFF);
			shuffleText.embedFonts = true;
			shuffleText.width = 150;
			
			seeAllEventsText = new TextFieldTextRenderer();
			seeAllEventsText.textFormat = FontFactory.getTextFormat(0, 18, 0x4D4D4D);
			seeAllEventsText.embedFonts = true;
			seeAllEventsText.width = 150;
			
			coinsCost = new TextFieldTextRenderer();
			coinsCost.textFormat = FontFactory.getTextFormat(2, 15, 0xFFFFFF);
			coinsCost.embedFonts = true;
			coinsCost.width = 25;
		}
		
		override protected function initialize():void
		{
			header = commonAssetsScreen.getHeader("Popular Events",true, headerBackButtonHandler, true, coinsCallbackHandler);
			addChild( header );
						
			selectYourEventText = new TextFieldTextRenderer();
			selectYourEventText.x = 16.5;
			selectYourEventText.y = 59;
			selectYourEventText.textFormat = FontFactory.getTextFormat(0, 18, 0xFFFFFF);
			selectYourEventText.embedFonts = true;
			
			addChild(selectYourEventText);
			selectYourEventText.text = "Select your event";
			
			for (var i:int = 0; i < 4; i++)
			{
				var button:Button = commonAssetsScreen.getPopularEventButton(i, "Today", "16:00", "Team 1", "Team 2", eventSelected);
				addChild( button );
				button.x = 10;
				button.y = 100 + i * button.height;
			}
			
			shuffleButton = new Button();
			shuffleButton.defaultSkin = new Image(Assets.getAssetsTexture("shuffle_btn"));
			shuffleButton.downSkin = new Image(Assets.getAssetsTexture("shuffle_btn_press"));
			addChild(shuffleButton);
			shuffleButton.x = 6;
			shuffleButton.y = 335;
			shuffleText.text = "Shuffle";
			shuffleButton.addChild( shuffleText );
			shuffleText.x = 53.5;
			shuffleText.y = 18.5;
			coinsCost.text = "50";
			shuffleButton.addChild(coinsCost);
			coinsCost.x = 277;
			coinsCost.y = 19;
			
			seeAllEventsButton = new Button();
			seeAllEventsButton.defaultSkin = new Image(Assets.getAssetsTexture("events_btn"));
			seeAllEventsButton.downSkin = new Image(Assets.getAssetsTexture("events_btn_press"));
			addChild(seeAllEventsButton);
			seeAllEventsButton.x = 10;
			seeAllEventsButton.y = 400;
			seeAllEventsText.text = "See All Events";
			seeAllEventsButton.addChild(seeAllEventsText);
			seeAllEventsText.x = 47.5;
			seeAllEventsText.y = 15;
			seeAllEventsButton.addEventListener(Event.TRIGGERED, seeAllEventsRequest);
		}
		
		private function seeAllEventsRequest(e:Event)
		{
			dispatchEvent(new Event("onSeeAllEvents"));
		}
				
		private function eventSelected(eventId:int):void
		{
			trace("selected event with id :" + eventId);
		}
		
		private function headerBackButtonHandler()
		{
			trace("back handler");
			dispatchEvent(new Event("onBack"));
		}
		
		private function coinsCallbackHandler(e:starling.events.Event)
		{
			trace("coins callback");
		}
		
		override protected function draw():void
		{
			
		}
					
		override protected function screen_addedToStageHandler(event:Event):void
		{
			commonAssetsScreen.refreshBackCallback( headerBackButtonHandler );
		}
		
	}

}