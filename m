Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167EFC4338F
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Jul 2021 20:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB19760EB2
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Jul 2021 20:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhGVTaj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Jul 2021 15:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57895 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230366AbhGVTaj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Jul 2021 15:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626984673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FQiDBKKD741DQtVrx05XHx6TnZPGQkq3WyPqWgsemgI=;
        b=UgWJ7u7JY3eZsNvzVA2B/FtXvpJVF7FJCs8U8TODR/MO7TnCr0GuVAHyYGgRfGZEqe1F3o
        eMoArk/ZUAEGt4boFLRfx8bhoySqYvmjbZEA3KzdVDfvJYnLkzJDHSVSo/VBUvdljqmMRA
        xyVkD3ohk0eRBRpcwpQhfZrqS18Z0dI=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-sBTFf_sYMi-bW1aR2N9i1g-1; Thu, 22 Jul 2021 16:11:11 -0400
X-MC-Unique: sBTFf_sYMi-bW1aR2N9i1g-1
Received: by mail-io1-f69.google.com with SMTP id e24-20020a5d8e180000b02904dd8a55bbd7so4792365iod.12
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Jul 2021 13:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FQiDBKKD741DQtVrx05XHx6TnZPGQkq3WyPqWgsemgI=;
        b=j1fWzJfKgbukRTPFhRJB1KgEnRXwPWNp24HVq6To1Lv2gRYszvp78SFsoL1H5fzR3h
         aIzWgZ0BRKSaJ9lsaA8fiBT+dsFVXWuFG1eFGa+O+b8w9GFdJr4q3iSUJZPGvkteA4kj
         9A2kS0OuIz9SGKF4LDXjVl4eRtPwtMv0YhU4hxMWTdrW2KzpwrLq3qryb7rKwP/UedX2
         FXkapq0Bz0sSREJj7qjrASSGmYZs5OmxCwjPUsYb5ZM2qClWWoqRWFxnznDHDQk1cLZp
         80yhkL7WabGlUXuJVh0IqCRCJjQX2WHTjpzWUg7DPGd207YnEJEWwlg6EAgE2ME84qwj
         L/4w==
X-Gm-Message-State: AOAM530AxkFBl3AC7EDCRX+xcWxwQ/NvvNOkepDcwYpgiuQ21JwKKg2Y
        ABT1amN9uK+XnflOVSDe87ag9oajVYDfuuPDyFtmicPeytYHkGKHrMh4U4qQoZyPZjrc2P84LCf
        rhHAs9yTlAI4txrlOWwg2iqOYWSo=
X-Received: by 2002:a5d:89d6:: with SMTP id a22mr1111589iot.178.1626984671239;
        Thu, 22 Jul 2021 13:11:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJFAwPs+9TaQkgJnqjWfck0s69NuWgcN/6K4dwXO71x1EdNm8aK86jdgf3quWKyPITk0/jbg==
X-Received: by 2002:a5d:89d6:: with SMTP id a22mr1111572iot.178.1626984671066;
        Thu, 22 Jul 2021 13:11:11 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id r1sm14629137ilt.37.2021.07.22.13.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 13:11:10 -0700 (PDT)
Date:   Thu, 22 Jul 2021 15:11:05 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Mark Brown <broonie@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 0/3] sched, x86, arm64: PREEMPT_RT, FPU and preemption
Message-ID: <20210722201105.kcja2ndxv7rtsrbi@halaneylaptop>
References: <20210722175157.1367122-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722175157.1367122-1-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Jul 22, 2021 at 06:51:54PM +0100, Valentin Schneider wrote:
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
>  arch/arm64/kernel/fpsimd.c     |  6 ++++--
>  arch/x86/include/asm/fpu/api.h | 19 ++-----------------
>  include/linux/bottom_half.h    | 26 ++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+), 19 deletions(-)
> 
> --
> 2.25.1
> 

I'm an outsider on all of this, but this series makes sense and looks
good to me.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

