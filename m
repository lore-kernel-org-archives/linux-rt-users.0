From: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>
Subject: Re: Query regarding 2.6.335 RT and Non-RT performance
Date: Mon, 23 Aug 2010 19:56:32 +0530
Message-ID: <4C728518.3030906@linux.vnet.ibm.com>
References: <AANLkTik4U-ua1zi5r5n4uw8oA-cQOO0zev__OuCto7CP@mail.gmail.com> <AANLkTimbQh3rTKnK5cri10_wLJ8BJfUnf54iZ1ENLyuN@mail.gmail.com> <4C6AC4A6.4080407@redhat.com> <AANLkTikM5sMtOmu959EZkXUxr=zX8L2HwK52L5JjAK59@mail.gmail.com> <4C6AE6D7.2060006@us.ibm.com> <AANLkTimzwSq_8A6vQftOUptpSkhY5nbc37ihx=r=Ff33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nivedita Singhvi <niv@us.ibm.com>,
	David Sommerseth <davids@redhat.com>,
	linux-rt-users@vger.kernel.org
To: Manikandan Ramachandran <crmanik@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:34394 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480Ab0HWO0l (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Aug 2010 10:26:41 -0400
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp09.au.ibm.com (8.14.4/8.13.1) with ESMTP id o7NEQeEs001431
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Aug 2010 00:26:40 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o7NEQdIi1523956
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Aug 2010 00:26:39 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o7NEQcHS032129
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Aug 2010 00:26:39 +1000
In-Reply-To: <AANLkTimzwSq_8A6vQftOUptpSkhY5nbc37ihx=r=Ff33@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wednesday 18 August 2010 03:52 AM, Manikandan Ramachandran wrote:
> I see a scenario where higher priority task is ready to run but lower
> priority IRQ thread is hogging the cpu. Please see the timeline log
> below:
>
>    
Can you try turning on RCU_CPU_STALL_DETECTION to get any trace
which might have hogged the cpu too long. Also make sure that
sirq-rcu is running at little more prio than your high prio task.

Thanks,
Gowri
> GIVE ffff0c1c [Comment: High priority IRQ thread wakes up high
> priority process at jiffy 0xffff0c1c]
> **ffff0c21**##ffff0c21##**ffff0c21**##ffff0c21##**ffff0c21**##ffff0c21##**ffff0c21**##ffff0c21##**ffff0c21**##ffff0c22##**ffff0c22**##ffff0c22##**ffff0c22**##ffff0c22##**ffff0c22**##ffff0c22##**ffff0c22**##ffff0c22##**ffff0c22**##ffff0c22##**ffff0c22**##ffff0c22##**ffff0c22**##ffff0c22##**ffff0c23**##ffff0c23##**ffff0c23**##ffff0c23##**ffff0c23**##ffff0c24##**ffff0c24**##ffff0c24##**ffff0c24**##ffff0c24##
> [Comment: Low priority IDE[ide_intr] handler hogs CPU for almost 3 ms]
> GOTffff0c26 [Comment: High priority task wakes up after 10 ms!!]
>
> I fail to understand why scheduler failed to schedule high priority
> task 10 times in a row. FYI, I have put IDE thread to SCHED_NORMAL
> while high priority thread and task to SCHED_FIFO.
>
>    

