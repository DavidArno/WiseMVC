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
	public class ViewTestMediator extends Mediator 
	{
		/**
		 * The Mediator name
		 */
		public static const NAME:String = 'ViewTestMediator';
		
		/**
		 * Constructor
		 */
		public function ViewTestMediator(view:View, data:Object ) {
			super(view, NAME, data );
		}

		override public function get notificationInterests():Array
		{
			// be sure that the mediator has some Observers created
			// in order to test removeMediator
			return [ 'ABC', 'DEF', 'GHI'  ];
		}

	}
}