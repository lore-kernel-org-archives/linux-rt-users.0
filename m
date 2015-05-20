From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 4.0.4-rt1
Date: Wed, 20 May 2015 09:12:53 +0200
Message-ID: <555C33F5.5070208@linutronix.de>
References: <20150519213923.GA26363@linutronix.de> <555BBA52.9030809@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Carsten Emde <C.Emde@osadl.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58861 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbbETHM6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 May 2015 03:12:58 -0400
In-Reply-To: <555BBA52.9030809@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/20/2015 12:33 AM, Carsten Emde wrote:
> Hi Sebastian,

Hi Carsten,

>> Known issues:
>>        - My AMD box throws a lot of "cpufreq_stat_notifier_trans: No
>>          policy found" warnings after boot. It is gone after manuall=
y
>>          setting the policy (to something else than reported).
> Same here, probably a minor issue. The messages disappear after setti=
ng
> cpufreq to performance, but they reappear when setting cpufreq back t=
o
> ondemand.

Okay. Didn't try to set it back but yes, the messages gets back here,
too.

> On a side note: We need teach cyclictest 4.0 - right now, it says:
> WARN: Running on unknown kernel version...YMMV

Ah. Just posted a patch. I had in my rt-tests repo and forgot about it=E2=
=80=A6

> Thanks, Sebastian, for the good work!

Thank you.

>=20
>     -Carsten.
Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
