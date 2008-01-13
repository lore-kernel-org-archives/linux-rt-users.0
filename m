From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: Re: 2.6.24-rc7-rt1
Date: Sun, 13 Jan 2008 21:43:32 +0100
Message-ID: <200801132143.34889.m.kozlowski@tuxland.pl>
References: <1200250801.9190.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:3365 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753364AbYAMUnh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 13 Jan 2008 15:43:37 -0500
In-Reply-To: <1200250801.9190.7.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

> We are pleased to announce the 2.6.24-rc7-rt1 tree, which can be
> downloaded from the location:
> 
>   http://rt.et.redhat.com/download/

  CC      kernel/lockdep.o
kernel/lockdep.c: In function 'trace_hardirqs_on':
kernel/lockdep.c:2068: error: too many arguments to function 'trace_hardirqs_on_caller'
make[1]: *** [kernel/lockdep.o] Error 1
make: *** [kernel] Error 2

--- linux-2.6.24-rc7-rt1.orig/kernel/lockdep.c  2008-01-11 21:16:46.000000000 -0500
+++ linux-2.6.24-rc7-rt1/kernel/lockdep.c       2008-01-11 21:18:10.000000000 -0500

[... snip ...]

 /*
  * Hardirqs will be enabled:
  */
-void trace_hardirqs_on(void)
+notrace void trace_hardirqs_on_caller(void) <--- this should have 'unsigned long a0'
 {
        struct task_struct *curr = current;
        unsigned long ip;
@@ -2050,6 +2059,13 @@ void trace_hardirqs_on(void)
        curr->hardirq_enable_ip = ip;
        curr->hardirq_enable_event = ++curr->irq_events;
        debug_atomic_inc(&hardirqs_on_events);
+#ifdef CONFIG_CRITICAL_IRQSOFF_TIMING
+       time_hardirqs_on(a0, 0 /* CALLER_ADDR1 */); <--- a0 is used here
+#endif
+}
+
+void notrace trace_hardirqs_on(void) {
+       trace_hardirqs_on_caller(CALLER_ADDR0);
 }

But then there is also trace_hardirqs_on_caller() in kernel/latency_trace.c 
and both are not static.

Regards,

	Mariusz
