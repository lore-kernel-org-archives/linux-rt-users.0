Return-Path: <SRS0=Z5tp=YA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0749ECE58C
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Oct 2019 15:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D652070B
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Oct 2019 15:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfJGPOx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:14:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44632 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfJGPOw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Oct 2019 11:14:52 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iHUio-00078t-71; Mon, 07 Oct 2019 17:14:50 +0200
Date:   Mon, 7 Oct 2019 17:14:50 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH RT] printk: handle iterating while buffer changing
Message-ID: <20191007151450.pox2wys5zlzzmhke@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: John Ogness <john.ogness@linutronix.de>

The syslog and kmsg_dump readers are provided buffers to fill.
Both try to maximize the provided buffer usage by calculating the
maximum number of messages that can fit. However, if after the
calculation, messages are dropped and new messages added, the
calculation will no longer match.

For syslog, add a check to make sure the provided buffer is not
overfilled.

For kmsg_dump, start over by recalculating the messages
available.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

This reassembles the behaviour that commit
   c9dccacfccc72 ("printk: Do not lose last line in kmsg buffer dump")

did for the "old" printk code.

 kernel/printk/printk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 58c545a528b3b..9d9523431178b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1436,6 +1436,9 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 			break;
 		}
 
+		if (len + textlen > size)
+			break;
+
 		if (copy_to_user(buf + len, text, textlen))
 			len = -EFAULT;
 		else
@@ -3075,7 +3078,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 		ret = prb_iter_next(&iter, msgbuf, PRINTK_RECORD_MAX, &seq);
 		if (ret == 0) {
 			break;
-		} else if (ret < 0) {
+		} else if (ret < 0 || seq >= end_seq) {
 			prb_iter_init(&iter, &printk_rb, &seq);
 			goto retry;
 		}
-- 
2.23.0

