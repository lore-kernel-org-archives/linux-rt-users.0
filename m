Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFA5C77B7F
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 May 2023 17:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjEPRNs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 May 2023 13:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjEPRNq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 May 2023 13:13:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0F0A5F5
        for <linux-rt-users@vger.kernel.org>; Tue, 16 May 2023 10:13:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8D8363CD7
        for <linux-rt-users@vger.kernel.org>; Tue, 16 May 2023 17:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEEAC4339E
        for <linux-rt-users@vger.kernel.org>; Tue, 16 May 2023 17:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684257220;
        bh=spVOV71j9bhvQjTWjU5c+FyDEJKBjhg87E1GoUS4Moc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QOg17ldeV6xOY1vIPMiEx+jNzBcTqmfxY5vCQoaTUg4UqUTPv5bbkl3miao6pVvin
         HwtW5JD9sks35G/JN9epN4jIzqX7Zv/E853RhsofUxG8MCe0mJLsEZgQBHe5amofrR
         LzzTZ2PrQfPCBzY7V49wGwTZUYWs52AqoCjpEsgvyIMdLOhcGzSbqncnwEX8d0EDZK
         wxFZPe8TJgIKAzpypBcb53OZ6qBpWDS21f8S/237ekwZrKd96PmBljc2Z6d/D2YFHN
         KtJ69s8a/GpjOi5P9m+yUKDe9MwRXWDfAbzPvGq5JShut2OM90RftrxEZmThonH3o8
         UEntKhBDEleig==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ac770a99e2so154107501fa.3
        for <linux-rt-users@vger.kernel.org>; Tue, 16 May 2023 10:13:40 -0700 (PDT)
X-Gm-Message-State: AC+VfDzSOTw6rwgXEcPjkMZYHZBlsd37YKyQnZhb+yME1foy1MMsNmh2
        YKQQpRUfLECzM0NHCnv5N1sNZb0RGfX5pCnRYDQ=
X-Google-Smtp-Source: ACHHUZ41elzlgMi6a0Tk8E5D34ZuytqxLfpS5uu+j9vQdGxXH6T4uEyEN6Iy3/LhhbAvFwAkVCFFLePGAfoilx2FUzU=
X-Received: by 2002:ac2:4255:0:b0:4f1:26f5:77fb with SMTP id
 m21-20020ac24255000000b004f126f577fbmr6798144lfl.28.1684257218138; Tue, 16
 May 2023 10:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <202305142217.46875.pisa@cmp.felk.cvut.cz> <20230516163352.jaNEyMPF@linutronix.de>
In-Reply-To: <20230516163352.jaNEyMPF@linutronix.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 May 2023 19:13:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHs0-sxieh_9235Y+QEUzftvPCJLp37Qp3vKXKmO1i=zw@mail.gmail.com>
Message-ID: <CAMj1kXHs0-sxieh_9235Y+QEUzftvPCJLp37Qp3vKXKmO1i=zw@mail.gmail.com>
Subject: Re: Preemp-RT kernel builds from 6.3 on fails on Xilinx Zynq 7Z010
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-rt-users@vger.kernel.org,
        Pavel Hronek <hronepa1@fel.cvut.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 16 May 2023 at 18:33, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> + ard, peterz

Hello Sebastian,

