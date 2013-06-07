From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Getting "BUG: sleeping function"
Date: Fri, 7 Jun 2013 10:54:01 +0200
Message-ID: <20130607085401.GB10280@linutronix.de>
References: <3AE1C3304537E04B84F686355CB6716501C09073@mail-srv.asocstech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Eyal Cohen <eyalc@asocstech.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45010 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788Ab3FGIyD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Jun 2013 04:54:03 -0400
Content-Disposition: inline
In-Reply-To: <3AE1C3304537E04B84F686355CB6716501C09073@mail-srv.asocstech.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Eyal Cohen | 2013-05-09 11:46:11 [+0300]:

>Hello.
Hi,

>All seems to work smoothly, except I'm getting a BUG "sleeping function
>called from invalid context" print for calling "pci_unregister_driver()"
>from my module exit function.
>>From what I understand, the exit function is called from the rmmod
>process, using a regular thread and should not be in atomic mode.
>Therefore it should be able to acquire spinlocks without problem, since
>it could sleep.
>So why is this happening?

My guess would be that you disabled interrupts somewhere in MPUExit().

Sebastian
