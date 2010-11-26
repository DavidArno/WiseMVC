/*
 PureMVC - Copyright(c) 2006-08 Futurescale, Inc., Some rights reserved.
 Your reuse is governed by the Creative Commons Attribution 3.0 United States License
*/
package org.wisemvc.as3.patterns.command
{
	import org.wisemvc.as3.core.Controller;
	import org.wisemvc.as3.interfaces.ICommand;
	import org.wisemvc.as3.interfaces.INotification;
	import org.wisemvc.as3.patterns.observer.Notifier;

	/**
	 * A base <code>ICommand</code> implementation that executes other <code>ICommand</code>s.
	 *  
	 * <P>
	 * A <code>MacroCommand</code> maintains an list of
	 * <code>ICommand</code> Class references called <i>SubCommands</i>.</P>
	 * 
	 * <P>
	 * When <code>execute</code> is called, the <code>MacroCommand</code> 
	 * instantiates and calls <code>execute</code> on each of its <i>SubCommands</i> turn.
	 * Each <i>SubCommand</i> will be passed a reference to the original
	 * <code>INotification</code> that was passed to the <code>MacroCommand</code>'s 
	 * <code>execute</code> method.</P>
	 * 
	 * <P>
	 * Unlike <code>SimpleCommand</code>, your subclass
	 * should not override <code>execute</code>, but instead, should 
	 * override the <code>initializeMacroCommand</code> method, 
	 * calling <code>addSubCommand</code> once for each <i>SubCommand</i>
	 * to be executed.</P>
	 * 
	 * @see org.puremvc.as3.core.controller.Controller Controller
	 * @see org.puremvc.as3.patterns.observer.Notification Notification
	 * @see org.puremvc.as3.patterns.command.SimpleCommand SimpleCommand
	 */
	public class MacroCommand extends Notifier implements ICommand
	{
		protected var _subCommands:Array;
		protected var _controller:Controller
		/**
		 * Constructor. 
		 */
		function MacroCommand(controller:Controller, subCommands:Array)
		{
			super(controller);
			_controller = controller;
			_subCommands = subCommands;
		}
		
		/**
		 * Add a <i>SubCommand</i> to the list created by the constructor.
		 * 
		 * <P>
		 * The <i>SubCommands</i> will be called in First In/First Out (FIFO)
		 * order.</P>
		 * 
		 * @param commandClassRef a reference to the <code>Class</code> of the <code>ICommand</code>.
		 */
		protected function addSubCommand(commandClassRef:Class): void
		{
			_subCommands.push(commandClassRef);
		}
		
		/** 
		 * Execute this <code>MacroCommand</code>'s <i>SubCommands</i>.
		 * 
		 * <P>
		 * The <i>SubCommands</i> will be called in First In/First Out (FIFO)
		 * order. </P>
		 * 
		 * @param notification the <code>INotification</code> object to be passsed to each <i>SubCommand</i>.
		 */
		public function execute(notification:INotification):void
		{
			while (_subCommands.length > 0)
			{
				var commandClassRef:Class = _subCommands.shift();
				var commandInstance:ICommand = new commandClassRef(_controller);
				commandInstance.execute(notification);
			}
		}								
	}
}