Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5154C4338F
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 12:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD0846113E
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 12:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241293AbhHEMVl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 Aug 2021 08:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhHEMVl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Aug 2021 08:21:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B71FC061765;
        Thu,  5 Aug 2021 05:21:27 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628166085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJ6h27+J2VjaA1WXjL40qqFmxctr3307BnOoE6P6noY=;
        b=nfxwPZ1u6r5H5TNpOKIynwGTCnmj1GahmxCfM5EKXqTf9pJeHKDHRGaCQrDDAaULTCRBAF
        GLdmabzlIgjdxn/TT/dw5gnjW79g+PmtsprTcf9OTyiWaF1ujEWFiPxYig8JTVEqGy7ZAX
        efpnPQeD/JalHgJ0OmFkQiG1SukfxZ4AhA0hHOGKP6MeHHQMekMPa7jHlO8OdbQV6Hbn7C
        u5jGN/1bOHMvGjNnTXOD1YI+K0Jk3Obr+PiZA+cRwEls+X1Ubhv2ZYvisoTaslLl1tBRFI
        hOfJU5cHAAZ+Wws11eFXIgzM0Cqiysh6UrepND7dT8xeAepUydMZJNRcQgD9Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628166085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJ6h27+J2VjaA1WXjL40qqFmxctr3307BnOoE6P6noY=;
        b=ZdvwuHxOA0redXKXPacWWewEg0LUlbPeZtIqavHy7Ck4d9ELFe9NHdZRDTWj+sHRRlrYA/
        IYsIq3YTlHC2IoBg==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Qin\, Chao" <chao.qin@intel.com>, Joe Perches <joe@perches.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users\@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "bigeasy\@linutronix.de" <bigeasy@linutronix.de>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "mgross\@linux.intel.com" <mgross@linux.intel.com>,
        "Mei\, Paul" <paul.mei@intel.com>, "Li\, Lili" <lili.li@intel.com>,
        "Qin\, Chao" <chao.qin@intel.com>
Subject: RE: [PREEMPT_RT][PATCH] printk: Enhance the condition check of msleep in pr_flush()
In-Reply-To: <DM6PR11MB380275B5125531E8EB9D019B92F29@DM6PR11MB3802.namprd11.prod.outlook.com>
References: <20210719022649.3444072-1-chao.qin@intel.com> <ea6c6a2b5482d62038d7d0a1d46b87665051222f.camel@perches.com> <87o8axm6ae.fsf@jogness.linutronix.de> <DM6PR11MB380275B5125531E8EB9D019B92F29@DM6PR11MB3802.namprd11.prod.outlook.com>
Date:   Thu, 05 Aug 2021 14:27:25 +0206
Message-ID: <87eeb8w08q.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello Steven,

Could you please cherry-pick 83e9288d9c42("printk: Enhance the condition
check of msleep in pr_flush()") from linux-rt-devel.git (branch
linux-5.14.y-rt-rebase) for the next stable v5.10-rt release?

The commit is provided below as well.

Thanks.

John Ogness

On 2021-08-05, "Qin, Chao" <chao.qin@intel.com> wrote:
> Do you have plan to backport this fix into v5.10.y-rt kernel?


From 83e9288d9c4295d1195e9d780fcbc42c72ba4a83 Mon Sep 17 00:00:00 2001
From: Chao Qin <chao.qin@intel.com>
Date: Mon, 19 Jul 2021 10:26:50 +0800
Subject: [PATCH] printk: Enhance the condition check of msleep in pr_flush()

There is msleep in pr_flush(). If call WARN() in the early boot
stage such as in early_initcall, pr_flush() will run into msleep
when process scheduler is not ready yet. And then the system will
sleep forever.

Before the system_state is SYSTEM_RUNNING, make sure DO NOT sleep
in pr_flush().

Fixes: c0b395bd0fe3("printk: add pr_flush()")
Signed-off-by: Chao Qin <chao.qin@intel.com>
Signed-off-by: Lili Li <lili.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/20210719022649.3444072-1-chao.qin@intel.com
---
 kernel/printk/printk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e4085e2cafb5..500ae4b18864 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3661,7 +3661,9 @@ bool pr_flush(int timeout_ms, bool reset_on_progress)
 	u64 diff;
 	u64 seq;
 
-	may_sleep = (preemptible() && !in_softirq());
+	may_sleep = (preemptible() &&
+		     !in_softirq() &&
+		     system_state >= SYSTEM_RUNNING);
 
 	seq = prb_next_seq(prb);
 
-- 
2.20.1
