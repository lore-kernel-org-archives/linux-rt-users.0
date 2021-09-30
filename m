Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40473C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 23:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D9161A54
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 23:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349550AbhI3XDF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 19:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349211AbhI3XDE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Sep 2021 19:03:04 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D31C06176A
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Sep 2021 16:01:21 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id rm6-20020a17090b3ec600b0019ece2bdd20so5924864pjb.1
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Sep 2021 16:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9vOPd9p2sd2d5v3RKmdTOej6hGK2t+WyJK7sVM7hvPk=;
        b=IA50Zs+XENq30rumhrSEpk/N3Dkrvx1ZcG8lzIh1ovCMxCct4KYwNtozmgXm334u+2
         7cxt6KZy4ilMhwmxXwjbb7fl2U6KDIGExIb3afH2+t6yES0uSJSNUqRYxlbB8/capnjm
         vCT2K8bmqBWYYjJ3c1dEnCAQ+1C2QnVwGfk0h5tw2JwS/tYxSeP/IZB7c3jyT94JuVyc
         g8mYo5xbG5hZNs/Yql9LtrTMbVtNr39zjSdyUtaZqa5+ORDX56il3tudKqYSrQ9nrCyB
         1DL9hZNte0iMwPbDLshR4hp/97TKqa+z5t4pNfsZvuDniWeGow+6zu2Y2IFj1brssMUW
         q5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=9vOPd9p2sd2d5v3RKmdTOej6hGK2t+WyJK7sVM7hvPk=;
        b=dqR3h/jSO3JYhZvbnxY8kNT3kysewLKY1MsGyuKyciu2uKZFnPQ5qjKF4UzpGWrClq
         aTqVd3qMxeblvu8qY+xZiR2CcliK0eQbG6X9q//DK9X6D0sANglRTY2ccw7/JVd4b+Th
         USchyc4HwPcrrFIhf2yvBxxsQrr4PthXhozkurykFAbDmdmp9GfA6kfMDAJIOz9/UrN5
         PVEhSHg2PsmdruJ3eS6dArWUdnp0RSBYVmUbuFZbPmQrf5rqgIYjTr0XUIPzYj8m/mI/
         mOj+wDGzTKJirlnFgIqG/GmkA2Obgvyr22EwkHsQe+vzVG0id8VECFNmiEKftYQOwuuO
         G7AQ==
X-Gm-Message-State: AOAM5307ZDGLwY/iW7wrHnaXWO2K39Nluklu5WbdLVvS4Gecg7Sz0Xkx
        FQ5SwKKc62rk7DrW7kQCaWk=
X-Google-Smtp-Source: ABdhPJyL5nqcR29TQOGUxCl98w4FdQK/FDJIzij9glIp0eSSkob6p+XDECNFpktJYhbUxjVZymcURQ==
X-Received: by 2002:a17:902:868d:b0:13d:dfa7:f3f2 with SMTP id g13-20020a170902868d00b0013ddfa7f3f2mr6691151plo.30.1633042880914;
        Thu, 30 Sep 2021 16:01:20 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id g15sm4088845pfu.155.2021.09.30.16.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 16:01:20 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Pierre FICHEUX <pierre.ficheux@smile.fr>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Strange problem with PREEMPT_RT
References: <CAFc1U0sgMtKvcpTWkyjwXsq3Md_Huew7mSye_AratkM63D6K-Q@mail.gmail.com>
        <87y27e53a2.fsf@stealth>
        <20210930132319.eixnv6rb66ui6x6j@linutronix.de>
Date:   Fri, 01 Oct 2021 08:01:17 +0900
In-Reply-To: <20210930132319.eixnv6rb66ui6x6j@linutronix.de> (Sebastian
        Andrzej Siewior's message of "Thu, 30 Sep 2021 15:23:19 +0200")
Message-ID: <87h7e14qiq.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2021-09-30 09:13:25 [+0900], Punit Agrawal wrote:
>> With hackbench, the system is sufficiently busy to avoid the going into
>> idle.
>
> Not just that. cyclictest's usage of /dev/cpu_dma_latency has the side
> effect that it may disable some of the PM stuff in the system.
> So your system appears good but then when cyclictest is gone, the
> numbers go up.
>
> Maybe we should drop that so we observe a system without altering its
> behaviour?

+1

For users tuning their system it doesn't help if the reported numbers
are not reproducible when running their application.
