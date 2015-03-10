package
{
	import Camera.CameraManager;
	import Camera.CameraType;
	
	import away3d.containers.View3D;
	import away3d.core.managers.Stage3DManager;
	import away3d.core.managers.Stage3DProxy;
	import away3d.debug.Trident;
	import away3d.events.Stage3DEvent;
	import away3d.lights.DirectionalLight;
	import away3d.materials.lightpickers.LightPickerBase;
	import away3d.materials.lightpickers.StaticLightPicker;
	
	import core.AshExtension;
	import core.Config;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import mcvs.command.event.GameEvent;
	
	import org.aswing.JButton;
	import org.aswing.JLabel;
	
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;
	
	public class GameFrame extends Sprite
	{
		private var _context:IContext;
		
		private var _uiLayer:Sprite;
		private var _gameLayer:Sprite;
		
		// away3d相关
		private var _stage3DManger:Stage3DManager;
		private var _stage3DProxy:Stage3DProxy;
		private var _profile:String = "baseline"
		private var _view:View3D;
		private var _mainLight:DirectionalLight;
		private var _mainLightPick:LightPickerBase;
		
		public function GameFrame()
		{
			this.addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init( e:Event ):void
		{
			this.removeEventListener( Event.ADDED_TO_STAGE, init );
			
			_uiLayer = new Sprite();
			_gameLayer = new Sprite();
			this.addChild( _uiLayer );
			this.addChild( _gameLayer );
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.stageFocusRect = false;
			
			initContext();
		}
		
		/**
		 * 初始化robotlegs
		 * */
		private function initContext():void
		{
			context = new Context();
			context.injector.map( Context ).toValue( context );
			context.install( MVCSBundle, AshExtension );
			context.configure( new ContextView(this) );
			context.injector.map( GameFrame ).toValue( this );
			context.configure( Config );
		}
		
		
		public function get context():IContext
		{
			return _context;
		}

		public function set context(value:IContext):void
		{
			_context = value;
		}

		public function get view():View3D
		{
			return _view;
		}

		public function set view(value:View3D):void
		{
			_view = value;
		}

		public function get mainLight():DirectionalLight
		{
			return _mainLight;
		}

		public function set mainLight(value:DirectionalLight):void
		{
			_mainLight = value;
		}

		public function get uiLayer():Sprite
		{
			return _uiLayer;
		}

		public function set uiLayer(value:Sprite):void
		{
			_uiLayer = value;
		}

		public function get gameLayer():Sprite
		{
			return _gameLayer;
		}

		public function set gameLayer(value:Sprite):void
		{
			_gameLayer = value;
		}

		public function get stage3DManger():Stage3DManager
		{
			return _stage3DManger;
		}

		public function set stage3DManger(value:Stage3DManager):void
		{
			_stage3DManger = value;
		}

		public function get profile():String
		{
			return _profile;
		}

		public function set profile(value:String):void
		{
			_profile = value;
		}

		public function get stage3DProxy():Stage3DProxy
		{
			return _stage3DProxy;
		}

		public function set stage3DProxy(value:Stage3DProxy):void
		{
			_stage3DProxy = value;
		}

		public function get mainLightPick():LightPickerBase
		{
			return _mainLightPick;
		}

		public function set mainLightPick(value:LightPickerBase):void
		{
			_mainLightPick = value;
		}


	}
}