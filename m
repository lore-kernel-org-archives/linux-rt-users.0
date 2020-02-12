Return-Path: <SRS0=WKTr=4A=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3797DC2BA83
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Feb 2020 12:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F320920659
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Feb 2020 12:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=unikie-com.20150623.gappssmtp.com header.i=@unikie-com.20150623.gappssmtp.com header.b="RsJOljxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgBLMzl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:55:41 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32868 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbgBLMzl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Feb 2020 07:55:41 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so1801272otp.0
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Feb 2020 04:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgYIL2d4d27MbWyy0k/6/4pfAddFsUUccOuBr5M1J90=;
        b=RsJOljxLSdeEQ+0uValA16C/pORujdoxQTVXyEzO5lNoB2zdiIf3Kaeqq1u1SukhbD
         ev7cYIXW3MCDI5HyEMyErpPa1vVfb1z0FsxWOFpWtFYJJEjdADsZck+2c/AX8mrWr/TC
         /KxMc4/qEcShG1VG65m+8antQgW7aUNNvHTOjB+xpwows+4p7Epu3EmF7tRy41Wp2o5k
         6dBE+zkCBbZt/p0M8isw2tjShsIjCYSdEg9oaULIfFc7Qaxgvb+63ZelFjV95eShN6jp
         gqjEdMyk+LOkdZKvykdeKW4BYHG7QoTJojYPp/MVx3KCIAYb5wmPn4mgHFWNORD4t/dA
         UyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgYIL2d4d27MbWyy0k/6/4pfAddFsUUccOuBr5M1J90=;
        b=AyHOMguhEsMDoSV7Zen/U+XJnNLHrTDwjhJTkK4FeaYNG0qA9MHU1PID9+B0EjKriX
         8cJuULwyRvS2/CgdgEfZDsD+qZC6e14x3om5guFDM+c2yrqciKw6Ze1Al5E75JMpfhfz
         gWMycsl5objIQS9o1JXhy/ElW4CT2xC+VhHK8h1IPqYPHUphdVdo/N9M3NtB65jzi0Nf
         7xL+b/qtqdgAYR2jAYbJUbocriHXMEWkc8Os/IQM2L1x9UMepF8+gp18GxvI1G6zXZa9
         o5pXZf16TJTfmUpa7Vv42uSzUu/gQb2Cd2i6W5QLNDMI0VzH4X2hDII9eTk14p2Qgvlv
         Ecng==
X-Gm-Message-State: APjAAAXhmQ0M/UpmgDDrYRPa7p3N4xDnTt7sDI94fzfjXjs78RBCM3ur
        so7DaNx9jsd4hzl5biGg/iupQIexbxnomdKjwxnt9Q==
X-Google-Smtp-Source: APXvYqwZcQkOrE1hxfZhAp4a3NyoFos0fxyOXz+PWFatOLDPLSX2R9k1dYn66ir3cizAxhBGo4irnjRR/qZodwsOO8E=
X-Received: by 2002:a05:6830:155a:: with SMTP id l26mr9291710otp.339.1581512140476;
 Wed, 12 Feb 2020 04:55:40 -0800 (PST)
MIME-Version: 1.0
References: <20191218165334.k4suur4gzlu62ibs@linutronix.de>
 <20191231100051.658-1-john.mathew@unikie.com> <20200114124732.mbw6lfrajmaxjkce@linutronix.de>
 <CAJz2qXntOC31LcfphJDdotQ2pMZjV8DPECMF-H7dDPWFZbw=VQ@mail.gmail.com>
 <20200211120443.tpb5feweflnjr72i@linutronix.de> <CAJz2qXn_bSF5iRKZLVfrMxQXYS8cfOs9GqJtrizzpiAXR4kzAg@mail.gmail.com>
 <20200211155925.ctrtxyxh3pfuo2os@linutronix.de>
In-Reply-To: <20200211155925.ctrtxyxh3pfuo2os@linutronix.de>
From:   John Mathew <john.mathew@unikie.com>
Date:   Wed, 12 Feb 2020 14:55:29 +0200
Message-ID: <CAJz2qXk=OXRFV8XGWbh+pMG3CLX6Htkwi+jR635U4sibNaGdxw@mail.gmail.com>
Subject: Re: [PATCH] crypto: only wait for completion once
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Feb 11, 2020 at 5:59 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-02-11 17:52:44 [+0200], John Mathew wrote:
> > > crypto/tcrypt.c
> > I ran the module in a loop with mode ranging from 0..200. The output
> > is the same (tcrypt: all tests passed ) with and without my patch.
>
> Try one of the modes which are not built-in but provided by a module.
> And the module must not be loaded before starting the test.

I tried the mode 26 which tests the "anubis" module. The module is
loaded dynamically after starting the test.
Using traces in the code i confirmed that the algo lookup and tfm
creation works fine.
alg_test returns 0.
>
> Sebastian
