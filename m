Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5C4C4332F
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Dec 2022 14:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiLOOrw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 15 Dec 2022 09:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiLOOru (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Dec 2022 09:47:50 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EA02F64D
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Dec 2022 06:47:49 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id l10so7091839plb.8
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Dec 2022 06:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E21P3+xoC+hmuC3jKvtc2SpHoJGCst494qW6S++/x8Q=;
        b=LmpHUGSp68l/570C0qBR4qPepyjtCxln0DGUSObCW0dkCCeXJNpzz2tdW2kF7Yj/7M
         c3wRf1oV906Fab5jlD92vdT5LPy8GeHSGUF/wL1KR2PSykA7qLdiMK8AFTTJ4jCQrzP0
         p9Va1Xpzg9Ls0Dk7mgZmEOrwLgjTyg8/D16k6/TM/qAQrtyFU6StOCgkG40xnX2H5Kjt
         NaQrv8A/pZjCohj1LUFvynfxQOORe6VqgXg+cu2fhV09rcjpg/Hb6oIWhoBTyG7wpnLb
         hrM7nt7vKmyfAGiu4USM5h34+6HVZj7gChnNUi/Uqh+nJy3IlLpqxdLA7Yv2ZWxBFhhk
         RoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E21P3+xoC+hmuC3jKvtc2SpHoJGCst494qW6S++/x8Q=;
        b=0b23jTef2+SgOLGaSjWhoYkz90U0mWGF9kqzb7KMtQccsQo7X0PUOvJaLj0FCfS8ID
         B8Y1FJYdG7Aq/FxPVPxW5lTvAQgHccJlrs4kAjY0AY8d+55e5eEkbzYyE/ln7gm1ogmD
         BUPjuItqIEQNiqn0fP+XXYF+J2TqSq4UZwatuhPr0USStS5coWtVRfOrVWDaLCYXnXWX
         ZU6year2v9NOk6qa6kgboDnEXiRsBqEcYmNqSSYvk0Z1Xq19zr8Vltkk70fXHIFVmbYz
         uLJcfStlUANbFQelHQ3YFlc4sy8pah20v+RT1GVJbNyu9io3B3K16SqFho4Dkyvzj61z
         JaGg==
X-Gm-Message-State: AFqh2koaZFzgSozFBiXegQyayeeBQzBle6ZqbfkHJ1B3ZSq3Ek0fOYbU
        bv5ocDm4pOSmDQIUewkfPuIlyfm66NZnOyl4EueO9zi8
X-Google-Smtp-Source: AMrXdXvSRS3KuXE8iBJcPaQ9DPeoesmRVYE7Pmb8XX8iD3iw3w2FGeGEFVh5xccrKQQVfi2E+FRMYNTSis3PYHuK9Co=
X-Received: by 2002:a17:90b:2541:b0:219:8199:ef57 with SMTP id
 nw1-20020a17090b254100b002198199ef57mr565481pjb.129.1671115668868; Thu, 15
 Dec 2022 06:47:48 -0800 (PST)
MIME-Version: 1.0
References: <CAEYdEeS4T33R48EQ6016rdSmVNN4ii5YBN3DKL_RRCDznGpJGA@mail.gmail.com>
 <CAMLffL_pK6riLWOT60MV7-X-EsDs0kFCQK4bSF9aogEcsdvZ3A@mail.gmail.com>
In-Reply-To: <CAMLffL_pK6riLWOT60MV7-X-EsDs0kFCQK4bSF9aogEcsdvZ3A@mail.gmail.com>
From:   Brian Wrenn <dcbrianw@gmail.com>
Date:   Thu, 15 Dec 2022 09:47:37 -0500
Message-ID: <CAEYdEeT3m36Nu7f8FpAGgRFLOAfO2FzrNiZAnV9BOEXmMPt3LQ@mail.gmail.com>
Subject: Re: Version Magic Mismatch for Kernel Module
To:     Clark Williams <williams@redhat.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

1. aarch64 on an sd410
2. spidev & rtc_pm8xxx

spidev seems to work as expected despite the error.
rtc_pm8xxx doesn't perform all the expected functionality, but I don't
think that has anything to do with the version magic mismatch.

On Wed, Dec 14, 2022 at 5:49 PM Clark Williams <williams@redhat.com> wrote:
>
> I've not seen this before. A couple of questions:
>
> 1. What arch are you building?
> 2. Which modules report version magic mis-match?
>
> Thanks,
> Clark
>
>
> On Wed, Dec 14, 2022 at 2:09 PM Brian Wrenn <dcbrianw@gmail.com> wrote:
>>
>> Hi, I've patched the Linux Kernel v5.15.7 with rt23 and used
>> menuconfig to select the fully preemptable kernel.  The boot process
>> for two modules reports an unexpected version magic.  It reads the
>> following:
>>
>> <module name>: version magic '<kernel version> SMP preempt mode_unload
>> <arch>' should be '<kernel version> SMP preemp_rt mod_unload <arch>
>>
>> This only happens for two modules, and I've built all the modules
>> under the same source tree with the same make command.  This warning
>> makes sense since I have indeed built and imaged my SOM with the
>> preempt kernel.  The command 'uname -v' returns, "SMP PREEMPT_RT
>> <date>".
>>
>> Even though I've never built this source tree without the PREEMPT_RT
>> patch, I've done a clean build to remove any doubt about obsolete
>> object files.  Can offer a hint as to what I need to change to get
>> those modules to build with the correct version magic?
>>
>> Thank you for any help,
>> Brian
>>
