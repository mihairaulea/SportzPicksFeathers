package feathers.events 
{
	
	import starling.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class MyToggleButtonEvent extends Event
	{
		
		public var buttonId:String;
		
		public function MyToggleButtonEvent(name:String)
		{
			super(name);
		}
	}

}