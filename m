From: Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [PATCH v3 2/2] timers: Don't search for expired timers while
 TIMER_SOFTIRQ is scheduled
Date: Fri, 2 Mar 2018 10:29:56 -0600
Message-ID: <98f4236e-9863-2af7-1170-51cd118f65bd@ni.com>
References: <alpine.DEB.2.20.1707182206110.2425@nanos>
 <20170803210657.19179-1-haris.okanovic@ni.com>
 <20170803210657.19179-2-haris.okanovic@ni.com>
 <28f05e39-6bc6-99c5-e1bc-91be3e79ea78@ni.com>
 <13c06708-f7ad-4f46-1c0b-f12d1ca16beb@ni.com>
 <20180301164755.pipco45y5nlvmdsy@linutronix.de>
 <7079102c-f53b-e8ab-c54d-1c40ff21d921@ni.com>
 <20180302145232.anp4hz25uwqygopa@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, julia.cartwright@ni.com, gratian.crisan@ni.com,
        anna-maria@linutronix.de
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180302145232.anp4hz25uwqygopa@linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> Could please point me to the code/patches or something?

I rebase onto v4.14.20-rt17, running some sanity test before reposting 
to ml (cyclictest & Anna's timertest). Will post V4 sometime today (US 
Central Time) if everything goes well.

Are you also asking for a 4.9 version? I'm fine leaving it out of 4.9.

-- Haris


On 03/02/2018 08:52 AM, Sebastian Andrzej Siewior wrote:
> On 2018-03-01 12:37:49 [-0600], Haris Okanovic wrote:
>> It was added back into 4.9 at some point after v4.9.30-rt20. I see an older
>> version in v4.9.68-rt60, for example, hence my original email. It was
>> dropped sometime thereafter, presumably because it no longer cleanly
>> applies. I don't see it in v4.14.20-rt17, for example.
> 
> It was removed in v4.9.34-rt24 via 95d4a348841d ("Revert "timers: Don't
> wake ktimersoftd on every tick""). I don't see any leftovers or an older
> version.
> Looking at the queue I see two patches from you and that is:
>   timers: Don't wake ktimersoftd on every tick
>   tpm_tis: fix stall after iowrite*()s
> 
> and the former is reverted. This was v4.9.84-rt62 that I've been looking
> at. Could please point me to the code/patches or something?
> 
>>> Is there a newer patch pending on your side?
>>
>> Not yet. The latest version on patchwork is OK, just needs to be rebased
>> post-4.9. I'll post a new version when I get a chance to build and retest
>> it.
> okay.
> 
> Sebastian
> 
