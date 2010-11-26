/*
 PureMVC - Copyright(c) 2006-08 Futurecale, Inc., Some rights reserved.
 Your reuse is governed by Creative Commons Attribution 2.5 License
*/
package org.wisemvc.as3.core.view
{
	import org.wisemvc.as3.core.Controller;
	import org.wisemvc.as3.core.View;
	import org.wisemvc.as3.patterns.mediator.Mediator;

   	/**
  	 * A Mediator class used by ViewTest.
  	 * 
  	 * @see org.puremvc.as3.core.view.ViewTest ViewTest
  	 */
	public class ViewTestMediator4 extends Mediator
	{
		/**
		 * The Mediator name
		 */
		public static const NAME:String = 'ViewTestMediator4';
				
		/**
		 * Constructor
		 */
		public function ViewTestMediator4(view:View,  data:Object ) {
			super(view, NAME, data );
		}

		public function get viewTest():ViewTest
		{
			return viewComponent as ViewTest;
		}
				
		override public function onRegister():void
		{
			viewTest.onRegisterCalled = true;
		}
				
		override public function onRemove():void
		{
			viewTest.onRemoveCalled = true;
		}
				
				
	}
}