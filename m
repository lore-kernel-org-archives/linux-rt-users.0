Return-Path: <SRS0=Jm7W=6Z=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670D0C54E4B
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 May 2020 10:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 449FC206A3
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 May 2020 10:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jVkoV2Pu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgEKK6u (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 11 May 2020 06:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728209AbgEKK6t (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 May 2020 06:58:49 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A5DC061A0C;
        Mon, 11 May 2020 03:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zVp+KEHG//4GteVS2L398c27Nbd57ht0c26PeqpvFXk=; b=jVkoV2PuBzBJwby863FFvQofrP
        eIgYpS/larLjlrwfm524OvYm+5JobjO60lsIh72kFf14x/QfIpabyHqUC5hSZFKRsToim0/RIrt50
        0uqLKpBX72g7C3wiUYnTHdfbpLrN2N5ilSmQuVmAgg7FgJ2YErN0hZGLFioHDLXhjAB8eSlAfX6aL
        vM0oThfzssyWwPOp/FhQzn6roUTcBPga2Y5k21hmFNuwssHYf6fU3sBekwxSIUIlY0kgxCjZ+9Mp3
        m03EF5Jg96CZW0m8yIdv4zbd8JwcrPjY3HAi3myjNpZclO8SEmpnj1oVv1pqsGSKULURELUrla/rW
        ObH8Wilw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jY68J-00033J-6w; Mon, 11 May 2020 10:58:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B20FE3010C8;
        Mon, 11 May 2020 12:58:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F5082038FB65; Mon, 11 May 2020 12:58:00 +0200 (CEST)
Date:   Mon, 11 May 2020 12:58:00 +0200
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
Message-ID: <20200511105800.GB2940@hirez.programming.kicks-ass.net>
References: <20200428050242.17717-1-swood@redhat.com>
 <20200428050242.17717-2-swood@redhat.com>
 <jhjftcns35d.mognet@arm.com>
 <20200428220917.GB16027@hirez.programming.kicks-ass.net>
 <c4a8d1f044b721a2c396fa00a0244eff0b851ae4.camel@redhat.com>
 <20200428230204.GE16027@hirez.programming.kicks-ass.net>
 <89043649a64fc97dd90eb25c85bcc8f65483cf4f.camel@redhat.com>
 <20200429090533.GH13592@hirez.programming.kicks-ass.net>
 <0945b70535f11c9abd45d3a3da2e984c4b1d832b.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0945b70535f11c9abd45d3a3da2e984c4b1d832b.camel@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Apr 29, 2020 at 08:31:39PM -0500, Scott Wood wrote:
> > If you were to do a queue_balance_callback() from somewhere in the
> > pick_next_task() machinery, then the balance_callback() at the end of
> > __schedule() would run it, and it'd be gone. How would
> > rt_mutex_setprio() / __sched_setscheduler() be affected?
> 
> The rq lock is dropped between queue_balance_callback() and the
> balance_callback() at the end of __schedule().  What stops
> setprio/setscheduler on another cpu from doing the callback at that
> point?

Hurmm.. fair point, and that might explain some issues I had a while
back. Let me poke a little at that.
