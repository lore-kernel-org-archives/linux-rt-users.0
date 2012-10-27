From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: [ANNOUNCE] 3.6.2-rt4
Date: Fri, 26 Oct 2012 17:17:02 -0700
Message-ID: <21FCFA85-855E-4FD0-A903-8340AEAA46CB@thebigcorporation.com>
References: <op.wms2phwb6426ze@millennium.getinternet.no> <508B06B2.6050605@windriver.com> <op.wms4jjf96426ze@localhost.localdomain>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: Uwaysi Bin Kareem <uwaysi.bin.kareem@paradoxuncreated.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58021 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966897Ab2J0ARG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Oct 2012 20:17:06 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3095938pbb.19
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Oct 2012 17:17:05 -0700 (PDT)
In-Reply-To: <op.wms4jjf96426ze@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Oct 26, 2012, at 3:24 PM, Uwaysi Bin Kareem <uwaysi.bin.kareem@paradoxuncreated.com> wrote:

> On Fri, 26 Oct 2012 23:54:58 +0200, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> 
>> On 12-10-26 05:45 PM, Uwaysi Bin Kareem wrote:
>>> Hiya, got a bit busy.
>>> 
>>> http://paradoxuncreated.com/tmp/_config3_6_2local
>> 
>> Which has:
>> 
>> CONFIG_SCHED_MC=y
>> # CONFIG_IRQ_TIME_ACCOUNTING is not set
>> # CONFIG_PREEMPT_NONE is not set
>> # CONFIG_PREEMPT_VOLUNTARY is not set
>> CONFIG_PREEMPT=y
>> CONFIG_PREEMPT_COUNT=y
>> CONFIG_X86_LOCAL_APIC=y
>> 
>> ...which means that this config file isn't even from
>> a preempt-rt build.  If it was it would have something
>> like the below.
>> 
>> CONFIG_SCHED_MC=y
>> # CONFIG_IRQ_TIME_ACCOUNTING is not set
>> CONFIG_PREEMPT=y
>> CONFIG_PREEMPT_RT_BASE=y
>> # CONFIG_PREEMPT_NONE is not set
>> # CONFIG_PREEMPT_VOLUNTARY is not set
>> # CONFIG_PREEMPT__LL is not set
>> # CONFIG_PREEMPT_RTB is not set
>> CONFIG_PREEMPT_RT_FULL=y
>> CONFIG_PREEMPT_COUNT=y
>> CONFIG_X86_LOCAL_APIC=y
>> 
>> Paul.
>> --
>> 
>>> 
>>> gcc version is the current ubuntu 12.04 one.
>>> 
>>> Peace Be With You.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> 
> 
> Here is my rt one actually, which really is the same.

Not really the same.

When I diff the 2 files, I get about 6,000 lines of diff.

There are oodles and oodles of differences all over the place. 
Entire subsystems are not enabled in the RT version.

Put the working (non-rt) config file into the fully patched RT tree.

Then run make oldconfig, and you should only get a few prompts pertaining to RT and debug options.

Answer those appropriately and then you should end up with a config matching the original config (but not the same)

Sven