From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: [PATCH][RT] lock.h: fix spelling of contended
Date: Tue, 09 Dec 2008 22:35:20 -0800
Message-ID: <1228890920.9542.2.camel@dd>
References: <alpine.DEB.1.10.0812090946210.16798@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Gregory Haskins <ghaskins@novell.com>,
	Darren Hart <dvhltc@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:39459 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbYLJGf3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Dec 2008 01:35:29 -0500
Received: by wf-out-1314.google.com with SMTP id 27so23976wfd.4
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Dec 2008 22:35:29 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.0812090946210.16798@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Maybe it'll save you a half second...

Signed-off-by: Sven-Thorsten Dietrich <sven@thebigcorporation.com>

diff --git a/include/linux/lock.h b/include/linux/lock.h
index e0d10d6..785bf7d 100644
--- a/include/linux/lock.h
+++ b/include/linux/lock.h
@@ -11,7 +11,7 @@
 #define DEFINE_LOCK(l)				DEFINE_SPINLOCK(l)
 #define lock_init(l)				spin_lock_init(l)
 #define lock_is_locked(l)			spin_is_locked(l)
-#define lock_is_contended(l)			spin_is_conteted(l)
+#define lock_is_contended(l)			spin_is_contended(l)
 #define lock_can_lock(l)			spin_can_lock(l)
 #define assert_lock_locked(l)			assert_spin_locked(l)
 


