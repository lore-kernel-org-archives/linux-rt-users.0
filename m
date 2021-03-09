Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4EFC433E6
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Mar 2021 20:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F7B652C9
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Mar 2021 20:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhCIUkQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 9 Mar 2021 15:40:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55268 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhCIUj6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Mar 2021 15:39:58 -0500
Date:   Tue, 9 Mar 2021 21:39:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615322397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=3Xmr7Bhm0yYCHVKJX9GMtPw2hz01AiXv05IR/hPgmaU=;
        b=XSOmexd5PnwwcdDTHsdnG6UIp+m9ICNnwmCxtVDvuMuJYWIb8amjFibDOUGdmUKlChSUb3
        ql/8qfc/qV7Lm52QP5upOOQD7sbC2o+9Xc4oZxee8KDVzdR1XTiYfrtA7IIz/Jij2dojRl
        whsLNxI24cGs1DBky4x/W46hU08u4FqzQGdsOOS9FGThx1MR2kRdLWMhltI18TNsriI903
        TgP9x2CglwAg2GMwc1tc8DMCsAEa0VQ67PRlGi8j1Um1v1pYdnqyviF4o3Fx+HSEwa39B7
        LTWsozGXmsVuGbes3z5uCG0kP1Ukom3+73eySbXRBt/hAB5VY2fVq4Ud5M8T6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615322397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=3Xmr7Bhm0yYCHVKJX9GMtPw2hz01AiXv05IR/hPgmaU=;
        b=uxvAFBor5NSvzfxQoajagsFkWhQoR0TF7qmu+owkEQ5a3Db/LUQ2v35zvedsHq273KY4uI
        FdhGaE3ownLQmLDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.11.4-rt11
Message-ID: <20210309203956.lt5sp3l633xx5nl5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.11.4-rt11 patch set. 

Changes since v5.11.4-rt10:

  - Update the softirq/tasklet patches to the latest version posted to
    the list.

Known issues
     - kdb/kgdb can easily deadlock.
     - netconsole triggers WARN.

The delta patch against v5.11.4-rt10 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.11/incr/patch-5.11.4-rt10-rt11.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.11.4-rt11

The RT patch against v5.11.4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.11/older/patch-5.11.4-rt11.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.11/older/patches-5.11.4-rt11.tar.xz

Sebastian

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index ed6e49bceff1a..272ffd12cf756 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -672,6 +672,7 @@ static inline int tasklet_trylock(struct tasklet_struct *t)
 void tasklet_unlock(struct tasklet_struct *t);
 void tasklet_unlock_wait(struct tasklet_struct *t);
 void tasklet_unlock_spin_wait(struct tasklet_struct *t);
+
 #else
 static inline int tasklet_trylock(struct tasklet_struct *t) { return 1; }
 static inline void tasklet_unlock(struct tasklet_struct *t) { }
@@ -702,8 +703,8 @@ static inline void tasklet_disable_nosync(struct tasklet_struct *t)
 }
 
 /*
- * Do not use in new code. There is no real reason to invoke this from
- * atomic contexts.
+ * Do not use in new code. Disabling tasklets from atomic contexts is
+ * error prone and should be avoided.
  */
 static inline void tasklet_disable_in_atomic(struct tasklet_struct *t)
 {
diff --git a/kernel/softirq.c b/kernel/softirq.c
index a9b66aa086366..27551db2b3ccc 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -830,8 +830,8 @@ EXPORT_SYMBOL(tasklet_init);
 
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 /*
- * Do not use in new code. There is no real reason to invoke this from
- * atomic contexts.
+ * Do not use in new code. Waiting for tasklets from atomic contexts is
+ * error prone and should be avoided.
  */
 void tasklet_unlock_spin_wait(struct tasklet_struct *t)
 {
diff --git a/localversion-rt b/localversion-rt
index d79dde624aaac..05c35cb580779 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt10
+-rt11
