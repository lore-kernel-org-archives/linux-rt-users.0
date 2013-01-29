From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Re:[PATCH]sched/rt: Do not try to push tasks if pinned task
 switches to RT
Date: Tue, 29 Jan 2013 08:19:05 -0500
Message-ID: <1359465545.17639.19.camel@gandalf.local.home>
References: <446051359450817@web10d.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Libo Chen <chenlibo.3@gmail.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	lizefan@huawei.com, jovi.zhangwei@huawei.com
To: Kirill Tkhai <tkhai@yandex.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:9809 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977Ab3A2NTH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Jan 2013 08:19:07 -0500
In-Reply-To: <446051359450817@web10d.yandex.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2013-01-29 at 13:13 +0400, Kirill Tkhai wrote:

> >=20
> > The task of p->nr_cpus_allowed =3D1 would`t be added to pushable_ta=
sks list =EF=BC=88see the enqueue_task_rt()=EF=BC=89and this push_rt_ta=
sk() need to push other tasks when rt.overloaded.
>=20
> If rq has already had 2 or more pushable tasks and we try to add a pi=
nned task then call of push_rt_task will just waste a time.
>=20

Correct, I just have some minor comments about the patch.

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
