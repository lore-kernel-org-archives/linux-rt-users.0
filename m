Return-Path: <SRS0=1NWT=DN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9A8C47095
	for <linux-rt-users@archiver.kernel.org>; Tue,  6 Oct 2020 08:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F0CA20789
	for <linux-rt-users@archiver.kernel.org>; Tue,  6 Oct 2020 08:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PKeVFABf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vi8JoNxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgJFI6P (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 6 Oct 2020 04:58:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35286 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFI6O (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Oct 2020 04:58:14 -0400
Date:   Tue, 6 Oct 2020 10:58:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601974693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=hEJvtAL62ULulPeD/jHa+GvV5aMwJhSsP1ywkU7v+VI=;
        b=PKeVFABfgPEXsRA2YZAPcDtc+bOop9XApl3EJ3Xu9kDpSLcne9ypDCoFtnxfec6u+e28H5
        lnIhMElSUsJF9IBTAhN8WAggoCg2bWWwSSBWqSPQzgDHhajdUEpfrsAE5q2oovXa1XeiSA
        OhE0YNET6dJPQP8ECPj6whamrOOr91wUvTafYcf/bg+1+qLdAKtC+u7dkVt949bc33oAjp
        Q6RYh8nqRZ4QqXjCUFnBmyOYXCvL3pJJAIwtAd0Bd6ulCf6hmhRphbgcOwOwnev4PX/ByD
        904IpKZRC+Pk61nYUCjJDmox/NLLP9srfmUSvD9lw9oDhKcMDHPfZ9Rbe7lUXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601974693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=hEJvtAL62ULulPeD/jHa+GvV5aMwJhSsP1ywkU7v+VI=;
        b=Vi8JoNxeOmOCltXe4uKFOCy8teLIbxGs5RVqhFpA2FRMBhMg5rxhDgEQQTb2LlqItNru6T
        xKqryMhvvN+qJjBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.9-rc8-rt12
Message-ID: <20201006085811.mtizrfff6k5r3me7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.9-rc8-rt12 patch set. 

Changes since v5.9-rc8-rt11:

  - The kernel test robot reported a few warnings due to the printk code
    and a compile error in the powerpc architecture.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.9-rc8-rt11 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/incr/patch-5.9-rc8-rt11-rt12.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.9-rc8-rt12

The RT patch against v5.9-rc8 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patch-5.9-rc8-rt12.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patches-5.9-rc8-rt12.tar.xz

Sebastian

diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index c9a889880214e..d488311efab1f 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -311,9 +311,6 @@ void default_machine_crash_shutdown(struct pt_regs *regs)
 	unsigned int i;
 	int (*old_handler)(struct pt_regs *regs);
 
-	/* Avoid hardlocking with irresponsive CPU holding logbuf_lock */
-	printk_nmi_enter();
-
 	/*
 	 * This function is only called after the system
 	 * has panicked or is otherwise in a critical state.
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 8b74ff17b2eef..ee7008c436ca1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1981,12 +1981,6 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 }
 EXPORT_SYMBOL(vprintk);
 
-int vprintk_default(const char *fmt, va_list args)
-{
-	return vprintk_emit(0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
-}
-EXPORT_SYMBOL_GPL(vprintk_default);
-
 /**
  * printk - print a kernel message
  * @fmt: format string
@@ -2784,7 +2778,7 @@ static int __init init_printk_kthread(void)
 }
 late_initcall(init_printk_kthread);
 
-static int vprintk_deferred(const char *fmt, va_list args)
+__printf(1, 0) static int vprintk_deferred(const char *fmt, va_list args)
 {
 	return vprintk_emit(0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
 }
diff --git a/localversion-rt b/localversion-rt
index 05c35cb580779..6e44e540b927b 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt11
+-rt12
