/*
 PureMVC - Copyright(c) 2006-08 Futurescale, Inc., Some rights reserved.
 Your reuse is governed by the Creative Commons Attribution 3.0 United States License
*/
package org.wisemvc.as3.patterns.mediator
{
	import org.wisemvc.as3.core.View;
	import org.wisemvc.as3.interfaces.IMediator;
	import org.wisemvc.as3.interfaces.INotification;
	import org.wisemvc.as3.patterns.observer.Notifier;

	/**
	 * A base <code>IMediator</code> implementation. 
	 * 
	 * 
	 */
	public class Mediator extends Notifier implements IMediator
	{
		protected var _mediatorName:String;
		protected var _viewComponent:Object;
		protected var _view:View;
		
		/**
		 * The name of the <code>Mediator</code>. 
		 * 
		 * <P>
		 * Typically, a <code>Mediator</code> will be written to serve
		 * one specific control or group controls and so,
		 * will not have a need to be dynamically named.</P>
		 */
		public static const NAME:String = 'Mediator';
		
		/**
		 * Constructor.
		 */
		public function Mediator(view:View, mediatorName:String=null, viewComponent:Object=null ) 
		{
			super(view.observerCtrl.sender);
			
			_view = view;
			_mediatorName = (mediatorName != null) ? mediatorName : NAME;
			_viewComponent = viewComponent;	
		}

		/**
		 * Get the name of the <code>Mediator</code>.
		 * @return the Mediator name
		 */		
		public function get mediatorName():String 
		{	
			return _mediatorName;
		}

		/**
		 * Set the <code>IMediator</code>'s view component.
		 * 
		 * @param Object the view component
		 */
		public function set viewComponent(value:Object):void 
		{
			_viewComponent = value;
		}

		/**
		 * Get the <code>Mediator</code>'s view component.
		 * 
		 * <P>
		 * Additionally, an implicit getter will usually
		 * be defined in the subclass that casts the view 
		 * object to a type, like this:</P>
		 * 
		 * <listing>
		 *		private function get comboBox : mx.controls.ComboBox 
		 *		{
		 *			return viewComponent as mx.controls.ComboBox;
		 *		}
		 * </listing>
		 * 
		 * @return the view component
		 */		
		public function get viewComponent():Object
		{	
			return _viewComponent;
		}

		/**
		 * List the <code>INotification</code> names this
		 * <code>Mediator</code> is interested in being notified of.
		 * 
		 * @return Array the list of <code>INotification</code> names 
		 */
		public function get notificationInterests():Array
		{
			return [];
		}

		/**
		 * Handle <code>INotification</code>s.
		 * 
		 * <P>
		 * Typically this will be handled in a switch statement,
		 * with one 'case' entry per <code>INotification</code>
		 * the <code>Mediator</code> is interested in.</P>
		 */ 
		public function handleNotification(notification:INotification):void {}
		
		/**
		 * Called by the View when the Mediator is registered
		 */ 
		public function onRegister( ):void {}

		/**
		 * Called by the View when the Mediator is removed
		 */ 
		public function onRemove( ):void {}
	}
}