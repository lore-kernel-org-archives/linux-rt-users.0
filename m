Return-Path: <SRS0=OCyy=U3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2579C4321A
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jun 2019 10:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959EE208E3
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jun 2019 10:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICjnZK3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfF1K26 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:28:58 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41567 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfF1K26 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Jun 2019 06:28:58 -0400
Received: by mail-qt1-f193.google.com with SMTP id d17so5652191qtj.8
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Jun 2019 03:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=SGSgk0gA9Kt7i87kof0dmw6rZHV0SJK9Aui4FAJYhRE=;
        b=ICjnZK3jixYcE0a5H2kgGmQzDEue/5/HhzVKVcswefVCEYVGaqVdfG87nulRVG2/Ky
         dhDApwCDFR++69JKn5bmO3CLKjMN7c4L/zktouAijnkOMU7DWaeY/2z1JjHdEPouKRnO
         WCV2TSdxjSGWFNYW9Zyim6+vF47VkMjma9k2AOVRjFDUmocRNS6IXxlWeyBVXvPWg0EB
         CahF4kPhSfZe+eHc2CwAEZq0F8V/ED37kYOVR6ljWNhhmjdD3BFdmkHqmzChth5+K3P2
         7DHlTjABSf+jLNo57BeYIKIRw6wKVlyUmLMKkYdoP4EopwhWcTGoTs2FUFxLzuntJB9I
         JZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=SGSgk0gA9Kt7i87kof0dmw6rZHV0SJK9Aui4FAJYhRE=;
        b=NRdM8jAPzqqtrQPlKsT+P9Xwh0LFWJ+1yAJFBasPA7WKdm/k1+cWGkhYcAWQty/hiZ
         ReOHpM0IfKVjNxQDqZdM3BUMMwQYHIjwritWWxXdeNufEnTzH/R8O3zyj6vl6jGKGzcQ
         df1Anf8Cu19z5HS+KI4v2D3R7O9LoLVQbAPI/lbWs8nsgbjp65j+Ve+DbbaJ7kkre/fa
         Y/mRJ2BSR0kjYANuvw58lPi/ag9QX8Ci7nSSJwktUzJC6/hPN07Ojrl/p5hw4LP1kLMn
         ty5Fiw+f8oNoD5MErK6ufi2zRG/zSgRw1gdl3RsXwcL8XLOY17uA4hSOHrf2PUB3kXRy
         Zc6w==
X-Gm-Message-State: APjAAAVwJpwgLfE71Iot+seTwLraTIXOz1WWvfQ2c0EFag6z21q9Z/Cm
        F7ypaB31ACOeUw9U8ZoerylBv0NUNpEIxiAl/kCFCAZH
X-Google-Smtp-Source: APXvYqwbM0PKwba83WNz/+HvRToZGw/TurNCe3h7g3R0vBtwI5srrkOUVQfKf/uK8nDENLQ/u5yIevxDgHltTVKsUso=
X-Received: by 2002:a0c:8aaa:: with SMTP id 39mr7380080qvv.17.1561717737109;
 Fri, 28 Jun 2019 03:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190626161843.2c6r2dxeoxeyxce7@linutronix.de>
 <CAJjrzcVMJRya42sZbVsiiHh2dv=Wuy-OouqesfjxUMG9bK1LkQ@mail.gmail.com>
 <20190628103435.0d95ebe8@archlinux> <CAJjrzcUBU5PPSzwXwm6wD8vT_mAakE-mepN1+CQuCoPNMWwgzw@mail.gmail.com>
 <20190628115739.7fec552c@archlinux>
In-Reply-To: <20190628115739.7fec552c@archlinux>
From:   Arve Barsnes <arve.barsnes@gmail.com>
Date:   Fri, 28 Jun 2019 12:28:44 +0200
Message-ID: <CAJjrzcWdSxHoHFP1THs4_jbFGAOCfds73W0fjFkNFib97TAQ6g@mail.gmail.com>
Subject: Re: [ANNOUNCE] v5.0.21-rt14
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 28 Jun 2019 at 11:58, Ralf Mardorf <ralf.mardorf@alice-dsl.net> wrote:
>
> On Fri, 28 Jun 2019 11:28:27 +0200, Arve Barsnes wrote:
> >I don't have those other commands installed, but outside of my trouble
> >with -rt14, it's interesting that my uname output does not mention
> >PREEMPT RT.
>
> Perhaps you accidentally used the wrong config to build the kernel?
>
> What does
>
>   zgrep PREE /proc/config.gz
>   grep PREE /lib/modules/5.0.21-rt1*/build/.config
>
> show?
>
> You might have a config in /boot/ or somewhere else.

This is a relatively new box that haven't really been used much for
audio work yet, so I seem to have completely failed to set up preempt
at the moment.

CONFIG_HAVE_PREEMPT_LAZY=y
CONFIG_PREEMPT_VOLUNTARY=y

Other configs not set.

But before I removed my -rt14 config I did a diff between it and the
-rt13 config, and they were identical, so at least the config is not
the cause of my boot trouble. I might have done something otherwise
wrong though, I will try to redo the upgrade from the beginning after
the weekend.
