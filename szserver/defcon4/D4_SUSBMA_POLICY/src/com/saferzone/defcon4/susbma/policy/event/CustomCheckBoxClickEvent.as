package com.saferzone.defcon4.susbma.policy.event
{
	import flash.events.Event;
	
	public class CustomCheckBoxClickEvent extends Event
	{
		public static const CUSTOM_CHECKBOX_CLICK:String = "CUSTOM_CHECKBOX_CLICK";
		
		public var m_vo:Object;
		public function CustomCheckBoxClickEvent(type:String, object:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.m_vo = object;
		}
		
		public override function clone():Event
		{
			return new CustomCheckBoxClickEvent(type,m_vo);
		}
	}
}