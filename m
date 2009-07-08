From: Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: Re: [LTP] LTP RT Tests (Cyclic, rt-migrate, etc)
Date: Wed, 08 Jul 2009 23:43:53 +0530
Message-ID: <1247076833.5405.48.camel@subratamodak.linux.ibm.com>
References: <1224509719.5152.116.camel@subratamodak.linux.ibm.com>
	 <1224840077.5270.69.camel@subratamodak.linux.ibm.com>
	 <alpine.DEB.1.10.0810240749470.25677@gandalf.stny.rr.com>
	 <1229093480.5171.60.camel@subratamodak.linux.ibm.com>
	 <alpine.DEB.1.10.0812121533350.29763@gandalf.stny.rr.com>
	 <1229347938.5353.8.camel@subratamodak.linux.ibm.com>
	 <alpine.DEB.1.10.0812150851290.18692@gandalf.stny.rr.com>
	 <1245768486.4860.53.camel@subratamodak.linux.ibm.com>
	 <alpine.DEB.2.00.0907061024200.8813@gandalf.stny.rr.com>
	 <1246890698.4887.24.camel@subratamodak.linux.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: ltp-list <ltp-list@lists.sf.net>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Clark Williams <clark.williams@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>
To: dvhltc <dvhltc@linux.vnet.ibm.com>,
	Sripathi Kodi <sripathik@linux.vnet.ibm.com>,
	Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:34096 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754499AbZGHSOF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Jul 2009 14:14:05 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n68I8u1x026769
	for <linux-rt-users@vger.kernel.org>; Wed, 8 Jul 2009 14:08:56 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n68IE1Rr256714
	for <linux-rt-users@vger.kernel.org>; Wed, 8 Jul 2009 14:14:02 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n68IDxN0008533
	for <linux-rt-users@vger.kernel.org>; Wed, 8 Jul 2009 14:14:00 -0400
In-Reply-To: <1246890698.4887.24.camel@subratamodak.linux.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Darren/Sri/Gowri,

Where do you want me to put this exactly inside the RT tree ?

Regards--
Subrata

On Mon, 2009-07-06 at 20:01 +0530, Subrata Modak wrote: 
> On Mon, 2009-07-06 at 10:26 -0400, Steven Rostedt wrote:
> > 
> > On Tue, 23 Jun 2009, Subrata Modak wrote:
> > 
> > > Steven,
> > > 
> > > Do you remember this ?
> > 
> > Yes, and I finally got time to fix it up a little ;-)
> 
> Great. Forwarding to the ltp mailing list as well. Thanks steven.
> 
> Regards--
> Subrata
> 
> > 
> > OK, here it is. To run it, just do:
> > 
> >  ./rt-migrate-test -c 
> > 
> > You need to be root since it changes the priorities. It will check the 
> > number of processors and create N+1 threads (where N is the number of 
> > processors). Each thread will wake up at the same time and try to do a 
> > busy loop for 20 millisecs. If a lower prio thread runs for 1ms before a 
> > higher prio thread, it will fail. This should test the migration of the 
> > threads to make sure that the higher prio threads run first.
> > 
> > Sorry for taking so long.
> > 
> > -- Steve
> > 
> > 
> > 
> > > 
> > > Regards--
> > > Subrata
> > > 
> > > On Mon, 2008-12-15 at 08:52 -0500, Steven Rostedt wrote: 
> > > > On Mon, 15 Dec 2008, Subrata Modak wrote:
> > > > > > 
> > > > > > Lets see, you wanted my rt migration test. I'll clean that up now. Is 
> > > > > 
> > > > > Oh yes.
> > > > 
> > > > OK, I'm cleaning it up to be more for production use.
> > > > 
> > > > > 
> > > > > > there something else I needed to send you? If you remember.
> > > > > 
> > > > > I am not quite sure now. Will let you know in future.
> > > > 
> > > > OK, thanks,
> > > > 
> > > > -- Steve
> > > > 
> > > 
> > > 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

