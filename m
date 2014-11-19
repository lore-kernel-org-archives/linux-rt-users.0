From: Stanislav Meduna <stano@meduna.org>
Subject: Re: Measuring scheduling latency for RT threads
Date: Wed, 19 Nov 2014 14:19:49 +0100
Message-ID: <546C98F5.1020103@meduna.org>
References: <trinity-4b6e4283-c92f-4553-af86-5fb9e1fb1541-1416401016597@3capp-gmx-bs35>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?SsO8cmdlbiBMYW5uZXI=?= <jue.lanner@gmx.at>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:60878 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747AbaKSNT6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Nov 2014 08:19:58 -0500
In-Reply-To: <trinity-4b6e4283-c92f-4553-af86-5fb9e1fb1541-1416401016597@3capp-gmx-bs35>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 19.11.2014 13:43, "J=C3=BCrgen Lanner" wrote:

> My first goal is to find out about the worst case latency:
> Is there a way I can find out how long (worst case) a RT thread
> being ready to run is just waiting to be dispatched? =20

ftrace, trace-cmd, kernelshark

The latency for the highest prio runnable task is available
right away with the wakeup tracer. For other tasks you can
trace the scheduling functions and interpret the results
using a script (or look at them graphically using kernelshark).

Note that the function tracing is not free and will skew
the results a bit, but should be good enough to identify
the offenders.

--=20
                                 Stano

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
