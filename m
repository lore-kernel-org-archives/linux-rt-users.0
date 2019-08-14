Return-Path: <SRS0=V9Xa=WK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE16C433FF
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Aug 2019 16:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8F82083B
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Aug 2019 16:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfHNQRd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:17:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38064 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfHNQRc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Aug 2019 12:17:32 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hxvxq-0000cu-U2; Wed, 14 Aug 2019 18:17:30 +0200
Date:   Wed, 14 Aug 2019 18:17:30 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Paul Thomas <pthomas8589@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        dunc.mcphie@gmail.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH RT] x86: preempt: Check preemption level before looking at
 lazy-preempt
Message-ID: <20190814161730.ywnyjfenduw7vqhf@linutronix.de>
References: <alpine.DEB.2.21.1907170111160.1767@nanos.tec.linutronix.de>
 <CAD56B7eswTRxbeA8foXyVVZ7Bd+_y40dtOLkHxuAf4kVge7VDg@mail.gmail.com>
 <alpine.DEB.2.21.1907171001150.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171009280.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171101150.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171220400.1767@nanos.tec.linutronix.de>
 <CAD56B7eomeb5Lr2juFWtZmtqSx3SkPijW03QZz8xv39He26PrA@mail.gmail.com>
 <20190813095306.xqgq3uusdpj7dhy7@linutronix.de>
 <CAD56B7fqosJAhiCLikhcxv_3wY7ETOv++kmQcr-=9NKEGq7Agw@mail.gmail.com>
 <20190814112656.z3de2rgbqzpaquz5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190814112656.z3de2rgbqzpaquz5@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Before evaluating the lazy-preempt state it must be ensure that the
preempt-count is zero.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/preempt.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index f8e42abd874a4..9496299d23fc3 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -99,6 +99,8 @@ static __always_inline bool __preempt_count_dec_and_test(void)
 	if (____preempt_count_dec_and_test())
 		return true;
 #ifdef CONFIG_PREEMPT_LAZY
+	if (preempt_count())
+		return false;
 	if (current_thread_info()->preempt_lazy_count)
 		return false;
 	return test_thread_flag(TIF_NEED_RESCHED_LAZY);
-- 
2.23.0.rc1

