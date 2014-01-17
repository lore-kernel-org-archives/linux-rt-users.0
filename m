From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH] API cleanup - use local_lock not __local_lock for soft
Date: Fri, 17 Jan 2014 20:44:03 +0100
Message-ID: <20140117194403.GC20157@opentech.at>
References: <20131229171154.GA23586@opentech.at> <20140117144729.GB5785@linutronix.de> <20140117145955.GA5637@opentech.at> <52D94891.80109@linutronix.de> <20140117153323.GA23566@opentech.at> <20140117113218.7392363d@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users@vger.kernel.org,
	Sami Pietikainen <Sami.Pietikainen@wapice.com>,
	Jouko Haapaluoma <jouko.haapaluoma@wapice.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:45852 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638AbaAQToE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 17 Jan 2014 14:44:04 -0500
Content-Disposition: inline
In-Reply-To: <20140117113218.7392363d@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


trivial API cleanup - kernel/softirq.c was mimiking local_lock. 

No change of functional behavior

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 kernel/softirq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 2da729b..15ad603 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -505,12 +505,12 @@ void __init softirq_early_init(void)
 
 static void lock_softirq(int which)
 {
-	__local_lock(&__get_cpu_var(local_softirq_locks[which]));
+	local_lock(local_softirq_locks[which]);
 }
 
 static void unlock_softirq(int which)
 {
-	__local_unlock(&__get_cpu_var(local_softirq_locks[which]));
+	local_unlock(local_softirq_locks[which]);
 }
 
 static void do_single_softirq(int which, int need_rcu_bh_qs)
-- 
1.7.2.5

