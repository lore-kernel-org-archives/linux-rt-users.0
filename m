From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH rt] Fix races in ptrace
Date: Thu, 29 Aug 2013 20:49:16 +0200
Message-ID: <521F97AC.8080505@linutronix.de>
References: <102271374683007@web8f.yandex.ru> <20130812164145.GJ23040@linutronix.de> <393831376342036@web15d.yandex.ru> <20130821172431.GD16913@linutronix.de> <96171377181398@web13h.yandex.ru> <20130829163300.GC15360@linutronix.de> <143271377797197@web5m.yandex.ru> <521F92D9.5090701@linutronix.de> <18551377802042@web15m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Alexander Fyodorov <halcy@yandex.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52191 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755070Ab3H2StT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Aug 2013 14:49:19 -0400
In-Reply-To: <18551377802042@web15m.yandex.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/29/2013 08:47 PM, Alexander Fyodorov wrote:
>=20
> Yes, my test application failed because of it, a detailed description=
 is in the first message in the thread. I've also looked at other place=
s that test saved_state but I don't understand the code enough to decid=
e whether there are similar bugs there or not.

Yes, you did I just wanted to make sure since it looks like a very
small race window. Will take a look on the remaining part once I get
back=E2=80=A6

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
