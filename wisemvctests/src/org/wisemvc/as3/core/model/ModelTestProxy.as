package org.wisemvc.as3.core.model
{
	import org.wisemvc.as3.core.Controller;
	import org.wisemvc.as3.core.Model;
	import org.wisemvc.as3.patterns.proxy.Proxy;

	public class ModelTestProxy extends Proxy
	{
		public static const NAME:String = 'ModelTestProxy';
		public static const ON_REGISTER_CALLED:String = 'onRegister Called';
		public static const ON_REMOVE_CALLED:String = 'onRemove Called';

		public function ModelTestProxy(model:Model)
		{
			super(model, NAME, '');
		}

		override public function onRegister():void
		{
			data = ON_REGISTER_CALLED;
		}		

		override public function onRemove():void
		{
			data = ON_REMOVE_CALLED;
		}		
	}
}