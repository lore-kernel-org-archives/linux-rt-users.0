From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V2 Resend 2/4] timer: hrtimer: Don't check idle_cpu() before
	calling get_nohz_timer_target()
Date: Tue,  6 Nov 2012 16:08:44 +0530
Message-ID: <5caa3dab5feb7cc3d78b4f9a19dbb24401796b53.1352196505.git.viresh.kumar@linaro.org>
References: <cover.1352196505.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pdsw-power-team-5wv7dgnIgG8@public.gmane.org
To: pjt-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, paul.mckenney-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org,
	tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, venki-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org,
	mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <cover.1352196505.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1352196505.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1352196505.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

Check for current cpu's idleness already done in implementation of
sched_select_cpu() which is called by get_nohz_timer_target(). So, no need to
call idle_cpu() twice, once from sched_select_cpu() and once from timer and
hrtimer before calling get_nohz_timer_target().

This patch removes calls to idle_cpu() from timer and hrtimer.

This also reduces an extra call to smp_processor_id() when
get_nohz_timer_target() is called.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 kernel/hrtimer.c | 2 +-
 kernel/timer.c   | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index 6db7a5e..74bdaf6 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -159,7 +159,7 @@ struct hrtimer_clock_base *lock_hrtimer_base(const struct hrtimer *timer,
 static int hrtimer_get_target(int this_cpu, int pinned)
 {
 #ifdef CONFIG_NO_HZ
-	if (!pinned && get_sysctl_timer_migration() && idle_cpu(this_cpu))
+	if (!pinned && get_sysctl_timer_migration())
 		return get_nohz_timer_target();
 #endif
 	return this_cpu;
diff --git a/kernel/timer.c b/kernel/timer.c
index 367d008..1170ece 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -735,11 +735,13 @@ __mod_timer(struct timer_list *timer, unsigned long expires,
 
 	debug_activate(timer, expires);
 
-	cpu = smp_processor_id();
-
 #if defined(CONFIG_NO_HZ) && defined(CONFIG_SMP)
-	if (!pinned && get_sysctl_timer_migration() && idle_cpu(cpu))
+	if (!pinned && get_sysctl_timer_migration())
 		cpu = get_nohz_timer_target();
+	else
+		cpu = smp_processor_id();
+#else
+	cpu = smp_processor_id();
 #endif
 	new_base = per_cpu(tvec_bases, cpu);
 
-- 
1.7.12.rc2.18.g61b472e
