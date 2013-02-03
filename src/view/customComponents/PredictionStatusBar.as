package view.customComponents 
{
	
	import starling.display.*;
	
	public class PredictionStatusBar extends Sprite
	{
		
			
		private var elementsArray:Array = new Array();
		
		public function PredictionStatusBar() 
		{
			
		}
		
		public function init(noOfElements:int, noOfActiveElements:int = 0)
		{
			for (var i:int = 0; i < noOfElements; i++)
			{
				var predStatusItem:PredictionStatusItem = new PredictionStatusItem();
				if (noOfActiveElements >= i+1) predStatusItem.enable();
				else predStatusItem.disable();
				elementsArray[i] = predStatusItem;
				addChild(predStatusItem);
				predStatusItem.x = (predStatusItem.width+7) * i ;
			}
			
		}
		
		public function setNoOfActiveElements(activeElements:int):void
		{
			for (var i:int = 0; i < elementsArray.length; i++)
			{
				if (i  < activeElements) PredictionStatusItem(elementsArray[i]).enable();
				else 						PredictionStatusItem(elementsArray[i]).disable();
			}
		}
		
	}

}