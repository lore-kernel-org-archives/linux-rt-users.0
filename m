Return-Path: <SRS0=5J30=EC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46677C55179
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 09:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D963D20759
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 09:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="IgAFWVzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896001AbgJ0JuA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Oct 2020 05:50:00 -0400
Received: from mout.gmx.net ([212.227.15.19]:38383 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895997AbgJ0Jt7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Oct 2020 05:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603792146;
        bh=md6P4mIqJNm4Z74SBvAdHygGTPRRylq7Nvq0KO6MK8Y=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=IgAFWVzvKwQlOWPFmIBfMhwu/xClwCCQwXxAFt3GlFoIc5KYjW6vpk7HrCPJZPQcA
         WS99T9NRyjnzhhXXU4C/XIiBRw5+2RRJs//804YWUvjPXnXTXNtcSXOij4n/KUoyFm
         8Jb6LpEn2oVg4WW2FkKBFtdmuvpXuw0fA0KSdbrM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.146.51.69]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3Rs-1kpPv22hNW-00LSWT; Tue, 27
 Oct 2020 10:49:06 +0100
Message-ID: <73f0a095b06ce8778411cc251d0edf6ffe46557c.camel@gmx.de>
Subject: Re: kvm+nouveau induced lockdep  gripe
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Hillf Danton <hdanton@sina.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Skeggs <bskeggs@redhat.com>
Date:   Tue, 27 Oct 2020 10:49:04 +0100
In-Reply-To: <20201027090019.3vteojm43ljqqe33@linutronix.de>
References: <20201021125324.ualpvrxvzyie6d7d@linutronix.de>
         <a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de>
         <20201023090108.5lunh4vqfpkllmap@linutronix.de>
         <20201024022236.19608-1-hdanton@sina.com>
         <20201024050000.8104-1-hdanton@sina.com>
         <20201026173107.quylcy6fgjvrqat6@linutronix.de>
         <431e81699f2310eabfe5af0a3de400ab99d9323b.camel@gmx.de>
         <20201026195308.wsbk7xy57wuzfbao@linutronix.de>
         <0dfae65db2f0d3ef603c1db34f37cee63f7f41f4.camel@gmx.de>
         <20201027090019.3vteojm43ljqqe33@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QphFDyGFLVb07ZImYmAxiVppT+XiPpb9UaX/lJgNTkxbHrtfSMi
 enEPFBq4CpL0RJ6aCoT4I1PhGlP80T2J1nZCSM7xeVScae1V20N+gXxVgVID4UobzN75YKY
 qlhZLICW+VC0unc1RXfaywQsbCODsRUFpoye+7fZLX98Ym5D+1kyorBRR81AraCpk/rX9eO
 myJdGp0W/6fRpyFZsSGHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:27DmJYfCjFQ=:KDv21O6CDGrEm5LiFRRfhz
 BQuWXGAje3IYxJZcAEFOFha0asFEUB9baTjHAmALrzU6Suy7wVxVPSK7vOmpa83IHLgqM84NB
 xJQgPTnBXo8kT0JQM1RHzzZ5U6S85I4qmXNsamHBU5fO1lYKjTYdnIgUvv/+BLBSUTlc9XYZn
 DTCPk/nrErsGskT3FVStmzlpGfLuIuJMlKo/uuAcIxofR/vg3GCnGk/5k456yAs1pYhk+BT1K
 lglEQLCK6wcp44axjc45FtrXfoKHSZ9qsnKL8PEYRQ5Zo1aonhnqhl+pT0E8MTSh12Vm+SNpE
 arsmmRtBnbdC0V1OO/XfAEL/psFiEsRo0GtwdSo/dujqk3DbFpzdijIi8Mp2YddwyqH1GRAxJ
 Z+IYcWp5IGLWq2gu7yPP5lJgc7lZbPa9NxshAoGRuERME5UEb5QtYjTaAbSBtzjecDoFndjbV
 pVfNevkAP236OOUBfrYWOW81xDfyM+Y3ty133X8rzNbe5SKINi0IGRDaICxwye3M5wPWZuEmJ
 5UXiok33v7/7d7UDYMok0YKb2JnZu5zstU9cVhBa+vOGf0aOx0LtI572WXN8sFkGa00WxncGW
 s98BU1W/TJvzWpJcY0Zb+OWXWLvdq2MVGfeS3dQ9Nj4vY4SUfLPmTzpMfisbtnL5YJbME1ys5
 fSrnPol5IXlkumNJHgXZbpou5nPMN6m2ZQkm4CDsm8hougAppTZQlWPzoffCeQX1nGXVw6Tpe
 Y26+58tsDTUfPpZRjR03B2G2iSxsoS1MC2KtnybBdEoRuFuTCw4cV74hVSb0jEHvH01AarBqC
 boTh4yavW9wfFUubPbwO6LcMnVU88CtCdpQO1Lo75CDitt7MxqgVHxiqHCmZGMoM+yB3YTLRg
 Uzzh3I53T9Y2hBGpmQkA==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2020-10-27 at 10:00 +0100, Sebastian Andrzej Siewior wrote:
> On 2020-10-27 07:03:38 [+0100], Mike Galbraith wrote:
> > On Mon, 2020-10-26 at 20:53 +0100, Sebastian Andrzej Siewior wrote:
> > >
> > > Could you try this, please?
> >
> > Nogo, first call of sched_setscheduler() is via kthread_create().  I
> > confirmed that nuking that (gratuitous user foot saving override) call
> > on top of moving sched_set_fifo() does shut it up, but that won't fly.
>
> mkay. but this then, too.

Yup, might even fly.

>  Let me try if I can figure out when this
> broke.
>
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 3edaa380dc7b4..64d6afb127239 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -244,6 +244,7 @@ EXPORT_SYMBOL_GPL(kthread_parkme);
>  static int kthread(void *_create)
>  {
>  	/* Copy data: it's on kthread's stack */
> +	static const struct sched_param param =3D { .sched_priority =3D 0 };
>  	struct kthread_create_info *create =3D _create;
>  	int (*threadfn)(void *data) =3D create->threadfn;
>  	void *data =3D create->data;
> @@ -273,6 +274,13 @@ static int kthread(void *_create)
>  	init_completion(&self->parked);
>  	current->vfork_done =3D &self->exited;
>
> +	/*
> +	 * root may have changed our (kthreadd's) priority or CPU mask.
> +	 * The kernel thread should not inherit these properties.
> +	 */
> +	sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
> +	set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_KTHREAD));
> +
>  	/* OK, tell user we're spawned, wait for stop or wakeup */
>  	__set_current_state(TASK_UNINTERRUPTIBLE);
>  	create->result =3D current;
> @@ -370,7 +378,6 @@ struct task_struct *__kthread_create_on_node(int (*t=
hreadfn)(void *data),
>  	}
>  	task =3D create->result;
>  	if (!IS_ERR(task)) {
> -		static const struct sched_param param =3D { .sched_priority =3D 0 };
>  		char name[TASK_COMM_LEN];
>
>  		/*
> @@ -379,13 +386,6 @@ struct task_struct *__kthread_create_on_node(int (*=
threadfn)(void *data),
>  		 */
>  		vsnprintf(name, sizeof(name), namefmt, args);
>  		set_task_comm(task, name);
> -		/*
> -		 * root may have changed our (kthreadd's) priority or CPU mask.
> -		 * The kernel thread should not inherit these properties.
> -		 */
> -		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
> -		set_cpus_allowed_ptr(task,
> -				     housekeeping_cpumask(HK_FLAG_KTHREAD));
>  	}
>  	kfree(create);
>  	return task;
>
> Sebastian

