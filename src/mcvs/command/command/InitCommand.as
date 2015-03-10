package mcvs.command.command
{
	import mcvs.helloworld.HelloWorldView;
	
	import org.aswing.JFrame;
	import org.aswing.JLabel;
	import org.aswing.JPanel;

	public class InitCommand
	{
		[Inject]
		public var gameRoot:GameFrame;
		
		public function InitCommand()
		{
		}
		
		public function execute():void
		{
			gameRoot.addChild( new HelloWorldView() );
		}
	}
}