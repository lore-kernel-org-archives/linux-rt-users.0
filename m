From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 08/25][RFC 3.0.23-rt39-rc1] x86: vdso: Use seqcount instead of seqlock
Date: Tue, 06 Mar 2012 11:16:44 -0500
Message-ID: <20120306161946.596382093@goodmis.org>
References: <20120306161636.491172179@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0008-x86-vdso-Use-seqcount-instead-of-seqlock.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The update of the vdso data happens under xtime_lock, so adding a
nested lock is pointless. Just use a seqcount to sync the readers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86/include/asm/vgtod.h   |    2 +-
 arch/x86/kernel/vsyscall_64.c  |   11 +++--------
 arch/x86/vdso/vclock_gettime.c |   16 ++++++++--------
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index 646b4c1..10e09fc 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -5,7 +5,7 @@
 #include <linux/clocksource.h>
 
 struct vsyscall_gtod_data {
-	seqlock_t	lock;
+	seqcount_t	seq;
 
 	/* open coded 'struct timespec' */
 	time_t		wall_time_sec;
diff --git a/arch/x86/kernel/vsyscall_64.c b/arch/x86/kernel/vsyscall_64.c
index c378a18..c1fe684 100644
--- a/arch/x86/kernel/vsyscall_64.c
+++ b/arch/x86/kernel/vsyscall_64.c
@@ -50,11 +50,7 @@
 #include <asm/traps.h>
 
 DEFINE_VVAR(int, vgetcpu_mode);
-DEFINE_VVAR(struct vsyscall_gtod_data, vsyscall_gtod_data) =
-{
-	.lock = __SEQLOCK_UNLOCKED(__vsyscall_gtod_data.lock),
-	.sysctl_enabled = 1,
-};
+DEFINE_VVAR(struct vsyscall_gtod_data, vsyscall_gtod_data);
 
 void update_vsyscall_tz(void)
 {
@@ -64,9 +60,8 @@ void update_vsyscall_tz(void)
 void update_vsyscall(struct timespec *wall_time, struct timespec *wtm,
 			struct clocksource *clock, u32 mult)
 {
-	unsigned long flags;
+	write_seqcount_begin(&vsyscall_gtod_data.seq);
 
-	write_seqlock_irqsave(&vsyscall_gtod_data.lock, flags);
 
 	/* copy vsyscall data */
 	vsyscall_gtod_data.clock.vread		= clock->vread;
@@ -79,7 +74,7 @@ void update_vsyscall(struct timespec *wall_time, struct timespec *wtm,
 	vsyscall_gtod_data.wall_to_monotonic	= *wtm;
 	vsyscall_gtod_data.wall_time_coarse	= __current_kernel_time();
 
-	write_sequnlock_irqrestore(&vsyscall_gtod_data.lock, flags);
+	write_seqcount_end(&vsyscall_gtod_data.seq);
 }
 
 static void warn_bad_vsyscall(const char *level, struct pt_regs *regs,
diff --git a/arch/x86/vdso/vclock_gettime.c b/arch/x86/vdso/vclock_gettime.c
index a724905..117e6cf 100644
--- a/arch/x86/vdso/vclock_gettime.c
+++ b/arch/x86/vdso/vclock_gettime.c
@@ -46,11 +46,11 @@ notrace static noinline int do_realtime(struct timespec *ts)
 {
 	unsigned long seq, ns;
 	do {
-		seq = read_seqbegin(&gtod->lock);
+		seq = read_seqcount_begin(&gtod->seq);
 		ts->tv_sec = gtod->wall_time_sec;
 		ts->tv_nsec = gtod->wall_time_nsec;
 		ns = vgetns();
-	} while (unlikely(read_seqretry(&gtod->lock, seq)));
+	} while (unlikely(read_seqcount_retry(&gtod->seq, seq)));
 	timespec_add_ns(ts, ns);
 	return 0;
 }
@@ -59,12 +59,12 @@ notrace static noinline int do_monotonic(struct timespec *ts)
 {
 	unsigned long seq, ns, secs;
 	do {
-		seq = read_seqbegin(&gtod->lock);
+		seq = read_seqcount_begin(&gtod->seq);
 		secs = gtod->wall_time_sec;
 		ns = gtod->wall_time_nsec + vgetns();
 		secs += gtod->wall_to_monotonic.tv_sec;
 		ns += gtod->wall_to_monotonic.tv_nsec;
-	} while (unlikely(read_seqretry(&gtod->lock, seq)));
+	} while (unlikely(read_seqcount_retry(&gtod->seq, seq)));
 
 	/* wall_time_nsec, vgetns(), and wall_to_monotonic.tv_nsec
 	 * are all guaranteed to be nonnegative.
@@ -83,10 +83,10 @@ notrace static noinline int do_realtime_coarse(struct timespec *ts)
 {
 	unsigned long seq;
 	do {
-		seq = read_seqbegin(&gtod->lock);
+		seq = read_seqcount_begin(&gtod->seq);
 		ts->tv_sec = gtod->wall_time_coarse.tv_sec;
 		ts->tv_nsec = gtod->wall_time_coarse.tv_nsec;
-	} while (unlikely(read_seqretry(&gtod->lock, seq)));
+	} while (unlikely(read_seqcount_retry(&gtod->seq, seq)));
 	return 0;
 }
 
@@ -94,12 +94,12 @@ notrace static noinline int do_monotonic_coarse(struct timespec *ts)
 {
 	unsigned long seq, ns, secs;
 	do {
-		seq = read_seqbegin(&gtod->lock);
+		seq = read_seqcount_begin(&gtod->seq);
 		secs = gtod->wall_time_coarse.tv_sec;
 		ns = gtod->wall_time_coarse.tv_nsec;
 		secs += gtod->wall_to_monotonic.tv_sec;
 		ns += gtod->wall_to_monotonic.tv_nsec;
-	} while (unlikely(read_seqretry(&gtod->lock, seq)));
+	} while (unlikely(read_seqcount_retry(&gtod->seq, seq)));
 
 	/* wall_time_nsec and wall_to_monotonic.tv_nsec are
 	 * guaranteed to be between 0 and NSEC_PER_SEC.
-- 
1.7.8.3
