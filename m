From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 3/4] workqueue: Schedule work on non-idle cpu instead of current one
Date: Tue,  6 Nov 2012 16:08:45 +0530
Message-ID: <ad25c731a6ca1bd1269555245952f05c856a9759.1352196505.git.viresh.kumar@linaro.org>
References: <cover.1352196505.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Cc: Arvind.Chauhan@arm.com, linaro-dev@lists.linaro.org,
	patches@linaro.org, pdsw-power-team@arm.com,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>
To: pjt@google.com, paul.mckenney@linaro.org, tglx@linutronix.de,
	tj@kernel.org, suresh.b.siddha@intel.com, venki@google.com,
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1352196505.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1352196505.git.viresh.kumar@linaro.org>
References: <cover.1352196505.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Workqueues queues work on current cpu, if the caller haven't passed a prefe=
rred
cpu. This may wake up an idle CPU, which is actually not required.

This work can be processed by any CPU and so we must select a non-idle CPU =
here.
This patch adds in support in workqueue framework to get preferred CPU deta=
ils
from the scheduler, instead of using current CPU.

Most of the time when a work is queued, the current cpu isn't idle and so w=
e
will choose it only. There are cases when a cpu is idle when it queues some
work. For example, consider following scenario:
- A cpu has programmed a timer and is IDLE now.
- CPU gets into interrupt handler due to timer and queues a work. As the CP=
U is
  currently IDLE, we can queue this work to some other CPU.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/workqueue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 042d221..d32efa2 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1238,7 +1238,7 @@ static void __queue_work(unsigned int cpu, struct wor=
kqueue_struct *wq,
 =09=09struct global_cwq *last_gcwq;
=20
 =09=09if (cpu =3D=3D WORK_CPU_UNBOUND)
-=09=09=09cpu =3D raw_smp_processor_id();
+=09=09=09cpu =3D sched_select_cpu(0);
=20
 =09=09/*
 =09=09 * It's multi cpu.  If @work was previously on a different
@@ -1383,7 +1383,7 @@ static void __queue_delayed_work(int cpu, struct work=
queue_struct *wq,
 =09=09if (gcwq)
 =09=09=09lcpu =3D gcwq->cpu;
 =09=09if (lcpu =3D=3D WORK_CPU_UNBOUND)
-=09=09=09lcpu =3D raw_smp_processor_id();
+=09=09=09lcpu =3D sched_select_cpu(0);
 =09} else {
 =09=09lcpu =3D WORK_CPU_UNBOUND;
 =09}
--=20
1.7.12.rc2.18.g61b472e
