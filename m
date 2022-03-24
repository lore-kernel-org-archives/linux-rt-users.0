Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD34C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 24 Mar 2022 16:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346746AbiCXQfw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiCXQfv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 24 Mar 2022 12:35:51 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069E01B7A1
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Mar 2022 09:34:19 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id p143so2835940vkf.5
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Mar 2022 09:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jf6PkF+G71/nBnc4bRADbUg1MsdhsKjI9kPcGi91InU=;
        b=jl1L7Z9yWtzE4sX/6Fu+duqFrHfTDJ2vIUhtw5rY07YiPnWIGDOoVTBK3yVH2ku4it
         MKSW42DQmHDG+p+XIabjiGPyKVZhkRFs+ZwHaxqve4tNN65/6L0WSiKDfoOkmIokrbPa
         svJwnYI9DhUXkcD4f+1JvXVUyb/nb3ird8gVp7llYOzGR1j6MhZJzYf2+s7jioxuReIA
         4PAl/tiUqVompiyxEDNnmbTLNiWmUKS15OODRn3Li8bJkkVINQ42ftQYgMJ4qa/w9cJF
         TF3fOMOgdMudO0N9dxgJpMHiXcf2GPJb9HNuEwQfIxSU0kZPHCedrgLgV3DMQEuH7izB
         02+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jf6PkF+G71/nBnc4bRADbUg1MsdhsKjI9kPcGi91InU=;
        b=R9Egu8EdcWI7SpjasAM6t5dp9qu+0yJ691WP9NdkFhcJo1pGNciYSI6URnrI4Obo+v
         l8qlhY8UmaceyWodv5emD0BT0dWYBS1hbTAVSd4WsUERsH7iX6AdZ2y8cAsl13Tk5OuC
         G2t4xuJrCvgRUnF1PC9KwNS6e6p2sTIJp+jCThOomQZXX5tllR4JCjN6KlQzq/2SmT5g
         rDjxg7wSh+POTxMX0OG2AuTRqXzobo8/hD8j6NIREt1bv8ouizetVjhUU4JmSvfLy63c
         FMOSuXxR1mkMTH/hmYlbKYT7GcINlp6ylIt8oE17jPiigcQOz5ZqiORDFRaQzGymD/p1
         3dXQ==
X-Gm-Message-State: AOAM530ZWEcMC43qRWihUJraQAiDz85CXzQR4GKxmTpe6fKLsqP9+eKj
        ZQ56MZjVT/8GlhzeQ7BBZPjKgSF1+7UXqeuk2z7Bif9hkec=
X-Google-Smtp-Source: ABdhPJz7RZC+zdvRrhd3JHnF9MySC8niIT7fhRFRzMH9MsycpEuznaTGFNCzJMX4tvQtM+USB3XiL9Cil+bVI/qeUN8=
X-Received: by 2002:a05:6122:c85:b0:33f:ab27:5f5d with SMTP id
 ba5-20020a0561220c8500b0033fab275f5dmr3143081vkb.2.1648139657927; Thu, 24 Mar
 2022 09:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+1+E3UVmbLA76t_JkZMMC6FHsmc_EOKeLztvgN6nAhTjjK5bQ@mail.gmail.com>
 <871qyse8ra.fsf@jogness.linutronix.de> <CA+1+E3WxTOMbh5OCub2wNiNWNELA2fcDL1hXgzJzr-Yc-FuoTQ@mail.gmail.com>
 <87lewzohkk.fsf@jogness.linutronix.de>
In-Reply-To: <87lewzohkk.fsf@jogness.linutronix.de>
From:   Gautam Thaker <ghthaker@gmail.com>
Date:   Thu, 24 Mar 2022 09:34:06 -0700
Message-ID: <CA+1+E3WBGf1Q9aXAMiN3gfUEEqWQDfzPH-Hg6-G8FrZEBSZUYw@mail.gmail.com>
Subject: Re: 5.15.28-rt35 #2 SMP PREEMPT_RT: Should scheduling latency be as
 large as 800 usec?
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Mar 24, 2022 at 1:55 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> Your system is configured to support many different governors. For
> minimal latency it is important that you are using the performance
> governor. The frequency scaling might be the cause of the horrible
> hwlatdetect numbers you are seeing.
>
> If you have the cpufrequtils package installed, you can easily switch to
> the performance governor with:
>
> cpufreq-set -g performance
>
> With cpufreq-info you can see a nice summary of how your CPUs are
> currently set. You should see it running full speed.
>
> You can also configure the performance governor manually using
> sysfs. You may want to read through the documentation [0] so that you
> understand what you are doing.
>
> [0] https://www.kernel.org/doc/html/latest/admin-guide/pm/cpufreq.html

I tried both
cpufreq-set -g performance
and
cpufreq-set -g schedutil

And also set the lower and upper freq to 3.2 GHz. Overall this has not
made much of a  difference, I still see ~800 usec latency reports out
of 'hwlatdetect'. The best run was:

...
... [Same for CPUs 0-30 ...]
analyzing CPU 31:
  driver: intel_cpufreq
  CPUs which run at the same hardware frequency: 31
  CPUs which need to have their frequency coordinated by software: 31
  maximum transition latency: 20.0 us.
  hardware limits: 1.20 GHz - 3.20 GHz
  available cpufreq governors: conservative, ondemand, userspace,
powersave, performance, schedutil
  current policy: frequency should be within 3.20 GHz and 3.20 GHz.
                  The governor "schedutil" may decide which speed to use
                  within this range.
  current CPU frequency is 1.20 GHz.

node-0> sudo hwlatdetect --duration=30s
hwlatdetect:  test duration 30 seconds
   detector: tracer
   parameters:
        Latency threshold: 10us
        Sample window:     1000000us
        Sample width:      500000us
     Non-sampling period:  500000us
        Output File:       None

Starting test
test finished
Max Latency: 779us
Samples recorded: 8
Samples exceeding threshold: 8
ts: 1648139049.597634649, inner:779, outer:18
ts: 1648139050.597355299, inner:16, outer:498
ts: 1648139051.347299254, inner:441, outer:0
ts: 1648139074.347304238, inner:410, outer:0
ts: 1648139075.347310909, inner:414, outer:0
ts: 1648139076.347309378, inner:0, outer:412
ts: 1648139077.347313644, inner:0, outer:415
ts: 1648139078.347315084, inner:414, outer:0

I understand my issues may be related to SMI (system management
interrupt) which may cause the processor to enter the SMM (system
management mode) which locks out the OS. Are their techniques to
investigate (and bypass/avoid) these latency sources?

>
> John Ogness

Many Thanks, I finally feel I am making some progress after some
period of head scratching.

Gautam
