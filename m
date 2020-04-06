Return-Path: <SRS0=mM24=5W=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36E5C2BA1A
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Apr 2020 21:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CEC2072A
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Apr 2020 21:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgDFVWa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:22:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45709 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgDFVWa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Apr 2020 17:22:30 -0400
Received: from [5.158.153.53] (helo=nereus.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jLZCM-00013T-Sd; Mon, 06 Apr 2020 23:22:27 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH RT] printk: console must not schedule for drivers
Date:   Mon,  6 Apr 2020 23:22:17 +0200
Message-Id: <20200406212217.2323-1-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Even though the printk kthread is always preemptible, it is still not
allowed to call cond_resched() from within console drivers. The
task may become non-preemptible in the console driver call chain. For
example, vt_console_print() takes a spinlock and then can call into
fbcon_redraw(), which can conditionally invoke cond_resched():

BUG: sleeping function called from invalid context at kernel/printk/printk.c:2322
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 177, name: printk
CPU: 0 PID: 177 Comm: printk Not tainted 5.6.2-00011-ga536059557f1d9 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
Call Trace:
 dump_stack+0x66/0x8b
 ___might_sleep+0x102/0x120
 console_conditional_schedule+0x24/0x30
 fbcon_redraw+0x96/0x1c0
 ? fbcon_cursor+0x100/0x190
 fbcon_scroll+0x556/0xd70
 con_scroll+0x147/0x1e0
 lf+0x9e/0xb0
 vt_console_print+0x253/0x3d0
 printk_kthread_func+0x1d5/0x3b0

Disable cond_resched() for the call into the console drivers.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 8821a8c2263f..8bc683be0857 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2715,6 +2715,7 @@ static int printk_kthread_func(void *data)
 			    &len, printk_time);
 
 		console_lock();
+		console_may_schedule = 0;
 		call_console_drivers(master_seq, ext_text, ext_len, text, len,
 				     msg->level, msg->facility);
 		if (len > 0 || ext_len > 0)
-- 
2.19.0

