From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [RFC v0] Use swait in completion
Date: Tue, 8 Mar 2016 19:07:16 +0100
Message-ID: <56DF14D4.4010203@bmw-carit.de>
References: <1457452754-24029-1-git-send-email-wagi@monom.org>
 <20160308175206.GD21842@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <wagi@monom.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:44800 "EHLO
	mail.bmw-carit.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbcCHSHW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Mar 2016 13:07:22 -0500
In-Reply-To: <20160308175206.GD21842@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/08/2016 06:52 PM, Sebastian Andrzej Siewior wrote:
> However I don't think if your DEFER flag solution is all that bad. I
> have also the block-mq in -RT using swait and they perform wakes with
> irqs-off. Not in -RT but mainline. So me might need something to make=
 it
> work properly. But if we defer the wakeup they might come at us and
> complain about the latency=E2=80=A6

I intended to extend the test code to measure the latency diff as well.
Just to get a feeling how bad it is. At least with a lot of waiters on
the completion the current measurement indicate an improvement. I guess
with real workload the things look quite different.

cheers,
daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
