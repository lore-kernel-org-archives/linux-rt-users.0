Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4ADC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Jun 2022 17:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbiF3RVW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Jun 2022 13:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbiF3RVU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Jun 2022 13:21:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 982A41C13C
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Jun 2022 10:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656609678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4I+MH1BitjShuNkM5CAAnuV26uY5raJYeW45VTPEJk=;
        b=BS7bp4EnuVbxeSEMeTyRP+1nLkR/A1VjCnvSLsvIgOfOo6Jxw6Rd3ONoaChoj9OMgh3hxv
        cL1Gu7ljfO4BfRRLMopaQmaajIMgwk0iymqP8eistzD7JZ2M1TmqBgpGozhg0DPWEzPNTN
        +4m/cpZtkCd0dU9Iokx0Uic95Hxg+jA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-c86BjotWOhOScWsXQLG3qQ-1; Thu, 30 Jun 2022 13:21:17 -0400
X-MC-Unique: c86BjotWOhOScWsXQLG3qQ-1
Received: by mail-wm1-f72.google.com with SMTP id be12-20020a05600c1e8c00b0039c506b52a4so1659775wmb.1
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Jun 2022 10:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P4I+MH1BitjShuNkM5CAAnuV26uY5raJYeW45VTPEJk=;
        b=EA+mS2KJ3AOE+PW2F0KAc3hB0b3M774Hlg4APtUe+6620dNZjH7gYPmUweR6BBYasX
         Oao0u3BfhmhTjpjToFNhzGSe2MZH5g/iI2ECC153B3Mirh8Syl+y/AeWDJ4C+gBABdmM
         F/PCdLst0uyG90dWcuHkHAbHgaenjfLgJ2uiqxs8CxdhUJQfoZBvJb3H1Hc+pYqby3jU
         Vf2hef/GZSQ3BLCgiTMQkO6+ITjyzhQseGSiBdvA38viVczGUMAIhyg9ONNijCXWdFlG
         QlTpcAtF5f57qR0JS1IiootuqWhMtZLc17YGrewVGfCEzs4nNjlj/Bc2R3YVpHewbAK8
         m6GQ==
X-Gm-Message-State: AJIora//MvYNe1HUXZnERnzjnQXBsFAjp9BGO+jNXwWvs2zBQeJTRgcw
        JCv3u8ljZ1JfvA6YqPapPoerzlGdbs+5wnHAI1BopA5ogqMPL05HSvuH9HcM4ubtNX6qwXXCk3C
        vzLApGBCr4uUOgtx0wY09rQ1AXgs=
X-Received: by 2002:a05:6000:1147:b0:21b:93db:701a with SMTP id d7-20020a056000114700b0021b93db701amr9196205wrx.447.1656609675924;
        Thu, 30 Jun 2022 10:21:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vDjX7DBkTEc4uBQnlR8uyyjkl4TbNFruSL7iNye5iA5L4+fSkC52vbubuSOh3YfA0NmC/V2Q==
X-Received: by 2002:a05:6000:1147:b0:21b:93db:701a with SMTP id d7-20020a056000114700b0021b93db701amr9196183wrx.447.1656609675731;
        Thu, 30 Jun 2022 10:21:15 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id f20-20020a05600c155400b0039c41686421sm4065122wmg.17.2022.06.30.10.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 10:21:14 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     kexec@lists.infradead.org, linux-rt-users@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [PATCH v3 2/2] panic, kexec: Make __crash_kexec() NMI safe
Date:   Thu, 30 Jun 2022 18:20:41 +0100
Message-Id: <20220630172041.4100123-3-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220630172041.4100123-1-vschneid@redhat.com>
References: <20220630172041.4100123-1-vschneid@redhat.com>
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

This prevents an nmi_panic() from executing the main body of
__crash_kexec() which does the actual kexec into the kdump kernel.
The warning and return are explained by:

  6ce47fd961fa ("rtmutex: Warn if trylock is called from hard/softirq context")
  [...]
  The reasons for this are:

      1) There is a potential deadlock in the slowpath

      2) Another cpu which blocks on the rtmutex will boost the task
	 which allegedly locked the rtmutex, but that cannot work
	 because the hard/softirq context borrows the task context.

Furthermore, grabbing the lock isn't NMI safe, so do away with kexec_mutex
and replace it with an atomic variable. This is somewhat overzealous
as *some* callsites could keep using a mutex (e.g. the sysfs-facing ones
like crash_shrink_memory()), but this has the benefit of involving a single
unified lock and preventing any future NMI-related surprises.

Tested by triggering NMI panics via:

  $ echo 1 > /proc/sys/kernel/panic_on_unrecovered_nmi
  $ echo 1 > /proc/sys/kernel/unknown_nmi_panic
  $ echo 1 > /proc/sys/kernel/panic

  $ ipmitool power diag

Fixes: 6ce47fd961fa ("rtmutex: Warn if trylock is called from hard/softirq context")
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/kexec.c          | 11 ++++-------
 kernel/kexec_core.c     | 20 ++++++++++----------
 kernel/kexec_file.c     |  4 ++--
 kernel/kexec_internal.h | 15 ++++++++++++++-
 4 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index b5e40f069768..cb8e6e6f983c 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -93,13 +93,10 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 
 	/*
 	 * Because we write directly to the reserved memory region when loading
-	 * crash kernels we need a mutex here to prevent multiple crash kernels
-	 * from attempting to load simultaneously, and to prevent a crash kernel
-	 * from loading over the top of a in use crash kernel.
-	 *
-	 * KISS: always take the mutex.
+	 * crash kernels we need a serialization here to prevent multiple crash
+	 * kernels from attempting to load simultaneously.
 	 */
