Return-Path: <SRS0=P+nX=6N=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF25BC83004
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Apr 2020 09:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB7DE20775
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Apr 2020 09:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EZpoaZAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgD2JF6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2JF5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Apr 2020 05:05:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D34C03C1AD;
        Wed, 29 Apr 2020 02:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XlD1+AvJfZeuuQwUQ9zHNy+2swxAxqsHpj/K9yi6CiM=; b=EZpoaZAfMPr1EACN+PajqhaSMa
        6B0TPq9Ch62/wPf1hf+KHHNPAjStZHmGqTBzAP1qzVyAJboFPqCyLv6cRXhfX2YCrLmSpxSDrokhK
        kVExjadPyagDkJ/pkzcULs7cUtnrAPixDNbfiVN5vpJlGRWtja8dDJNNJI+cZko5DHLZDu4+J+IJO
        RZf/SpXptIWWbZvahGcVJgLX/ny8hlX2l+p+6Bpjr4KAwQD9pmr+uhcVN28FFB3Z2oCGxJcXMF8nF
        sZ6/4kUQ7QBcpptD6auavUCnnapT2ZYp4bY832A3++ccW/O4fqAFHpQ+2ujqaHar90mh3Oc669/Op
        ndRGfKqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTieu-0008JI-C1; Wed, 29 Apr 2020 09:05:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A9CB7300130;
        Wed, 29 Apr 2020 11:05:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 784EC20BD8FF8; Wed, 29 Apr 2020 11:05:33 +0200 (CEST)
Date:   Wed, 29 Apr 2020 11:05:33 +0200
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
Message-ID: <20200429090533.GH13592@hirez.programming.kicks-ass.net>
References: <20200428050242.17717-1-swood@redhat.com>
 <20200428050242.17717-2-swood@redhat.com>
 <jhjftcns35d.mognet@arm.com>
 <20200428220917.GB16027@hirez.programming.kicks-ass.net>
 <c4a8d1f044b721a2c396fa00a0244eff0b851ae4.camel@redhat.com>
 <20200428230204.GE16027@hirez.programming.kicks-ass.net>
 <89043649a64fc97dd90eb25c85bcc8f65483cf4f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89043649a64fc97dd90eb25c85bcc8f65483cf4f.camel@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Apr 28, 2020 at 06:20:32PM -0500, Scott Wood wrote:
> On Wed, 2020-04-29 at 01:02 +0200, Peter Zijlstra wrote:
> > On Tue, Apr 28, 2020 at 05:55:03PM -0500, Scott Wood wrote:
> > > On Wed, 2020-04-29 at 00:09 +0200, Peter Zijlstra wrote:
> > > > Also, if you move it this late, this is entirely the wrong place. If
> > > > you
> > > > do it after the context switch either use the balance_callback or put
> > > > it
> > > > in the idle path.
> > > > 
> > > > But what Valentin said; this needs a fair bit of support, the whole
> > > > reason we've never done this is to avoid that double context switch...
> > > > 
> > > 
> > > balance_callback() enters with the rq lock held but BH not separately
> > 
> > BH? softirqs you mean? Pray tell more.
> 
> In https://lore.kernel.org/lkml/5122CD9C.9070702@oracle.com/ the need to
> keep softirqs disabled during rebalance was brought up, but simply wrapping
> the lock dropping in local_bh_enable()/local_bh_disable() meant that
> local_bh_enable() would be called with interrupts disabled, which isn't
> allowed.

That thread, nor your explanation make any sense -- why do we care about
softirqs?, nor do I see how placing it in finish_task_switch() helps
with any of this.

> > > disabled, which interferes with the ability to enable interrupts but not
> > > BH.
> > > It also gets called from rt_mutex_setprio() and __sched_setscheduler(),
> > > and
> > > I didn't want the caller of those to be stuck with the latency.
> > 
> > You're not reading it right.
> 
> Could you elaborate?

If you were to do a queue_balance_callback() from somewhere in the
pick_next_task() machinery, then the balance_callback() at the end of
__schedule() would run it, and it'd be gone. How would
rt_mutex_setprio() / __sched_setscheduler() be affected?
