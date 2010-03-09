From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: [PATCH 2/2] add-smp-option-to-svsematest.patch
Date: Tue, 09 Mar 2010 21:39:24 +0100
Message-ID: <4B96B1FC.3070502@osadl.org>
References: <20100307204800.456744470@osadl.org> <20100307204909.626988443@osadl.org> <4B968F2B.4070708@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: John Kacur <jkacur@redhat.com>,
	RT-users <linux-rt-users@vger.kernel.org>
To: David Sommerseth <davids@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:52437 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754719Ab0CIUkZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Mar 2010 15:40:25 -0500
In-Reply-To: <4B968F2B.4070708@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

David,

>> -		if (priority > 0)
>> +		if (priority > 1 && !sameprio)
>> 			priority--;
> Unless I'm missing something really obvious, shouldn't this one state:
> 	if (priority > 0 && !sameprio)
> 		priority--;
> Or else 1 will be the lowest priority. [..]
Yes, which is ok, since the range of valid SCHED_FIFO priorities is 1 to
99. A priority of 0 would cause sched_setscheduler() to set the EINVAL
error condition.

	Carsten.
