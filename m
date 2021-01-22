Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13939C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Jan 2021 12:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D2821D7A
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Jan 2021 12:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbhAVMbt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Jan 2021 07:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbhAVMbl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Jan 2021 07:31:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7643EC06174A
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Jan 2021 04:31:01 -0800 (PST)
Date:   Fri, 22 Jan 2021 13:30:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611318657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rSi+Cl424xasLfdnola1Eti3Z3BzrrUt2w9Nrf2fd+0=;
        b=HYApeeGZpNV5CkoyOfsbLxz8O6UOs2R9iOD5R7WOBThzEoMAWh8LK0BVBESm2avPiUPP+c
        5DPpeBne2DaBaoPTE6FbzGj15LRcBW9lqpJq8AvxMGYckT1eck3vWPjFDCSi/lzF75S+D3
        +VLimsGc/aEzSq1uFtiauh6BdriqVZThJ83sFCMBj0ZbRXpIBEHMBSd8wBHX/1C6tusGkN
        F6G84fxfCGozNf1fsw8aJfiwvlUN0S75paIrgggjz7nieq6onBMFSDpQDKI4NuR9REpQdM
        L2ViqrDFuh1Zv3xuTM+2F3PWajfW2QGqXDlHQP+/SSKYDugE5AGdNYul2+h9hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611318657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rSi+Cl424xasLfdnola1Eti3Z3BzrrUt2w9Nrf2fd+0=;
        b=9Hzd5TrCMDiXR3EBUUL618h9CUnLSD3WgrtcqVI36ryhQnj9gnhCFWScF0CEtiaiaTqDwG
        sdsB+m2Es+x5kYBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Sebastien Laveze <sebastien.laveze@oss.nxp.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: timerfd performances
Message-ID: <20210122123057.72aeag672rh3omcw@linutronix.de>
References: <e4c83482f22059647c546f202470d05e142134bc.camel@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4c83482f22059647c546f202470d05e142134bc.camel@oss.nxp.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-01-18 17:10:15 [+0100], Sebastien Laveze wrote:
> Hi,
Hi,

> In the end, it seems my most viable option at the moment is to move to
> clock_nanosleep() but it implies radical changes in my application
> architecture as it's not as scalable and flexible as timerfd.
> 
> Any hints on how to "secure" the wake-up latency of timer fds or what
> is expected in future works would be greatly appreciated !

Splitting the timer-wakeups back into ktimersoftd would look like
helping. But note that all timer wake ups would happen there - even the
accumulated case where we have to wake 100 tasks at once. This would
then probably ask for split on SCHED_OTHER vs RT tasks like it is done
for clock_nanosleep().

> Thanks,
> Seb

Sebastian
