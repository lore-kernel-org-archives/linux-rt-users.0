From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Threaded IPIs?
Date: Thu, 26 Jul 2007 19:33:11 -0400
Message-ID: <46A8F6F70200005A000283D4@mcclure.wal.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <kvm-devel@lists.sourceforge.net>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mcclure-nat.wal.novell.com ([130.57.22.22]:31846 "EHLO
	mcclure.wal.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756138AbXGZXdW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Jul 2007 19:33:22 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi guys,
  While working with the -rt kernel, I have noticed a problem in KVM.
Specifically, when you stop a VM you sometimes get a "sleep while
atomic" oopses.  It turns out that the issue is related to an
smp_function_call IPI that KVM does to remotely flush the VMX hardware
on shutdown.  The code tries to acquire the global kvm_lock (which is a
normal spinlock_t, of course converted to rt_mutex on -rt) from the
interrupt context of the IPI handler.  You know the rest of the
story....

The obvious solution is to convert the kvm_lock to a raw_spinlock_t.
However, I really don't want to do this unless we absolutely have to
since it will just increase latencies for a good portion of the rest of
KVM.

There are probably quite a few solutions here which don't involve the
"big hammer" conversion to raw_spinlocks.  One of them I was kicking
around was "what if FUNCTION_CALL IPIs (FC-IPI) could be generally
threaded just like hard/soft IRQs"?  This brings up some questions:

a) Will KVM function properly if we did this (I believe so)?

b) Would this be a good way to solve the problem (perhaps, but more
simple solutions probably exist)? 

c) Would this be useful to other subsystems besides KVM (I have no idea
what else is low-level enough to use FC-IPI)?

Help me to brainstorm on this threaded-IPI idea for a minute.  Assuming
this idea has merit, here are some of the ground-rules I was considering
for this feature:

1) By default, general IPIs will continue to act like NODELAY IRQs (e.g.
execute in interrupt context).  This means things like RESCHEDULE, et.
al. will continue to function as they do today.

2) By default, FC-IPIs would be threaded if hardirqs are threaded.

3) An option in the call parameter could specify if NODELAY-like
behavior is desired for subsystems that care to limit the deferment.
This would cause the FC-IPI to override the deferment mechanism and
execute directly in interrupt context on a per-call basis.

4) On systems where hardirqs are not threaded, the DEFER/NODELAY flag is
ignored and FC-IPIs resume their current behavior.

There would be some remaining challenges to resolve too, such as:

A) Normal deferment mechanism have threads that naturally affine to any
arbitrary processor that is free based on the scheduler policy, whereas
FC-IPIs usually affine to a specific processor (as is the case with
KVM).  Is there a way today to affine a deferred work item (e.g.
work-queues, tasklets, etc) to a specific CPU?  If not, we would have to
create one.

I guess I cannot think of any others at the moment, but (A) is big
enough to chew on for now ;)

Comments?

Regards,
-Greg
