package robotlegscore
{
	import flash.events.IEventDispatcher;
	
	import mcvs.command.command.InitCommand;
	import mcvs.command.event.GameEvent;
	import mcvs.helloworld.HelloWorldMediator;
	import mcvs.helloworld.IHelloWorldView;
	
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;

	public class Config implements IConfig
	{
		[Inject]
		public var context:IContext;
		
		[Inject]
		public var eventCommandMap:IEventCommandMap;
		
		[Inject]
		public var dispatcher:IEventDispatcher;
		
		[Inject]
		public var mediatorMap:IMediatorMap;
		
		public function Config()
		{
		}
		
		public function configure():void
		{
			initCommand();
			
			initViewMediator();
			
			dispatcher.dispatchEvent( new GameEvent(GameEvent.INIT) );
		}
		
		
		/**
		 * 注入命令
		 * */
		private function initCommand():void
		{
			eventCommandMap.map(GameEvent.INIT).toCommand(InitCommand);
		}
		
		
		/**
		 * 注入界面
		 * */
		private function initViewMediator():void
		{
			mediatorMap.map( IHelloWorldView ).toMediator( HelloWorldMediator );
			context.injector.injectInto( HelloWorldMediator ); 
		}
		
	}
}