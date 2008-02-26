From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: 2.6.24.2-rt2
Date: Tue, 26 Feb 2008 18:15:56 +0100
Message-ID: <47C4494C.1090600@siemens.com>
References: <1203639849.7551.4.camel@localhost.localdomain> <47C3EA1F.3030203@siemens.com> <47C3FF82.6060900@siemens.com> <Pine.LNX.4.58.0802261013001.6116@gandalf.stny.rr.com> <47C43289.80506@siemens.com> <Pine.LNX.4.58.0802261155330.10116@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lizzard.sbs.de ([194.138.37.39]:60088 "EHLO lizzard.sbs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762436AbYBZRQ2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Feb 2008 12:16:28 -0500
In-Reply-To: <Pine.LNX.4.58.0802261155330.10116@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steven Rostedt wrote:
> 
> On Tue, 26 Feb 2008, Jan Kiszka wrote:
>>> What's the NUMA topology?
>> 4 nodes. I'm not sure if it is really NUMA related, but the same kernel
>> runs that test as expected on a non-NUMA 2x2 box.
>>
>>> What tasks are running, and at what priorities?
>> 40 pthreads, created with default parameters from a main thread which
>> runs with default parameters as well. The threads simply run endless loops.
>>
>>> Those three idle CPUS, should they have tasks running on them?
>> For sure, given the overload situation of the system (40x full load vs.
>> 16 cores). Neither did we fiddle with any parameter of the system
>> (knowingly, its a standard openSUSE 10.3 underneath) nor did we set
>> thread affinities.
>>
> 
> Do you get different behaviour with 2.6.24.2?

Last time I checked mainline (I think 2.6.24), it was fine. It was
definitely fine for 2.6.23. But I'm going to revalidate this once the
machine is free again (tomorrow).

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux
