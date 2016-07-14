From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RT PATCH 1/2] timers: wakeup all timer waiters
Date: Thu, 14 Jul 2016 20:37:42 +0200
Message-ID: <bf4277f7-0da1-bbf6-4425-cfaeb74afab6@linutronix.de>
References: <1468512304-15310-1-git-send-email-bigeasy@linutronix.de>
 <20160714121341.2b0e70f5@gandalf.local.home>
 <e014d4ad-316f-3afe-fcac-923cd2f9a7e6@linutronix.de>
 <20160714131945.67cc8ce5@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160714131945.67cc8ce5@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 07/14/2016 07:19 PM, Steven Rostedt wrote:
>> While doing so I noticed that we drop the base lock during timer
>> invocations and so it could be possible that we have two invocations
>> of del_timer_sync() on a timer on the same "base" (one after the
>> other). This is patch #1.
>>
>> After that I saw that we do the wake up under the base lock but there
>> is no reason for it. So here is patch #2.
>>
>> Patch #1 is something that could happen in theory and I did not run in
>> any problem.
>>
> 
> OK, so patch 2 was just discovered by reviewing code?

both, not just patch 2.

> 
> -- Steve

Sebastian
