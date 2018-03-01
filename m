From: Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [PATCH v3 2/2] timers: Don't search for expired timers while
 TIMER_SOFTIRQ is scheduled
Date: Thu, 1 Mar 2018 12:37:49 -0600
Message-ID: <7079102c-f53b-e8ab-c54d-1c40ff21d921@ni.com>
References: <alpine.DEB.2.20.1707182206110.2425@nanos>
 <20170803210657.19179-1-haris.okanovic@ni.com>
 <20170803210657.19179-2-haris.okanovic@ni.com>
 <28f05e39-6bc6-99c5-e1bc-91be3e79ea78@ni.com>
 <13c06708-f7ad-4f46-1c0b-f12d1ca16beb@ni.com>
 <20180301164755.pipco45y5nlvmdsy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, julia.cartwright@ni.com, gratian.crisan@ni.com,
        anna-maria@linutronix.de
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180301164755.pipco45y5nlvmdsy@linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 03/01/2018 10:47 AM, Sebastian Andrzej Siewior wrote:
> On 2018-03-01 09:49:59 [-0600], Haris Okanovic wrote:
>> *bump* Has anyone looked into this?
> 
> I'm lost.
> It entered the kernel in v4.9.9-rt6 and left in v4.9.30-rt20 once we
> figured out that there is something wrong with it.

It was added back into 4.9 at some point after v4.9.30-rt20. I see an 
older version in v4.9.68-rt60, for example, hence my original email. It 
was dropped sometime thereafter, presumably because it no longer cleanly 
applies. I don't see it in v4.14.20-rt17, for example.

> Is it still in a RT tree somewhere?

I can't draw an exact timeline, since rt history is hard to follow. I 
don't think so.

> Is there a newer patch pending on your side?

Not yet. The latest version on patchwork is OK, just needs to be rebased 
post-4.9. I'll post a new version when I get a chance to build and 
retest it.

> 
> Sebastian
> 
