From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: realtime measurement tests: approach to criteria
Date: Tue, 04 Aug 2009 07:28:00 -0700
Message-ID: <4A784570.4080201@us.ibm.com>
References: <4A7772FE.20808@us.ibm.com> <1249387682.15587.32.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LTP <ltp-list@lists.sourceforge.net>,
	Clark Williams <williams@redhat.com>,
	amrith <amrith@linux.ibm.com>,
	Sripathi Kodi <sripathik@in.ibm.com>
To: subrata@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:41549 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754530AbZHDO2D (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Aug 2009 10:28:03 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n74ERYL3029491
	for <linux-rt-users@vger.kernel.org>; Tue, 4 Aug 2009 10:27:34 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n74ES3mY238978
	for <linux-rt-users@vger.kernel.org>; Tue, 4 Aug 2009 10:28:03 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n74ES2SC022219
	for <linux-rt-users@vger.kernel.org>; Tue, 4 Aug 2009 10:28:03 -0400
In-Reply-To: <1249387682.15587.32.camel@subratamodak.linux.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Subrata Modak wrote:
> Hi Darren,
> 
> On Mon, 2009-08-03 at 16:30 -0700, Darren Hart wrote: 
>> The current ltp/testcases/realtime tests belong to one of func, perf, or 
>> stress.  While strict pass/fail criteria make sense for functional tests 
>> (did the tasks wake up in priority order?), the others use "arbitrary" 
>> values and compare those against the whatever is being measured (wakeup 
>> latency, etc.) and then determine pass/fail.  Ideally the tests 
>> themselves would not determine the pass/fail criteria, and would instead 
>> simply report on their measurements since the criteria will vary in 
>> every use-case based on requirements, workload, hardware, etc.
>>
>> I'd like to propose an approach where the tests only report their 
>> measured values (with the exception of the func/* tests which will 
>> maintain their pass/fail criteria).  Users should be able to populate a 
>> criteria.conf file that specified the criteria of each test.  The 
>> results could then be parsed, compared against the results, and a 
>> pass/fail determined from there.  I suspect it would be best for the .c 
>> tests to just report the numbers and the statistics in a common format 
>> and rely on python parser scripts to read the config file and determine 
>> pass/fail from there.
>>
>> I'd like users thoughts on this approach before we jump in and start 
>> changing things (as this is a fairly invasive change).
> 
> This is indeed a good approach. Should we also ask the RT-USERS, who
> might be interested to comment on this ?

Thanks for including the rt-users list, yes I should have done that 
originally as well.

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
