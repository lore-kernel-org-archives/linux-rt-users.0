Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B929DC433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95DFE61151
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhJOR1Y (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhJOR1X (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Oct 2021 13:27:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174BAC061570;
        Fri, 15 Oct 2021 10:25:17 -0700 (PDT)
Date:   Fri, 15 Oct 2021 19:25:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634318714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=1WN9cr+JBrgxENw+1ro55q+PzK5+4flkdw5BKQfBtas=;
        b=USqP1XOCxpg4j9eyl3g80G+zz/nWQU65bkh7N4XdlvZ9ZsQi6bvhKO2F6EeFwZeNvXLoTz
        qHNQn4A6QeutTAbIk1o/KwEJ0Ebn4rYqsLvkuweURZBUPD3fbdnLq+IVUdINW5tG3wyLss
        Z1WtIdUJrT7Cndv/6n7LMANRb3MwtzJKqNt9eArciy0jZ6my1CXgbeySd/K3OxzX10o/sz
        aCexCWocNoiam2GKrRjZwtMPCY/D03BKvlfX6JvzrjYKFpbl6vR6VMd3KmiwwJLlUDIhxy
        6OHKQwPeR/i2/NEaR5FRB+HuVXEde9uYcaZUQOBldi3XEjCgvPb1UwNaQ2T6yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634318714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=1WN9cr+JBrgxENw+1ro55q+PzK5+4flkdw5BKQfBtas=;
        b=YveGSGpgD8VAhGx15vwUnifWJIa3js7R5yYW6WB+buWSVavnryp25GZ5AtbKp9lanx1DBK
        RDE19U9Om8PyDhCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.15-rc5-rt10
Message-ID: <20211015172513.d744ewiogtecrqu2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.15-rc5-rt10 patch set. 

Changes since v5.15-rc5-rt9:

  - Use delayed signals on ARM64 to avoid sleeping-while-atomic warnings
    while software breakpoints are used. Patch by He Zhe.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.15-rc5-rt9 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/incr/patch-5.15-rc5-rt9-rt10.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.15-rc5-rt10

The RT patch against v5.15-rc5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patch-5.15-rc5-rt10.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patches-5.15-rc5-rt10.tar.xz

Sebastian

diff --git a/arch/arm64/include/asm/signal.h b/arch/arm64/include/asm/signal.h
index ef449f5f4ba80..5e535c3e49260 100644
--- a/arch/arm64/include/asm/signal.h
+++ b/arch/arm64/include/asm/signal.h
@@ -22,4 +22,8 @@ static inline void __user *arch_untagged_si_addr(void __user *addr,
 }
 #define arch_untagged_si_addr arch_untagged_si_addr
 
+#if defined(CONFIG_PREEMPT_RT)
+#define ARCH_RT_DELAYS_SIGNAL_SEND
+#endif
+
 #endif
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 8a9194ed981ce..1d65f2801e138 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -928,6 +928,14 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
 		} else {
 			local_daif_restore(DAIF_PROCCTX);
 
+#ifdef ARCH_RT_DELAYS_SIGNAL_SEND
+			if (unlikely(current->forced_info.si_signo)) {
+				struct task_struct *t = current;
+				force_sig_info(&t->forced_info);
+				t->forced_info.si_signo = 0;
+			}
+#endif
+
 			if (thread_flags & _TIF_UPROBE)
 				uprobe_notify_resume(regs);
 
diff --git a/localversion-rt b/localversion-rt
index 22746d6390a42..d79dde624aaac 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt9
+-rt10
