/**
 * VERSION: 0.94
 * DATE: 9/12/2009
 * AS3 (AS2 version is also available)
 * UPDATES AND DOCUMENTATION AT: http://blog.greensock.com/timelinelite/
 **/
package com.greensock {
	import com.greensock.core.*;
	
	import flash.utils.*;
/**
 * 	TimelineLite is a lightweight, intuitive timeline class for building and managing sequences of 
 * 	TweenLite, TweenMax, TimelineLite, and/or TimelineMax instances. You can think of a TimelineLite instance 
 *  like a virtual MovieClip timeline or a container where you place tweens (or other timelines) over the 
 *  course of time. You can:
 * 	<ul>
 * 		<li> build sequences easily by adding tweens with the append(), prepend(), insert(), and insertMultiple() methods.</li>
 * 
 * 		<li> add labels, play(), stop(), gotoAndPlay(), gotoAndStop(), restart(), and even reverse() smoothly anytime. </li>
 * 		
 * 		<li> nest timelines within timelines as deeply as you want. When you pause or change the 
 * 		  timeScale of a parent timeline, it affects all of its descendents.</li>
 * 		
 * 		<li> set the progress of the timeline using its <code>currentProgress</code> property. For example, to skip to
 * 		  the halfway point, set <code>myTimeline.currentProgress = 0.5</code>. </li>
 * 		  
 * 		<li> tween the <code>currentTime</code> or <code>currentProgress</code> property to fastforward/rewind the timeline. You could 
 * 		  even attach a slider to one of these properties to give the user the ability to drag 
 * 		  forwards/backwards through the whole timeline.</li>
 * 		
 * 		<li> speed up or slow down the entire timeline with its timeScale property. You can even tween
 * 		  this property to gradually speed up or slow down the timeline.</li>
 * 		  
 * 		<li> add onComplete, onStart, onUpdate, and/or onReverseComplete callbacks using the constructor's "vars" object.</li>
 * 		  
 * 		<li> use the insertMultiple() method to create complex sequences including various alignment
 * 		  modes and staggering capabilities.</li>
 * 		  
 * 		<li> base the timing on frames instead of seconds if you prefer. Please note, however, that
 * 		  the timeline's timing mode dictates its childrens' timing mode as well. </li>
 * 		
 * 		<li> kill the tweens of a particular object with killTweensOf() or get the tweens of an object
 * 		  with getTweensOf() or get all the tweens/timelines in the timeline with getChildren()</li>
 * 		  
 * 		<li> If you need even more features like AS3 event listeners, repeat, repeatDelay, yoyo, currentLabel, getLabelAfter(), getLabelBefore(), 
 * 		  addCallback(), removeCallback(), getActive() and more, check out TimelineMax which extends TimelineLite.</li>
 * 	</ul>
 * 	
 * <b>EXAMPLE:</b><br /><br /><code>
 * 	
 * 		import com.greensock.TweenLite;<br />
 * 		import com.greensock.TimelineLite;<br /><br />
 * 		
 * 		//create the timeline<br />
 * 		var myTimeline:TimelineLite = new TimelineLite();<br /><br />
 * 		
 * 		//add a tween<br />
 * 		myTimeline.append(new TweenLite(mc, 1, {x:200, y:100}));<br /><br />
 * 		
 * 		//add another tween at the end of the timeline (makes sequencing easy)<br />
 * 		myTimeline.append(new TweenLite(mc, 0.5, {alpha:0}));<br /><br />
 * 		
 * 		//reverse it anytime...<br />
 * 		myTimeline.reverse();<br /><br />
 * 		
 * 		//Add a "spin" label 3-seconds into the timeline.<br />
 * 		myTimeline.addLabel("spin", 3);<br /><br />
 * 		
 * 		//insert a rotation tween at the "spin" label (you could also define the insert point as the time instead of a label)<br />
 * 		myTimeline.insert(new TweenLite(mc, 2, {rotation:"360"}), "spin"); <br /><br />
 * 		
 * 		//go to the "spin" label and play the timeline from there...<br />
 * 		myTimeline.gotoAndPlay("spin");<br /><br />
 * 		
 * 		//add a tween to the beginning of the timeline, pushing all the other existing tweens back in time<br />
 * 		myTimeline.prepend(new TweenLite(mc, 1, {tint:0xFF0000}));<br /><br />
 * 		
 * 		//nest another TimelineLite inside your timeline...<br />
 * 		var nestedTimeline:TimelineLite = new TimelineLite();<br />
 * 		nestedTimeline.append(new TweenLite(mc2, 1, {x:200}));<br />
 * 		myTimeline.append(nestedTimeline);<br /><br /></code>
 * 		
 * 		
 * 	insertMultiple() provides some very powerful sequencing tools, allowing you to add an Array of 
 * 	tweens or timelines and optionally align them with SEQUENCE or START modes, and even stagger them if you want. 
 *  For example, to insert 3 tweens into the timeline, aligning their start times but staggering them by 0.2 seconds, <br /><br /><code>
 * 	
 * 		myTimeline.insertMultiple([new TweenLite(mc, 1, {y:"100"}),
 * 								   new TweenLite(mc2, 1, {y:"100"}),
 * 								   new TweenLite(mc3, 1, {y:"100"})], 
 * 								   0, 
 * 								   TweenAlign.START, 
 * 								   0.2);</code><br /><br />
 * 								   
 * 	You can use the constructor's "vars" object to do virtually all the setup too, like this sequence:<br /><br /><code>
 * 	
 * 		var myTimeline:TimelineLite = new TimelineLite({tweens:[new TweenLite(mc1, 1, {y:"100"}), TweenMax.to(mc2, 1, {tint:0xFF0000}), new TweenLite(mc3, 1, {y:"100"})], align:TweenAlign.SEQUENCE, onComplete:myFunction});</code><br /><br />
 * 	
 * 	If that confuses you, don't worry. Just use the append(), insert(), and prepend() methods to build your
 * 	sequence. But power users will likely appreciate the quick, compact way they can set up sequences now. <br /><br />
 *  
 * 	
 * <b>NOTES:</b>
 * <ul>
 * 	<li> TimelineLite automatically inits the OverwriteManager class to prevent unexpected overwriting behavior in sequences.
 * 	  The default mode is AUTO, but you can set it to whatever you want with OverwriteManager.init() (see http://blog.greensock.com/overwritemanager/)</li>
 * 	<li> TimelineLite adds about 2.7k to your SWF (3.5kb including OverwriteManager).</li>
 * </ul>
 * 
 * <b>Copyright 2009, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 **/
	public class TimelineLite extends SimpleTimeline {
		/** @private **/
		public static const version:Number = 0.94;
		/** @private **/
		private static var _overwriteMode:int = (OverwriteManager.enabled) ? OverwriteManager.mode : OverwriteManager.init(2); //Ensures that TweenLite instances don't overwrite each other before being put into the timeline/sequence.
		/** @private **/
		protected var _labels:Object;
		/** @private Just stores the first and last tweens when the timeline is disabled (enabled=false). We do this in an Array in order to avoid circular references which can cause garbage collection issues (timeline referencing TweenCore, and TweenCore referencing timeline) **/
		protected var _endCaps:Array;
		/** @private **/
		protected var _pauseTime:Number;
		
		/**
		 * Constructor. <br /><br />
		 * 
		 * <b>SPECIAL PROPERTIES</b><br />
		 * The following special properties may be passed in via the constructor's vars parameter, like
		 * <code>new TimelineLite({paused:true, onComplete:myFunction})</code>
		 * 
		 * <ul>
		 * 	<li><b> delay : Number</b>			Amount of delay before the timeline should begin (in seconds unless "useFrames" is set 
		 * 										to true in which case the value is measured in frames).</li>
		 * 
		 *  <li><b> paused : Boolean</b> 		Sets the initial paused state of the timeline (by default, timelines automatically begin playing immediately)</li>
		 * 								
		 * 	<li><b> useFrames : Boolean</b>		If useFrames is set to true, the timeline's timing mode will be based on frames. 
		 * 										Otherwise, it will be based on seconds/time. NOTE: a TimelineLite's timing mode is 
		 * 										always determined by its parent timeline. </li>
		 * 
		 * 	<li><b> reversed : Boolean</b>		If true, the timeline will be reversed initially. This does NOT force it to the very end and start 
		 * 										playing backwards. It simply affects the orientation of the timeline, so if reversed is set to 
		 * 										true initially, it will appear not to play because it is already at the beginning. To cause it to
		 * 										play backwards from the end, set reversed to true and then set the <code>currentProgress</code> property to 1 immediately
		 * 										after creating the timeline.</li>
		 * 									
		 * 	<li><b> tweens : Array</b>			To immediately insert several tweens into the timeline, use the "tweens" special property
		 * 										to pass in an Array of TweenLite/TweenMax/TimelineLite/TimelineMax instances. You can use this in conjunction
		 * 										with the align and stagger special properties to set up complex sequences with minimal code.
		 * 										These values simply get passed to the insertMultiple() method.</li>
		 * 	
		 * 	<li><b> align : String</b>			Only used in conjunction with the "tweens" special property when multiple tweens are
		 * 										to be inserted immediately. The value simply gets passed to the 
		 * 										insertMultiple() method. The default is NORMAL. Options are:
		 * 										<ul>
		 * 											<li><b> TweenAlign.SEQUENCE:</b> aligns the tweens one-after-the-other in a sequence</li>
		 * 											<li><b> TweenAlign.START:</b> aligns the start times of all of the tweens (ignores delays)</li>
		 * 											<li><b> TweenAlign.NORMAL:</b> aligns the start times of all the tweens (honors delays)</li>
		 * 										</ul></li>
		 * 										
		 * 	<li><b> stagger : Number</b>		Only used in conjunction with the "tweens" special property when multiple tweens are
		 * 										to be inserted immediately. It staggers the tweens by a set amount of time (in seconds) (or
		 * 										in frames if "useFrames" is true). For example, if the stagger value is 0.5 and the "align" 
		 * 										property is set to TweenAlign.START, the second tween will start 0.5 seconds after the first one 
		 * 										starts, then 0.5 seconds later the third one will start, etc. If the align property is 
		 * 										TweenAlign.SEQUENCE, there would be 0.5 seconds added between each tween. This value simply gets 
		 * 										passed to the insertMultiple() method. Default is 0.</li>
		 * 	
		 * 	<li><b> onStart : Function</b>		A function that should be called when the timeline begins (the <code>currentProgress</code> won't necessarily
		 * 										be zero when <code>onStart</code> is called. For example, if the timeline is created and then its <code>currentProgress</code>
		 * 										property is immediately set to 0.5 or if its <code>currentTime</code> property is set to something other than zero,
		 * 										<code>onStart</code> will still get fired because it is the first time the timeline is getting rendered.)</li>
		 * 	
		 * 	<li><b> onStartParams : Array</b>	An Array of parameters to pass the onStart function.</li>
		 * 	
		 * 	<li><b> onUpdate : Function</b>		A function that should be called every time the timeline's time/position is updated 
		 * 										(on every frame while the timeline is active)</li>
		 * 	
		 * 	<li><b> onUpdateParams : Array</b>	An Array of parameters to pass the onUpdate function</li>
		 * 	
		 * 	<li><b> onComplete : Function</b>	A function that should be called when the timeline has finished </li>
		 * 	
		 * 	<li><b> onCompleteParams : Array</b> An Array of parameters to pass the onComplete function</li>
		 * 	
		 * 	<li><b> onReverseComplete : Function</b> A function that should be called when the timeline has reached its starting point again after having been reversed </li>
		 * 	
		 * 	<li><b> onReverseCompleteParams : Array</b> An Array of parameters to pass the onReverseComplete functions</li>
		 * 	
		 * 	<li><b> autoRemoveChildren : Boolean</b> If autoRemoveChildren is set to true, as soon as child tweens/timelines complete,
		 * 										they will automatically get killed/removed. This is normally undesireable because
		 * 										it prevents going backwards in time (like if you want to <code>reverse()</code> or set the 
		 * 										<code>currentProgress</code> value to a lower value, etc.). It can, however, improve speed and memory
		 * 										management. TweenLite's root timelines use <code>autoRemoveChildren:true</code>.</li>
		 * 	</ul>
		 * 
		 * @param vars optionally pass in special properties like <code>useFrames, onComplete, onCompleteParams, onUpdate, onUpdateParams, onStart, onStartParams, tweens, align, stagger, delay, reversed,</code> and/or <code>autoRemoveChildren</code>.
		 */
		public function TimelineLite(vars:Object=null) {
			super(vars);
			_endCaps = [];
			if (this.vars.paused == true) {
				this.paused = true;
			}
			_labels = {};
			this.autoRemoveChildren = Boolean(this.vars.autoRemoveChildren == true);
			_hasUpdate = Boolean(typeof(this.vars.onUpdate) == "function");
			if (this.vars.tweens is Array) {
				this.insertMultiple(this.vars.tweens, 0, this.vars.align || "normal", this.vars.stagger || 0);
			}
			if (this.vars.reversed == true) {
				this.cachedReversed = true;
			}
		}
		
		/**
		 * @private
		 * Adds a TweenLite, TweenMax, TimelineLite, or TimelineMax instance to this timeline. 
		 * Typically it is best to use the insert(), append(), or prepend() methods to add a tween
		 * or timeline, though. addChild() should generally be avoided (it is used primarily by other 
		 * classes in the GreenSock tweening platform).
		 * 
		 * @param tween TweenLite, TweenMax, TimelineLite, or TimelineMax instance
		 */
		override public function addChild(tween:TweenCore):void {
			if (tween.timeline) {
				tween.timeline.remove(tween, true); //removes from existing timeline so that it can be properly added to this one. Even if the timeline is this, it still needs to be removed so that it can be added in the appropriate order (required for proper rendering)
			}
			tween.timeline = this;
			if (tween.gc) {
				tween.setEnabled(true, true);
			}
			setDirtyCache(true);
			
			//now make sure it is inserted in the proper order...
			
			var first:TweenCore = _firstChild || _endCaps[0];
			var last:TweenCore = _lastChild || _endCaps[1];
			
			if (last == null) {
				first = last = tween;
				tween.nextNode = tween.prevNode = null;
			} else {
				var curTween:TweenCore = last, st:Number = tween.cachedStartTime;
				while (curTween != null && st <= curTween.cachedStartTime) {
					curTween = curTween.prevNode;
				}
				if (curTween == null) {
					first.prevNode = tween;
					tween.nextNode = first;
					tween.prevNode = null;
					first = tween;
				} else {
					if (curTween.nextNode) {
						curTween.nextNode.prevNode = tween;
					} else if (curTween == last) {
						last = tween;
					}
					tween.prevNode = curTween;
					tween.nextNode = curTween.nextNode;
					curTween.nextNode = tween;
				}
			}
			
			if (this.gc) {
				_endCaps[0] = first;
				_endCaps[1] = last;
			} else {
				_firstChild = first;
				_lastChild = last;
			}
		}
		
		/**
		 * Removes a TweenLite, TweenMax, TimelineLite, or TimelineMax instance from the timeline.
		 * 
		 * @param tween TweenLite, TweenMax, TimelineLite, or TimelineMax instance to remove
		 * @param skipDisable If false (the default), the TweenLite/Max/TimelineLite/Max instance is disabled. This is primarily used internally - there's really no reason to set it to true. 
		 */
		override public function remove(tween:TweenCore, skipDisable:Boolean=false):void {
			if (!tween.gc && !skipDisable) {
				tween.setEnabled(false, true);
			}
			
			var first:TweenCore = _firstChild || _endCaps[0];
			var last:TweenCore = _lastChild || _endCaps[1];
			
			if (tween.nextNode) {
				tween.nextNode.prevNode = tween.prevNode;
			} else if (last == tween) {
				last = tween.prevNode;
			}
			if (tween.prevNode) {
				tween.prevNode.nextNode = tween.nextNode;
			} else if (first == tween) {
				first = tween.nextNode;
			}
			
			if (this.gc) {
				_endCaps[0] = first;
				_endCaps[1] = last;
			} else {
				_firstChild = first;
				_lastChild = last;
			}
			tween.nextNode = tween.prevNode = null;	
			setDirtyCache(true);
		}
		
		/**
		 * Inserts a TweenLite, TweenMax, TimelineLite, or TimelineMax instance into the timeline at a specific time, frame, or label. 
		 * If you insert at a label that doesn't exist yet, one is created at the end of the timeline.
		 * 
		 * @param tween TweenLite, TweenMax, TimelineLite, or TimelineMax instance to insert
		 * @param timeOrLabel The time in seconds (or frames for frames-based timelines) or label at which the tween/timeline should be inserted. For example, myTimeline.insert(myTween, 3) would insert myTween 3-seconds into the timeline, and myTimeline.insert(myTween, "myLabel") would insert it at the "myLabel" label.
		 */
		public function insert(tween:TweenCore, timeOrLabel:*=0):void {
			if (typeof(timeOrLabel) == "string") {
				if (!(timeOrLabel in _labels)) {
					addLabel(timeOrLabel, this.duration);
				}	
				timeOrLabel = Number(_labels[timeOrLabel]);
			}
			/* Possible addition - this would avoid situations where a TimelineLite/Max is created as a class variable and then much later the children are added to it - without this line, the timeline would never start because it would finish immediately with no tweens.
			if (_firstChild == null && _endCaps[0] == null && (this.timeline == TweenLite.rootTimeline || this.timeline == TweenLite.rootFramesTimeline)) {
				this.startTime = this.timeline.cachedTime;
			}
			*/
			tween.cachedStartTime = Number(timeOrLabel) + tween.delay;
			addChild(tween);
		}
		
		/**
		 * Inserts a TweenLite, TweenMax, TimelineLite, or TimelineMax instance at the END of the timeline. 
		 * This makes it easy to build sequences by continuing to append() tweens or timelines.
		 * 
		 * @param tween TweenLite, TweenMax, TimelineLite, or TimelineMax instance to append
		 */
		public function append(tween:TweenCore):void {
			insert(tween, this.duration);
		}
		
		/**
		 * Inserts a TweenLite, TweenMax, TimelineLite, or TimelineMax instance at the beginning of the timeline,
		 * pushing all existing tweens back in time to make room for the newly inserted one. You can optionally
		 * affect the positions of labels too.
		 * 
		 * @param tween TweenLite, TweenMax, TimelineLite, or TimelineMax instance to prepend
		 * @param adjustLabels If true, all existing labels will be adjusted back in time along with the existing tweens to keep them aligned. (default is false)
		 */
		public function prepend(tween:TweenCore, adjustLabels:Boolean=false):void {
			shiftChildren((tween.totalDuration / tween.cachedTimeScale) + tween.delay, adjustLabels, 0);
			insert(tween, 0);
		}
		
		/**
		 * Inserts multiple tweens/timelines into the timeline at once, optionally aligning them (as a sequence for example)
		 * and/or staggering the timing. This is one of the most powerful methods in TimelineLite because it accommodates
		 * advanced timing effects and builds complex sequences with relatively little code.<br /><br />
		 *  
		 * @param tweens an Array containing any or all of the following: TweenLite, TweenMax, TimelineLite, and/or TimelineMax instances  
		 * @param timeOrLabel time in seconds (or frame if the timeline is frames-based) or label that serves as the point of insertion. For example, the number 2 would insert the tweens beginning at 2-seconds into the timeline, or "myLabel" would ihsert them wherever "myLabel" is.
		 * @param align determines how the tweens will be aligned in relation to each other before getting inserted. Options are: TweenAlign.SEQUENCE (aligns the tweens one-after-the-other in a sequence), TweenAlign.START (aligns the start times of all of the tweens (ignores delays)), and TweenAlign.NORMAL (aligns the start times of all the tweens (honors delays)). The default is NORMAL.
		 * @param stagger staggers the tweens by a set amount of time (in seconds) (or in frames for frames-based timelines). For example, if the stagger value is 0.5 and the "align" property is set to TweenAlign.START, the second tween will start 0.5 seconds after the first one starts, then 0.5 seconds later the third one will start, etc. If the align property is TweenAlign.SEQUENCE, there would be 0.5 seconds added between each tween. Default is 0.
		 */
		public function insertMultiple(tweens:Array, timeOrLabel:*=0, align:String="normal", stagger:Number=0):void {
			var i:int, tween:TweenCore, curTime:Number = Number(timeOrLabel) || 0, l:uint = tweens.length;
			if (typeof(timeOrLabel) == "string") {
				if (!(timeOrLabel in _labels)) {
					addLabel(timeOrLabel, this.duration);
				}
				curTime = _labels[timeOrLabel];
			}
			for (i = 0; i < l; i++) {
				tween = tweens[i] as TweenCore;
				insert(tween, curTime);
				if (align == "sequence") {
					curTime = tween.cachedStartTime + (tween.totalDuration / tween.cachedTimeScale);
				} else if (align == "start") {
					tween.cachedStartTime -= tween.delay;
				}
				curTime += stagger;
			}
		}
		
		/**
		 * Appends multiple tweens/timelines at the end of the timeline at once, optionally aligning them (as a sequence for example)
		 * and/or staggering the timing. This is one of the most powerful methods in TimelineLite because it accommodates
		 * advanced timing effects and builds complex sequences with relatively little code.<br /><br />
		 *  
		 * @param tweens an Array containing any or all of the following: TweenLite, TweenMax, TimelineLite, and/or TimelineMax instances  
		 * @param align determines how the tweens will be aligned in relation to each other before getting appended. Options are: TweenAlign.SEQUENCE (aligns the tweens one-after-the-other in a sequence), TweenAlign.START (aligns the start times of all of the tweens (ignores delays)), and TweenAlign.NORMAL (aligns the start times of all the tweens (honors delays)). The default is NORMAL.
		 * @param stagger staggers the tweens by a set amount of time (in seconds) (or in frames for frames-based timelines). For example, if the stagger value is 0.5 and the "align" property is set to TweenAlign.START, the second tween will start 0.5 seconds after the first one starts, then 0.5 seconds later the third one will start, etc. If the align property is TweenAlign.SEQUENCE, there would be 0.5 seconds added between each tween. Default is 0.
		 */
		public function appendMultiple(tweens:Array, align:String="normal", stagger:Number=0):void {
			insertMultiple(tweens, this.duration, align, stagger);
		}
		
		/**
		 * Prepends multiple tweens/timelines to the beginning of the timeline at once, moving all existing children back to make
		 * room, and optionally aligning the new children (as a sequence for example) and/or staggering the timing.<br /><br />
		 *  
		 * @param tweens an Array containing any or all of the following: TweenLite, TweenMax, TimelineLite, and/or TimelineMax instances  
		 * @param align determines how the tweens will be aligned in relation to each other before getting prepended. Options are: TweenAlign.SEQUENCE (aligns the tweens one-after-the-other in a sequence), TweenAlign.START (aligns the start times of all of the tweens (ignores delays)), and TweenAlign.NORMAL (aligns the start times of all the tweens (honors delays)). The default is NORMAL.
		 * @param stagger staggers the tweens by a set amount of time (in seconds) (or in frames for frames-based timelines). For example, if the stagger value is 0.5 and the "align" property is set to TweenAlign.START, the second tween will start 0.5 seconds after the first one starts, then 0.5 seconds later the third one will start, etc. If the align property is TweenAlign.SEQUENCE, there would be 0.5 seconds added between each tween. Default is 0.
		 */
		public function prependMultiple(tweens:Array, align:String="normal", stagger:Number=0, adjustLabels:Boolean=false):void {
			var tl:TimelineLite = new TimelineLite({tweens:tweens, align:align, stagger:stagger}); //dump them into a new temporary timeline initially so that we can determine the overall duration.
			shiftChildren(tl.duration, adjustLabels, 0);
			insertMultiple(tweens, 0, align, stagger);
			tl.kill();
		}
		
		
		/**
		 * Adds a label to the timeline, making it easy to mark important positions/times. gotoAndStop() and gotoAndPlay()
		 * allow you to skip directly to any label. This works just like timeline labels in the Flash IDE.
		 * 
		 * @param label The name of the label
		 * @param time The time in seconds (or frames for frames-based timelines) at which the label should be added. For example, myTimeline.addLabel("myLabel", 3) adds the label "myLabel" at 3 seconds into the timeline.
		 */
		public function addLabel(label:String, time:Number):void {
			_labels[label] = time;
		}
		
		/**
		 * Returns the time associated with a particular label.
		 * 
		 * @param label Label name
		 * @return Time associated with the label (or 0 if there is no such label)
		 */
		public function getLabelTime(label:String):Number {
			return (label in _labels) ? _labels[label] : 0;
		}
		
		
		/**
		 * Restarts the timeline and begins playing forward.
		 * 
		 * @param includeDelay determines whether or not the timeline's delay (if any) should be factored in
		 * @param suppressEvents If true, no events or callbacks will be triggered as the "virtual playhead" moves to the new position (onComplete, onUpdate, onReverseComplete, etc. of this timeline and any of its child tweens/timelines won't be triggered, nor will any of the associated events be dispatched) 
		 */
		public function restart(includeDelay:Boolean=false, suppressEvents:Boolean=true):void {
			this.reversed = false;
			this.paused = false;
			this.setTotalTime((includeDelay) ? -_delay : 0, suppressEvents);
		}
		
		/** Starts playing the timeline forwards from its current position. (essentially unpauses it and makes sure that it is not reversed) **/
		public function play():void {
			this.reversed = false;
			this.paused = false;
		}
		
		/** Starts playing the timeline from its current position without altering its direction (forward or reversed). **/
		public function resume():void {
			this.paused = false;
		}
		
		/** Pauses the playback of the timeline. **/
		public function stop():void {
			this.paused = true;
		}
		
		/**
		 * Skips to a particular time, frame, or label and plays the timeline forwards from there (unpausing it)
		 * 
		 * @param timeOrLabel time in seconds (or frame if the timeline is frames-based) or label to skip to. For example, myTimeline.gotoAndPlay(2) will skip to 2-seconds into a timeline, and myTimeline.gotoAndPlay("myLabel") will skip to wherever "myLabel" is. 
		 * @param suppressEvents If true, no events or callbacks will be triggered as the "virtual playhead" moves to the new position (onComplete, onUpdate, onReverseComplete, etc. of this timeline and any of its child tweens/timelines won't be triggered, nor will any of the associated events be dispatched) 
		 */
		public function gotoAndPlay(timeOrLabel:*, suppressEvents:Boolean=true):void {
			goto(timeOrLabel, suppressEvents);
			play();
		}
		
		/**
		 * Skips to a particular time, frame, or label and stops the timeline (pausing it)
		 * 
		 * @param timeOrLabel time in seconds (or frame if the timeline is frames-based) or label to skip to. For example, myTimeline.gotoAndStop(2) will skip to 2-seconds into a timeline, and myTimeline.gotoAndStop("myLabel") will skip to wherever "myLabel" is. 
		 * @param suppressEvents If true, no events or callbacks will be triggered as the "virtual playhead" moves to the new position (onComplete, onUpdate, onReverseComplete, etc. of this timeline and any of its child tweens/timelines won't be triggered, nor will any of the associated events be dispatched) 
		 */
		public function gotoAndStop(timeOrLabel:*, suppressEvents:Boolean=true):void {
			goto(timeOrLabel, suppressEvents);
			this.paused = true;
		}
		
		/**
		 * Skips to a particular time, frame, or label without changing the paused state of the timeline
		 * 
		 * @param timeOrLabel time in seconds (or frame if the timeline is frames-based) or label to skip to. For example, myTimeline.goto(2) will skip to 2-seconds into a timeline, and myTimeline.goto("myLabel") will skip to wherever "myLabel" is. 
		 * @param suppressEvents If true, no events or callbacks will be triggered as the "virtual playhead" moves to the new position (onComplete, onUpdate, onReverseComplete, etc. of this timeline and any of its child tweens/timelines won't be triggered, nor will any of the associated events be dispatched) 
		 */
		public function goto(timeOrLabel:*, suppressEvents:Boolean=true):void {
			if (typeof(timeOrLabel) == "string") {
				if (timeOrLabel in _labels) {
					setTotalTime((this.cachedReversed) ? this.duration - Number(_labels[timeOrLabel]) : Number(_labels[timeOrLabel]), suppressEvents);
				}
			} else {
				setTotalTime(Number(timeOrLabel), suppressEvents);
			}
		}
		
		/**
		 * Reverses the timeline smoothly, adjusting its startTime to avoid any skipping. After being reversed,
		 * the timeline will play backwards, exactly opposite from its forward orientation.
		 * 
		 * @param forceResume If true, the timeline will resume() immediately upon reversing. Otherwise the paused state will remain unchanged.
		 */
		public function reverse(forceResume:Boolean=true):void {
			this.reversed = true;
			if (forceResume) {
				this.paused = false;
			} else if (this.gc) {
				this.setEnabled(true, false);
			}
		}
		
		
		/**
		 * @private
		 * Renders all tweens and sub-timelines in the state they'd be at a particular time (or frame for frames-based timelines). 
		 * 
		 * @param time time in seconds (or frames for frames-based timelines) that should be rendered. 
		 * @param suppressEvents If true, no events or callbacks will be triggered for this render (like onComplete, onUpdate, onReverseComplete, etc.)
		 * @param force Normally the tween will skip rendering if the time matches the cachedTotalTime (to improve performance), but if force is true, it forces a render. This is primarily used internally for tweens with durations of zero in TimelineLite/Max instances.
		 */
		override public function renderTime(time:Number, suppressEvents:Boolean=false, force:Boolean=false):void {
			if (this.gc) {
				this.setEnabled(true, false);
			} else if (!this.active && !this.cachedPaused) {
				this.active = true;  //so that if the user renders a tween (as opposed to the timeline rendering it), the timeline is forced to re-render and align it with the proper time/frame on the next rendering cycle. Maybe the tween already finished but the user manually re-renders it as halfway done.
			}
			var totalDur:Number = (this.cacheIsDirty) ? this.totalDuration : this.cachedTotalDuration, prevTime:Number = this.cachedTime, tween:TweenCore, isComplete:Boolean, rendered:Boolean, next:TweenCore, dur:Number;
			if (time >= totalDur) {
				if (_rawPrevTime <= totalDur && _rawPrevTime != time) {
					this.cachedTotalTime = this.cachedTime = totalDur;
					forceChildrenToEnd(totalDur, suppressEvents);
					isComplete = !this.hasPausedChild();
					rendered = true;
					if (this.cachedDuration == 0 && isComplete && (time == 0 || _rawPrevTime < 0)) { //In order to accommodate zero-duration timelines, we must discern the momentum/direction of time in order to render values properly when the "playhead" goes past 0 in the forward direction or lands directly on it, and also when it moves past it in the backward direction (from a postitive time to a negative time).
						force = true;
					}
				}
				
			} else if (time <= 0) {
				if (time < 0) {
					this.active = false;
					if (this.cachedDuration == 0 && _rawPrevTime > 0) { //In order to accommodate zero-duration timelines, we must discern the momentum/direction of time in order to render values properly when the "playhead" goes past 0 in the forward direction or lands directly on it, and also when it moves past it in the backward direction (from a postitive time to a negative time).
						force = true;
						isComplete = true;
					}
				}
				if (_rawPrevTime >= 0 && _rawPrevTime != time) {
					forceChildrenToBeginning(0, suppressEvents);
					this.cachedTotalTime = 0;
					this.cachedTime = 0;
					rendered = true;
					if (this.cachedReversed) {
						isComplete = true;
					}
				}
			} else {
				this.cachedTotalTime = this.cachedTime = time;
			}
			_rawPrevTime = time;
			
			if (this.cachedTime == prevTime && !force) {
				return;
			} else if (!this.initted) {
				this.initted = true;
			}
			if (prevTime == 0 && this.vars.onStart != null && !suppressEvents) {
				this.vars.onStart.apply(null, this.vars.onStartParams);
			}
			
			if (rendered) {
				//already rendered
			} else if (this.cachedTime - prevTime > 0) {
				tween = _firstChild;
				while (tween) {
					next = tween.nextNode; //record it here because the value could change after rendering...
					if (tween.active || (!tween.cachedPaused && tween.cachedStartTime <= this.cachedTime)) {
						
						if (!tween.cachedReversed) {
							tween.renderTime((this.cachedTime - tween.cachedStartTime) * tween.cachedTimeScale, suppressEvents, false);
						} else {
							dur = (tween.cacheIsDirty) ? tween.totalDuration : tween.cachedTotalDuration;
							tween.renderTime(dur - ((this.cachedTime - tween.cachedStartTime) * tween.cachedTimeScale), suppressEvents, false);
						}
						
					}
					tween = next;
				}
			} else {
				tween = _lastChild;
				while (tween) {
					next = tween.prevNode; //record it here because the value could change after rendering...
					if (tween.active || (!tween.cachedPaused && tween.cachedStartTime <= prevTime)) {
						
						if (!tween.cachedReversed) {
							tween.renderTime((this.cachedTime - tween.cachedStartTime) * tween.cachedTimeScale, suppressEvents, false);
						} else {
							dur = (tween.cacheIsDirty) ? tween.totalDuration : tween.cachedTotalDuration;
							tween.renderTime(dur - ((this.cachedTime - tween.cachedStartTime) * tween.cachedTimeScale), suppressEvents, false);
						}
						
					}
					tween = next;
				}
			}
			if (_hasUpdate && !suppressEvents) {
				this.vars.onUpdate.apply(null, this.vars.onUpdateParams);
			}
			if (isComplete) {
				complete(true, suppressEvents);
			}
		}
		
		/**
		 * @private
		 * Due to occassional floating point rounding errors in Flash, sometimes child tweens/timelines were not being
		 * rendered at the very beginning (their currentProgress might be 0.000000000001 instead of 0 because when Flash 
		 * performed this.cachedTime - tween.startTime, floating point errors would return a value that
		 * was SLIGHTLY off). This method forces them to the beginning.
		 * 
		 * @param time Time that should be rendered (either zero or a negative number). The reason a negative number could be important is because if there are zero-duration tweens at the very beginning (startTime=0), we need a way to sense when the timeline has gone backwards BEYOND zero so that the tweens know to render their starting values instead of their ending values. If the time is exactly zero, those tweens would render their end values.
		 * @param suppressEvents If true, no events or callbacks will be triggered for this render (like onComplete, onUpdate, onReverseComplete, etc.)
		 */
		protected function forceChildrenToBeginning(time:Number, suppressEvents:Boolean=false):Number {
			var tween:TweenCore = _lastChild, next:TweenCore, dur:Number;
			while (tween) {
				next = tween.prevNode; //record it here because the value could change after rendering...
				if (tween.active || (!tween.cachedPaused && (tween.cachedTotalTime != 0 || tween.cachedDuration == 0))) {
					
					if (time == 0 && (tween.cachedDuration != 0 || tween.cachedStartTime == 0)) {
						tween.renderTime(tween.cachedReversed ? tween.cachedTotalDuration : 0, suppressEvents, false);
					} else if (!tween.cachedReversed) {
						tween.renderTime((time - tween.cachedStartTime) * tween.cachedTimeScale, suppressEvents, false);
					} else {
						dur = (tween.cacheIsDirty) ? tween.totalDuration : tween.cachedTotalDuration;
						tween.renderTime(dur - ((time - tween.cachedStartTime) * tween.cachedTimeScale), suppressEvents, false);
					}
					
				}
				tween = next;
			}
			return time;
		}
		
		/**
		 * @private
		 * Due to occassional floating point rounding errors in Flash, sometimes child tweens/timelines were not being
		 * fully completed (their currentProgress might be 0.999999999999998 instead of 1 because when Flash 
		 * performed this.cachedTime - tween.startTime, floating point errors would return a value that
		 * was SLIGHTLY off). This method forces them to completion.
		 * 
		 * @param time Time that should be rendered (either this.totalDuration or greater). The reason a greater number could be important is because if there are reversed zero-duration tweens at the very end, we need a way to sense when the timeline has gone BEYOND the end so that the tweens know to render their starting values instead of their ending values. If the time is exactly this.totalDuration, those reversed zero-duration tweens would render their end values.
		 * @param suppressEvents If true, no events or callbacks will be triggered for this render (like onComplete, onUpdate, onReverseComplete, etc.)
		 */
		protected function forceChildrenToEnd(time:Number, suppressEvents:Boolean=false):Number {
			var tween:TweenCore = _firstChild, next:TweenCore, dur:Number;
			while (tween) {
				next = tween.nextNode; //record it here because the value could change after rendering...
				if (tween.active || (!tween.cachedPaused && (tween.cachedTotalTime != tween.cachedTotalDuration || tween.cachedDuration == 0))) {
					
					if (time == this.cachedDuration && (tween.cachedDuration != 0 || tween.cachedStartTime == this.cachedDuration)) {
						tween.renderTime(tween.cachedReversed ? 0 : tween.cachedTotalDuration, suppressEvents, false);
					} else if (!tween.cachedReversed) {
						tween.renderTime((time - tween.cachedStartTime) * tween.cachedTimeScale, suppressEvents, false);
					} else {
						dur = (tween.cacheIsDirty) ? tween.totalDuration : tween.cachedTotalDuration;
						tween.renderTime(dur - ((time - tween.cachedStartTime) * tween.cachedTimeScale), suppressEvents, false);
					}
					
				}
				tween = next;
			}
			return time;
		}
		
		/**
		 * @private
		 * Checks the timeline to see if it has any paused children (tweens/timelines). 
		 * 
		 * @return Indicates whether or not the timeline contains any paused children
		 */
		public function hasPausedChild():Boolean {
			var tween:TweenCore = _firstChild || _endCaps[0];
			while (tween) {
				if (tween.cachedPaused || ((tween is TimelineLite) && (tween as TimelineLite).hasPausedChild())) {
					return true;
				}
				tween = tween.nextNode;
			}
			return false;
		}
		
		/**
		 * Forces the timeline to completion.
		 * 
		 * @param skipRender to skip rendering the final state of the timeline, set skipRender to true. 
		 * @param suppressEvents If true, no events or callbacks will be triggered for this render (like onComplete, onUpdate, onReverseComplete, etc.)
		 */
		override public function complete(skipRender:Boolean=false, suppressEvents:Boolean=false):void {
			if (!skipRender) {
				renderTime(this.totalDuration, suppressEvents, false); //just to force the final render
				return; //renderTime() will call complete(), so just return here.
			}
			if (this.timeline.autoRemoveChildren) {
				this.setEnabled(false, false);
			} else {
				this.active = false;
			}
			if (!suppressEvents) {
				if (this.cachedReversed && this.cachedTotalTime == 0 && this.cachedDuration != 0) {
					if (this.vars.onReverseComplete) {
						this.vars.onReverseComplete.apply(null, this.vars.onReverseCompleteParams);
					}
				} else if (this.vars.onComplete) {
					this.vars.onComplete.apply(null, this.vars.onCompleteParams);
				}
			}
		}
		
		
		/**
		 * Provides an easy way to get all of the tweens and/or timelines nested in this timeline (as an Array). 
		 *  
		 * @param nested determines whether or not tweens and/or timelines that are inside nested timelines should be returned. If you only want the "top level" tweens/timelines, set this to false.
		 * @param tweens determines whether or not tweens (TweenLite and TweenMax instances) should be included in the results
		 * @param timelines determines whether or not timelines (TimelineLite and TimelineMax instances) should be included in the results
		 * @return an Array containing the child tweens/timelines.
		 */
		public function getChildren(nested:Boolean=true, tweens:Boolean=true, timelines:Boolean=true):Array {
			var a:Array = [], tween:TweenCore = _firstChild || _endCaps[0];
			while (tween) {
				if (tween is TweenLite) {
					if (tweens) {
						a[a.length] = tween;
					}
				} else {
					if (timelines) {
						a[a.length] = tween;
					}
					if (nested) {
						a = a.concat((tween as TimelineLite).getChildren(true, tweens, timelines));
					}
				}
				tween = tween.nextNode;
			}
			return a;
		}
		
		/**
		 * Returns the tweens of a particular object that are inside this timeline.
		 * 
		 * @param target the target object of the tweens
		 * @param nested determines whether or not tweens that are inside nested timelines should be returned. If you only want the "top level" tweens/timelines, set this to false.
		 * @return an Array of TweenLite and TweenMax instances
		 */
		public function getTweensOf(target:Object, nested:Boolean=true):Array {
			var tweens:Array = getChildren(nested, true, false), a:Array = [], i:int;
			var l:uint = tweens.length;
			for (i = 0; i < l; i++) {
				if (tweens[i].target == target) {
					a[a.length] = tweens[i];
				}
			}
			return a;
		}
		
		/**
		 * Shifts the startTime of the timeline's children by a certain amount and optionally adjusts labels too. This can be useful
		 * when you want to prepend children or splice them into a certain spot, moving existing ones back to make room for the new ones.
		 * 
		 * @param amount Number of seconds (or frames for frames-based timelines) to move each child.
		 * @param adjustLabels If true, the timing of all labels will be adjusted as well.
		 * @param ignoreBeforeTime All children that begin at or after the startAtTime will be affected by the shift (the default is 0, causing all children to be affected). This provides an easy way to splice children into a certain spot on the timeline, pushing only the children after that point back to make room.
		 */
		public function shiftChildren(amount:Number, adjustLabels:Boolean=false, ignoreBeforeTime:Number=0):void {
			var tween:TweenCore = _firstChild || _endCaps[0];
			while (tween) {
				if (tween.cachedStartTime >= ignoreBeforeTime) {
					tween.cachedStartTime += amount;
				}
				tween = tween.nextNode;
			}
			if (adjustLabels) {
				for (var p:String in _labels) {
					if (_labels[p] >= ignoreBeforeTime) {
						_labels[p] += amount;
					}
				}
			}
			this.setDirtyCache(true);
		}
		
		/**
		 * Kills tweens of a particular object.
		 * 
		 * @param target the target object of the tweens
		 * @param nested determines whether or not tweens that are inside nested timelines should be affected. If you only want the "top level" tweens/timelines to be affected, set this to false.
		 */
		public function killTweensOf(target:Object, nested:Boolean=true):Boolean {
			var tweens:Array = getTweensOf(target, nested);
			var i:int = tweens.length;
			while (i--) {
				TweenLite(tweens[i]).setEnabled(false, false);
			}
			return Boolean(tweens.length > 0);
		}
		
		/**
		 * @private
		 * Sets the cacheIsDirty property of all anscestor timelines (and optionally this timeline too). Setting
		 * the cacheIsDirty to true forces recalculation of its cachedDuration and cachedTotalDuration and sorts 
		 * the child TweenCores so that they're in the proper order next time the duration or totalDuration is 
		 * requested. I don't just recalculate them immediately because it can be much faster to do it this way.
		 * 
		 * @param includeSelf indicates whether or not this timeline's cacheIsDirty property should be affected.
		 */
		protected function setDirtyCache(includeSelf:Boolean=true):void {
			var tween:TweenCore = (includeSelf) ? this : this.timeline;
			while (tween) {
				tween.cacheIsDirty = true;
				tween = tween.timeline;
			}
		}
		
		/** @inheritDoc **/
		override public function invalidate():void {
			var tween:TweenCore = _firstChild || _endCaps[0];
			while (tween) {
				tween.invalidate();
				tween = tween.nextNode;
			}
		}
		
		/**
		 * Empties the timeline of all child tweens/timelines, or you can optionally pass an Array containing specific 
		 * tweens/timelines to remove. So <code>myTimeline.clear()</code> would remove all children whereas 
		 * <code>myTimeline.clear([tween1, tween2])</code> would only remove tween1 and tween2. You could even clear only 
		 * the tweens of a particular object with <code>myTimeline.clear(myTimeline.getTweensOf(myObject));</code>
		 * 
		 * @param tweens (optional) An Array containing specific children to remove.
		 */
		public function clear(tweens:Array=null):void {
			if (tweens == null) {
				tweens = getChildren(false, true, true);
			}
			var i:int = tweens.length;
			while (i--) {
				TweenCore(tweens[i]).setEnabled(false, false);
			}
		}
		
		/** @inheritDoc **/
		override public function setEnabled(enabled:Boolean, ignoreTimeline:Boolean=false):Boolean {
			if (enabled == this.gc) {
				var tween:TweenCore, next:TweenCore;
				
				/*
				NOTE: To avoid circular references (TweenCore.timeline and SimpleTimeline._firstChild/_lastChild) which cause garbage collection
				problems, store the _firstChild and _lastChild in the _endCaps Array when the timeline is disabled.
				*/
				
				if (enabled) {
					_firstChild = tween = _endCaps[0];
					_lastChild = _endCaps[1];					
				} else {
					tween = _firstChild;
					_endCaps = [_firstChild, _lastChild];
					_firstChild = _lastChild = null;
				}
				
				while (tween) {
					tween.setEnabled(enabled, true);
					tween = tween.nextNode;
				}
				
				return super.setEnabled(enabled, ignoreTimeline);
			}
			return false;
		}
		
		/**
		 * @private
		 * Exactly the same as setting the totalTime property but also allows for suppression of events. 
		 * 
		 * @param totalTime Time that should be rendered (includes any repeats and repeatDelays for TimelineMax)
		 * @param suppressEvents If true, no events or callbacks will be triggered for this render (like onComplete, onUpdate, onReverseComplete, etc.)
		 **/
		protected function setTotalTime(totalTime:Number, suppressEvents:Boolean=false):void {
			var tlTime:Number = (_pauseTime || _pauseTime == 0) ? _pauseTime : this.timeline.cachedTotalTime;
			if (this.cachedReversed) {
				var dur:Number = (this.cacheIsDirty) ? this.totalDuration : this.cachedTotalDuration;
				this.cachedStartTime = tlTime - ((dur - totalTime) / this.cachedTimeScale);
			} else {
				this.cachedStartTime = tlTime - (totalTime / this.cachedTimeScale);
			}
			setDirtyCache(false);
			renderTime(totalTime, suppressEvents, false);
		}
		
		
		
//---- GETTERS / SETTERS -------------------------------------------------------------------------------------------------------
				
		/** 
		 * Value between 0 and 1 indicating the progress of the timeline according to its duration 
 		 * where 0 is at the beginning, 0.5 is halfway finished, and 1 is finished. <code>totalProgress</code>, 
 		 * by contrast, describes the overall progress according to the timeline's <code>totalDuration</code> 
 		 * which includes repeats and repeatDelays (if there are any). Since TimelineLite doesn't offer 
 		 * "repeat" and "repeatDelay" functionality, <code>currentProgress</code> and <code>totalProgress</code> are always the same
 		 * but in TimelineMax, they could be different. For example, if a TimelineMax instance 
		 * is set to repeat once, at the end of the first cycle <code>totalProgress</code> would only be 0.5 
		 * whereas <code>currentProgress</code> would be 1. If you tracked both properties over the course of the 
		 * tween, you'd see <code>currentProgress</code> go from 0 to 1 twice (once for each cycle) in the same
		 * time it takes the <code>totalProgress</code> property to go from 0 to 1 once.
		 **/
		public function get currentProgress():Number {
			return this.cachedTime / this.duration;
		}
		
		public function set currentProgress(n:Number):void {
			setTotalTime(this.duration * n, false);
		}
		
		/**
		 * Most recently rendered time (or frame for frames-based timelines) according to the timeline's 
		 * duration. <code>totalTime</code>, by contrast, is based on the totalDuration which includes repeats and repeatDelays.
		 * Since TimelineLite doesn't offer "repeat" and "repeatDelay" functionality, <code>currentTime</code> and <code>totalTime</code>
		 * will always be the same but in TimelineMax, they could be different. For example, if a TimelineMax
		 * instance has a duration of 5 a repeat of 1 (meaning its totalDuration is 10), at the end 
		 * of the second cycle, <code>currentTime</code> would be 5 whereas <code>totalTime</code> would be 10. If you tracked both
		 * properties over the course of the tween, you'd see <code>currentTime</code> go from 0 to 5 twice (one for each
		 * cycle) in the same time it takes <code>totalTime</code> go from 0 to 10.
		 **/
		override public function set currentTime(n:Number):void {
			setTotalTime(n);
		}
		
		/**
		 * Most recently rendered time (or frame for frames-based timelines) according to the timeline's 
		 * totalDuration. <code>currentTime</code>, by contrast, is based on the duration which does NOT include repeats and repeatDelays.
		 * Since TimelineLite doesn't offer "repeat" and "repeatDelay" functionality, <code>currentTime</code> and <code>totalTime</code>
		 * will always be the same but in TimelineMax, they could be different. For example, if a TimelineMax
		 * instance has a duration of 5 a repeat of 1 (meaning its totalDuration is 10), at the end 
		 * of the second cycle, <code>currentTime</code> would be 5 whereas <code>totalTime</code> would be 10. If you tracked both
		 * properties over the course of the tween, you'd see <code>currentTime</code> go from 0 to 5 twice (one for each
		 * cycle) in the same time it takes <code>totalTime</code> go from 0 to 10.
		 **/
		public function get totalTime():Number {
			return this.cachedTotalTime;
		}
		
		public function set totalTime(n:Number):void {
			setTotalTime(n, false);
		}
		
		/**
		 * Duration of the timeline in seconds (or frames for frames-based timelines) not including any repeats
		 * or repeatDelays. "totalDuration", by contrast, does include repeats and repeatDelays but since TimelineLite
		 * doesn't offer "repeat" and "repeatDelay" functionality, duration and totalDuration will always be the same. 
		 * In TimelineMax, however, they could be different. 
		 **/
		override public function get duration():Number {
			if (this.cacheIsDirty) {
				var d:Number = this.totalDuration; //just triggers recalculation
			}
			return this.cachedDuration;
		}
		
		override public function set duration(n:Number):void {
			if (this.duration != 0 && n != 0) {
				this.timeScale = this.duration / n;
			}
		}
		
		/**
		 * Duration of the timeline in seconds (or frames for frames-based timelines) including any repeats
		 * or repeatDelays. "duration", by contrast, does NOT include repeats and repeatDelays. Since TimelineLite
		 * doesn't offer "repeat" and "repeatDelay" functionality, duration and totalDuration will always be the same. 
		 * In TimelineMax, however, they could be different. 
		 **/
		override public function get totalDuration():Number {
			if (this.cacheIsDirty) {
				var max:Number = 0, end:Number, tween:TweenCore = _firstChild || _endCaps[0], prevStart:Number = -Infinity, next:TweenCore;
				while (tween) {
					next = tween.nextNode; //record it here in case the tween changes position in the sequence...
					
					if (tween.cachedStartTime < prevStart) { //in case one of the tweens shifted out of order, it needs to be re-inserted into the correct position in the sequence
						this.addChild(tween);
						prevStart = tween.prevNode.cachedStartTime;
					} else {
						prevStart = tween.cachedStartTime;
					}
					if (tween.cachedStartTime < 0) { //children aren't allowed to have negative startTimes, so adjust here if one is found.
						max -= tween.cachedStartTime;
						this.shiftChildren(-tween.cachedStartTime, false, -9999999999);
					}
					end = tween.cachedStartTime + (tween.totalDuration / tween.cachedTimeScale);
					if (end > max) {
						max = end;
					}
					
					tween = next;
				}
				this.cachedDuration = this.cachedTotalDuration = max;
				this.cacheIsDirty = false;
			}
			return this.cachedTotalDuration;
		}
		
		override public function set totalDuration(n:Number):void {
			if (this.totalDuration != 0 && n != 0) {
				this.timeScale = this.totalDuration / n;
			}
		}
		
		/** Multiplier describing the speed of the timeline where 1 is normal speed, 0.5 is half-speed, 2 is double speed, etc. **/
		public function get timeScale():Number {
			return this.cachedTimeScale;
		}
		
		public function set timeScale(n:Number):void {
			if (n == 0) { //can't allow zero because it'll throw the math off
				n = 0.0001;
			}
			var tlTime:Number = (_pauseTime || _pauseTime == 0) ? _pauseTime : this.timeline.cachedTotalTime;
			this.cachedStartTime = tlTime - ((tlTime - this.cachedStartTime) * this.cachedTimeScale / n);
			this.cachedTimeScale = n;
			setDirtyCache(false);
		}
		
		/** When a Timeline is reversed, it acts as though the playhead moves backwards in time as the tween progresses. It does not take into account the reversed state of anscestor timelines, so for example, a timeline that is not reversed might appear reversed if its parent timeline (or any ancenstor timeline) is reversed. In TimelineMax, this value is not affected by yoyo repeats. **/
		public function get reversed():Boolean {
			return this.cachedReversed;
		}
		
		public function set reversed(b:Boolean):void {
			if (b != this.cachedReversed) {
				var p:Number = (b) ? (1 - (this.cachedTotalTime / this.totalDuration)) : this.cachedTotalTime / this.totalDuration;
				var tlTime:Number = (_pauseTime || _pauseTime == 0) ? _pauseTime : this.timeline.cachedTotalTime;
				this.cachedStartTime = tlTime - (p * this.totalDuration / this.cachedTimeScale);
				this.cachedReversed = b;
				setDirtyCache(false);
			}
		}
		
		/** Paused state of the timeline. This does not take into account anscestor timelines, so for example, a timeline that is not paused might appear paused if its parent timeline (or any ancenstor timeline) is paused. **/
		public function get paused():Boolean {
			return this.cachedPaused;
		}
		
		public function set paused(b:Boolean):void {
			if (b != this.cachedPaused) {
				if (b) {
					_pauseTime = this.timeline.rawTime;
				} else {
					this.cachedStartTime += this.timeline.rawTime - _pauseTime;
					_pauseTime = NaN;
					var dur:Number = this.totalDuration; //ensures that the cachedDuration/cachedTotalDuration is refreshed. Otherwise, if someone created a timeline, paused it immediately, added a bunch of tweens, and then unpaused it, the cachedDuration would still be zero meaning it could get ignored in the rendering queue.
				}
				this.cachedPaused = b;
				this.active = Boolean(!this.cachedPaused && this.cachedTotalTime > 0 && this.cachedTotalTime < this.cachedTotalDuration);
			}
			if (!b && this.gc) {
				this.setEnabled(true, false);
			}
		}
		
		/** 
		 * Indicates whether or not the timeline's timing mode is frames-based as opposed to time-based. 
		 * This can only be set via the vars object in the constructor, or by attaching it to a timeline with the desired
		 * timing mode (a timeline's timing mode is always determined by its parent timeline) 
		 **/
		public function get useFrames():Boolean {
			var tl:SimpleTimeline = this.timeline;
			while (tl.timeline) {
				tl = tl.timeline;
			}
			return Boolean(tl == TweenLite.rootFramesTimeline);
		}
		
		/**
		 * @private
		 * Reports the totalTime of the timeline without capping the number at the totalDuration (max) and zero (minimum) which can be useful when
		 * unpausing tweens/timelines. Imagine a case where a paused tween is in a timeline that has already reached the end, but then
		 * the tween gets unpaused - it needs a way to place itself accurately in time AFTER what was previously the timeline's end time.
		 * 
		 * @return The totalTime of the timeline without capping the number at the totalDuration (max) and zero (minimum)
		 */
		override public function get rawTime():Number {
			if ((this.cachedTotalTime != 0 && this.cachedTotalTime != this.cachedTotalDuration)) { //note: don't use this.totalDuration because if other tweens get unpaused before this one, the totalDuration could change.  
				return this.cachedTotalTime;
			} else {
				return (this.timeline.rawTime - this.cachedStartTime) * this.cachedTimeScale;
			}
		}
		
		
	}
}