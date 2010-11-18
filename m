From: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Re: Slub support with PREEMPT_RT ?
Date: Thu, 18 Nov 2010 09:59:31 +0100
Message-ID: <AANLkTikV5Jykyv4+SBcJQqMvzMSUsXOUdXTQU5rOhcs_@mail.gmail.com>
References: <AANLkTimUb7rfRKCwhnf3s=Qw+J79_PqL_1Zk=fz5B99q@mail.gmail.com>
	<4CE4802D.6070903@linux.intel.com>
	<1290069601.2109.1295.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Darren Hart <dvhart@linux.intel.com>,
	linux-rt-users@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45884 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754904Ab0KRI7d (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Nov 2010 03:59:33 -0500
Received: by wwa36 with SMTP id 36so3071452wwa.1
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Nov 2010 00:59:32 -0800 (PST)
In-Reply-To: <1290069601.2109.1295.camel@laptop>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2010/11/18 Peter Zijlstra <peterz@infradead.org>:
> On Wed, 2010-11-17 at 17:23 -0800, Darren Hart wrote:
>> On 11/17/2010 08:18 AM, Jean-Michel Hautbois wrote:
>> > Hi !
>> >
>> > I am wondering why SLUB isn't supported with PREEMPT_RT ?
>> > I cannot find any info on that except the fact it is not working yet.
>> > What do we have to do in order to support it ?
>>
>> Peter can answer this better than I can, but it has something to do with
>> all the local_bh_disable() calls not being compatible with the goals of
>> PREEMPT_RT - if I remember correctly.
>
> Nah, its slub doens't use the softirq crap. But its close, you have to
> iron out the per-cpu assumptions in the thing. I did a few slub-rt ports
> at various times but the thing kept changing too much and I gave up.
>
> I should probably do a new port and hope the thing is more stable now
> that the excitement is down or somesuch.
>

My real question is the impact of SLUB compared to SLAB on the
determinism of kmalloc usage and all caches.
I did some tests using SLUB instead of SLAB on a small (MPC5200 /
400Mhz / 16k i-cache and 16k d-cache), and slub seems to be better.
But I don't know if there is a possibility to tune SLAB in order to
get good results.
