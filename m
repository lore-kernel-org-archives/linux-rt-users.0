From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 0/3] Compile fixes for disabled config opts.
Date: Mon, 29 Sep 2008 10:32:50 -0400
Message-ID: <1222698773-5920-1-git-send-email-paul.gortmaker@windriver.com>
Cc: linux-rt-users@vger.kernel.org
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:44164 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489AbYI2OdD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Sep 2008 10:33:03 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


The following patches fix some basic compile failures that appear
when you change the kernel configuration to disable various options
that would be normally enabled by most folks using the preempt_rt
patch set (26rt9).

However, it may be useful in some situations to be able to ask people
to turn off "X" and recompile to try and get better data on a certain
bug/problem, so having the ability to compile with different configs
disabled is probably worthwhile.

Within each patch, I've listed the parent patch of the broken out
series in which it would make sense to fold the fix in, should that
be what you want to do with these.  If that is what you want to do,
then feel free to toss the patch headers/SOB line from these stand
alone patches.

Thanks,
Paul.
---

0001-compat_rwsem-fix-compile-failure-for-when-PREEMPT_R.patch
 b/include/asm-x86/rwsem.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

0002-rt-bit-spinlocks-fix-compile-failure-for-CONFIG_PR.patch
 b/include/linux/bit_spinlock.h |    2 +-
 b/include/linux/spinlock.h     |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

0003-rt-sysctl-compile-fix-for-when-profiling-is-off.patch
 b/kernel/sysctl.c |    2 ++
 1 file changed, 2 insertions(+)

