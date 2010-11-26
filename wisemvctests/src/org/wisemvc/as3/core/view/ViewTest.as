/*
 PureMVC - Copyright(c) 2006-08 Futurecale, Inc., Some rights reserved.
 Your reuse is governed by Creative Commons Attribution 2.5 License
*/
package org.wisemvc.as3.core.view
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import org.wisemvc.as3.core.Controller;
	import org.wisemvc.as3.core.View;
	import org.wisemvc.as3.interfaces.IMediator;
	import org.wisemvc.as3.patterns.mediator.Mediator;
	import org.wisemvc.as3.patterns.observer.Notification;
 	
  	/**
	 * Test the PureMVC View class.
	 */
	public class ViewTest extends TestCase {
  		
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
  	    public function ViewTest( methodName:String ) {
   			super( methodName );
        }
  	
 		/**
		 * Create the TestSuite.
		 */
 		public static function suite():TestSuite {
  			
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new ViewTest( "testGetInstance" ) );
   			ts.addTest( new ViewTest( "testRegisterAndRetrieveMediator" ) );
   			ts.addTest( new ViewTest( "testHasMediator" ) );
   			ts.addTest( new ViewTest( "testRegisterAndRemoveMediator" ) );
   			ts.addTest( new ViewTest( "testOnRegisterAndOnRemove" ) );
   			ts.addTest( new ViewTest( "testSuccessiveRegisterAndRemoveMediator" ) );
   			ts.addTest( new ViewTest( "testRemoveMediatorAndSubsequentNotify" ) );
   			ts.addTest( new ViewTest( "testRemoveOneOfTwoMediatorsAndSubsequentNotify" ) );
   			ts.addTest( new ViewTest( "testMediatorReregistration" ) );
   			ts.addTest( new ViewTest( "testModifyObserverListDuringNotification" ) );
   			return ts;
   		}
  		
  		/**
  		 * Tests the View Singleton Factory Method 
  		 */
  		public function testGetInstance():void {
  			
   			// Test Factory Method
			var controller:Controller = new Controller();
   			var view:View = controller.view;
   			
   			// test assertions
   			assertTrue( "Expecting instance not null", view != null );
   		}
   		
  		/**
  		 * A test variable that proves the viewTestMethod was
  		 * invoked by the View.
  		 */
  		private var viewTestVar:Number;

		/**
		 * Tests registering and retrieving a mediator with
		 * the View.
		 */
		public function testRegisterAndRetrieveMediator():void {
			
  			// Get the Singleton View instance
			var controller:Controller = new Controller();
			var view:View = controller.view;

			// Create and register the test mediator
			var viewTestMediator:ViewTestMediator = new ViewTestMediator(controller.view, this );
			view.registerMediator( viewTestMediator );
			
			// Retrieve the component
			var mediator:IMediator = view.retrieveMediator( ViewTestMediator.NAME ) as IMediator;
			
			// test assertions  			
   			assertTrue( "Expecting comp is ViewTestMediator", mediator is ViewTestMediator );
		}
 		
  		/**
  		 * Tests the hasMediator Method
  		 */
  		public function testHasMediator():void {
  			
   			// register a Mediator
			var controller:Controller = new Controller();
			var view:View = controller.view;
			
			// Create and register the test mediator
			var mediator:Mediator = new Mediator(controller.view, 'hasMediatorTest', this );
			view.registerMediator( mediator );
			
   			// assert that the view.hasMediator method returns true
   			// for that mediator name
   			assertTrue( "Expecting view.hasMediator('hasMediatorTest') == true", 
   						view.hasMediator('hasMediatorTest') == true);

			view.removeMediator( 'hasMediatorTest' );
			
   			// assert that the view.hasMediator method returns false
   			// for that mediator name
   			assertTrue( "Expecting view.hasMediator('hasMediatorTest') == false", 
   						view.hasMediator('hasMediatorTest') == false);

   		}

		/**
		 * Tests registering and removing a mediator 
		 */
		public function testRegisterAndRemoveMediator():void {
			
  			// Get the Singleton View instance
			var controller:Controller = new Controller();
			var view:View = controller.view;

			// Create and register the test mediator
			var mediator:IMediator = new Mediator(controller.view, 'testing', this );
			view.registerMediator( mediator );
			
			// Remove the component
			var removedMediator:IMediator = view.removeMediator( 'testing' ) as IMediator;
			
			// assert that we have removed the appropriate mediator
   			assertTrue( "Expecting removedMediator.getMediatorName() == 'testing'", 
						removedMediator.mediatorName == 'testing');
				
			// assert that the mediator is no longer retrievable
   			assertTrue( "Expecting view.retrieveMediator( 'testing' ) == null )", 
   						view.retrieveMediator( 'testing' ) == null );
		}
		
		/**
		 * Tests that the View callse the onRegister and onRemove methods
		 */
		public function testOnRegisterAndOnRemove():void {
			
  			// Get the Singleton View instance
			var controller:Controller = new Controller();
			var view:View = controller.view;

			// Create and register the test mediator
			var mediator:IMediator = new ViewTestMediator4(view, this );
			view.registerMediator( mediator );

			// assert that onRegsiter was called, and the mediator responded by setting our boolean
   			assertTrue( "Expecting onRegisterCalled == true", 
						onRegisterCalled);
				
			
			// Remove the component
			view.removeMediator( ViewTestMediator4.NAME ) as IMediator;
			
			// assert that the mediator is no longer retrievable
   			assertTrue( "Expecting onRemoveCalled == true", 
   						onRemoveCalled );
		}
		
		
		/**
		 * Tests successive regster and remove of same mediator.
		 */
		public function testSuccessiveRegisterAndRemoveMediator():void {
			
  			// Get the Singleton View instance
			var controller:Controller = new Controller();
			var view:View = controller.view;

			// Create and register the test mediator, 
			// but not so we have a reference to it
			view.registerMediator( new ViewTestMediator(controller.view, this ) );
			
			// test that we can retrieve it
   			assertTrue( "Expecting view.retrieveMediator( ViewTestMediator.NAME ) is ViewTestMediator", 
   			view.retrieveMediator( ViewTestMediator.NAME ) is ViewTestMediator );

			// Remove the Mediator
			view.removeMediator( ViewTestMediator.NAME );

			// test that retrieving it now returns null			
   			assertTrue( "Expecting view.retrieveMediator( ViewTestMediator.NAME ) == null", 
   			view.retrieveMediator( ViewTestMediator.NAME ) == null );

			// test that removing the mediator again once its gone doesn't cause crash 		
   			assertTrue( "Expecting view.removeMediator( ViewTestMediator.NAME ) doesn't crash", 
   			view.removeMediator( ViewTestMediator.NAME ) == void);

			// Create and register another instance of the test mediator, 
			view.registerMediator( new ViewTestMediator(controller.view, this ) );
			
   			assertTrue( "Expecting view.retrieveMediator( ViewTestMediator.NAME ) is ViewTestMediator", 
   			view.retrieveMediator( ViewTestMediator.NAME ) is ViewTestMediator );

			// Remove the Mediator
			view.removeMediator( ViewTestMediator.NAME );
			
			// test that retrieving it now returns null			
   			assertTrue( "Expecting view.retrieveMediator( ViewTestMediator.NAME ) == null", 
   			view.retrieveMediator( ViewTestMediator.NAME ) == null );
		}
		
		/**
		 * Tests registering a Mediator for 2 different notifications, removing the
		 * Mediator from the View, and seeing that neither notification causes the
		 * Mediator to be notified. Added for the fix deployed in version 1.7
		 */
		public function testRemoveMediatorAndSubsequentNotify():void {
			
  			// Get the Singleton View instance
			var controller:Controller = new Controller();
			var view:View = controller.view;
			
			// Create and register the test mediator to be removed.
			view.registerMediator( new ViewTestMediator2(view, this ) );
			
			// test that notifications work
			controller.notifyObservers( new Notification(NOTE1) );
   			assertTrue( "Expecting lastNotification == NOTE1", 
		   			lastNotification == NOTE1);

			controller.notifyObservers( new Notification(NOTE2) );
   			assertTrue( "Expecting lastNotification == NOTE2", 
		   			lastNotification == NOTE2);

			// Remove the Mediator
			view.removeMediator( ViewTestMediator2.NAME );

			// test that retrieving it now returns null			
   			assertTrue( "Expecting view.retrieveMediator( ViewTestMediator2.NAME ) == null", 
   			view.retrieveMediator( ViewTestMediator2.NAME ) == null );

			// test that notifications no longer work
			// (ViewTestMediator2 is the one that sets lastNotification
			// on this component, and ViewTestMediator)
			lastNotification = null;
			
			controller.notifyObservers( new Notification(NOTE1) );
   			assertTrue( "Expecting lastNotification != NOTE1", 
		   			lastNotification != NOTE1);

			controller.notifyObservers( new Notification(NOTE2) );
   			assertTrue( "Expecting lastNotification != NOTE2", 
		   			lastNotification != NOTE2);
		}
		
		/**
		 * Tests registering one of two registered Mediators and seeing
		 * that the remaining one still responds.
		 * Added for the fix deployed in version 1.7.1
		 */
		public function testRemoveOneOfTwoMediatorsAndSubsequentNotify():void {
			
  			// Get the Singleton View instance
			var controller:Controller = new Controller();
			var view:View = controller.view;
			
			// Create and register that responds to notifications 1 and 2
			view.registerMediator( new ViewTestMediator2(view, this ) );
			
			// Create and register that responds to notification 3
			view.registerMediator( new ViewTestMediator3(view, this ) );
			
			// test that all notifications work
   			controller.notifyObservers( new Notification(NOTE1) );
   			assertTrue( "Expecting lastNotification == NOTE1", 
		   			lastNotification == NOTE1);

   			controller.notifyObservers( new Notification(NOTE2) );
   			assertTrue( "Expecting lastNotification == NOTE2", 
		   			lastNotification == NOTE2);

   			controller.notifyObservers( new Notification(NOTE3) );
   			assertTrue( "Expecting lastNotification == NOTE3", 
		   			lastNotification == NOTE3);
		   			
			// Remove the Mediator that responds to 1 and 2
			view.removeMediator( ViewTestMediator2.NAME );

			// test that retrieving it now returns null			
   			assertTrue( "Expecting view.retrieveMediator( ViewTestMediator2.NAME ) == null", 
   			view.retrieveMediator( ViewTestMediator2.NAME ) == null );

			// test that notifications no longer work
			// for notifications 1 and 2, but still work for 3
			lastNotification = null;
			
   			controller.notifyObservers( new Notification(NOTE1) );
   			assertTrue( "Expecting lastNotification != NOTE1", 
		   			lastNotification != NOTE1);

   			controller.notifyObservers( new Notification(NOTE2) );
   			assertTrue( "Expecting lastNotification != NOTE2", 
		   			lastNotification != NOTE2);

   			controller.notifyObservers( new Notification(NOTE3) );
   			assertTrue( "Expecting lastNotification == NOTE3", 
		   			lastNotification == NOTE3);
		}
		
		/**
		 * Tests registering the same mediator twice. 
		 * A subsequent notification should only illicit
		 * one response. Also, since reregistration
		 * was causing 2 observers to be created, ensure
		 * that after removal of the mediator there will
		 * be no further response.
		 * 
		 * Added for the fix deployed in version 2.0.4
		 */
		public function testMediatorReregistration():void {
			
  			// Get the Singleton View instance
			var controller:Controller = new Controller();
			var view:View = controller.view;
			
			// Create and register that responds to notification 5
			view.registerMediator( new ViewTestMediator5(view, this ) );
			
			// try to register another instance of that mediator (uses the same NAME constant).
			view.registerMediator( new ViewTestMediator5(view, this ) );
			
			// test that the counter is only incremented once (mediator 5's response) 
			counter=0;
   			controller.notifyObservers( new Notification(NOTE5) );
   			assertEquals( "Expecting counter == 1",  1, counter);

			// Remove the Mediator 
			view.removeMediator( ViewTestMediator5.NAME );

			// test that retrieving it now returns null			
   			assertTrue( "Expecting view.retrieveMediator( ViewTestMediator5.NAME ) == null", 
   			view.retrieveMediator( ViewTestMediator5.NAME ) == null );

			// test that the counter is no longer incremented  
			counter=0;
   			controller.notifyObservers( new Notification(NOTE5) );
   			assertEquals( "Expecting counter == 0", 0,  counter);
		}
		
		
		/**
		 * Tests the ability for the observer list to 
		 * be modified during the process of notification,
		 * and all observers be properly notified. This
		 * happens most often when multiple Mediators
		 * respond to the same notification by removing
		 * themselves.  
		 * 
		 * Added for the fix deployed in version 2.0.4
		 */
		public function testModifyObserverListDuringNotification():void {
			
  			// Get the Singleton View instance
			var controller:Controller = new Controller();
			var view:View = controller.view;
			
			// Create and register several mediator instances that respond to notification 6 
			// by removing themselves, which will cause the observer list for that notification 
			// to change. versions prior to Standard Version 2.0.4 will see every other mediator
			// fails to be notified.  
			view.registerMediator( new ViewTestMediator6(controller.view, ViewTestMediator6+"/1", this ) );
			view.registerMediator( new ViewTestMediator6(controller.view, ViewTestMediator6+"/2", this ) );
			view.registerMediator( new ViewTestMediator6(controller.view, ViewTestMediator6+"/3", this ) );
			view.registerMediator( new ViewTestMediator6(controller.view, ViewTestMediator6+"/4", this ) );
			view.registerMediator( new ViewTestMediator6(controller.view, ViewTestMediator6+"/5", this ) );
			view.registerMediator( new ViewTestMediator6(controller.view, ViewTestMediator6+"/6", this ) );
			view.registerMediator( new ViewTestMediator6(controller.view, ViewTestMediator6+"/7", this ) );
			view.registerMediator( new ViewTestMediator6(controller.view, ViewTestMediator6+"/8", this ) );

			// clear the counter
			counter=0;
			// send the notification. each of the above mediators will respond by removing
			// themselves and incrementing the counter by 1. This should leave us with a
			// count of 8, since 8 mediators will respond.
			controller.notifyObservers( new Notification( NOTE6 ) );
			// verify the count is correct
   			assertEquals( "Expecting counter == 8", 8, counter);
	
			// clear the counter
			counter=0;
			controller.notifyObservers( new Notification( NOTE6 ) );
			// verify the count is 0
   			assertEquals( "Expecting counter == 0", 0, counter);

		}
 	}
}