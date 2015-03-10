package ecs.system
{
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;
	
	import ecs.node.SceneNode;

	public class SceneSystem extends System
	{
		[Inject]
		public var gameRoot:GameFrame;
		
		private var _sceneList:NodeList;
		
		public function SceneSystem()
		{
			super();
		}
		
		
		/**
		 * 添加到ASH引擎 
		 * */
		override public function addToEngine(engine:Engine):void
		{
			_sceneList = engine.getNodeList( SceneNode );
			
			_sceneList.nodeAdded.add( onAdded );
			_sceneList.nodeRemoved.add( onRemoved );
		}
		
		
		private function onAdded( node:SceneNode ):void
		{
			if( node.terrain )
			{
				gameRoot.view.scene.addChild( node.terrain );
			}
		}
		
		
		private function onRemoved( node:SceneNode ):void
		{
			if( node.terrain )
			{
				gameRoot.view.scene.removeChild( node.terrain );
			}
		}
		
		
		/**
		 * 从引擎中移除
		 * */
		override public function removeFromEngine( engine:Engine ):void
		{
			
		}
		
		
		
		override public function update(time:Number):void
		{
		
		}
	}
}