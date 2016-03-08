From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC v0] Use swait in completion
Date: Tue, 8 Mar 2016 18:52:06 +0100
Message-ID: <20160308175206.GD21842@linutronix.de>
References: <1457452754-24029-1-git-send-email-wagi@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Daniel Wagner <wagi@monom.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52486 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbcCHRwK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Mar 2016 12:52:10 -0500
Content-Disposition: inline
In-Reply-To: <1457452754-24029-1-git-send-email-wagi@monom.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Daniel Wagner | 2016-03-08 16:59:13 [+0100]:

>Hi,
Hi,

>As Peter correctly pointed out in [1] a simple conversion from
>wait to swait in completion.c wont work. I played a bit around and
>came up with this rather ugly idea.

besides all the things I mentioned privatly, here is what I have
currently in -RT:

+void swake_up_all_locked(struct swait_queue_head *q)
+{
+       struct swait_queue *curr;
+       int wakes =3D 0;
+
+       while (!list_empty(&q->task_list)) {
+
+               curr =3D list_first_entry(&q->task_list, typeof(*curr),
+                                       task_list);
+               wake_up_process(curr->task);
+               list_del_init(&curr->task_list);
+               wakes++;
+       }
+       WARN_ON(wakes > 2);
+}
+EXPORT_SYMBOL(swake_up_all_locked);

the remaining part is what you have. The only user so far is complete()
and currently I see ony complete_all() with zero or one waiter.
If none of my boxes die over the night, I intend to release this
tomorrow in -RT and see if someone else triggers the limit.

However I don't think if your DEFER flag solution is all that bad. I
have also the block-mq in -RT using swait and they perform wakes with
irqs-off. Not in -RT but mainline. So me might need something to make i=
t
work properly. But if we defer the wakeup they might come at us and
complain about the latency=E2=80=A6

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
