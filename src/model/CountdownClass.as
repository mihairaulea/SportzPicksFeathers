package model 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	 
	public class CountdownClass 
	{
		
		private var timer:Timer = new Timer(1000);
		
		private var startDaysHoursMinsSecondsArray:Array;
		private var callbackFunction:Function;
		
		private var currentSeconds:int;
		
		private static var instance:CountdownClass = null;
		
		public function CountdownClass() 
		{
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
		}
		
		public static function getInstance():CountdownClass
		{
			if (instance == null)
			{
				instance = new CountdownClass();
			}
			return instance;
		}
		
		public function startCountingFromDaysHoursMinsSecondsFormat(daysHoursMinsSecsArray:Array,callbackFunct:Function):void
		{
			clearTimer();
			startDaysHoursMinsSecondsArray = daysHoursMinsSecsArray;
			this.callbackFunction = callbackFunct;
			currentSeconds = convertFromDaysHoursMinsSecondsToSeconds(startDaysHoursMinsSecondsArray);
			timer.start();
		}
		
		public function startCountingFromSeconds(seconds:int, callbackFunct:Function):void
		{
			clearTimer();
			this.callbackFunction = callbackFunct;
			currentSeconds = seconds;
			timer.start();
		}
		
		public function clearTimer():void
		{
			if( timer.running )timer.stop();
		}
		
		private function timerHandler(e:TimerEvent):void
		{
			if (currentSeconds == 0) timer.stop();
			else
			{
				currentSeconds--;
				callbackFunction.call(null,convertFromSecondsToDaysHoursMinsSecs(currentSeconds) );
			}
		}
		
		private function convertFromSecondsToDaysHoursMinsSecs( seconds:int ):Array
		{
			var result:Array = new Array(4);
			result[0] = Math.floor(seconds / 86400);
			seconds = seconds - result[0] * 86400;
			result[1] = Math.floor((seconds) / 3600);
			seconds = seconds - result[1] * 3600;
			result[2] = Math.floor((seconds) / 60);
			result[3] = seconds % 60;		
			return result;
		}
		
		private function convertFromDaysHoursMinsSecondsToSeconds( array:Array):int
		{
			return array[0] * 86400 + array[1] * 3600 + array[2] * 60 + array[3];
		}
		
	}

}