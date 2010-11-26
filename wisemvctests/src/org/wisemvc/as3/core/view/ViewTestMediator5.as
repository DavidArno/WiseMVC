/*
 PureMVC - Copyright(c) 2006-08 Futurecale, Inc., Some rights reserved.
 Your reuse is governed by Creative Commons Attribution 2.5 License
*/
package org.wisemvc.as3.core.view
{
	import org.wisemvc.as3.core.Controller;
	import org.wisemvc.as3.core.View;
	import org.wisemvc.as3.interfaces.INotification;
	import org.wisemvc.as3.patterns.mediator.Mediator;

   	/**
  	 * A Mediator class used by ViewTest.
  	 * 
  	 * @see org.puremvc.as3.core.view.ViewTest ViewTest
  	 */
	public class ViewTestMediator5 extends Mediator
	{
		/**
		 * The Mediator name
		 */
		public static const NAME:String = 'ViewTestMediator5';
				
		/**
		 * Constructor
		 */
		public function ViewTestMediator5(view:View,  data:Object ) {
			super(view, NAME, data );
		}

		override public function get notificationInterests():Array
		{
			return [ ViewTest.NOTE5 ];
		}

		override public function handleNotification( note:INotification ):void
		{
			viewTest.counter++;
		}

		public function get viewTest():ViewTest
		{
			return viewComponent as ViewTest;
		}
	}
}