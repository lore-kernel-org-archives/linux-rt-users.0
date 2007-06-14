From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] fix migrating softirq [cause of network hang]
Date: Thu, 14 Jun 2007 09:08:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0706140907570.32607@gandalf.stny.rr.com>
References: <1181738836.10408.54.camel@localhost.localdomain>
 <200706140002.17411.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	john stultz <johnstul@us.ibm.com>
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:58579 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbXFNNJP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Jun 2007 09:09:15 -0400
In-Reply-To: <200706140002.17411.dvhltc@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 14 Jun 2007, Darren Hart wrote:

> On Wednesday 13 June 2007 05:47:16 Steven Rostedt wrote:
>
> >
> > I'm assuming that this fix may fix other bugs too.
> >
>
> I ran 2.6.21-rt10 + this patch with kernbench and then loops building a kernel
> (which would previously rapidly exhaust memory).  It successfully built 400
> kernels with "make -j 32" on an 8 opteron machine with 8 GB of RAM and has so
> far completed 25 "make -j" on the same system.  Looks like a winner to me so
> far.
>


This is great news! Darren (and team), thanks a lot for testing it.

-- Steve
