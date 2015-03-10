package ecs.component
{
	import away3d.containers.ObjectContainer3D;

	public class CContainer extends IComponent
	{
		private var _container:ObjectContainer3D;
		
		public function CContainer()
		{
			
		}
		
		override public function dispose():void
		{
			if( _container )
			{
				_container.dispose();
				_container = null;
			}
		}
		
		
		public function get container():ObjectContainer3D
		{
			return _container;
		}
		
		public function set container(value:ObjectContainer3D):void
		{
			_container = value;
		}
		
	}
}