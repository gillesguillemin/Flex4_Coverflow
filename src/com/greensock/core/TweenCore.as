/**
 * VERSION: 0.94
 * DATE: 9/12/2009
 * ACTIONSCRIPT VERSION: 3.0 (AS2 version is also available)
 * UPDATES AND DOCUMENTATION AT: http://www.TweenLite.com
 **/

package com.greensock.core {
	import com.greensock.*;
/**
 * TweenCore is the base class for all TweenLite, TweenMax, TimelineLite, and TimelineMax classes and 
 * provides core functionality and properties. There is no reason to use this class directly.<br /><br />
 * 
 * <b>Copyright 2009, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */
	public class TweenCore {
		/** @private **/
		public static const version:Number = 0.94;
		
		/** @private **/
		protected static var _classInitted:Boolean;
		
		/** @private Delay in seconds (or frames for frames-based tweens/timelines) **/
		protected var _delay:Number; 
		/** @private Has onUpdate. Tracking this as a Boolean value is faster than checking this.vars.onUpdate != null. **/
		protected var _hasUpdate:Boolean;
		/** @private Primarily used for zero-duration tweens to determine the direction/momentum of time which controls whether the starting or ending values should be rendered. For example, if a zero-duration tween renders and then its timeline reverses and goes back before the startTime, the zero-duration tween must render the starting values. Otherwise, if the render time is zero or later, it should always render the ending values. **/
		protected var _rawPrevTime:Number = -1;
		
		/** Stores variables (things like alpha, y or whatever we're tweening as well as special properties like "onComplete"). **/
		public var vars:Object; 
		/** @private The tween has begun and is now active **/
		public var active:Boolean; 
		/** @private Flagged for garbage collection **/
		public var gc:Boolean; 
		/** @private Indicates whether or not init() has been called (where all the tween property start/end value information is recorded) **/
		public var initted:Boolean; 
		 /** Every tween belongs to one timeline. By default, it uses the TweenLite.rootTimeline (or TweenLite.rootFramesTimeline for frames-based tweens/timelines). **/
		public var timeline:SimpleTimeline;
		/** @private Start time in seconds (or frames for frames-based tweens/timelines), according to its position on its parent timeline **/
		public var cachedStartTime:Number; 
		/** @private The last rendered currentTime of this TweenCore. If a tween is going to repeat, its cachedTime will reset even though the cachedTotalTime continues linearly (or if it yoyos, the cachedTime may go forwards and backwards several times over the course of the tween). The cachedTime reflects the tween's "local" (which can never exceed the duration) time whereas the cachedTotalTime reflects the overall time. These will always match if the tween doesn't repeat/yoyo.**/
		public var cachedTime:Number; 
		/** @private The last rendered totalTime of this TweenCore. It is prefaced with "cached" because using a public property like this is faster than using the getter which is essentially a function call. If you want to update the value, you should always use the normal property, like myTween.totalTime = 0.5.**/
		public var cachedTotalTime:Number; 
		/** @private Prefaced with "cached" because using a public property like this is faster than using the getter which is essentially a function call. If you want to update the value, you should always use the normal property, like myTween.duration = 0.5.**/
		public var cachedDuration:Number; 
		/** @private Prefaced with "cached" because using a public property like this is faster than using the getter which is essentially a function call. If you want to update the value, you should always use the normal property, like myTween.totalDuration = 0.5.**/
		public var cachedTotalDuration:Number; 
		/** @private timeScale allows you to slow down or speed up a tween/timeline. 1 = normal speed, 0.5 = half speed, 2 = double speed, etc. It is prefaced with "cached" because using a public property like this is faster than using the getter which is essentially a function call. If you want to update the value, you should always use the normal property, like myTween.timeScale = 2**/
		public var cachedTimeScale:Number;
		/** @private Indicates whether or not the tween is reversed. **/ 
		public var cachedReversed:Boolean;
		/** @private Next TweenCore object in the linked list.**/
		public var nextNode:TweenCore; 
		/** @private Previous TweenCore object in the linked list**/
		public var prevNode:TweenCore; 
		/** @private Indicates that the duration or totalDuration may need refreshing (like if a TimelineLite's child had a change in duration or startTime). This is another performance booster because if the cache isn't dirty, we can quickly read from the cachedDuration and/or cachedTotalDuration **/
		public var cacheIsDirty:Boolean; 
		/** @private Quicker way to read the paused property. It is public for speed purposes. When setting the paused state, always use the regular "paused" property.**/
		public var cachedPaused:Boolean; 
		/** Place to store any data you want.**/
		public var data:*; 
		
		public function TweenCore(duration:Number=0, vars:Object=null) {
			this.vars = vars || {};
			this.cachedDuration = this.cachedTotalDuration = duration || 0;
			_delay = this.vars.delay || 0;
			this.cachedTimeScale = this.vars.timeScale || 1;
			this.active = Boolean(duration == 0 && _delay == 0 && this.vars.immediateRender != false);
			this.cachedTotalTime = this.cachedTime = 0;
			this.data = this.vars.data;
			
			if (!_classInitted) {
				if (isNaN(TweenLite.rootFrame)) {
					TweenLite.initClass();
					_classInitted = true;
				} else {
					return;
				}
			}
			
			var tl:SimpleTimeline = (this.vars.timeline is SimpleTimeline) ? this.vars.timeline : (this.vars.useFrames) ? TweenLite.rootFramesTimeline : TweenLite.rootTimeline;
			this.cachedStartTime = tl.cachedTotalTime + _delay;
			tl.addChild(this);
		}
		
		/**
		 * @private
		 * Renders the tween/timeline at a particular time (or frame number for frames-based tweens)
		 * WITHOUT changing its startTime. For example, if a tween's duration
		 * is 3, renderTime(1.5) would render it at the halfway finished point.
		 * 
		 * @param time time in seconds (or frame number for frames-based tweens/timelines) to render.
		 * @param suppressEvents If true, no events or callbacks will be triggered for this render (like onComplete, onUpdate, onReverseComplete, etc.)
		 * @param force Normally the tween will skip rendering if the time matches the cachedTotalTime (to improve performance), but if force is true, it forces a render. This is primarily used internally for tweens with durations of zero in TimelineLite/Max instances.
		 */
		public function renderTime(time:Number, suppressEvents:Boolean=false, force:Boolean=false):void {
			
		}
		
		/**
		 * Forces the tween/timeline to completion.
		 * 
		 * @param skipRender to skip rendering the final state of the tween, set skipRender to true. 
		 * @param suppressEvents If true, no events or callbacks will be triggered for this render (like onComplete, onUpdate, onReverseComplete, etc.)
		 */
		public function complete(skipRender:Boolean=false, suppressEvents:Boolean=false):void {
			
		}
		
		/** 
		 * Clears any initialization data like starting values in tweens/timelines which can be useful if, for example, 
		 * you want to restart it without reverting to any previously recorded starting values. When you invalidate() 
		 * a tween/timeline, it will be re-initialized the next time it renders and its <code>vars</code> object will be re-parsed. 
		 * The timing of the tween/timeline (duration, startTime, delay) will NOT be affected. Another example would be if you
		 * have a TweenMax(mc, 1, {x:100, y:100}) that ran when mc.x and mc.y were initially at 0, but now mc.x 
		 * and mc.y are 200 and you want them tween to 100 again, you could simply invalidate() the tween and 
		 * restart() it. Without invalidating() first, restarting it would cause the values jump back to 0 immediately 
		 * (where they started when the tween originally began). When you invalidate a timeline, it automatically invalidates 
		 * all of its children.
		 **/
		public function invalidate():void {
			
		}
		
		/**
		 * @private
		 * If a tween/timeline is enabled, it is eligible to be rendered (unless it is paused). Setting enabled to
		 * false essentially removes it from its parent timeline and stops protecting it from garbage collection.
		 * 
		 * @param enabled Enabled state of the tween/timeline
		 * @param ignoreTimeline By default, the tween/timeline will remove itself from its parent timeline when it is disabled, and add itself when it is enabled, but this parameter allows you to override that behavior.
		 * @return Boolean value indicating whether or not important properties may have changed when the TweenCore was enabled/disabled. For example, when a motionBlur (plugin) is disabled, it swaps out a BitmapData for the target and may alter the alpha. We need to know this in order to determine whether or not a new tween that is overwriting this one should be re-initted() with the changed properties. 
		 **/
		public function setEnabled(enabled:Boolean, ignoreTimeline:Boolean=false):Boolean {
			if (enabled == this.gc) {
				this.gc = !enabled;
				if (enabled) {
					this.active = Boolean(!this.cachedPaused && this.cachedTotalTime > 0 && this.cachedTotalTime < this.cachedTotalDuration);
					if (!ignoreTimeline) {
						this.timeline.addChild(this);
					}
				} else {
					this.active = false;
					if (!ignoreTimeline) {
						this.timeline.remove(this);
					}
				}
			}
			return false;
		}
		
		/** Kills the tween/timeline, stopping it immediately. **/
		public function kill():void {
			setEnabled(false, false);
		}
		
//---- GETTERS / SETTERS ------------------------------------------------------------
		
		/** 
		 * Length of time in seconds (or frames for frames-based tweens/timelines) before the tween should begin. 
		 * The tween's starting values are not determined until after the delay has expired (except in from() tweens) 
		 **/
		public function get delay():Number {
			return _delay;
		}
		
		public function set delay(n:Number):void {
			this.startTime += (n - _delay);
			_delay = n;
		}
		
		/**
		 * Duration of the tween in seconds (or frames for frames-based tweens/timelines) not including any repeats
		 * or repeatDelays. "totalDuration", by contrast, does include repeats and repeatDelays.
		 **/
		public function get duration():Number {
			return this.cachedDuration;
		}
		
		public function set duration(n:Number):void {
			this.cachedDuration = this.cachedTotalDuration = n;
		}
		
		/**
		 * Duration of the tween in seconds (or frames for frames-based tweens/timelines) including any repeats
		 * or repeatDelays (which are only available on TweenMax and TimelineMax). <code>duration</code>, by contrast, does 
		 * <b>NOT</b> include repeats and repeatDelays. So if a TweenMax's duration is 1 and it has a repeat of 2, the totalDuration would be 3.
		 **/ 
		public function get totalDuration():Number {
			return this.cachedTotalDuration;
		}
		
		public function set totalDuration(n:Number):void {
			this.duration = n;
		}
		
		/** Most recently rendered time in seconds (or frame for frames-based tweens/timelines). **/
		public function get currentTime():Number {
			return this.cachedTime;
		}
		
		public function set currentTime(n:Number):void {
			this.startTime = this.timeline.cachedTotalTime - (n / this.cachedTimeScale);
			renderTime(n, false, false);
		}
		
		/** Start time in seconds (or frames for frames-based tweens/timelines), according to its position on its parent timeline **/
		public function get startTime():Number {
			return this.cachedStartTime;
		}
		
		public function set startTime(n:Number):void {
			var adjust:Boolean = Boolean(this.timeline != null && (n != this.cachedStartTime || this.gc));
			this.cachedStartTime = n;
			if (adjust) {
				this.timeline.addChild(this); //ensures that any necessary re-sequencing of TweenCores in the timeline occurs to make sure the rendering order is correct.
			}
		}

	}
}