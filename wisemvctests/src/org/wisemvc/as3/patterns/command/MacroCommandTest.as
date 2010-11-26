/*
 PureMVC - Copyright(c) 2006-08 Futurecale, Inc., Some rights reserved.
 Your reuse is governed by Creative Commons Attribution 2.5 License
*/
package org.wisemvc.as3.patterns.command
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import org.wisemvc.as3.core.Controller;
	import org.wisemvc.as3.interfaces.INotification;
	import org.wisemvc.as3.patterns.observer.Notification;
 	
	/**
	 * Test the PureMVC SimpleCommand class.
	 *
  	 * @see org.puremvc.as3.patterns.command.MacroCommandTestVO MacroCommandTestVO
  	 * @see org.puremvc.as3.patterns.command.MacroCommandTestCommand MacroCommandTestCommand
	 */
 	public class MacroCommandTest extends TestCase {
  		
		protected var controller:Controller;

		/**
  		 * Constructor.
  		 * 
  		 * @param methodName the name of the test method an instance to run
  		 */
  	    public function MacroCommandTest( methodName:String ) {
   			super( methodName );
			controller = new Controller();
           }
  	
		/**
		 * Create the TestSuite.
		 */
  		public static function suite():TestSuite {
  			
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new MacroCommandTest( "testMacroCommandExecute" ) );
   			
   			return ts;
   		}
  		
  		/**
  		 * Tests operation of a <code>MacroCommand</code>.
  		 * 
  		 * <P>
  		 * This test creates a new <code>Notification</code>, adding a 
  		 * <code>MacroCommandTestVO</code> as the body. 
  		 * It then creates a <code>MacroCommandTestCommand</code> and invokes
  		 * its <code>execute</code> method, passing in the 
  		 * <code>Notification</code>.<P>
  		 * 
  		 * <P>
  		 * The <code>MacroCommandTestCommand</code> has defined an
  		 * <code>initializeMacroCommand</code> method, which is 
  		 * called automatically by its constructor. In this method
  		 * the <code>MacroCommandTestCommand</code> adds 2 SubCommands
  		 * to itself, <code>MacroCommandTestSub1Command</code> and
  		 * <code>MacroCommandTestSub2Command</code>.
  		 * 
  		 * <P>
  		 * The <code>MacroCommandTestVO</code> has 2 result properties,
  		 * one is set by <code>MacroCommandTestSub1Command</code> by
  		 * multiplying the input property by 2, and the other is set
  		 * by <code>MacroCommandTestSub2Command</code> by multiplying
  		 * the input property by itself. 
  		 * 
  		 * <P>
  		 * Success is determined by evaluating the 2 result properties
  		 * on the <code>MacroCommandTestVO</code> that was passed to 
  		 * the <code>MacroCommandTestCommand</code> on the Notification 
  		 * body.</P>
  		 * 
  		 */
  		public function testMacroCommandExecute():void {
  			
  			// Create the VO
  			var vo:MacroCommandTestVO = new MacroCommandTestVO(5);
  			
  			// Create the Notification (note)
  			var note:INotification = new Notification('MacroCommandTest', vo);

			// Create the SimpleCommand  			
			var command:MacroCommandTestCommand = new MacroCommandTestCommand(controller);
   			
   			// Execute the SimpleCommand
   			command.execute(note);
   			
   			// test assertions
   			assertTrue( "Expecting vo.result1 == 10", vo.result1 == 10 );
   			assertTrue( "Expecting vo.result2 == 25", vo.result2 == 25 );
   			
   		}
   		
  	}
}