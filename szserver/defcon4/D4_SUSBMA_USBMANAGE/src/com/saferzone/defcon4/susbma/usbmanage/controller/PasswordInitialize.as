//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.usbmanage.controller
{
	import com.saferzone.defcon4.susbma.usbmanage.consts.LocalConst;
	import com.saferzone.defcon4.susbma.usbmanage.model.SusbmaUsbManageRemoteProxy;
	
	import mx.collections.IList;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 *
	 * enclosing_type
	 *
	 * @version 0.001
	 * @author CyD
	 * @since Oct 12, 2011
	 *
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * @playerversion AIR 2.6
	 * @productversion Flex 4.5
	 *
	 */
	public class PasswordInitialize extends SimpleCommand implements ICommand
	{
		
		//------------------------------------------------------------------------------
		//
		// Methods 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		// Overriden Methods 
		//--------------------------------------
		
		override public function execute(notification:INotification):void
		{
			var proxy:SusbmaUsbManageRemoteProxy = facade.retrieveProxy(SusbmaUsbManageRemoteProxy.NAME) as SusbmaUsbManageRemoteProxy;
			
			switch(notification.getName())
			{
				case LocalConst.D4LC_CMD_PASSWORD_INITIALIZE:
				{
					var targets:IList = notification.getBody().targets as IList;
					var sno:String = notification.getBody().sno;
					var pwd:String = notification.getBody().pwd;
					var isDataDelete:int = notification.getBody().isDataDelete;
				 	var isFirst:int = notification.getBody().isFirst;
					proxy.changeUsbPassword(targets, sno, pwd, isDataDelete, isFirst);
					break;
				}
					
			}
			
		}
	}
}
