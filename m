From: Sankara Muthukrishnan <sankara.m@gmail.com>
Subject: [PATCH RFC] irq: Honor /proc/irq core affinity when an IRQ thread is created
Date: Mon, 27 Aug 2012 17:27:17 -0500
Message-ID: <CAFQPvXe0siyupbZvnEVFQi-nog4qObGejX9HxgxeVgOphJoyTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45164 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322Ab2H0W1R (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Aug 2012 18:27:17 -0400
Received: by pbbrr13 with SMTP id rr13so8202087pbb.19
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Aug 2012 15:27:17 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi everyone,

I would like to get some feedback from the RT community before
submitting to the mainline.

Currently, by writing to /proc/irq/../smp_affinity file, core affinity
of already running IRQ threads can be modified. However, after writing
to the /proc file, an IRQ thread that gets created later does not
inherit the affinity specified in the file. This happens because the
irq action is registered in irq description only after setup_affinity
function is called. This patch addresses this problem by calling
setup_affinity function after the irq action is updated in the irq
description structure. It looks like the existing behavior (without
this patch) is inconsistent because in the case of multiple action
handlers for an irq, the IRQ thread associated with the new action
handler that is being registered does not inherit the core affinity
from the /proc file, however, the IRQ threads of the existing action
handlers do inherit the affinity.

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 87dc0539cebb26bd7122e1f2a608be7325ade437..05c64c5fc2be5c2db34e74e5a5f4d3c6f9c74bca
100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1083,9 +1083,6 @@ __setup_irq(unsigned int irq, struct irq_desc
*desc, struct irqaction *new)
         if (new->flags & IRQF_NO_SOFTIRQ_CALL)
             irq_settings_set_no_softirq_call(desc);

-        /* Set default affinity mask once everything is setup */
-        setup_affinity(irq, desc, mask);
