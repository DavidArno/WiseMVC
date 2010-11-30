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
	import org.wisemvc.as3.core.controller.NotificationSender;
	import org.wisemvc.as3.interfaces.IProxy;

	/**
	 * The <code>Model</code> class provides access to model objects (Proxies) 
	 * by named lookup. 
	 * 
	 * <P>
	 * The <code>Model</code> assumes these responsibilities:</P>
	 * 
	 * <UL>
	 * <LI>Maintain a cache of <code>IProxy</code> instances.</LI>
	 * <LI>Provide methods for registering, retrieving, and removing 
	 * <code>IProxy</code> instances.</LI>
	 * <LI>Notifiying <code>IProxys</code> when they are registered or 
	 * removed.</LI>
	 * </UL>
	 *
	 * @see Proxy
	 * @see IProxy
	 */
	public class Model
	{
		/**
		 * Local record of the <code>NotificationSender</code> 
		 */
		protected var _sender:NotificationSender;
		
		/**
		 * The array of registered proxies, indexed by proxy name
		 */
		protected var _proxyMap:Array;
		
		/**
		 * Constructor
		 *  
		 * @param sender	Instance of <code>NotificationSender</code>
		 * 					supplied by <code>Controller</code>
		 */
		public function Model(sender:NotificationSender)
		{
			_sender = sender;
			_proxyMap = [];	
		}
		
		/**
		 * This Model's <code>NotificationSender</code>
		 */
		public function get sender():NotificationSender
		{
			return _sender;
		}
				
		/**
		 * Duplicates the sender property using a language-agnostic format
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
		 * 
		 * @return the <code>IProxy</code> instance previously registered with 
		 * the given <code>proxyName</code>. Null if the named proxy has not
		 * been registered.
		 */
		public function retrieveProxy(proxyName:String):IProxy
		{
			return _proxyMap[proxyName];
		}

		/**
		 * Check if a Proxy is registered
		 * 
		 * @param proxyName
		 * 
		 * @return true if the named proxy is currently registered; else false
		 */
		public function hasProxy(proxyName:String):Boolean
		{
			return _proxyMap[proxyName] != null;
		}

		/**
		 * Remove an <code>IProxy</code> from the <code>Model</code>.
		 * 
		 * @param proxyName name of the <code>IProxy</code> instance to be removed.
		 * 
		 * @return 	the <code>IProxy</code> that was removed from the 
		 * 			<code>Model</code>. Null if no such registered proxy was found.
		 */
		public function removeProxy(proxyName:String):IProxy
		{
			var proxy:IProxy = retrieveProxy(proxyName);

			if (proxy != null)
			{
				_proxyMap[proxyName] = null;
				proxy.onRemove();
			}

			return proxy;
		}
	}
}