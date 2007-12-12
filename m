From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH -rt] cycles_to_usecs rounding fix
Date: Wed, 12 Dec 2007 12:15:22 -0800
Message-ID: <20071212201258.890003246__171.086160890077$1197491411$gmane$org@mvista.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, johnstul@us.ibm.com
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758370AbXLLU2D@vger.kernel.org>
Message-Id: <20071212201258.890003246@mvista.com>
Date: Wed, 12 Dec 2007 12:12:58 -0800
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

do_div() rounds down, so we add have the divisor to round up. This effected my
change to preempt_max_latency. Each time you read preempt_max_latency it gets 
rounded lower.

Signed-off-by: Daniel Walker <dwalker@mvista.com>


---
 kernel/time/timekeeping.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.23/kernel/time/timekeeping.c
===================================================================
--- linux-2.6.23.orig/kernel/time/timekeeping.c
+++ linux-2.6.23/kernel/time/timekeeping.c
@@ -144,7 +144,8 @@ unsigned long notrace cycles_to_usecs(cy
 {
 	u64 ret = cyc2ns(clock, cycles);
 
-	do_div(ret, 1000);
+	ret += NSEC_PER_USEC/2; /* For rounding in do_div() */
+	do_div(ret, NSEC_PER_USEC);
 
 	return ret;
 }
-- 

-- 
