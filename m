Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD34C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Jun 2022 12:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376281AbiFPMiq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Jun 2022 08:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiFPMih (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Jun 2022 08:38:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41C3E4B842
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jun 2022 05:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655383111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=J1U4+ccxioO2o2if5tY8m8K+V+bkZR3b9CE1FcjFWgs=;
        b=Pl4OnIRRwwBTgiEJ27dKemO9qLd8fe544+jtHAonAAFo73XHa0uRWWTGks/Z0jup7iOOIi
        gfBpoSKXu9mLUVBVRWYl1KY6JhkC0G8QrVMj2kcGQGZRwuyV7AFYuYRqgrMpqKys7x1OEE
        q21Z+iVm2lxKP/MN4x/bLNTwrAekqrE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-hBnpb8pQPkqf5SPwLNRAqg-1; Thu, 16 Jun 2022 08:38:30 -0400
X-MC-Unique: hBnpb8pQPkqf5SPwLNRAqg-1
Received: by mail-qk1-f197.google.com with SMTP id bl27-20020a05620a1a9b00b0069994eeb30cso1584760qkb.11
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jun 2022 05:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J1U4+ccxioO2o2if5tY8m8K+V+bkZR3b9CE1FcjFWgs=;
        b=Nuk7X4bPwwTa3plQMI0ZeSG6TINgi+/ELpCJoz6rZb/1RBxSbpuroHI9C2V6sdXXP3
         pphwnWdnTSgcuC0UtSwVIoNhTMcuIOQ9knhn2yxubjv2j5xmIiQHeVnhJ5J9khnozgVq
         VRuNN9VVBTfzyBkQS7HRIvH0dXvvirWkZkbt8PDGtVUEbbuy0+ZSvgI7r5xYiRnu1yJe
         lnZ1RqUGFIzwutCTqEg05oiRXETYYso/yVtFJ6nRorQeL0J6xDReB7/p5tCnS4SQuYrl
         LE0Ohs64RZFGuhrP6mWAG6zfo3oB9wtJXk7O4JgOpP4K+YWNXUP98OarxxZZ+h3gnQbY
         PqrQ==
X-Gm-Message-State: AJIora87MCTXsN/ilTALl/S7DXBehnERWaEO7C/ynLOAGYIAy6ShTKPK
        YV8ax+o0K6MKP6gtXBEzenLDcCHO6f/MD905WL/t04FYOgemL9zRtcOPGPd6u3wQVJehkyhwnyN
        CaOePSVHVuDHVpk3lGZUL1ZF6UjE=
X-Received: by 2002:a05:6214:2484:b0:46e:55b5:9f56 with SMTP id gi4-20020a056214248400b0046e55b59f56mr3859042qvb.71.1655383109523;
        Thu, 16 Jun 2022 05:38:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1twCUpPOsmHv4Nb/H9nsJ9UF88b4sWMLdzmeyX1akaa3jENfxyDO4SaAdIKpO9aT3IGPmk2fg==
X-Received: by 2002:a05:6214:2484:b0:46e:55b5:9f56 with SMTP id gi4-20020a056214248400b0046e55b59f56mr3859025qvb.71.1655383109264;
        Thu, 16 Jun 2022 05:38:29 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id y3-20020a05620a44c300b006a75a8fd54asm1863828qkp.84.2022.06.16.05.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 05:38:28 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [PATCH] panic, kexec: Don't mutex_trylock() in __crash_kexec()
Date:   Thu, 16 Jun 2022 13:37:09 +0100
Message-Id: <20220616123709.347053-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Attempting to get a crash dump out of a debug PREEMPT_RT kernel via an NMI
panic() doesn't work. The cause of that lies in the PREEMPT_RT definition
of mutex_trylock():

	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES) && WARN_ON_ONCE(!in_task()))
		return 0;

This prevents an NMI panic() from executing the main body of
__crash_kexec() which does the actual kexec into the kdump kernel.
The warning and return are explained by:

  6ce47fd961fa ("rtmutex: Warn if trylock is called from hard/softirq context")
  [...]
  The reasons for this are:

      1) There is a potential deadlock in the slowpath

      2) Another cpu which blocks on the rtmutex will boost the task
	 which allegedly locked the rtmutex, but that cannot work
	 because the hard/softirq context borrows the task context.

Use a pair of barrier-ordered variables to serialize loading vs executing a
crash kernel.

Tested by triggering NMI panics via:

  $ echo 1 > /proc/sys/kernel/panic_on_unrecovered_nmi
  $ echo 1 > /proc/sys/kernel/unknown_nmi_panic
  $ echo 1 > /proc/sys/kernel/panic

  $ ipmitool power diag

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
Regarding the original explanation for the WARN & return:

I don't get why 2) is a problem - if the lock is acquired by the trylock
then the critical section will be run without interruption since it
cannot sleep, the interrupted task may get boosted but that will not
have any actual impact AFAICT.
Regardless, even if this doesn't sleep, the ->wait_lock in the slowpath
isn't NMI safe so this needs changing.

