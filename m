From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH -rt] remove in_interrupt() BUG_ON in exit path
Date: Tue, 30 Oct 2007 15:40:04 -0700
Message-ID: <20071030223635.719787685__14527.0125395202$1193784239$gmane$org@mvista.com>
Cc: linux-kernel@vger.kernel.org
To: mingo@elte.hu
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758004AbXJ3Wn1@vger.kernel.org>
Message-Id: <20071030223635.719787685@mvista.com>
Date: Tue, 30 Oct 2007 15:36:35 -0700
CC: linux-rt-users@vger.kernel.org
CC: rostedt@goodmis.org
CC: kraj@mvista.com
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

As you can see from the patch there is already a case to catch this type
of problem. This BUG_ON() adds a resursive OOPS , since BUG() causes an OOPS 
and the OOPS just calls do_exit() , and do_exit() just causes another OOPS with
this BUG_ON().. If we call panic() here then it's clear what the problem was,
instead of causing an endless recursive crash.

Signed-off-by: Daniel Walker <dwalker@mvista.com>

---
 kernel/exit.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-2.6.23.1/kernel/exit.c
===================================================================
--- linux-2.6.23.1.orig/kernel/exit.c
+++ linux-2.6.23.1/kernel/exit.c
@@ -895,7 +895,6 @@ fastcall NORET_TYPE void do_exit(long co
 
 	WARN_ON(atomic_read(&tsk->fs_excl));
 
-	BUG_ON(in_interrupt());
 	if (unlikely(in_interrupt()))
 		panic("Aiee, killing interrupt handler!");
 	if (unlikely(!tsk->pid))
-- 

-- 