>
> I've been looking at the PREEMPT_RT report from Pavel:
>
> On 2023-05-14 22:17:46 [+0200], Pavel Pisa wrote:
> > [  199.657099] ------------[ cut here ]------------
> > [  199.657116] WARNING: CPU: 1 PID: 1702 at kernel/softirq.c:172 __local_bh_disable_ip+0xd8/0x16c
> > [  199.657150] DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt))
> > [  199.657155] Modules linked in: ctucanfd_platform ctucanfd dtbocfg(O) uio_pdrv_genirq ip_tables x_tables
> > [  199.657192] CPU: 1 PID: 1702 Comm: find Tainted: G           O       6.3.0-rc7-rt9-dut #1
> > [  199.657207] Hardware name: Xilinx Zynq Platform
> > [  199.657224]  unwind_backtrace from show_stack+0x10/0x14
> > [  199.657259]  show_stack from dump_stack_lvl+0x40/0x4c
> > [  199.657294]  dump_stack_lvl from __warn+0x84/0x168
> > [  199.657330]  __warn from warn_slowpath_fmt+0x134/0x1b8
> > [  199.657357]  warn_slowpath_fmt from __local_bh_disable_ip+0xd8/0x16c
> > [  199.657379]  __local_bh_disable_ip from vfp_sync_hwstate+0x28/0xa0
> > [  199.657403]  vfp_sync_hwstate from vfp_notifier+0x30/0x174
> > [  199.657424]  vfp_notifier from atomic_notifier_call_chain+0x64/0x88
> > [  199.657446]  atomic_notifier_call_chain from copy_thread+0xa4/0xe0
> > [  199.657474]  copy_thread from copy_process+0x1258/0x1ba8
> > [  199.657503]  copy_process from kernel_clone+0x94/0x3b8
> > [  199.657525]  kernel_clone from sys_clone+0x70/0x98
> > [  199.657547]  sys_clone from ret_fast_syscall+0x0/0x54
> > [  199.657565] Exception stack(0xf1231fa8 to 0xf1231ff0)
> > [  199.657578] 1fa0:                   b6f5f088 b6f5f520 01200011 00000000 00000000 00000000
> > [  199.657592] 1fc0: b6f5f088 b6f5f520 00000001 00000078 004efba8 00000000 004cc2fc 00000000
> > [  199.657601] 1fe0: 00000078 bef2b740 b6df8fe3 b6d8e616
> > [  199.657608] ---[ end trace 0000000000000000 ]---
>
> The problem is that vfp_sync_hwstate() does:
>         preempt_disable();
>         local_bh_disable();
>
> this *would* be okay *if* it is guaranteed that BH is not already
> disabled on this CPU. This isn't the case because something disabled BH,
> got preempted and then this occurred.
> This could be (probably) fixed by dropping that get_cpu() from
> vfp_sync_hwstate() (unless preemption should really be disabled as
> claimed by the comment). But then I looked further and stumbled over
> commit
>    62b95a7b44d1a ("ARM: 9282/1: vfp: Manipulate task VFP state with softirqs disabled")
>
> and got a little sad. On PREEMPT_RT you can't simply add
> SOFTIRQ_DISABLE_OFFSET to the preemption counter because it works
> differently. You would have to invoke local_bh_disable() which *may*
> involve a context switch if BH was disabled by another task which got
> preempted. I guess this only happens from userland at which point it is
> guaranteed that BH is disabled since it is not preemptible on !RT.
>
> This local_bh_disable() is invoked from do_vfp which has interrupts
> enabled. The counter-part enables BH by simply removing that constant.
> Don't we miss a scheduling opportunity if an interrupt occurred and the
> NEED_RESCHED flag was set? Also if an interrupt raised softirqs while
> they were disabled, the local_bh_enable() should invoke "do_softirq()"
> or they remain pending until the next opportunity. Unless your way back
> there has a check somewhere.
>

Please check whether 6.4-rc2 is equally affected - we fixed some
issues related to BH en/disabling from asm code.

In particular,

2b951b0efbaa6c80 ARM: 9297/1: vfp: avoid unbalanced stack on 'success'
return path
c76c6c4ecbec0deb ARM: 9294/2: vfp: Fix broken softirq handling with
instrumentation enabled
3a2bdad0b46649cc ARM: 9293/1: vfp: Pass successful return address via
register R3
dae904d96ad6a5fa ARM: 9292/1: vfp: Pass thread_info pointer to vfp_support_entry

Please take a look, and confirm whether or not we still need to drop
the get_cpu() call from vfp_sync_hwstate()

Thanks,
Ard.



