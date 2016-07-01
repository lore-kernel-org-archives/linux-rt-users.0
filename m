From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH][RT] x86: Fix an RT MCE crash
Date: Fri, 1 Jul 2016 11:20:46 +0200
Message-ID: <f96ce3fa-adca-773f-562c-dac2e75d65a9@monom.org>
References: <1467293089-27656-1-git-send-email-minyard@acm.org>
 <20160630094301.22d32ec1@gandalf.local.home> <5775316F.2020102@acm.org>
 <20160630115101.6337c395@gandalf.local.home> <20160630160128.GA4365@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Corey Minyard <minyard@acm.org>, linux-rt-users@vger.kernel.org,
	Corey Minyard <cminyard@mvista.com>,
	Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hotel311.server4you.de ([85.25.146.15]:46714 "EHLO
	hotel311.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbcGAJ04 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Jul 2016 05:26:56 -0400
In-Reply-To: <20160630160128.GA4365@pd.tnic>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/30/2016 06:01 PM, Borislav Petkov wrote:
>>>>>   #ifdef CONFIG_PREEMPT_RT_FULL
>>>>> +static bool notify_work_ready __read_mostly;
>>>>>   struct task_struct *mce_notify_helper;
>>>>>   
>>>>>   static int mce_notify_helper_thread(void *unused)
>>>>> @@ -1386,12 +1387,14 @@ static int mce_notify_work_init(void)
> 
> Hmm, what is mce_notify_work_init() ?
> 
> This must be some RT-homegrown thing.
> 
> What it is supposed to do? Upstream is much different from 3.10 or
> whatever that kernel version is.

The notify work snippet defers the execution of mce_notify_irq to a
kthread using swork (simple work, which is based on simple wait [1]).

mce_notify_irq() can't be run in IRQ context because of
wake_up_interruptible() which calls mutex_lock() eventually with
CONFIG_PREEMPT_RT_FULL.

cheers,
daniel

[1]
https://git.kernel.org/cgit/linux/kernel/git/rt/linux-rt-devel.git/tree/include/linux/swork.h?h=linux-4.6.y-rt

https://git.kernel.org/cgit/linux/kernel/git/rt/linux-rt-devel.git/tree/kernel/sched/swork.c?h=linux-4.6.y-rt