-	if (!mutex_trylock(&kexec_mutex))
+	if (!kexec_trylock())
 		return -EBUSY;
 
 	if (flags & KEXEC_ON_CRASH) {
@@ -165,7 +162,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 
 	kimage_free(image);
 out_unlock:
-	mutex_unlock(&kexec_mutex);
+	kexec_unlock();
 	return ret;
 }
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 16370926b21a..b03859a0fbaa 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -46,7 +46,7 @@
 #include <crypto/hash.h>
 #include "kexec_internal.h"
 
-DEFINE_MUTEX(kexec_mutex);
+atomic_t __kexec_lock = ATOMIC_INIT(0);
 
 /* Per cpu memory for storing cpu states in case of system crash. */
 note_buf_t __percpu *crash_notes;
@@ -964,7 +964,7 @@ late_initcall(kexec_core_sysctl_init);
  */
 void __noclone __crash_kexec(struct pt_regs *regs)
 {
-	/* Take the kexec_mutex here to prevent sys_kexec_load
+	/* Take the kexec_lock here to prevent sys_kexec_load
 	 * running on one cpu from replacing the crash kernel
 	 * we are using after a panic on a different cpu.
 	 *
@@ -972,7 +972,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
 	 * of memory the xchg(&kexec_crash_image) would be
 	 * sufficient.  But since I reuse the memory...
 	 */
-	if (mutex_trylock(&kexec_mutex)) {
+	if (kexec_trylock()) {
 		if (kexec_crash_image) {
 			struct pt_regs fixed_regs;
 
@@ -981,7 +981,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
 			machine_crash_shutdown(&fixed_regs);
 			machine_kexec(kexec_crash_image);
 		}
-		mutex_unlock(&kexec_mutex);
+		kexec_unlock();
 	}
 }
 STACK_FRAME_NON_STANDARD(__crash_kexec);
@@ -1013,13 +1013,13 @@ ssize_t crash_get_memory_size(void)
 {
 	ssize_t size = 0;
 
-	if (!mutex_trylock(&kexec_mutex))
+	if (!kexec_trylock())
 		return -EBUSY;
 
 	if (crashk_res.end != crashk_res.start)
 		size = resource_size(&crashk_res);
 
-	mutex_unlock(&kexec_mutex);
+	kexec_unlock();
 	return size;
 }
 
@@ -1039,7 +1039,7 @@ int crash_shrink_memory(unsigned long new_size)
 	unsigned long old_size;
 	struct resource *ram_res;
 
-	if (!mutex_trylock(&kexec_mutex))
+	if (!kexec_trylock())
 		return -EBUSY;
 
 	if (kexec_crash_image) {
@@ -1078,7 +1078,7 @@ int crash_shrink_memory(unsigned long new_size)
 	insert_resource(&iomem_resource, ram_res);
 
 unlock:
-	mutex_unlock(&kexec_mutex);
+	kexec_unlock();
 	return ret;
 }
 
@@ -1150,7 +1150,7 @@ int kernel_kexec(void)
 {
 	int error = 0;
 
-	if (!mutex_trylock(&kexec_mutex))
+	if (!kexec_trylock())
 		return -EBUSY;
 	if (!kexec_image) {
 		error = -EINVAL;
@@ -1226,7 +1226,7 @@ int kernel_kexec(void)
 #endif
 
  Unlock:
-	mutex_unlock(&kexec_mutex);
+	kexec_unlock();
 	return error;
 }
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 145321a5e798..42b95bf58daf 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -334,7 +334,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 	image = NULL;
 
-	if (!mutex_trylock(&kexec_mutex))
+	if (!kexec_trylock())
 		return -EBUSY;
 
 	dest_image = &kexec_image;
@@ -406,7 +406,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
 		arch_kexec_protect_crashkres();
 
-	mutex_unlock(&kexec_mutex);
+	kexec_unlock();
 	kimage_free(image);
 	return ret;
 }
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 48aaf2ac0d0d..74da1409cd14 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -13,7 +13,20 @@ void kimage_terminate(struct kimage *image);
 int kimage_is_destination_range(struct kimage *image,
 				unsigned long start, unsigned long end);
 
-extern struct mutex kexec_mutex;
+/*
+ * Whatever is used to serialize accesses to the kexec_crash_image needs to be
+ * NMI safe, as __crash_kexec() can happen during nmi_panic(), so here we use a
+ * "simple" atomic variable that is acquired with a cmpxchg().
+ */
+extern atomic_t __kexec_lock;
+static inline bool kexec_trylock(void)
+{
+	return atomic_cmpxchg_acquire(&__kexec_lock, 0, 1) == 0;
+}
+static inline void kexec_unlock(void)
+{
+	atomic_set_release(&__kexec_lock, 0);
+}
 
 #ifdef CONFIG_KEXEC_FILE
 #include <linux/purgatory.h>
-- 
2.31.1

