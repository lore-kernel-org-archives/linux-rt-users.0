From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch-3.18.7-rt1] sched/context-tracking: fix PREEMPT_LAZY explosions
Date: Mon, 09 Mar 2015 15:45:41 +0100
Message-ID: <54FDB215.1090205@linutronix.de>
References: <20150216111822.GA21649@linutronix.de>	 <1424258514.3819.39.camel@gmail.com> <20150309134535.GA13768@linutronix.de> <1425911771.30469.8.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425911771.30469.8.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 03/09/2015 03:36 PM, Mike Galbraith wrote:
> On Mon, 2015-03-09 at 14:45 +0100, Sebastian Andrzej Siewior wrote:
>> * Mike Galbraith | 2015-02-18 12:21:54 [+0100]:
>>
>>> On Mon, 2015-02-16 at 12:18 +0100, Sebastian Andrzej Siewior wrote:
>>>
>>>> Known issues:
>>>>
>>>>       - lazy preempt on x86_64 leads to a crash with some load.
>>>
>>> The below still works for me.  (it doesn't make nohz_full actually work
>>> in rt, but at least folks who want to tinker with it can do so)
>> So your box still crashes without it?
>>
>> The thing is I tried to reproduce it and it does not occur anymore.
>> Neither in KVM nor on real HW.
> 
> Heh, well that's interesting, I just presumed it would still explode
> because you said it would.  I'll beat on it any let you know if I'm
> carrying a placebo patch or not :)

Hehe. By the time I did 3.18-rt1 I was surprised that the disable-
lazy-preempt-on-x8664 was still there because I assumed it has been
fixed in the v3.14 series. So I left it as-is (including the broken
message) and wanted to drop later an eye on it. And after you dropped a
few patches to fix it I assumed (even more) that it is still broken :)

> 
> 	-Mike
> 

Sebastian
