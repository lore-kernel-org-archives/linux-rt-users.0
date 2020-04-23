Return-Path: <SRS0=c0v5=6H=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F3AC54FD0
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Apr 2020 16:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC9A20CC7
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Apr 2020 16:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgDWQUH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728865AbgDWQUH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Apr 2020 12:20:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFB1C09B041;
        Thu, 23 Apr 2020 09:20:07 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jRea4-0001BA-9h; Thu, 23 Apr 2020 18:20:04 +0200
Date:   Thu, 23 Apr 2020 18:20:04 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH RT] Revert "rt: Improve the serial console PASS_LIMIT"
Message-ID: <20200423162004.ogbhgrkiwaphhh2r@linutronix.de>
References: <20200330144712.cwcz5ejal4ankeoi@linutronix.de>
 <nycvar.YEU.7.76.2004231017470.4730@gjva.wvxbf.pm>
 <nycvar.YFH.7.76.2004231111550.19713@cbobk.fhfr.pm>
 <20200423104559.rgplz6rqk6sg4kz7@linutronix.de>
 <20200423160707.hqt5wjinzcec2yig@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200423160707.hqt5wjinzcec2yig@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

There is no need to loop for longer. The message of too much work was
removed in commit
    9d7c249a1ef9b ("serial: 8250: drop the printk from serial8250_interrupt()")

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250_core.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 15d7c47fb7ca3..475b51f4321db 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -55,16 +55,7 @@ static struct uart_driver serial8250_reg;
 
 static unsigned int skip_txen_test; /* force skip of txen test at init time */
 
-/*
- * On -rt we can have a more delays, and legitimately
- * so - so don't drop work spuriously and spam the
- * syslog:
- */
-#ifdef CONFIG_PREEMPT_RT
-# define PASS_LIMIT	1000000
-#else
-# define PASS_LIMIT	512
-#endif
+#define PASS_LIMIT	512
 
 #include <asm/serial.h>
 /*
-- 
2.26.2

