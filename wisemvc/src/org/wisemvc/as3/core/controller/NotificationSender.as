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
package org.wisemvc.as3.core.controller
{
	import org.wisemvc.as3.interfaces.INotification;
	import org.wisemvc.as3.interfaces.IObserver;
	import org.wisemvc.as3.patterns.observer.Notification;

	/**
	 * <code>NotificationSender</code> forms the most basic, heavily encapulated,
	 * aspect of the MVC controller to which classes get access. It provides 
	 * support for sending notifications.
	 * 
	 * <p>In addition, it also provides a mechanism for progressively compromising
	 * the controller's integrity and the quality of the MVC paradigm. If it is 
	 * supplied with either an instance of <code>Controller</code> or
	 * <code>ObserverController</code> via its constructor, it will expose
	 * these to <code>Model</code>. This enables <code>Proxies</code> in 
	 * existing that did not follow PureMVC best practice to continue accessing
	 * normally prohibited controller features, lessening the need to rewrite 
	 * code.
	 * 
	 * <p>Taken in isolation, this class does nothing useful as it lacks the 
	 * ability to add observers. It is intended to be used via the 
	 * <code>Controller</code> class.</p>
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
		 * Defaults to null, but may be set to an instance of Controller by
		 * the constructor if really necessary.
		 */
		protected var _controller:Controller;

		/**
		 * Defaults to null, but may be set to an instance of ObserverController
		 * by the constructor if really necessary.
		 */
		protected var _observerCtrl:ObserverController;
		
		/**
		 * Constructor
		 *  
		 * @param controller	An instance of Controller. Only to be supplied 
		 * 						if it is to be exposed via the controller
		 * 						property. Keep null to maintain MVC integrity
		 * @param observerCtrl	An instance of ObserverController. As with
		 * 						controller, this should only be supplied if
		 * 						the integrity of the MVC needs compromising.
		 */
		public function NotificationSender(controller:Controller = null, 
										   observerCtrl:ObserverController = null)
		{
			_observerMap = [];
			_controller = controller;
			_observerCtrl = observerCtrl;
		}
		
		/**
		 * If an instance of <code>Controller</code> if supplied to the
		 * constructor, it returns that instance of <code>Controller</code>;
		 * otherwise it throws a ControllerStrictModeError error.
		 * 
		 * @throws	ControllerStrictModeError	
		 * 			Thrown if <code>Controller</code> is not defined.
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
		 * If an instance of <code>ObserverController</code> if supplied to the
		 * constructor, it returns that instance of <code>ObserverController</code>;
		 * otherwise it throws a ControllerStrictModeError error.
		 * 
		 * @throws	 ControllerStrictModeError	
		 * 			Thrown if <code>ObserverController</code> is not defined.
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
		public function sendNotification(notificationName:String, 
										 body:Object=null, 
										 type:String=null):void 
		{
			notifyAllObservers(new Notification(notificationName, body, type));
		}
		
		/**
		 * Provides the controller classes direct access to the oberser map,
		 * so they can add and remove items from it.  
		 */
		internal function get observerMap():Array
		{
			return _observerMap;
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
		internal function notifyAllObservers(notification:INotification):void
		{
			if (observerMap[notification.name] != null)
			{
				// Get a reference to the observers list for this notification name
				var observersRef:Array = observerMap[notification.name] as Array;
				
				// Copy observers from reference array to working array, 
				// since the reference array may change during the notification loop
				var observers:Array = new Array(); 
				var observer:IObserver;
				for (var i:Number = 0; i < observersRef.length; i++) 
				{
					observer = observersRef[i] as IObserver;
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