Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9408DC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 00:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 777C561528
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 00:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345040AbhI3APO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Sep 2021 20:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhI3APL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Sep 2021 20:15:11 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6784C06161C
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Sep 2021 17:13:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id oa12-20020a17090b1bcc00b0019f2d30c08fso3399395pjb.0
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Sep 2021 17:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=95JsvCzQiPnDRFbySU6C/Kkfi9kUM94rpQI/r+qt14k=;
        b=n0uX4a+d1zqvxku2qxe047HVIkzuvrY49x0HqAt+BFXZEmzvgrWLA+n3nWc7KpcVRr
         mVhBenUF++JtA4deODUi/DfWA/lqIZe+I3iwNtyGh+PG2VVz9KmU3YhsQsg3Uqct6Xe/
         WsSjEbIZyImwlAkSTNoFarEYvWdJy0PdgXNFrCWwhtTAu1RUWF6sS8YKfwLZQdd6/Tft
         f9IhdD+7GjYtd7suO4qRFPd+oxqJ3i14DtWVS3LY7z8cVXeZgzWMs2sAP9vgPJnxFNUo
         Cp2u+CaQNMuKW04md6nlmrTrPWN8lLetgybZq1sNhSN5jI9AnZppIH3/PLrt3LHB+E4G
         4RXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=95JsvCzQiPnDRFbySU6C/Kkfi9kUM94rpQI/r+qt14k=;
        b=wDuWB1WmgBiQf3FJvZR4E/1F/Tg+Z29XYJdIHmdBFAxGUzwf8lr+q+M72l0HJlh54v
         0NxA2E52cGpUBYamZfNukE/+Y7kDSyaSZG0aWVYQnxv1lz5mQLOJ6UvagH+3n8svh/kA
         sxjzvTHvO2Gy6gFEuvT6JiefDnKwWfUoF9I4/Z8zmI730XBXQYDQ4odW0Rzt/LTSD/EX
         cytuOiV5sXOKKUd78IovmKlNB7AiAkQRSVyguEmqEio/g8XaDIW5LRp3FrYU1A2CbyCp
         XgCXT9d89lz6NZ9cFjHSCDkp+8yUGAxUdq33iTYiYq5y76ABr6S+JLw9sLx37qHR3v9b
         vzkw==
X-Gm-Message-State: AOAM533YP1+o63LNca3peX7jvZuzkxL5Ia/tLGVTOhKYlFtATmNsSpdc
        8BwUOVY/FloL7ouTG/GHDQhgDyIwxFA=
X-Google-Smtp-Source: ABdhPJzRqkXQz+Vy3PCfd4/29W31OenJEj+1d4Cjvgwy5sAYDRaarVkZTzKqzQRwPrTbBgGsLV4B5w==
X-Received: by 2002:a17:902:d507:b0:13e:1145:b1cd with SMTP id b7-20020a170902d50700b0013e1145b1cdmr2505957plg.19.1632960809246;
        Wed, 29 Sep 2021 17:13:29 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id c199sm792149pfb.152.2021.09.29.17.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 17:13:28 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Strange problem with PREEMPT_RT
References: <CAFc1U0sgMtKvcpTWkyjwXsq3Md_Huew7mSye_AratkM63D6K-Q@mail.gmail.com>
Date:   Thu, 30 Sep 2021 09:13:25 +0900
In-Reply-To: <CAFc1U0sgMtKvcpTWkyjwXsq3Md_Huew7mSye_AratkM63D6K-Q@mail.gmail.com>
        (Pierre FICHEUX's message of "Wed, 29 Sep 2021 18:40:35 +0200")
Message-ID: <87y27e53a2.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Pierre FICHEUX <pierre.ficheux@smile.fr> writes:

> Hi,
>
> I have a strange problem on a PREEMPT_RT system.
>
> I have a process with 2 threads,
>
> - 1 TR thread (10 ms period) which places 350 KB blocks in a fifo (1
> block every 10 ms).
> - 1 non-TR thread (SCHED_OTHER) which reads the block in the fifo and
> writes it to the disk
>
> If I run this on a powerful machine (HP Z4-i9, 14 cores, NVME disk,
> CentOS 7 with 3.10 PREEMPT_RT kernel, yes that's ooold), the max
> jitter WITH hackbench remains around 20 to 30 =C2=B5s while the max jitter
> WITHOUT hackbench goes up to 350 =C2=B5s!
>
> -> hackbench -p -g 20 -l 10000000
>
> Running the program with  taskset 01 doesn't change anything
> If I don't write the data to disk it doesn't change anything either.
>
> The important jitters appear rather at the beginning (but sometimes also =
later).
>
> Any ideas ?

Is power management (cpuidle, cpufreq) enabled on the system?

One possible explanation -

The load from the 10ms task, isn't high enough to keep the system at
high-frequencies or prevent it from going into deeper sleep states. Both
of these can impact latencies.

With hackbench, the system is sufficiently busy to avoid the going into
idle.

>
>
> thanks by advance
>
> --
> Pierre
