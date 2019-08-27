Return-Path: <SRS0=YHoI=WX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05041C3A5A3
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Aug 2019 13:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD94217F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Aug 2019 13:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfH0NWF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:22:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43665 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbfH0NWF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Aug 2019 09:22:05 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i2bQ9-0006Cr-2B; Tue, 27 Aug 2019 15:22:01 +0200
Date:   Tue, 27 Aug 2019 15:22:01 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Alexander Dahl <ada@thorsis.com>,
        Julien Grall <julien.grall@arm.com>
Cc:     linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.2.10-rt5
Message-ID: <20190827132200.uj44quypjsqu3oup@linutronix.de>
References: <20190827105542.qxvtteirkh55i5ly@linutronix.de>
 <1775495.KgcFvHdtex@ada>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1775495.KgcFvHdtex@ada>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-08-27 14:34:19 [+0200], Alexander Dahl wrote:
> Hello Sebastian,
Hello Alexander,

> This causes build errors on my side now, I tested with the .config we use on 
> our custom tree on a tag "v5.2.10-rt5-rebase", cross-compiling with gcc 7.3.1 
> for ARCH=arm:

of course, !SMP. What about this:

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -934,7 +934,11 @@ void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
 {
 	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
 
+#ifdef CONFIG_SMP
 	if (timer->is_soft && base != &migration_base) {
+#else
+	if (timer->is_soft && base && base->cpu_base) {
+#endif
 		spin_lock(&base->cpu_base->softirq_expiry_lock);
 		spin_unlock(&base->cpu_base->softirq_expiry_lock);
 	}

Sebastian
