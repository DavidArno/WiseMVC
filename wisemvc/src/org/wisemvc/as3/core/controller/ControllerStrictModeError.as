/*
 * WiseMVC - Copyright(c) 2010 David Arno.
 *
 * All restrictions on the reuse or copying of this source is waived by the
 * copyright owner save that this copyright notice must remain.
 */
package org.wisemvc.as3.core.controller
{
	/**
	 * An error thrown by <code>NotificationSender</code> when attempting to gain access
	 * to <code>ObserverControl</code> or <code>Controller</code> when access is
	 * disabled. See @see Controller#controller for more details.
	 */
	public class ControllerStrictModeError extends Error
	{
		/**
		 * Constructor.
		 *  
		 * @param message	An error message
		 * @param id		An option arbitrary ID.
		 */
		function ControllerStrictModeError(message:String, id:*=0)
		{
			super(message, id);
		}
	}
}