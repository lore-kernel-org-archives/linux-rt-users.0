From: Ashoka K <ashok.vinu@gmail.com>
Subject: Re: Need help to measure and tune the latency in Linux RT
Date: Tue, 30 Apr 2013 18:47:05 +0530
Message-ID: <CALJd4cbEUMpLhjbFMELbGbXZ6WuAzaychjtt2uyv8Mvwi74xHQ@mail.gmail.com>
References: <CALJd4cbfqRFiGHshv8A+0A8kFo_qW=rvREsdgj3jQ=-0Rix0-g@mail.gmail.com>
	<20130430111021.GC31290@titan.lakedaemon.net>
	<517FB553.3000001@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-embedded@vger.kernel.org, linux-newbie@vger.kernel.org,
	Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
	linux-rt-users@vger.kernel.org
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-newbie-owner@vger.kernel.org>
In-Reply-To: <517FB553.3000001@meduna.org>
Sender: linux-newbie-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thanks for all the replies.
I am stuck with this issue for more tan a month. Explained this in
more detail at:

http://stackoverflow.com/questions/15805231/need-to-improve-the-linux-performance-for-embedded-system

But with no response from anyone.

I use PREEMPT patch for 2.6.33 vanilla kernel.

I have pasted all the processes running on my system:

  PID USER       VSZ STAT COMMAND
    1 root      3192 S    init
    2 root         0 SW   [kthreadd]
    3 root         0 SW   [ksoftirqd/0]
    4 root         0 SW   [events/0]
    5 root         0 SW   [khelper]
    8 root         0 SW   [async/mgr]
   84 root         0 SW   [sync_supers]
   86 root         0 SW   [bdi-default]
   88 root         0 SW   [kblockd/0]
   91 root         0 SW   [omap2_mcspi]
  116 root         0 SW   [rpciod/0]
  123 root         0 SW   [kswapd0]
  124 root         0 SW   [aio/0]
  125 root         0 SW   [nfsiod]
  126 root         0 SW<  [kslowd001]
  127 root         0 SW<  [kslowd000]
  128 root         0 SW   [crypto/0]
  267 root         0 SW   [mtdblockd]
  351 root         0 SWN  [jffs2_gcd_mtd8]
  359 root      3192 S    /sbin/syslogd
  361 root      3192 S    /usr/sbin/telnetd
  364 root      1996 S    vsftpd
  410 root     43844 S   my_appl
  416 root     56412 S <  my_appl
  417 root     84804 S    my_appl
  418 root     43844 S    my_appl
  419 root     84824 S    my_appl
  430 root     46552 S <  my_appl

The process my_appl is my application processes.

the ksoftirq is running with SCHED_OTHER.

$ chrt -p 3
pid 3's current scheduling policy: SCHED_OTHER
pid 3's current scheduling priority: 0

I will test by changing ksoftirq priority to see how it works.

Regards
Ashoka.  K


On Tue, Apr 30, 2013 at 5:43 PM, Stanislav Meduna <stano@meduna.org> wrote:
>>> This critical thread is at RR priority 50.
>
> Try to put it higher than the irq thread handling your HD hardware.
> I've even encountered hardware where I had to put the ATA thread
> in the SHED_OTHER domain - see [1] for the thread.
>
>>> I used a HR timer thread with RR pri 55 to wakeup the critical thread
>>> every 1 milli sec to do the job.
>
> Which prio is the ksoftirqd running at? The HRTIMER interrupts are
> routed through it so it also has to be high enough.
>
> I got burned with this myself [2]
>
> Regards
>                                      Stano
>
> [1] http://www.spinics.net/lists/linux-rt-users/msg08711.html
> [2] http://www.spinics.net/lists/linux-rt-users/msg08745.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-newbie" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at http://www.linux-learn.org/faqs
