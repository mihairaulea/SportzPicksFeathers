package view.util 
{
	import starling.display.Sprite;
	import starling.events.Event;
	import flash.errors.IllegalOperationError;
	import starling.display.DisplayObject;
	
	public class ContentRequester
	{
		private var _screenInstance:DisplayObject;
		
		public function ContentRequester(screen:Object, events:Object = null, initializer:Object = null) 
		{
			this.screen = screen;
			this.events = events ? events : { };
			this.initializer = initializer ? initializer : { };
		}
		
		public var screen:Object;
		public var events:Object;
		public var initializer:Object;
		public var init:Boolean = false;
		
		internal function getScreen():DisplayObject
		{
			if (this.initializer)
			{
				for (var property:String in this.initializer)
				{
					this._screenInstance[property] = this.initializer[property];
					trace(this._screenInstance[property]);
				}
			}
			
			return this._screenInstance;
		}
						
		internal function initScreen():DisplayObject
		{
			var screenInstance:DisplayObject;
			if (this.screen is Class)
			{
				var ScreenType:Class = Class(this.screen);
				screenInstance = new ScreenType();
				this._screenInstance = screenInstance;
				screenInstance.visible = false;
			}
			else if (this.screen is DisplayObject)
			{
				screenInstance = DisplayObject(this.screen);
				this._screenInstance = screenInstance;
				screenInstance.visible = false;
			}
			else
			{
				throw  new IllegalOperationError("ScreenNavigatorItem \"screen\" must be a Class or a display object.");
			}
			
			return screenInstance;
		}		
	}

}