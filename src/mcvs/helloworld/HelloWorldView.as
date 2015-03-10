package mcvs.helloworld
{
	import org.aswing.JLabel;
	import org.aswing.JPanel;

	public class HelloWorldView extends JPanel implements IHelloWorldView
	{
		public function HelloWorldView()
		{
			this.width = 200;		this.height = 50;
			var lable:JLabel = new JLabel( "Hello My Game");
			lable.width = 100;
			lable.height = 20;
			lable.x = 20;	lable.y = 20;
			
			this.addChild( lable );
		}
	}
}