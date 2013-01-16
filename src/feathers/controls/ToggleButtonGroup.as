package feathers.controls 
{
	import feathers.events.MyToggleButtonEvent;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author ...
	 */
	public class ToggleButtonGroup extends Sprite
	{
		
		private var btnsArray:Array = new Array();
		
		public function ToggleButtonGroup() 
		{
			
		}
		
		public function addNewToggleButton( toggleButton:MyToggleButton ):void
		{
			btnsArray.push(toggleButton);
			toggleButton.addEventListener(MyToggleButton.REQUEST_FOR_CHANGE, requestForChangeHandler);
			addChild(toggleButton);
		}
		
		private function requestForChangeHandler(e:MyToggleButtonEvent)
		{			
			setSelectedButton(e.buttonId);			
		}
		
		public function setSelectedButton( buttonIdToSelect:String )
		{
			for (var i:int = 0; i < btnsArray.length; i++)
			{
				if (buttonIdToSelect != MyToggleButton(btnsArray[i]).buttonId)
				{
					MyToggleButton(btnsArray[i]).setUnselected();
				}
				else
				{
					MyToggleButton(btnsArray[i]).setSelected();
				}
			}
		}
		
	}

}