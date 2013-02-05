From: Austin Hendrix <ahendrix@willowgarage.com>
Subject: Re: kfree causing high latency on 3.4.4-rt13
Date: Mon, 4 Feb 2013 17:42:29 -0800
Message-ID: <CAOY97Va2gie-jTfoP_3S9CS6ysR+a8rgC2Br1STiR251Y9F=gg@mail.gmail.com>
References: <CAOY97VYWzxz-=HNYamCdqOzjXPsAyKjETZ3Hv7V3K4CZ6YB1kQ@mail.gmail.com>
	<alpine.LFD.2.02.1302041245060.11905@ionos>
	<CAOY97VZ-98xy-MaS5YuwUh9e00r8=eHQ1ZbG5yfp3xnHJjnSew@mail.gmail.com>
	<1360021255.23825.0.camel@linux-mbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:61044 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754410Ab3BEBmb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Feb 2013 20:42:31 -0500
Received: by mail-ob0-f173.google.com with SMTP id dn14so6931094obc.4
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Feb 2013 17:42:30 -0800 (PST)
In-Reply-To: <1360021255.23825.0.camel@linux-mbp>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Feb 4, 2013 at 3:40 PM, Sven-Thorsten Dietrich
<sven@thebigcorporation.com> wrote:
> On Mon, 2013-02-04 at 13:54 -0800, Austin Hendrix wrote:
>> An example of what I'm seeing from latencytop is:
>> [kfree]                                           7937.6 msec          6.4 %
>
> you are overwhelming folks with data now... but just a few more
> questions:
>
> - e.g. what does the RT program you are running do?
> - Code snippet that reproduces this issue?
> - list of other processes on system.
> - system specs; e.g. cpu speed, I am guessing around 8 - 12 Kilo Hz?
>
> Thanks
>
> Sven
>
>
>>
>> I poked around the kernel source a bit and was pretty stumped by this,
>> so I'm glad it's not just me.
>>
>> Thanks,
>> -Austin
>>
>> On Mon, Feb 4, 2013 at 3:49 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > On Tue, 29 Jan 2013, Austin Hendrix wrote:
>> >> I'm running 3.4.4-rt13 on my systems, and while the realtime
>> >> performance is great, I occasionally see non-realtime processes block
>> >> for several seconds. Running latencytop, it looks like the kfree
>> >> kernel process is the worst offender. Does anyone have advice on how I
>> >
>> > There is no kfree process. kfree() is a function to release memory
>> > allocated by kmalloc.
>> >
>> > Can you provide the latencytop output please ?
>> >
>> > Thanks,
>> >
>> >         tglx
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>

I wish I had more data too; that's one of the frustrating things about
the troubleshooting process. Most of my attempts to capture more data
or narrow the problem have instead caused the system to stop
exhibiting problems.

The system in question is a dual Xeon L5520 (quad-core, 2.27GHz), with
24GB of RAM. It's inside our robots:
https://willowgarage.com/pages/pr2/overview

The system load is around 2-3 under normal use.
My realtime process is an EtherCAT master, using about 30-40% of one
core. We use it for 1kHz motor control, so the realtime deadline is
pretty lax; in the 100's of us range.
The rest of the system load comes from a number of non-realtime
processes that are doing a significant amount of network I/O, along
with an NFS server.

Believe it or not, this system actually works quite well on the
3.0.6-rt17 kernel. I'm upgrading it to a newer kernel since I'm also
upgrading the base OS from Ubuntu Lucid to Precise.

I gave the 3.4.28-rt40 stable release a try today, and so far I
haven't seen the problems that I was seeing with 3.4.4-rt13. I'd still
like to know more about how the debug the problems I'm seeing on
3.4.4-rt13 so that I can do a better job of debugging if problems like
this come up in the future.

Thanks,
-Austin
