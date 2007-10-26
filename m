From: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>
Subject: Re: Interrupt Latency module for intel
Date: Fri, 26 Oct 2007 08:49:09 +0530
Message-ID: <1985e0f60710252019x62ffb218l89ce476de642d73d@mail.gmail.com>
References: <1985e0f60710192336l5469682ai9dc47d5bc1a87c55@mail.gmail.com>
	 <1193255575.3557.2.camel@imap.mvista.com>
	 <1193260511.4040.42.camel@sven.thebigcorporation.com>
	 <1985e0f60710250941j44e40b5evb186e2cbebffdae8@mail.gmail.com>
	 <Pine.LNX.4.58.0710251321020.8703@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Sven-Thorsten Dietrich" <sven@thebigcorporation.com>,
	"Daniel Walker" <dwalker@mvista.com>,
	RT <linux-rt-users@vger.kernel.org>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:3231 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbXJZDTL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Oct 2007 23:19:11 -0400
Received: by wr-out-0506.google.com with SMTP id 36so589991wra
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Oct 2007 20:19:10 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.58.0710251321020.8703@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Steve,

On 10/25/07, Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> Please don't top post.
>
> --
>
> On Thu, 25 Oct 2007, Jaswinder Singh wrote:
>
> > Hello Daniel and Sven-Thorsten Dietrich,
> >
> > Can you please let me know the procedure of :
> > 1. high resolution timers from userspace
>
> http://rt.wiki.kernel.org/index.php/Cyclictest
>

As per http://www.mail-archive.com/linux-rt-users@vger.kernel.org/msg01487.html
According to Thomas Gleixner :

cyclictest is not about interrupt latency, it's about the full
chain of:

        timer interrupt
        scheduler
        user space execution

in the second test you did it's:

        timer interrupt
        softirq + signal delivery
        scheduler
        user space execution

Please let me know from cyclictest How can I get separately :-

1. Interrupt latency numbers
2. Task switching numbers


> > 2. ingo's irq latency timing and tracing
>
> I need to write up some howtos for that.
>

Thanks.

Jaswinder Singh.

> >
> > I will also try these methods and try to compare the performance numbers.
> >
>
> The cyclictest is fine for comparisons, but the latency trace is only
> available with the -rt patch.
>
> -- Steve
>
>
