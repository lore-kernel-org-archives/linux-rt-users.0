Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6460FC4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Jul 2021 14:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC0060EB4
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Jul 2021 14:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbhGWNc1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 09:32:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235351AbhGWNc1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Jul 2021 09:32:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE4EA60EB4;
        Fri, 23 Jul 2021 14:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627049580;
        bh=9zgAdN2R83/AZuFoRURWsWq5ldzAHeQTlvqMRC3gzBg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jCruH8X7ttLvopYjhCJO7sQuRtFQA9BDS5phMv2YmQjXfut/sQA3bOGpr9kl+ggyP
         PDuH/e+s4vAzz5Kbwzi0SZtUQW16NTmqndd7jdnE3ZCuAANqbcUbGf58mVXGSRDpKj
         LDCQrtLHCHZnJuXmjnqbTdEEZlZJs3wNuJy0atP593sM5RiSVFkwTwnCxfh4Wrv8tG
         Ox1hr1TSxhukpenSIo80VcTfNSi1iHpmChFKycwaCzYPt8w2qITx/TVrOlYLBpvIlR
         9YarBcIVpbHXdCdyAjnJzAHvB+RFTGDUVBtOM63GdeUR0T3rTGFbVlwuQLVjkLQ27L
         vBKpJMr28iDZA==
Received: by mail-oo1-f41.google.com with SMTP id k7-20020a4abd870000b029025e4d9b0a3dso412086oop.6;
        Fri, 23 Jul 2021 07:13:00 -0700 (PDT)
X-Gm-Message-State: AOAM531+Nm4uxvv260GhbiPpSLyRPd8xAnMbtdaM/pZVicQfYCm9j1yk
        nakpTCyofNw65tVzt0dKRYiO85bVmIKeNKP1jWs=
X-Google-Smtp-Source: ABdhPJw1EADKet1m/Ts4jll8W2cR5Nkp1FQ05/qz/DVoG35kETxmRNs3KWUEW9UXNJ9E3g7oimll8XZHEWO4W71ls4o=
X-Received: by 2002:a4a:6558:: with SMTP id z24mr2823148oog.41.1627049580214;
 Fri, 23 Jul 2021 07:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210722175157.1367122-1-valentin.schneider@arm.com>
In-Reply-To: <20210722175157.1367122-1-valentin.schneider@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 23 Jul 2021 16:12:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE8Yyn0orHe3DjFvCQ3k5mUKJF10BcJ3fJTessRoMShBA@mail.gmail.com>
Message-ID: <CAMj1kXE8Yyn0orHe3DjFvCQ3k5mUKJF10BcJ3fJTessRoMShBA@mail.gmail.com>
Subject: Re: [PATCH 0/3] sched, x86, arm64: PREEMPT_RT, FPU and preemption
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-rt-users@vger.kernel.org, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Mark Brown <broonie@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 22 Jul 2021 at 19:53, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Hi folks,
>
> This stems from some more v5.13-rt1 breakage on arm64. This time per-CPU access
> safety isn't sufficient, we really need to keep preemption disabled.
>
> In a happy accident I stumbled on
>
>   cba08c5dc6dc ("x86/fpu: Make kernel FPU protection RT friendly")
>
> so I packaged what was done there into some common helpers and plastered them
> over the problematic areas.
>
> Cheers,
> Valentin
>
> Valentin Schneider (3):
>   sched/preempt: Introduce preempt_{enable, disable}_bh()
>   x86/fpu: Make FPU protection reuse common helper
>   arm64/fpsimd: Fix FPSIMD context handling vs PREEMPT_RT
>

Thanks for fixing this.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>


>  arch/arm64/kernel/fpsimd.c     |  6 ++++--
>  arch/x86/include/asm/fpu/api.h | 19 ++-----------------
>  include/linux/bottom_half.h    | 26 ++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+), 19 deletions(-)
>
> --
> 2.25.1
>
