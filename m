From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/7] printk: Fix rq->lock vs logbuf_lock unlock lock inversion
Date: Mon, 18 Feb 2013 22:53:42 -0500
Message-ID: <20130219035410.384095545@goodmis.org>
References: <20130219035339.428477998@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, ybu <ybu@qti.qualcomm.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	<stable@vger.kernel.org>, <stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-printk-Fix-rq-lock-vs-logbuf_lock-unlock-lock-invers.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: "Bu, Yitian" <ybu@qti.qualcomm.com>

commit 07354eb1a74d1 ("locking printk: Annotate logbuf_lock as raw")
reintroduced a lock inversion problem which was fixed in commit
0b5e1c5255 ("printk: Release console_sem after logbuf_lock"). This
happened probably when fixing up patch rejects.

Restore the ordering and unlock logbuf_lock before releasing
console_sem.

Signed-off-by: ybu <ybu@qti.qualcomm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: stable@vger.kernel.org
Cc: stable-rt@vger.kernel.org
Link: http://lkml.kernel.org/r/E807E903FE6CBE4D95E420FBFCC273B827413C@nasanexd01h.na.qualcomm.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/printk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk.c b/kernel/printk.c
index 7109711..56d7497 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -868,9 +868,9 @@ static int console_trylock_for_printk(unsigned int cpu, unsigned long flags)
 		}
 	}
 	printk_cpu = UINT_MAX;
+	raw_spin_unlock(&logbuf_lock);
 	if (wake)
 		up(&console_sem);
-	raw_spin_unlock(&logbuf_lock);
 	return retval;
 }
 static const char recursion_bug_msg [] =
-- 
1.7.10.4
