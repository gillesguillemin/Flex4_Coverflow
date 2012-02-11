/**
 * VERSION: 2.0
 * DATE: 7/27/2009
 * ACTIONSCRIPT VERSION: 3.0 
 * UPDATES AND DOCUMENTATION AT: http://www.TweenMax.com
 **/
package com.greensock.plugins {
	import flash.display.*;
	import com.greensock.*;
/**
 * Toggles the visibility at the end of a tween. For example, if you want to set <code>visible</code> to false
 * at the end of the tween, do:<br /><br /><code>
 * 
 * TweenLite.to(mc, 1, {x:100, visible:false});<br /><br /></code>
 * 
 * The <code>visible</code> property is forced to true during the course of the tween. <br /><br />
 * 
 * <b>USAGE:</b><br /><br />
 * <code>
 * 		import com.greensock.TweenLite; <br />
 * 		import com.greensock.plugins.TweenPlugin; <br />
 * 		import com.greensock.plugins.VisiblePlugin; <br />
 * 		TweenPlugin.activate([VisiblePlugin]); //activation is permanent in the SWF, so this line only needs to be run once.<br /><br />
 * 
 * 		TweenLite.to(mc, 1, {x:100, visible:false}); <br /><br />
 * </code>
 *
 * Bytes added to SWF: 244 (not including dependencies)<br /><br />
 * 
 * <b>Copyright 2009, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */
	public class VisiblePlugin extends TweenPlugin {
		/** @private **/
		public static const VERSION:Number = 2.0;
		/** @private **/
		public static const API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		
		/** @private **/
		protected var _target:Object;
		/** @private **/
		protected var _tween:TweenLite;
		/** @private **/
		protected var _visible:Boolean;
		/** @private **/
		protected var _hideAtStart:Boolean;
		
		/** @private **/
		public function VisiblePlugin() {
			super();
			this.propName = "visible";
			this.overwriteProps = ["visible"];
		}
		
		/** @private **/
		override public function onInitTween(target:Object, value:*, tween:TweenLite):Boolean {
			init(target, Boolean(value), tween);
			return true;
		}
		
		/** @private **/
		protected function init(target:Object, visible:Boolean, tween:TweenLite):void {
			_target = target;
			_tween = tween;
			_visible = visible;
			if (_tween.vars.runBackwards != true) {
				this.onComplete = onCompleteTween;
			} else if (_tween.vars.immediateRender == true && !_visible) {
				_hideAtStart = true;
			}
		}
		
		/** @private **/
		public function onCompleteTween():void {
			_target.visible = _visible;
		}
		
		/** @private **/
		override public function set changeFactor(n:Number):void {
			if (_hideAtStart && _tween.cachedTime == 0) {
				_target.visible = false;
			} else if (!_visible) { //in case a completed tween is re-rendered at an earlier time.
				_target.visible = true;
			}
		}

	}
}