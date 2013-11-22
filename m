From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.12.0-rt2
Date: Fri, 22 Nov 2013 15:23:45 +0100
Message-ID: <20131122142345.GC8698@linutronix.de>
References: <20131116194633.GD11518@linutronix.de>
 <EBD2DE4ADA47B94E831AED12A4B0CADA67EE68DA@edb0.wapice.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Langfinger <linux-rt-users@langfinger.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sami =?utf-8?Q?Pietik=C3=A4inen?= <Sami.Pietikainen@wapice.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44873 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755601Ab3KVOXq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Nov 2013 09:23:46 -0500
Content-Disposition: inline
In-Reply-To: <EBD2DE4ADA47B94E831AED12A4B0CADA67EE68DA@edb0.wapice.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Sami Pietik=C3=A4inen | 2013-11-19 07:38:27 [+0000]:

>> - tried to fix AT91's "already-free IRQ" and highres problem. Michae=
l
>>   Langfinge reported it initially and Sami Pietik=C3=A4inen sent a p=
atch for
>>   the "already-free IRQ" problem. Based on another patch I looked at=
 the
>>   highres patch and tried to fix it. As I don't have the hardware, s=
ome
>>   feedback would be nice.
>
>I did a quick test run with the 3.12.0-rt2 kernel. There are no "Tryin=
g to free already free IRQ 1" warnings anymore so that issue seems to b=
e fixed. However, the system still hangs.
>
>CONFIG_HIGH_RES_TIMERS=3Dy
>CONFIG_ATMEL_TCB_CLKSRC=3Dy
>Hangs (or resets if the WD is enabled)
>
>CONFIG_HIGH_RES_TIMERS=3Dy
>CONFIG_ATMEL_TCB_CLKSRC=3Dn
>Boots ok.
>
>Now the kernel boots with the CONFIG_HIGH_RES_TIMERS enabled, but hang=
s when I enable the TCB clock source.
>Michael, if you have spare time, maybe you could also test these confi=
gs to see if you have similar behavior.
Okay. So in the working variant with TCB=3Dn, do you have high res time=
rs
available?

>BR,
>Sami Pietik=C3=A4inen

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
