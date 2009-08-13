From: John Kacur <jkacur@gmail.com>
Subject: Re: [PATCH][RT] Fix build errors in rtmutex
Date: Thu, 13 Aug 2009 13:04:57 +0200
Message-ID: <520f0cf10908130404p86c991k85dcd797e7e21baa@mail.gmail.com>
References: <1250138467.15796.16.camel@quadrophenia.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Sven-Thorsten Dietrich <sdietrich@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yx0-f175.google.com ([209.85.210.175]:33889 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbZHMLE5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Aug 2009 07:04:57 -0400
In-Reply-To: <1250138467.15796.16.camel@quadrophenia.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Aug 13, 2009 at 6:41 AM, Sven-Thorsten
Dietrich<sdietrich@novell.com> wrote:
> Subject: Fix up "too few parameters to function" build errors in rtmu=
tex
> From: Sven-Thorsten Dietrich <sdietrich@suse.de>
>
> Signed-off-by: Sven-Thorsten Dietrich <sdietrich@suse.de>
> Index: b/kernel/rtmutex.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/kernel/rtmutex.c
> +++ b/kernel/rtmutex.c
> @@ -1513,7 +1513,8 @@ int rt_mutex_start_proxy_lock(struct rt_
>
> =A0 =A0 =A0 =A0mark_rt_mutex_waiters(lock);
>
> - =A0 =A0 =A0 if (!rt_mutex_owner(lock) || try_to_steal_lock(lock, ta=
sk)) {
> + =A0 =A0 =A0 if (!rt_mutex_owner(lock) ||
> + =A0 =A0 =A0 =A0 =A0try_to_steal_lock(lock, task, STEAL_NORMAL)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* We got the lock for task. */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0debug_rt_mutex_lock(lock);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rt_mutex_set_owner(lock, task, 0);
> @@ -1522,7 +1523,8 @@ int rt_mutex_start_proxy_lock(struct rt_
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 ret =3D task_blocks_on_rt_mutex(lock, waiter, task, det=
ect_deadlock);
> + =A0 =A0 =A0 ret =3D task_blocks_on_rt_mutex(lock, waiter, task, det=
ect_deadlock,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0flags);
>
> =A0 =A0 =A0 =A0if (ret && !waiter->task) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> Index: b/kernel/trace/ring_buffer.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2522,7 +2522,7 @@ ring_buffer_peek(struct ring_buffer *buf
> =A0 =A0 =A0 =A0if (event && event->type_len =3D=3D RINGBUF_TYPE_PADDI=
NG)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rb_advance_reader(cpu_buffer);
> =A0 =A0 =A0 =A0if (dolock)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 atomic_)spin_unlock(&cpu_buffer->reader=
_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 atomic_spin_unlock(&cpu_buffer->reader_=
lock);
> =A0 =A0 =A0 =A0local_irq_restore(flags);
>
> =A0 =A0 =A0 =A0if (event && event->type_len =3D=3D RINGBUF_TYPE_PADDI=
NG) {
>
>

Hi Sven

I have to admit I'm scratching my head over this one, I don't see any
rt trees that it applies to. Which version are you referring to here?

Thanks
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
