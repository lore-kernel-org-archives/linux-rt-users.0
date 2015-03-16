From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.18.9-rt4 kernel panic - Was: 3.18.9-rt4
Date: Mon, 16 Mar 2015 15:01:50 +0100
Message-ID: <20150316140150.GB28130@linutronix.de>
References: <20150313223041.0a8bf390@archlinux>
 <20150314104336.756a6f0e@archlinux>
 <20150315145153.44f5217c@tor.valhalla.alchemy.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Joakim Hernberg <jhernberg@alchemy.lu>,
	Ralf Mardorf <ralf.mardorf@rocketmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35422 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbbCPOBy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Mar 2015 10:01:54 -0400
Content-Disposition: inline
In-Reply-To: <20150315145153.44f5217c@tor.valhalla.alchemy.lu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Joakim Hernberg | 2015-03-15 14:51:53 [+0100]:

>I remember that you had boot problems a while ago, together
>with a couple of other AMD cpu users.  IIRC it just affected a few
>specific AMD cpus.  AFAIK, you could not succesfully boot any kernel
>starting with with 3.12.6-rt9, and I have another report from another
>afflicted user saying that the boot problem was fixed by reverting:
>
>timers-do-not-raise-softirq-unconditionally.patch
>timer-Raise-softirq-if-there-s-irq_work.patch
>timer-rt-Always-raise-the-softirq-if-there-s-irq_wor.patch
>
>This might be significant, as these patches are in play again, at
>least on 3.18-rt.

As of v3.18-RT these patches are revereted. In two pix I see cpufreq
with k8. My AMD here uses acpi-cpufreq so I never run into this. So
maybe I find something once I look=E2=80=A6. I the meantime you could y=
ou please
drop cpufreq from your .config and try again?

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
