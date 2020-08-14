Return-Path: <SRS0=y2gO=BY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD86C433DF
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Aug 2020 11:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24427207DA
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Aug 2020 11:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RlIJGJTA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NovBDUKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgHNL6x (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:58:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36410 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHNL6x (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 14 Aug 2020 07:58:53 -0400
Date:   Fri, 14 Aug 2020 13:58:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597406330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GcCjjjpshN+VO1dI+U0IUtgW/jCZhOJYWs5NIGoP2mc=;
        b=RlIJGJTArMiAifulo1TBtaON6WivdnirLfUy66WgbeWdSs6i3jjQDJ2Ih61d2FHjHJCBUB
        FDpN3pBKr1fkbfTnhGYqHnZfV9lFNyz4LomYGRW5NNwWF3YNHFivdSjn9/Gv1hv+5lDT6r
        OG+g7z6RKBI1Zj0rOFekWuLpm8uiCyidr6yevQwuZKnKTkYqincx8TMnD0fB0y6lg8ZLab
        jHFoo7rUX8EXcgR7PJxlZXKz1ZV9f4m6OCmr3pKntRV7jkWPi9fU2JciNYu9qz06miA2gl
        2JMMtD46wqsYQ7jhAjQmllzvT2jAj3+zdBaR6OexhA3Zv+0DXoI3WRmd7HIQkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597406330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GcCjjjpshN+VO1dI+U0IUtgW/jCZhOJYWs5NIGoP2mc=;
        b=NovBDUKQqfOHJRdqlEuuLt5DPuNfXkNuKG/DT5VYDlfFoIryvb8uevOj5cDK8qD427UHOZ
        0P8vkqUH54vSAyDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Roosen Henri <Henri.Roosen@ginzinger.com>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: RT kernel v4.14 NULL pointer dereferences
Message-ID: <20200814115848.w4m2bfqttkid6woi@linutronix.de>
References: <fd9d435b3f6a5f4ffd7ef93763e78c087871d565.camel@ginzinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd9d435b3f6a5f4ffd7ef93763e78c087871d565.camel@ginzinger.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-06-16 07:30:33 [+0000], Roosen Henri wrote:
> Hi RT-experts,
> 
> Duration tests with RT enabled v4.14 kernels on our ARM iMX6Q systems
> are showing "Unable to handle kernel NULL pointer dereference at
> virtual address" after running for some months. The same tests on NON-
> RT kernels don't show any problem and have been running without any
> problems for more than 20 months now.
> 
> I've been updating the tests from time to time with more recent
> kernels. Testing is basically done with cyclictest, in parallel with
> some load scripts/hackbench. Please have a look at the kernel traces:
> 4.14.71-rt44  -> https://paste.debian.net/1152206/
> 4.14.106-rt56 -> https://paste.debian.net/1152204/
> 4.14.146-rt67 -> https://paste.debian.net/1152202/
> 
> I've seen the v4.14-rt branch got some fixes, so my questions are:
> 1) is problem I'm facing known and fixed in v4.14-rt, or
> 2) is the problem I'm seeing a new issue probably still unfixed in
> 4.14.183-rt83 (which I'm testing right now)?
> 
> Any help is highly appreciated!

So this has not fixed all by itself?
Is the 4.14 series the only one that is affected?

> Thanks,
> Henri

Sebastian
