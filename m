From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Kernel thread's CPU affinity with isolcpus kernel boot argument
Date: Thu, 25 Feb 2016 15:18:06 +0100
Message-ID: <20160225141806.GB16161@linutronix.de>
References: <5698D4D0.3020907@etas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Mathias Koehrer <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53557 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932407AbcBYOSI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Feb 2016 09:18:08 -0500
Content-Disposition: inline
In-Reply-To: <5698D4D0.3020907@etas.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mathias Koehrer | 2016-01-15 12:15:28 [+0100]:

>However, I noticed that most kernel threads use the affinity mask 0xff=
=2E
>I can change this by using =E2=80=9Ctaskset=E2=80=9D. However, I am wo=
ndering if
>there is mechanism that forces the kernel to consider the value of
>=E2=80=9Cisolcpus=E2=80=9D also for kernel threads.

not that I am aware of. There are a few per-CPU threads which have to
stay the way they are. I would have expected that others like kworker/u=
*
respect the isol CPUs and stay away.

>Best regards
>
>Mathias

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
