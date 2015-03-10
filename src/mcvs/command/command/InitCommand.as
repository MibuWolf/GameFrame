package mcvs.command.command
{
	import Camera.CameraManager;
	import Camera.CameraType;
	
	import ash.core.Engine;
	import ash.core.Entity;
	import ash.tools.ComponentPool;
	
	import away3d.containers.View3D;
	import away3d.core.managers.Stage3DManager;
	import away3d.debug.Trident;
	import away3d.events.Stage3DEvent;
	import away3d.lights.DirectionalLight;
	import away3d.materials.lightpickers.StaticLightPicker;
	
	import ecs.component.C3DTerrain;
	import ecs.system.SceneSystem;
	
	import flash.events.Event;
	
	import mcvs.ui.helloworld.HelloWorldView;
	
	import org.aswing.JFrame;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	
	import robotlegs.bender.framework.impl.Context;

	public class InitCommand
	{
		[Inject]
		public var context:Context;
		
		[Inject]
		public var gameRoot:GameFrame;
		
		[Inject]
		public var engine:Engine;
		
		public function InitCommand()
		{
		}
		
		public function execute():void
		{
			gameRoot.uiLayer.addChild( new HelloWorldView() );
			
			initSystem();
			
			initAway3D();
		}
		
		
		/**
		 * 初始化away3d引擎
		 * */
		private function initAway3D():void
		{
			if( !gameRoot.stage3DManger && gameRoot.gameLayer.stage )
			{
				gameRoot.stage3DManger = Stage3DManager.getInstance( gameRoot.gameLayer.stage );
				gameRoot.stage3DProxy = gameRoot.stage3DManger.getFreeStage3DProxy( false, gameRoot.profile );
				gameRoot.stage3DProxy .addEventListener( Stage3DEvent.CONTEXT3D_CREATED, onContextCreated );
				gameRoot.stage3DProxy .antiAlias = 0;
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
			gameRoot.stage3DProxy.removeEventListener( Stage3DEvent.CONTEXT3D_CREATED, onContextCreated );
			
			
			if( gameRoot.view )
			{
				gameRoot.view.dispose();
				gameRoot.view = null;
			}
			
			gameRoot.view = new View3D( null, null, null, false, gameRoot.profile );
			gameRoot.view.stage3DProxy = gameRoot.stage3DProxy;	
			gameRoot.gameLayer.stage.addChild( gameRoot.view );
			onResize(null);
			
			gameRoot.view.camera.lens.far = 10000;
			gameRoot.view.camera.lens.near = 1;
			gameRoot.view.camera.y = 300;
			
			
			gameRoot.mainLight = new DirectionalLight(300, -300, -5000);
			gameRoot.mainLight.color = 0xfffdc5;
			gameRoot.mainLight.ambient = 1;
			gameRoot.view.scene.addChild(gameRoot.mainLight);
			
			var t:Trident = new Trident( 500 );
			t.x = -50;	t.y =290; t.z = -1000;
			gameRoot.view.scene.addChild( t );
			
			gameRoot.mainLightPick = new StaticLightPicker( [gameRoot.mainLight] );
			
			CameraManager.getInstance().createCameraController( CameraType.FIRSTPERSONMODEL, gameRoot.view.camera, null, 180, 0 );
			
			if( !gameRoot.gameLayer.hasEventListener(Event.ENTER_FRAME) )
			{
				gameRoot.gameLayer.addEventListener(Event.ENTER_FRAME, onFrame );
			}
			
			gameRoot.stage.addEventListener(Event.RESIZE,onResize);
			
			initScene();
		}
		
		
		/**
		 * 舞台大小发生变化
		 * */
		private function onResize(e:Event):void
		{
			if( this.gameRoot.view )
			{
				this.gameRoot.view.width = this.gameRoot.gameLayer.stage.stageWidth;
				this.gameRoot.view.height = this.gameRoot.gameLayer.stage.stageHeight;
			}
		}
		
		
		private function initSystem():void
		{
			var sceneSys:SceneSystem = new SceneSystem();
			context.injector.map( SceneSystem ).toValue( sceneSys );
			context.injector.injectInto( sceneSys );
			engine.addSystem( sceneSys, 1 );
		}
		
		
		private function onFrame(e:Event):void
		{
			gameRoot.view.render();
		}
		
		
		private function initScene():Entity
		{	
			var entity:Entity = new Entity();
			
			var sceneComponent:C3DTerrain = new C3DTerrain( "D:/MyCode/GameFrame/Asset/terrain/terrain_diffuse.jpg","D:/MyCode/GameFrame/Asset/terrain/terrain_heights.jpg" );

			entity.add( sceneComponent );
			
			engine.addEntity( entity );
			return entity;
		}
	}
}