From: Michael Langfinger <linux-rt-users@langfinger.org>
Subject: Re: 3.10.9-rt5 with Atmel AT91SAM9G25 SoC triggers "Trying to free  already-free IRQ 1"
Date: Sat, 09 Nov 2013 21:37:50 +0100
Message-ID: <4532aa9843b9bc12ba1f645b257bcc0b-EhVcX1hHQARfWkQdAQYAWQoDGQlVS19cWF9EAVxEXEI3UlEWXV5/H1RcQ11dRSoDXFJdQFpcXA9f-webmailer2@server01.webmailer.hosteurope.de>
References: <EBD2DE4ADA47B94E831AED12A4B0CADA67E950BA@edb1.wapice.localdomain>
 <aa8bdc572d2b3fc1f5c1c92293990143-EhVcX1hHQARfWkQdAQYAWQoDGQlVS19cWF9EAVxEXEI3UlEWXV5/H1FTQ11bSSoDXF1RQFtXWAhY-webmailer2@server02.webmailer.hosteurope.de>
 <20131011100951.GC6983@linutronix.de>
 <EBD2DE4ADA47B94E831AED12A4B0CADA67EBD1B2@edb0.wapice.localdomain>
 <20131018140346.GA14569@linutronix.de>
 <EBD2DE4ADA47B94E831AED12A4B0CADA67ECB109@edb1.wapice.localdomain>
 <EBD2DE4ADA47B94E831AED12A4B0CADA67ECF09C@edb1.wapice.localdomain>
 <20131108221721.GB13367@linutronix.de>
Reply-To: linux-rt-users@langfinger.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Sami_Pietik=C3=A4inen?= <Sami.Pietikainen@wapice.com>,
	<linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout02.webmailer.hosteurope.de ([80.237.138.58]:38714 "EHLO
	mailout02.webmailer.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757261Ab3KIUq6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 9 Nov 2013 15:46:58 -0500
In-Reply-To: <20131108221721.GB13367@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 Hello Sebastian,

 sorry, I had so many other things on my mind in the last few weeks tha=
t=20
 I totally forgot to keep you updated about the matter.

 Yes, the patch from Sami solves my problem, I tested the patch with=20
 kernel 3.10.17-rt12. The system boots just fine, no more warnings and=20
 the serial console is back, too. Thanks a lot, Sami! The only remainin=
g=20
 problem for now seems to be that the system does not boot if I enable=20
 the high resolution timer support (CONFIG_HIGH_RES_TIMERS - the same=20
 problem that Sami described a while ago).

 Kind regards,
 Michael Langfinger

> * Sami Pietik=C3=A4inen | 2013-10-28 13:59:53 [+0000]:
>
>>It seems that there is an irq number mismatch in the=20
>> "arm-at91-pit-remove-irq-handler-when-clock-is-unused.patch".
>>The patch adds setup_irq() and remove_irq() calls which have=20
>> different irq number than the base driver.
>>
>>If I'm correct, the irq number should be NR_IRQS_LEGACY + AT91_ID_SYS=
=20
>> instead of only AT91_ID_SYS.
>>
>>I have attached a fixed patch for 3.6.9-rt21. I tested it with=20
>> SAMA5D35, and it removed the
>>"Trying to free already-free IRQ 1" boot warnings.
>
> Michael, any feedback? Does this solve your problem, too?
>
>>BR,
>>Sami Pietik=C3=A4inen
>
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
