Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B65C77B75
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 May 2023 22:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjEQWFu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 May 2023 18:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjEQWFt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 May 2023 18:05:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7DAED
        for <linux-rt-users@vger.kernel.org>; Wed, 17 May 2023 15:05:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADAAE64A00
        for <linux-rt-users@vger.kernel.org>; Wed, 17 May 2023 22:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB41C433EF
        for <linux-rt-users@vger.kernel.org>; Wed, 17 May 2023 22:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684361147;
        bh=Fwx9j7CaAEAqPue1AHfLVYbDTEmZLz5fzaSw6/3F6zQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hI2ZIpr5n72X89G7ldA71MW/uhuOugmj3q9HPshaY2MoyIe6VaxAjNcUhbjYRFRaD
         xf4kJv6eIqIxEKtZQp9Z+VatVsRPvitCq7gC2ckRzt6/2SAxCyZXftCEDvZnsxeFG+
         H1M9BtH2wgs/aX8TjxrX/eLEcw4yYNGS7O2weQpFQnkwDPN3+Q6qx0VDhs4GXK6QMD
         +YfjTvh15N1CiuyvpQ4IgjDiNBE3EL/YwhJlDhbj7b9y5kOtDaHQBIozOgOJtriYLr
         9C5Kcd3FXveapKPkP/IqCwKlBJZ09Y1wJsh2xD03FvcX7nribxSLQ2NUYPUqyDkwbt
         qn2OweXCrgKEg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4f2510b2b98so1550021e87.3
        for <linux-rt-users@vger.kernel.org>; Wed, 17 May 2023 15:05:47 -0700 (PDT)
X-Gm-Message-State: AC+VfDzyj9apBGENzTsI/5hn82NCQLVCYeeeq4b4oG1L/KngIVnnexA+
        PgFsu1nGAbOceI3idkXfymujZIXQdF8nQ45k4Wo=
X-Google-Smtp-Source: ACHHUZ4tPf2zpKB6VZyGisrZdrwN3YVxrphmkUaMnqaOuHbC5yHftQ/0uuVmtvw+UsgL2ejDzguORKl/cqi+qgddWJ4=
X-Received: by 2002:ac2:43b2:0:b0:4dd:cb1d:b3cc with SMTP id
 t18-20020ac243b2000000b004ddcb1db3ccmr588709lfl.11.1684361145099; Wed, 17 May
 2023 15:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <202305142217.46875.pisa@cmp.felk.cvut.cz> <20230516163352.jaNEyMPF@linutronix.de>
 <CAMj1kXHs0-sxieh_9235Y+QEUzftvPCJLp37Qp3vKXKmO1i=zw@mail.gmail.com>
 <20230517085411.eTVSySWx@linutronix.de> <CAMj1kXEG1F5RgzhjWfELfh8REQoOGjEH065aHwzHVP9DVEt7Bw@mail.gmail.com>
 <20230517143706.6hi48xeo@linutronix.de>
In-Reply-To: <20230517143706.6hi48xeo@linutronix.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 18 May 2023 00:05:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFVutgNLYWpsM1QvrLBWsoNoSSEAK-oJKGL6bEqrh=nDg@mail.gmail.com>
Message-ID: <CAMj1kXFVutgNLYWpsM1QvrLBWsoNoSSEAK-oJKGL6bEqrh=nDg@mail.gmail.com>
Subject: Re: Preemp-RT kernel builds from 6.3 on fails on Xilinx Zynq 7Z010
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-rt-users@vger.kernel.org,
        Pavel Hronek <hronepa1@fel.cvut.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 17 May 2023 at 16:37, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2023-05-17 13:05:32 [+0200], Ard Biesheuvel wrote:
> > For context, these changes give a substantial performance boost on the
> > RX path to IPsec or WireGuard using SIMD based software crypto.
> >
> > > =E2=80=A6
> > > > Please take a look, and confirm whether or not we still need to dro=
p
> > > > the get_cpu() call from vfp_sync_hwstate()
> > >
> > > Yes, it needs to be dealt with. At the time vfp_sync_hwstate() the
> > > context is fully preemptible. So that get_cpu() needs to be removed
> > > before local_bh_disable(). But=E2=80=A6
> > >
> > > If I understand the logic right, then the VFP state is saved on conte=
xt
> > > switch and the FPU access is disabled but the content remains and is =
in
> > > sync with vfp_current_hw_state. Upon first usage (after the context
> > > switch) in userland there is an exception at which point the access t=
o
> > > the FPU is enabled (FPEXC_EX) and the FPU content is loaded unless it=
 is
> > > in sync as per vfp_current_hw_state.
> > >
> >
> > Exactly. On UP we lazily preserve the user space FP state, and on SMP
> > we always preserve it on a context switch. Then, only when user space
> > actually tries to use the SIMD context, the correct data is copied in.
> > That way, we don't take the performance hit for tasks that are blocked
> > in the kernel.
> >
> > > That means it relies on disabled preemption while operating on
> > > vfp_current_hw_state.
> >
> > In general, this code relies on preserving/restoring the VFP context
> > to/from memory to be a critical section, as it needs to run to
> > completion once it is started.
> >
> > > On PREEMPT_RT softirqs are only handled in process
> > > context (for instance at the end of the threaded interrupt). Therefor=
e
> > > it is sufficient to disable preemption instead of BH. It would need
> > > something like x86's fpregs_lock().
> >
> > I think this is not the only issue, to be honest. We cannot preempt
> > tasks while they are using the SIMD unit in kernel mode, as the kernel
> > mode context is never preserved/restored. So we at least need to
> > disable preemption again in kernel_neon_begin() [which now relies on
> > BH disable to disable preemption but as you point out, that is only
> > the case on !RT]
> >
> > Given this, I wonder whether supporting kernel mode NEON on PREEMPT_RT
> > is worth it to begin with. AIUI, the alternative is to disable both
> > preemption and BH when touching the VFP state.
>
> Only preemption on RT.

Right.

> So it is debatable if it makes sense to use NEON
> on RT. The preempt-off section is limited to PAGE_SIZE due the scatter/
> gather walk if I remember correctly.
>

This depends on the type of algorithm (skciphers/aeads vs
shashes/ahashes) but they generally all have a bounded quantum of work
before yielding the NEON (and therefore the CPU).

> > > Otherwise vfp_entry() can get preempted after decisions based on
> > > vfp_current_hw_state have been made. Also kernel_neon_begin() could g=
et
> > > preempted after enabling FPU. I think based on current logic, after
> > > kernel_neon_begin() a task can get preempted on PREEMPT_RT and since
> > > vfp_current_hw_state is NULL the registers won't be saved and a zero =
set
> > > of registers will be loaded once the neon task gets back on the CPU (=
it
> > > seems that VFP exceptions in kernel mode are treated the same way as
> > > those in user mode).
> > >
> > > What do you think?
> > >
> >
> > Indeed. kernel_neon_begin() no longer disabling preemption is
> > definitely wrong on PREEMPT_RT. The question is whether we want to
> > untangle this or just make PREEMPT_RT and KERNEL_MODE_NEON mutually
> > exclusive. This, by itself, makes quite a lot of sense, actually,
> > given that on actual 32-bit hardware, the SIMD speedup is not that
> > spectacular (the AES and other crypto instructions, which do give an
> > order of magnitude speedup are only implemented on 64-bit cores, which
> > usually run a 64-bit kernel). So if real-time behavior is a
> > requirement, using ordinary crypto implemented in C (which does not
> > require preemption to be disabled) is likely preferred anyway.
>
> I have no opinion which can be backed up by numbers. So I have no
> problem to go along with it and disable KERNEL_MODE_NEON since it is
> simpler and the benefit is questionable.
>
> So patch
> - #1 KERNEL_MODE_NEON depends on !RT

Actually, given your explanation above, I think this may not be
necessary. Given that on !RT, disabling BH implies disabling
preemption and on RT disabling preemption implies disabling BH, it
should just be a matter of doing one or the other consistently,
depending on IS_ENABLED(CONFIG_PREEMPT_RT)

> - #2 disable BH followed by preemption in vfp_sync_hwstate() and
>   vfp_entry().
>

Not sure what to do here, given my answer to #1

In most cases where the VFP code disables BH, it is either because an
interrupting softirq may enable the SIMD unit and disable it again,
which would result in a FP exception when the interrupted context
tries to access the registers, or because such an interruption would
corrupt the preserved/restored FP state if it occurs while such a
preserve/restore is in progress.

Maybe the commit log of patch 62b95a7b44d1a30b3a9 sheds some more light her=
e.

> if so, let me prepare something unless you want to :)
>

Don't let me stop you :-)
