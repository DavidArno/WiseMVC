/*
 PureMVC - Copyright(c) 2006-08 Futurecale, Inc., Some rights reserved.
 Your reuse is governed by Creative Commons Attribution 2.5 License
*/
package org.wisemvc.as3.patterns.mediator
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import org.wisemvc.as3.core.Controller;
 	
 	/**
	 * Test the PureMVC Mediator class.
	 * 
	 * @see org.puremvc.as3.interfaces.IMediator IMediator
	 * @see org.puremvc.as3.patterns.mediator.Mediator Mediator
	 */
	public class MediatorTest extends TestCase {
  		
		protected var controller:Controller;
		
   		/**
  		 * Constructor.
  		 * 
  		 * @param methodName the name of the test method an instance to run
  		 */
 	    public function MediatorTest ( methodName:String ) {
   			super( methodName );
			controller = new Controller();
           }
  	
 		/**
		 * Create the TestSuite.
		 */
 		public static function suite():TestSuite {
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new MediatorTest( "testNameAccessor" ) );
   			ts.addTest( new MediatorTest( "testViewAccessor" ) );

   			return ts;
   		}
  		

  		/**
  		 * Tests getting the name using Mediator class accessor method. 
  		 */
  		public function testNameAccessor():void {

			// Create a new Mediator and use accessors to set the mediator name 
   			var mediator:Mediator = new Mediator(controller.view);
   			
   			// test assertions
   			assertTrue( "Expecting mediator.getMediatorName() == Mediator.NAME", mediator.mediatorName == Mediator.NAME );
   		}

  		/**
  		 * Tests getting the name using Mediator class accessor method. 
  		 */
  		public function testViewAccessor():void {

			// Create a view object
			var view:Object = new Object();
			
			// Create a new Proxy and use accessors to set the proxy name 
   			var mediator:Mediator = new Mediator(controller.view, Mediator.NAME, view );
			   			
   			// test assertions
   			assertNotNull( "Expecting mediator.getViewComponent() not null", mediator.viewComponent);
   		}

  	}
}