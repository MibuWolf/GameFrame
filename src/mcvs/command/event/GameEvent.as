package mcvs.command.event
{
	import flash.events.Event;

	public class GameEvent extends Event
	{
		public static var INIT:String = "INIT";
		
		public function GameEvent(type:String)
		{
			super(type)
		}
	}
}