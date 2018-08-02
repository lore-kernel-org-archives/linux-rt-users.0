From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 08/15] seqlock: provide the same ordering semantics as mainline
Date: Thu,  2 Aug 2018 17:25:23 -0500
Message-ID: <650bfc722354f3307e6390ddddf1e4ee4e9dced2.1533242791.git.tom.zanussi@linux.intel.com>
References: <cover.1533242791.git.tom.zanussi@linux.intel.com>
Cc: rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com, stable-rt@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533242791.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1533242791.git.tom.zanussi@linux.intel.com>
References: <cover.1533242791.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Julia Cartwright <julia@ni.com>

The mainline implementation of read_seqbegin() orders prior loads w.r.t.
the read-side critical section.  Fixup the RT writer-boosting
implementation to provide the same guarantee.

Also, while we're here, update the usage of ACCESS_ONCE() to use
READ_ONCE().

Fixes: e69f15cf77c23 ("seqlock: Prevent rt starvation")
Cc: stable-rt@vger.kernel.org
Signed-off-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit afa4c06b89a3c0fb7784ff900ccd707bef519cb7)
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 include/linux/seqlock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 4acd0e2fb5cb..efa234031230 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -338,6 +338,7 @@ repeat:
 		spin_unlock_wait(&sl->lock);
 		goto repeat;
 	}
+	smp_rmb();
 	return ret;
 }
 #endif
-- 
2.14.1
