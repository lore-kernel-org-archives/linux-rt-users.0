From: Gerrit Binnenmars <gerritbinnenmars@wanadoo.nl>
Subject: Re: CONFIG_CRITICAL_IRQSOFF_TIMING
Date: Tue, 30 Oct 2007 22:26:57 +0100 (CET)
Message-ID: <25376807.1614051193779617681.JavaMail.www@wwinf6102>
Reply-To: gerritbinnenmars@wanadoo.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-2.orange.nl ([193.252.22.242]:13729 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752651AbXJ3V07 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Oct 2007 17:26:59 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6108.orange.nl (SMTP Server) with ESMTP id B544070000AE
	for <linux-rt-users@vger.kernel.org>; Tue, 30 Oct 2007 22:26:57 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> Datum: 30/10/07 10:11 PM
> Van: "Daniel Walker" 
> Aan: gerritbinnenmars@wanadoo.nl
> CC: linux-rt-users@vger.kernel.org
> Onderwerp : Re: CONFIG_CRITICAL_IRQSOFF_TIMING
> 
> On Tue, 2007-10-30 at 22:09 +0100, Gerrit Binnenmars wrote:
> > > Datum: 30/10/07 10:02 PM
> > > Van: "Daniel Walker" 
> > > Aan: gerritbinnenmars@wanadoo.nl
> > > CC: linux-rt-users@vger.kernel.org
> > > Onderwerp : Re: CONFIG_CRITICAL_IRQSOFF_TIMING
> > > 
> > > On Tue, 2007-10-30 at 21:52 +0100, Gerrit Binnenmars wrote:
> > > 
> > > > CONFIG_LTT_PROBE_LOCKING=m
> > > > # CONFIG_LTT_PROBE_STACK is not set
> > > 
> > > I wonder which kernel your using? I don't recall LTT being part of real
> > > time in the past .. What the architecture too ?
> > 
> > Hello Daniel,
> > I use version 2.6.22.1-rt4, see the following link for LTT compatibility
> > http://ltt.polymtl.ca/svn/ltt/branches/poly/doc/developer/lttng-lttv-compatibility.html
> > 
> > I have used LTT on both i386 an on a PowerPC (MPC8555) architecture.
> > It is a great help in understanding real-time behaviour.
> 
> Did you add LTT into your kernel on your own?
> 
> Daniel
> 
> 
>
Daniel, I first applied the rt patchset and then the LTTng patch 
(http://ltt.polymtl.ca/lttng/patch-2.6.22.1-rt4-lttng-0.9.10.tar.gz).
Then LTT can be selected in the Instrumentation part of the config file. 
further ltt-control is needed (http://ltt.polymtl.ca/lttng/ltt-control-0.43-10082007.tar.gz)

The viewer is only working on i386 but that is not really a problem.

So, I applied the available patches without doing anything special.
Is LTT causing troubles with the preempt_max_latency options?

Gerrit 
