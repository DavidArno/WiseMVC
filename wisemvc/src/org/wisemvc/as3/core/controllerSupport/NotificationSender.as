/*
 * This is a derived work from PureMVC and is subject to the requirement 
 * detailed at http://trac.puremvc.org/PureMVC_AS3 that the original
 * copyright message be left in the source file header. No new restrictions 
 * nor warranties are implied nor expressed by this derivative. Futurescale, Inc
 * does not in any way endorse this derived work.
 *
 * PureMVC - Copyright(c) 2006-08 Futurescale, Inc., Some rights reserved.
 * Your reuse is governed by the Creative Commons Attribution 3.0 United States License
 */
package org.wisemvc.as3.core.controllerSupport
{
	import org.wisemvc.as3.core.Controller;
	import org.wisemvc.as3.interfaces.INotification;
	import org.wisemvc.as3.interfaces.IObserver;
	import org.wisemvc.as3.patterns.observer.Notification;

	/**
	 * <code>NotificationSender</code> forms the most basic, heavily encapulated,
	 * version of <code>Control</code> to which classes get access. It provides support for
	 * sending notifications.
	 * 
	 * <p>In addition, it also provides a mechanism for progressively compromising
	 * the <code>Control</code> instance's encapsulation and the quality of the
	 * MVC paradigm. On creation of and instance of <code>Control</code>, which is derived 
	 * from this class, it may select to expose itself and/ or the intermediary class,
	 * <code>NotificationSender</code> to the <code>Model</code>, <code>View</code> and
	 * their subsidiary classes.</p>
	 * 
	 * <p>By itself, this class does nothing useful as it lacks the ability to add
	 * observers. It is intended to be used via the <code>Controller</code> class.</p>
	 */
	public class NotificationSender
	{
		/**
		 * An array, indexed by <code>INotification</code> names, of arrays of
		 * IObservers, eg _observerMap[notification.name][0] would yield an
		 * instance of INotification. Used by @see #notifyAllObservers to pass
		 * details of a notification to all interested observers.
		 */
		protected var _observerMap:Array;
		
		/**
		 * Defaults to null, but may be set to an instance of Controller by a derived
		 * class. See @see #controller for more details.
		 */
		protected var _controller:Controller;

		/**
		 * Defaults to null, but may be set to an instance of ObserverController by a derived
		 * class. See @see #observerCtrl for more details.
		 */
		protected var _observerCtrl:ObserverController;
		
		/**
		 * Constructor.
		 */
		public function NotificationSender()
		{
			_observerMap = [];
			_controller = null;
			_observerCtrl = null;
		}
		
		/**
		 * If an instance of this class is created via <code>new Controller()</code>
		 * then that instance may optionally choose to expose itself via this
		 * property. If so, it returns that instance of <code>Controller</code>,
		 * otherwise it throws a ControllerStrictModeError error.
		 * 
		 * @throws	 ControllerStrictModeError	Thrown if controller is not exposed
		 */
		public function get controller():Controller
		{
			if (_controller == null)
			{
				throw new ControllerStrictModeError("Operating in strict 'no access to controller' mode. Access to controller denied.");
			}
			else
			{
				return _controller;
			}
		}
		
		/**
		 * If an instance of this class is created via <code>new Controller()</code>
		 * then that instance may optionally choose to expose itself via this
		 * property as an instance of <code>ObserverController</code>. If so, it 
		 * returns that instance of <code>ObserverController</code>,
		 * otherwise it throws a ControllerStrictModeError error.
		 * 
		 * @throws	 ControllerStrictModeError	Thrown if observerCtrl is not exposed
		 */
		public function get observerCtrl():ObserverController
		{
			if (_observerCtrl == null)
			{
				throw new ControllerStrictModeError("Operating in strict 'no access to observer ctrl' mode. Access to observerCtrl denied.");
			}
			else
			{
				return _observerCtrl;
			}
		}
		
		/**
		 * Identical to the <code>controller</code> property save that it uses
		 * a method syntax.
		 * 
		 * <p>Use this method if it is important to you to maintain syntax
		 * consistency between language implementations of WiseMVC</p>
		 */
		public function getController():Controller
		{
			return controller;
		}
		
		/**
		 * Identical to the <code>observerCtrl</code> property save that it uses
		 * a method syntax.
		 * 
		 * <p>Use this method if it is important to you to maintain syntax
		 * consistency between language implementations of WiseMVC</p>
		 */
		public function getObserverCtrl():ObserverController
		{
			return observerCtrl;
		}
		
		/**
		 * Create and send an <code>INotification</code> to all interested
		 * observers.
		 * 
		 * @param notificationName the name of the notiification to send
		 * @param body the body of the notification (optional)
		 * @param type the type of the notification (optional)
		 */ 
		public function sendNotification(notificationName:String, body:Object=null, type:String=null):void 
		{
			notifyAllObservers(new Notification(notificationName, body, type));
		}

		/**
		 * Notify the <code>IObservers</code> for a particular <code>INotification</code>.
		 * 
		 * <P>
		 * All previously attached <code>IObservers</code> for this <code>INotification</code>'s
		 * list are notified and are passed a reference to the <code>INotification</code> in 
		 * the order in which they were registered.</P>
		 * 
		 * @param notification the <code>INotification</code> to notify <code>IObservers</code> of.
		 */
		protected function notifyAllObservers(notification:INotification):void
		{
			if (_observerMap[notification.name] != null)
			{
				// Get a reference to the observers list for this notification name
				var observers_ref:Array = _observerMap[notification.name] as Array;
				
				// Copy observers from reference array to working array, 
				// since the reference array may change during the notification loop
				var observers:Array = new Array(); 
				var observer:IObserver;
				for (var i:Number = 0; i < observers_ref.length; i++) 
				{
					observer = observers_ref[i] as IObserver;
					observers.push(observer);
				}
				
				// Notify Observers from the working array				
				for (i = 0; i < observers.length; i++) 
				{
					observer = observers[i] as IObserver;
					observer.notifyObserver(notification);
				}
			}
		}
	}
}