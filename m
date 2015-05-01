From: Ayyappa Ch <ayyappa.ch.linux@gmail.com>
Subject: [Patchv2] arch/arm64 :Cyclic Test fix in ARM64 fpsimd
Date: Fri, 1 May 2015 13:03:55 +0530
Message-ID: <CAPyr0yJ0JjxdrY7Gc+ANSM8JCMVOUGvpPxsSetWa9NHqPmidBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34347 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbbEAHd4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 May 2015 03:33:56 -0400
Received: by qkgx75 with SMTP id x75so47416808qkg.1
        for <linux-rt-users@vger.kernel.org>; Fri, 01 May 2015 00:33:55 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Following Anders Roxell  patch on "Enable PREEMPT_RT_FULL" , observed
one issue with Cyclic test while running floating point operations. So
, modified below changes for that.

>From e6a5fce9b3b55f48656240036a9354a0997c2907 Mon Sep 17 00:00:00 2001
From: Ayyappa Ch <ayyappa.chandolu@amd.com>
Date: Tue, 28 Apr 2015 11:53:00 +0530
Subject: [PATCH ] floating point realtime fix

---
 arch/arm64/kernel/fpsimd.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 2438497..3dca156 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -166,10 +166,10 @@ void fpsimd_flush_thread(void)
  */
 void fpsimd_preserve_current_state(void)
 {
- preempt_disable();
+ migrate_disable();
  if (!test_thread_flag(TIF_FOREIGN_FPSTATE))
  fpsimd_save_state(&current->thread.fpsimd_state);
- preempt_enable();
+ migrate_enable();
 }

 /*
@@ -179,7 +179,7 @@ void fpsimd_preserve_current_state(void)
  */
 void fpsimd_restore_current_state(void)
 {
- preempt_disable();
+ migrate_disable();
  if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
  struct fpsimd_state *st = &current->thread.fpsimd_state;

@@ -187,7 +187,7 @@ void fpsimd_restore_current_state(void)
  this_cpu_write(fpsimd_last_state, st);
  st->cpu = smp_processor_id();
  }
- preempt_enable();
+ migrate_enable();
 }

 /*
@@ -197,7 +197,7 @@ void fpsimd_restore_current_state(void)
  */
 void fpsimd_update_current_state(struct fpsimd_state *state)
 {
- preempt_disable();
+ migrate_disable();
  fpsimd_load_state(state);
  if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
  struct fpsimd_state *st = &current->thread.fpsimd_state;
@@ -205,7 +205,7 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
  this_cpu_write(fpsimd_last_state, st);
  st->cpu = smp_processor_id();
  }
- preempt_enable();
+ migrate_enable();
 }

 /*
@@ -239,7 +239,7 @@ void kernel_neon_begin_partial(u32 num_regs)
  * that there is no longer userland FPSIMD state in the
  * registers.
  */
- preempt_disable();
+ migrate_disable();
  if (current->mm &&
     !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
  fpsimd_save_state(&current->thread.fpsimd_state);
@@ -255,7 +255,7 @@ void kernel_neon_end(void)
  in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
  fpsimd_load_partial_state(s);
  } else {
- preempt_enable();
+ migrate_enable();
  }
 }
 EXPORT_SYMBOL(kernel_neon_end);
-- 
1.9.1
