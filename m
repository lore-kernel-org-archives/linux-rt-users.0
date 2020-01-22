Return-Path: <SRS0=RBrU=3L=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F57C2D0DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Jan 2020 19:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D667B2465B
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Jan 2020 19:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgAVTHK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:07:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgAVTHK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Jan 2020 14:07:10 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1864724655;
        Wed, 22 Jan 2020 19:07:09 +0000 (UTC)
Date:   Wed, 22 Jan 2020 14:07:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH RT 24/32] sched: migrate_enable: Use
 stop_one_cpu_nowait()
Message-ID: <20200122140707.6ac91fc8@gandalf.local.home>
In-Reply-To: <56d00d663e61abf7df7cdd91d8da98b4f9e5906e.camel@redhat.com>
References: <20200117174111.282847363@goodmis.org>
        <20200117174131.019724236@goodmis.org>
        <20200122083130.kuu3yppckhyjrr4u@linutronix.de>
        <20200122063311.52b68472@gandalf.local.home>
        <56d00d663e61abf7df7cdd91d8da98b4f9e5906e.camel@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 22 Jan 2020 12:39:14 -0600
Scott Wood <swood@redhat.com> wrote:

> On Wed, 2020-01-22 at 06:33 -0500, Steven Rostedt wrote:
> > On Wed, 22 Jan 2020 09:31:30 +0100
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >   
> > > On 2020-01-17 12:41:35 [-0500], Steven Rostedt wrote:  
> > > > 4.19.94-rt39-rc1 stable review patch.
> > > > If anyone has any objections, please let me know.    
> > > 
> > > I don't know how much of this patch and the previous is classified as
> > > "new feature" vs "bug fix". This patch requires patch 31 (of this
> > > series)
> > > as bug fix.
> > > I'm not against it, just pointing out.
> > >   
> > 
> > Hmm, the description looked more of a bug fix than a new feature.  
> 
> Yes, the state clobber was an existing bug.  Patch 23 was a performance
> improvement rather than a bugfix, though.
>

Some people consider performance improvements bug fixes ;-)

-- Steve
