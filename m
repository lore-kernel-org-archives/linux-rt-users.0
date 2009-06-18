From: Iratxo Pichel Ortiz <ipichel@albentia.com>
Subject: Re: NOHZ: local_softirq_pending
Date: Thu, 18 Jun 2009 02:33:19 +0200
Message-ID: <4A398B4F.6080702@albentia.com>
References: <4A35171C.9090800@albentia.com>  <8e6b7a710906141250m2a991ca9r5949e502b9976e39@mail.gmail.com>  <alpine.LFD.2.00.0906151501200.2800@localhost.localdomain>  <4A365CCF.2020707@albentia.com> <8e6b7a710906160101x6a8ae9d5qa7638627f513278@mail.gmail.com> <4A376450.5020209@albentia.com> <4A376559.5060604@albentia.com> <4A37B014.4040104@albentia.com> <4A37E6D1.5010207@albentia.com> <alpine.LFD.2.00.0906180001210.2800@localhost.localdomain> <4A396FB8.3020807@albentia.com> <alpine.LFD.2.00.0906180133220.2800@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	=?ISO-8859-1?Q?Noeli?= =?ISO-8859-1?Q?a_Mor=F3n?=
	<nmoron@albentia.com>,
	'Rodrigo Partearroyo' <rpartearroyo@albentia.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from llsc093-a04.servidoresdns.net ([82.223.190.45]:59013 "EHLO
	llsc093-a04.servidoresdns.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752065AbZFRAdU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jun 2009 20:33:20 -0400
In-Reply-To: <alpine.LFD.2.00.0906180133220.2800@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas Gleixner wrote:
> Please bzip2 it and upload it somewhere as it's probably too large fo=
r
> the mailinglist.
>  =20
Please find 3 realizations at:
http://www.proyectoradio.com/webdocs/rtkernel/trace.bz2
http://www.proyectoradio.com/webdocs/rtkernel/trace2.bz2
http://www.proyectoradio.com/webdocs/rtkernel/trace3.bz2

Just in case they get lost sometime in the future, at the end of this=20
email is the result of "tail -30 trace3", hopefully it is enough of tha=
t=20
file.

Having read the three of them, regardless of the last process before th=
e=20
"NOHZ...", there is always a call to the FPE emulator. I am going to do=
=20
some tests changing the FPE emulator, in case it helps.

Thanks a lot,

    Iratxo.
> Thanks,
>
> 	tglx
> -------------->
> Subject: debug-nohz-issue.patch
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Thu, 18 Jun 2009 01:41:01 +0200
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/tick-sched.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> Index: linux-2.6-tip/kernel/time/tick-sched.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6-tip.orig/kernel/time/tick-sched.c
> +++ linux-2.6-tip/kernel/time/tick-sched.c
> @@ -250,6 +250,8 @@ void tick_nohz_stop_sched_tick(int inidl
>  	if (unlikely(local_softirq_pending() && cpu_online(cpu))) {
>  		static int ratelimit;
> =20
> +		tracing_off();
> +
>  		if (ratelimit < 10) {
>  			printk(KERN_ERR "NOHZ: local_softirq_pending %02x\n",
>  			       local_softirq_pending());
>
>  =20

              sh-1162  [000] 4154504576.502616: n_tty_set_room <-n_tty_=
read
              sh-1162  [000] 4154504576.502616: schedule_timeout=20
<-n_tty_read
              sh-1162  [000] 4154504576.502616: schedule <-schedule_tim=
eout
              sh-1162  [000] 4154504576.502616: __schedule <-schedule
              sh-1162  [000] 4154504576.502616: rcu_qsctr_inc <-__sched=
ule
              sh-1162  [000] 4154504576.502616: deactivate_task <-__sch=
edule
              sh-1162  [000] 4154504576.502616: dequeue_task=20
<-deactivate_task
              sh-1162  [000] 4154504576.502616: update_avg <-dequeue_ta=
sk
              sh-1162  [000] 4154504576.502616: dequeue_task_fair=20
<-dequeue_task
              sh-1162  [000] 4154504576.502616: update_curr=20
<-dequeue_task_fair
              sh-1162  [000] 4154504576.502616: clear_buddies=20
<-dequeue_task_fair
              sh-1162  [000] 4154504576.502616: __clear_buddies=20
<-clear_buddies
              sh-1162  [000] 4154504576.502616: update_min_vruntime=20
<-dequeue_task_fair
              sh-1162  [000] 4154504576.502616: put_prev_task_fair=20
<-__schedule
              sh-1162  [000] 4154504576.502616: check_spread=20
<-put_prev_task_fair
              sh-1162  [000] 4154504576.502616: pick_next_task_rt=20
<-__schedule
              sh-1162  [000] 4154504576.502616: pick_next_task_fair=20
<-__schedule
              sh-1162  [000] 4154504576.502616: pick_next_task_idle=20
<-__schedule
              sh-1162  [000] 4154504576.502616: calc_load_account_activ=
e=20
<-pick_next_task_idle
              sh-1162  [000] 4154504576.502616: __rcu_read_lock=20
<-__atomic_notifier_call_chain
              sh-1162  [000] 4154504576.502616: nwfpe_notify=20
<-notifier_call_chain
              sh-1162  [000] 4154504576.502616: dsp_do <-notifier_call_=
chain
              sh-1162  [000] 4154504576.502616: __rcu_read_unlock=20
<-__atomic_notifier_call_chain
          <idle>-0     [000] 4154504576.502616: finish_task_switch=20
<-__schedule
          <idle>-0     [000] 4154504576.502616:=20
tick_nohz_stop_sched_tick <-cpu_idle
          <idle>-0     [000] 4154504576.502616: ktime_get=20
<-tick_nohz_stop_sched_tick
          <idle>-0     [000] 4154504576.502616: ktime_get_ts <-ktime_ge=
t
          <idle>-0     [000] 4154504576.502616: getnstimeofday=20
<-ktime_get_ts
          <idle>-0     [000] 4154504576.502616: ixp4xx_get_cycles=20
<-getnstimeofday
          <idle>-0     [000] 4154504576.502616: set_normalized_timespec=
=20
<-ktime_get_ts

--=20
Iratxo Pichel Ortiz
Software Development Manager

Albentia Systems S.A.
http://www.albentia.com

Tel: +34 914400567
Cel: +34 663808405
=46ax: +34 914400569

C\Margarita Salas 22
Parque Tecnol=F3gico de Legan=E9s
Legan=E9s (28918)
Madrid
Spain

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
