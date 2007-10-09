From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 2/5] RT - fix reschedule IPI
Date: Tue, 09 Oct 2007 10:25:54 -0400
Message-ID: <20071009142554.4941.39785.stgit@novell1.haskins.net>
References: <20071009142044.4941.65189.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: kravetz@us.ibm.com, linux-kernel@vger.kernel.org,
	ghaskins@novell.com, pmorreale@novell.com, sdietrich@novell.com
To: mingo@elte.hu, linux-rt-users@vger.kernel.org, rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:45531
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754060AbXJIOiz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Oct 2007 10:38:55 -0400
In-Reply-To: <20071009142044.4941.65189.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Mike Kravetz <kravetz@us.ibm.com>

x86_64 based RESCHED_IPIs fail to set the reschedule flag

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 arch/x86_64/kernel/smp.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86_64/kernel/smp.c b/arch/x86_64/kernel/smp.c
index a5bf746..3ce6cad 100644
--- a/arch/x86_64/kernel/smp.c
+++ b/arch/x86_64/kernel/smp.c
@@ -505,13 +505,13 @@ void smp_send_stop(void)
 }
 
 /*
- * Reschedule call back. Nothing to do,
- * all the work is done automatically when
- * we return from the interrupt.
+ * Reschedule call back. Trigger a reschedule pass so that
+ * RT-overload balancing can pass tasks around.
  */
 asmlinkage void smp_reschedule_interrupt(void)
 {
 	ack_APIC_irq();
+	set_tsk_need_resched(current);
 }
 
 asmlinkage void smp_call_function_interrupt(void)
