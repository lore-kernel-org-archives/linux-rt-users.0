From: Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: Re: [LTP] LTP RT Tests (Cyclic, rt-migrate, etc)
Date: Thu, 30 Jul 2009 23:58:45 +0530
Message-ID: <1248978525.5788.55.camel@subratamodak.linux.ibm.com>
References: <1224509719.5152.116.camel@subratamodak.linux.ibm.com>
	 <1246890698.4887.24.camel@subratamodak.linux.ibm.com>
	 <1247076833.5405.48.camel@subratamodak.linux.ibm.com>
	 <200907102200.12804.sripathik@in.ibm.com>
	 <1247244446.5040.0.camel@subratamodak.linux.ibm.com>
	 <4A57884C.10401@us.ibm.com>
	 <alpine.DEB.2.00.0907201039140.3858@gandalf.stny.rr.com>
	 <4A64A369.8040808@us.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Sripathi Kodi <sripathik@in.ibm.com>,
	Gowrishankar <gomuthuk@linux.vnet.ibm.com>,
	ltp-list <ltp-list@lists.sf.net>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Clark Williams <clark.williams@gmail.com>
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:53070 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbZG3S3A (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Jul 2009 14:29:00 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6UIPWRv022453
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Jul 2009 12:25:32 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n6UISsOd197262
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Jul 2009 12:28:57 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n6UISqT1001981
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Jul 2009 12:28:54 -0600
In-Reply-To: <4A64A369.8040808@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2009-07-20 at 10:03 -0700, Darren Hart wrote: 
> Steven Rostedt wrote:
> > On Fri, 10 Jul 2009, Darren Hart wrote:
> > 
> >> Subrata Modak wrote:
> >>> On Fri, 2009-07-10 at 22:00 +0530, Sripathi Kodi wrote:
> >>>> On Wednesday 08 July 2009 23:43:53 Subrata Modak wrote:
> >>>>> Darren/Sri/Gowri,
> >>>>>
> >>>>> Where do you want me to put this exactly inside the RT tree ?
> >>>> Hi Subrata,
> >>>>
> >>>> Going by how the tests are organized currently, I think this should go
> >>>> into it's own directory under testcases/realtime/func. We will need to
> >>>> add a makefile to it. Are you looking at us to help you with this?
> >>> Correct. Please send me a patch which integrates it into RT tests build,
> >>> install & run.
> >> Just got back from a week vacation and am burning through mail as fast as I
> >> can :-) Haven't had a look yet, but does this test use librttest.h?  I suspect
> >> not.  We'll need to adapt it to run within the existing ltp real-time testing
> >> framework, which includes things like buffered output as well as mlocking
> >> support.
> >>
> >> Lastly, I'm not sure this test does anything effectively different than
> >> prio-wake, already in the tree.  My other concerns with the test are its
> >> explicit 1ms preemption criteria (as Steven described it anyway).  We are
> >> trying to move away from criteria being inherent in measurement tests, and 1
> >> ms seems like an awfully long priority inversion to be an acceptable criteria
> >> to many users.
> >>
> >> Steven, am I missing something conceptually here?
> > 
> > Hmm, I missed this email, sorry for the late reply.
> > 
> > What does prio-wake do?
> > 
> > This test is what I used to develop the rt scheduler in mainline (as well 
> > as in -rt).  It wakes up N+1 tasks with lowering real time priorities. 
> > Where N is the number of CPUs in the system. Then it makes sure that the 
> > these tasks spread out across the CPUs. Most tests just test the highest 
> > priority task in the system. But those tests usually miss the second 
> > highest prio task in the system. If you have a second highest prio task in 
> > the system and a CPU is available to run, then it should run on that CPU. 
> > But what happens is that it can wait to be migrated and can take millisecs 
> > to wake up.
> > 
> > This test makes sure that all the high prio tasks that are in the running 
> > state are actually running on a CPU if it can.
> > 
> > Make sense?
> 
> Yup.  This is different than prio-wake.  Prio-wake creates some number 
> of threads of varying priorities and puts them to sleep on 
> pthread_cond_wait and then wakes them with pthread_cond_broadcast, then 
> tests that the threads were woken in priority order.  Fails on 
> kernels/glibc without requeue pi support as a FUTEX_WAKE(all) was used 
> for PI mutexes.
> 
> So to include this in the ltp/restcases/realtime suite, the test should 
> make use of the librttest.c and libstats.c apis, standardized argument 
> parsing, buffered logging mechanism, and standardized output formatting. 
>   I can't get to that for a little while myself, but can assist if you 
> have any questions.  Alternatively we can wait a little while, and 
> perhaps someone on my team will be able to help merge it with the 
> realtime test infrastructure in LTP.

That should be fine.

Regards--
Subrata

> 
> > 
> > (BTW, current -rt and mainline now fail this test :-? )
> 
> Hrm, uh oh.  Adding it to my lengthy list of things to try and look at :/
> 
> Thanks Steve,
> 

