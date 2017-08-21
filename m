From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 4.9.33-rt23 latency under high load
Date: Mon, 21 Aug 2017 15:25:22 +0200
Message-ID: <20170821132522.nbtbdaj2ls5an6zw@linutronix.de>
References: <efca9200a0d04af788a7f32322091337@S1P7MBX1A.EXCHPROD.USA.NET>
 <20170807134622.okjuu56qupao4zqk@linutronix.de>
 <79e87984082046ca9cafa8baf74ee864@S1P7MBX1A.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Carol Wong <carolw@netacquire.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:50647 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753387AbdHUNZZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 21 Aug 2017 09:25:25 -0400
Content-Disposition: inline
In-Reply-To: <79e87984082046ca9cafa8baf74ee864@S1P7MBX1A.EXCHPROD.USA.NET>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-08-11 22:15:02 [+0000], Carol Wong wrote:
> Hi Sebastian,
Hi Carol,

> I can't say that this change is responsible, but I see a dramatic difference when this patch is removed. Perhaps this is a red herring. For sure in my test case, 4.9.30-rt21 reports small latency and 4.9.33-rt23 reports large latency.
> 
> > This change should be a nop if you don't change the task's CPU-mask
> > while the task is in a migrate-disable section. Do I miss something?
> > Is part of your workload changing cpu-affinity mask?
> > 
> 
> The test program does not alter affinity masks. 

interesting. Could you add a trace-printk to check if it gets into that
inner-loop if the mask changes and it needs to do the fixup? Other than
that I don't see anything that could make any difference.

> I performed the same test with 4.11.12-rt9 and observed large latencies under heavy cpu & net load.
> 
> [localhost:~]# cyclictest -S -p98 --policy=rr
> # /dev/cpu_dma_latency set to 0us
> policy: rr: loadavg: 0.65 0.61 0.56 1/204 2206
> 
> T: 0 ( 2131) P:98 I:1000 C:11132138 Min:      1 Act:    1 Avg:    1 Max:     375
> T: 1 ( 2132) P:98 I:1500 C:7421425 Min:      1 Act:    1 Avg:    1 Max:     105
> T: 2 ( 2133) P:98 I:2000 C:5566069 Min:      1 Act:    1 Avg:    1 Max:      68
> T: 3 ( 2134) P:98 I:2500 C:4452855 Min:      1 Act:    2 Avg:    1 Max:      64
> 
> 
> Cheers,
> Carol

Sebastian
