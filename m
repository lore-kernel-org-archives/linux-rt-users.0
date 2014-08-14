From: Anders Roxell <anders.roxell@linaro.org>
Subject: Merge conflict when forward porting v3.14.12-rt9 onto v3.14.17
Date: Fri, 15 Aug 2014 01:52:33 +0200
Message-ID: <20140814235233.GA21825@8470w>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: grant.likely@linaro.org, mike.holmes@linaro.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:65452 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446AbaHNXwj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Aug 2014 19:52:39 -0400
Received: by mail-la0-f54.google.com with SMTP id hz20so1796273lab.13
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Aug 2014 16:52:37 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I have forward ported v3.14.12-rt9 to v3.14.17 and I got some merge conflicts.
The merge conflicts occured already on v3.14.14.

I maintain a git tree (to support the Linaro stable kernel RT tree) at [1]
meant to integrate the RT development patchset onto the mainline stable
kernel releases (one branch for each major stable kernel release), and
later integrate minor mainline releases into the branches, such that the
branches themselves are purely fast-forward.

Cheers,
Anders

[1] https://git.linaro.org/people/anders.roxell/linux-rt.git

diff --cc kernel/Kconfig.locks
index 8bb92eb,ecee67a..b867a1c
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@@ -220,6 -220,9 +220,9 @@@ config INLINE_WRITE_UNLOCK_IRQRESTOR
  
  endif
  
+ config ARCH_SUPPORTS_ATOMIC_RMW
+       bool
+ 
  config MUTEX_SPIN_ON_OWNER
        def_bool y
-       depends on SMP && !DEBUG_MUTEXES && !PREEMPT_RT_FULL
 -      depends on SMP && !DEBUG_MUTEXES && ARCH_SUPPORTS_ATOMIC_RMW
++      depends on SMP && !DEBUG_MUTEXES && ARCH_SUPPORTS_ATOMIC_RMW && !PREEMPT_RT_FULL
diff --cc kernel/trace/trace.c
index 841eaf84,7e259b2..c3bedc2
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@@ -462,8 -468,8 +468,8 @@@ int __trace_puts(unsigned long ip, cons
  
        local_save_flags(irq_flags);
        buffer = global_trace.trace_buffer.buffer;
 -      event = trace_buffer_lock_reserve(buffer, TRACE_PRINT, alloc, 
 +      event = trace_buffer_lock_reserve(buffer, TRACE_PRINT, alloc,
-                                         irq_flags, preempt_count());
+                                         irq_flags, pc);
        if (!event)
                return 0;

-- 
Anders Roxell
anders.roxell@linaro.org
M: +46 709 71 42 85 | IRC: roxell
