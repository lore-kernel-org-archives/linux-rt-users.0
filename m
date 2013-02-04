From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: kfree causing high latency on 3.4.4-rt13
Date: Mon, 4 Feb 2013 12:49:56 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1302041245060.11905@ionos>
References: <CAOY97VYWzxz-=HNYamCdqOzjXPsAyKjETZ3Hv7V3K4CZ6YB1kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Austin Hendrix <ahendrix@willowgarage.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43198 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001Ab3BDLt6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Feb 2013 06:49:58 -0500
In-Reply-To: <CAOY97VYWzxz-=HNYamCdqOzjXPsAyKjETZ3Hv7V3K4CZ6YB1kQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 29 Jan 2013, Austin Hendrix wrote:
> I'm running 3.4.4-rt13 on my systems, and while the realtime
> performance is great, I occasionally see non-realtime processes block
> for several seconds. Running latencytop, it looks like the kfree
> kernel process is the worst offender. Does anyone have advice on how I

There is no kfree process. kfree() is a function to release memory
allocated by kmalloc.

Can you provide the latencytop output please ?

Thanks,

	tglx
