Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F476C7EE23
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 May 2023 11:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjEQLGa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 May 2023 07:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjEQLGT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 May 2023 07:06:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2752A198
        for <linux-rt-users@vger.kernel.org>; Wed, 17 May 2023 04:05:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B86CE61B39
        for <linux-rt-users@vger.kernel.org>; Wed, 17 May 2023 11:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1A1C433AC
        for <linux-rt-users@vger.kernel.org>; Wed, 17 May 2023 11:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684321546;
        bh=qFKD79K63+zZFidXirbfSN98MZUR71mhk/EyLESka7U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oa6wd6fZOUK8McVFHEpWS3urUbKAvRNoiKg12tbJg3iMihxgD7VJAoWiyTOnoR1iA
         DcUJM0mYHj5zb37Y0VbH8pcj9kb2hn74j6AV7Kpop7ko7ikkuPpMkRj5K/qhJ3l0z7
         hwOTNUGkEhF3MM/d7RQjsJiKMyFQ1Caix96z4EL7hMggsppY2b7AV/qjeGz/Hzs8kc
         8y9hpIV1vw9W+KsAn6F6urdX5hRBNBj+FOQwojSzqTWUEXWGByyHy9r778u7N9PVh9
         OGQci89zF5TgvPwSR/rP8NyTe2LWP+W/K7mCiwy1Y/mOp0qreKKrBikeXDjq3pDbla
         5Ed4YKqlXiHPQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ac7f53ae44so5679761fa.2
        for <linux-rt-users@vger.kernel.org>; Wed, 17 May 2023 04:05:45 -0700 (PDT)
X-Gm-Message-State: AC+VfDySpu9EkNOkK3JaM7evWl1b1bM1DPD0qJP92NamgjPu1SFW5g79
        f4QKf3ZB1yI5fXDoRY9lzoU8WZuumzPscVP7iWc=
X-Google-Smtp-Source: ACHHUZ6ZanBOmbNlFhpS8pIqQaCTTPdfZ67PYPNOcs15owWc6e9+zgEO3EKfa3pVvxattq3svIFcvbK8jeY7hgkmkvI=
X-Received: by 2002:a2e:a0d6:0:b0:2ad:81ca:a52f with SMTP id
 f22-20020a2ea0d6000000b002ad81caa52fmr9383219ljm.47.1684321543935; Wed, 17
 May 2023 04:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <202305142217.46875.pisa@cmp.felk.cvut.cz> <20230516163352.jaNEyMPF@linutronix.de>
 <CAMj1kXHs0-sxieh_9235Y+QEUzftvPCJLp37Qp3vKXKmO1i=zw@mail.gmail.com> <20230517085411.eTVSySWx@linutronix.de>
In-Reply-To: <20230517085411.eTVSySWx@linutronix.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 17 May 2023 13:05:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEG1F5RgzhjWfELfh8REQoOGjEH065aHwzHVP9DVEt7Bw@mail.gmail.com>
Message-ID: <CAMj1kXEG1F5RgzhjWfELfh8REQoOGjEH065aHwzHVP9DVEt7Bw@mail.gmail.com>
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

On Wed, 17 May 2023 at 10:54, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2023-05-16 19:13:26 [+0200], Ard Biesheuvel wrote:
> > On Tue, 16 May 2023 at 18:33, Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > + ard, peterz
> >
> > Hello Sebastian,
> Hi Ard,
>
> > Please check whether 6.4-rc2 is equally affected - we fixed some
> > issues related to BH en/disabling from asm code.
>
> oh oh Ard, you are the best. Thank you.
>

Well, I was the one who broke things in the first place, so it's only
reasonable that I was the one fixing them again.

For context, these changes give a substantial performance boost on the
RX path to IPsec or WireGuard using SIMD based software crypto.

> =E2=80=A6
> > Please take a look, and confirm whether or not we still need to drop
> > the get_cpu() call from vfp_sync_hwstate()
>
> Yes, it needs to be dealt with. At the time vfp_sync_hwstate() the
> context is fully preemptible. So that get_cpu() needs to be removed
> before local_bh_disable(). But=E2=80=A6
>
> If I understand the logic right, then the VFP state is saved on context
> switch and the FPU access is disabled but the content remains and is in
> sync with vfp_current_hw_state. Upon first usage (after the context
> switch) in userland there is an exception at which point the access to
> the FPU is enabled (FPEXC_EX) and the FPU content is loaded unless it is
> in sync as per vfp_current_hw_state.
>

Exactly. On UP we lazily preserve the user space FP state, and on SMP
we always preserve it on a context switch. Then, only when user space
actually tries to use the SIMD context, the correct data is copied in.
That way, we don't take the performance hit for tasks that are blocked
in the kernel.

> That means it relies on disabled preemption while operating on
> vfp_current_hw_state.

In general, this code relies on preserving/restoring the VFP context
to/from memory to be a critical section, as it needs to run to
completion once it is started.

> On PREEMPT_RT softirqs are only handled in process
> context (for instance at the end of the threaded interrupt). Therefore
> it is sufficient to disable preemption instead of BH. It would need
> something like x86's fpregs_lock().

I think this is not the only issue, to be honest. We cannot preempt
tasks while they are using the SIMD unit in kernel mode, as the kernel
mode context is never preserved/restored. So we at least need to
disable preemption again in kernel_neon_begin() [which now relies on
BH disable to disable preemption but as you point out, that is only
the case on !RT]

Given this, I wonder whether supporting kernel mode NEON on PREEMPT_RT
is worth it to begin with. AIUI, the alternative is to disable both
preemption and BH when touching the VFP state.

> Otherwise vfp_entry() can get preempted after decisions based on
> vfp_current_hw_state have been made. Also kernel_neon_begin() could get
> preempted after enabling FPU. I think based on current logic, after
> kernel_neon_begin() a task can get preempted on PREEMPT_RT and since
> vfp_current_hw_state is NULL the registers won't be saved and a zero set
> of registers will be loaded once the neon task gets back on the CPU (it
> seems that VFP exceptions in kernel mode are treated the same way as
> those in user mode).
>
> What do you think?
>

Indeed. kernel_neon_begin() no longer disabling preemption is
definitely wrong on PREEMPT_RT. The question is whether we want to
untangle this or just make PREEMPT_RT and KERNEL_MODE_NEON mutually
exclusive. This, by itself, makes quite a lot of sense, actually,
given that on actual 32-bit hardware, the SIMD speedup is not that
spectacular (the AES and other crypto instructions, which do give an
order of magnitude speedup are only implemented on 64-bit cores, which
usually run a 64-bit kernel). So if real-time behavior is a
requirement, using ordinary crypto implemented in C (which does not
require preemption to be disabled) is likely preferred anyway.
