Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475F2C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 15:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244C661267
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 15:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346334AbhI3Pvg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 11:51:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50996 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346074AbhI3Pvf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Sep 2021 11:51:35 -0400
Date:   Thu, 30 Sep 2021 17:49:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633016992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/pBBYaU8HcrLt7lPSLrbdU2c0rrQjLddlaRCbL5buVI=;
        b=yZyz4k7nMH2ku0KGjtAM0RfjOMjTVuUkBEzcjRorAVi3NECqjT0UWmd2g5lGDYYAkVXGYf
        FN9aN3am6yGh/fFAZcn816WQS3Qmrz7GYwbWLjolU5xdDFyw/ZNkxSh6Ov4/wTNCKucUrg
        qG4AhrT2liYPhGR8juXb7U/QCfE/dbrCx42RCrKcMQCRrelpJSuHBJSZmOOVEXreiUJNFE
        sT4TFY63mai7Ee9JCHV0QqyOdHzh3SRsfnNozxB2F69RZ2Lmv9XXQsdASl3dA9G+UwYcCJ
        LVC7B/kR0ym2pSLatxtJQ0vxWjsZjmBdXA25O0YKY7iWRA1U7ITKeTEFRIGYXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633016992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/pBBYaU8HcrLt7lPSLrbdU2c0rrQjLddlaRCbL5buVI=;
        b=X2GQsF8lArkjTsphCQqc9fwuVu0E0Dmy4ageh9oOj3+TCFDmXCBvrNAfZeSXkTqiye7JIq
        /Qjwy0ywkZO8wWDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     John Kacur <jkacur@redhat.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Clark Williams <williams@redhat.com>,
        Pierre FICHEUX <pierre.ficheux@smile.fr>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Strange problem with PREEMPT_RT
Message-ID: <20210930154950.ucpjabqtdk2rig33@linutronix.de>
References: <CAFc1U0sgMtKvcpTWkyjwXsq3Md_Huew7mSye_AratkM63D6K-Q@mail.gmail.com>
 <87y27e53a2.fsf@stealth>
 <20210930132319.eixnv6rb66ui6x6j@linutronix.de>
 <87v92i9o5t.fsf@jogness.linutronix.de>
 <6034cc70-fb69-d9d-ce31-673d4d42adc@redhat.com>
 <87pmsq9kdd.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pmsq9kdd.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-09-30 17:08:54 [+0206], John Ogness wrote:
> > Where does this "--latency=" option apply to?
> 
> It is the value written to /dev/cpu_dma_latency, which AFAIK writes the
> maximum acceptable latency (in microseconds). This translates to the
> allowed C states. cyclictest currently writes 0, which should keep the
> processor in C0. For example, setting it to 1-5, should allow C0 and C1.
> 
> Using --laptop will cause cyclictest to avoid touching
> /dev/cpu_dma_latency. But nobody would know that unless they looked at
> the code.

Exactly. We want to measure not to change the defaults before we start
doing so.

> IMHO, systems should be configured for production use and cyclictest
> should just _measure_ latencies at a specified priority level. But by
> default cyclictest is adjusting global system behavior during
> measurements, thus providing results that the system (as it is actually
> configured) would not be able to provide.
> 
> I realize that nobody wants to touch defaults. But I'm not sure users
> are aware how important the --laptop option is for realistic
> measurements. In fact, the description of --laptop even encourages users
> _not_ to use it. :-/

We don't want to touch the defaults? Not so long ago I was curious why
the -b argument didn't stop the trace. Apparently I didn't use the
--tracemark option which is required nowadays.

> John Ogness

Sebastian
