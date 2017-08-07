From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 4.9.33-rt23 latency under high load
Date: Mon, 7 Aug 2017 15:46:22 +0200
Message-ID: <20170807134622.okjuu56qupao4zqk@linutronix.de>
References: <efca9200a0d04af788a7f32322091337@S1P7MBX1A.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Carol Wong <carolw@netacquire.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:44406 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbdHGNqZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Aug 2017 09:46:25 -0400
Content-Disposition: inline
In-Reply-To: <efca9200a0d04af788a7f32322091337@S1P7MBX1A.EXCHPROD.USA.NET>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-07-27 22:45:38 [+0000], Carol Wong wrote:
> Hi,
Hi,

> On my test setup, cyclictest is reporting max latency > 500 us in 4.9.33-rt23 and 4.9.35-rt25. Max latency is small in 4.9.33-rt22 and 4.9.33-rt21 (< 50 us) under the same conditions. 
> 
> My test setup uses a Core i7 (3.4GHz 3rd gen) with hyper-threading disabled. The system is under heavy load (60-90% each core) servicing network traffic and performing arithmetic on the packet payloads. Interrupt rate is approximately 60K intr/s. I've tried a few different NICs (e1000, e1000e, and ixgbe) with the same result. Occasional big hits start occurring within 30 minutes.
> 
> I tried a modified 4.9.33-rt23 kernel with the following commit removed: 
> <https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/commit/kernel/sched/core.c?h=v4.9-rt&id=1dc89be37874bfc7bb4a0ea7c45492d7db39f62b>
> The big latency hits do not happen with this commit backed out.

so you say with this change is responsible for 450us of latency?
This change should be a nop if you don't change the task's CPU-mask
while the task is in a migrate-disable section. Do I miss something? Is
part of your workload changing cpu-affinity mask?

> I've not yet had a chance to try a 4.11 kernel, but it looks like there's been recent work on migrate_disable/enable in that branch. Maybe a backport to 4.9 is needed?

v4.11 should have the same change you just pointed out.

> Cheers,
> Carol
> 
Sebastian
