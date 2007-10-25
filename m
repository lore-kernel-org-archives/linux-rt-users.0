From: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>
Subject: Re: Interrupt Latency module for intel
Date: Thu, 25 Oct 2007 22:11:17 +0530
Message-ID: <1985e0f60710250941j44e40b5evb186e2cbebffdae8@mail.gmail.com>
References: <1985e0f60710192336l5469682ai9dc47d5bc1a87c55@mail.gmail.com>
	 <1193255575.3557.2.camel@imap.mvista.com>
	 <1193260511.4040.42.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Daniel Walker" <dwalker@mvista.com>,
	RT <linux-rt-users@vger.kernel.org>, rostedt@goodmis.org
To: "Sven-Thorsten Dietrich" <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.189]:16928 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756632AbXJYQlU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Oct 2007 12:41:20 -0400
Received: by rn-out-0102.google.com with SMTP id s46so585231rnb
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Oct 2007 09:41:18 -0700 (PDT)
In-Reply-To: <1193260511.4040.42.camel@sven.thebigcorporation.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Daniel and Sven-Thorsten Dietrich,

Can you please let me know the procedure of :
1. high resolution timers from userspace
2. ingo's irq latency timing and tracing

I will also try these methods and try to compare the performance numbers.

Thanks you,

Jaswinder Singh.

On 10/25/07, Sven-Thorsten Dietrich <sven@thebigcorporation.com> wrote:
> On Wed, 2007-10-24 at 12:52 -0700, Daniel Walker wrote:
> > On Sat, 2007-10-20 at 12:06 +0530, Jaswinder Singh wrote:
> > > hello all,
> > >
> > > On my Intel Pentium 4 with linux-2.6.23-rc8-rt1, I am getting :
> > >
> > > Interrupt Latency result
> > > ------------------------
> > > MAX latency : 12.570 micro-seconds
> > > MIN latency : 3.352 micro-seconds
> > > AVG latency : 4.190 micro-seconds
> > > Total Samples : 32583
> > >
> > > Please review this interrupt latency module and give your feedback.
> >
> > Have you noticed there is at least one other way to measure this with
> > existing tools? With high resolution timers you could do this from
> > userspace..
>
> Not to mention of course ingo's irq latency timing and tracing, which
> works more comprehensively.
>
> >
> > Daniel
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
