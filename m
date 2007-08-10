From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: How to control IRQ thread priority from inside the driver
Date: Fri, 10 Aug 2007 18:00:28 +0200
Message-ID: <3efb10970708100900q6f799f4cmd72d9f6abc27f7fe@mail.gmail.com>
References: <200708081514.31864.jbe@pengutronix.de>
	 <200708081409.28105.dvhltc@us.ibm.com>
	 <200708091610.58134.jbe@pengutronix.de>
	 <200708091128.44043.dvhltc@us.ibm.com>
	 <3efb10970708100421s1f058d45qa7c9c7b265c0933d@mail.gmail.com>
	 <Pine.LNX.4.58.0708101112490.20808@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Darren Hart" <dvhltc@us.ibm.com>, "Ingo Molnar" <mingo@elte.hu>,
	"Juergen Beisert" <jbe@pengutronix.de>,
	linux-rt-users@vger.kernel.org
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:47737 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763874AbXHJQA3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Aug 2007 12:00:29 -0400
Received: by py-out-1112.google.com with SMTP id d32so1422476pye
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Aug 2007 09:00:29 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.58.0708101112490.20808@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Steven,

> Perhaps adding in a new command line interface (We may need to extend the
> command line size limit). Where one could do
> irq_priority_map=10-51,21-40,...  Where the first number is the irq number
> followed by the irq priority. We can also do something similar to
> softirqs.
>
> Would something like that satisfy your needs?

Yeah, it would at least suit my needs :-)
But, the irq-numbers to be defined is hardware specific, and even
board specific on X86. Maybe someone wants to give a certain interrupt
handler a different priority, but not a certain IRQ-number to keep it
possible to use 1 target image usable on multiple boards with  1
single kernel and 1 single config.
How to define that on a kernel commandline is still a question to me...

> When I get time, I can write up a patch to do something like this.

I could write a proposal on a solution for this, and if we all agree
for one solution, I could make the patch for this. (Maybe I have more
time free than you ;-) )

Remy
