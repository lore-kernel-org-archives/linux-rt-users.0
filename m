From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH V2 0/1] Add sched_clock to Atmel TCB clock source
Date: Wed, 10 Jun 2015 18:35:39 +0200
Message-ID: <20150610163539.GB24273@linutronix.de>
References: <20150602214617.585540231@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52848 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965786AbbFJQfk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Jun 2015 12:35:40 -0400
Content-Disposition: inline
In-Reply-To: <20150602214617.585540231@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Carsten Emde | 2015-06-02 23:46:17 [+0200]:

>Hi Thomas,
Hi Carsten,

>here comes V2 of the patch to add sched_clock to the Atmel TCB clock source.
>It provides the sched_clock:
>32 bits at 16MHz, resolution 60ns, wraps every 260301047747ns 
>
>It is not yet clear, why interrupts are enabled when this code is running.
Do I get access to the HW in question?

>Thanks,
>	-Carsten.

Sebastian
