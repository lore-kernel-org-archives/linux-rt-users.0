Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1A2C56201
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Nov 2020 13:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA43620A8B
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Nov 2020 13:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FnOxIEPD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1k8za+g3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgKLNyu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 Nov 2020 08:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbgKLNyu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 Nov 2020 08:54:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF365C0613D1;
        Thu, 12 Nov 2020 05:54:49 -0800 (PST)
Date:   Thu, 12 Nov 2020 14:54:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605189288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l8J/g3+UlJiPv1r44/uRYuW0HBR3RLzuLwjDlVtLk+U=;
        b=FnOxIEPDMOCmSPlj5bs8TfynVc/bbg3oPSLt8Wcu0/8q6yKMDB0Me58btrNhQ2UYtUMv6d
        a/b44lUS98qsqWxrKzpKRFuyog1bMO3l8eHpdTemD8ZLGnukKnXKypvNasCkccodLyffBR
        BW9ttWbWwKST18K5KignkZwoy0J7UsjDI8v4okq72qe5e08pgfdSfxHamcFn4PBNWiU6Eb
        LcGKh5PrkOqRwYdF2smV5Sy61i7tX0gCZBaBWq6zIIUrWhyMoCG5KtpoIESaRIJqXN4JhU
        P19OiIGnXzhaSYnv7KhQgB1JtQLyeSCzL8bg4/Y2j1Ii+JHX5nJPLkvNNrLqQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605189288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l8J/g3+UlJiPv1r44/uRYuW0HBR3RLzuLwjDlVtLk+U=;
        b=1k8za+g3OUbKN+AqR0TIwRZ0iXUFK6/n+GrrZhMyr+IyPON27fI5Gofy9TkwR1hMquGo+Y
        8lfDHWQ2tC0ORnAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.10-rc2-rt4
Message-ID: <20201112135446.ghwvgio6f66igcho@linutronix.de>
References: <20201104111948.vpykh3ptmysqhmve@beryllium.lan>
 <20201104124746.74jdsig3dffomv3k@beryllium.lan>
 <20201104130930.llx56gtqt532h7c7@linutronix.de>
 <20201104160650.b63zqof74wohgpa2@beryllium.lan>
 <20201106105447.2lasulgjrbqdhnlh@linutronix.de>
 <20201106161413.7c65uxenamy474uh@beryllium.lan>
 <20201109124718.ljf7inok4zakkjed@linutronix.de>
 <20201109143703.ps7gxhqrirhntilr@beryllium.lan>
 <20201110180518.miuxa25j7lnn7f2q@linutronix.de>
 <20201112123902.netkfwzccwrtscdv@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201112123902.netkfwzccwrtscdv@beryllium.lan>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-12 13:39:02 [+0100], Daniel Wagner wrote:
> With the current version signaltest + your test patch and 'taskset -c1'
> the results looks good again, around 230us (running since 2 hours). I've
> tested first without taskset and it took about an half hour to hit
> 350us. So pinning the threads on one CPU fixes it.

okay. So case closed.

> I think we change signaltest to use the correct affinity on
> default. Also, I see that sigwaittest has some code for it, but it, but
> it would be a good idea to set the defaults so that out of the box the
> test does the right thing.

Sounds reasonable. Having tasks jumping from one CPU to another may lead
to higher latencies.

> I'm sorry about dragging you into this problem.
I feared that something in lazy preempt or signal stack is broken. But
it appears not to be the case :)

Sebastian
