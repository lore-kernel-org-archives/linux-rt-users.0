Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AB3C77B7F
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 May 2023 16:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjEPQer (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 May 2023 12:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjEPQe1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 May 2023 12:34:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554B893C2
        for <linux-rt-users@vger.kernel.org>; Tue, 16 May 2023 09:34:00 -0700 (PDT)
Date:   Tue, 16 May 2023 18:33:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684254833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Dj/17DBqLGsy2QIsxHAHJVL4pIhP6p1ulNipf7MrYI=;
        b=GweRE35TZIKz99xFAxb2xkkNPodhD1DmxCH9W8l/sQ6Ko/SK1wvsGc4assydjggrPwzsDv
        UzzcY/y6ywjJ7/WUg3fsuj6kVjAnnFcMpVlXcfy3ZLbzGTxEVmAinl0LGUUZK9uLS0cX/s
        0igVRnYsr00+X2ZvkUVDMKOYDWmD1r0kCVWsojD5VMeRBCxHj8JamQCgECrBsPE5EztKYv
        d7ugxTz+30fmX8ZWDZYe+h9fxlxnKkq5VFovDkCTVy8ii2aEHZMSPhArY+jutyrpN66kkY
        qLAMZCC7lOwLxfWWjtUEz/LThb9Hla8ikSvn5fGMHvCWQOg1ZGklehPEW09UcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684254833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Dj/17DBqLGsy2QIsxHAHJVL4pIhP6p1ulNipf7MrYI=;
        b=Zs+LUYt9GgHDkJtK9s9Pi01Tptk3bmvVKSTktan0bG3GKYSXlM2sZAh1qL63Ni/a8ZIOXt
        uLJSV3S7Q8yX+SAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     linux-rt-users@vger.kernel.org,
        Pavel Hronek <hronepa1@fel.cvut.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Preemp-RT kernel builds from 6.3 on fails on Xilinx Zynq 7Z010
Message-ID: <20230516163352.jaNEyMPF@linutronix.de>
References: <202305142217.46875.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202305142217.46875.pisa@cmp.felk.cvut.cz>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

+ ard, peterz

I've been looking at the PREEMPT_RT report from Pavel:

On 2023-05-14 22:17:46 [+0200], Pavel Pisa wrote:
> [  199.657099] ------------[ cut here ]------------
> [  199.657116] WARNING: CPU: 1 PID: 1702 at kernel/softirq.c:172 __local_bh_disable_ip+0xd8/0x16c
> [  199.657150] DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt))
> [  199.657155] Modules linked in: ctucanfd_platform ctucanfd dtbocfg(O) uio_pdrv_genirq ip_tables x_tables
> [  199.657192] CPU: 1 PID: 1702 Comm: find Tainted: G           O       6.3.0-rc7-rt9-dut #1
> [  199.657207] Hardware name: Xilinx Zynq Platform
> [  199.657224]  unwind_backtrace from show_stack+0x10/0x14
> [  199.657259]  show_stack from dump_stack_lvl+0x40/0x4c
> [  199.657294]  dump_stack_lvl from __warn+0x84/0x168
> [  199.657330]  __warn from warn_slowpath_fmt+0x134/0x1b8
> [  199.657357]  warn_slowpath_fmt from __local_bh_disable_ip+0xd8/0x16c
> [  199.657379]  __local_bh_disable_ip from vfp_sync_hwstate+0x28/0xa0
> [  199.657403]  vfp_sync_hwstate from vfp_notifier+0x30/0x174
> [  199.657424]  vfp_notifier from atomic_notifier_call_chain+0x64/0x88
> [  199.657446]  atomic_notifier_call_chain from copy_thread+0xa4/0xe0
> [  199.657474]  copy_thread from copy_process+0x1258/0x1ba8
> [  199.657503]  copy_process from kernel_clone+0x94/0x3b8
> [  199.657525]  kernel_clone from sys_clone+0x70/0x98
> [  199.657547]  sys_clone from ret_fast_syscall+0x0/0x54
> [  199.657565] Exception stack(0xf1231fa8 to 0xf1231ff0)
> [  199.657578] 1fa0:                   b6f5f088 b6f5f520 01200011 00000000 00000000 00000000
> [  199.657592] 1fc0: b6f5f088 b6f5f520 00000001 00000078 004efba8 00000000 004cc2fc 00000000
> [  199.657601] 1fe0: 00000078 bef2b740 b6df8fe3 b6d8e616
> [  199.657608] ---[ end trace 0000000000000000 ]---

The problem is that vfp_sync_hwstate() does:
	preempt_disable();
	local_bh_disable();

this *would* be okay *if* it is guaranteed that BH is not already
disabled on this CPU. This isn't the case because something disabled BH,
got preempted and then this occurred.
This could be (probably) fixed by dropping that get_cpu() from
vfp_sync_hwstate() (unless preemption should really be disabled as
claimed by the comment). But then I looked further and stumbled over
commit
   62b95a7b44d1a ("ARM: 9282/1: vfp: Manipulate task VFP state with softirqs disabled")

