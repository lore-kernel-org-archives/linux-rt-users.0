Return-Path: <SRS0=Byy1=TB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CF6C43219
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 May 2019 19:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498F620652
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 May 2019 19:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pw2dYNwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfEATZd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 May 2019 15:25:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfEATZc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 May 2019 15:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Svp6NeVfnrKdCuBqYXud25fjj+cIG4+GuETWruPIq3w=; b=pw2dYNwgUYrBZ6XHj0W3NTTJh
        Q3RgzJjrP6wa+KnPIDx0gBRUtxfV1qjJDBHv7iVnho+f3wuYGz83G6fr7TO7HoAEMYTHg5QGgYoXP
        OzzYj5HcC9hWpbasGeMbjIaou0uSC4+2igQD8Cber4gU76av4C4orUuxpG7Kx9uJi1hZp7DKoj+6Z
        NnpRZ59p5v7SBgAqWyhoWvjQYqpvmt3PUPyq/VGataEGxQTUcBoWI4XwoVtzt+tAPiIrjFlzs2HUh
        QrEzWmwC9loKdoUymC5ugHYthZKD9vyR+brdjLGCwxK+hxu7RsNMcDVvAAmectFYEOAap1oTZM48F
        4lfHD8O/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLur9-0004a4-Se; Wed, 01 May 2019 19:25:28 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E4CC2984EB4; Wed,  1 May 2019 21:25:25 +0200 (CEST)
Date:   Wed, 1 May 2019 21:25:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, jack@suse.com
Subject: Re: [RT WARNING] DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) !=
 current) with fsfreeze (4.19.25-rt16)
Message-ID: <20190501192525.GW7905@worktop.programming.kicks-ass.net>
References: <20190326093421.GA29508@localhost.localdomain>
 <20190419085627.GI4742@localhost.localdomain>
 <20190430125130.uw7mhdnsoqr2v3gf@linutronix.de>
 <20190430132811.GB2589@hirez.programming.kicks-ass.net>
 <20190501170953.GB2650@hirez.programming.kicks-ass.net>
 <ce854251-139e-15f1-2ac5-b66a27f8284c@redhat.com>
 <20190501185400.GQ7905@worktop.programming.kicks-ass.net>
 <20190501192234.rwwuntngpi5v4unq@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501192234.rwwuntngpi5v4unq@linux-r8p5>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, May 01, 2019 at 12:22:34PM -0700, Davidlohr Bueso wrote:
> On Wed, 01 May 2019, Peter Zijlstra wrote:
> 
> > Nah, the percpu_rwsem abuse by the freezer is atrocious, we really
> > should not encourage that. Also, it completely wrecks -RT.
> > 
> > Hence the proposed patch.
> 
> Is this patch (and removing rcuwait) only intended for rt?

Seeing how we want to have -rt upstream, and how horrible that current
fixup is; I'm tempted to say that barring a better solution, we'd want
this upstream.
