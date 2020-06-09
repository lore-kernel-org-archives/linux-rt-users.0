Return-Path: <SRS0=w7Cs=7W=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5F5C433E0
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 16:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 361562078C
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 16:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFSMz8N4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbgFIQkL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731074AbgFIQkK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Jun 2020 12:40:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FD3C05BD1E;
        Tue,  9 Jun 2020 09:40:08 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u26so2720514wmn.1;
        Tue, 09 Jun 2020 09:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=7Y2ExY85BoPcedn5x6S+ytoOXLcWpABh59ie+XkypSE=;
        b=nFSMz8N49ggw5MrKrz8g8uHEyHih78bK1Js/RnT8JimC+Fk4PuQqv96QldQ19q9ADH
         hzKLxDLVb1viYVoYf25mzUkb+XYvBuw8yTlyj6p5au5dLXMxNcDJCvqp4Jj3Jikn8xgv
         VvH7O7WZtSKg31WbucAhzlYkkUYxZ+fx1QCJK7+SPW5enr0R4FLaypU3fmTQR3UTzeLB
         fAN4PcVpqfrXGBswNRJvW4cBCOOsz4fhGW8Tm11KpqejoBgju5JH/yqRJmBYzmuVBs57
         W4ROQ63G6KgPUthUSwzRKZj6TUcbc7176ko9eCjaR3CMtGkKRmkeptehWxvFPCdb5Nw0
         rdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=7Y2ExY85BoPcedn5x6S+ytoOXLcWpABh59ie+XkypSE=;
        b=QsVoj/nbDx8HjA40YoiwWsprm1EKA78sXrqOeHORHFov05fZ7kRgSWqFsy7ENsPfXG
         c9JkE6e2Ku9Gub+Vp6zu8x9jhlpYJegQ6wDkY5lqW4wvSe2nBClEdv/bdEg/O9tjiTki
         4M55feRlTkoIUAeZxTreJP1oUKgHS2a228KJtMxB62OsUgTuG5IeE9ezjgaNm9e0DyVT
         Uc9aEYvtZMBTXAHrYvG4XURKda2hYUK6MEFIuMopGeJGKdi8Qj+hdrxCFHfhg3I10g1F
         M6MFNotJ4mRQKYjU5KoqiQBB+ntYO6WWefoK2e+WdfJeaO4ziI0CJDesCWAQPYjEYr5V
         YDtQ==
X-Gm-Message-State: AOAM533weyCtKeWXhlRziKHsDpF4jJAEl1gVvYMbN9rjQ7i/ZPSP+ySN
        kYqDAfv0VsirCo4LuC8w2xY=
X-Google-Smtp-Source: ABdhPJx66+0aIpQmFRhtjz67aBZc3TeSJXFEsU0xG2C4YryZonJ99z543J+Oj+VxfkEl4HJFaceMLg==
X-Received: by 2002:a1c:bd86:: with SMTP id n128mr5209884wmf.5.1591720807292;
        Tue, 09 Jun 2020 09:40:07 -0700 (PDT)
Received: from [192.168.68.104] ([89.237.74.3])
        by smtp.gmail.com with ESMTPSA id z2sm3872754wrs.87.2020.06.09.09.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 09:40:06 -0700 (PDT)
Date:   Tue, 09 Jun 2020 19:40:03 +0300
User-Agent: K-9 Mail for Android
In-Reply-To: <D6892A4E-18F7-4EB7-BA09-BD4DF9079BDE@gmail.com>
References: <cover.1587675252.git.zanussi@kernel.org> <6d4c92b28c54d8ca687c29043562de943a373547.1587675252.git.zanussi@kernel.org> <CAGi-RUKn6k98H5v9kw7je1MChb4+Uq8EGhKO0nuXNMBy9M1_qw@mail.gmail.com> <b5026121af44601e4318479194357fdb956982f6.camel@kernel.org> <20200609154741.5kesuvl7txz4s3yu@linutronix.de> <e288ef193f743782df48667b6b03122bd025119f.camel@kernel.org> <20200609163446.efp76qbjzkbtl7nk@linutronix.de> <D6892A4E-18F7-4EB7-BA09-BD4DF9079BDE@gmail.com>
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
Message-ID: <34E6C220-A85B-4296-AB8E-62DE6D9DC561@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On June 9, 2020 7:37:31 PM GMT+03:00, Ramon Fried <rfried=2Edev@gmail=2Eco=
m> wrote:
>
>
>On June 9, 2020 7:34:46 PM GMT+03:00, Sebastian Andrzej Siewior
><bigeasy@linutronix=2Ede> wrote:
>>On 2020-06-09 11:17:53 [-0500], Tom Zanussi wrote:
>>> Hi Sebastian,
>>Hi Tom,
>>
>>> I did find a problem with the patch when configured as !SMP since in
>>> that case the RUN flag is never set (will send a patch for that
>>> shortly), but that wouldn't be the case here=2E
>>
>>How?
>>
>>| #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
>>| static inline int tasklet_trylock(struct tasklet_struct *t)
>>| {
>>|         return !test_and_set_bit(TASKLET_STATE_RUN, &(t)->state);
>>| }
>>
>>I can't tell from the backtrace if he runs with RT or without but I
>>assumed RT=2E But yes, for !SMP && !RT it would explain it=2E
>PREEMT_FULL is enabled=2E=20
>I'm working on getting symbols for this trace, this is a crash kernel
>so everything is stripped naked=2E=20
>Thanks, Ramon

Correction=2E normal kernel is running with RT enabled, crash kernel witho=
ut=2E=20
>>
>>> It would help to be able to reproduce it, but I haven't been able to
>>> yet=2E
>>>=20
>>> Tom
>>>=20
>>Sebastian

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
