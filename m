From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: PI mutex support on ARM
Date: Wed, 5 Sep 2007 14:57:10 +0200
Message-ID: <3efb10970709050557i24dbdc3bub65a5eea249ae8f1@mail.gmail.com>
References: <200708201453.14641.m.gruber@tirol.com>
	 <3efb10970708201159q69a8757ay605e8567b4233922@mail.gmail.com>
	 <200708211048.35443.m.gruber@tirol.com>
	 <200709041348.42229.m.gruber@tirol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
	williams@redhat.com
To: "Manfred Gruber" <m.gruber@tirol.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:24587 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755672AbXIEM5L (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Sep 2007 08:57:11 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1021230wra
        for <linux-rt-users@vger.kernel.org>; Wed, 05 Sep 2007 05:57:11 -0700 (PDT)
In-Reply-To: <200709041348.42229.m.gruber@tirol.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Manfred,

> My question if I run the pi_stress, my watchdog triggers, if watchdog is
> disabled i get this:
> Is this the correct behaviour ? Or does it show a problem ?

Depends on the priority of your watchdog-feeder thread. If it is not
running in RT mode, with a priority higher than used in the pi-stress
test, then yes it is normal that the watchdog kicks in. pi-stress
takes 100% CPU-load, and leaves no room for non-RT processes.

The output you get seems normal to me...

Remy

2007/9/4, Manfred Gruber <m.gruber@tirol.com>:
> hi !
>
> I have now run 2.6.23-rc4-rt1 on my arm920t with the pi_stress test programm
> from http://people.redhat.com/williams/tests
>
> My question if I run the pi_stress, my watchdog triggers, if watchdog is
> disabled i get this:
>
> Admin threads running on processor: 0
> Test threads running on processor:  0
> Starting PI Stress Test
> Number of thread groups: 10
> Number of inversions per group: infinite
> Test threads using scheduler policy: SCHED_FIFO
>     Admin thread priority:  4
> 10 groups of 3 threads will be created
>     High thread priority:   3
>     Med  thread priority:   2
>     Low thread priority:    1
> Press Control-C to stop test
> Current Inversions: 15551
> Keyboard Interrupt!
>
> Stopping test
> Total inversion performed: 15570
> Test Duration: 0 days, 0 hours, 0 minutes, 14 seconds
>
> Is this the correct behaviour ? Or does it show a problem ?
>
> thanks, regards
>         fred
>
> Am Tuesday 21 August 2007 schrieben Sie:
> > Hi Remy !
> >
> > thanks a lot, i will test it on a ARM-v4 with 2.6.23-rc2-rt2 and
> > 2.6.21.5-rt20.
> >
> > I have a application which makes a lot of pthread_mutex_lock/unlock
> > between rt and non-rt tasks with PI. So i will look what happens.
> >
> > thanks
> >       fred
> >
> > Am Monday 20 August 2007 schrieben Sie:
> > > Hello Manfred,
> > >
> > > At http://www.spinics.net/lists/arm-kernel/msg42349.html you can find
> > > a patch that will probably work. Due to the lack of proper atomic
> > > instructions on the ARM-v4 core this patch is likely to be the best
> > > possible solution.
> > >
> > > Kind Regards,
> > >
> > > Remy
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-rt-users"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
