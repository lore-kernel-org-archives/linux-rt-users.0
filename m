From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched: don't clear PF_THREAD_BOUND in
 select_fallback_rq
Date: Fri, 7 Jun 2013 22:50:48 +0200
Message-ID: <20130607205048.GA22550@linutronix.de>
References: <5178F0DE.8030808@huawei.com>
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
Received: from www.linutronix.de ([62.245.132.108]:48566 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757427Ab3FGUut convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Jun 2013 16:50:49 -0400
Content-Disposition: inline
In-Reply-To: <5178F0DE.8030808@huawei.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Qiang Huang | 2013-04-25 17:01:18 [+0800]:

So I looked again at this.

>This is revert of "sched-clear-pf-thread-bound-on-fallback-rq.patch"
>(commit 0d939066acdcb in v3.4-rt),.
>
>Select_fallback_rq() can be easilly called during system boot, because
>select_task_rq_fair() just return task_cpu(p) for bounded kernel threa=
ds,
>which is 0 during system boot and not in tsk_cpus_allowed, so
>select_fallback_rq() is called and PF_THREAD_BOUND is cleared. In my
>box, 1/3 bounded kernel threads will clear that flag after boot.

Please tell me _which_ threads lose this flag. I don't see this=E2=80=A6

>And it will cause problems, for example:
># for pid in `ps -e -o pid`; do taskset -p -c 0-15 $pid; done
>this command will cause system hung.

I tracked this down and I grabbed a brown paper bag=E2=80=A6
So to trigger this, it seems enough to=20
| taskset -p -c 5 2
| echo 0 > /sys/devices/system/cpu/cpu5/online

and the fix is:

Subject: [PATCH] kernel/cpu: fix cpu down problems

During forward porting I mixed up those two calls. The CPU up/down
worked usually. However a migrate_disable() in one of the notifier coul=
d
freeze the system.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/cpu.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index d44dea3..0784023 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -557,11 +557,6 @@ static int __ref _cpu_down(unsigned int cpu, int t=
asks_frozen)
 	}
=20
 	cpu_hotplug_begin();
-	err =3D cpu_unplug_begin(cpu);
-	if (err) {
-		printk("cpu_unplug_begin(%d) failed\n", cpu);
-		goto out_cancel;
-	}
=20
 	err =3D __cpu_notify(CPU_DOWN_PREPARE | mod, hcpu, -1, &nr_calls);
 	if (err) {
@@ -569,8 +564,16 @@ static int __ref _cpu_down(unsigned int cpu, int t=
asks_frozen)
 		__cpu_notify(CPU_DOWN_FAILED | mod, hcpu, nr_calls, NULL);
 		printk("%s: attempt to take down CPU %u failed\n",
 				__func__, cpu);
+		goto out_cancel;
+	}
+
+	err =3D cpu_unplug_begin(cpu);
+	if (err) {
+		printk("cpu_unplug_begin(%d) failed\n", cpu);
+		__cpu_notify(CPU_DOWN_FAILED | mod, hcpu, nr_calls, NULL);
 		goto out_release;
 	}
+
 	smpboot_park_threads(cpu);
=20
 	/* Notifiers are done. Don't let any more tasks pin this CPU. */
--=20
1.7.10.4

Does this fix your problems.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
