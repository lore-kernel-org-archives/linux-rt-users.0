From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] lockdep: Add nr_save_trace_invocations counter
Date: Fri, 23 Apr 2010 10:31:16 +0200
Message-ID: <w2v520f0cf11004230131i743c596emfd0e5b8870330a8b@mail.gmail.com>
References: <alpine.LFD.2.00.1004222208310.3155@localhost>
	 <20100423025850.GA21328@windriver.com>
	 <alpine.LFD.2.00.1004230907050.4151@localhost>
	 <1272009915.1646.25.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yong Zhang <yong.zhang@windriver.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sven-Thorsten Dietrich <thebigcorporation@gmail.com>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Gregory Haskins <ghaskins@novell.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:37173 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896Ab0DWIbT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 23 Apr 2010 04:31:19 -0400
In-Reply-To: <1272009915.1646.25.camel@laptop>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Apr 23, 2010 at 10:05 AM, Peter Zijlstra <peterz@infradead.org>=
 wrote:
> On Fri, 2010-04-23 at 09:24 +0200, John Kacur wrote:
>> direct dependencies: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A08752 [max: 1=
6384]
>> I have
>> stack-trace invocations: 10888
>> from the same run.
>>
>> Still trying to figure out what the meaning is of that though to be
>> honest.
>>
>> Here is a portion of the lockdep_stats, with all of the new fields a=
nd the
>> redundant ones.
>>
>> stack-trace invocations: 10888
>> =A0 =A0 =A0 =A0 LOCK_USED_IN_HARDIRQ: 15
>> =A0 =A0 =A0 =A0 LOCK_USED_IN_HARDIRQ_READ: 0
>> =A0 =A0 =A0 =A0 LOCK_ENABLED_HARDIRQ: 543
>> =A0 =A0 =A0 =A0 LOCK_ENABLED_HARDIRQ_READ: 28
>> =A0 =A0 =A0 =A0 LOCK_USED_IN_SOFTIRQ: 0
>> =A0 =A0 =A0 =A0 LOCK_USED_IN_SOFTIRQ_READ: 0
>> =A0 =A0 =A0 =A0 LOCK_ENABLED_SOFTIRQ: 543
>> =A0 =A0 =A0 =A0 LOCK_ENABLED_SOFTIRQ_READ: 28
>> =A0 =A0 =A0 =A0 LOCK_USED_IN_RECLAIM_FS: 5
>> =A0 =A0 =A0 =A0 LOCK_USED_IN_RECLAIM_FS_READ: 0
>> =A0 =A0 =A0 =A0 LOCK_ENABLED_RECLAIM_FS: 95
>> =A0 =A0 =A0 =A0 LOCK_ENABLED_RECLAIM_FS_READ: 8
>> =A0 =A0 =A0 =A0 LOCK_USED: 871
>
> 8752+871+8+95+5+28+543+28+543+15=3D10888
>
> So you get a stack-trace for each direct-dependency, and you get a
> stack-trace for each LOCK_state, the sum seems to match the total
> invocations.
>
> Non of these numbers look strange..
>

As I told Peter privately the laptop that triggered the
MAX_STACK_TRACE_ENTRIES every time, has met an
unfortunate early demise. However, I think it was the config - not the
hardware. On this machine where the above
numbers come from, I believe I have less debug options configured -
but it is running the exact same kernel as
the laptop was. (2.6.33.2-rt13)
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
