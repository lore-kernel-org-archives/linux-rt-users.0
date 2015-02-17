From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Solving WARNING: Enabled interrupts issues
Date: Tue, 17 Feb 2015 14:58:13 +0100
Message-ID: <20150217135813.GN26177@linutronix.de>
References: <20141108235647.68a2a00f@crunchbang>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Marc =?utf-8?B?TWFyw60=?= <marc.mari.barcelo@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43820 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933076AbbBQN6P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 08:58:15 -0500
Content-Disposition: inline
In-Reply-To: <20141108235647.68a2a00f@crunchbang>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Marc Mar=C3=AD | 2014-11-08 23:56:47 [+0100]:

>And the handler is a bit long, so I won't post it here. Just say that
>it does its own tasks without any lock, just a memory barrier (mb()),
>and then it calls generic_handle_irq(irq); I also know that irqs are
>enabled even when the handler is called (and, as far as I understand,
>this is due to threaded interrupts) because I printed the value of
>irqs_disabled();

 git grep generic_handle_irq drivers/irqchip/
I looks like you try to implement a irq chip.

>Thanks in advance
>Marc

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
