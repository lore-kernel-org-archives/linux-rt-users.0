From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: [ANNOUNCE] 4.0.4-rt1
Date: Wed, 20 May 2015 00:33:54 +0200
Message-ID: <555BBA52.9030809@osadl.org>
References: <20150519213923.GA26363@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:38126 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230AbbESWfA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 May 2015 18:35:00 -0400
In-Reply-To: <20150519213923.GA26363@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian,

> I'm pleased to announce the v4.0.4-rt1 patch set.
First smoke test on an Intel Gulftown 980X: Compiled and booted without 
problem, no regression of real-time capabilities so far.

> [..]
> Known issues:
>        - My AMD box throws a lot of "cpufreq_stat_notifier_trans: No
>          policy found" warnings after boot. It is gone after manually
>          setting the policy (to something else than reported).
Same here, probably a minor issue. The messages disappear after setting 
cpufreq to performance, but they reappear when setting cpufreq back to 
ondemand.

On a side note: We need teach cyclictest 4.0 - right now, it says:
WARN: Running on unknown kernel version...YMMV

Thanks, Sebastian, for the good work!

	-Carsten.
