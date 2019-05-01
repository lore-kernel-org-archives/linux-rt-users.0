Return-Path: <SRS0=Byy1=TB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95FEC43219
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 May 2019 18:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDC920675
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 May 2019 18:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cZtAbaPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfEASyL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 May 2019 14:54:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47624 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfEASyL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 May 2019 14:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mIUlTqn6wXkiuEWJTRY2AWbGrT0fqFXBa6GVgICMsZg=; b=cZtAbaPU0seeywoUsS+mL9FNN
        wgQK8SIjmW4Ud5TVI4TTGPQA03RBCRkmxIK9mDDrB28g2tmT/pcfJLbkHFxdOtZRhlYkNpdvqLiD7
        2+quQLFdEjQCrQGvWHbziSUuc7curcbqYaVcrIcPXsFOYJK0CGj6yOnPKKuRnpm94pXp+oz6i6IIo
        8rE+WFEeqapcu32Rupj1qi6mCbEvUpSv3fLD0cLrEKwhOrZF7IfVD8JS0lA5i7z+LcLTVx+LV7bKG
        tAe+ZtyymPighUulm2vDyqJ8lWCN+RleTtSYh81nrsjeyomD5WO3fUzwxf8N7zmraQQ8Q64FougBk
        c592qFNGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLuMm-0002oG-3g; Wed, 01 May 2019 18:54:04 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4DB27984EB4; Wed,  1 May 2019 20:54:00 +0200 (CEST)
Date:   Wed, 1 May 2019 20:54:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, jack@suse.com,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RT WARNING] DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) !=
 current) with fsfreeze (4.19.25-rt16)
Message-ID: <20190501185400.GQ7905@worktop.programming.kicks-ass.net>
References: <20190326093421.GA29508@localhost.localdomain>
 <20190419085627.GI4742@localhost.localdomain>
 <20190430125130.uw7mhdnsoqr2v3gf@linutronix.de>
 <20190430132811.GB2589@hirez.programming.kicks-ass.net>
 <20190501170953.GB2650@hirez.programming.kicks-ass.net>
 <ce854251-139e-15f1-2ac5-b66a27f8284c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce854251-139e-15f1-2ac5-b66a27f8284c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, May 01, 2019 at 01:26:08PM -0400, Waiman Long wrote:
> On 5/1/19 1:09 PM, Peter Zijlstra wrote:
> > On Tue, Apr 30, 2019 at 03:28:11PM +0200, Peter Zijlstra wrote:
> >
> >> Yeah, but AFAIK fs freezing code has a history of doing exactly that..
> >> This is just the latest incarnation here.
> >>
> >> So the immediate problem here is that the task doing thaw isn't the same
> >> that did freeze, right? The thing is, I'm not seeing how that isn't a
> >> problem with upstream either.
> >>
> >> The freeze code seems to do: percpu_down_write() for the various states,
> >> and then frobs lockdep state.
> >>
> >> Thaw then does the reverse, frobs lockdep and then does: percpu_up_write().
> >>
> >> percpu_down_write() directly relies on down_write(), and
> >> percpu_up_write() on up_write(). And note how __up_write() has:
> >>
> >> 	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
> >>
> >> So why isn't this same code coming unstuck in mainline?
> 
> That code is in just in the tip tree. It is not in the mainline yet. I
> do realize that it can be a problem and so I have it modified to the
> following in my part2 patchset.

Nah, the percpu_rwsem abuse by the freezer is atrocious, we really
should not encourage that. Also, it completely wrecks -RT.

Hence the proposed patch.
