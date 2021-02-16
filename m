Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672D7C433DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Feb 2021 08:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E6A564E41
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Feb 2021 08:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhBPIbQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Feb 2021 03:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhBPIat (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Feb 2021 03:30:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3310BC061574
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 00:29:45 -0800 (PST)
Date:   Tue, 16 Feb 2021 09:29:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613464183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OKql+UMPc+vHoiIUQy/+sVpdJP1ujqrbPVrn1Zen5wE=;
        b=k49QPEismd0hkixhTuo4M0hnHrpOCgRpFb1DOPaHuODj+4T0rZYplox+26gdeI+A7ICyOx
        o94ays84xqtuoMaizVtjZ5lNkytv+vcZnGW7OxjjY/e5Ym9A1sWl5k9t6UNt15hGsbLatW
        RvWJAGo04REFMA4p/F5D8SQp1zTjgSfD3gkg9Svqiq6YHBlDY+1B7Zao3Hx3hpdpkf44/U
        kkdDUCAp2kxdLk/L+kYrcG7+Yud4ukLTPRoMhQfeiQ6o2X7RaHhU1gGqmd5tRQZZRpF1/J
        gasTm3wCXozugVgwjShrOuQobo752lL0RpyhuEED9YHtC3mPFd4nhlugUlj8yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613464183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OKql+UMPc+vHoiIUQy/+sVpdJP1ujqrbPVrn1Zen5wE=;
        b=7iHRpHZG0GLyKmBwFubT/E1Sopy/Bv/6+sUl2aswCgtxXmN0leQ3ohv0aDtgQTy1ekgoyQ
        tVi5gg3ExObn2JCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jonathan Schwender <schwenderjonathan@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: v5.10.14-rt28 fails to build without CONFIG_SMP
Message-ID: <20210216082942.cniylvhc4hoe3wht@linutronix.de>
References: <20210209180601.hbjpgfcntgsjirbk@linutronix.de>
 <ae545d99-66ec-ef32-604e-ee5caee8ece5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae545d99-66ec-ef32-604e-ee5caee8ece5@gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-02-14 11:54:27 [+0100], Jonathan Schwender wrote:
> Hi Sebastian,
Hi,

> It seems that commit 17cfc9697f5574e4b523c21fca160aac5a3ac6dc "softirq:
> Update the WIP"
> breaks builds without CONFIG_SMP, due to unresolved references to
> tasklet_unlock and tasklet_unlock_wait in softirq.c

Should not happen in v5.10.16-rt30.

> Regards
> 
> Jonathan Schwender

Sebastian
