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
package org.wisemvc.as3.core
{
	import org.wisemvc.as3.core.controllerSupport.NotificationSender;
	import org.wisemvc.as3.interfaces.IProxy;

	public class Model
	{
		protected var _controller:NotificationSender;
		protected var _proxyMap:Array;
		
		public function Model(controller:NotificationSender)
		{
			_controller = controller;
			_proxyMap = new Array();	
		}
		
		/**
		 * The controller, as an instance of <code>NotificationSender</code>.
		 */
		public function get sender():NotificationSender
		{
			return _controller;
		}
		
		
		/**
		 * Duplicates the @see #sender property using a language-agnostic format
		 */
		public function getSender():NotificationSender
		{
			return sender;
		}

		/**
		 * Register an <code>IProxy</code> with the <code>Model</code>.
		 * 
		 * @param proxy an <code>IProxy</code> to be held by the <code>Model</code>.
		 */
		public function registerProxy(proxy:IProxy):void
		{
			_proxyMap[proxy.proxyName] = proxy;
			proxy.onRegister();
		}

		/**
		 * Retrieve an <code>IProxy</code> from the <code>Model</code>.
		 * 
		 * @param proxyName
		 * @return the <code>IProxy</code> instance previously registered with the given <code>proxyName</code>.
		 */
		public function retrieveProxy(proxyName:String):IProxy
		{
			return _proxyMap[proxyName];
		}

		/**
		 * Check if a Proxy is registered
		 * 
		 * @param proxyName
		 * @return whether a Proxy is currently registered with the given <code>proxyName</code>.
		 */
		public function hasProxy(proxyName:String):Boolean
		{
			return _proxyMap[proxyName] != null;
		}

		/**
		 * Remove an <code>IProxy</code> from the <code>Model</code>.
		 * 
		 * @param proxyName name of the <code>IProxy</code> instance to be removed.
		 * @return the <code>IProxy</code> that was removed from the <code>Model</code>
		 */
		public function removeProxy(proxyName:String):IProxy
		{
			var proxy:IProxy = _proxyMap[proxyName] as IProxy;
			if (proxy)
			{
				_proxyMap[proxyName] = null;
				proxy.onRemove();
			}

			return proxy;
		}
	}
}