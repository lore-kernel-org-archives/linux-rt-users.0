From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.0-rt3
Date: Wed, 27 Jul 2011 23:49:58 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1107272346290.2660@ionos>
References: <alpine.LFD.2.02.1107241223560.2702@ionos> <4E304268.7080509@ohl.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: sebastian@ohl.name
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43260 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755439Ab1G0VuB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Jul 2011 17:50:01 -0400
In-Reply-To: <4E304268.7080509@ohl.name>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 27 Jul 2011, Sebastian Ohl wrote:

> Hey folks,
> 
> i just tried to compile the new rt patch and i was wondering why i
> cannot select 4GB or 64GB of memory if i am selecting full preemption?
> in my old rt kernel (2.6.33.1) this hasn't been a problem.

As I sadi elsewhere I dropped highmem support for now as the 33-rt
hackery to make it work is just ugly as hell and anything above 4G is
even in mainline a complete disaster.

If possible, just run a 64bit kernel on your machine (you can still
use 32bit userspace) or you have to wait until someone comes up with a
reasonable fix for that problem, unless you are the one tackling it :)

Thanks,

	tglx
