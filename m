From: yi li <liyi.dev@gmail.com>
Subject: A question about cpu_idle()
Date: Wed, 21 Oct 2009 11:07:38 +0800
Message-ID: <a0e7fce50910202007l587d2cfcu91b455ff0486110b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:55315 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbZJUDHe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Oct 2009 23:07:34 -0400
Received: by yxe26 with SMTP id 26so5276104yxe.4
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Oct 2009 20:07:38 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi RT users,

While reading patch-2.6.31.4-rt14, there is a patch for cpu_idle()
which I cannot understand.

Could anyone kindly enough to tell me what is patch used for?


diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index ebefb54..c8d0ece 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -152,9 +152,11 @@ void cpu_idle(void)
                }

                tick_nohz_restart_sched_tick();
-               preempt_enable_no_resched();
-               schedule();
+               local_irq_disable();
+               __preempt_enable_no_resched();
+               __schedule();
                preempt_disable();
+               local_irq_enable();
        }
 }

Regards,
-Yi
