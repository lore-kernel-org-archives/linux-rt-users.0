From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC v1 1/3] work-simple: Simple work queue implemenation
Date: Fri, 13 Feb 2015 13:09:21 +0100
Message-ID: <20150213120921.GA5482@linutronix.de>
References: <1405085173-20449-1-git-send-email-daniel.wagner@oss.bmw-carit.de>
 <1405085173-20449-2-git-send-email-daniel.wagner@oss.bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Daniel Wagner <daniel.wagner@oss.bmw-carit.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60086 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbbBMMJX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Feb 2015 07:09:23 -0500
Content-Disposition: inline
In-Reply-To: <1405085173-20449-2-git-send-email-daniel.wagner@oss.bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Daniel Wagner | 2014-07-11 15:26:11 [+0200]:

>diff --git a/kernel/sched/work-simple.c b/kernel/sched/work-simple.c
>--- /dev/null
>+++ b/kernel/sched/work-simple.c
=E2=80=A6
>+static int swork_kthread(void *arg)
>+{
>+	struct sworker *sw =3D arg;
>+	struct swork_event *ev;
>+
>+	pr_info("swork_kthread enter\n");
>+
>+	for (;;) {
>+		swait_event_interruptible(sw->wq,
>+					swork_readable(sw));
>+		if (kthread_should_stop())
>+			break;
>+
>+		raw_spin_lock(&sw->lock);

why not the _irq() suffix?

>+		while (!list_empty(&sw->events)) {
>+			ev =3D list_first_entry(&sw->events,
>+					struct swork_event, list);
>+			list_del_init(&ev->list);
>+
>+			raw_spin_unlock(&sw->lock);
>+
>+			ev->func(ev);
>+			xchg(&ev->flags, 0);

I've been looking at this for a while and this won't work in longterm.
Why do you bother using xchg if you don't look at the return value?
Also, you need to clear that flag _before_ invoking ->func() because
while that function is beeing executed someone might do another
queue_work() and expects that that work item invoked again. Atleast thi=
s
is how queue_work() behaves and I would want the same here.

But don't worry. I fix this up to me needs so there is nothing you need
to worry about. The remaining part is simple. Thanks.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
