From: Gilles Carry <glscarry@free.fr>
Subject: Re: [PATCH 1/2] [RT] hrtimers stuck in waitqueue
Date: Fri, 22 Aug 2008 08:11:21 +0200
Message-ID: <9D520574-2E78-4C1D-A1C6-801F82313F02@free.fr>
References: <1219070552-30783-1-git-send-email-gilles.carry@bull.net> <1219070552-30783-2-git-send-email-gilles.carry@bull.net> <520f0cf10808210616s1d7d66fcpbddf6904c9c70870@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Gilles Carry" <gilles.carry@bull.net>,
	linux-rt-users@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
	tinytim@us.ibm.com, jean-pierre.dion@bull.net,
	sebastien.dugue@bull.net
To: John Kacur <jkacur@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailfe06.tele2.fr ([212.247.154.172]:58627 "EHLO swip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752824AbYHVGLZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Aug 2008 02:11:25 -0400
In-Reply-To: <520f0cf10808210616s1d7d66fcpbddf6904c9c70870@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Le 21 ao=FBt 08 =E0 15:16, John Kacur a =E9crit :

> On Mon, Aug 18, 2008 at 4:42 PM, Gilles Carry =20
> <gilles.carry@bull.net> wrote:
>> This patch makes hrtimers initialized with hrtimer_init_sleeper
>> to use another mode and then not be stuck in waitqueues when
>> hrtimer_interrupt is very busy.
>>
>> The new mode is HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFIRQ.
>> The above-mentionned timers have been moved from
>> HRTIMER_CB_IRQSAFE_NO_SOFTIRQ to
>> HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFIRQ.
>>
>> HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFIRQ timers use a slightly =20
>> different
>> state machine from HRTIMER_CB_IRQSAFE_NO_SOFTIRQ's as when removing =
=20
>> the
>> timer, __run_hrtimer sets the status to INACTIVE _then_
>> wakes up the thread. This way, an awakened thread cannot enter
>> hrtimer_cancel before the timer's status has changed.
>>
>> Signed-off-by: Gilles Carry <gilles.carry@bull.net>
>>
>> ---
>> include/linux/hrtimer.h |    4 ++++
>> kernel/hrtimer.c        |   26 +++++++++++++++++++++-----
>> 2 files changed, 25 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
>> index f3867fd..53f4d44 100644
>> --- a/include/linux/hrtimer.h
>> +++ b/include/linux/hrtimer.h
>> @@ -49,12 +49,16 @@ enum hrtimer_restart {
>> *                                     does not restart the timer
>> *     HRTIMER_CB_IRQSAFE_NO_SOFTIRQ:  Callback must run in hardirq =20
>> context
>> *                                     Special mode for tick =20
>> emultation
>> + *     HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFTIRQ:
>> + *                                     Callback must run in =20
>> hardirq context and
>> + *                                     does not restart the timer
>> */
>> enum hrtimer_cb_mode {
>>       HRTIMER_CB_SOFTIRQ,
>>       HRTIMER_CB_IRQSAFE,
>>       HRTIMER_CB_IRQSAFE_NO_RESTART,
>>       HRTIMER_CB_IRQSAFE_NO_SOFTIRQ,
>> +       HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFTIRQ,
>> };
>>
>> /*
>> diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
>> index fa63a24..778eb7e 100644
>> --- a/kernel/hrtimer.c
>> +++ b/kernel/hrtimer.c
>> @@ -668,6 +668,7 @@ static inline int =20
>> hrtimer_enqueue_reprogram(struct hrtimer *timer,
>>               /* Timer is expired, act upon the callback mode */
>>               switch(timer->cb_mode) {
>>               case HRTIMER_CB_IRQSAFE_NO_RESTART:
>> +               case HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFTIRQ:
>>                       debug_hrtimer_deactivate(timer);
>>                       /*
>>                        * We can call the callback from here. No =20
>> restart
>> @@ -1089,6 +1090,8 @@ int hrtimer_cancel(struct hrtimer *timer)
>>
>>               if (ret >=3D 0)
>>                       return ret;
>> +               WARN_ON (timer->cb_mode =3D=3D
>
> Minor point here, we may as well squash checkpatch.pl complaints now,
> to reduce any clean-up later to push to mainline. if you run
> checkpatch.pl
> WARNING: space prohibited between function name and open parenthesis =
=20
> '('
> #69: FILE: kernel/hrtimer.c:1093:
> +               WARN_ON (timer->cb_mode =3D=3D

I will fix that soon.
I split the line because it was to long. I know some people don't like =
=20
more than
80 chars a line. This is why I did this.

>
>
>
>> +                       HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFTIRQ);
>>               hrtimer_wait_for_timer(timer);
>>       }
>> }
>> @@ -1298,11 +1301,18 @@ static void __run_hrtimer(struct hrtimer =20
>> *timer)
>>       int restart;
>>
>>       debug_hrtimer_deactivate(timer);
>> -       __remove_hrtimer(timer, base, HRTIMER_STATE_CALLBACK, 0);
>> -       timer_stats_account_hrtimer(timer);
>>
>>       fn =3D timer->function;
>> -       if (timer->cb_mode =3D=3D HRTIMER_CB_IRQSAFE_NO_SOFTIRQ) {
>> +
>> +       switch (timer->cb_mode) {
>> +       case HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFTIRQ:
>> +               __remove_hrtimer(timer, base, =20
>> HRTIMER_STATE_INACTIVE, 0);
>
> Correct me if I'm wrong but there is a lot of code reworking and code
> expansion here, when really the above line is the only difference
> between your new HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFTIRQ
> and HRTIMER_CB_IRQSAFE_NO_SOFTIRQ.
> It is not even strictly necessary to return, since the rest of the
> function should be safe. I have attached an alternate smaller patch, =
-
> maybe you'll find it simpler?
>

You're right I did some reworking to have clear situation of what is =20
to be done
depending on the timer's mode.
I'll check your patch as soon as I come back to my office (monday).
I just have an email client down here.

Thank-you for all your comments, John.

>
>> +               timer_stats_account_hrtimer(timer);
>> +               spin_unlock(&cpu_base->lock);
>> +               fn(timer);
>> +               spin_lock(&cpu_base->lock);
>> +               return;
>> +       case HRTIMER_CB_IRQSAFE_NO_SOFTIRQ:
>>               /*
>>                * Used for scheduler timers, avoid lock inversion wit=
h
>>                * rq->lock and tasklist_lock.
>> @@ -1310,11 +1320,17 @@ static void __run_hrtimer(struct hrtimer =20
>> *timer)
>>                * These timers are required to deal with enqueue =20
>> expiry
>>                * themselves and are not allowed to migrate.
>>                */
>> +               __remove_hrtimer(timer, base, =20
>> HRTIMER_STATE_CALLBACK, 0);
>> +               timer_stats_account_hrtimer(timer);
>>               spin_unlock(&cpu_base->lock);
>>               restart =3D fn(timer);
>>               spin_lock(&cpu_base->lock);
>> -       } else
>> +               break;
>> +       default:
>> +               __remove_hrtimer(timer, base, =20
>> HRTIMER_STATE_CALLBACK, 0);
>> +               timer_stats_account_hrtimer(timer);
>>               restart =3D fn(timer);
>> +       }
>>
>>       /*
>>        * Note: We clear the CALLBACK bit after enqueue_hrtimer to =20
>> avoid
>> @@ -1516,7 +1532,7 @@ void hrtimer_init_sleeper(struct =20
>> hrtimer_sleeper *sl, struct task_struct *task)
>>       sl->timer.function =3D hrtimer_wakeup;
>>       sl->task =3D task;
>> #ifdef CONFIG_HIGH_RES_TIMERS
>> -       sl->timer.cb_mode =3D HRTIMER_CB_IRQSAFE_NO_SOFTIRQ;
>> +       sl->timer.cb_mode =3D HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFTI=
RQ;
>> #endif
>> }
>>
>> --
>> 1.5.2.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-=20
>> users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> <hrtimers_stuck_in_waitq-jk.patch>

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
