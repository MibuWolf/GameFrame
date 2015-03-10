package robotlegscore
{
	import ash.core.Engine;
	
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;

	public class AshExtension  implements IExtension
	{
		public function AshExtension()
		{
		}
		
		public function extend(context:IContext):void
		{
			context.injector.map( Engine ).toValue( new Engine() );
		}
	
	}
}