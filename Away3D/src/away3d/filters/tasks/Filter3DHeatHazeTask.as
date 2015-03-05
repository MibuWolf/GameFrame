package away3d.filters.tasks
{
	import away3d.cameras.Camera3D;
	import away3d.core.managers.Stage3DProxy;
	import away3d.filters.Filter3DBase;
	import away3d.textures.RenderTexture;
	
	import flash.display3D.Context3D;
	import flash.display3D.Context3DBlendFactor;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.textures.Texture;

	public class Filter3DHeatHazeTask extends Filter3DTaskBase
	{
		private var _data:Vector.<Number>;
		public var heatMap:RenderTexture;
		
		public function Filter3DHeatHazeTask()
		{
			super();
			_data = Vector.<Number>([1, 1, 0.0015, 1, 2, 2, 0, 0]);
			
		}
		
		
		override protected function getFragmentCode():String
		{
			var code:String;
			code = "tex ft1, v0, fs1 <2d, nearest>\n"
				+ "mul ft0,ft1,fc1\n"
				+ "sub ft0,ft0,fc0\n"
				+ "mul ft0,ft0,fc0.z\n"
				+ "add ft0,v0,ft0\n"
				+ "tex oc, ft0, fs0 <2d, nearest>\n";
			return code;
		}
		
		override public function activate(stage3DProxy:Stage3DProxy, camera3D:Camera3D, depthTexture:Texture):void
		{
			var context:Context3D = stage3DProxy.context3D;
			context.setBlendFactors(Context3DBlendFactor.ONE,Context3DBlendFactor.ZERO );
			context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, _data, 2);
			context.setTextureAt(1, heatMap.getTextureForStage3D(stage3DProxy));
		}
		
		override public function deactivate(stage3DProxy:Stage3DProxy):void
		{
			stage3DProxy.context3D.setTextureAt(1, null);
		}
	
	}
}