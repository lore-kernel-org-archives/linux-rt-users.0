From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: kfree causing high latency on 3.4.4-rt13
Date: Mon, 04 Feb 2013 15:40:55 -0800
Message-ID: <1360021255.23825.0.camel@linux-mbp>
References: <CAOY97VYWzxz-=HNYamCdqOzjXPsAyKjETZ3Hv7V3K4CZ6YB1kQ@mail.gmail.com>
	 <alpine.LFD.2.02.1302041245060.11905@ionos>
	 <CAOY97VZ-98xy-MaS5YuwUh9e00r8=eHQ1ZbG5yfp3xnHJjnSew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Austin Hendrix <ahendrix@willowgarage.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:53329 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197Ab3BDXk7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Feb 2013 18:40:59 -0500
Received: by mail-pa0-f45.google.com with SMTP id kl14so1002999pab.32
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Feb 2013 15:40:58 -0800 (PST)
In-Reply-To: <CAOY97VZ-98xy-MaS5YuwUh9e00r8=eHQ1ZbG5yfp3xnHJjnSew@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2013-02-04 at 13:54 -0800, Austin Hendrix wrote:
> An example of what I'm seeing from latencytop is:
> [kfree]                                           7937.6 msec          6.4 %

you are overwhelming folks with data now... but just a few more
questions:

- e.g. what does the RT program you are running do?
- Code snippet that reproduces this issue?
- list of other processes on system.
- system specs; e.g. cpu speed, I am guessing around 8 - 12 Kilo Hz?

Thanks

Sven


> 
> I poked around the kernel source a bit and was pretty stumped by this,
> so I'm glad it's not just me.
> 
> Thanks,
> -Austin
> 
> On Mon, Feb 4, 2013 at 3:49 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Tue, 29 Jan 2013, Austin Hendrix wrote:
> >> I'm running 3.4.4-rt13 on my systems, and while the realtime
> >> performance is great, I occasionally see non-realtime processes block
> >> for several seconds. Running latencytop, it looks like the kfree
> >> kernel process is the worst offender. Does anyone have advice on how I
> >
> > There is no kfree process. kfree() is a function to release memory
> > allocated by kmalloc.
> >
> > Can you provide the latencytop output please ?
> >
> > Thanks,
> >
> >         tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



