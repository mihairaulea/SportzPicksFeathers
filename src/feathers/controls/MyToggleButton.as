package feathers.controls 
{
	import starling.display.Sprite;
	import starling.events.*;
	import feathers.events.MyToggleButtonEvent;
	/**
	 * ...
	 * @author ...
	 */
	public class MyToggleButton extends Sprite
	{
	
		private var buttonOn:Button;
		private var buttonOff:Button;
		private var isSelected:Boolean = false;
		
		public var buttonId:String;
		public static var REQUEST_FOR_CHANGE:String = "requestForChange";
		
		public function MyToggleButton(buttonOn:Button, buttonOff:Button, buttonId:String) 
		{
			this.buttonOn = buttonOn;
			this.buttonOff = buttonOff;
			this.addChild(buttonOn);
			this.addChild(buttonOff);
			buttonOff.visible = false;
			
			this.buttonId = buttonId;
			
			buttonOn.addEventListener(Event.TRIGGERED, buttonTriggered);
			buttonOff.addEventListener(Event.TRIGGERED, buttonTriggered);
		}
		
		private function buttonTriggered(e:Event):void
		{
			var event:MyToggleButtonEvent = new MyToggleButtonEvent(MyToggleButton.REQUEST_FOR_CHANGE);
			event.buttonId = buttonId;
			dispatchEvent(event);
		}
		
		public function setSelected():void
		{
			buttonOn.visible = true;
			buttonOff.visible = false;
		}
		
		public function setUnselected():void
		{			
			buttonOn.visible = false;
			buttonOff.visible = true;
		}
		
	}

}