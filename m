Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECE3C4338F
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Aug 2021 08:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58F65611CC
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Aug 2021 08:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbhHFIFQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 04:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239010AbhHFIFP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Aug 2021 04:05:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE57FC061798;
        Fri,  6 Aug 2021 01:04:59 -0700 (PDT)
Date:   Fri, 6 Aug 2021 10:04:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628237096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kFh0juNxNei1lKKweLcVBgmk4aRcGgpk3Wk3FpbmvMM=;
        b=wHCyJ8uN5AoAGUQmTEWvco7IHjI3OCjpbww5it7jlDfF+Re+kHqxucHb0qLxOP3TqbLMC4
        PZ9G9N7UdvT7KT4i18bokXtMxvxkx96a4D8wbzsyukJ4QX/RyWUIjUFTWXMS1gSr+15MBH
        oo8tNtSt7eVQ95jAydhCUyU2XIqrwxr+AX7Sa4uvIhGoq4xWXSnAE1v4sdJltN3kBnOxrz
        PbQ6ZBKQ5P2DMMZ0N3J3rx1Z888Z5EGVk8lEJUunPIRwUlTMidVpssuKX8xhwUB2JXrdEk
        W1rA2CR1QgSckG47Iy9W3awxqfdV50ax5akz2B24JVw7tHoG66NuDmoGbMf2XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628237096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kFh0juNxNei1lKKweLcVBgmk4aRcGgpk3Wk3FpbmvMM=;
        b=Pa1+KznjxhxY+X3DkJ0CEekWR3J5AcJSEEYOfdR+hvWpFPsBntCRJ9jB3aL5Faqbtyn08C
        hIpr6FjMPF71e0Aw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Make rcu_normal_after_boot writable on RT
Message-ID: <20210806080455.wkhlebgt7howjcrk@linutronix.de>
References: <20210805080123.16320-1-juri.lelli@redhat.com>
 <20210805160337.GI4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210805160337.GI4397@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-05 09:03:37 [-0700], Paul E. McKenney wrote:
> Makes sense to me!
> 
> But would another of the -rt people be willing to give an Acked-by?
> For example, maybe they would prefer this kernel boot parameter to be
> exposed only if (!PREEMPT_RT || NO_HZ_FULL).  Or are there !NO_HZ_FULL
> situations where rcu_normal_after_boot makes sense?

Julia crafted that "rcu_normal_after_boot = 1" for RT after we had more
and more synchronize_rcu_expedited() users popping up. I would like to
keep that part (default value) since it good to have for most users.

I don't mind removing CONFIG_PREEMPT_RT part here if there are legitimate
use cases for using "rcu_normal_after_boot = 0".
Paul suggested initially to restrict that option for PREEMPT_RT and I
would follow here Paul's guidance to either remove it or restrict it to
NO_HZ_FULL in RT's case (as suggested).

> 							Thanx, Paul

Sebastian
