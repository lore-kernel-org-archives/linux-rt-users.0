Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21011C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 23:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F05E2619E7
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 23:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344652AbhI3XYS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 19:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343926AbhI3XYR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Sep 2021 19:24:17 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD15C06176A
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Sep 2021 16:22:33 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id v19so5280640pjh.2
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Sep 2021 16:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PueTiU9AjzRMozOInNHH5RkzOnZxlZzPdUQDVZXSY1M=;
        b=gXTfyDu5UhhAdYy/JTXEEoYz1pbATXuhNlX3tXrtKnwAdRUpSdQGaOlETpS3+f1IVM
         UsUk55jPRFvfQYxL2w/7zGEQxkZ23eeE7ZT81ApwDObZCSzYMWtS85aTwEr0H4hGXF2a
         nqlrksJDd+/yL8A/Pf5gu0B3P550XRfDgXuKK9lkTMF4siwZJJbaWzs5pQV5GPBjbagf
         /rZCTwE9j5rvW2OB7sFsE2tpEiwjuf+ew6VYvo46LWDA6Eoikkv+oQI6575qp4o3Oqb/
         vcvMSWNPt43d++KIlCe6YiCjOVq9b7zM/Xa5HOxt/IKcMqTiC1eiyx1sTY0/kozx8p6w
         VHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=PueTiU9AjzRMozOInNHH5RkzOnZxlZzPdUQDVZXSY1M=;
        b=Nx0e3yOFk4l/OqvEqqNqinKHrdosBOlUyBVC6ZuHLnmOwZjtfzq++YkdNWUqTReOxs
         hJu2xWVFCUBcbQ9Z/1mmWCj1ib4bjsrUMfjyIVkjFXHheqfTQhlCF87Wu+VIuZjPfMDc
         fTuzRVqjFqUYTjHmzsAUX/5ZzVQ/0Sm0Z1+yQpoqM2sGO+eozualNwja7AhXCizZ28ku
         1QkrR7Y0XSIXbFSRuWZQ36PvC7M2crjvrBtTDhkDDl0YehWKDRK36B36BL4LuGdisGUg
         AHzd3MEXyuiGdPcVZA/J1kIdusHbzwukDoT2Ex3mFwIgUtvDlTU86bpOyFbQ3e9am0GF
         cH1A==
X-Gm-Message-State: AOAM533RKxfKuPWHP7d8oQlkZSYkHxDz9qcBqXhxoAQSM6/grDL+kYhV
        r4RLt17ZMQsxU8ovxacAs7s=
X-Google-Smtp-Source: ABdhPJwcyqzvJ0fFaUmM190y+wHnHAEQb+Mt5rqLfORgC6hcpy5mhO7Pvgi+jtbPHjAdj7qLSTsp8Q==
X-Received: by 2002:a17:902:ea09:b0:13e:416f:549 with SMTP id s9-20020a170902ea0900b0013e416f0549mr6528376plg.43.1633044153341;
        Thu, 30 Sep 2021 16:22:33 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id b8sm4017196pfi.103.2021.09.30.16.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 16:22:32 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Pierre FICHEUX <pierre.ficheux@smile.fr>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Strange problem with PREEMPT_RT
References: <CAFc1U0sgMtKvcpTWkyjwXsq3Md_Huew7mSye_AratkM63D6K-Q@mail.gmail.com>
        <87y27e53a2.fsf@stealth>
        <20210930132319.eixnv6rb66ui6x6j@linutronix.de>
        <87v92i9o5t.fsf@jogness.linutronix.de>
        <6034cc70-fb69-d9d-ce31-673d4d42adc@redhat.com>
        <87pmsq9kdd.fsf@jogness.linutronix.de>
        <49773379-4c5b-b6be-5125-9884e2b364aa@redhat.com>
Date:   Fri, 01 Oct 2021 08:22:29 +0900
In-Reply-To: <49773379-4c5b-b6be-5125-9884e2b364aa@redhat.com> (John Kacur's
        message of "Thu, 30 Sep 2021 12:16:23 -0400 (EDT)")
Message-ID: <877dex4pje.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

John Kacur <jkacur@redhat.com> writes:

> On Thu, 30 Sep 2021, John Ogness wrote:
>
>> On 2021-09-30, John Kacur <jkacur@redhat.com> wrote:
>> >>>> With hackbench, the system is sufficiently busy to avoid the going
>> >>>> into idle.
>> >>>
>> >>> Not just that. cyclictest's usage of /dev/cpu_dma_latency has the side
>> >>> effect that it may disable some of the PM stuff in the system.
>> >>> So your system appears good but then when cyclictest is gone, the
>> >>> numbers go up.
>> >>>
>> >>> Maybe we should drop that so we observe a system without altering its
>> >>> behaviour?
>> >> 
>> >> +1
>> >> 
>> >> Developers wanting to explicitly cause this behavior can use --latency=
>> >> to enable it. Having it on as a default is misleading.
>> >
>> > Where does this "--latency=" option apply to?
>
> I see this option was dropped from the help, will add it back.
>
>> 
>> It is the value written to /dev/cpu_dma_latency, which AFAIK writes the
>> maximum acceptable latency (in microseconds). This translates to the
>> allowed C states. cyclictest currently writes 0, which should keep the
>> processor in C0. For example, setting it to 1-5, should allow C0 and C1.
>> 
>> Using --laptop will cause cyclictest to avoid touching
>> /dev/cpu_dma_latency. But nobody would know that unless they looked at
>> the code.
>> 
>> IMHO, systems should be configured for production use and cyclictest
>> should just _measure_ latencies at a specified priority level. But by
>> default cyclictest is adjusting global system behavior during
>> measurements, thus providing results that the system (as it is actually
>> configured) would not be able to provide.
>
> The thing is, we are not just trying to measure an environment, we are 
> also simulating a realtime application. If your realtime environment 
> doesn't disable c-states, then your realtime application probably
> should.

I agree something (firmware, OS, application) should disable c-states -
cyclictest doing it during measurements hides the fact that the system
isn't configured correctly for applications requiring low latencies.

I do too lean towards "altering system behaviour is better left outside
the application" as different system have different knobs and need
different tweaking to achieve low latency.

> It's always a question of are we trying to measure a worse case scenario 
> or a best case scenario.
>
> If I remove this default we're going to get a slew of reports from people 
> using cyclictest wondering why they aren't getting good realtime 
> performance.

Perhaps, this is a change best done with a major version bump. Not that
it'll stop users queries completely but hopefully more people will pay
attention to the changelog.

[...]
