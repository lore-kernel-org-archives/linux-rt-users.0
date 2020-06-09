Return-Path: <SRS0=w7Cs=7W=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F221FC433E1
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 17:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14CA2078C
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 17:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="veUV+ht9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgFIROk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgFIROk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Jun 2020 13:14:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BEFC05BD1E;
        Tue,  9 Jun 2020 10:14:39 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q25so3971910wmj.0;
        Tue, 09 Jun 2020 10:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=f3UvWDv1CED4jjUBqfRfvM4oSFQYy/OmmaaawbFwR7s=;
        b=veUV+ht9l73/oX3+ycrz/bBlorQG2HNViwYtfEsR+hoUBp98MskBl92OV3m2r2ntnK
         Edmq2USqPcgtpPVBFyKAjjmTha8otuWUyCVLA26w72N7hmJEKBzot8HuDn6WD0iZiGmI
         mT+P4B3yzAaMq+wGAH2OkjMHtIxXGug7SeKyr2+VxGSOKZUKqg84Xa8Xb6LdcgICcu3d
         u5pkEHa7nT7vbXOF1KpiULq2DkPWo7xqRoRQeLnpXFFDRywMv+6FLElb5KgLL81XawHB
         HzULX1avffZOADHWSpbLh1oJOX2U0b5MzXJVSBSlp25mRwPR/S0vSDrLawbI8inf58Yz
         Ptww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=f3UvWDv1CED4jjUBqfRfvM4oSFQYy/OmmaaawbFwR7s=;
        b=Yl5z0lejg/4Ve/26WHkcSvIXEUqEJe5d1LFsfV4d6fuJLtBdDoCHyZYWl9nhPD3m+v
         RCW9S5H6xurv1WDaQT1ahIFD3FabWGUIHINcQJONmTfJ7dXHU13aoztDtjmIBTPqp+Mr
         qEjAKiFVFqqaRgguKKr6f/jtB6E5+l7W2pHlskbzzFEAylmlQZrKMzrM/soTQToUDmiV
         Lq1h04LCvGoIWOJ3xHC2xJ8u2UoKUWGnDvx7zA42mN3EQbvQ1JKH8nEAow0yGxzvVROp
         xZYT94OnI5u6B+Q6+e0WzbbUFhI25Oq6eqVO6zd7OxIatuSjYA0hQLW3iCb9grkAtA+E
         0m/Q==
X-Gm-Message-State: AOAM533gR9d63/9HX96OANIHubGpr4a7RQ5v/z41luEyc78xa03UhBov
        08YGD5oZLfY1g6opTmZ4wWxgdB6lx0o=
X-Google-Smtp-Source: ABdhPJyUqGUJRmoCdD03M+OpkyV/seYw6pQTXZjuV0Rx1+PHZsHa+nEHQVo/mwBxnxyHJhyxawuvqQ==
X-Received: by 2002:a1c:2d83:: with SMTP id t125mr5225943wmt.187.1591722878556;
        Tue, 09 Jun 2020 10:14:38 -0700 (PDT)
Received: from [192.168.68.104] ([89.237.74.3])
        by smtp.gmail.com with ESMTPSA id b201sm3436985wmb.36.2020.06.09.10.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 10:14:38 -0700 (PDT)
Date:   Tue, 09 Jun 2020 20:14:34 +0300
User-Agent: K-9 Mail for Android
In-Reply-To: <20200609171043.vhvms7lowffqm6e4@linutronix.de>
References: <6d4c92b28c54d8ca687c29043562de943a373547.1587675252.git.zanussi@kernel.org> <CAGi-RUKn6k98H5v9kw7je1MChb4+Uq8EGhKO0nuXNMBy9M1_qw@mail.gmail.com> <b5026121af44601e4318479194357fdb956982f6.camel@kernel.org> <20200609154741.5kesuvl7txz4s3yu@linutronix.de> <e288ef193f743782df48667b6b03122bd025119f.camel@kernel.org> <20200609163446.efp76qbjzkbtl7nk@linutronix.de> <D6892A4E-18F7-4EB7-BA09-BD4DF9079BDE@gmail.com> <34E6C220-A85B-4296-AB8E-62DE6D9DC561@gmail.com> <20200609164213.bshzpfuqgioyvtpm@linutronix.de> <61D63A44-E3D9-4E7F-BE08-B887C078F445@gmail.com> <20200609171043.vhvms7lowffqm6e4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RT 1/2] tasklet: Address a race resulting in double-enqueue
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Tom Zanussi <zanussi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Zhang Xiao <xiao.zhang@windriver.com>
From:   Ramon Fried <rfried.dev@gmail.com>
Message-ID: <50AE5644-D046-4043-8A70-204D0BFEB67F@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On June 9, 2020 8:10:43 PM GMT+03:00, Sebastian Andrzej Siewior <bigeasy@l=
inutronix=2Ede> wrote:
>On 2020-06-09 20:07:06 [+0300], Ramon Fried wrote:
>> Indeed
>>  I'm truly sorry, I thought our crash kernel is configured as RT as
>well=2E=20
>> so, as I understand, if I build the RT kernel without preempt enabled
>I can hit this bug?=20
>
>Don't worry, I should have been better with the details in the log=2E
>
>So you should _always_ hit the warning/bug if you compile a kernel
>without SMP and RT=2E If you enable one of these then everything should
>be
>fine=2E
Would there be a fix for that?=20
>
>Sebastian

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
