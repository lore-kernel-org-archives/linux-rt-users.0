From: Josh Cartwright <josh.cartwright@ni.com>
Subject: Re: spike in latency when calling popen() in the same process that
 runs a high priority RT thread
Date: Thu, 30 May 2013 13:02:43 -0500
Message-ID: <20130530180243.GM16790@beefymiracle.amer.corp.natinst.com>
References: <OF23979777.B356D29C-ON86257B75.0059025F-86257B75.00593F88@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Gratian Crisan <gratian.crisan@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailserver5.natinst.com ([130.164.80.5]:35715 "EHLO
	spamkiller05.natinst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756226Ab3E3SBc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 May 2013 14:01:32 -0400
Received: from mailserv59-us.natinst.com (nb-chan1-1338.natinst.com [130.164.19.134])
	by spamkiller05.natinst.com (8.14.5/8.14.5) with ESMTP id r4UI1VEk000329
	for <linux-rt-users@vger.kernel.org>; Thu, 30 May 2013 13:01:31 -0500
In-Reply-To: <OF23979777.B356D29C-ON86257B75.0059025F-86257B75.00593F88@ni.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, May 24, 2013 at 11:14:49AM -0500, Gratian Crisan wrote:
> We are seeing a fairly big spike in latency for an RT thread when
> another regular thread in the same process calls popen().  I have
> modified cyclictest (see the patch below) to spawn another thread that
> just does popen() in a loop and run cyclictest with the following
> options:
>
> ./cyclictest -m -S --policy=fifo -p 98
>
> Normally the max latency on our system is ~50uS. This is a dual core
> ARM Cortex-A9 running a 3.2.35-rt52 kernel. With this change it spikes
> over 500uS.
> This doesn't happen if the popen() test is run in a separate process
>
> We are looking for ideas on the root cause for this.

We've continued investigations here.

The following sequence is what happens when we see large latencies:

  RT thread:                   fork thread:
  sys_clock_nanosleep()
  ...
                               sys_fork()
                                dup_mm()
                                 dup_mmap()
                                  down_write(&oldmm->mmap_sem)
                                   for each vma, for each valid mapping:
                                    if (is_cow_mapping)
                                     mark pte wrprotect
  ...
  *woken*
  do_page_fault()
   down_read(&mm->mmap_sem)
    block. (boost fork thread prio)

COW mappings in the parent process are marked write-protect during the
fork().  In the unfortunate event that the RT thread wakes up and writes
to any region which is COWable while the page tables are still being
copied into the new process, it faults and then gets blocked on mmap_sem.

The time the RT thread spends sleeping on mmap_sem is proportional to
the number of existing page table mappings for the process.  If that
process makes use of mlockall() (say, cyclictest with -m), then many
valid mappings exist, so the copying can take a while.  Running without
mlockall() still shows the above condition being hit, but the impact is
quite a bit smaller due to there being fewer mappings at the time of
fork().

The solution we've gone with is to audit our codebase and remove any
usages of fork() from any code executing in the same process as our RT
threads.  In nearly all cases, vfork()/exec() has been a suitable
alternative that doesn't affect the high priority thread.

Would it be worth it for us to add a blurb about this on the RT wiki?

  Josh
