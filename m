Return-Path: <SRS0=m88/=7S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93908C433E1
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Jun 2020 23:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726E420810
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Jun 2020 23:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgFEXmY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Jun 2020 19:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbgFEXmX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Jun 2020 19:42:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8316206FA;
        Fri,  5 Jun 2020 23:42:22 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jhLyf-002sAr-W7; Fri, 05 Jun 2020 19:42:22 -0400
Message-ID: <20200605234221.847811418@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Jun 2020 19:41:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        kernel test robot <rong.a.chen@intel.com>,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH RT 1/8] printk: console must not schedule for drivers
References: <20200605234149.965509211@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

5.4.44-rt27-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: John Ogness <john.ogness@linutronix.de>

Even though the printk kthread is always preemptible, it is still not
allowed to call cond_resched() from within console drivers. The
task may become non-preemptible in the console driver call chain. For
example, vt_console_print() takes a spinlock and then can call into
fbcon_redraw(), which can conditionally invoke cond_resched():

|BUG: sleeping function called from invalid context at kernel/printk/printk.c:2322
|in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 177, name: printk
|CPU: 0 PID: 177 Comm: printk Not tainted 5.6.2-00011-ga536059557f1d9 #1
|Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
|Call Trace:
| dump_stack+0x66/0x8b
| ___might_sleep+0x102/0x120
| console_conditional_schedule+0x24/0x30
| fbcon_redraw+0x96/0x1c0
| fbcon_scroll+0x556/0xd70
| con_scroll+0x147/0x1e0
| lf+0x9e/0xb0
| vt_console_print+0x253/0x3d0
| printk_kthread_func+0x1d5/0x3b0

Disable cond_resched() for the call into the console drivers.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/printk/printk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2affe95866a4..9600373bcf55 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2746,6 +2746,7 @@ static int printk_kthread_func(void *data)
 			    &len, printk_time);
 
 		console_lock();
+		console_may_schedule = 0;
 		call_console_drivers(master_seq, ext_text, ext_len, text, len,
 				     msg->level, msg->facility);
 		if (len > 0 || ext_len > 0)
-- 
2.26.2


