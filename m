Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EDAC433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Nov 2021 20:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8B31617E4
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Nov 2021 20:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhKPU2e (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Nov 2021 15:28:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229733AbhKPU2e (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Nov 2021 15:28:34 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32DD561ABD;
        Tue, 16 Nov 2021 20:25:36 +0000 (UTC)
Date:   Tue, 16 Nov 2021 15:25:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Jun Miao <jun.miao@windriver.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.10-rt+] drm/i915/gt: transform irq_disable into
 local_lock.
Message-ID: <20211116152534.122f8357@gandalf.local.home>
In-Reply-To: <20211009164908.GA21269@zipoli.concurrent-rt.com>
References: <20211007165928.GA43890@zipoli.concurrent-rt.com>
        <20211007171929.hegwwqelf46skjyw@linutronix.de>
        <20211009164908.GA21269@zipoli.concurrent-rt.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, 9 Oct 2021 12:49:08 -0400
Joe Korty <joe.korty@concurrent-rt.com> wrote:

> On Thu, Oct 07, 2021 at 07:19:29PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2021-10-07 12:59:28 [-0400], Joe Korty wrote:  
> > > Convert IRQ blocking in intel_breadcrumbs_park() to a local lock.
> > > 
> > > Affects 5.10-rt and all later releases, up to and including when
> > > rt was merged into mainline.  
> > 
> > RT was merged into mainline? Nobody tells me anything anymore??? 
> >   
> > > This problem has been reported in two other linux-rt-users postings,
> > >   
> > >    [PREEMPT_RT] i915: fix PREEMPT_RT locking splats (Clark Williams)
> > >    [linux-5.12.y-rt] drm/i915/gt: Fix a lockdep warning with interrupts enabled (Jun Miao)
> > > 
> > > Neither of these submit the obvious solution, nor,
> > > AFAICT, has either yet been acted on.  So I muddy the
> > > waters further by submitting this, a third fix.  
> > 
> > 5.12 is longer maintained. Could you please take the latest devel tree
> > for testing and participate in
> >   https://lore.kernel.org/all/20211005150046.1000285-1-bigeasy@linutronix.de/
> > 
> > If anything I would prefer those patches backported into v5.10 if it is
> > affected.  
> 
> 
> Hi Sebastian,
> Please add my 'Tested-by' to the below patch.  
> 
>    [linux-5.12.y-rt] drm/i915/gt: Fix a lockdep warning with interrupts enabled (Jun Miao)
> 
> What was tested was a backport to 5.10-rt.  One reject
> was encountered, trivially resolved.  No other adjustments
> were made.
> 
> My regression tests of last night all passed without any
> of the usual lockdep splats occuring.  Prior to this,
> I could be assured of a large enough flood of splats to
> overwhelm the kernel log.
> 
> My test stand is a Supermicro C7Z170-SQ.  This is tthe
> only system I have on which I could trigger the problem.
> 
> I could not find this patch in the 5.12-rt or the 5.15-rt
> tree, so I fetched a copy out of the linux-rt-users
> archives, and backported that.
> 
> Tested-by: Joe Korty <joe.korty@concurrent-rt.com>

I'm looking to see what needs to be added to 5.10-rt. Is there a particular
fix in one of the 5.x-rt trees (x > 10) that I can pull from? Or is this
only an issue with 5.10 and below?

-- Steve
