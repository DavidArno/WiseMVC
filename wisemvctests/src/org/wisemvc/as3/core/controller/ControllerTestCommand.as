/*
 PureMVC - Copyright(c) 2006-08 Futurecale, Inc., Some rights reserved.
 Your reuse is governed by Creative Commons Attribution 2.5 License
*/
package org.wisemvc.as3.core.controller
{
	import org.wisemvc.as3.core.Controller;
	import org.wisemvc.as3.interfaces.INotification;
	import org.wisemvc.as3.patterns.command.SimpleCommand;

	/**
	 * A SimpleCommand subclass used by ControllerTest.
	 *
  	 * @see org.puremvc.as3.core.controller.ControllerTest ControllerTest
  	 * @see org.puremvc.as3.core.controller.ControllerTestVO ControllerTestVO
	 */
	public class ControllerTestCommand extends SimpleCommand
	{

		/**
		 * Constructor.
		 */
		public function ControllerTestCommand(controller:Controller)
		{
			super(controller);
		}
		
		/**
		 * Fabricate a result by multiplying the input by 2
		 * 
		 * @param note the note carrying the ControllerTestVO
		 */
		override public function execute( note:INotification ) :void
		{
			
			var vo:ControllerTestVO = note.body as ControllerTestVO;
			
			// Fabricate a result
			vo.result = 2 * vo.input;

		}
		
	}
}