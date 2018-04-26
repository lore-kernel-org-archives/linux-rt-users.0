From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT] seqlock: provide the same ordering semantics as mainline
Date: Thu, 26 Apr 2018 15:02:03 -0500
Message-ID: <20180426200203.11560-1-julia@ni.com>
References: <20180426192258.GK12238@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        John Ogness <john.ogness@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Gratian Crisan <gratian.crisan@ni.com>,
        <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable-rt@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180426192258.GK12238@jcartwri.amer.corp.natinst.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The mainline implementation of read_seqbegin() orders prior loads w.r.t.
the read-side critical section.  Fixup the RT writer-boosting
implementation to provide the same guarantee.

Also, while we're here, update the usage of ACCESS_ONCE() to use
READ_ONCE().

Fixes: e69f15cf77c23 ("seqlock: Prevent rt starvation")
Cc: stable-rt@vger.kernel.org
Signed-off-by: Julia Cartwright <julia@ni.com>
---
Found during code inspection of the RT seqlock implementation.

   Julia

 include/linux/seqlock.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index a59751276b94..597ce5a9e013 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -453,7 +453,7 @@ static inline unsigned read_seqbegin(seqlock_t *sl)
 	unsigned ret;
 
 repeat:
-	ret = ACCESS_ONCE(sl->seqcount.sequence);
+	ret = READ_ONCE(sl->seqcount.sequence);
 	if (unlikely(ret & 1)) {
 		/*
 		 * Take the lock and let the writer proceed (i.e. evtl
@@ -462,6 +462,7 @@ static inline unsigned read_seqbegin(seqlock_t *sl)
 		spin_unlock_wait(&sl->lock);
 		goto repeat;
 	}
+	smp_rmb();
 	return ret;
 }
 #endif
-- 
2.16.1
