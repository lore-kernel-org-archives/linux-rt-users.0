From: Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: Re: 2.6.25.4-rt4
Date: Tue, 03 Jun 2008 20:18:02 +0530
Message-ID: <1212504482.4715.29.camel@subratamodak.linux.ibm.com>
References: <1212076754.24785.18.camel@localhost.localdomain>
	 <1212324634.4678.5.camel@subratamodak.linux.ibm.com>
	 <Pine.LNX.4.58.0806021332150.10366@gandalf.stny.rr.com>
Reply-To: subrata@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	ltp-list <ltp-list@lists.sourceforge.net>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:46263 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754096AbYFCOsV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Jun 2008 10:48:21 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m53Em7Yi029949
	for <linux-rt-users@vger.kernel.org>; Tue, 3 Jun 2008 10:48:07 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m53Em75e041354
	for <linux-rt-users@vger.kernel.org>; Tue, 3 Jun 2008 10:48:07 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m53Em6St008493
	for <linux-rt-users@vger.kernel.org>; Tue, 3 Jun 2008 10:48:06 -0400
In-Reply-To: <Pine.LNX.4.58.0806021332150.10366@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2008-06-02 at 13:42 -0400, Steven Rostedt wrote:
> On Sun, 1 Jun 2008, Subrata Modak wrote:
> 
> >
> > Dear Steve,
> >
> > I am hopeful that you might know that we have started to maintain RT
> > linux test cases inside Linux Test Project (http://ltp.sourceforge.net/)
> > from Dec 2007 onwards. With initial integration from IBM, these set of
> > test cases has been enriched so far from IBM, BULL and PENGUTRONICS.
> > Would you like to review them at:
> > http://ltp.cvs.sourceforge.net/ltp/ltp/testcases/realtime/.
> >
> > I am hopeful that you can give me an idea of how these test cases are in
> > sync with your RT tree releases, and also find out the gaps where more
> > testing and hence test cases needs to be done/added.
> >
> 
> Hi,
> 
> Thanks, they should all stay in sync since they are userland tools and we
> try to keep the user API the same. But, with that said, the ftrace code is
> still under development, and some of the tests do interact with it. I'll
> try to remember to send patches to keep them updated.

Thanks Steve for your forthcoming help and contribution. I will also
meanwhile keep you in loop for all the RT tests updates if any in LTP.

Regards--
Subrata

> 
> Thanks,
> 
> -- Steve
> 

