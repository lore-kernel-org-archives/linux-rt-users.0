From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH RT 0.5/6] locallock: Add include of percpu.h
Date: Wed, 26 Jun 2013 15:43:37 -0400
Message-ID: <1372275817.18733.270.camel@gandalf.local.home>
References: <20130626192806.107564905@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clark.williams@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:12204 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307Ab3FZTnk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Jun 2013 15:43:40 -0400
In-Reply-To: <20130626192806.107564905@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[ I cut and pasted the series file but missed this patch to start ]

locallock.h uses per cpu variables, and if it is included by code
that does not include percpu.h, the compiler complains.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-rt.git/include/linux/locallock.h
===================================================================
--- linux-rt.git.orig/include/linux/locallock.h
+++ linux-rt.git/include/linux/locallock.h
@@ -1,6 +1,7 @@
 #ifndef _LINUX_LOCALLOCK_H
 #define _LINUX_LOCALLOCK_H
 
+#include <linux/percpu.h>
 #include <linux/spinlock.h>
 
 #ifdef CONFIG_PREEMPT_RT_BASE


