From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [patch 3/6] stomp-machine: fix typo in kernel/cpu.c
Date: Fri, 02 May 2014 13:13:06 +0200
Message-ID: <1399029186.5233.127.camel@marge.simpson.net>
References: <1399020080.5233.96.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:41931 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbaEBLNJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 May 2014 07:13:09 -0400
Received: by mail-ee0-f41.google.com with SMTP id d49so322198eek.14
        for <linux-rt-users@vger.kernel.org>; Fri, 02 May 2014 04:13:08 -0700 (PDT)
In-Reply-To: <1399020080.5233.96.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 kernel/cpu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -649,7 +649,7 @@ static int __ref _cpu_down(unsigned int
 		/* CPU didn't die: tell everyone.  Can't complain. */
 		smpboot_unpark_threads(cpu);
 		cpu_notify_nofail(CPU_DOWN_FAILED | mod, hcpu);
-		goto out_cancel;
+		goto out_release;
 	}
 	BUG_ON(cpu_online(cpu));
 



