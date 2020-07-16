Return-Path: <SRS0=vtwn=A3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E509C433DF
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Jul 2020 20:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A8C20787
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Jul 2020 20:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8xwJpe/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgGPUkF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Jul 2020 16:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgGPUkE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Jul 2020 16:40:04 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D7FC061755
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2020 13:40:04 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id p6so2188835uaq.12
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2020 13:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y796mvA2LbqLQ1fo8H+s0ezwp/Sorje1+A6mNhuW49I=;
        b=U8xwJpe/nzSLuHDZieyA3ch4Qshav8Ohuz/wMMjFcE1xc6CZCAW9fFUcWshndIbyKM
         mHbgo+to0KjZHV7Mil7j7y9119wiYQmXQjRJtwCdKeyhZQFmP39IEE47kKD5vVd1+xoV
         3ZROrhuKRzNPwLAIRqZ52Qi/MmZo/csJrvtS9lOjLs4lDYa4+F/8YXCMxXYR2onp1m57
         AakueOa5YpYb3XM2LiavSI3D5qcqcVRr8WGkRGBnLH5uRxx3lR2iq4ni9g9nXsFhf4TL
         Wyok/o5r08Nn2+V1CVQLJ5D26H6/zbv7lQ/5QR/xWahjYUW1hSHsfCqxwwFuNVtg9pCm
         qJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y796mvA2LbqLQ1fo8H+s0ezwp/Sorje1+A6mNhuW49I=;
        b=VvYuK/0D9hCZuOOYiOEL0QDEHzGeWY549qzc5/ffLHtVTyK0RPVTGdW+ufjOL6JoBB
         HQkRmL4oDBEKFis3LkrvC4JFSEJfKrzbRQSr83eLeGO9xQmEKNiEo6D0WrI8FbiBp3Ng
         UpT7Vn9mNJJPXwkb6cbcoIHIQk8i/GxyMHolgIYsZ5wx+1ZJZuExkR2xMegdmWvAOJ+S
         AG78SQmJW+TzCw+UXZegaNM6Oe8/GxTbWfY2M+xyriJ01rr2iCOxFVJciT3WhLZJ0Dg8
         qWvVKuFJMKe09iOsuPQDZoz87JfvznJLXSeR6+kkmguaEXFGwfjykaWTPElRgBgtIaA3
         eodA==
X-Gm-Message-State: AOAM533bg2A2wV3qX8NGszgXp+MIqqQeB7lE4ltVXMyXupJ45ujvNvJM
        +cvePIPUs4bW2HJmjI9rSe3bPrm14RpU9HGEcoZ2Fw==
X-Google-Smtp-Source: ABdhPJwbfNxf+djXrErH2ZXkEoEz8jzBY7T8qLdKIcOvujCAB9dRu8kDfPS0gVKQL7AjlH5B2FlmjiDUeHTxIU2Bg9I=
X-Received: by 2002:ab0:4a45:: with SMTP id r5mr5012373uae.93.1594932003601;
 Thu, 16 Jul 2020 13:40:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:fd69:0:0:0:0:0 with HTTP; Thu, 16 Jul 2020 13:40:03
 -0700 (PDT)
In-Reply-To: <CAKkbJ-wDsGO+ZHKZFkPfUL113ONc=NNNeShQkLf+ZH82iaBTEQ@mail.gmail.com>
References: <CAKkbJ-yB4XGuexzmwfkR8g76HR8iCkXaHsXaLaS6V+Wfy86bvg@mail.gmail.com>
 <CAFpOueQm5MhbrV53=kAcw=ES2LzsZPkmX2SqTVKuYTf0QDt=7w@mail.gmail.com> <CAKkbJ-wDsGO+ZHKZFkPfUL113ONc=NNNeShQkLf+ZH82iaBTEQ@mail.gmail.com>
From:   Itai Handler <itai.handler@gmail.com>
Date:   Thu, 16 Jul 2020 23:40:03 +0300
Message-ID: <CAFpOueRmx19j3ay9F==6WK18rMd=8uVP772rR-0_Bo2JT85d-Q@mail.gmail.com>
Subject: Re: Serial port driver usage and status
To:     Michel Macena Oliveira <michel@austral-dynamics.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Michel,

On 7/16/20, Michel Macena Oliveira <michel@austral-dynamics.com> wrote:
> Thanks for the answer,
> Yes I wrote a code that works with  /dev/tty* serial using termios.h.
> I thought exactly what you suggested, to use a dedicated thread, but
> how to properly implement it?
> I mean in a simple way, just need to put open and write calls inside
> the high priority (RT) thread?
>
> Current kernel: 4.4.208-rt198 #1 SMP PREEMPT RT

I believe that if you need low latency rx, you will have to patch the kerne=
l.
I=E2=80=99d recommend you to read https://lkml.org/lkml/2019/1/10/595

Itai Handler
