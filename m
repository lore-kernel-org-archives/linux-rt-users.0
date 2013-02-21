From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH rt-3.6 1/3] rt: drop duplicated rt-disable-rt-group-sched.patch
Date: Thu, 21 Feb 2013 14:53:32 -0500
Message-ID: <1361476414-27352-2-git-send-email-paul.gortmaker@windriver.com>
References: <1361476414-27352-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:36855 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368Ab3BUTx5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Feb 2013 14:53:57 -0500
In-Reply-To: <1361476414-27352-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The rt-disable-rt-group-sched.patch is an accidental duplicate of the
earlier sched-disable-rt-group-sched-on-rt.patch

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 rt-disable-rt-group-sched.patch | 29 -----------------------------
 series                          |  3 ++-
 2 files changed, 2 insertions(+), 30 deletions(-)
 delete mode 100644 rt-disable-rt-group-sched.patch

diff --git a/rt-disable-rt-group-sched.patch b/rt-disable-rt-group-sched.patch
deleted file mode 100644
index 418dd9d..0000000
diff --git a/series b/series
index d45a993..24902ef 100644
--- a/series
+++ b/series
@@ -570,7 +570,8 @@ net-use-cpu-chill.patch
 lockdep-selftest-convert-spinlock-to-raw-spinlock.patch
 lockdep-selftest-only-do-hardirq-context-test-for-raw-spinlock.patch
 
-rt-disable-rt-group-sched.patch
+# dropped; duplicate of sched-disable-rt-group-sched-on-rt.patch above
+#rt-disable-rt-group-sched.patch
 fs-jbd-pull-plug-when-waiting-for-space.patch
 perf-make-swevent-hrtimer-irqsafe.patch
 cpu-rt-rework-cpu-down.patch
-- 
1.8.1.2

