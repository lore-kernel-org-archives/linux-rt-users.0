From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: Query regarding 2.6.335 RT and Non-RT performance
Date: Thu, 19 Aug 2010 07:59:19 -0700
Message-ID: <4C6D46C7.5020209@us.ibm.com>
References: <AANLkTik4U-ua1zi5r5n4uw8oA-cQOO0zev__OuCto7CP@mail.gmail.com> <AANLkTimbQh3rTKnK5cri10_wLJ8BJfUnf54iZ1ENLyuN@mail.gmail.com> <4C6AC4A6.4080407@redhat.com> <AANLkTikM5sMtOmu959EZkXUxr=zX8L2HwK52L5JjAK59@mail.gmail.com> <4C6AE6D7.2060006@us.ibm.com> <AANLkTimzwSq_8A6vQftOUptpSkhY5nbc37ihx=r=Ff33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Sommerseth <davids@redhat.com>,
	linux-rt-users@vger.kernel.org
To: Manikandan Ramachandran <crmanik@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:38288 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753640Ab0HSO7X (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Aug 2010 10:59:23 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o7JErIWn026048
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Aug 2010 10:53:18 -0400
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o7JExMlW471654
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Aug 2010 10:59:22 -0400
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o7JExLYO026991
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Aug 2010 08:59:22 -0600
In-Reply-To: <AANLkTimzwSq_8A6vQftOUptpSkhY5nbc37ihx=r=Ff33@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/17/2010 03:22 PM, Manikandan Ramachandran wrote:


> I see a scenario where higher priority task is ready to run but lower
> priority IRQ thread is hogging the cpu. Please see the timeline log
> below:
>
> GIVE ffff0c1c [Comment: High priority IRQ thread wakes up high
> priority process at jiffy 0xffff0c1c]
> **ffff0c21**##ffff0c21##**ffff0c21**##ffff0c21##**ffff0c21**##ffff0c21##**ffff0c21**##ffff0c21##**ffff0c21**##ffff0c22##**ffff0c22**##ffff0c22##**ffff0c22**##ffff0c22##**ffff0c22**##ffff0c22##**ffff0c22**##ffff0c22##**ffff0c22**##ffff0c22##**ffff0c22**##ffff0c22##**ffff0c22**##ffff0c22##**ffff0c23**##ffff0c23##**ffff0c23**##ffff0c23##**ffff0c23**##ffff0c24##**ffff0c24**##ffff0c24##**ffff0c24**##ffff0c24##
> [Comment: Low priority IDE[ide_intr] handler hogs CPU for almost 3 ms]
> GOTffff0c26 [Comment: High priority task wakes up after 10 ms!!]
>
> I fail to understand why scheduler failed to schedule high priority
> task 10 times in a row. FYI, I have put IDE thread to SCHED_NORMAL
> while high priority thread and task to SCHED_FIFO.

Not really sure from the above what's going on, what priorities
you are running at, etc.

You might want look at the output of "ps -eLo pid,rtprio,policy,comm"
to see if you can confirm your scheduler attributes.

thanks,
Nivedita
