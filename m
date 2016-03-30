From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RT] Warning from swake_up_all_locked in rt-4.4.4-rt11
Date: Wed, 30 Mar 2016 12:22:51 +0200
Message-ID: <20160330102251.GB21849@linutronix.de>
References: <20160313225358.4eb9316a@sluggy.hsv.redhat.com>
 <alpine.DEB.2.11.1603140948560.3657@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Clark Williams <williams@redhat.com>,
	Daniel Wagner <wagi@monom.org>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1603140948560.3657@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Thomas Gleixner | 2016-03-14 09:49:52 [+0100]:

>On Sun, 13 Mar 2016, Clark Williams wrote:
>
>> I'm hitting the WARN_ON(wakes > 2) in $SUBJECT when resuming from suspend on my laptop (quad-core i7 with HT on). Looks like the warning gets hit 36 times on resume. E.g.:
>> This trace (and a similar one with device_resume) happens on all cpus so the
>> trace info is kinda jumbled up. I'll try it with WARN_ON_ONCE instead
>> tomorrow.
>
>If resume is the only case, then we can filter that out and not worry about it
>at all :)

I see here 3 to 7 loops on each warning in the resume case and I see
approx 7 warnings. It wakes always a kworker/u*/* task.
system_state is always set to SYSTEM_RUNNING so I am not sure what can
be used for filtering.
Any suggestions?

>Thanks,
>
>	tglx

Sebastian
