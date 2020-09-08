Return-Path: <SRS0=F8C2=CR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC59FC43461
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Sep 2020 19:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79BE22137B
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Sep 2020 19:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yeGdGILu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7LSSF/P8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbgIHTTz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730668AbgIHQCS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Sep 2020 12:02:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74D3C061786;
        Tue,  8 Sep 2020 09:02:17 -0700 (PDT)
Date:   Tue, 8 Sep 2020 18:02:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599580936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=97oj1pCtLhc8GEIScXkD+7t3oCOzOaAxQFhhixXPXYs=;
        b=yeGdGILuNPEXB5/p4qF0cmCVDKze7lv3D+hxUC2BiCT6JPgkPmoSlYin1TMQFR9vUUkQKv
        4KXemeCiJSkkgTxR6LuobNDDMQdl9bA/Lwn5y5Rb8pwvOTjcXRkbnsbSrQKfGz6Dbvrrdr
        Ru2alBZYhCt3Q7wNBuMNAICWmDZibBJLKAQw+IqAzVBgFirtAIS3ehO0garsyfPHiX/uzY
        FN5q68u0L89RM60+CEv2reYlTUHdNept+AebIBJI+1lFRqVWoAXLcaMRCMnYIInZAO4Wrm
        REhfWQY+Q+jdUnrE9bAVrnGJIz09QDkrJxnN0+DuLTZQ0A175sbazDu/5WoWtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599580936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=97oj1pCtLhc8GEIScXkD+7t3oCOzOaAxQFhhixXPXYs=;
        b=7LSSF/P8VGb8OFyKhLSf/g7sECVsh9xM22Xon8GdgRlb6KSYTPdHfwFEvQME5g9X3nVfqn
        qBoLR76pYz7bo9CA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: v5.9-rc3-rt3 boot time networking lockdep splat
Message-ID: <20200908160214.p3av2uxt7jjj6rx2@linutronix.de>
References: <20200902155557.h2wl2qpfn2rwsofw@linutronix.de>
 <46a2b89ec8d953a4be18c7389c7d8c66310a7ff0.camel@gmx.de>
 <b989e196a8b9cceda35152de9202d7a67ca32196.camel@gmx.de>
 <20200908151229.g24j4n4fderlm2pe@linutronix.de>
 <a79815352e2f238b7f108e6e7202f6655f26159d.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a79815352e2f238b7f108e6e7202f6655f26159d.camel@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-09-08 17:59:31 [+0200], Mike Galbraith wrote:
> > I have no idea how to debug this based on this report. Can you narrow
> > it down to something?
> 
> I instrumented what I presume is still this problem once upon a time,
> structures containing locks are allocated/initialized/freed again and
> again with no cleanup until we increment into the wall.

Any idea what it is?

> > Is Lappy new, got a new something or has a new config switch? I'm just
> > curious if this something or something that was always there but
> > remained undetected.
> 
> Nah, this is nothing new.  Turn lockdep on in RT, it's just a matter of
> time before it turns itself off.  It's usually just not _that_ quick.

Okay. So I have few boxes which run over the weekend without this splat.

> 	-Mike

Sebastian
