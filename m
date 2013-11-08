From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.10.9-rt5 with Atmel AT91SAM9G25 SoC triggers "Trying to free
 already-free IRQ 1"
Date: Fri, 8 Nov 2013 23:17:21 +0100
Message-ID: <20131108221721.GB13367@linutronix.de>
References: <EBD2DE4ADA47B94E831AED12A4B0CADA67E950BA@edb1.wapice.localdomain>
 <aa8bdc572d2b3fc1f5c1c92293990143-EhVcX1hHQARfWkQdAQYAWQoDGQlVS19cWF9EAVxEXEI3UlEWXV5/H1FTQ11bSSoDXF1RQFtXWAhY-webmailer2@server02.webmailer.hosteurope.de>
 <20131011100951.GC6983@linutronix.de>
 <EBD2DE4ADA47B94E831AED12A4B0CADA67EBD1B2@edb0.wapice.localdomain>
 <20131018140346.GA14569@linutronix.de>
 <EBD2DE4ADA47B94E831AED12A4B0CADA67ECB109@edb1.wapice.localdomain>
 <EBD2DE4ADA47B94E831AED12A4B0CADA67ECF09C@edb1.wapice.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Langfinger <linux-rt-users@langfinger.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Sami =?utf-8?Q?Pietik=C3=A4inen?= <Sami.Pietikainen@wapice.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33110 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758435Ab3KHWRX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Nov 2013 17:17:23 -0500
Content-Disposition: inline
In-Reply-To: <EBD2DE4ADA47B94E831AED12A4B0CADA67ECF09C@edb1.wapice.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Sami Pietik=C3=A4inen | 2013-10-28 13:59:53 [+0000]:

>It seems that there is an irq number mismatch in the "arm-at91-pit-rem=
ove-irq-handler-when-clock-is-unused.patch".
>The patch adds setup_irq() and remove_irq() calls which have different=
 irq number than the base driver.
>
>If I'm correct, the irq number should be NR_IRQS_LEGACY + AT91_ID_SYS =
instead of only AT91_ID_SYS.
>
>I have attached a fixed patch for 3.6.9-rt21. I tested it with SAMA5D3=
5, and it removed the=20
>"Trying to free already-free IRQ 1" boot warnings.

Michael, any feedback? Does this solve your problem, too?

>BR,
>Sami Pietik=C3=A4inen

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
