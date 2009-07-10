From: Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: Re: [LTP] LTP RT Tests (Cyclic, rt-migrate, etc)
Date: Fri, 10 Jul 2009 22:17:25 +0530
Message-ID: <1247244446.5040.0.camel@subratamodak.linux.ibm.com>
References: <1224509719.5152.116.camel@subratamodak.linux.ibm.com>
	 <1246890698.4887.24.camel@subratamodak.linux.ibm.com>
	 <1247076833.5405.48.camel@subratamodak.linux.ibm.com>
	 <200907102200.12804.sripathik@in.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: dvhltc <dvhltc@linux.vnet.ibm.com>,
	Sripathi Kodi <sripathik@linux.vnet.ibm.com>,
	Gowrishankar <gomuthuk@linux.vnet.ibm.com>,
	ltp-list <ltp-list@lists.sf.net>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Clark Williams <clark.williams@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sripathi Kodi <sripathik@in.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:44330 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbZGJQrj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Jul 2009 12:47:39 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e39.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n6AGh9Sp006667
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2009 10:43:09 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n6AGlZ2g107022
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2009 10:47:35 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n6AGlYee002822
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2009 10:47:35 -0600
In-Reply-To: <200907102200.12804.sripathik@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2009-07-10 at 22:00 +0530, Sripathi Kodi wrote:
> On Wednesday 08 July 2009 23:43:53 Subrata Modak wrote:
> > Darren/Sri/Gowri,
> > 
> > Where do you want me to put this exactly inside the RT tree ?
> 
> Hi Subrata,
> 
> Going by how the tests are organized currently, I think this should go
> into it's own directory under testcases/realtime/func. We will need to
> add a makefile to it. Are you looking at us to help you with this?

Correct. Please send me a patch which integrates it into RT tests build,
install & run.

Regards--
Subrata

> 
> Thanks,
> Sripathi.
> 
> > 
> > Regards--
> > Subrata
> > 
> > On Mon, 2009-07-06 at 20:01 +0530, Subrata Modak wrote: 
> > > On Mon, 2009-07-06 at 10:26 -0400, Steven Rostedt wrote:
> > > > 
> > > > On Tue, 23 Jun 2009, Subrata Modak wrote:
> > > > 
> > > > > Steven,
> > > > > 
> > > > > Do you remember this ?
> > > > 
> > > > Yes, and I finally got time to fix it up a little ;-)
> > > 
> > > Great. Forwarding to the ltp mailing list as well. Thanks steven.
> > > 
> > > Regards--
> > > Subrata
> > > 
> > > > 
> > > > OK, here it is. To run it, just do:
> > > > 
> > > >  ./rt-migrate-test -c 
> > > > 
> > > > You need to be root since it changes the priorities. It will check the 
> > > > number of processors and create N+1 threads (where N is the number of 
> > > > processors). Each thread will wake up at the same time and try to do a 
> > > > busy loop for 20 millisecs. If a lower prio thread runs for 1ms before a 
> > > > higher prio thread, it will fail. This should test the migration of the 
> > > > threads to make sure that the higher prio threads run first.
> > > > 
> > > > Sorry for taking so long.
> > > > 
> > > > -- Steve
> > > > 
> > > > 
> > > > 
> > > > > 
> > > > > Regards--
> > > > > Subrata
> > > > > 
> > > > > On Mon, 2008-12-15 at 08:52 -0500, Steven Rostedt wrote: 
> > > > > > On Mon, 15 Dec 2008, Subrata Modak wrote:
> > > > > > > > 
> > > > > > > > Lets see, you wanted my rt migration test. I'll clean that up now. Is 
> > > > > > > 
> > > > > > > Oh yes.
> > > > > > 
> > > > > > OK, I'm cleaning it up to be more for production use.
> > > > > > 
> > > > > > > 
> > > > > > > > there something else I needed to send you? If you remember.
> > > > > > > 
> > > > > > > I am not quite sure now. Will let you know in future.
> > > > > > 
> > > > > > OK, thanks,
> > > > > > 
> > > > > > -- Steve
> > > > > > 
> > > > > 
> > > > > 
> > > ------------------------------------------------------------------------------
> > > _______________________________________________
> > > Ltp-list mailing list
> > > Ltp-list@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/ltp-list
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 

