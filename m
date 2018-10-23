Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:43957 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbeJWR6v (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Oct 2018 13:58:51 -0400
Date: Tue, 23 Oct 2018 11:36:13 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 100% RT load on 2 processor SMP machine
Message-ID: <20181023093613.y6w76hnrvbzetsi2@linutronix.de>
References: <2762823.FS3CZOEJbg@dabox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2762823.FS3CZOEJbg@dabox>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Tim Sander <tim@krieglstein.org>
Cc: linux-rt-users@vger.kernel.org

On 2018-10-15 17:44:42 [+0200], Tim Sander wrote:
> Hi
Hi,

> I just disovered a bug in my playground realtime application which led to 100% 
> load on one core. This was the non normal case when the system was waiting for 
> a network client to connect and i had a fifo buffer overflow which led 
> accidentially to a busy wait loop with 98 fifo priority. This in turn lead to 
> a system which did not accept any new network connections.
> 
> The expected behaviour for a SMP system which still has one processor lightly 
> loaded should be that it still works "normal" even if one core is overloaded 
> with hard realtime work. Are there any explanations for this behavior?
> 
You should figure what blocked you from working in the end. So if you
had an interrupt pinned to the CPU that was blocked by RT task then this
would explain why it did not make any progress.
If you disable RT_RUNTIME_SHARE then the RT (that went wild) will be
throttled.

	echo NO_RT_RUNTIME_SHARE > /sys/kernel/debug/sched_features
> 
> Best regards
> Tim

Sebastian