> The snippet below is probably disgusting but I managed to boot in qemu.
>
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 06b48ce23e1ca..47c9f14f8c5e9 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -244,6 +244,7 @@ THUMB(      fpreg   .req    r7      )
>         .endm
>  #endif
>
> +#if 0
>         .macro  local_bh_disable, ti, tmp
>         ldr     \tmp, [\ti, #TI_PREEMPT]
>         add     \tmp, \tmp, #SOFTIRQ_DISABLE_OFFSET
> @@ -256,6 +257,7 @@ THUMB(      fpreg   .req    r7      )
>         sub     \tmp, \tmp, #SOFTIRQ_DISABLE_OFFSET
>         str     \tmp, [\ti, #TI_PREEMPT]
>         .endm
> +#endif
>
>  #define USERL(l, x...)                         \
>  9999:  x;                                      \
> diff --git a/arch/arm/vfp/entry.S b/arch/arm/vfp/entry.S
> index 9a89264cdcc0b..80e45999c2961 100644
> --- a/arch/arm/vfp/entry.S
> +++ b/arch/arm/vfp/entry.S
> @@ -22,7 +22,14 @@
>  @  IRQs enabled.
>  @
>  ENTRY(do_vfp)
> -       local_bh_disable r10, r4
> +       push {r0, r2, r9, r10, lr}
> +       ldr     r0, 0f
> +       mov     r1, #SOFTIRQ_DISABLE_OFFSET
> +0:
> +       bl      __local_bh_disable_ip
> +       pop {r0, r2, r9, r10, lr}
> +
> +/*     local_bh_disable r10, r4 */
>         ldr     r4, .LCvfp
>         ldr     r11, [r10, #TI_CPU]     @ CPU number
>         add     r10, r10, #TI_VFPSTATE  @ r10 = workspace
> @@ -30,7 +37,11 @@ ENTRY(do_vfp)
>  ENDPROC(do_vfp)
>
>  ENTRY(vfp_null_entry)
> -       local_bh_enable_ti r10, r4
> +/*     local_bh_enable_ti r10, r4 */
> +       ldr     r0, 0f
> +       mov     r1, #SOFTIRQ_DISABLE_OFFSET
> +0:
> +       bl      __local_bh_enable_ip
>         ret     lr
>  ENDPROC(vfp_null_entry)
>
> diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
> index 26c4f61ecfa39..e9f183aad39ed 100644
> --- a/arch/arm/vfp/vfphw.S
> +++ b/arch/arm/vfp/vfphw.S
> @@ -175,7 +175,13 @@ ENTRY(vfp_support_entry)
>                                         @ else it's one 32-bit instruction, so
>                                         @ always subtract 4 from the following
>                                         @ instruction address.
> -       local_bh_enable_ti r10, r4
> +       push { r0, r2, r9, r10, r11, lr}
> +       ldr     r0, 0f
> +       mov     r1, #SOFTIRQ_DISABLE_OFFSET
> +0:
> +       bl      __local_bh_enable_ip
> +       pop { r0, r2, r9, r10, r11, lr}
> +/*     local_bh_enable_ti r10, r4 */
>         ret     r9                      @ we think we have handled things
>
>
> @@ -200,7 +206,13 @@ ENTRY(vfp_support_entry)
>         @ not recognised by VFP
>
>         DBGSTR  "not VFP"
> -       local_bh_enable_ti r10, r4
> +/*     local_bh_enable_ti r10, r4 */
> +       push { r0, r2, r9, r10, r11, lr}
> +       ldr     r0, 0f
> +       mov     r1, #SOFTIRQ_DISABLE_OFFSET
> +0:
> +       bl      __local_bh_enable_ip
> +       pop { r0, r2, r9, r10, r11, lr}
>         ret     lr
>
>  process_exception:
> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> index 01bc48d738478..d4f68806e66b9 100644
> --- a/arch/arm/vfp/vfpmodule.c
> +++ b/arch/arm/vfp/vfpmodule.c
> @@ -515,11 +515,9 @@ static inline void vfp_pm_init(void) { }
>   */
>  void vfp_sync_hwstate(struct thread_info *thread)
>  {
> -       unsigned int cpu = get_cpu();
> -
>         local_bh_disable();
> -
> -       if (vfp_state_in_hw(cpu, thread)) {
> +       preempt_disable();
> +       if (vfp_state_in_hw(smp_processor_id(), thread)) {
>                 u32 fpexc = fmrx(FPEXC);
>
>                 /*
> @@ -530,8 +528,8 @@ void vfp_sync_hwstate(struct thread_info *thread)
>                 fmxr(FPEXC, fpexc);
>         }
>
> +       preempt_enable();
>         local_bh_enable();
> -       put_cpu();
>  }
>
>  /* Ensure that the thread reloads the hardware VFP state on the next use. */
>
> Sebastian
