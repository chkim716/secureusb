package com.saferzone.defcon4.susbma.usbmanage.event
{
	import flash.events.Event;
	
	public class CustomTreeItemClickEvent extends Event
	{
		public static const CUSTOM_TREEITEM_CLICK:String = "CUSTOM_TREEITEM_CLICK";
		
		public var m_vo:Object;
		public function CustomTreeItemClickEvent(type:String, object:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.m_vo = object;
		}
		
		public override function clone():Event
		{
			return new CustomTreeItemClickEvent(type,m_vo);
		}
	}
}