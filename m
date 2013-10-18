From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.10.9-rt5 with Atmel AT91SAM9G25 SoC triggers "Trying to free
 already-free IRQ 1"
Date: Fri, 18 Oct 2013 16:03:47 +0200
Message-ID: <20131018140346.GA14569@linutronix.de>
References: <EBD2DE4ADA47B94E831AED12A4B0CADA67E950BA@edb1.wapice.localdomain>
 <aa8bdc572d2b3fc1f5c1c92293990143-EhVcX1hHQARfWkQdAQYAWQoDGQlVS19cWF9EAVxEXEI3UlEWXV5/H1FTQ11bSSoDXF1RQFtXWAhY-webmailer2@server02.webmailer.hosteurope.de>
 <20131011100951.GC6983@linutronix.de>
 <EBD2DE4ADA47B94E831AED12A4B0CADA67EBD1B2@edb0.wapice.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Langfinger <linux-rt-users@langfinger.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Sami =?utf-8?Q?Pietik=C3=A4inen?= <Sami.Pietikainen@wapice.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40761 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755994Ab3JRODs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Oct 2013 10:03:48 -0400
Content-Disposition: inline
In-Reply-To: <EBD2DE4ADA47B94E831AED12A4B0CADA67EBD1B2@edb0.wapice.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Sami Pietik=C3=A4inen | 2013-10-14 07:24:20 [+0000]:

>Hello Sebastian
Hello Sami,

>>The problem does not look -RT specific.
>
>I would say that at least the "Trying to free already-free IRQ 1" warn=
ing is somehow -RT specific. When I tested the 3.6.9 kernel without the=
 RT patch there were no warnings (using SAMA5D35). The same warning Mic=
hael is having appeared only after applying the patch. However, the oth=
er problems Michael is having might also be something else.
>
>>I don't understand why uart tries over and over to request that inter=
rupt but it simply doesn't work.
>>I am a little confused why at91 is having everything (or more than on=
e
>>device) is on irq 16. It should have only one device on each interrup=
t since they have usually dedicated irq lines.
>
>arm-at91-tclib-default-to-tclib-timer-for-rt.patch has the following c=
omment:
>"RT is not too happy about the shared timer interrupt in AT91
>devices. Default to tclib timer for RT."
>
>Snippet from SAMA5D35 datasheet:
>"Usually, the Debug Unit interrupt line connects to the interrupt sour=
ce 1 of the AIC, which may be shared with the real-time clock, the syst=
em timer interrupt lines and other system peripheral interrupts"
>
>The debug unit also has UART which is probably Michael's ttyS0.

Argh. I missed that detail. So that explains why UART and the timer
share the same interrupt number. Is that timer really disabled in your
config?

>
>BR,
>Sami

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
