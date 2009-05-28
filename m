From: GeunSik Lim <leemgs1@gmail.com>
Subject: [RESEND] [PATCH 2/2 V3] sched: fix typo in sched-rt-group.txt file
Date: Thu, 28 May 2009 10:36:14 +0900
Message-ID: <1243474574.14685.38.camel@centos51>
References: <1242884360.31161.77.camel@centos51>
Reply-To: leemgs1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	tglx <tglx@linutronix.de>, williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932287AbZE1Bgw@vger.kernel.org>
In-Reply-To: <1242884360.31161.77.camel@centos51>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org




>From c2e8f308730c87010d50a72f80ede6b7f308497e Mon Sep 17 00:00:00 2001
From: GeunSik,Lim <leemgs1@gmail.com>
Date: Thu, 28 May 2009 09:59:46 +0900
Subject: [PATCH 2/2] sched: fix typo in sched-rt-group.txt file

Fix typo about static priority's range.

    Kernel Space                     User Space
    ===============================================================
      0(high) to  98(low)     user RT priority 99(high) to 1(low)
                              with SCHED_RR or SCHED_FIFO
    ---------------------------------------------------------------
     99                       sched_priority is not used in scheduling
                              decisions(it must be specified as 0)
    ---------------------------------------------------------------
    100(high) to 139(low)     user nice -20(high) to 19(low)
    ---------------------------------------------------------------
    140                       idle task priority
    ---------------------------------------------------------------
    * ref) http://www.kernel.org/doc/man-pages/online/pages/man2/sched_setscheduler.2.html

    Signed-off-by: GeunSik Lim <geunsik.lim@samsung.com>
    Reviewed-by: Ingo Molnar <mingo@elte.hu>
    CC: Steven Rostedt <rostedt@goodmis.org>
---
 Documentation/scheduler/sched-rt-group.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/scheduler/sched-rt-group.txt b/Documentation/scheduler/sched-rt-group.txt
index 5ba4d3f..1537146 100644
--- a/Documentation/scheduler/sched-rt-group.txt
+++ b/Documentation/scheduler/sched-rt-group.txt
@@ -169,7 +169,7 @@ get their allocated time.
 
 Implementing SCHED_EDF might take a while to complete. Priority Inheritance is
 the biggest challenge as the current linux PI infrastructure is geared towards
-the limited static priority levels 0-139. With deadline scheduling you need to
+the limited static priority levels 0-99. With deadline scheduling you need to
 do deadline inheritance (since priority is inversely proportional to the
 deadline delta (deadline - now).
 
-- 
1.6.3.1



-----------------------------------------------
To unsubscribe from this list: send the line "unsubscribe linux-***" 
in the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

GeunSik Lim (  S A M S U N G     E L E C T R O N I C S  )
e-Mail  :1) geunsik.lim@samsung.com
         2) leemgs@gmail.com , leemgs1@gmail.com
HomePage: http://blog.naver.com/invain/
-----------------------------------------------
