From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: workqueue realtime priority
Date: Fri, 25 Oct 2013 19:59:52 +0200
Message-ID: <20131025175952.GB21841@linutronix.de>
References: <9B7F15AA4177464A8FAB5BE79B14288B889580FE@vistrex4.vi.vector.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Frederich, Jens" <Jens.Frederich@vector.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42225 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab3JYR7x (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Oct 2013 13:59:53 -0400
Content-Disposition: inline
In-Reply-To: <9B7F15AA4177464A8FAB5BE79B14288B889580FE@vistrex4.vi.vector.int>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Frederich, Jens | 2013-10-15 13:04:22 [+0000]:

>Hi all,
Hi Jems,

>is there any way to set the global workqueue priority to real
>time or setup a workqueue with real time priority on Linux RT
>3.x? I want to setup a kernel worker thread with real time
>priority. What's the best way? Should I better use tasklets?

There is the chrt tool to change the priority of a task. But the workers  are
created on demand and shared with others so it won't be good.
Whether it is good to use a tasklet or not depends on what you try to
do. But since you can't alter the priority of the tasklet (and only of
tasklet) it is probably not better.

>Thanks
>Jens

Sebastian
