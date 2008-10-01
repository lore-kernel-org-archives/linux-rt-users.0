From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: RT points of interest associated with 2.6.27-rcN
Date: Wed, 1 Oct 2008 09:23:21 -0400
Message-ID: <20081001132319.GA4531@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rostedt@goodmis.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [128.224.252.2] ([128.224.252.2]:31822 "EHLO
	yow-pgortmak-d1.corp.ad.wrs.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752681AbYJANXX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Oct 2008 09:23:23 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


I didn't get a chance to cover any random technical items, discussion
points, or my to do list in the previous e-mail where I gave a heads
up to folks that the 1st cut of the patches for 2.6.27 existed.  So here
are some of the things I encountered when carrying things forward:


-2.6.21-rc6-lockless6-speculative-get-page.patch essentially got merged
 upstream as commit e286781, but they differ in that e286781 used
 an optimization of setting page_count to zero instead of introducing
 the PG_nonewrefs bit.  Since the PG_nonewrefs bit is used in other
 patches within the series, and since it wasn't clear to me how or
 whether the optimization using page_count would be valid in RT
 context, I left the PG_nonewrefs bit in the patches (actually in
 lock_page_ref.patch) for now.  I'll have to read the code more before
 I'll be 100% confident I understand what the right approach is here.

-the rt-list-mods.patch was partly merged upstream via commit 7d283aee,
 with the exception of the one-line lib/lock_list.c change and the
 splice2 operations; I've retained those additional chunks in this
 patch file.

-ftrace tip merge/update; when I started working with 26rt6, there was
 still considerable work being done for ftrace upstream; hence I set the
 ftrace-upstream.patch aside, rather than carry it through the rc1..rc8
 series and end up dropping already applied bits all along the way.
 Now things are at rc8, I need to go back now and see what parts of
 ftrace-upstream.patch are present and what needs to be added in.

-preempt-realtime-i386.patch used to roll back FIRST_SYSTEM_VECTOR from
 0xef -> 0xee, but commit 305b92a2 seems to give this a dynamic "rewind"
 capability vs. a hard compile time default, so I believe we don't
 need the 0xef -> 0xee anymore.

-preempt-realtime-x86_64.patch seems to orphan the io_apic_sync()
 function.  If it truly has no users, we could consider removing it
 as part of this patch.

-the schedule_on_each_cpu-enhance.patch seems to essentially be reverting
 the commit 8de6d30 where they replace set_bit+queue_work with
 schedule_work_on() -- need to go back and look again to confirm/deny.

-the no-warning-for-irqs-disabled-in-local-bh-enable.patch gets broken
 by commit 0f476b6d, and the comments in that commit seem to indicate
 that this can't happen anymore -- but I'm not sure those comments are
 valid in RT context.  I'll keep this in mind when doing more testing.

-the spinlock.h code in 27rcX is using typecheck() in spinlock.h, in
 the places where the RT patches were doing the same within the macro
 BUILD_CHECK_IRQ_FLAGS(); so I left it using the upstream, rather than
 re-introducing the BUILD_CHECK_IRQ_FLAGS() macro.

-commit 0d71d10a breaks the example /dev/rmem driver that was patched in
 for doing the JVM conformance test by getting rid of the nopfn capability.
 The fix/update wasn't immediately obvious to me, so I set it aside for
 the moment, given that it doesn't appear to be key to the core functionality
 of the patch set in general.

-commit db70089 adds flush_work(), which knows nothing about PI workqueues,
 and the adaptation of barriers.  I added rt-wq-flush_work.patch on the end
 of the series, rather than contaminate existing patches with my changes, but
 once a fix is agreed on, it would go in rt-workqeue-prio.patch after review.

-PF_HARDIRQ and PF_SOFTIRQ; the number of vacant slots is dwindling, e.g.
 PF_THREAD_BOUND bumped one of the above; it would be good if we could
 claim spots for these upstream before there are no spots left.

-drivers/base/class.c goes after __mutex_init() instead of mutex_init()
 which in RT-land, isn't what it used to be; I want to look at this further
 and determine why it didn't use mutex_init() to begin with.

-testing on non-x86;  I've booted x86 but didn't have access to real non-x86
 hardware last week on account of being away, so I've only verified that it
 would cross compile for powerpc.  I'd like to test the waters with an
 ARM and a powerpc at least sometime this week.

-wider driver testing; The config I tested on the old P4 box had a minimal
 .config file.  For example, I did notice that IRQ handler of the ehci (USB)
 driver was doing something non-RT compatible, and I expect there to be 
 several other drivers also needing attention.

So that is about it.  I'll keep folks posted on patch updates and anything
else I trip over that I think is of general interest.

Paul.
