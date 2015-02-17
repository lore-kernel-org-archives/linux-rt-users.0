From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: kernel BUG at /build/linux-rt/kernel/locking/rtmutex.c:997!
Date: Tue, 17 Feb 2015 15:13:33 +0100
Message-ID: <20150217141333.GR26177@linutronix.de>
References: <CADLDEKuPf3UNf-CB_xpmjcmQxQA_drFkXzBMQYUF_7K0dM7V3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Juerg Haefliger <juergh@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43877 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756534AbbBQONf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 09:13:35 -0500
Content-Disposition: inline
In-Reply-To: <CADLDEKuPf3UNf-CB_xpmjcmQxQA_drFkXzBMQYUF_7K0dM7V3w@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Juerg Haefliger | 2014-12-02 12:09:47 [+0100]:

>I have a simple test that runs two iperf clients in parallel with the
>ltp network tests and it triggers a deadlock within a few minutes.
>This is 100% repeatable. I've tried this on different RT kernels and
>determined that prior to the following commit (which went into 3.10
>upstream), the machine doesn't deadlock and seems to run just fine:
>
>fb52f40e085ef4074f1335672cd62c1f832af13b rtmutex: Handle deadlock
>detection smarter

has this been resolved in the meantime? Do you see the same problem with
v3.18-RT?

Sebastian
