/*
 PureMVC - Copyright(c) 2006-08 Futurescale, Inc., Some rights reserved.
 Your reuse is governed by the Creative Commons Attribution 3.0 United States License
*/
package org.wisemvc.as3.patterns.command
{
	import org.wisemvc.as3.core.controller.Controller;
	import org.wisemvc.as3.interfaces.ICommand;
	import org.wisemvc.as3.interfaces.INotification;
	import org.wisemvc.as3.patterns.observer.Notifier;

	/**
	 * A base <code>ICommand</code> implementation.
	 * 
	 * <P>
	 * Your subclass should override the <code>execute</code> 
	 * method where your business logic will handle the <code>INotification</code>. </P>
	 * 
	 * @see org.puremvc.as3.core.controller.Controller Controller
	 * @see org.puremvc.as3.patterns.observer.Notification Notification
	 * @see org.puremvc.as3.patterns.command.MacroCommand MacroCommand
	 */
	public class SimpleCommand extends Notifier implements ICommand
	{
		protected var _controller:Controller;
		
		/**
		 * Constructor. 
		 */
		function SimpleCommand(controller:Controller)
		{
			super(controller.sender);
			_controller = controller;
		}
		
		/**
		 * Fulfill the use-case initiated by the given <code>INotification</code>.
		 * 
		 * <P>
		 * In the Command Pattern, an application use-case typically
		 * begins with some user action, which results in an <code>INotification</code> being broadcast, which 
		 * is handled by business logic in the <code>execute</code> method of an
		 * <code>ICommand</code>.</P>
		 * 
		 * @param notification the <code>INotification</code> to handle.
		 */
		public function execute(notification:INotification):void
		{
			throw new Error("You must override this abstract method with your own command logic");
		}					
	}
}