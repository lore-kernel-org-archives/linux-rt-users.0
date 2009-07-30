From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [LTP] LTP RT Tests (Cyclic, rt-migrate, etc)
Date: Thu, 30 Jul 2009 14:42:02 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.0907301440460.21267@gandalf.stny.rr.com>
References: <1224509719.5152.116.camel@subratamodak.linux.ibm.com>  <1246890698.4887.24.camel@subratamodak.linux.ibm.com>  <1247076833.5405.48.camel@subratamodak.linux.ibm.com>  <200907102200.12804.sripathik@in.ibm.com>  <1247244446.5040.0.camel@subratamodak.linux.ibm.com>
  <4A57884C.10401@us.ibm.com>  <alpine.DEB.2.00.0907201039140.3858@gandalf.stny.rr.com>  <4A64A369.8040808@us.ibm.com> <1248978525.5788.55.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Darren Hart <dvhltc@us.ibm.com>,
	Sripathi Kodi <sripathik@in.ibm.com>,
	Gowrishankar <gomuthuk@linux.vnet.ibm.com>,
	ltp-list <ltp-list@lists.sf.net>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Clark Williams <clark.williams@gmail.com>
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:33635 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbZG3SmE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Jul 2009 14:42:04 -0400
In-Reply-To: <1248978525.5788.55.camel@subratamodak.linux.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 30 Jul 2009, Subrata Modak wrote:
> > 
> > Yup.  This is different than prio-wake.  Prio-wake creates some number 
> > of threads of varying priorities and puts them to sleep on 
> > pthread_cond_wait and then wakes them with pthread_cond_broadcast, then 
> > tests that the threads were woken in priority order.  Fails on 
> > kernels/glibc without requeue pi support as a FUTEX_WAKE(all) was used 
> > for PI mutexes.
> > 
> > So to include this in the ltp/restcases/realtime suite, the test should 
> > make use of the librttest.c and libstats.c apis, standardized argument 
> > parsing, buffered logging mechanism, and standardized output formatting. 
> >   I can't get to that for a little while myself, but can assist if you 
> > have any questions.  Alternatively we can wait a little while, and 
> > perhaps someone on my team will be able to help merge it with the 
> > realtime test infrastructure in LTP.
> 
> That should be fine.
> 

Note,

Please take the following code:

 http://rostedt.homelinux.com/code/rt-migrate-test.c

Because I got rid of the old logdev writes (ifdef out) and replaced it 
with ftrace. It tries to write to ftrace if possible, but if ftrace is not 
configured, it should just ignore it.

-- Steve

