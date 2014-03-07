From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 3/6] rt: Make cpu_chill() use hrtimer instead of msleep()
Date: Fri, 07 Mar 2014 16:23:10 +0100
Message-ID: <5319E45E.20900@linutronix.de>
References: <20140305003333.402759240@goodmis.org>	<20140305003346.602499217@goodmis.org>	<531996BB.2050401@linutronix.de> <20140307095223.2f412a1a@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	stable-rt@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140307095223.2f412a1a@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 03/07/2014 03:52 PM, Steven Rostedt wrote:
>> Now that you posted "cpu_chill: Add a UNINTERRUPTIBLE
>> hrtimer_nanosleep" wouldn't it make sense to delay this patches from
>> the stable series until we get them all in one go?
> 
> Sure, say this on the day I'm about to release ;-)

Haven't noticed that earlier.

> Nah, I'll release these today anyway. Otherwise I can't update to the
> mainline stables. When the rc candidates are out, it holds up any new
> updates to the versions.
> 
> Also, the stable 3.10 has this bug already. Might as well update all
> the stables with the same fix. It makes it easier on my side, as the
> way I do the updates is to use the same quilt queue for all releases. I
> start with 3.10, and get them working, and then apply the same queue to
> 3.8. Any conflicts in the patch I do a quilt fork, with a -v3.8
> appended, and then after getting that working I go to 3.4, and so on.
> This also lets me drop patches that are not applicable for earlier
> releases.
> 
> If I delay this for a new update, then 3.10 will be out of sync. I'm
> just going to release these, and then we can start a new one right away.

No worries. Do as it is easier for you.

> 
> Thanks!
> 
> -- Steve
> 
Sebastian
