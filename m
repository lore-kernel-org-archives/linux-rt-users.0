From: Alexander Fyodorov <halcy@yandex.ru>
Subject: Re: [PATCH rt] Fix races in ptrace
Date: Thu, 29 Aug 2013 22:47:22 +0400
Message-ID: <18551377802042@web15m.yandex.ru>
References: <102271374683007@web8f.yandex.ru> <20130812164145.GJ23040@linutronix.de> <393831376342036@web15d.yandex.ru> <20130821172431.GD16913@linutronix.de> <96171377181398@web13h.yandex.ru> <20130829163300.GC15360@linutronix.de> <143271377797197@web5m.yandex.ru> <521F92D9.5090701@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from forward6.mail.yandex.net ([77.88.60.125]:50547 "EHLO
	forward6.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756801Ab3H2Sr0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Aug 2013 14:47:26 -0400
In-Reply-To: <521F92D9.5090701@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

29.08.2013, 22:28, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>:
> On 08/29/2013 07:26 PM, Alexander Fyodorov wrote:
>> =9AStill this is only half of the solution because the patch doesn't=
 solve the race in wait_task_inactive() (and all other places which tes=
t both state and saved_state without holding pi_lock).
>
> So you are concerned that missing pi_lock in wait_task_inactive(). Th=
is
> is a problem if the task wakes up from sleeping on the lock while its
> state is beeing checked. Hmm it indeed looks legal.
> I keep that patch in queue but disabled and take another look once I
> get back.
> Does this missing pi_lock() affects you or is just a precaution?

Yes, my test application failed because of it, a detailed description i=
s in the first message in the thread. I've also looked at other places =
that test saved_state but I don't understand the code enough to decide =
whether there are similar bugs there or not.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
