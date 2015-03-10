package
{
	import away3d.containers.View3D;
	import away3d.core.managers.Stage3DManager;
	import away3d.core.managers.Stage3DProxy;
	import away3d.debug.Trident;
	import away3d.events.Stage3DEvent;
	import away3d.lights.DirectionalLight;
	import away3d.materials.lightpickers.LightPickerBase;
	import away3d.materials.lightpickers.StaticLightPicker;
	
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
	
	import robotlegscore.AshExtension;
	import robotlegscore.Config;
	
	public class GameFrame extends Sprite
	{
		private var _context:IContext;
		
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
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.stageFocusRect = false;
			
			initContext();
			
			initAway3D();
		}
		
		/**
		 * 初始化robotlegs
		 * */
		private function initContext():void
		{
			context = new Context();
			context.install( MVCSBundle, AshExtension );
			context.configure( new ContextView(this) );
			context.injector.map( GameFrame ).toValue( this );
			context.configure( Config );
		}
		
		
		/**
		 * 初始化away3d引擎
		 * */
		private function initAway3D():void
		{
			if( !_stage3DManger && stage )
			{
				_stage3DManger = Stage3DManager.getInstance( stage );
				_stage3DProxy = _stage3DManger.getFreeStage3DProxy( false, _profile );
				_stage3DProxy.addEventListener( Stage3DEvent.CONTEXT3D_CREATED, onContextCreated );
				_stage3DProxy.antiAlias = 0;
			}
			else
			{
				onContextCreated( null );
			}
		}

		
		/**
		 * 创建完成真正开始初始化
		 * */
		private function onContextCreated(e:Stage3DEvent):void
		{
			_stage3DProxy.removeEventListener( Stage3DEvent.CONTEXT3D_CREATED, onContextCreated );
			
			
			if( _view )
			{
				_view.dispose();
				_view = null;
			}
			
			_view = new View3D( null, null, null, false, _profile );
			_view.stage3DProxy = _stage3DProxy;	
			stage.addChild( _view );
			onResize(null);
			
			_view.camera.lens.far = 10000;
			_view.camera.lens.near = 1;
			_view.camera.y = 300;
			
			
			_mainLight = new DirectionalLight(300, -300, -5000);
			_mainLight.color = 0xfffdc5;
			_mainLight.ambient = 1;
			_view.scene.addChild(_mainLight);
			
			var t:Trident = new Trident( 500 );
			t.x = -50;	t.y =290; t.z = -1000;
			_view.scene.addChild( t );
			
			_mainLightPick = new StaticLightPicker( [_mainLight] );
		}
		
		
		/**
		 * 舞台大小发生变化
		 * */
		private function onResize(e:Event):void
		{
			if( this._view )
			{
				this._view.width = this.stage.stageWidth;
				this._view.height = this.stage.stageHeight;
			}
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


	}
}