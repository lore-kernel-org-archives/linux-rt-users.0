From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Timer tick not disabled with NO_HZ_FULL
Date: Wed, 3 Aug 2016 09:40:56 +0200
Message-ID: <20160803074056.GA6741@linutronix.de>
References: <CAC6yHM4kTvXiJwsyFqmi3p_4U8a54wwUJz9QFHAGsO+aM6G6Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Francis Giraldeau <francis.giraldeau@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:60700 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbcHCHlO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 3 Aug 2016 03:41:14 -0400
Content-Disposition: inline
In-Reply-To: <CAC6yHM4kTvXiJwsyFqmi3p_4U8a54wwUJz9QFHAGsO+aM6G6Wg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Francis Giraldeau | 2016-07-29 16:56:15 [-0400]:

>It seems that the timer tick occurs with a PREEMPT_RT kernel even if configured
>with NO_HZ_FULL. On a real-time system where some cores are configured with
correct.

…
>This commit is quite old, maybe a solution exists to the problem of base timer
>locking. Would it be possible for instance to use RCU instead here to support
>NO_HZ_FULL with a PREEMPT_RT kernel?

Unfortunately RCU can't fix everything in its own magical way. But there
is hope! Since v4.6.4-rt8 we have NO_HZ_FULL working thanks to the timer
wheel rework.

>Thanks,
>
>Francis

Sebastian
