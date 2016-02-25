From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Bisect results for 4.4.1-rt[4,5]
Date: Thu, 25 Feb 2016 15:06:27 +0100
Message-ID: <56CF0A63.7010203@linutronix.de>
References: <20150816135630.GE7004@linutronix.de> <1614199.PesBpXyHut@dabox>
 <56BDA0EF.7090503@linutronix.de> <6333508.b5IKNpgbEX@dabox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Tim Sander <tim@krieglstein.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53506 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759993AbcBYOGd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Feb 2016 09:06:33 -0500
In-Reply-To: <6333508.b5IKNpgbEX@dabox>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/17/2016 09:14 AM, Tim Sander wrote:
> Hi Sebastian

Hi Tim,

> I have done a bisect run, its a rather innocent looking on liner whic=
h seems=20
> to cause the problems. The numbers where reasonably stable so i am pr=
etty=20
> confident that this is the patch giving ~26=B5s additional latency on=
 the Altera
> SOC plattform:
>=20
> eec2bf477ac674583a7d73b9d00f47c528b7266d is the first bad commit
> commit eec2bf477ac674583a7d73b9d00f47c528b7266d
> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date:   Thu Feb 4 16:38:10 2016 +0100
>=20
>     kernel/perf: mark perf_cpu_context's timer as irqsafe
>    =20
>     Otherwise we get a WARN_ON() backtrace and some events are report=
ed as
>     "not counted".
>    =20
>     Cc: stable-rt@vger.kernel.org
>     Reported-by: Yang Shi <yang.shi@linaro.org>
>     Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Seriously? That patch? I played a little and I doubt seriously that
this patch has something to do with it.
So before that patch you would have a warn_on spotted and complained if
that timer would fire. So that is one reason why I doubt that this
patch is in charge of the 25us.

If I add a printk() to that timer I don't see it under "normal"
circumstances. However I do
 perf_4.3 stat -e
branches,branch-misses,bus-cycles,cache-misses,cache-references,cycles,=
instructions
apt-get update

then I see them fire.

> Best Regards
> Tim

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
