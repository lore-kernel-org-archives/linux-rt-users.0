Return-Path: <SRS0=EtfJ=BR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C22C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 14:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B9A222CA1
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 14:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rAHeJmOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHGON7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgHGON7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Aug 2020 10:13:59 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43824C061756;
        Fri,  7 Aug 2020 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sILJhmcxpN/2FRHY9VUS5qLkeu+nSCsPbP2Lw3eqGAs=; b=rAHeJmOzOcBwDN5UlSqmMdsfgL
        JCqcyJUZR5TcERSei8xPwrQTe8VDvbBjGSkbObtq3fp38KWjFZ6EdcSZeNI+6P4cqGezC83ZwSeRS
        1DdDiMBhRsCO+3GFxI/fjbupJXZ/tqn9uGf+YspnO2dNK+0squ6e/nJWbd0hSHeb9Jx9MCNpRFZ2p
        6OSzW4qooZRFrHQk9uDhPKLi8hIm9HPIEDvTvN/wsDjk3xScKbqeVXrbL0lKZPwHWC6TsAlTI2Tm9
        olk1rVP16FUiWV3nDOBKoD7wv9KZVlHg7QSmeM/NhguIheBsYVgt970PzU1+nj2DmTNbQiyl8ZyF4
        RpqtzuMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k4380-0006BA-3R; Fri, 07 Aug 2020 14:13:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C6E0630015A;
        Fri,  7 Aug 2020 16:13:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B9EA921451925; Fri,  7 Aug 2020 16:13:46 +0200 (CEST)
Date:   Fri, 7 Aug 2020 16:13:46 +0200
From:   peterz@infradead.org
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     luca abeni <luca.abeni@santannapisa.it>, mingo@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com,
        dietmar.eggemann@arm.com, linux-rt-users@vger.kernel.org,
        mtosatti@redhat.com, williams@redhat.com,
        valentin.schneider@arm.com
Subject: Re: [RFC PATCH v2 6/6] sched/fair: Implement starvation monitor
Message-ID: <20200807141346.GL2674@hirez.programming.kicks-ass.net>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
 <20200807095604.GO42956@localhost.localdomain>
 <20200807152832.591f462e@nowhere>
 <20200807134353.GR42956@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807134353.GR42956@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Aug 07, 2020 at 03:43:53PM +0200, Juri Lelli wrote:

> Right, but I fear we won't be able to keep current behavior for wakeups:
> RT with highest prio always gets scheduled right away?

If you consider RT throttling, that's already not the case. We can
consider this fair server to be just another way to implement that.

At some point, we'll have have to preempt higher priority tasks, that's
the entire point of the thing after all.
