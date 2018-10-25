Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from krieglstein.org ([176.28.13.145]:53118 "EHLO krieglstein.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbeJYS2h (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 25 Oct 2018 14:28:37 -0400
From: Tim Sander <tim@krieglstein.org>
Subject: Re: 100% RT load on 2 processor SMP machine
Date: Thu, 25 Oct 2018 11:56:33 +0200
Message-ID: <4078127.TmsvjRzeSv@dabox>
In-Reply-To: <20181023093613.y6w76hnrvbzetsi2@linutronix.de>
References: <2762823.FS3CZOEJbg@dabox> <20181023093613.y6w76hnrvbzetsi2@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org

Hi Sebastian

Thanks for your feedback.
Am Dienstag, 23. Oktober 2018, 11:36:13 CEST schrieb Sebastian Andrzej Siewior:
> > I just disovered a bug in my playground realtime application which led to
> > 100% load on one core. This was the non normal case when the system was
> > waiting for a network client to connect and i had a fifo buffer overflow
> > which led accidentially to a busy wait loop with 98 fifo priority. This
> > in turn lead to a system which did not accept any new network
> > connections.
> > 
> > The expected behaviour for a SMP system which still has one processor
> > lightly loaded should be that it still works "normal" even if one core is
> > overloaded with hard realtime work. Are there any explanations for this
> > behavior?
> You should figure what blocked you from working in the end. So if you
> had an interrupt pinned to the CPU that was blocked by RT task then this
> would explain why it did not make any progress.
I have no cpu affinity set on this system but i have seen that they are only
served by the cpu 0. Nevertheless /proc/interrupts show that only cpu 0 is
serving interrupts (besides twd, Rescheduling interrupts and function call
 interrupts). I have set the cpu_affinity of my runaway high priority thread
for testing to cpu 1. Which made things a little better but still the system
is barely usable.

> If you disable RT_RUNTIME_SHARE then the RT (that went wild) will be
> throttled.
> 
> 	echo NO_RT_RUNTIME_SHARE > /sys/kernel/debug/sched_features
I could not see any improvement from this. I have also not seen any throttling
of the RT-task. I have enabled the check for hung tasks but it seems the tasks
are making enough progress not to trigger it but the system beeing crawling
along so that normal tasks are not properly scheduled:

[  849.052372] i2c_designware ffc04000.i2c: controller timed out
[  849.058120] rtc-pcf8563 0-0051: pcf8563_read_block_data: read error

htop shows me that the first cpu is only lightly loaded, so in my opinion
there should be no need for stalls on this Intel/Altera Cyclone V Arm Cortex
A9 system. Also the runaway task is at 98 priority so all RCU or other
housekeeping tasks should be allowed to run besides of the runaway task.

Probably there is an improvment from RT_RUNTIME_SHARE. While i have not
seen any throtteling i have seen a BUG message:

[  302.045391] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=-20 stuck for 102s!
[  302.053571] Showing busy workqueues and worker pools:
[  302.058609] workqueue events_highpri: flags=0x10
[  302.063210]   pwq 3: cpus=1 node=0 flags=0x0 nice=-20 active=1/256
[  302.069387]     pending: flush_backlog BAR(82)
[  302.073843] workqueue netns: flags=0xe000a
[  302.077925]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=1/1
[  302.083323]     in-flight: 82:cleanup_net
[  302.087344] workqueue ipv6_addrconf: flags=0x40008
[  302.092118]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/1
[  302.097947]     in-flight: 31:addrconf_verify_work
[  302.102742] pool 0: cpus=0 node=0 flags=0x0 nice=0 hung=1s workers=3 idle: 32 5
[  302.110054] pool 4: cpus=0-1 flags=0x4 nice=0 hung=36s workers=4 idle: 57 148 7

Below is the output "ps -Leo pid,tid,class,rtprio,stat,comm,wchan" while the above BUG messages where popping up.

  PID   TID CLS RTPRIO STAT COMMAND         WCHAN
    1     1 TS       - Ss   systemd         epoll_wait
    2     2 TS       - S    kthreadd        kthreadd
    3     3 TS       - I<   rcu_gp          rescuer_thread
    4     4 TS       - I<   rcu_par_gp      rescuer_thread
    5     5 TS       - I    kworker/0:0-rcu worker_thread
    6     6 TS       - I<   kworker/0:0H-ev worker_thread
    7     7 TS       - I    kworker/u4:0-ev worker_thread
    8     8 TS       - I<   mm_percpu_wq    rescuer_thread
    9     9 TS       - S    ksoftirqd/0     smpboot_thread_fn
   10    10 FF       1 S    ktimersoftd/0   smpboot_thread_fn
   11    11 TS       - I    rcu_preempt     rcu_gp_kthread
   12    12 TS       - I    rcu_sched       rcu_gp_kthread
   13    13 TS       - S    rcuc/0          smpboot_thread_fn
   14    14 TS       - S    kswork          swork_kthread
   15    15 FF      99 S    posixcputmr/0   smpboot_thread_fn
   16    16 FF      99 S    migration/0     smpboot_thread_fn
   17    17 FF      99 S    watchdog/0      smpboot_thread_fn
   18    18 TS       - S    cpuhp/0         smpboot_thread_fn
   19    19 TS       - S    cpuhp/1         smpboot_thread_fn
   20    20 FF      99 S    watchdog/1      smpboot_thread_fn
   21    21 FF      99 S    migration/1     smpboot_thread_fn
   22    22 FF      99 S    posixcputmr/1   smpboot_thread_fn
   23    23 TS       - R    rcuc/1          -
   24    24 FF       1 R    ktimersoftd/1   -
   25    25 TS       - R    ksoftirqd/1     -
   26    26 TS       - I    kworker/1:0-eve worker_thread
   27    27 TS       - R<   kworker/1:0H    -
   28    28 TS       - S    kdevtmpfs       devtmpfsd
   29    29 TS       - I<   netns           rescuer_thread
   30    30 TS       - S    rcu_tasks_kthre rcu_tasks_kthread
   31    31 TS       - D    kworker/0:1+ipv rtnl_lock
   32    32 TS       - I    kworker/0:2-eve worker_thread
   33    33 TS       - S    khungtaskd      watchdog
   34    34 TS       - S    oom_reaper      oom_reaper
   35    35 TS       - I<   writeback       rescuer_thread
   36    36 TS       - S    kcompactd0      kcompactd
   37    37 TS       - I<   crypto          rescuer_thread
   38    38 TS       - I<   kblockd         rescuer_thread
   39    39 FF      99 S    watchdogd       kthread_worker_fn
   40    40 TS       - I<   rpciod          rescuer_thread
   41    41 TS       - I<   kworker/u5:0    worker_thread
   42    42 TS       - I<   xprtiod         rescuer_thread
   43    43 TS       - S    kswapd0         kswapd
   44    44 TS       - I<   nfsiod          rescuer_thread
   56    56 FF      50 S    irq/33-denali-n irq_thread
   57    57 TS       - I    kworker/u4:1-ev worker_thread
   59    59 FF      50 S    irq/28-ff706000 irq_thread
   60    60 TS       - I<   ipv6_addrconf   rescuer_thread
   61    61 TS       - I    kworker/1:1-mm_ worker_thread
   62    62 TS       - S    ubi_bgt0d       ubi_thread
   64    64 TS       - S    ubifs_bgt0_1    ubifs_bg_thread
   77    77 TS       - Ss   systemd-journal epoll_wait
   82    82 TS       - D    kworker/u4:2+ne flush_work
  108   108 TS       - Ssl  systemd-timesyn epoll_wait
  108   179 TS       - Ssl  sd-resolve      skb_wait_for_more_packets
  111   111 FF      50 S    irq/30-ffc04000 irq_thread
  112   112 FF      50 S    irq/34-ff705000 irq_thread
  113   113 FF      50 S    irq/31-ffc06000 irq_thread
  114   114 FF      50 S    irq/36-fff00000 irq_thread
  116   116 TS       - S    spi0            kthread_worker_fn
  118   118 TS       - I<   stmmac_wq       rescuer_thread
  148   148 TS       - I    kworker/u4:3    worker_thread
  160   160 TS       - Ss   systemd-network epoll_wait
  161   161 TS       - Ss   ads1115test     hrtimer_nanosleep
  163   163 TS       - Ss   thttpd          poll_schedule_timeout.constprop.3
  164   164 TS       - Ss   dbus-daemon     epoll_wait
  166   166 TS       - Ss   sh              wait
  167   167 TS       - Ss+  agetty          poll_schedule_timeout.constprop.3
  169   169 TS       - Ss   cjet            epoll_wait
  171   171 TS       - Ss   systemd-resolve epoll_wait
  172   172 TS       - Ss   jetstatic.bin   epoll_wait
  173   173 TS       - Ss   devscan.bin     epoll_wait
  175   175 TS       - I    kworker/1:2-eve worker_thread
  176   176 FF      50 S    irq/29-eth0     irq_thread
  177   177 FF      50 S    irq/40-ttyS0    irq_thread
  185   185 TS       - SLsl rawisolwebbits  poll_schedule_timeout.constprop.3
  185   187 FF      98 RLsl RawMeasThread   -
  194   194 TS       - Ss   systemd-udevd   epoll_wait
  200   200 TS       - I<   kworker/0:1H    worker_thread
  204   204 TS       - R+   ps              -

Best regards
Tim
