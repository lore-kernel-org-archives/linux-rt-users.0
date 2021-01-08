Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976FFC43381
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Jan 2021 09:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49B7D23383
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Jan 2021 09:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbhAHJdp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 8 Jan 2021 04:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbhAHJdo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Jan 2021 04:33:44 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC63C0612F4;
        Fri,  8 Jan 2021 01:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AFhQ5m4QRya/SI/e/ihcUh2OxTirSzfuPrKOq59dUp0=; b=BUn3OEaiG3IFlZ7EeATceuIIPf
        GORD2Eo5wkYEH4pjMYOkOUtLBCkZ+gvrK47gjrcE/+8gLy+BaCosjOEWFCbN/M1Q23PL3fmnIXwqU
        Lq0AnxNPhY92ADQ+GAbXcyAs316UqJgAAQWfVKwhChFOOPb+OOhin9CaxtzmnlzYyTlpSzi3vmbSZ
        pfvbJKRtg8Vq/0QtiZaMejMyvXSOF1jKy4+Es9g3zPkbw9ovWOGmWpovazPkP4d5kIiPJD0oJSk7W
        r44ZHIp7vuFhrJ3/vOpgXPx8rpeFNvcfVOXYPWFornI8tWgBSyUJoBXlAX11UP7ZP6rErjmAFsSbq
        KJ0cxvKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxo8O-0005tk-40; Fri, 08 Jan 2021 09:32:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A5A0F3003D8;
        Fri,  8 Jan 2021 10:32:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E7EE2BB7DCD2; Fri,  8 Jan 2021 10:32:36 +0100 (CET)
Date:   Fri, 8 Jan 2021 10:32:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Siewior <bigeasy@linutronix.de>
Cc:     Ran Wang <ran.wang_1@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] rt: kernel/sched/core: fix kthread_park() pending
 too long when CPU un-plugged
Message-ID: <X/gmtIqgT27OvDX6@hirez.programming.kicks-ass.net>
References: <20210107091841.19798-1-ran.wang_1@nxp.com>
 <X/bmU4byS7k46zWM@hirez.programming.kicks-ass.net>
 <20210107152843.gyljmpctkwybfewh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107152843.gyljmpctkwybfewh@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Jan 07, 2021 at 04:28:43PM +0100, Sebastian Siewior wrote:
> This sleep can be triggered by ptrace/strace() and with brief testing I
> can trigger the sleep there but I don't get it anywhere near where I
> would notice it with cyclictest.

It's a single task wakeup (the caller), doing that from hardirq context
really should not be a problem, we do lots of that in RT already.
