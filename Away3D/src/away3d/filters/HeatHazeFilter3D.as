package away3d.filters
{
	import away3d.core.managers.Stage3DProxy;
	import away3d.filters.tasks.Filter3DHeatHazeTask;
	import away3d.textures.RenderTexture;
	
	import flash.display3D.textures.Texture;

	public class HeatHazeFilter3D  extends Filter3DBase
	{
		private var _vHeatHazeTask:Filter3DHeatHazeTask;
		
		public function HeatHazeFilter3D()
		{
			super();
			_vHeatHazeTask = new Filter3DHeatHazeTask();
			_vHeatHazeTask.heatMap = new RenderTexture(2,2);
			addTask( _vHeatHazeTask );
		}
		
		
		override public function setRenderTargets(mainTarget:Texture, stage3DProxy:Stage3DProxy):void
		{
			_vHeatHazeTask.target = _vHeatHazeTask.getMainInputTexture(stage3DProxy);
			
			super.setRenderTargets(mainTarget, stage3DProxy);
		}
	}
}