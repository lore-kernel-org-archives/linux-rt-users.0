From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Operation not permitted / pthread_setschedparam
Date: Wed, 1 Oct 2014 01:09:14 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1410010058160.4455@nanos>
References: <542A88A8.7060800@steinhoff.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Armin Steinhoff <armin@steinhoff.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33934 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbaI3XJR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Sep 2014 19:09:17 -0400
In-Reply-To: <542A88A8.7060800@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 30 Sep 2014, Armin Steinhoff wrote:
> a "pthread_setschedparam" call of the code below terminates with an
> errno == 1  ... means "Operation not permitted"
...
> I'm using a PREEMPT_RT kernel 3.4.0-rc7-rt7-2.16  for SuSE 12.2
> Milestone 2 (3.4.11-2.16).
>
> How to solve that problem ?

Hint #1: 3.4.0-rc7-rt7-2.16 

Hint #2: linux/REPORTING-BUGS

Hint #3: Start over at Hint #1

Thanks,

	tglx

