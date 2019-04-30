Return-Path: <SRS0=4n46=TA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D41C43219
	for <linux-rt-users@archiver.kernel.org>; Tue, 30 Apr 2019 13:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC74221670
	for <linux-rt-users@archiver.kernel.org>; Tue, 30 Apr 2019 13:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfD3Npv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 30 Apr 2019 09:45:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47342 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfD3Npv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 30 Apr 2019 09:45:51 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hLT4u-0000OZ-9a; Tue, 30 Apr 2019 15:45:48 +0200
Date:   Tue, 30 Apr 2019 15:45:48 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, jack@suse.com
Subject: Re: [RT WARNING] DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) !=
 current) with fsfreeze (4.19.25-rt16)
Message-ID: <20190430134547.lll7kjrslh3zat2b@linutronix.de>
References: <20190326093421.GA29508@localhost.localdomain>
 <20190419085627.GI4742@localhost.localdomain>
 <20190430125130.uw7mhdnsoqr2v3gf@linutronix.de>
 <20190430132811.GB2589@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190430132811.GB2589@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-04-30 15:28:11 [+0200], Peter Zijlstra wrote:
> On Tue, Apr 30, 2019 at 02:51:31PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-04-19 10:56:27 [+0200], Juri Lelli wrote:
> > > On 26/03/19 10:34, Juri Lelli wrote:
> > > > Hi,
> > > > 
> > > > Running this reproducer on a 4.19.25-rt16 kernel (with lock debugging
> > > > turned on) produces warning below.
> > > 
> > > And I now think this might lead to an actual crash.
> > 
> > Peter, could you please take a look at the thread:
> >   https://lkml.kernel.org/r/20190419085627.GI4742@localhost.localdomain
> > 
> > I assumed that returning to userland with acquired locks is something we
> > did not want…
> 
> Yeah, but AFAIK fs freezing code has a history of doing exactly that..
> This is just the latest incarnation here.
> 
> So the immediate problem here is that the task doing thaw isn't the same
> that did freeze, right? The thing is, I'm not seeing how that isn't a
> problem with upstream either.
> 
> The freeze code seems to do: percpu_down_write() for the various states,
> and then frobs lockdep state.
> 
> Thaw then does the reverse, frobs lockdep and then does: percpu_up_write().
> 
> percpu_down_write() directly relies on down_write(), and
> percpu_up_write() on up_write(). And note how __up_write() has:
> 
> 	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
> 
> So why isn't this same code coming unstuck in mainline?

I have to re-route most of this questions to Juri Lelli.
Lockdep has these gems:
	lockdep_sb_freeze_release() / lockdep_sb_freeze_acquire()

Sebastian
