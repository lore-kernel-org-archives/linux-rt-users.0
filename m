Return-Path: <SRS0=yCAb=37=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F1DC352A3
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Feb 2020 15:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9097D20714
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Feb 2020 15:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=unikie-com.20150623.gappssmtp.com header.i=@unikie-com.20150623.gappssmtp.com header.b="v4FATYOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgBKPw4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:52:56 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46703 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbgBKPw4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 Feb 2020 10:52:56 -0500
Received: by mail-ot1-f66.google.com with SMTP id g64so10507471otb.13
        for <linux-rt-users@vger.kernel.org>; Tue, 11 Feb 2020 07:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YGFR7KimUjNoXQNtvS217xmTgVCU4+VWjrNcJmYfxaY=;
        b=v4FATYOQHkL3JPbGeymhvuXT8cOZCk7ZZ4qbqgF46zsaWwdCKAeLjOfmps6VaCcYDN
         lykUZrddT6FVWGYKwr0pb+XSPxK7G/yFXgDiK2N5vonnUoBmRZkeU+88DkkAN7LgqntV
         OJTQmqAEypx59nLnYiFxBDgKP4NHI+mM3HUXDMOD7zlOYLngXouRSFLcsv4en15/wwxQ
         bhrd/L7eLrm7JdtvTt/kMb6x6OVoOQ6nCBmDGEoYmpHN2UQzoWX42m3p4R2fluDAhHVF
         BYHTvXZRUu9tkOaOVMHGiDMtJW2Yow5AAHp3cVyG0t/rPnaettYycQL7Sicr9eYu3pRT
         8J/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGFR7KimUjNoXQNtvS217xmTgVCU4+VWjrNcJmYfxaY=;
        b=CucFpDMeNEAvqeqqAcGecKREp/ufrxKT5eEI/NXL6hzaNMVHJ6EV/D2ukVYVH+hc0D
         f21PDzkds5XFW4r4WB82b0TZtyEjvMBBfgEEiNeDeelvikVrYR9COq/1ke9/uOtSM/pD
         s/BdhMM8fKHPZVMw4qIYhxdrSibfIe08Cs3f7hcYYbkR1bXHhZ62+lXSuomS45eTjb+2
         slUM3tbUFzuh2TzN7dQW5jcYYwDfA/awTyQLO8AHcPsZY3OAPQbI69fCAuLxPWQM9qwb
         VuSQGttFKB7dZgsczjcQkA60sr+ZzbgmG2dAYWuaeJS/IixPCih/kWVkSAILI6EdYII9
         CtEQ==
X-Gm-Message-State: APjAAAUu+M6RrtuhSbj7h/5Egh1RxNGt0F2d7uSGQtTB2hwUrXBWgcqY
        acjfjUky6RoaXtdvHBbjoW/uKiZYsVhpfu2RZWQBEA==
X-Google-Smtp-Source: APXvYqwlCqNLj5KAkqTgNPGcrgU9X8UFaPbM9yHMYQf6OvDVo9NBXtBYD1TzLPpsaIiAMQmj+NS2HMpxB861j4ygy9M=
X-Received: by 2002:a9d:6e8e:: with SMTP id a14mr5488968otr.109.1581436375289;
 Tue, 11 Feb 2020 07:52:55 -0800 (PST)
MIME-Version: 1.0
References: <20191218165334.k4suur4gzlu62ibs@linutronix.de>
 <20191231100051.658-1-john.mathew@unikie.com> <20200114124732.mbw6lfrajmaxjkce@linutronix.de>
 <CAJz2qXntOC31LcfphJDdotQ2pMZjV8DPECMF-H7dDPWFZbw=VQ@mail.gmail.com> <20200211120443.tpb5feweflnjr72i@linutronix.de>
In-Reply-To: <20200211120443.tpb5feweflnjr72i@linutronix.de>
From:   John Mathew <john.mathew@unikie.com>
Date:   Tue, 11 Feb 2020 17:52:44 +0200
Message-ID: <CAJz2qXn_bSF5iRKZLVfrMxQXYS8cfOs9GqJtrizzpiAXR4kzAg@mail.gmail.com>
Subject: Re: [PATCH] crypto: only wait for completion once
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Feb 11, 2020 at 2:04 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-02-11 13:48:59 [+0200], John Mathew wrote:
> > > Have you tested this patch and if so how?
> > I ran the syzkaller for many days and was not able to reproduce the
> > hang, also no new issues were found.
> > Do you know any more tests for the crypto functionality?
>
> crypto/tcrypt.c
I ran the module in a loop with mode ranging from 0..200. The output
is the same (tcrypt: all tests passed ) with and without my patch.

>
> Sebastian
