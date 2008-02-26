From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.24.2-rt2
Date: Tue, 26 Feb 2008 11:55:58 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0802261155330.10116@gandalf.stny.rr.com>
References: <1203639849.7551.4.camel@localhost.localdomain> <47C3EA1F.3030203@siemens.com>
 <47C3FF82.6060900@siemens.com> <Pine.LNX.4.58.0802261013001.6116@gandalf.stny.rr.com>
 <47C43289.80506@siemens.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:43898 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895AbYBZQ4W (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Feb 2008 11:56:22 -0500
In-Reply-To: <47C43289.80506@siemens.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 26 Feb 2008, Jan Kiszka wrote:
> >>
> >
> > What's the NUMA topology?
>
> 4 nodes. I'm not sure if it is really NUMA related, but the same kernel
> runs that test as expected on a non-NUMA 2x2 box.
>
> > What tasks are running, and at what priorities?
>
> 40 pthreads, created with default parameters from a main thread which
> runs with default parameters as well. The threads simply run endless loops.
>
> >
> > Those three idle CPUS, should they have tasks running on them?
>
> For sure, given the overload situation of the system (40x full load vs.
> 16 cores). Neither did we fiddle with any parameter of the system
> (knowingly, its a standard openSUSE 10.3 underneath) nor did we set
> thread affinities.
>

Do you get different behaviour with 2.6.24.2?

-- Steve
