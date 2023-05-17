Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D980FC77B75
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 May 2023 14:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjEQOhf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 May 2023 10:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjEQOhe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 May 2023 10:37:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09B35B92
        for <linux-rt-users@vger.kernel.org>; Wed, 17 May 2023 07:37:10 -0700 (PDT)
Date:   Wed, 17 May 2023 16:37:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684334228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=szd4rfowkM/hJpYfSQx/uqFKrLlX1Tg1wxKUvyan//k=;
        b=DO9hqs5af4K70pB4ggvqwsN3B/7MtKw3MCYP1l4tiXfkHBcU9+t3MMV3W8461/BE9OZJVm
        yDFFSPzcmzUp8SeKtOf0XbBzkDIwRvcBGaIM1a1oSmGOG1q2U52OFe9+f29OQKX7KjY7oW
        40pVkL4aHgow1KFZaoYb+5fXlHcC02YRkL65RpnVKAEu7NXbThQQF5/RNovpIPa4xsx99m
        SQkgTvP1TbMwTpy742Bd4loZjVMfJM3WPQql7cfftyQz3xobNSPDK+4U417ZaUZHbNsWmD
        28v7U2FWD7FkHrWAjNdRUDG/V+g6Dwk4YCApimuKnVMEeaTqPrkkcuKMFaCjGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684334228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=szd4rfowkM/hJpYfSQx/uqFKrLlX1Tg1wxKUvyan//k=;
        b=7XWPBV7vPrwWeF5kDcxYMIaEx4xvMalDMYi/C8+IFpqulJWMIje1feQRIdGL9Qmr4A1jy1
        NqRp3XSGXQ3ukyDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-rt-users@vger.kernel.org,
        Pavel Hronek <hronepa1@fel.cvut.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Preemp-RT kernel builds from 6.3 on fails on Xilinx Zynq 7Z010
Message-ID: <20230517143706.6hi48xeo@linutronix.de>
References: <202305142217.46875.pisa@cmp.felk.cvut.cz>
 <20230516163352.jaNEyMPF@linutronix.de>
 <CAMj1kXHs0-sxieh_9235Y+QEUzftvPCJLp37Qp3vKXKmO1i=zw@mail.gmail.com>
 <20230517085411.eTVSySWx@linutronix.de>
 <CAMj1kXEG1F5RgzhjWfELfh8REQoOGjEH065aHwzHVP9DVEt7Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMj1kXEG1F5RgzhjWfELfh8REQoOGjEH065aHwzHVP9DVEt7Bw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-05-17 13:05:32 [+0200], Ard Biesheuvel wrote:
> For context, these changes give a substantial performance boost on the
> RX path to IPsec or WireGuard using SIMD based software crypto.
>=20
> > =E2=80=A6
> > > Please take a look, and confirm whether or not we still need to drop
> > > the get_cpu() call from vfp_sync_hwstate()
> >
> > Yes, it needs to be dealt with. At the time vfp_sync_hwstate() the
> > context is fully preemptible. So that get_cpu() needs to be removed
> > before local_bh_disable(). But=E2=80=A6
> >
> > If I understand the logic right, then the VFP state is saved on context
> > switch and the FPU access is disabled but the content remains and is in
> > sync with vfp_current_hw_state. Upon first usage (after the context
> > switch) in userland there is an exception at which point the access to
> > the FPU is enabled (FPEXC_EX) and the FPU content is loaded unless it is
> > in sync as per vfp_current_hw_state.
> >
>=20
> Exactly. On UP we lazily preserve the user space FP state, and on SMP
> we always preserve it on a context switch. Then, only when user space
> actually tries to use the SIMD context, the correct data is copied in.
> That way, we don't take the performance hit for tasks that are blocked
> in the kernel.
>=20
> > That means it relies on disabled preemption while operating on
> > vfp_current_hw_state.
>=20
> In general, this code relies on preserving/restoring the VFP context
> to/from memory to be a critical section, as it needs to run to
> completion once it is started.
>=20
> > On PREEMPT_RT softirqs are only handled in process
> > context (for instance at the end of the threaded interrupt). Therefore
> > it is sufficient to disable preemption instead of BH. It would need
> > something like x86's fpregs_lock().
>=20
> I think this is not the only issue, to be honest. We cannot preempt
> tasks while they are using the SIMD unit in kernel mode, as the kernel
> mode context is never preserved/restored. So we at least need to
> disable preemption again in kernel_neon_begin() [which now relies on
> BH disable to disable preemption but as you point out, that is only
> the case on !RT]
>=20
> Given this, I wonder whether supporting kernel mode NEON on PREEMPT_RT
> is worth it to begin with. AIUI, the alternative is to disable both
> preemption and BH when touching the VFP state.

Only preemption on RT. So it is debatable if it makes sense to use NEON
on RT. The preempt-off section is limited to PAGE_SIZE due the scatter/
gather walk if I remember correctly.

> > Otherwise vfp_entry() can get preempted after decisions based on
> > vfp_current_hw_state have been made. Also kernel_neon_begin() could get
> > preempted after enabling FPU. I think based on current logic, after
> > kernel_neon_begin() a task can get preempted on PREEMPT_RT and since
> > vfp_current_hw_state is NULL the registers won't be saved and a zero set
> > of registers will be loaded once the neon task gets back on the CPU (it
> > seems that VFP exceptions in kernel mode are treated the same way as
> > those in user mode).
> >
> > What do you think?
> >
>=20
> Indeed. kernel_neon_begin() no longer disabling preemption is
> definitely wrong on PREEMPT_RT. The question is whether we want to
> untangle this or just make PREEMPT_RT and KERNEL_MODE_NEON mutually
> exclusive. This, by itself, makes quite a lot of sense, actually,
> given that on actual 32-bit hardware, the SIMD speedup is not that
> spectacular (the AES and other crypto instructions, which do give an
> order of magnitude speedup are only implemented on 64-bit cores, which
> usually run a 64-bit kernel). So if real-time behavior is a
> requirement, using ordinary crypto implemented in C (which does not
> require preemption to be disabled) is likely preferred anyway.

I have no opinion which can be backed up by numbers. So I have no
problem to go along with it and disable KERNEL_MODE_NEON since it is
simpler and the benefit is questionable.

So patch
- #1 KERNEL_MODE_NEON depends on !RT
- #2 disable BH followed by preemption in vfp_sync_hwstate() and
  vfp_entry().

if so, let me prepare something unless you want to :)

Sebastian