I've thought about trying to defer the kexec out of an NMI (or IRQ)
context, but that pretty much means deferring the panic() which I'm
not sure is such a great idea.
---
 include/linux/kexec.h |  2 ++
 kernel/kexec.c        | 18 ++++++++++++++----
 kernel/kexec_core.c   | 41 +++++++++++++++++++++++++----------------
 kernel/kexec_file.c   | 14 ++++++++++++++
 4 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ce6536f1d269..89bbe150752e 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -369,6 +369,8 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
 
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
+extern bool panic_wants_kexec;
+extern bool kexec_loading;
 extern int kexec_load_disabled;
 
 #ifndef kexec_flush_icache_page
diff --git a/kernel/kexec.c b/kernel/kexec.c
index b5e40f069768..1253f4bb3079 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -94,14 +94,23 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	/*
 	 * Because we write directly to the reserved memory region when loading
 	 * crash kernels we need a mutex here to prevent multiple crash kernels
-	 * from attempting to load simultaneously, and to prevent a crash kernel
-	 * from loading over the top of a in use crash kernel.
-	 *
-	 * KISS: always take the mutex.
+	 * from attempting to load simultaneously.
 	 */
 	if (!mutex_trylock(&kexec_mutex))
 		return -EBUSY;
 
+	/*
+	 * Prevent loading a new crash kernel while one is in use.
+	 *
+	 * Pairs with smp_mb() in __crash_kexec().
+	 */
+	WRITE_ONCE(kexec_loading, true);
+	smp_mb();
+	if (READ_ONCE(panic_wants_kexec)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
 	if (flags & KEXEC_ON_CRASH) {
 		dest_image = &kexec_crash_image;
 		if (kexec_crash_image)
@@ -165,6 +174,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 
 	kimage_free(image);
 out_unlock:
+	WRITE_ONCE(kexec_loading, false);
 	mutex_unlock(&kexec_mutex);
 	return ret;
 }
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 4d34c78334ce..932cc0d4daa3 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -933,6 +933,8 @@ int kimage_load_segment(struct kimage *image,
 
 struct kimage *kexec_image;
 struct kimage *kexec_crash_image;
+bool panic_wants_kexec;
+bool kexec_loading;
 int kexec_load_disabled;
 #ifdef CONFIG_SYSCTL
 static struct ctl_table kexec_core_sysctls[] = {
@@ -964,24 +966,31 @@ late_initcall(kexec_core_sysctl_init);
  */
 void __noclone __crash_kexec(struct pt_regs *regs)
 {
-	/* Take the kexec_mutex here to prevent sys_kexec_load
-	 * running on one cpu from replacing the crash kernel
-	 * we are using after a panic on a different cpu.
+	/*
+	 * This should be taking kexec_mutex before doing anything with the
+	 * kexec_crash_image, but this code can be run in NMI context which
+	 * means we can't even trylock.
 	 *
-	 * If the crash kernel was not located in a fixed area
-	 * of memory the xchg(&kexec_crash_image) would be
-	 * sufficient.  But since I reuse the memory...
+	 * Pairs with smp_mb() in do_kexec_load() and sys_kexec_file_load()
 	 */
-	if (mutex_trylock(&kexec_mutex)) {
-		if (kexec_crash_image) {
-			struct pt_regs fixed_regs;
-
-			crash_setup_regs(&fixed_regs, regs);
-			crash_save_vmcoreinfo();
-			machine_crash_shutdown(&fixed_regs);
-			machine_kexec(kexec_crash_image);
-		}
-		mutex_unlock(&kexec_mutex);
+	WRITE_ONCE(panic_wants_kexec, true);
+	smp_mb();
+	/*
+	 * If we're panic'ing while someone else is messing with the crash
+	 * kernel, this isn't going to end well.
+	 */
+	if (READ_ONCE(kexec_loading)) {
+		WRITE_ONCE(panic_wants_kexec, false);
+		return;
+	}
+
+	if (kexec_crash_image) {
+		struct pt_regs fixed_regs;
+
+		crash_setup_regs(&fixed_regs, regs);
+		crash_save_vmcoreinfo();
+		machine_crash_shutdown(&fixed_regs);
+		machine_kexec(kexec_crash_image);
 	}
 }
 STACK_FRAME_NON_STANDARD(__crash_kexec);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 145321a5e798..4bb399e6623e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -337,6 +337,18 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if (!mutex_trylock(&kexec_mutex))
 		return -EBUSY;
 
+	/*
+	 * Prevent loading a new crash kernel while one is in use.
+	 *
+	 * Pairs with smp_mb() in __crash_kexec().
+	 */
+	WRITE_ONCE(kexec_loading, true);
+	smp_mb();
+	if (READ_ONCE(panic_wants_kexec)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
 	dest_image = &kexec_image;
 	if (flags & KEXEC_FILE_ON_CRASH) {
 		dest_image = &kexec_crash_image;
@@ -406,6 +418,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
 		arch_kexec_protect_crashkres();
 
+out_unlock:
+	WRITE_ONCE(kexec_loading, false);
 	mutex_unlock(&kexec_mutex);
 	kimage_free(image);
 	return ret;
-- 
2.27.0

