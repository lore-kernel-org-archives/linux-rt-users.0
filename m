From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [4.1.15-rt17] BUG: unable to handle kernel NULL pointer
 dereference at 0000000000000001
Date: Thu, 4 Feb 2016 18:16:55 +0100
Message-ID: <20160204171655.GD3381@linutronix.de>
References: <CALqGcGpG8ShUjPtuwG8BzToLszLHhyf9ELZkaWE2ziq3TL3YrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Christoph Mathys <eraserix@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39998 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551AbcBDRQ4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Feb 2016 12:16:56 -0500
Content-Disposition: inline
In-Reply-To: <CALqGcGpG8ShUjPtuwG8BzToLszLHhyf9ELZkaWE2ziq3TL3YrA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Christoph Mathys | 2015-12-23 14:55:08 [+0100]:

>While running my "infamous" tests with containers[0] on 4.1, I get
>system freezes regularly. I have tried with and without PREEMPT_RT.
>The lockups did only occur on RT and when the cgroup "memory" was in
>use. Without rt or this particular cgroup (cgroup_disable kernel
>parameter), my test ran for ~15h before I stopped it manually.
>
>tldr; CONFIG_MEMCG seem to be broken for PREEMPT_RT.
>
>I don't know if the errors below are directly responsible for the
>system freeze, but they are the last thing I see from the system
>before it freezes.
>
>The second dump below might contain some typos because I had to
>convert it manually from a screenshot to text.

The memcg tests from LTP didn't cause any problems. And after about
three hours trying to get lxc to work I gave up.
So I have no idea how to continue here.

>[0] http://www.spinics.net/lists/linux-rt-users/msg14262.html

Sebastian
