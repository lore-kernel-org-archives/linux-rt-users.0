From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: [RFC PATCH] rt/aio: fix rcu garbage collection might_sleep()
 splat
Date: Mon, 09 Jun 2014 13:04:22 +0400
Message-ID: <53957896.6020907@pavlinux.ru>
References: <1402216538.31630.7.camel@marge.simpson.net>	 <5395172E.4010007@cn.fujitsu.com>	 <1402283822.5195.3.camel@marge.simpson.net> <1402294928.6316.38.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402294928.6316.38.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

09.06.2014 10:22, Mike Galbraith =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Mon, 2014-06-09 at 05:17 +0200, Mike Galbraith wrote:
>> On Mon, 2014-06-09 at 10:08 +0800, Lai Jiangshan wrote:
>>> Hi, rt-people

> @@ -522,7 +524,9 @@ static void free_ioctx_users(struct perc
>   	struct kioctx *ctx =3D container_of(ref, struct kioctx, users);
>   	struct kiocb *req;
>
> +	preempt_enable_rt();
>   	spin_lock_irq(&ctx->ctx_lock);
> +	local_irq_disable_rt();
>
>   	while (!list_empty(&ctx->active_reqs)) {
>   		req =3D list_first_entry(&ctx->active_reqs,
> @@ -536,6 +540,8 @@ static void free_ioctx_users(struct perc
>
>   	percpu_ref_kill(&ctx->reqs);
>   	percpu_ref_put(&ctx->reqs);
> +	preempt_disable_rt();
> +	local_irq_enable_rt();


I think, enable_/disable_ must be as mirror reflections


     preempt_enable_rt();
         local_irq_disable_rt();

                 do_something();

         local_irq_enable_rt();
     preempt_disable_rt();



--=20

                                                          Pavel.
