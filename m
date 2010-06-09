From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Calculating latency using high resolution timer
Date: Wed, 9 Jun 2010 20:30:38 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1006092028280.2933@localhost.localdomain>
References: <AANLkTikuWI08hHb2BdzicdEYKO4SdQlCL17gDQgqwrKz@mail.gmail.com> <AANLkTinCc-TibWfphYTZtXhDh2flvrcXNW_bO3SUetyV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: "Sarin, Suseelan" <suseelan@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:57704 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470Ab0FISaq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Jun 2010 14:30:46 -0400
In-Reply-To: <AANLkTinCc-TibWfphYTZtXhDh2flvrcXNW_bO3SUetyV@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 9 Jun 2010, Sarin, Suseelan wrote:

> Hi All,
> 
> My real-time program has a thread which needs to run at every 2ms. I
> want to calculate the latency of this thread and I am using
> clock_gettime for this. I am bit confused here that whether I can do
> this. My doubt is, if the system is loaded to the extend that an RT
> task can have considerable latency, can I trust the time read from the
> high resolution timer of the system?

Yes, it's accurate. cyclictest relies on that as well.

> Also, with these measurements, I am seeing a ~5msec latency. Is there
> a way I can exactly point out the reason for this latency?

Tracing. See cyclictest.c for how that's done.

Thanks,

	tglx
