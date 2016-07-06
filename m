From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH][RT] x86: Fix an RT MCE crash
Date: Wed, 6 Jul 2016 15:43:51 +0200
Message-ID: <4eb7ab5c-447e-addc-be99-ce4b4682e4bb@linutronix.de>
References: <20160630170134.GA3932@pd.tnic> <57755449.7070302@acm.org>
 <20160630172611.GC3932@pd.tnic> <57755CC6.60506@acm.org>
 <20160630182257.GD3932@pd.tnic> <577576AA.8040004@mvista.com>
 <20160630203457.GF3932@pd.tnic> <5775A181.2050404@acm.org>
 <20160701072050.GA4593@pd.tnic> <577C580F.8010004@acm.org>
 <20160706083704.GA7300@pd.tnic> <577CF39F.5010400@mvista.com>
 <20160706093256.29406f9b@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Borislav Petkov <bp@alien8.de>, Corey Minyard <minyard@acm.org>,
	"Luck, Tony" <tony.luck@intel.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Corey Minyard <cminyard@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40012 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754246AbcGFNn4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Jul 2016 09:43:56 -0400
In-Reply-To: <20160706093256.29406f9b@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/06/2016 03:32 PM, Steven Rostedt wrote:
> On Wed, 6 Jul 2016 07:03:43 -0500
> Corey Minyard <cminyard@mvista.com> wrote:
> 
>>> ---
>>> diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
>>> index aaf4b9b94f38..cc70d98a30f6 100644
>>> --- a/arch/x86/kernel/cpu/mcheck/mce.c
>>> +++ b/arch/x86/kernel/cpu/mcheck/mce.c
>>> @@ -1391,7 +1391,8 @@ static int mce_notify_work_init(void)
>>>   
>>>   static void mce_notify_work(void)
>>>   {
>>> -	wake_up_process(mce_notify_helper);
>>> +	if (mce_notify_helper)
>>> +		wake_up_process(mce_notify_helper);
>>>   }
> 
> Actually, this appears to be the fix in 4.6-rt.

This is in there since it was switched to swork instead of using its
own thread and is also in v4.1:

https://git.kernel.org/cgit/linux/kernel/git/rt/linux-rt-devel.git/tree/arch/x86/kernel/cpu/mcheck/mce.c?h=linux-4.1.y-rt#n1387

as part of x86-mce-use-swait-queue-for-mce-wakeups.patch. And this
patch was first part of v3.18.9-rt4 as a new patch dropping x86-mce-
Defer-mce-wakeups-to-threads-for-PREEMPT_RT.patch.

> -- Steve

Sebastian
