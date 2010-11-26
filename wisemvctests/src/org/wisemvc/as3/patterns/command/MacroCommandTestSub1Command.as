/*
 PureMVC - Copyright(c) 2006-08 Futurecale, Inc., Some rights reserved.
 Your reuse is governed by Creative Commons Attribution 2.5 License
*/
package org.wisemvc.as3.patterns.command
{
	import org.wisemvc.as3.core.Controller;
	import org.wisemvc.as3.interfaces.INotification;

	/**
	 * A SimpleCommand subclass used by MacroCommandTestCommand.
	 *
  	 * @see org.puremvc.as3.patterns.command.MacroCommandTest MacroCommandTest
  	 * @see org.puremvc.as3.patterns.command.MacroCommandTestCommand MacroCommandTestCommand
  	 * @see org.puremvc.as3.patterns.command.MacroCommandTestVO MacroCommandTestVO
	 */
	public class MacroCommandTestSub1Command extends SimpleCommand
	{
		public function MacroCommandTestSub1Command(controller:Controller)
		{
			super(controller);
		}
		
		/**
		 * Fabricate a result by multiplying the input by 2
		 * 
		 * @param event the <code>IEvent</code> carrying the <code>MacroCommandTestVO</code>
		 */
		override public function execute( note:INotification ) :void
		{
			
			var vo:MacroCommandTestVO = note.body as MacroCommandTestVO;
			
			// Fabricate a result
			vo.result1 = 2 * vo.input;

		}
		
	}
}