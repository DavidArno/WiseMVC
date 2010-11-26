/*
 PureMVC - Copyright(c) 2006-08 Futurecale, Inc., Some rights reserved.
 Your reuse is governed by Creative Commons Attribution 2.5 License
*/
package org.wisemvc.as3.patterns.command
{
	import org.wisemvc.as3.core.Controller;

	/**
	 * A MacroCommand subclass used by MacroCommandTest.
	 *
  	 * @see org.puremvc.as3.patterns.command.MacroCommandTest MacroCommandTest
  	 * @see org.puremvc.as3.patterns.command.MacroCommandTestSub1Command MacroCommandTestSub1Command
  	 * @see org.puremvc.as3.patterns.command.MacroCommandTestSub2Command MacroCommandTestSub2Command
  	 * @see org.puremvc.as3.patterns.command.MacroCommandTestVO MacroCommandTestVO
	 */
	public class MacroCommandTestCommand extends MacroCommand
	{
		/**
		 * Constructor.
		 */
		public function MacroCommandTestCommand(controller:Controller)
		{
			super(controller, initializeMacroCommand());
		}
		
		/**
		 * Initialize the MacroCommandTestCommand by adding
		 * its 2 SubCommands.
		 */
		protected function initializeMacroCommand():Array
		{
			return [MacroCommandTestSub1Command, MacroCommandTestSub2Command];
		}		
	}
}