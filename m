From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: kfree causing high latency on 3.4.4-rt13
Date: Tue, 5 Feb 2013 11:12:03 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1302051107160.11905@ionos>
References: <CAOY97VYWzxz-=HNYamCdqOzjXPsAyKjETZ3Hv7V3K4CZ6YB1kQ@mail.gmail.com> <alpine.LFD.2.02.1302041245060.11905@ionos> <CAOY97VZ-98xy-MaS5YuwUh9e00r8=eHQ1ZbG5yfp3xnHJjnSew@mail.gmail.com> <1360021255.23825.0.camel@linux-mbp>
 <CAOY97Va2gie-jTfoP_3S9CS6ysR+a8rgC2Br1STiR251Y9F=gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sven-Thorsten Dietrich <sven@thebigcorporation.com>,
	linux-rt-users@vger.kernel.org
To: Austin Hendrix <ahendrix@willowgarage.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48344 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab3BEKMK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Feb 2013 05:12:10 -0500
In-Reply-To: <CAOY97Va2gie-jTfoP_3S9CS6ysR+a8rgC2Br1STiR251Y9F=gg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 4 Feb 2013, Austin Hendrix wrote:
> I gave the 3.4.28-rt40 stable release a try today, and so far I
> haven't seen the problems that I was seeing with 3.4.4-rt13. I'd still
> like to know more about how the debug the problems I'm seeing on
> 3.4.4-rt13 so that I can do a better job of debugging if problems like
> this come up in the future.

One possibility would be to use the kernel tracer and modify
latencytop in the kernel to issue a tracing_off() call when a certain
latency treshold is reached. That way you freeze the kernel trace on
the spot where the latency is detected and you can analyze what
happened right before that point in the system.

Thanks,

	tglx
