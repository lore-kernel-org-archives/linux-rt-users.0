From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] duplicate zap_rt_locks in preempt-realtime-core.patch
Date: Wed, 10 Sep 2008 23:40:47 -0400
Message-ID: <20080911034045.GA5729@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [128.224.252.2] ([128.224.252.2]:38556 "EHLO
	yow-pgortmak-d1.corp.ad.wrs.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752446AbYIKDks (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Sep 2008 23:40:48 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steven,

It looks like patch was over-eager and gave you two copies of
zap_rt_locks() within preempt-realtime-core.patch  -- I've increased
the context so you can see the dup without going to compare against
the original.

Thanks,
Paul.

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 1f90d41..0931614 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -222,18 +222,12 @@ extern void __attribute__((format(printf, 1, 2)))
 #ifdef CONFIG_PREEMPT_RT
 extern void zap_rt_locks(void);
 #else
 # define zap_rt_locks() do { } while (0)
 #endif
 
-#ifdef CONFIG_PREEMPT_RT
-extern void zap_rt_locks(void);
-#else
-# define zap_rt_locks() do { } while (0)
-#endif
