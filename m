From: Ibrahim Umar <iambaim@gmail.com>
Subject: [PATCH] Kernel 3.4.1 stable patched with 3.4-rt8 patch won't build
Date: Tue, 5 Jun 2012 17:33:36 +0800
Message-ID: <CAKhR_gPZcBXE4-M=5YAbzRzed99ZFcYBvWjoL8Cyfm4GT5G=dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: mingo@elte.hu, tglx@linutronix.de
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:43048 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202Ab2FEJdh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Jun 2012 05:33:37 -0400
Received: by gglu4 with SMTP id u4so3783090ggl.19
        for <linux-rt-users@vger.kernel.org>; Tue, 05 Jun 2012 02:33:36 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I believe it is because of this patch in the mainline:
https://lkml.org/lkml/2012/5/14/348

Below please find a patch to reverse it. While I haven't run tests
against the resulting system, the patch below made kernel 3.4.1 with
rt8 patch builds and boots fine.

-baim

--- linux-3.4.1/kernel/workqueue.c	2012-06-05 16:32:44.908918296 +0800
+++ linux-3.4.1-rt/kernel/workqueue.c	2012-06-05 16:55:18.144882941 +0800
@@ -1208,13 +1208,8 @@
 				jiffies + IDLE_WORKER_TIMEOUT);
 	}

-	/*
-	 * Sanity check nr_running.  Because trustee releases gcwq->lock
-	 * between setting %WORKER_ROGUE and zapping nr_running, the
-	 * warning may trigger spuriously.  Check iff trustee is idle.
-	 */
-	WARN_ON_ONCE(gcwq->trustee_state == TRUSTEE_DONE &&
-		     gcwq->nr_workers == gcwq->nr_idle &&
+	/* sanity check nr_running */
+	WARN_ON_ONCE(gcwq->nr_workers == gcwq->nr_idle &&
 		     atomic_read(get_gcwq_nr_running(gcwq->cpu)));
 }
