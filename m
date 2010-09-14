From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: preempt rt in commercial use
Date: Tue, 14 Sep 2010 11:38:01 -0600
Message-ID: <4C8F7AB90200005A00071A8F@soto.provo.novell.com>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com>
 <201009141317.13439@zigzag.lvk.cs.msu.su>
 <AANLkTikCwVw9jsg+L_e-kHnhogSdgE+8rrO8O0gDMB5V@mail.gmail.com>
 <20100914094411.GB10841@pengutronix.de> <4C8F8500.5070002@theptrgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: "Nikita V. Youshchenko" <yoush@cs.msu.su>,
	"Raz" <raziebe@gmail.com>,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>
To: "Robert Schwebel" <r.schwebel@pengutronix.de>,
	"Jeff Angielski" <jeff@theptrgroup.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
In-Reply-To: <4C8F8500.5070002@theptrgroup.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>>> On 9/14/2010 at 10:21 AM, in message <4C8F8500.5070002@theptrgroup.com>, Jeff
Angielski <jeff@theptrgroup.com> wrote: 
> On 09/14/2010 05:44 AM, Robert Schwebel wrote:
>> On Tue, Sep 14, 2010 at 11:24:21AM +0200, Raz wrote:
>>> anyone can say preempt rt is hard real time?
>>
>> Hard realtime has something to do with how you define "missing the
>> deadline". If somebody cuts the cable of your roboter controller in the
>> factory hall, the system misses the deadline. So it is all about
>> probabilities: hard realtime systems have a very, very low probability
>> of missing the deadline. However, in real life systems, it is>  0%.
>>
>> So yes, if you talk about real world, it is hard realtime.
> 
> No.  Preempt rt it's not hard realtime.

This is not technically correct, but a common misconception. "Hard" vs "Soft" is a property of the _application_, not the os/platform itself, and it's based on how tolerant a given application is to missed deadlines.

"Hard" might be something like professional lossless audio, nuclear fuel-rod control, bomb-squad robotics, tele-medicine, etc, where the result of a missed deadline can have a serious/unacceptable negative impact (death, injury, SLA failure, etc).  "Soft" might be telecom audio, high-frequency financial trading, etc, where misses (crappy audio quality, missed market opportunity, etc) are certainly not desired, but can technically be gracefully recovered from.

Any given platform (os and hardware combo) will have quantifiable performance/latency characteristics.  If those characteristics exceed the requirements of your application, they it would generally work to run a "hard rt" application on that platform.  If those characteristics <= your app, it probably will not meet your deadlines and therefore, a hard-rt app will fail.

Consider a fictious nuclear fuel rod control applications with requirements for a period of 20s, 500ms dutycycle, and with +- 1s jitter tolerance.  Failure means reactor meltdown (this is hard-realtime) yet preempt-rt could certainly handle this.  Heck, mainline linux could probably handle this.  On the other hand, if anyone out there plans on doing fuel-rod control with software, please tell me so I can leave the continent. ;)  But the point is, it's a hard-realtime application and it can be done even with preempt-rt.  As you scale the applicaiton's requirements tighter and tighter, you will eventually find the limits of the platform to which it is no longer acceptable to run the application.  On modern x86 desktops, these limits are in the order of 10us-150us.

The biggest challenge is _proving_ that a given platform actually possesses the desired performance characteristics.  This is especially difficult with preempt-rt given that its based on a general purpose OS (linux) and a large one that that.  Smaller, more RT specific os designs may be easier to prove every path has a maximum latency of "X".  That said, there are very few products out there that could probably fit that description and most will have trouble proving beyond a shadow of doubt.  In addition, the preempt-rt community is very responsive and treats every latency source as a "bug" to be fixed/improved.

So bottom line, if in doubt, I suggest you give preempt-rt a try.  Linux in general boasts probably the broadest support profile of any platform out there.  In addition, it's configuration is so finely grained that you can probably scale it back to a lean, mean, low-latency environment that will do what you need for perhaps all but the most stringent requirements.  Where it wouldn't work, perhaps only dedicated hardware may help anyway.

> 
> But most people/companies who think they need hard realtime really 
> don't.

I do agree with this statement.
 
-Greg
