From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: [PATCH 2/2] add-smp-option-to-svsematest.patch
Date: Tue, 09 Mar 2010 22:07:27 +0100
Message-ID: <4B96B88F.8050709@osadl.org>
References: <20100307204800.456744470@osadl.org>	 <20100307204909.626988443@osadl.org> <4B968F2B.4070708@redhat.com> <520f0cf11003091015i4c474939i8086cdd2bf98a438@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Sommerseth <davids@redhat.com>,
	RT-users <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:52657 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754783Ab0CIVKY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Mar 2010 16:10:24 -0500
In-Reply-To: <520f0cf11003091015i4c474939i8086cdd2bf98a438@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

John,

>>> -             if (priority > 0)
>>> +             if (priority > 1 && !sameprio)
>>>                       priority--;
>> Unless I'm missing something really obvious, shouldn't this one state:
>>        if (priority > 0 && !sameprio)
>>                priority--;
>> Or else 1 will be the lowest priority.  It's a similar situation in
>> "[PATCH 1/2] add-smp-option-to-ptsematest.patch" as well.
> Carsten, is it useful to have SCHED_OTHER for this test?
Don't think so. These tests (svsematest, ptsematest etc.) are intended
as additional tests to cyclictest. I used them to make sure that the
implementations of the various semaphore mechanisms (that mostly boil
down to the same kernel code) do not introduce additional latencies. It
may be sufficient to have cyclictest equipped with the numerous (and
exotic) options.

Another plan was to add a plugin slot to cyclictest, since probably more
than 90% of the code of the various test programs is identical. A plugin
version of cyclictest would provide all the various runtime and
scheduler options, the stop clocks and the test framework. The actual
test plugin could be specified as a command line argument. The plugin
interface would need to connect the start and stop code of a particular
test to cyclictest. But this was just a plan...

	Carsten.


