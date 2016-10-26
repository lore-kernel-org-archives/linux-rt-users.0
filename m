From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Subject: RE: [ANNOUNCE] 3.18.43-rt46
Date: Wed, 26 Oct 2016 10:37:01 +0000
Message-ID: <7e3ad2f2475b41979a77419a8d99b6c0@FE-MBX1012.de.bosch.com>
References: <20161020164801.0bbea1a8@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:53455 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbcJZKhE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Oct 2016 06:37:04 -0400
In-Reply-To: <20161020164801.0bbea1a8@gandalf.local.home>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steven,

> Or to build 3.18.43-rt46 directly, the following patches should be applied:
> 
>   http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz
>   http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.43.xz
>   http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.43-rt46.patch.xz
I am using the patches as proposed.

However with this version I get lots of compiler warnings:

./arch/x86/include/asm/preempt.h:118:6: warning: 'tmp' may be used uninitialized in this function [-Wmaybe-uninitialized]
  tmp &= ~PREEMPT_NEED_RESCHED;
         ^
./arch/x86/include/asm/preempt.h:112:6: note: 'tmp' was declared here
  u32 tmp;
        ^

The relevant code is the following:

/*
 * Returns true when we need to resched and can (barring IRQ state).
 */
static __always_inline bool should_resched(void)
{
#ifdef CONFIG_PREEMPT_LAZY
	u32 tmp;

	if (!raw_cpu_read_4(__preempt_count))
		return true;

	/* preempt count == 0 ? */
	tmp &= ~PREEMPT_NEED_RESCHED;
	if (tmp)
		return false;
	if (current_thread_info()->preempt_lazy_count)
		return false;
	return test_thread_flag(TIF_NEED_RESCHED_LAZY);
#else
	return unlikely(!raw_cpu_read_4(__preempt_count));
#endif
}

And within this code tmp is actually not initialized, the warning is fine.
This code is new with the patch-3.18.43-rt46.patch.xz.
With the previous patch-3.18.42-rt44.patch.xz the code of should_resched
was differently (much more compact) and did not show the warnings.

Regards

Mathias

