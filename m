From: Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: Re: realtime measurement tests: approach to criteria
Date: Tue, 04 Aug 2009 17:38:02 +0530
Message-ID: <1249387682.15587.32.camel@subratamodak.linux.ibm.com>
References: <4A7772FE.20808@us.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: LTP <ltp-list@lists.sourceforge.net>,
	Clark Williams <williams@redhat.com>,
	amrith <amrith@linux.ibm.com>,
	Sripathi Kodi <sripathik@in.ibm.com>
To: Darren Hart <dvhltc@us.ibm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:50549 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754790AbZHDMIN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Aug 2009 08:08:13 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n74CBxIZ029431
	for <linux-rt-users@vger.kernel.org>; Tue, 4 Aug 2009 08:11:59 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n74C8E4u248858
	for <linux-rt-users@vger.kernel.org>; Tue, 4 Aug 2009 08:08:14 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n74C8DD1010277
	for <linux-rt-users@vger.kernel.org>; Tue, 4 Aug 2009 08:08:13 -0400
In-Reply-To: <4A7772FE.20808@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Darren,

On Mon, 2009-08-03 at 16:30 -0700, Darren Hart wrote: 
> The current ltp/testcases/realtime tests belong to one of func, perf, or 
> stress.  While strict pass/fail criteria make sense for functional tests 
> (did the tasks wake up in priority order?), the others use "arbitrary" 
> values and compare those against the whatever is being measured (wakeup 
> latency, etc.) and then determine pass/fail.  Ideally the tests 
> themselves would not determine the pass/fail criteria, and would instead 
> simply report on their measurements since the criteria will vary in 
> every use-case based on requirements, workload, hardware, etc.
> 
> I'd like to propose an approach where the tests only report their 
> measured values (with the exception of the func/* tests which will 
> maintain their pass/fail criteria).  Users should be able to populate a 
> criteria.conf file that specified the criteria of each test.  The 
> results could then be parsed, compared against the results, and a 
> pass/fail determined from there.  I suspect it would be best for the .c 
> tests to just report the numbers and the statistics in a common format 
> and rely on python parser scripts to read the config file and determine 
> pass/fail from there.
> 
> I'd like users thoughts on this approach before we jump in and start 
> changing things (as this is a fairly invasive change).

This is indeed a good approach. Should we also ask the RT-USERS, who
might be interested to comment on this ?

Regards--
Subrata

> 

