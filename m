From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Patch RT] Fix CFS load balancing for RT tasks
Date: Wed, 11 Jul 2007 19:06:20 +0200
Message-ID: <1184173580.12353.105.camel@chaos>
References: <20070711164708.48907792@frecb000686.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linux RT Users <linux-rt-users@vger.kernel.org>,
	Darren Hart <dvhltc@us.ibm.com>,
	john stultz <johnstul@us.ibm.com>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Gilles Carry <Gilles.Carry@ext.bull.net>,
	Steven Rostedt <rostedt@goodmis.org>
To: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:41335 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751052AbXGKRG1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Jul 2007 13:06:27 -0400
In-Reply-To: <20070711164708.48907792@frecb000686.frec.bull.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-07-11 at 16:47 +0200, S=C3=A9bastien Dugu=C3=A9 wrote:
>   The following patch fixes this by re-enabling the RT overload detec=
tion
> for the CFS. It may not be the right solution, maybe it should be inc=
orporated
> into the other load balancing mechanisms. I did not digg deep enough =
yet
> to make that call ;-)
>=20
>   P.S. Thanks to Steven Rostedt for logdev which is proving invaluabl=
e in
>        cases like this.
>=20
>   S=C3=A9bastien.

Nice catch. That was dropped during the CFS -> -rt merge.

	tglx

> ------------------
>=20
>   The RT overload mechanism of the O(1) scheduler has not been activa=
ted
> in the new CFS.
>=20
>   This patch fixes that by inserting calls to inc_rt_tasks() and dec_=
rt_tasks()
> in enqueue_task_rt() and dequeue_task_rt() respectively, which enable=
s the
> balance_rt_tasks() to be run in the rt_overload case.
>=20
>=20
> Signed-off-by: S=C3=A9bastien Dugu=C3=A9 <sebastien.dugue@bull.net>
>=20
> ---
>  kernel/sched_rt.c |    4 ++++
>  1 file changed, 4 insertions(+)
>=20
> Index: linux-2.6.21.5-rt20/kernel/sched_rt.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.21.5-rt20.orig/kernel/sched_rt.c	2007-07-11 10:46:26.00=
0000000 +0200
> +++ linux-2.6.21.5-rt20/kernel/sched_rt.c	2007-07-11 10:46:50.0000000=
00 +0200
> @@ -32,6 +32,8 @@ enqueue_task_rt(struct rq *rq, struct ta
> =20
>  	list_add_tail(&p->run_list, array->queue + p->prio);
>  	__set_bit(p->prio, array->bitmap);
> +
> +	inc_rt_tasks(p, rq);
>  }
> =20
>  /*
> @@ -44,6 +46,8 @@ dequeue_task_rt(struct rq *rq, struct ta
> =20
>  	update_curr_rt(rq, now);
> =20
> +	dec_rt_tasks(p, rq);
> +
>  	list_del(&p->run_list);
>  	if (list_empty(array->queue + p->prio))
>  		__clear_bit(p->prio, array->bitmap);
