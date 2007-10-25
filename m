From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Interrupt Latency module for intel
Date: Thu, 25 Oct 2007 13:23:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710251321020.8703@gandalf.stny.rr.com>
References: <1985e0f60710192336l5469682ai9dc47d5bc1a87c55@mail.gmail.com>
 <1193255575.3557.2.camel@imap.mvista.com>  <1193260511.4040.42.camel@sven.thebigcorporation.com>
 <1985e0f60710250941j44e40b5evb186e2cbebffdae8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sven-Thorsten Dietrich <sven@thebigcorporation.com>,
	Daniel Walker <dwalker@mvista.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Jaswinder Singh <jaswinderlinuxrt@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:41449 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbXJYRXw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Oct 2007 13:23:52 -0400
In-Reply-To: <1985e0f60710250941j44e40b5evb186e2cbebffdae8@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



Please don't top post.

--

On Thu, 25 Oct 2007, Jaswinder Singh wrote:

> Hello Daniel and Sven-Thorsten Dietrich,
>
> Can you please let me know the procedure of :
> 1. high resolution timers from userspace

http://rt.wiki.kernel.org/index.php/Cyclictest

> 2. ingo's irq latency timing and tracing

I need to write up some howtos for that.

>
> I will also try these methods and try to compare the performance numbers.
>

The cyclictest is fine for comparisons, but the latency trace is only
available with the -rt patch.

-- Steve
