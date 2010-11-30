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
	import org.wisemvc.as3.core.Model;
	import org.wisemvc.as3.core.View;
	import org.wisemvc.as3.interfaces.ICommand;
	import org.wisemvc.as3.interfaces.INotification;
	import org.wisemvc.as3.interfaces.IObserver;
	import org.wisemvc.as3.patterns.observer.Notification;
	import org.wisemvc.as3.patterns.observer.Observer;

	/**
	 * <code>Controller</code> forms the application's entry point into an MVC. It 
	 * replaces both the Facade and Controller classes from PureMVC. In addition,
	 * the <code>Observer</code> functionality has been moved from <code>View</code>
	 * to this class.
	 * 
	 * <p>An instance of <code>Controller</code> automatically creates an accompanying
	 * instance of <code>View</code> and <code>Model</code>, which are exposed
	 * via <code>view</code> and <code>model</code> properties.</p>
	 * 
	 * <p>As WiseMVC relies on dependency injection, the application must ensure
	 * that these two latter two objects are provided to all instances of any mediators and
	 * proxies that it creates. It order to facilitate registering interest in, and
	 * the sending of, notifications, <code>View</code> and <code>Model</code> are also
	 * given restricted access to aspects of <code>Controller's</code> functionality.
	 * This is achieved by providing an instance of <code>ObserverController</code>
	 * to <code>View</code> and <code>NotificationSender</code> to <code>Model</code>. In
	 * turn, <code>Model</code> and <code>View</code> expose the same data to 
	 * their associated classes.</p>
	 * 
	 * <p>For legacy systems that ignored PureMVC guidelines, <code>Controller</code>
	 * can be set up to operate in two <i>pragmatic</i> modes whereby it allows <code>Model</code>
	 * access to <code>ObserverController</code> or it allows both <code>View</code> and 
	 * <code>Model</code> access to the full <code>Controller</code> functionality. In turn
	 * this extra functionality is then exposed to the other WiseMVC classes.</p>
	 * 
	 * <p>Commands are always provided with unfettered access to the whole of the
	 * <code>Controller</code> functionality.</p>
	 * 
	 * @see NotificationSender
	 * @see ObserverController
	 * @see Model
	 * @see View
	 */
	public class Controller
	{
		protected var _commandMap:Array;
		protected var _model:Model;
		protected var _view:View;
		protected var _observerCtrl:ObserverController;
		protected var _sender:NotificationSender;
		
		/**
		 * Constructor.
		 *  
		 * @param pragmaticMode				If true, both the <code>View</code> and 
		 * 									<code>Model</code> access to the full 
		 * 									<code>Controller</code> functionality. When
		 * 									true, allowAccessToObservers' state becomes
		 * 									irrelevant. If false, allowAccessToObservers
		 * 									comes into play.
		 * @param allowAccessToObservers	Assuming pragmaticMode is false, then: if 
		 * 									false itself, then Model has access to 
		 * 									<code>NotificationSender</code>; else if true,
		 * 									Model gets access to <code>ObserverController</code>.
		 * 									View is unaffected by this parameter.
		 */
		public function Controller(pragmaticMode:Boolean=false, 
								   allowAccessToObservers:Boolean=false)
		{
			_commandMap = [];			
			setUpSenderAndCtrl(pragmaticMode, allowAccessToObservers);
			setUpViewAndModel();
		}

		/**
		 * Sets up the <code>View</code> and <code>Model</code> instances 
		 * associated with this <code>Controller</code>
		 */
		protected function setUpViewAndModel():void
		{
			_model = new Model(_sender);
			_view = new View(_observerCtrl);
		}

		/**
		 * Sets up the <code>ObserverController</code> and 
		 * <code>NotificationSender</code> associated with this 
		 * <code>Controller</code>. It also deals with any pragmatic mode 
		 * requirements.
		 * 
		 * @param pragmaticMode				See the constructor for details
		 * @param allowAccessToObservers	NotificationSender
		 */
		protected function setUpSenderAndCtrl(pragmaticMode:Boolean, 
											  allowAccessToObservers:Boolean):void
		{
			var controllerRef:Controller = null;
			var observerCtrlRef:ObserverController = null;
			
			if (pragmaticMode)
			{
				controllerRef = this;
			}
			
			_observerCtrl = new ObserverController();
			
			if (pragmaticMode || allowAccessToObservers)
			{
				observerCtrlRef = _observerCtrl;
			}

			_sender = new NotificationSender(controllerRef, observerCtrlRef);
			_observerCtrl.notificationSender = _sender;
		}
		
		/**
		 * The <code>Model</code> instance associated with this Controller. 
		 */
		public function get model():Model
		{
			return _model;
		}
		
		/**
		 * The <code>View</code> instance associated with this 
		 * <code>Controller</code>. 
		 */
		public function get view():View
		{
			return _view;
		}
		
		/**
		 * The <code>NotificationSender</code> instance associated with this 
		 * <code>Controller</code>. 
		 */
		public function get sender():NotificationSender
		{
			return _sender;
		}
		
		/**
		 * The <code>ObserverController</code> instance associated with this 
		 * <code>Controller</code>. 
		 */
		public function get observerCtrl():ObserverController
		{
			return _observerCtrl;
		}
		
		/**
		 * Language-generic version of the model property. 
		 */
		public function getModel():Model
		{
			return model;
		}
		
		/**
		 * Language-generic version of the view property.
		 */
		public function getView():View
		{
			return view;
		}
		
		/**
		 * Language-generic version of the sender property. 
		 */
		public function getSender():NotificationSender
		{
			return sender;
		}
		
		/**
		 * Language-generic version of the observerCtrl property.
		 */
		public function getObserverCtrl():ObserverController
		{
			return observerCtrl;
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
		public function notifyObservers(notification:INotification):void
		{
			_sender.notifyAllObservers(notification);
		}

		/**
		 * If an <code>ICommand</code> has previously been registered 
		 * to handle a the given <code>INotification</code>, then it is executed.
		 * 
		 * @param note an <code>INotification</code>
		 */
		public function executeCommand(note:INotification):void
		{
			var commandClassRef:Class = _commandMap[note.name];
			if (commandClassRef != null)
			{
				var commandInstance:ICommand = new commandClassRef(this);
				commandInstance.execute(note);
			}
		}

		/**
		 * Register a particular <code>ICommand</code> class as the handler 
		 * for a particular <code>INotification</code>.
		 * 
		 * <P>
		 * If an <code>ICommand</code> has already been registered to 
		 * handle <code>INotification</code>s with this name, it is no longer
		 * used, the new <code>ICommand</code> is used instead.</P>
		 * 
		 * <p>The Observer for the new ICommand is only created if this the 
		 * first time an ICommand has been regisered for this Notification name.</p>
		 * 
		 * @param notificationName the name of the <code>INotification</code>
		 * @param commandClassRef the <code>Class</code> of the <code>ICommand</code>
		 */
		public function registerCommand(notificationName:String, commandClassRef:Class):void
		{
			if (_commandMap[notificationName] == null) 
			{
				_observerCtrl.registerObserver(notificationName, new Observer(executeCommand, this));
			}
			_commandMap[notificationName] = commandClassRef;
		}
		
		/**
		 * Check if a Command is registered for a given Notification 
		 * 
		 * @param notificationName
		 * @return whether a Command is currently registered for the given <code>notificationName</code>.
		 */
		public function hasCommand(notificationName:String):Boolean
		{
			return _commandMap[notificationName] != null;
		}

		/**
		 * Remove a previously registered <code>ICommand</code> to <code>INotification</code> mapping.
		 * 
		 * @param notificationName the name of the <code>INotification</code> to remove the <code>ICommand</code> mapping for
		 */
		public function removeCommand(notificationName:String):void
		{
			if (hasCommand(notificationName))
			{
				_observerCtrl.removeObserver(notificationName, this);
				_commandMap[notificationName] = null;
			}
		}
	}
}