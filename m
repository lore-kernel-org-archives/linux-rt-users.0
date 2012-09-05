From: Sankara Muthukrishnan <sankara.m@gmail.com>
Subject: [PATCH RFC] irq: Set CPU affinity as soon as the irq thread is created
Date: Wed, 5 Sep 2012 18:07:12 -0500
Message-ID: <CAFQPvXckDMhH6MCkXC44wF0t13Ov=yQwER8GZgRRA4aq5=_w9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57899 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759847Ab2IEXHM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Sep 2012 19:07:12 -0400
Received: by pbbrr13 with SMTP id rr13so1680360pbb.19
        for <linux-rt-users@vger.kernel.org>; Wed, 05 Sep 2012 16:07:12 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi there,

As irq_thread_check_affinity is called inside the while loop in the
IRQ thread, the core affinity is set only when an interrupt happens.
It does not seem to be a bad idea to set the core affinity soon after
the thread is created also (as shown in the patch).
irq_thread_check_affinity calls kmalloc_node that can sleep. In an
embedded target where IRQ affinities are pre-configured during
boot-time (and not modified through /proc/irq/../smp_affinity) during
run-time, the extra latency due to irq_thread_check_affinity can be
avoided during processing of the first interrupt with this patch.
Thoughts?

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 87dc053..bf2cdc2 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -791,6 +791,7 @@ static int irq_thread(void *data)

        sched_setscheduler(current, SCHED_FIFO, &param);
        current->irqaction = action;
+       irq_thread_check_affinity(desc, action);

        while (!irq_wait_for_interrupt(action)) {

- Sankara
