From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [LTP] LTP RT Tests (Cyclic, rt-migrate, etc)
Date: Thu, 30 Jul 2009 12:49:56 -0700
Message-ID: <4A71F964.1060507@us.ibm.com>
References: <1224509719.5152.116.camel@subratamodak.linux.ibm.com> <1246890698.4887.24.camel@subratamodak.linux.ibm.com> <1247076833.5405.48.camel@subratamodak.linux.ibm.com> <200907102200.12804.sripathik@in.ibm.com> <1247244446.5040.0.camel@subratamodak.linux.ibm.com> <4A57884C.10401@us.ibm.com> <alpine.DEB.2.00.0907201039140.3858@gandalf.stny.rr.com> <4A64A369.8040808@us.ibm.com> <1248978525.5788.55.camel@subratamodak.linux.ibm.com> <alpine.DEB.2.00.0907301440460.21267@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Subrata Modak <subrata@linux.vnet.ibm.com>,
	Sripathi Kodi <sripathik@in.ibm.com>,
	Gowrishankar <gomuthuk@linux.vnet.ibm.com>,
	ltp-list <ltp-list@lists.sf.net>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Clark Williams <clark.williams@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:52630 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbZG3TuA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Jul 2009 15:50:00 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6UJjGM8003815
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Jul 2009 13:45:17 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n6UJo0DI258726
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Jul 2009 13:50:00 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n6UJnwMB029333
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Jul 2009 13:49:59 -0600
In-Reply-To: <alpine.DEB.2.00.0907301440460.21267@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steven Rostedt wrote:
> 
> On Thu, 30 Jul 2009, Subrata Modak wrote:
>>> Yup.  This is different than prio-wake.  Prio-wake creates some number 
>>> of threads of varying priorities and puts them to sleep on 
>>> pthread_cond_wait and then wakes them with pthread_cond_broadcast, then 
>>> tests that the threads were woken in priority order.  Fails on 
>>> kernels/glibc without requeue pi support as a FUTEX_WAKE(all) was used 
>>> for PI mutexes.
>>>
>>> So to include this in the ltp/restcases/realtime suite, the test should 
>>> make use of the librttest.c and libstats.c apis, standardized argument 
>>> parsing, buffered logging mechanism, and standardized output formatting. 
>>>   I can't get to that for a little while myself, but can assist if you 
>>> have any questions.  Alternatively we can wait a little while, and 
>>> perhaps someone on my team will be able to help merge it with the 
>>> realtime test infrastructure in LTP.
>> That should be fine.
>>
> 
> Note,
> 
> Please take the following code:
> 
>  http://rostedt.homelinux.com/code/rt-migrate-test.c
> 
> Because I got rid of the old logdev writes (ifdef out) and replaced it 
> with ftrace. It tries to write to ftrace if possible, but if ftrace is not 
> configured, it should just ignore it.

Just to be clear, Steven you want us to modify this test case so that it 
uses the librttest facilities, including those for standardized argument 
parsing, buffered out, and thread creation, then commit this to the 
repository?  I don't feel it should go in without those changes.  We've 
expended a lot of effort making the tests in ltp/realtime be consistent 
in those areas (they all use some common command line arguments and 
coding styles).  This ensures that they can be easily maintained along 
with the other tests in the suite and that users can know what to expect 
from the test in terms of output, etc.

Thanks,

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
