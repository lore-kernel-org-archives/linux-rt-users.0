From: Sripathi Kodi <sripathik@in.ibm.com>
Subject: Re: [LTP] LTP RT Tests (Cyclic, rt-migrate, etc)
Date: Fri, 10 Jul 2009 22:00:12 +0530
Message-ID: <200907102200.12804.sripathik@in.ibm.com>
References: <1224509719.5152.116.camel@subratamodak.linux.ibm.com> <1246890698.4887.24.camel@subratamodak.linux.ibm.com> <1247076833.5405.48.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: dvhltc <dvhltc@linux.vnet.ibm.com>,
	Sripathi Kodi <sripathik@linux.vnet.ibm.com>,
	Gowrishankar <gomuthuk@linux.vnet.ibm.com>,
	"ltp-list" <ltp-list@lists.sf.net>,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Clark Williams <clark.williams@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>
To: subrata@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:52322 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbZGJQaR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Jul 2009 12:30:17 -0400
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp08.au.ibm.com (8.13.1/8.13.1) with ESMTP id n6B2N0Wd004921
	for <linux-rt-users@vger.kernel.org>; Sat, 11 Jul 2009 12:23:00 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n6AGUF8O414084
	for <linux-rt-users@vger.kernel.org>; Sat, 11 Jul 2009 02:30:15 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n6AGUEkt026305
	for <linux-rt-users@vger.kernel.org>; Sat, 11 Jul 2009 02:30:15 +1000
In-Reply-To: <1247076833.5405.48.camel@subratamodak.linux.ibm.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wednesday 08 July 2009 23:43:53 Subrata Modak wrote:
> Darren/Sri/Gowri,
> 
> Where do you want me to put this exactly inside the RT tree ?

Hi Subrata,

Going by how the tests are organized currently, I think this should go
into it's own directory under testcases/realtime/func. We will need to
add a makefile to it. Are you looking at us to help you with this?

Thanks,
Sripathi.

> 
> Regards--
> Subrata
> 
> On Mon, 2009-07-06 at 20:01 +0530, Subrata Modak wrote: 
> > On Mon, 2009-07-06 at 10:26 -0400, Steven Rostedt wrote:
> > > 
> > > On Tue, 23 Jun 2009, Subrata Modak wrote:
> > > 
> > > > Steven,
> > > > 
> > > > Do you remember this ?
> > > 
> > > Yes, and I finally got time to fix it up a little ;-)
> > 
> > Great. Forwarding to the ltp mailing list as well. Thanks steven.
> > 
> > Regards--
> > Subrata
> > 
> > > 
> > > OK, here it is. To run it, just do:
> > > 
> > >  ./rt-migrate-test -c 
> > > 
> > > You need to be root since it changes the priorities. It will check the 
> > > number of processors and create N+1 threads (where N is the number of 
> > > processors). Each thread will wake up at the same time and try to do a 
> > > busy loop for 20 millisecs. If a lower prio thread runs for 1ms before a 
> > > higher prio thread, it will fail. This should test the migration of the 
> > > threads to make sure that the higher prio threads run first.
> > > 
> > > Sorry for taking so long.
> > > 
> > > -- Steve
> > > 
> > > 
> > > 
> > > > 
> > > > Regards--
> > > > Subrata
> > > > 
> > > > On Mon, 2008-12-15 at 08:52 -0500, Steven Rostedt wrote: 
> > > > > On Mon, 15 Dec 2008, Subrata Modak wrote:
> > > > > > > 
> > > > > > > Lets see, you wanted my rt migration test. I'll clean that up now. Is 
> > > > > > 
> > > > > > Oh yes.
> > > > > 
> > > > > OK, I'm cleaning it up to be more for production use.
> > > > > 
> > > > > > 
> > > > > > > there something else I needed to send you? If you remember.
> > > > > > 
> > > > > > I am not quite sure now. Will let you know in future.
> > > > > 
> > > > > OK, thanks,
> > > > > 
> > > > > -- Steve
> > > > > 
> > > > 
> > > > 
> > ------------------------------------------------------------------------------
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
