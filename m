Return-Path: <SRS0=N+eC=CF=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77D0C433DF
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Aug 2020 14:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CA022054F
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Aug 2020 14:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="27/zET3c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Tz6LDpE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgH0NMV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:12:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38724 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgH0NMB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Aug 2020 09:12:01 -0400
Date:   Thu, 27 Aug 2020 15:11:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598533897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dPsylZrWcQbHfyn7ZMN/ef2AKzaLfi0hb8YoJl3hZTI=;
        b=27/zET3cU2Pr9uQqPD1vwNNyK1go9OUCqhuG1cIFnjvFrrzSZzAphpnie0FaCH0ZrMsyVT
        KtQGO7A6cTPcw8HcYxSuVfLPlOVQIHC1nKCocKCFdLftlj7fuqUeyIiMym0t91dyBCvvci
        uMno9LDemAPaKe+A8pFhQq8fGA62Kh9OAOvsXU5IK3pQtCifSNT5zXXmsQboOjCjHRUyGY
        6/C2qJFlFJLmBdm/2S2EIrIonXsKDPFDPlJnp/bseHZH+uFlfbN+r7/0jQsT0zW8Sf/XeY
        NXvxP7WiasGDw8arbpwFPNsuB1zcP6SlJWUIk6VsbotWRhsK7W3d7eYolwVGTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598533897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dPsylZrWcQbHfyn7ZMN/ef2AKzaLfi0hb8YoJl3hZTI=;
        b=1Tz6LDpEGPoHcaTbPBcZjnYC2CR0v3/LK31SWRtVM9kjU41OURJYy7aiFOJRv2rFEjagYs
        RXAUUbvQzHUTEMAg==
From:   "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To:     Roosen Henri <Henri.Roosen@ginzinger.com>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "williams@redhat.com" <williams@redhat.com>
Subject: Re: RT kernel v4.14 NULL pointer dereferences
Message-ID: <20200827131136.aepfkssev6psio3c@linutronix.de>
References: <fd9d435b3f6a5f4ffd7ef93763e78c087871d565.camel@ginzinger.com>
 <20200814115848.w4m2bfqttkid6woi@linutronix.de>
 <25412beffb96ab8c2b8f869bdac5a66c49faa5ca.camel@ginzinger.com>
 <20200817111311.zyqjznhferoqqxkh@linutronix.de>
 <05cc3d6085641c7f0425e45358451b05c5e9fc07.camel@ginzinger.com>
 <1ffc7e58e5fdc26c60f403e454d4077241605a7b.camel@ginzinger.com>
 <be2424198cd899ca182b38c51f97f5b9acc16131.camel@ginzinger.com>
 <20200827125256.etg57uakct2gobl3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827125256.etg57uakct2gobl3@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-08-27 14:52:58 [+0200], To Roosen Henri wrote:
> On 2020-08-26 09:56:16 [+0000], Roosen Henri wrote:
> > Please let me know if there you find any unregularities in my config or
> > suggestions on any usefull debugging-/forensic-config-options.
> 
> I have no suggestions. Well besides memory debugging, lockdep and these
> kind of things.

You never sent a backtrace, did you? I remember you posted a link a
pastebin which contain only the "middle" of the trace, not where it
started.

> > Thanks!
> > Henri
> 
Sebastian
