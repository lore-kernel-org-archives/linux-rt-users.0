Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369AEECAAA1
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Oct 2022 10:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJXKzZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Oct 2022 06:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJXKy6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Oct 2022 06:54:58 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C78D13F0E;
        Mon, 24 Oct 2022 03:54:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9CD8E61D7D;
        Mon, 24 Oct 2022 12:44:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1666608272; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=Ewd7YIr3/bEdlcKC7v2uy0s+SHWdjFr5K1Yi5NyIu0o=;
        b=C4+RmTg5hzIEjuwHdWs8SjfZlMU3wo4WAXs4hFa2XAeFvu7j/5Ex526Dr8JBA/Rpd8240j
        Lvl25pbIOnbMYiQ5Q63Zn9n+AiEZNa8+hsqjOdes0N1hWylcOuqwZqclS7EoN9ydqC1XCE
        C71lqELBsDMUJrw5ZSB8NzDLSXqMCnEuaGiCzQU+lFylRPG5OBNSQKEYHaDfJ8Ni2Nfirs
        sfim8pizNBl+Hcuy1Nz4M+DraDhnpArs/5hMlNI5ZejIYJqtdLdTW1CBuIXthe1cp1LycB
        FeVnF3jK7IQeCZiETOlo/kkfmj+S7+V+oiDu1bqT2W0G1/OU3CpgdiWN02iWiw==
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Cc:     Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 5/9] timers: Keep interrupts disabled for TIMER_IRQSAFE timer.
Date:   Mon, 24 Oct 2022 12:44:21 +0200
Message-Id: <20221024104425.16423-6-wagi@monom.org>
In-Reply-To: <20221024104425.16423-1-wagi@monom.org>
References: <20221024104425.16423-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.19.255-rt114-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Keep interrupts disabled across callback invocation for the
TIMER_IRQSAFE as expected.
This is required for the timer used by workqueue after the upcomming
rework.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 kernel/time/timer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a2be2277506d..3e2c0bd03004 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1397,8 +1397,7 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 
 		fn = timer->function;
 
-		if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL) &&
-		    timer->flags & TIMER_IRQSAFE) {
+		if (timer->flags & TIMER_IRQSAFE) {
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn);
 			base->running_timer = NULL;
-- 
2.38.0

