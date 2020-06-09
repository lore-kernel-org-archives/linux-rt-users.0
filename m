Return-Path: <SRS0=w7Cs=7W=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9ECC433E0
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 16:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE6652078D
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 16:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2vDHKH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbgFIQij (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgFIQii (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Jun 2020 12:38:38 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DD7C05BD1E;
        Tue,  9 Jun 2020 09:38:37 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j10so22054654wrw.8;
        Tue, 09 Jun 2020 09:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=JGOr7cNh6uCeD4dtTcDluZBxMbP7WaDzdeSNEuXTGcU=;
        b=p2vDHKH+IxUEftaejbslDeV11CmtoMQVS1oa3R39vPrvYVcrxIfLcqo227SnbF0pGR
         bIwmkyvu3Azig75yT0F8Zt3tWOP8SDTGVM8tsyWmrRdYVijWjpJlzMsnH6T1PH3JP/T+
         T7yqoOO9AcUx7iIwcTWOX87rmVkGLAQQdzJhlSCx+emet9VAinRyVJaLvhWBPDX1HR5B
         n8lEWOMBsFbdWaXohWbr8GRgoneve4gEDrqNgUD3Cw++Ao4HoYXA/Q4p+8i69k2i54bS
         rfCi6jNtnb+5ADCCimJZ/cOo4pMK15VQ5zbz6U92DpZfxbaBcRj+/3LzgJBu1HKXFlnH
         A0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=JGOr7cNh6uCeD4dtTcDluZBxMbP7WaDzdeSNEuXTGcU=;
        b=BbeUsyqM3jkjs4FVmzBVIuqq/lKdEaSkymStVIVaHET6D1dwp04gulLYJuetdo1aRz
         qnXpembuauPYmT+y38FuT/ciJobXptcDS5LnuMWx14Tn6HD7Z/QqPfBkDbAEaPGKHhCH
         VOgZxdJA7ICxG1N/cOQP29J5SNm2cV96XSkVYuzelgoR9w+L4+hgYC8414JmuD5/Xzxq
         NdKaC/BiMVgw1fAWah+CVdFQMdL+n8XOwzyJMtCTyeZHxKLT//T2SvTk/Opq228ML8i0
         d7j8a11sNr6dKsioMyHn0/9F4fChPCTfncy16SZcTMBOgPv2km4n7eFjLXb5yH51fGvB
         ZjIg==
X-Gm-Message-State: AOAM531Quy9o+MjpUruz+tv1QlTKYXF5wknNvTRU1Kp74nyQi7a5jrQy
        d+u27ZA9hrY6iVlX3tsqTsLTAPg7/uc=
X-Google-Smtp-Source: ABdhPJwyATQekg8AU8SwKm3IdsP31GHM3iVGFzK0iWxf85tYd1O5Jm98/uYV/IIg6qE7kp+HkZzWKA==
X-Received: by 2002:adf:bb02:: with SMTP id r2mr5676730wrg.143.1591720716302;
        Tue, 09 Jun 2020 09:38:36 -0700 (PDT)
Received: from [192.168.68.104] ([89.237.74.3])
        by smtp.gmail.com with ESMTPSA id r5sm4180693wrq.0.2020.06.09.09.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 09:38:35 -0700 (PDT)
Date:   Tue, 09 Jun 2020 19:37:31 +0300
User-Agent: K-9 Mail for Android
In-Reply-To: <20200609163446.efp76qbjzkbtl7nk@linutronix.de>
References: <cover.1587675252.git.zanussi@kernel.org> <6d4c92b28c54d8ca687c29043562de943a373547.1587675252.git.zanussi@kernel.org> <CAGi-RUKn6k98H5v9kw7je1MChb4+Uq8EGhKO0nuXNMBy9M1_qw@mail.gmail.com> <b5026121af44601e4318479194357fdb956982f6.camel@kernel.org> <20200609154741.5kesuvl7txz4s3yu@linutronix.de> <e288ef193f743782df48667b6b03122bd025119f.camel@kernel.org> <20200609163446.efp76qbjzkbtl7nk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RT 1/2] tasklet: Address a race resulting in double-enqueue
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <zanussi@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Zhang Xiao <xiao.zhang@windriver.com>
From:   Ramon Fried <rfried.dev@gmail.com>
Message-ID: <D6892A4E-18F7-4EB7-BA09-BD4DF9079BDE@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On June 9, 2020 7:34:46 PM GMT+03:00, Sebastian Andrzej Siewior <bigeasy@l=
inutronix=2Ede> wrote:
>On 2020-06-09 11:17:53 [-0500], Tom Zanussi wrote:
>> Hi Sebastian,
>Hi Tom,
>
>> I did find a problem with the patch when configured as !SMP since in
>> that case the RUN flag is never set (will send a patch for that
>> shortly), but that wouldn't be the case here=2E
>
>How?
>
>| #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
>| static inline int tasklet_trylock(struct tasklet_struct *t)
>| {
>|         return !test_and_set_bit(TASKLET_STATE_RUN, &(t)->state);
>| }
>
>I can't tell from the backtrace if he runs with RT or without but I
>assumed RT=2E But yes, for !SMP && !RT it would explain it=2E
PREEMT_FULL is enabled=2E=20
I'm working on getting symbols for this trace, this is a crash kernel so e=
verything is stripped naked=2E=20
Thanks, Ramon
>
>> It would help to be able to reproduce it, but I haven't been able to
>> yet=2E
>>=20
>> Tom
>>=20
>Sebastian

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
