From: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Subject: Re: beagleboard RT problem
Date: Tue, 22 Jun 2010 07:46:55 -0700
Message-ID: <1277218015.10664.5.camel@sven.thebigcorporation.com>
References: <AANLkTik4gFjREMEwYqCyg24o6veBaEEa1oiEIkZl50kr@mail.gmail.com>
	 <AANLkTikWXBR-ZmsdMrPI3KyAgLV2G1yvuQrAYp07KFCN@mail.gmail.com>
	 <alpine.LFD.2.00.1006141301100.26248@localhost.localdomain>
	 <1276514850.26993.4.camel@sven.thebigcorporation.com>
	 <AANLkTimWSQfXQGedfHHLAbabPrRnUaWlPCMUEC3I9_G0@mail.gmail.com>
	 <AANLkTikP0Z8NbhiCd9yJeNJrnJqJkoXkSSErR_9B6dYC@mail.gmail.com>
	 <AANLkTilakntJf43kOkuT0EVu6v3s17VNJR6S60lB2ls3@mail.gmail.com>
	 <AANLkTinojaU-FL3K3C09hV9-qrr8ZdjA8fzDMWTeQh_k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Maksym Parkachov <lazy.gopher@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:27666 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366Ab0FVOrS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Jun 2010 10:47:18 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1353509fga.1
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Jun 2010 07:47:17 -0700 (PDT)
In-Reply-To: <AANLkTinojaU-FL3K3C09hV9-qrr8ZdjA8fzDMWTeQh_k@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2010-06-22 at 09:50 +0200, Maksym Parkachov wrote:
> Sujit,
> 
> thanks for the links, though they mostly have to do with application
> performance. I don't have any problem with app performance as there is
> no apps running yet :)

cyclictest is an app, and that is what you started this thread with.

you reported high latencies when running cyclictest, and you were asked
to turn on lockdep (and its assumed you went back and re-ran cyclic
test)


> 
> This is embedded system. There is no modules loaded, there is no
> network, there is no processes running beside busybox. Clean, fast,
> just real-time is not working :)
> 

> I did check the dmesg, and unfortunately there is nothing unusual. No
> new messages after running cyclictest.
> 
it does appear from an earlier post, that lock dep triggered on
something but you never reported any traces.


> I'll try to enable all kernel debugging options, but I'm not sure if
> it helps, I don't really know what to look for in the messages or in
> statistics.
> 


So assuming, that the lockdependency checker and lock validator aren't
in fact reporting locking problems, then you should be able to capture
your latency using the latency tracer.

This should report a nice stack dump for the path that is causing
cyclictest delays.  Take a look over the cyclictest parameters, or
forget about cyclictest altogether and run your app with latency
tracing.

Regards,

Sven


> Cheers,
> Maksym.
> 
> On 21 June 2010 12:34, Sujit K M <sjt.kar@gmail.com> wrote:
> > Searching for "kernel tuning in linux" I found some relevant but not
> > upto date articles.
> >
> > http://www.linux.com/archive/feature/146599
> > http://www.linuxforums.org/articles/linux-performance-tuning_107.html
> >
> > By the way I found something funny with your "lock_stat" gzip file. It
> > had the following warning.
> >
> > "lock_stat version 0.3
> > *WARNING* lock debugging disabled!! - possibly due to a lockdep warning"
> >
> > Also I think you could run dmesg to see the actvity for some clarity.
> >
> > On Sun, Jun 20, 2010 at 9:13 PM, Maksym Parkachov <lazy.gopher@gmail.com> wrote:
> >> Folks,
> >>
> >> it's me again with beagleboard RT problem.
> >>
> >> I recompiled the kernel and got some statistics on locks, but I'm not
> >> sure how to interpret it.  Searching on google didn't help, probably,
> >> not asking right question.
> >>
> >> Here are stats from /proc after running cyclictest.
> >>
> >> If you could take a look at it, it would be great.
> >>
> >> Thanks,
> >> Maksym.
> >>
> >> On 15 June 2010 09:34, Maksym Parkachov <lazy.gopher@gmail.com> wrote:
> >>> Hi folks,
> >>>
> >>> thanks for all suggestions.
> >>> I'll try with lock validation and see if I could come with more details.
> >>>
> >>> Thanks,
> >>> Maksym.
> >>>
> >>> On 14 June 2010 13:27, Sven-Thorsten Dietrich
> >>> <thebigcorporation@gmail.com> wrote:
> >>>> On Mon, 2010-06-14 at 13:05 +0200, John Kacur wrote:
> >>>>>
> >>>>> On Mon, 14 Jun 2010, Sujit K M wrote:
> >>>>>
> >>>>> > > CONFIG_PREEMPT_RCU=y
> >>>> %<
> >>>>> His problem is not with the config.
> >>>>> --
> >>>>
> >>>> Nope - the config is just fine.
> >>>>
> >>>> Turn on the lock validator and
> >>>> recompile the Kernel.
> >>>>
> >>>> Then repeat the test that produced the latency spike.
> >>>>
> >>>> If that doesn't produce any locking issues,
> >>>> turn on latency tracing and repeat.
> >>>>
> >>>>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> >>>>> the body of a message to majordomo@vger.kernel.org
> >>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>>
> >>>>
> >>>>
> >>>
> >>
> >
> >
> >
> > --
> > -- Sujit K M
> >
> > blog(http://kmsujit.blogspot.com/)
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


