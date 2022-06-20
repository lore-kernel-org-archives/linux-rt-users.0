Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0ADC433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 20 Jun 2022 11:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241990AbiFTLQ1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 20 Jun 2022 07:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241578AbiFTLQL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Jun 2022 07:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02DC717E1D
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Jun 2022 04:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655723745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C/YAxTMPWaMMeJDgal3C/TOrHv5lxTWth0EeXUfR+Y4=;
        b=aZjptZ8EUiWtNLzX5YIk1sePRxI/xDrbCDyhIXoLuEbF78vmIZX4DoeW7BvZS53AeYEKKd
        oU428Pkcu6TTsrQKPqsuv//icg5r0dLnxDPFDJ8d+f5Q/lpM36Ghs/SOyqKv5p+cL1P1g1
        qbmNYhtzg2la5w0j8LUouE3rpgdN27I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-U0gjij1AP0qNFttKsYkWvA-1; Mon, 20 Jun 2022 07:15:44 -0400
X-MC-Unique: U0gjij1AP0qNFttKsYkWvA-1
Received: by mail-wr1-f70.google.com with SMTP id v8-20020adfa1c8000000b0021b81a553fbso1748278wrv.18
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Jun 2022 04:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C/YAxTMPWaMMeJDgal3C/TOrHv5lxTWth0EeXUfR+Y4=;
        b=iYrtVNu1e6jwJkNMh5RwNkqBnD744zLihNOmJ4ZbYh1tJKHy38rDHdd481rx1Omvqs
         GD2S7GLFRYeHVCScrXsYtz1RM8J19GlQMpKJR4IXYlBfSkkQPvmbBF05YlMtSIQpRfMQ
         IkpaZwxQx5msdQVTUbWRxhUl/gPJGBiNUEXud3lRYxb4FTyb+QUaVtWXrwc+e/wSJnkh
         82CZ8zBntpuoI814CnkZg6CIFVuUmw4MdaNPnV91GacvP304OmYZq9IYJ90l/ZonXrPp
         ZqshNnmHEZhpMroXdACnL7bPPJd4BjjlCKl1gCQE1Pse6lkg3vMPWHpdEXx2G5cMOSw4
         6RwA==
X-Gm-Message-State: AOAM530H1QNAQJvy4wQzPPiaPEGRoJ3aZBlcKxmbEwsAWZIs81EN2LJO
        SXqKv/8wWsCVhmPD3AfUiy7WKNlonJz+qd6jCDC7bgdMW0r7ADfSbvpC9aClc6bFVpzcWhakerj
        x/WHEwekox9QP/A2J6VVZNXZkUE8=
X-Received: by 2002:a7b:c113:0:b0:39d:86c0:3ebe with SMTP id w19-20020a7bc113000000b0039d86c03ebemr34444008wmi.38.1655723742440;
        Mon, 20 Jun 2022 04:15:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzj82MNWSq7B7gWuB4AL33FUyV5eqkbqmeNRvPdUZPxtW8cOlQhltFmvUoqFG3syv3hfXYfRg==
X-Received: by 2002:a7b:c113:0:b0:39d:86c0:3ebe with SMTP id w19-20020a7bc113000000b0039d86c03ebemr34443984wmi.38.1655723742182;
        Mon, 20 Jun 2022 04:15:42 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id q185-20020a1c43c2000000b0039c3056c3dfsm21613089wma.27.2022.06.20.04.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 04:15:41 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
Date:   Mon, 20 Jun 2022 12:15:20 +0100
Message-Id: <20220620111520.1039685-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
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

Furthermore, grabbing the lock isn't NMI safe, so do away with it and
use an atomic variable to serialize reads vs writes of
kexec_crash_image.

Tested by triggering NMI panics via:

  $ echo 1 > /proc/sys/kernel/panic_on_unrecovered_nmi
  $ echo 1 > /proc/sys/kernel/unknown_nmi_panic
  $ echo 1 > /proc/sys/kernel/panic

  $ ipmitool power diag

Fixes: 6ce47fd961fa ("rtmutex: Warn if trylock is called from hard/softirq context")
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
v1 -> v2
++++++++

o Changed from Peterson-like synchronization to simpler atomic_cmpxchg
  (Petr)
