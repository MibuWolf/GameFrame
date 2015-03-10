package mcvs.ui.helloworld
{
	import robotlegs.bender.bundles.mvcs.Mediator;

	public class HelloWorldMediator extends Mediator
	{
		[Inject]
		public var view:IHelloWorldView;
		
		public function HelloWorldMediator()
		{
			
		}
		
		
	}
}