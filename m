Return-Path: <SRS0=fi+z=6M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587E7C83004
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 23:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 393BF206A1
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 23:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="thRXx1m2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgD1XCw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Apr 2020 19:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726343AbgD1XCv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Apr 2020 19:02:51 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632F7C03C1AC;
        Tue, 28 Apr 2020 16:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AIu07HAj/AGrMk6ZycUKbLgO7uQhu/8EqeWjT0+uzss=; b=thRXx1m2QR0nYaAuVcc/ntn9As
        h/QSxVIT6/nGdm0M7C501bF5GnnX81xbd/jZHBBuT1q0d3ucFzUzI0Z1Uz03kKGhv4qkEtc2bcWTh
        GS65J4aMfLxF7PONFoTRashCsbog5RHU4F7PsB9IuVmWtu4t/pL046rv+7dIfGco1NcIejiJOgLkw
        /Lq7LUz31RzkCgaJkhdZa1xp11tGcQe1FhiT6CoiP/+yWecjefEqsBd3Fd/BJy46lPocoFQtQc8hh
        6YIwFuv3LtL3NaKeS4jJXXostKoGxWafOLcN3t0MNiITkG4ugjDFlyB9A+Dobxi+3FpoQmjmcucvl
        W7PRb+Vg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTZEt-0004TY-7Y; Tue, 28 Apr 2020 23:02:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 54444304121;
        Wed, 29 Apr 2020 01:02:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3BCE22392F89E; Wed, 29 Apr 2020 01:02:04 +0200 (CEST)
Date:   Wed, 29 Apr 2020 01:02:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [RFC PATCH 1/3] sched/fair: Call newidle_balance() from
 finish_task_switch()
Message-ID: <20200428230204.GE16027@hirez.programming.kicks-ass.net>
References: <20200428050242.17717-1-swood@redhat.com>
 <20200428050242.17717-2-swood@redhat.com>
 <jhjftcns35d.mognet@arm.com>
 <20200428220917.GB16027@hirez.programming.kicks-ass.net>
 <c4a8d1f044b721a2c396fa00a0244eff0b851ae4.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4a8d1f044b721a2c396fa00a0244eff0b851ae4.camel@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Apr 28, 2020 at 05:55:03PM -0500, Scott Wood wrote:
> On Wed, 2020-04-29 at 00:09 +0200, Peter Zijlstra wrote:

> > Also, if you move it this late, this is entirely the wrong place. If you
> > do it after the context switch either use the balance_callback or put it
> > in the idle path.
> > 
> > But what Valentin said; this needs a fair bit of support, the whole
> > reason we've never done this is to avoid that double context switch...
> > 
> 
> balance_callback() enters with the rq lock held but BH not separately

BH? softirqs you mean? Pray tell more.

> disabled, which interferes with the ability to enable interrupts but not BH.
> It also gets called from rt_mutex_setprio() and __sched_setscheduler(), and
> I didn't want the caller of those to be stuck with the latency.

You're not reading it right.
