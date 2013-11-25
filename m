From: Vijay Katoch <katoch.vijay@gmail.com>
Subject: Re: Livelock in =?utf-8?b?aGFuZGxlX3B0ZV9mYXVsdA==?= [Was: Re: timerfd read does not return]
Date: Mon, 25 Nov 2013 10:36:49 +0000 (UTC)
Message-ID: <loom.20131125T113225-317@post.gmane.org>
References: <516BDE52.90200@meduna.org> <alpine.LFD.2.02.1304151416580.21884@ionos> <516BF8FD.2000700@meduna.org> <516EC3F3.1080406@meduna.org> <516FB8B9.9090506@meduna.org> <517B8D91.4010700@meduna.org> <518CEB45.9080705@meduna.org> <519023C0.2030603@meduna.org> <51909EAE.8070901@meduna.org> <5191F64D.2050509@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51369 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834Ab3KYKkF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Nov 2013 05:40:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1VktaF-0001We-PK
	for linux-rt-users@vger.kernel.org; Mon, 25 Nov 2013 11:40:03 +0100
Received: from 202.27.9.30 ([202.27.9.30])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Nov 2013 11:40:03 +0100
Received: from katoch.vijay by 202.27.9.30 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Nov 2013 11:40:03 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,
I'm also facing timer related issue in 2.6.33.7.2-rt30.
I have an embedded board with PowerPC 5200 running Realtime Linux with=20
version 2.6.33 (OSADL).
My application is using one high resolution timer in Linux for alarms. =
This=20
timer sometimes didn=E2=80=99t expire. The problem happens very rarely,=
 it may go=20
many months between each time it happens on a systems.
The timer is set by function timer_settime with absolute time.
I have done some interesting observations when the timer didn=E2=80=99t=
 expire:=20
- Function timer_gettime returns remaining time 1ns.
- Active timers are checked by displaying file /proc/timer_list and the=
=20
timer_list didn=E2=80=99t show this timer in the active timer list.=20
I have looked into the Linux source and found a possible scenario:
The function timer_gettime ends up in function common_timer_get (posix-
timers.c).  Function common_timer_get returns it_value.tv_nsec =3D 1 if=
 timer=20
is active and remaining time is <=3D 0. This means that the timer has c=
ounted=20
down and the timer state must be 'enqueued' or 'callback'.

I suppose that it is in state 'callback', that means it is running in=20
function __run_hrtimer (hrtimer.c). Function __run_hrtimer is calling=20
function__remove_hrtimer that remove the timer from timer active list b=
efore=20
it changes timer state from 'enqueued' to 'callback'.

Several functions are called in function __run_hrtimer between changing=
=20
timer state to 'callback' and the end of the function where the state=20
'callback' is cleared.  If it is hanging here, the function timer_getti=
me=20
may return 1ns while the timer is not in the active list. Here it is ca=
lling=20
several functions in Linux kernel and the callback function in the=20
application.=20

I have checked the callback function in my application. It is signaling=
 a=20
semaphore and setting the timer again on the same thread. I can't see w=
hy=20
that should not work.=20

Have you observed a similar case?
Do you have any idea of what are going wrong here?



--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
