From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: Interrupt Latency module for intel
Date: Wed, 24 Oct 2007 14:15:11 -0700
Message-ID: <1193260511.4040.42.camel@sven.thebigcorporation.com>
References: <1985e0f60710192336l5469682ai9dc47d5bc1a87c55@mail.gmail.com>
	 <1193255575.3557.2.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jaswinder Singh <jaswinderlinuxrt@gmail.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sccrmhc13.comcast.net ([204.127.200.83]:61085 "EHLO
	sccrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238AbXJXVP1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Oct 2007 17:15:27 -0400
In-Reply-To: <1193255575.3557.2.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-10-24 at 12:52 -0700, Daniel Walker wrote:
> On Sat, 2007-10-20 at 12:06 +0530, Jaswinder Singh wrote:
> > hello all,
> > 
> > On my Intel Pentium 4 with linux-2.6.23-rc8-rt1, I am getting :
> > 
> > Interrupt Latency result
> > ------------------------
> > MAX latency : 12.570 micro-seconds
> > MIN latency : 3.352 micro-seconds
> > AVG latency : 4.190 micro-seconds
> > Total Samples : 32583
> > 
> > Please review this interrupt latency module and give your feedback.
> 
> Have you noticed there is at least one other way to measure this with
> existing tools? With high resolution timers you could do this from
> userspace..

Not to mention of course ingo's irq latency timing and tracing, which
works more comprehensively.

> 
> Daniel
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
