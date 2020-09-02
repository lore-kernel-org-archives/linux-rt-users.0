Return-Path: <SRS0=5+M/=CL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9E6C433E7
	for <linux-rt-users@archiver.kernel.org>; Wed,  2 Sep 2020 15:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D2DD207EA
	for <linux-rt-users@archiver.kernel.org>; Wed,  2 Sep 2020 15:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i/ve32Wu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eOasIUQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgIBP4D (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:56:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48176 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIBP4B (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 2 Sep 2020 11:56:01 -0400
Date:   Wed, 2 Sep 2020 17:55:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599062158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=QbRUtG+xCqrG5ewBG4h2tqjAQOFvW6yIUDtQ1Zk6KEo=;
        b=i/ve32Wug0QHbc0SmvAHR8yZTjuXKFgKaxvULb0jiUOPuu8EXW3JDmps15BQtJIGqpV5Q9
        ptEp6MV8wG72LFEwbwvh6ln5K/Y6AE2wyAEnt+FRr/U0dqDqkAhc4+SKa+4Gqdel0JjmLI
        CFhSeRq96iWl5scdSN4ApHkwjkql8pbYSKUX+duxXNeymHYnc3JJ5GDFRe/ZNQBCHfOnfx
        7vWgEiYaqZSTASIdZenRjuIMLKFPR2kjj+Qy4tKxenJ1a2uJFBVnHuNDyXljge+r+k1zoS
        TeBAnRYMKYn/DYiKLz5mwPKMR+7vCPJtDLfBmBm63f/4XEbJrjyJ3k034YgbFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599062158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=QbRUtG+xCqrG5ewBG4h2tqjAQOFvW6yIUDtQ1Zk6KEo=;
        b=eOasIUQuWdBOcJRYzrZwGs9ha/d4h2nTopn9F3q97dkZQnqb0xCH8KGCP/pMqqflB5nBYh
        9cI/5zei8xgJz5CA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.9-rc3-rt3
Message-ID: <20200902155557.h2wl2qpfn2rwsofw@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.9-rc3-rt3 patch set. 

Changes since v5.9-rc3-rt2:

  - Correct a compile issue in the i915 driver. Reported by Carsten Emde
    and Daniel Wagner.

  - Mark Marshall reported a crash on PowerPC. The reason for the crash
    is a race in exec_mmap() vs a context switch and is not limited to
    PowerPC. This race is present since v5.4.3-rt1 and is addressed in
    two changes:

    - commit 38cf307c1f201 ("mm: fix kthread_use_mm() vs TLB invalidate")
      which is part of v5.9-rc1.

    - patch "mm: fix exec activate_mm vs TLB shootdown and lazy tlb switching race"
      by Nicholas Piggin which has been posted for review and is not yet
      merged upstream.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.9-rc3-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/incr/patch-5.9-rc3-rt2-rt3.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.9-rc3-rt3

The RT patch against v5.9-rc3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patch-5.9-rc3-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patches-5.9-rc3-rt3.tar.xz

Sebastian

diff --git a/arch/Kconfig b/arch/Kconfig
index 222e553f3cf50..5c8e173dc7c2b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -415,6 +415,13 @@ config MMU_GATHER_NO_GATHER
 	bool
 	depends on MMU_GATHER_TABLE_FREE
 
+config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
+	bool
+	help
+	  Temporary select until all architectures can be converted to have
+	  irqs disabled over activate_mm. Architectures that do IPI based TLB
+	  shootdowns should enable this.
+
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index c5700f44422ec..e8f809161c75f 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -29,7 +29,6 @@
 #include <linux/async.h>
 #include <linux/i2c.h>
 #include <linux/sched/clock.h>
-#include <linux/local_lock.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_crtc.h>
@@ -1150,7 +1149,6 @@ struct intel_crtc {
 #ifdef CONFIG_DEBUG_FS
 	struct intel_pipe_crc pipe_crc;
 #endif
-	local_lock_t pipe_update_lock;
 };
 
 struct intel_plane {
diff --git a/drivers/gpu/drm/i915/display/intel_sprite.c b/drivers/gpu/drm/i915/display/intel_sprite.c
index 62b8248d2ee79..1b9d5e690a9f0 100644
--- a/drivers/gpu/drm/i915/display/intel_sprite.c
+++ b/drivers/gpu/drm/i915/display/intel_sprite.c
@@ -118,7 +118,8 @@ void intel_pipe_update_start(const struct intel_crtc_state *new_crtc_state)
 			"PSR idle timed out 0x%x, atomic update may fail\n",
 			psr_status);
 
-	local_lock_irq(&crtc->pipe_update_lock);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_disable();
 
 	crtc->debug.min_vbl = min;
 	crtc->debug.max_vbl = max;
@@ -143,11 +144,13 @@ void intel_pipe_update_start(const struct intel_crtc_state *new_crtc_state)
 			break;
 		}
 
-		local_unlock_irq(&crtc->pipe_update_lock);
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			local_irq_enable();
 
 		timeout = schedule_timeout(timeout);
 
-		local_lock_irq(&crtc->pipe_update_lock);
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			local_irq_disable();
 	}
 
 	finish_wait(wq, &wait);
@@ -180,7 +183,8 @@ void intel_pipe_update_start(const struct intel_crtc_state *new_crtc_state)
 	return;
 
 irq_disable:
-	local_lock_irq(&crtc->pipe_update_lock);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_disable();
 }
 
 /**
@@ -218,7 +222,8 @@ void intel_pipe_update_end(struct intel_crtc_state *new_crtc_state)
 		new_crtc_state->uapi.event = NULL;
 	}
 
-	local_unlock_irq(&crtc->pipe_update_lock);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_enable();
 
 	if (intel_vgpu_active(dev_priv))
 		return;
diff --git a/fs/exec.c b/fs/exec.c
index a91003e28eaae..d4fb18baf1fb1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1130,11 +1130,24 @@ static int exec_mmap(struct mm_struct *mm)
 	}
 
 	task_lock(tsk);
-	active_mm = tsk->active_mm;
 	membarrier_exec_mmap(mm);
-	tsk->mm = mm;
+
+	local_irq_disable();
+	active_mm = tsk->active_mm;
 	tsk->active_mm = mm;
+	tsk->mm = mm;
+	/*
+	 * This prevents preemption while active_mm is being loaded and
+	 * it and mm are being updated, which could cause problems for
+	 * lazy tlb mm refcounting when these are updated by context
+	 * switches. Not all architectures can handle irqs off over
+	 * activate_mm yet.
+	 */
+	if (!IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
+		local_irq_enable();
 	activate_mm(active_mm, mm);
+	if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
+		local_irq_enable();
 	tsk->mm->vmacache_seqnum = 0;
 	vmacache_flush(tsk);
 	task_unlock(tsk);
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
