/*
 PureMVC - Copyright(c) 2006-08 Futurescale, Inc., Some rights reserved.
 Your reuse is governed by the Creative Commons Attribution 3.0 United States License
*/
package org.wisemvc.as3.core
{
	import org.wisemvc.as3.core.controllerSupport.NotificationSender;
	import org.wisemvc.as3.core.controllerSupport.ObserverController;
	import org.wisemvc.as3.interfaces.IMediator;
	import org.wisemvc.as3.interfaces.INotification;
	import org.wisemvc.as3.interfaces.IObserver;
	import org.wisemvc.as3.patterns.observer.Observer;

	public class View
	{
		protected var _mediatorMap:Array;
		protected var _controller:ObserverController;
		
		public function View(controller:ObserverController)
		{
			_mediatorMap = new Array();
			_controller = controller;
		}
		
		public function get observerCtrl():ObserverController
		{
			return _controller;
		}
		
		public function getObserverCtrl():ObserverController
		{
			return observerCtrl;
		}
		
		public function get sender():NotificationSender
		{
			return _controller;
		}
		
		
		public function getSender():NotificationSender
		{
			return sender;
		}
		
		/**
		 * Register an <code>IMediator</code> instance with the <code>View</code>.
		 * 
		 * <P>
		 * Registers the <code>IMediator</code> so that it can be retrieved by name,
		 * and further interrogates the <code>IMediator</code> for its 
		 * <code>INotification</code> interests.</P>
		 * <P>
		 * If the <code>IMediator</code> returns any <code>INotification</code> 
		 * names to be notified about, an <code>Observer</code> is created encapsulating 
		 * the <code>IMediator</code> instance's <code>handleNotification</code> method 
		 * and registering it as an <code>Observer</code> for all <code>INotifications</code> the 
		 * <code>IMediator</code> is interested in.</P>
		 * 
		 * @param mediatorName the name to associate with this <code>IMediator</code> instance
		 * @param mediator a reference to the <code>IMediator</code> instance
		 */
		public function registerMediator(mediator:IMediator):void
		{
			if (_mediatorMap[mediator.mediatorName] == null)
			{			
				_mediatorMap[mediator.mediatorName] = mediator;
				var interests:Array = mediator.notificationInterests;

				if (interests.length > 0) 
				{
					var observer:Observer = new Observer(mediator.handleNotification, mediator);
					for (var i:Number=0; i<interests.length; i++) 
					{
						_controller.registerObserver(interests[i], observer);
					}			
				}
				
				mediator.onRegister();
			}		
		}

		/**
		 * Retrieve an <code>IMediator</code> from the <code>View</code>.
		 * 
		 * @param mediatorName the name of the <code>IMediator</code> instance to retrieve.
		 * @return the <code>IMediator</code> instance previously registered with the given <code>mediatorName</code>.
		 */
		public function retrieveMediator(mediatorName:String):IMediator
		{
			return _mediatorMap[mediatorName];
		}

		/**
		 * Remove an <code>IMediator</code> from the <code>View</code>.
		 * 
		 * @param mediatorName name of the <code>IMediator</code> instance to be removed.
		 * @return the <code>IMediator</code> that was removed from the <code>View</code>
		 */
		public function removeMediator(mediatorName:String):IMediator
		{
			// Retrieve the named mediator
			var mediator:IMediator = retrieveMediator(mediatorName);
			
			if (mediator != null) 
			{
				var interests:Array = mediator.notificationInterests;
				for (var i:Number=0; i<interests.length; i++) 
				{
					_controller.removeObserver(interests[i], mediator);
				}	
				
				delete _mediatorMap[mediatorName];	
				mediator.onRemove();
			}
			
			return mediator;
		}
		
		/**
		 * Check if a Mediator is registered or not
		 * 
		 * @param mediatorName
		 * @return whether a Mediator is registered with the given <code>mediatorName</code>.
		 */
		public function hasMediator(mediatorName:String):Boolean
		{
			return retrieveMediator(mediatorName) != null;
		}
	}
}