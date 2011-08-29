From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [ANNOUNCE] 3.0.1-rt11
Date: Mon, 29 Aug 2011 12:57:21 -0700
Message-ID: <4E5BEF21.6040908@am.sony.com>
References: <1313232790.25267.7.camel@twins> <4E559039.8060209@am.sony.com> <20110826235507.GJ2342@linux.vnet.ibm.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <efault@gmx.de>
To: "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]:8871
	"EHLO AM1EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754896Ab1H2T5t (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Aug 2011 15:57:49 -0400
In-Reply-To: <20110826235507.GJ2342@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/26/11 16:55, Paul E. McKenney wrote:
> On Wed, Aug 24, 2011 at 04:58:49PM -0700, Frank Rowand wrote:
>> On 08/13/11 03:53, Peter Zijlstra wrote:
>>>
>>> Whee, I can skip release announcements too!
>>>
>>> So no the subject ain't no mistake its not, 3.0.1-rt11 is there for the
>>> grabs.
>>>
>>> Changes include (including the missing -rt10):
>>>
>>>   - hrtimer fix that should make RT_GROUP work again
>>>   - RCU fixes that should make the RCU stalls go away
>>>   - fixes SMP=n builds after breaking them in -rt9
>>
>> I have a consistent (every boot) hang on boot.  With a few
>> hacks to get console output, I get the
>>
>>   rcu_preempt_state detected stalls on CPUs/tasks
>>
>> messages in the attached console log.

< snip >

> 
> Hmmm...  The last few that I have seen that looked like this were
> due to my messing up rcutorture so that the RCU-boost testing kthreads
> ran CPU-bound at real-time priority.
> 
> Is it possible that something similar is happening on your system?
> 
>                                                         Thanx, Paul

I don't think so.  That would require CONFIG_RCU_TORTURE_TEST, correct?
And that is not set:

< way big snip >

>> # CONFIG_RCU_TORTURE_TEST is not set
>> CONFIG_RCU_CPU_STALL_TIMEOUT=60
>> CONFIG_RCU_CPU_STALL_VERBOSE=y

I'm finally getting back to this today, so I'm starting to learn about
the RCU stall detector, so maybe I can make some more sense of this.

-Frank

