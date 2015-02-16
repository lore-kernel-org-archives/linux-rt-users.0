From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [RFC v1 1/3] work-simple: Simple work queue implemenation
Date: Mon, 16 Feb 2015 07:45:58 +0100
Message-ID: <54E19226.2070606@bmw-carit.de>
References: <1405085173-20449-1-git-send-email-daniel.wagner@oss.bmw-carit.de> <1405085173-20449-2-git-send-email-daniel.wagner@oss.bmw-carit.de> <20150213120921.GA5482@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@oss.bmw-carit.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:58520 "EHLO
	mail.bmw-carit.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbbBPGwB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Feb 2015 01:52:01 -0500
In-Reply-To: <20150213120921.GA5482@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian,

On 02/13/2015 01:09 PM, Sebastian Andrzej Siewior wrote:
> * Daniel Wagner | 2014-07-11 15:26:11 [+0200]:
>=20
>> diff --git a/kernel/sched/work-simple.c b/kernel/sched/work-simple.c
>> --- /dev/null
>> +++ b/kernel/sched/work-simple.c
> =E2=80=A6
>> +static int swork_kthread(void *arg)
>> +{
>> +	struct sworker *sw =3D arg;
>> +	struct swork_event *ev;
>> +
>> +	pr_info("swork_kthread enter\n");
>> +
>> +	for (;;) {
>> +		swait_event_interruptible(sw->wq,
>> +					swork_readable(sw));
>> +		if (kthread_should_stop())
>> +			break;
>> +
>> +		raw_spin_lock(&sw->lock);
>=20
> why not the _irq() suffix?

Indeed. That should be with a _irq suffix.

>> +		while (!list_empty(&sw->events)) {
>> +			ev =3D list_first_entry(&sw->events,
>> +					struct swork_event, list);
>> +			list_del_init(&ev->list);
>> +
>> +			raw_spin_unlock(&sw->lock);
>> +
>> +			ev->func(ev);
>> +			xchg(&ev->flags, 0);
>=20
> I've been looking at this for a while and this won't work in longterm=
=2E
> Why do you bother using xchg if you don't look at the return value?

=46orgot to mention in the commit message (sorry about that), that I wa=
s
following what I saw in irq_work.c:__irq_work_run(). Looking at it agai=
n
(and reading up a lot on this topic) I agree that doesn't make sense.

> Also, you need to clear that flag _before_ invoking ->func() because
> while that function is beeing executed someone might do another
> queue_work() and expects that that work item invoked again. Atleast t=
his
> is how queue_work() behaves and I would want the same here.

You are right. I tried to simplify what I saw in irq_work and only usin=
g
a PENDING flag instead of a PENDING and BUSY flag. Obviously, my versio=
n
is broken in that regard. I guess the BUSY flag is necessary.

> But don't worry. I fix this up to me needs so there is nothing you ne=
ed
> to worry about. The remaining part is simple. Thanks.

Thanks a lot!

cheers,
daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
