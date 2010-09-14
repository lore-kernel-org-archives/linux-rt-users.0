From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: preempt rt in commercial use
Date: Tue, 14 Sep 2010 15:09:58 -0700
Message-ID: <4C8FF2B6.2090205@us.ibm.com>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <201009141317.13439@zigzag.lvk.cs.msu.su> <AANLkTikCwVw9jsg+L_e-kHnhogSdgE+8rrO8O0gDMB5V@mail.gmail.com> <20100914094411.GB10841@pengutronix.de> <4C8F8500.5070002@theptrgroup.com> <4C8F7AB90200005A00071A8F@soto.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robert Schwebel <r.schwebel@pengutronix.de>,
	Jeff Angielski <jeff@theptrgroup.com>,
	"Nikita V. Youshchenko" <yoush@cs.msu.su>, Raz <raziebe@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:58226 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201Ab0INWIn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Sep 2010 18:08:43 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8ELuWoe032249
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2010 15:56:32 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o8EM8hx8119834
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2010 16:08:43 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o8EM8gSd013817
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2010 16:08:42 -0600
In-Reply-To: <4C8F7AB90200005A00071A8F@soto.provo.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 09/14/2010 10:38 AM, Gregory Haskins wrote:

>> No.  Preempt rt it's not hard realtime.
>
> This is not technically correct, but a common misconception. "Hard" vs "Soft" is a property of the _application_, not the os/platform itself, and it's based on how tolerant a given application is to missed deadlines.
>
> "Hard" might be something like professional lossless audio, nuclear fuel-rod control, bomb-squad robotics, tele-medicine, etc, where the result of a missed deadline can have a serious/unacceptable negative impact (death, injury, SLA failure, etc).  "Soft" might be telecom audio, high-frequency financial trading, etc, where misses (crappy audio quality, missed market opportunity, etc) are certainly not desired, but can technically be gracefully recovered from.
>
> Any given platform (os and hardware combo) will have quantifiable performance/latency characteristics.  If those characteristics exceed the requirements of your application, they it would generally work to run a "hard rt" application on that platform.  If those characteristics<= your app, it probably will not meet your deadlines and therefore, a hard-rt app will fail.
>
> Consider a fictious nuclear fuel rod control applications with requirements for a period of 20s, 500ms dutycycle, and with +- 1s jitter tolerance.  Failure means reactor meltdown (this is hard-realtime) yet preempt-rt could certainly handle this.  Heck, mainline linux could probably handle this.  On the other hand, if anyone out there plans on doing fuel-rod control with software, please tell me so I can leave the continent. ;)  But the point is, it's a hard-realtime application and it can be done even with preempt-rt.  As you scale the applicaiton's requirements tighter and tighter, you will eventually find the limits of the platform to which it is no longer acceptable to run the application.  On modern x86 desktops, these limits are in the order of 10us-150us.
>
> The biggest challenge is _proving_ that a given platform actually possesses the desired performance characteristics.  This is especially difficult with preempt-rt given that its based on a general purpose OS (linux) and a large one that that.  Smaller, more RT specific os designs may be easier to prove every path has a maximum latency of "X".  That said, there are very few products out there that could probably fit that description and most will have trouble proving beyond a shadow of doubt.  In addition, the preempt-rt community is very responsive and treats every latency source as a "bug" to be fixed/improved.
>
> So bottom line, if in doubt, I suggest you give preempt-rt a try.  Linux in general boasts probably the broadest support profile of any platform out there.  In addition, it's configuration is so finely grained that you can probably scale it back to a lean, mean, low-latency environment that will do what you need for perhaps all but the most stringent requirements.  Where it wouldn't work, perhaps only dedicated hardware may help anyway.


I would go further and say people need to stop using the terms
"hard" and "soft". There isn't a binary yes/no answer to the real-time
requirements spectrum.

Applications can have varying response time requirements, from
microseconds to milliseconds to seconds to minutes as Greg says above.

Applications might have differing penalties for missed deadlines:
  * nuclear reactor explodes
  * I lose a trade and it costs me money
  * I get a slightly different stock price quoted to me
  * Justin Bieber sounds a little hoarse

If you're discussing Linux real-time, chances are your application
does not fall in the first one. Typically a very custom engineered
solution (hardware and software) is used for those who have rather
severe constraints.

The concept of "hard" as being mathematically/logically provable
in terms of specs and code examination is nice, but not very practical.
As other people have pointed out frequently, given any system, it's
possible to break its guaranteed deadlines (catastrophic hw failure,
etc.

The real-time Linux patchset (CONFIG_PREEMPT_RT) provides real-time
support in Linux. As you might expect from a general-purpose OS
providing real-time, it's providing increased determinism and better
control over your system (most significantly, your kernel tasks).

A more preemptive kernel and system with better time granularity
provides better real-time response compared to a standard kernel.

It's important to note that we're not providing guarantees. Latency
response time expectations are really based on empirical evidence,
testing with common hw/sw/configurations and debugging issues when
an issue is reported.

Seriously, the terms "hard" and "soft" really only serve to either
confuse or have little value (other than "custom" and "non-custom").

thanks,
Nivedita



