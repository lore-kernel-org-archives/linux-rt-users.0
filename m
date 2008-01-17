From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.24-rc8-rt1
Date: Thu, 17 Jan 2008 13:44:03 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801171343250.28350@gandalf.stny.rr.com>
References: <1200544050.318.18.camel@localhost.localdomain>
 <478F2A46.5070506@grandegger.com>  <1200586632.18731.141.camel@imap.mvista.com>
  <478F9BCE.4030301@grandegger.com> <1200594655.18731.148.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:36172 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbYAQSor (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Jan 2008 13:44:47 -0500
In-Reply-To: <1200594655.18731.148.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Thu, 17 Jan 2008, Daniel Walker wrote:

>
> On Thu, 2008-01-17 at 19:17 +0100, Wolfgang Grandegger wrote:
> > [    0.733248] TCP bind hash table entries: 2048 (order: 3, 57344
> > bytes)
> > [    0.741132] TCP: Hash tables configured (established 2048 bind
> > 2048)
> > [    0.747981] TCP reno registered
> > [    0.805896] krcupreemptd setsched 0
> > [    0.809657]   prio = 98
>
> That's interesting .. You chould try running cyclictest at priority 99
> to eliminate other threads that might get involved (using -p99 instead
> of -p80 , I think) ..

No that prio is the internal prio where smaller number is higher priority.
The krcupreemptd runs at RT prio 1, which is 98 internally.

-- Steve
