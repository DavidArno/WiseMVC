/*
 PureMVC - Copyright(c) 2006-08 Futurecale, Inc., Some rights reserved.
 Your reuse is governed by Creative Commons Attribution 2.5 License
*/
package org.wisemvc.as3.patterns.command
{
   	/**
  	 * A utility class used by MacroCommandTest.
  	 * 
  	 * @see org.puremvc.as3.patterns.command.MacroCommandTest MacroCommandTest
  	 * @see org.puremvc.as3.patterns.command.MacroCommandTestCommand MacroCommandTestCommand
   	 * @see org.puremvc.as3.patterns.command.MacroCommandTestSub1Command MacroCommandTestSub1Command
  	 * @see org.puremvc.as3.patterns.command.MacroCommandTestSub2Command MacroCommandTestSub2Command
 	 */
	public class MacroCommandTestVO
	{
		/**
		 * Constructor.
		 * 
		 * @param input the number to be fed to the MacroCommandTestCommand
		 */
		public function MacroCommandTestVO (input:Number){
			this.input = input;
		}
		public var input:Number;
		public var result1:Number;
		public var result2:Number;
	}
}