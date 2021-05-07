Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C72C433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 20:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F26F861456
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 20:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhEGUE1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 16:04:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229905AbhEGUE0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 16:04:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B202961432;
        Fri,  7 May 2021 20:03:23 +0000 (UTC)
Date:   Fri, 7 May 2021 16:03:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Bajjuri, Praneeth" <praneeth@ti.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [ANNOUNCE] 5.10.30-rt37
Message-ID: <20210507160321.56164c3c@gandalf.local.home>
In-Reply-To: <c3b8a530-2ade-5876-5c93-7f83286796b8@ti.com>
References: <20210419184731.246fa474@gandalf.local.home>
        <c3b8a530-2ade-5876-5c93-7f83286796b8@ti.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 3 May 2021 15:39:19 -0500
"Bajjuri, Praneeth" <praneeth@ti.com> wrote:

> On 4/19/2021 5:47 PM, Steven Rostedt wrote:
> > On Tue, Apr 20, 2021,ycollette.nospam@free.fr  wrote:  
> >> net/xfrm/xfrm_state.c: In function 'xfrm_state_init':
> >> ./include/linux/seqlock.h:178:36: error: initialization of 'seqcount_spinlock_t *' {aka 'struct seqcount_spinlock *'} from incompatible pointer type 'seqcount_t *' {aka 'struct seqcount *'} [-Werror=incompatible-pointer-types]
> >>    178 |   seqcount_##lockname##_t *____s = (s);   \
> >>        |                                    ^  
> > ...  
> >> net/xfrm/xfrm_state.c:2666:2: note: in expansion of macro 'seqcount_spinlock_init'
> >>   2666 |  seqcount_spinlock_init(&net->xfrm.xfrm_state_hash_generation,
> >>        |  ^~~~~~~~~~~~~~~~~~~~~~  
> > There is a rebase error at:
> > 
> >    247560698349 ("Merge tag 'v5.10.30' into v5.10-rt")
> > 
> > Cherry-pick mainline's commit:
> > 
> >    bc8e0adff343 ("net: xfrm: Use sequence counter with associated spinlock")  
> 
> Thanks for this fix, Cherry-pick resolved rt stable integration issue 
> that i was seeing.
> 
> Is this fix going to be posted for v5.10-rt too ?
> 
> > 
> > and your compilation issue will be fixed.  

Yes, I'm pulling it in now (sorry for the delay).

For some reason, Yann's email never made it into my INBOX :-/

But cherry picking that commit appears to do the job. I'll pull that in,
and then start bringing 5.10 to the latest release.

-- Steve
