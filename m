From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: 2.6.24-rc8-rt1
Date: Thu, 17 Jan 2008 19:46:18 +0100
Message-ID: <478FA27A.9030507@grandegger.com>
References: <1200544050.318.18.camel@localhost.localdomain>	 <478F2A46.5070506@grandegger.com>	 <1200586632.18731.141.camel@imap.mvista.com>	 <478F9BCE.4030301@grandegger.com> <1200594655.18731.148.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:42371 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbYAQSqV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Jan 2008 13:46:21 -0500
In-Reply-To: <1200594655.18731.148.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Daniel Walker wrote:
> On Thu, 2008-01-17 at 19:17 +0100, Wolfgang Grandegger wrote:
>> [    0.733248] TCP bind hash table entries: 2048 (order: 3, 57344
>> bytes)
>> [    0.741132] TCP: Hash tables configured (established 2048 bind
>> 2048)
>> [    0.747981] TCP reno registered
>> [    0.805896] krcupreemptd setsched 0
>> [    0.809657]   prio = 98
> 
> That's interesting .. You chould try running cyclictest at priority 99
> to eliminate other threads that might get involved (using -p99 instead
> of -p80 , I think) ..

I already tried that but I did not realize any difference. If I run
"while ls; do ls /bin; done" on the console I even get:

  #./cyclictest -n -p99 -i1000
  2.82 1.70 0.90 2/45 3168

  T: 0 ( 2426) P:99 I:1000 C: 135995 Min:     57 Act:  110 Avg:  106
Max:     911

Wolfgang.