and got a little sad. On PREEMPT_RT you can't simply add
SOFTIRQ_DISABLE_OFFSET to the preemption counter because it works
differently. You would have to invoke local_bh_disable() which *may*
involve a context switch if BH was disabled by another task which got
preempted. I guess this only happens from userland at which point it is
guaranteed that BH is disabled since it is not preemptible on !RT.

This local_bh_disable() is invoked from do_vfp which has interrupts
enabled. The counter-part enables BH by simply removing that constant.
Don't we miss a scheduling opportunity if an interrupt occurred and the
NEED_RESCHED flag was set? Also if an interrupt raised softirqs while
they were disabled, the local_bh_enable() should invoke "do_softirq()"
or they remain pending until the next opportunity. Unless your way back
there has a check somewhere.

The snippet below is probably disgusting but I managed to boot in qemu.

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 06b48ce23e1ca..47c9f14f8c5e9 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -244,6 +244,7 @@ THUMB(	fpreg	.req	r7	)
 	.endm
 #endif
 
+#if 0
 	.macro	local_bh_disable, ti, tmp
 	ldr	\tmp, [\ti, #TI_PREEMPT]
 	add	\tmp, \tmp, #SOFTIRQ_DISABLE_OFFSET
@@ -256,6 +257,7 @@ THUMB(	fpreg	.req	r7	)
 	sub	\tmp, \tmp, #SOFTIRQ_DISABLE_OFFSET
 	str	\tmp, [\ti, #TI_PREEMPT]
 	.endm
+#endif
 
 #define USERL(l, x...)				\
 9999:	x;					\
diff --git a/arch/arm/vfp/entry.S b/arch/arm/vfp/entry.S
index 9a89264cdcc0b..80e45999c2961 100644
--- a/arch/arm/vfp/entry.S
+++ b/arch/arm/vfp/entry.S
@@ -22,7 +22,14 @@
 @  IRQs enabled.
 @
 ENTRY(do_vfp)
-	local_bh_disable r10, r4
+	push {r0, r2, r9, r10, lr}
+	ldr     r0, 0f
+	mov	r1, #SOFTIRQ_DISABLE_OFFSET
+0:
+	bl	__local_bh_disable_ip
+	pop {r0, r2, r9, r10, lr}
+
+/*	local_bh_disable r10, r4 */
  	ldr	r4, .LCvfp
 	ldr	r11, [r10, #TI_CPU]	@ CPU number
 	add	r10, r10, #TI_VFPSTATE	@ r10 = workspace
@@ -30,7 +37,11 @@ ENTRY(do_vfp)
 ENDPROC(do_vfp)
 
 ENTRY(vfp_null_entry)
-	local_bh_enable_ti r10, r4
+/*	local_bh_enable_ti r10, r4 */
+	ldr     r0, 0f
+	mov	r1, #SOFTIRQ_DISABLE_OFFSET
+0:
+	bl	__local_bh_enable_ip
 	ret	lr
 ENDPROC(vfp_null_entry)
 
diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index 26c4f61ecfa39..e9f183aad39ed 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -175,7 +175,13 @@ ENTRY(vfp_support_entry)
 					@ else it's one 32-bit instruction, so
 					@ always subtract 4 from the following
 					@ instruction address.
-	local_bh_enable_ti r10, r4
+	push { r0, r2, r9, r10, r11, lr}
+	ldr     r0, 0f
+	mov	r1, #SOFTIRQ_DISABLE_OFFSET
+0:
+	bl	__local_bh_enable_ip
+	pop { r0, r2, r9, r10, r11, lr}
+/*	local_bh_enable_ti r10, r4 */
 	ret	r9			@ we think we have handled things
 
 
@@ -200,7 +206,13 @@ ENTRY(vfp_support_entry)
 	@ not recognised by VFP
 
 	DBGSTR	"not VFP"
-	local_bh_enable_ti r10, r4
+/*	local_bh_enable_ti r10, r4 */
+	push { r0, r2, r9, r10, r11, lr}
+	ldr     r0, 0f
+	mov	r1, #SOFTIRQ_DISABLE_OFFSET
+0:
+	bl	__local_bh_enable_ip
+	pop { r0, r2, r9, r10, r11, lr}
 	ret	lr
 
 process_exception:
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 01bc48d738478..d4f68806e66b9 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -515,11 +515,9 @@ static inline void vfp_pm_init(void) { }
  */
 void vfp_sync_hwstate(struct thread_info *thread)
 {
-	unsigned int cpu = get_cpu();
-
 	local_bh_disable();
-
-	if (vfp_state_in_hw(cpu, thread)) {
+	preempt_disable();
+	if (vfp_state_in_hw(smp_processor_id(), thread)) {
 		u32 fpexc = fmrx(FPEXC);
 
 		/*
@@ -530,8 +528,8 @@ void vfp_sync_hwstate(struct thread_info *thread)
 		fmxr(FPEXC, fpexc);
 	}
 
+	preempt_enable();
 	local_bh_enable();
-	put_cpu();
 }
 
 /* Ensure that the thread reloads the hardware VFP state on the next use. */

Sebastian
