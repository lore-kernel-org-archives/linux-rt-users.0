Return-Path: <SRS0=F8C2=CR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D082C433E2
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Sep 2020 20:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD93D2137B
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Sep 2020 20:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sXhlasBH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kxjaxt2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbgIHUCX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730310AbgIHPfM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Sep 2020 11:35:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0E2C0619ED;
        Tue,  8 Sep 2020 08:14:33 -0700 (PDT)
Date:   Tue, 8 Sep 2020 17:12:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599577950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lIVgIxTyroQddql8kti9o3VE5bSiFWAwUPsPZehXs9o=;
        b=sXhlasBHEKGmjbmZDMHbFD7Rsy2wjwblXmS7YU8lQi9EA9XqAewbLsZRFGt8nkjLTQXw8m
        zvObdrZX72xqJ9q18VgC85vQRLzqaFJWuwz2NhTol9lsNMd5XUs2iHQyUndQPPfwe1ObYU
        4hS0AhQaQjpwUDgEH4gdT/S5SMvdRK7QZIVkFX+y2/qH6NR7/iikQiqvY4tovuObzBVRfP
        kU0j8vopuU9FkdMMkglSKe6aGOTRAbB+uqo3DB9QfD3RY04TkasmbP7xnB82T2Y2Fb/3lA
        gJ5riSIi14Cl5GEhKWbT681B2G48wMlt4t2OKPPt5uXsePgIv+Zsq+1OyjmJjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599577950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lIVgIxTyroQddql8kti9o3VE5bSiFWAwUPsPZehXs9o=;
        b=kxjaxt2dIjBlb5FiPBRsluID3bgNmV1B32kw3B0tymfXnJyo4JFDg6Dp5xE6ZrD035G1Al
        trsnmHCEmRg6jCAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: v5.9-rc3-rt3 boot time networking lockdep splat
Message-ID: <20200908151229.g24j4n4fderlm2pe@linutronix.de>
References: <20200902155557.h2wl2qpfn2rwsofw@linutronix.de>
 <46a2b89ec8d953a4be18c7389c7d8c66310a7ff0.camel@gmx.de>
 <b989e196a8b9cceda35152de9202d7a67ca32196.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b989e196a8b9cceda35152de9202d7a67ca32196.camel@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-09-05 07:19:10 [+0200], Mike Galbraith wrote:
> Lappy, which does not use bridge, boots clean... but lock leakage
> pretty darn quickly inspires lockdep to craps its drawers.
> 
> [  209.001111] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> [  209.001113] turning off the locking correctness validator.
> [  209.001114] CPU: 2 PID: 3773 Comm: Socket Thread Tainted: G S        I E     5.9.0.gc70672d-rt3-rt #8
> [  209.001117] Hardware name: HP HP Spectre x360 Convertible/804F, BIOS F.47 11/22/2017
> [  209.001118] Call Trace:
> [  209.001123]  dump_stack+0x77/0x9b
> [  209.001129]  validate_chain+0xf60/0x1230

I have no idea how to debug this based on this report. Can you narrow
it down to something?

Is Lappy new, got a new something or has a new config switch? I'm just
curious if this something or something that was always there but
remained undetected.
(Your other report was about something that was previously always "broken".)

Sebastian
