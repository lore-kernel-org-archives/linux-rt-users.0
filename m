From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched: don't clear PF_THREAD_BOUND in
 select_fallback_rq
Date: Fri, 7 Jun 2013 22:59:17 +0200
Message-ID: <20130607205917.GA3395@linutronix.de>
References: <5178F0DE.8030808@huawei.com>
 <20130607205048.GA22550@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Li Zefan <lizefan@huawei.com>,
	zhangwei <jovi.zhangwei@huawei.com>, bitbucket@online.de
To: Qiang Huang <h.huangqiang@huawei.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48608 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab3FGU7S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Jun 2013 16:59:18 -0400
Content-Disposition: inline
In-Reply-To: <20130607205048.GA22550@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Sebastian Andrzej Siewior | 2013-06-07 22:50:48 [+0200]:

>* Qiang Huang | 2013-04-25 17:01:18 [+0800]:
>
>>select_fallback_rq() is called and PF_THREAD_BOUND is cleared. In my
>>box, 1/3 bounded kernel threads will clear that flag after boot.
>
>Please tell me _which_ threads lose this flag. I don't see this=E2=80=A6

The only way I lose this flag is by starting a workqueue on a CPU which
if offline. Now that is wrong. I am not sure if the workqueue re-uses
the "idle" workers later. In the up path it sets the CPU mask and
PF_THREAD_BOUND is usually set (unless it was lost due to
select_fallback_rq()). So we can set this back on:

Subject: [PATCH] kernel/workqueue: Add PF_THREAD_BOUND after set_cpu

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/workqueue.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 11285e4..aff5841 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1637,8 +1637,10 @@ __acquires(&gcwq->lock)
 		 * it races with cpu hotunplug operation.  Verify
 		 * against GCWQ_DISASSOCIATED.
 		 */
-		if (!(gcwq->flags & GCWQ_DISASSOCIATED))
+		if (!(gcwq->flags & GCWQ_DISASSOCIATED)) {
 			set_cpus_allowed_ptr(task, get_cpu_mask(gcwq->cpu));
+			task->flags |=3D PF_THREAD_BOUND;
+		}
=20
 		spin_lock_irq(&gcwq->lock);
 		if (gcwq->flags & GCWQ_DISASSOCIATED)
--=20
1.7.10.4

Do you see any other?

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
