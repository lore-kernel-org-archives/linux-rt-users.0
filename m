Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB345C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jun 2022 09:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiFXJMk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jun 2022 05:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiFXJLn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jun 2022 05:11:43 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070AE506FE
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jun 2022 02:11:32 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-317a66d62dfso18578437b3.7
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jun 2022 02:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hyQTQAZ3XspXZ2sNGfDrWiLVGkHDYE8Iizv5qBaCQ7M=;
        b=TOhxDmh99benkapwOPP1Vgc4LsXNE+kloHuSM8IdSWkylfk/3hETxVTBFVs7Fh06eC
         GFe4C/bUD38yyLECbYxUgEXNtM8hFsS3k2HQfdLceSDHpAA3MMMsEmSQcFJB7uw3LrqZ
         FLpdH9vMsVcEuQJ5uN2bVjt3UcQ6ah7H8qKCzT68Z0Uqpw5VcWxaIr6NsJeknwTDYExm
         sRO8sA5/7d4p9kSDGjso7UICc1o4vUOZFXdl10XfjhcrfLKo1fJPWjXH/P+Gb1OuDWgN
         n3O5o1sBub2MnFQecqSdQl+kfJ1oAO+ysXhkgJh69A7gdv4fP4BWtkhc90yT520LKsv0
         F9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hyQTQAZ3XspXZ2sNGfDrWiLVGkHDYE8Iizv5qBaCQ7M=;
        b=WRq0nL+v+wAELtJak+V6f9oNZp3nB33wa2ZJBWbvLps2EATU5/JK1Tk/TljQmOYr/A
         iQq7ZyRtTGStXBUIo1Y/IwKbsshPZqUcd5vkuIq0Z8CXqs08oV5QgfpprQMuUSo5Yfnx
         QGWV4dgX3JSsj7QgZvyMocjBGPyDQVtKwhvZ5YH/KOnAk/xPJZvctfrpkLSdjPxXcydM
         Zk0WBcV3IEtrrj/bbkqaPum3znxhL1OAJ95izAQewGaiygjnzLo0cuUphLRL+Zigz9WZ
         NQs8bC+rSmOyb+TwsEuEZwFE9mPUpu4k/PTv7cbXCbyc2R3cjtnDhERCEVncmjWCHakP
         Klbw==
X-Gm-Message-State: AJIora+ypFPwK//ZPc0CGghyw5FPqQTy9iSVbwCUzv19uTtx6vYObqPi
        QNfKu4VER51V9VV9mZdAtnBe4gZhZ4hexWICHmPl8w==
X-Google-Smtp-Source: AGRyM1t0z7szJRVjWdzYUDsqDUDAmhnzvKGAy+wXiedIkqLNud1wmzm+gu6WHYjZLm3KELgD7m+IFv5YSiXKooaleU0=
X-Received: by 2002:a81:574c:0:b0:317:7c3a:45be with SMTP id
 l73-20020a81574c000000b003177c3a45bemr15686171ywb.316.1656061891170; Fri, 24
 Jun 2022 02:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <bf74019da22b3c6a750153cbc74ffe3fcdb0ddf7.camel@gmx.de> <YrV+Vu47VDGDQpx8@linutronix.de>
In-Reply-To: <YrV+Vu47VDGDQpx8@linutronix.de>
From:   Marco Elver <elver@google.com>
Date:   Fri, 24 Jun 2022 11:10:55 +0200
Message-ID: <CANpmjNO+4uHo8sECw4e+hANQSHP+5UmFrZ2TgeRCsu2iuowYfw@mail.gmail.com>
Subject: Re: v5.19-rc2-rt3: mm/kfence might_sleep() splat
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Mike Galbraith <efault@gmx.de>,
        RT <linux-rt-users@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 24 Jun 2022 at 11:05, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-06-18 11:34:51 [+0200], Mike Galbraith wrote:
> > I moved the prandom_u32_max() call in kfence_guarded_alloc() out from
> > under raw spinlock to shut this one up.
>
> Care to send a patch? I don't even why kfence_metadata::lock is a
> raw_spinlock_t. This is the case since the beginning of the code.

Because kfence_handle_page_fault() may be called from anywhere, incl.
other raw_spinlock critical sections. We have this problem with all
debugging tools where the bug may manifest anywhere.

A patch for it already exists in -mm:
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-hotfixes-stable&id=327b18b7aaed5de3b548212e3ab75133bf323759
