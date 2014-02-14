From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 1/1] tracing/latency_hist Fix memory leak
Date: Fri, 14 Feb 2014 18:26:18 +0100
Message-ID: <20140214172751.776971499@osadl.org>
References: <20140214172617.382025623@osadl.org>
Cc: Nicholas Mc Guire <der.herr@hofr.at>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:51178 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242AbaBNR2O (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 Feb 2014 12:28:14 -0500
Content-Disposition: inline; filename=kernel-trace-latency-hist-fix-memory-leak.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The index_ptr memory that is allocated when printout is started
currently is only returned when the printout is stopped
prematurely. It is not returned when the printout regularly
finishes. Fix this memory leak.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

Index: linux-3.12.10-rt15-somedebug/kernel/trace/latency_hist.c
===================================================================
--- linux-3.12.10-rt15-somedebug.orig/kernel/trace/latency_hist.c
+++ linux-3.12.10-rt15-somedebug/kernel/trace/latency_hist.c
@@ -313,6 +313,7 @@ static void *l_next(struct seq_file *m, 
 
 	if (++*pos >= MAX_ENTRY_NUM) {
 		atomic_inc(&my_hist->hist_mode);
+		kfree(p);
 		return NULL;
 	}
 	*index_ptr = *pos;