o Slightly reworded changelog
o Added Fixes: tag. Technically should be up to since kexec can happen
  in an NMI, but that isn't such a clear target
---
 include/linux/kexec.h |  1 +
 kernel/kexec.c        | 16 ++++++++++++----
 kernel/kexec_core.c   | 36 +++++++++++++++++++-----------------
 kernel/kexec_file.c   | 11 +++++++++++
 4 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ce6536f1d269..5849a15ae3dd 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -369,6 +369,7 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
 
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
+extern atomic_t crash_kexec_lock;
 extern int kexec_load_disabled;
 
 #ifndef kexec_flush_icache_page
diff --git a/kernel/kexec.c b/kernel/kexec.c
index b5e40f069768..73e0df2c608f 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -94,14 +94,20 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
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
+	 * See associated comment in __crash_kexec().
+	 */
+	if (atomic_cmpxchg_acquire(&crash_kexec_lock, 0, 1)) {
+		ret = -EBUSY;
+		goto out_unlock_mutex;
+	}
+
 	if (flags & KEXEC_ON_CRASH) {
 		dest_image = &kexec_crash_image;
 		if (kexec_crash_image)
@@ -165,6 +171,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 
 	kimage_free(image);
 out_unlock:
+	atomic_set_release(&crash_kexec_lock, 0);
+out_unlock_mutex:
 	mutex_unlock(&kexec_mutex);
 	return ret;
 }
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 4d34c78334ce..f957109a266c 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -933,6 +933,7 @@ int kimage_load_segment(struct kimage *image,
 
 struct kimage *kexec_image;
 struct kimage *kexec_crash_image;
+atomic_t crash_kexec_lock = ATOMIC_INIT(0);
 int kexec_load_disabled;
 #ifdef CONFIG_SYSCTL
 static struct ctl_table kexec_core_sysctls[] = {
@@ -964,25 +965,26 @@ late_initcall(kexec_core_sysctl_init);
  */
 void __noclone __crash_kexec(struct pt_regs *regs)
 {
-	/* Take the kexec_mutex here to prevent sys_kexec_load
-	 * running on one cpu from replacing the crash kernel
-	 * we are using after a panic on a different cpu.
-	 *
-	 * If the crash kernel was not located in a fixed area
-	 * of memory the xchg(&kexec_crash_image) would be
-	 * sufficient.  But since I reuse the memory...
+	/*
+	 * This should be taking kexec_mutex before doing anything with the
+	 * kexec_crash_image, but this code can be run in NMI context which
+	 * means we can't even trylock. This is circumvented by using an
+	 * atomic variable that is *also* used by the codepaths that take
+	 * the mutex to modify kexec_crash_image.
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
+	if (atomic_cmpxchg_acquire(&crash_kexec_lock, 0, 1))
+		return;
+
+	if (kexec_crash_image) {
+		struct pt_regs fixed_regs;
+
+		crash_setup_regs(&fixed_regs, regs);
+		crash_save_vmcoreinfo();
+		machine_crash_shutdown(&fixed_regs);
+		machine_kexec(kexec_crash_image);
 	}
+
+	atomic_set_release(&crash_kexec_lock, 0);
 }
 STACK_FRAME_NON_STANDARD(__crash_kexec);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 145321a5e798..3faec031cfc9 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -337,6 +337,15 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if (!mutex_trylock(&kexec_mutex))
 		return -EBUSY;
 
+	/*
+	 * Prevent loading a new crash kernel while one is in use.
+	 * See associated comment in __crash_kexec().
+	 */
+	if (atomic_cmpxchg_acquire(&crash_kexec_lock, 0, 1)) {
+		ret = -EBUSY;
+		goto out_mutex_unlock;
+	}
+
 	dest_image = &kexec_image;
 	if (flags & KEXEC_FILE_ON_CRASH) {
 		dest_image = &kexec_crash_image;
@@ -406,6 +415,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
 		arch_kexec_protect_crashkres();
 
+	atomic_set_release(&crash_kexec_lock, 0);
+out_mutex_unlock:
 	mutex_unlock(&kexec_mutex);
 	kimage_free(image);
 	return ret;
-- 
2.31.1

