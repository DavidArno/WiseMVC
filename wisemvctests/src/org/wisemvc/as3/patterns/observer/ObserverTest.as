/*
 PureMVC - Copyright(c) 2006-08 Futurescale, Inc., Some rights reserved.
 Your reuse is governed by Creative Commons Attribution 2.5 License
*/
package org.wisemvc.as3.patterns.observer
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import org.wisemvc.as3.interfaces.INotification;
 	
   	/**
  	 * Tests PureMVC Observer class.
  	 * 
  	 * <P>
  	 * Since the Observer encapsulates the interested object's
  	 * callback information, there are no getters, only setters. 
  	 * It is, in effect write-only memory.</P>
  	 * 
  	 * <P>
  	 * Therefore, the only way to test it is to set the 
  	 * notification method and context and call the notifyObserver
  	 * method.</P>
  	 * 
  	 */
	public class ObserverTest extends TestCase {
  		
  		/**
  		 * Constructor.
  		 * 
  		 * @param methodName the name of the test method an instance to run
  		 */
  	    public function ObserverTest ( methodName:String ) {
   			super( methodName );
           }
  	
 		/**
		 * Create the TestSuite.
		 */
 		public static function suite():TestSuite {
  			
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new ObserverTest ( "testObserverConstructor" ) );
   			ts.addTest( new ObserverTest ( "testCompareNotifyContext" ) );
   			
   			return ts;
   		}
  		
  		/**
  		 * Tests observer class when initialized by accessor methods.
  		 * Observer now a true value object, so "accessor methods" removed
  		 */
//  		public function testObserverAccessors():void {
//  			
//   			// Create observer with null args, then
//   			// use accessors to set notification method and context
//    		var observer:Observer = new Observer(null,null);
//    		observer.setNotifyContext(this);
//   			observer.setNotifyMethod(observerTestMethod);
//  			
//   			// create a test event, setting a payload value and notify 
//   			// the observer with it. since the observer is this class 
//   			// and the notification method is observerTestMethod,
//   			// successful notification will result in our local 
//   			// observerTestVar being set to the value we pass in 
//   			// on the note body.
//   			var note:Notification = new Notification('ObserverTestNote',10);
//			observer.notifyObserver(note);
//
//			// test assertions  			
//   			assertTrue( "Expecting observerTestVar = 10", observerTestVar == 10 );
//   		}

  		/**
  		 * Tests observer class when initialized by constructor.
  		 * 
 		 */
  		public function testObserverConstructor():void {
  			
   			// Create observer passing in notification method and context
   			var observer:Observer = new Observer(observerTestMethod,this);
  			
   			// create a test note, setting a body value and notify 
   			// the observer with it. since the observer is this class 
   			// and the notification method is observerTestMethod,
   			// successful notification will result in our local 
   			// observerTestVar being set to the value we pass in 
   			// on the note body.
   			var note:Notification = new Notification('ObserverTestNote',5);
			observer.notifyObserver(note);

			// test assertions  			
   			assertTrue( "Expecting observerTestVar = 5", observerTestVar == 5 );
   		}

  		/**
  		 * Tests the compareNotifyContext method of the Observer class
  		 * 
 		 */
  		public function testCompareNotifyContext():void {
  			
   			// Create observer passing in notification method and context
   			var observer:Observer = new Observer( observerTestMethod, this );
  			
  			var negTestObj:Object = new Object();
  			
			// test assertions  			
   			assertTrue( "Expecting observer.compareNotifyContext(negTestObj) == false", observer.compareNotifyContext(negTestObj) == false );
   			assertTrue( "Expecting observer.compareNotifyContext(this) == true", observer.compareNotifyContext(this) == true );
   		}

  		/**
  		 * A test variable that proves the notify method was
  		 * executed with 'this' as its exectution context
  		 */
  		private var observerTestVar:Number;

  		/**
  		 * A function that is used as the observer notification
  		 * method. It multiplies the input number by the 
  		 * observerTestVar value
  		 */
  		private function observerTestMethod( note:INotification ) : void
  		{
  			observerTestVar = note.body as Number;
  		}
  		
  		
 		
  	}
}