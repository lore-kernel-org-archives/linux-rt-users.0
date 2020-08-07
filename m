Return-Path: <SRS0=EtfJ=BR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11C6C433DF
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 14:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE3CC22CA1
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 14:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mr1fv8hg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgHGOLw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgHGOLh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Aug 2020 10:11:37 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD47CC061756;
        Fri,  7 Aug 2020 07:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3SeHm1ZjMHsIJfjxrX9fUGzdepcw8YyHP7a7yWdfxp8=; b=mr1fv8hgzT1vJ+/IBK5iw5aGKm
        mu7pn6wNwqMJAeone/Rv0P5Mr1Jty9gc3ALqnSGBRb4qujMQfeNAH62LUcV2dk8bFozf0uSc+mOqk
        PLe3pfK1GwBLk+NGReUkckLhk2IBQmbKiRRgd1XNi/7JEzm04sMvOPUIR73O+uDaWrezu2ZCegi3s
        YdaCNorJIt2DcIoZenrouHeKm2x+Q/oAXf1eac6x4fvJPDIgsBoRh9L/ApJJOIBbUBfLw69Mn9T+y
        25K7O5ydz9jaq3kDW/wOEMs8bybEr47Jec07uCVH+Kr4Fyb30jcKBt6hZszVO8Z9zNJrAo6ZJoeuM
        GYVT2xzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k435d-00065v-Lq; Fri, 07 Aug 2020 14:11:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EDFBC3012DC;
        Fri,  7 Aug 2020 16:11:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AC91B21451927; Fri,  7 Aug 2020 16:11:18 +0200 (CEST)
Date:   Fri, 7 Aug 2020 16:11:18 +0200
From:   peterz@infradead.org
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Juri Lelli <juri.lelli@redhat.com>, mingo@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com,
        dietmar.eggemann@arm.com, linux-rt-users@vger.kernel.org,
        mtosatti@redhat.com, williams@redhat.com,
        valentin.schneider@arm.com
Subject: Re: [RFC PATCH v2 6/6] sched/fair: Implement starvation monitor
Message-ID: <20200807141118.GK2674@hirez.programming.kicks-ass.net>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
 <20200807095604.GO42956@localhost.localdomain>
 <20200807104618.GH2674@hirez.programming.kicks-ass.net>
 <20200807154941.2bb11408@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807154941.2bb11408@nowhere>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Aug 07, 2020 at 03:49:41PM +0200, luca abeni wrote:
> Hi Peter,
> 
> peterz@infradead.org wrote:

> > One thing I considerd was scheduling this as a least-laxity entity --
> > such that it runs late, not early
> 
> Are you thinking about scheduling both RT and non-RT tasks through
> deadline servers? If yes,

Maybe, I initially considered this for mixed criticality, where the
'soft' class would run EDF and the 'hard' class would run LLF (or the
other way around, I can't quite remember how I figured it).

If you restrict the hard class to single CPU assignment (IOW the UP
case) and ensure that u_llf + U_gedf/N < 1, it should just work out.

But I shelved all that after I heard about that other balancer idea
Danial was suppose to be working on ;-)))

> then I think that using something like
> laxity-based scheduling for the SCHED_OTHER server can be a good idea
> (but then we need to understand how to combine deadline-based
> scheduling with laxity-based scheduling, etc...)

/me consults notes, EDZL is I think the closest thing there.

> Or are you thinking about keeping the SCHED_OTHER server throttled
> until its laxity is 0 (or until its laxity is lower than some small
> value)? In this second case, the approach would work even if RT tasks
> are not scheduled through a server (but I do not know which kind of
> performance guarantee we could provide).

That would certainly be sufficient for OTHER servers I think.
