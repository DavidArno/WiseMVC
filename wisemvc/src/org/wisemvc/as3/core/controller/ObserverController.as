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
	import org.wisemvc.as3.interfaces.IObserver;
	import org.wisemvc.as3.patterns.observer.Notification;
	import org.wisemvc.as3.patterns.observer.Observer;

	/**
	 * <code>ObserverController</code> extends the functionality of 
	 * <code>NotificationSender</code> by adding publicly accessible methods for
	 * adding and removing <code>IObservers</code>
	 * 
	 * @see NotificationSender
	 */
	public class ObserverController
	{
		/**
		 * Local record of the NotificationSender i nstance, which contains
		 * the observer map. 
		 */
		protected var _sender:NotificationSender;
		
		/**
		 * Register an <code>IObserver</code> to be notified
		 * of <code>INotifications</code> with a given name.
		 * 
		 * @param notificationName the name of the <code>INotifications</code> to notify this <code>IObserver</code> of 
		 * @param observer the <code>IObserver</code> to register
		 */
		public function registerObserver (notificationName:String, observer:IObserver):void
		{
			var observers:Array = _sender.observerMap[notificationName];
			
			if (observers != null)
			{
				observers.push(observer);
			} 
			else 
			{
				_sender.observerMap[notificationName] = [observer];	
			}
		}

		/**
		 * Remove the observer for a given notifyContext from an observer list for a given Notification name.
		 * 
		 * @param notificationName which observer list to remove from 
		 * @param notifyContext remove the observer with this object as its notifyContext
		 */
		public function removeObserver(notificationName:String, notifyContext:Object):void
		{
			// the observer list for the notification under inspection
			var observers:Array = _sender.observerMap[notificationName] as Array;
			
			// find the observer for the notifyContext
			for (var i:int=0; i<observers.length; i++) 
			{
				if (Observer(observers[i]).compareNotifyContext(notifyContext) == true) 
				{
					// there can only be one Observer for a given notifyContext 
					// in any given Observer list, so remove it and break
					observers.splice(i,1);
					break;
				}
			}
			
			// Also, when a Notification's Observer list length falls to 
			// zero, delete the notification key from the observer map
			if (observers.length == 0) 
			{
				delete _sender.observerMap[notificationName];		
			}
		}
		
		/**
		 * @copy NotificationSender#sendNotification
		 */
		public function sendNotification(notificationName:String, body:Object=null, type:String=null):void 
		{
			_sender.sendNotification(notificationName, body, type);
		}
		
		/**
		 * Provides access to the NotificationSender. This is required to
		 * fullfil the requirements of classes such as <code>Mediator</code>
		 * that extend <code>Notifier</code>
		 */
		public function get sender():NotificationSender
		{
			return _sender;
		}
		
		/**
		 * Language agnostic version of the sender property
		 */
		public function getSender():NotificationSender
		{
			return _sender;
		}
		
		/**
		 * Used by <code>Controller</code> to notify this class of an
		 * instance of <code>NotificationSender</code>. The latter contains
		 * the observer map, which is used to control which notices are sent
		 * to which observers.
		 */
		internal function set notificationSender(val:NotificationSender):void
		{
			_sender = val;
		}
	}
}