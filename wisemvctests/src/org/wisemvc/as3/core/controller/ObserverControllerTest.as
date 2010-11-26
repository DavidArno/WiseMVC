/*
 PureMVC - Copyright(c) 2006-08 Futurecale, Inc., Some rights reserved.
 Your reuse is governed by Creative Commons Attribution 2.5 License
*/
package org.wisemvc.as3.core.controller
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import org.wisemvc.as3.core.Controller;
	import org.wisemvc.as3.interfaces.INotification;
	import org.wisemvc.as3.patterns.observer.Observer;
	
  	/**
	 * Test the PureMVC View class.
	 */
	public class ObserverControllerTest extends TestCase {
  		
  		public var lastNotification:String;	
  		public var onRegisterCalled:Boolean = false;
  		public var onRemoveCalled:Boolean = false;
  		public var counter:Number = 0;
  		
 		public static const NOTE1:String = "Notification1";
		public static const NOTE2:String = "Notification2";
		public static const NOTE3:String = "Notification3";
		public static const NOTE4:String = "Notification4";
		public static const NOTE5:String = "Notification5";
		public static const NOTE6:String = "Notification6";
 	
  		/**
  		 * Constructor.
  		 * 
  		 * @param methodName the name of the test method an instance to run
  		 */
  	    public function ObserverControllerTest( methodName:String ) {
   			super( methodName );
        }
  	
 		/**
		 * Create the TestSuite.
		 */
 		public static function suite():TestSuite {
  			
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new ObserverControllerTest( "testRegisterAndNotifyObserver" ) );
   			return ts;
   		}
  		
  		/**
  		 * Tests registration and notification of Observers.
  		 * 
  		 * <P>
  		 * An Observer is created to callback the viewTestMethod of
  		 * this ViewTest instance. This Observer is registered with
  		 * the View to be notified of 'ViewTestEvent' events. Such
  		 * an event is created, and a value set on its payload. Then
  		 * the View is told to notify interested observers of this
  		 * Event. 
  		 * 
  		 * <P>
  		 * The View calls the Observer's notifyObserver method
  		 * which calls the viewTestMethod on this instance
  		 * of the ViewTest class. The viewTestMethod method will set 
  		 * an instance variable to the value passed in on the Event
  		 * payload. We evaluate the instance variable to be sure
  		 * it is the same as that passed out as the payload of the 
  		 * original 'ViewTestEvent'.
  		 * 
 		 */
  		public function testRegisterAndNotifyObserver():void {
  			
  			// Get the Singleton View instance
  			var controller:Controller = new Controller();
  			
   			// Create observer, passing in notification method and context
   			var observer:Observer = new Observer(viewTestMethod, this );
   			
   			// Register Observer's interest in a particulat Notification with the View 
   			controller.registerObserver(ObserverTestNote.NAME, observer);
  			
   			// Create a ViewTestNote, setting 
   			// a body value, and tell the View to notify 
   			// Observers. Since the Observer is this class 
   			// and the notification method is viewTestMethod,
   			// successful notification will result in our local 
   			// viewTestVar being set to the value we pass in 
   			// on the note body.
   			var note:INotification = ObserverTestNote.create(10);
			controller.notifyObservers(note);

			// test assertions  			
   			assertTrue( "Expecting viewTestVar = 10", testVar == 10 );
   		}
		
		private var testVar:Number;
		
		/**
		 * A utility method to test the notification of Observers by the view
		 */
		private function viewTestMethod( note:INotification ) : void
		{
			// set the local viewTestVar to the number on the event payload
			testVar = note.body as Number;
		}
 	}
}