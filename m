From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [patch 4/6] stomp-machine: fix typo in kernel/stop_machine.c
Date: Fri, 02 May 2014 13:13:14 +0200
Message-ID: <1399029194.5233.128.camel@marge.simpson.net>
References: <1399020080.5233.96.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:54631 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbaEBLNQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 May 2014 07:13:16 -0400
Received: by mail-ee0-f45.google.com with SMTP id d17so3069982eek.4
        for <linux-rt-users@vger.kernel.org>; Fri, 02 May 2014 04:13:15 -0700 (PDT)
In-Reply-To: <1399020080.5233.96.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 kernel/stop_machine.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -671,7 +671,7 @@ int stop_machine_from_inactive_cpu(int (
 	ret = multi_cpu_stop(&msdata);
 
 	/* Busy wait for completion. */
-	while (!atomic_read(&done.nr_todo))
+	while (atomic_read(&done.nr_todo))
 		cpu_relax();
 
 	mutex_unlock(&stop_cpus_mutex);



