From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 18/25][RFC 3.0.23-rt39-rc1] net: u64_stat: Protect seqcount
Date: Tue, 06 Mar 2012 11:16:54 -0500
Message-ID: <20120306161950.744002958@goodmis.org>
References: <20120306161636.491172179@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0018-net-u64_stat-Protect-seqcount.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

On RT we must prevent that the writer gets preempted inside the write
section. Otherwise a preempting reader might spin forever.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/u64_stats_sync.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index 8da8c4e..b39549f 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -70,6 +70,7 @@ struct u64_stats_sync {
 static inline void u64_stats_update_begin(struct u64_stats_sync *syncp)
 {
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+	preempt_disable_rt();
 	write_seqcount_begin(&syncp->seq);
 #endif
 }
@@ -78,6 +79,7 @@ static inline void u64_stats_update_end(struct u64_stats_sync *syncp)
 {
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
 	write_seqcount_end(&syncp->seq);
+	preempt_enable_rt();
 #endif
 }
 
-- 
1.7.8.3
