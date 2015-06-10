From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: CPU stall on 3.12.13-rt21
Date: Wed, 10 Jun 2015 18:33:10 +0200
Message-ID: <20150610163310.GA24273@linutronix.de>
References: <AFDC53D21F2F1F4782A16D848C737357266239EE@srv01mail6.corp.trumpf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Matthias.Buehler@de.trumpf.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52814 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965894AbbFJQdM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Jun 2015 12:33:12 -0400
Content-Disposition: inline
In-Reply-To: <AFDC53D21F2F1F4782A16D848C737357266239EE@srv01mail6.corp.trumpf.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Matthias.Buehler@de.trumpf.com | 2015-05-28 07:55:16 [+0000]:

>Hi,
Hi,

>I am running two real-time processes on a 3.12.13.rt21.
>The first process receives start commands from an external control
>via network and relays these starts to the second process. This second
>process does the actual job and tells the result back to the first.
>This cycle is repeated several times a second.
>
>After some time (half an hour or so) the system stalls. There is no
>network connection available. A parallel running GUI is also frozen.
>
>I tried this scenario with 3.12.40-rt55 and 3.18.13-rt9 with the same
>result.
>
>Running the second process as SCHED_RR does not lead to this situation=
=2E

What do you mean by "second process as SCHED_RR". What was it before?
SCHED_FIFO? Can you tell me the what your realtime applications are and
their priorities? Is any of the applications pinned to a CPU?

>On the serial console I can see the following output:

There is a RCU stall on CPU0. CPU1 looks idle all the time.

>[ 4012.800040]=20
>[ 4012.800040] runnable tasks:
>[ 4012.800040]             task   PID         tree-key  switches  prio=
     exec-runtime         sum-exec        sum-sleep
>[ 4012.800040] -------------------------------------------------------=
---------------------------------------------------
>[ 4012.825647]      ksoftirqd/0     3        -3.000000    655617    98=
        -3.000000      8702.785784         0.000000
>[ 4012.836376]           rcuc/0    15        -3.000000    278716    98=
        -3.000000      5810.323312         0.000000
>[ 4012.847109]  systemd-journal   196   1513493.594716      2449   120=
   1513493.594716       273.461656   2623283.352271
>[ 4012.857844]    VisionLineGui  1622         0.000000   2388301    39=
         0.000000    384277.128155   1916449.569945
>[ 4012.868572]    VisionLineGui  1724   1513493.594716    102610   120=
   1513493.594716      1919.879611   2587477.132774
>[ 4012.879296]           screen  3572   1513493.594716     45227   120=
   1513493.594716      1808.874962    769084.691362
>[ 4012.890018] RVisionLineDaemo  3637         0.000000      4339    39=
         0.000000   1405501.394654         0.000000
>[ 4012.900740]          QThread  4224         0.000000    151421    59=
         0.000000     15053.995468         0.000000

VisionLineDaemo seems to run. VisionLineGui (1622) would also run if it
could, it is likely next in line. Are those in two the tasks to which
you refer that the stall can be avoided by setting a task SCHED_RR?
A task traceback could show what VisionLineDaemo is doing (in case it
stalls RCU and waits for something).

>
>Matthias B=C3=BChler

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
