/*
 PureMVC - Copyright(c) 2006-08 Futurescale, Inc., Some rights reserved.
 Your reuse is governed by the Creative Commons Attribution 3.0 United States License
*/
package org.wisemvc.as3.patterns.proxy
{
	import org.wisemvc.as3.core.Model;
	import org.wisemvc.as3.interfaces.IProxy;
	import org.wisemvc.as3.patterns.observer.Notifier;

	/**
	 * A base <code>IProxy</code> implementation. 
	 * 
	 * <P>
	 * In PureMVC, <code>Proxy</code> classes are used to manage parts of the 
	 * application's data model. </P>
	 * 
	 * <P>
	 * A <code>Proxy</code> might simply manage a reference to a local data object, 
	 * in which case interacting with it might involve setting and 
	 * getting of its data in synchronous fashion.</P>
	 * 
	 * <P>
	 * <code>Proxy</code> classes are also used to encapsulate the application's 
	 * interaction with remote services to save or retrieve data, in which case, 
	 * we adopt an asyncronous idiom; setting data (or calling a method) on the 
	 * <code>Proxy</code> and listening for a <code>Notification</code> to be sent 
	 * when the <code>Proxy</code> has retrieved the data from the service. </P>
	 * 
	 * @see org.puremvc.as3.core.model.Model Model
	 */
	public class Proxy extends Notifier implements IProxy
	{
		public static var NAME:String = 'Proxy';
		
		protected var _proxyName:String;
		protected var _data:Object;

		/**
		 * Constructor
		 */
		function Proxy(model:Model, proxyName:String=null, data:Object=null) 
		{
			super(model.sender);
			
			_proxyName = (proxyName != null) ? proxyName : NAME; 
			if (data != null)
			{
				this.data = data;
			}
		}

		/**
		 * Get the proxy name
		 */
		public function get proxyName():String 
		{
			return _proxyName;
		}		
		
		/**
		 * Set the data object
		 */
		public function set data(value:Object):void 
		{
			_data = value;
		}
		
		/**
		 * Get the data object
		 */
		public function get data():Object 
		{
			return _data;
		}		

		/**
		 * Called by the Model when the Proxy is registered
		 */ 
		public function onRegister( ):void {}

		/**
		 * Called by the Model when the Proxy is removed
		 */ 
		public function onRemove( ):void {}
	}
}