Return-Path: <SRS0=qyXN=W7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88DDC3A5A7
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Sep 2019 08:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FC022CF7
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Sep 2019 08:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JVZzJAjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfIDITe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:19:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60244 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfIDITe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Sep 2019 04:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZZNaQ4LXZ7GAaOEQI0TFwLUNueXowwuFXVaKHgUrpds=; b=JVZzJAjUvutqZpA1EnnBt9GSj
        1vU07aD4olQmFJMlHFncSfHnFBFUZddMJgyxs5PuIiezj62SySgFxPrjzX4kprKH4tMALw1CpHfuj
        E0oBNAIlJbjBAfgFq0Pf+jmZD4CBAxzqyuAnft9BaMhVwCRTQYP5YVYT/nEm2jQHo9Dv8SCogafOu
        LdBM3fHdbJA5YSK/+uYMih9402exK8oHkprbbLoZATYd1CfT286VwSUnr0YqUSm0bigG6qRmIqYlx
        tgxJC2lLYrMBjBi1G88zbIjti3mWYEG15IYBq0b27IMkjXlrC3NJEktYCU2mxy9smDAGdYtvOJl83
        ENZ5pQphA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5QVd-0002GX-1w; Wed, 04 Sep 2019 08:19:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 92453306027;
        Wed,  4 Sep 2019 10:18:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 139E429D882FB; Wed,  4 Sep 2019 10:19:19 +0200 (CEST)
Date:   Wed, 4 Sep 2019 10:19:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Viktor Rosendahl <viktor.rosendahl@gmail.com>, paulmck@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v5 1/4] ftrace: Implement fs notification for
 tracing_max_latency
Message-ID: <20190904081919.GA2349@hirez.programming.kicks-ass.net>
References: <20190903132602.3440-1-viktor.rosendahl@gmail.com>
 <20190903132602.3440-2-viktor.rosendahl@gmail.com>
 <20190904040039.GB150430@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904040039.GB150430@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Sep 04, 2019 at 12:00:39AM -0400, Joel Fernandes wrote:
> [ Resending since I messed up my last email's headers! ]
> 
> On Tue, Sep 03, 2019 at 03:25:59PM +0200, Viktor Rosendahl wrote:
> > This patch implements the feature that the tracing_max_latency file,
> > e.g. /sys/kernel/debug/tracing/tracing_max_latency will receive
> > notifications through the fsnotify framework when a new latency is
> > available.
> > 
> > One particularly interesting use of this facility is when enabling
> > threshold tracing, through /sys/kernel/debug/tracing/tracing_thresh,
> > together with the preempt/irqsoff tracers. This makes it possible to
> > implement a user space program that can, with equal probability,
> > obtain traces of latencies that occur immediately after each other in
> > spite of the fact that the preempt/irqsoff tracers operate in overwrite
> > mode.
> 
> Adding Paul since RCU faces similar situations, i.e. raising softirq risks
> scheduler deadlock in rcu_read_unlock_special() -- but RCU's solution is to
> avoid raising the softirq and instead use irq_work.

Which is right.

> I was wondering, if we can rename __raise_softirq_irqoff() to
> raise_softirq_irqoff_no_wake() and call that from places where there is risk
> of scheduler related deadlocks. Then I think this can be used from Viktor's
> code.  Let us discuss - what would happen if the softirq is raised, but
> ksoftirqd is not awakened for this latency notification path? Is this really
> an issue considering the softirq will execute during the next interrupt exit?

You'd get unbounded latency for processing the softirq and warnings on
going idle with softirqs pending.

I really don't see why we should/want to be using softirq here.
