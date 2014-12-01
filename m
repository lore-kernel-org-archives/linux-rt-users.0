From: =?UTF-8?Q?=22J=C3=BCrgen_Lanner=22?= <jue.lanner@gmx.at>
Subject: problem using trace-cmd and trace_marker when using only one core
Date: Mon, 1 Dec 2014 14:22:46 +0100
Message-ID: <trinity-fa84f03b-d353-462e-aae6-5a5e481afcec-1417440165730@3capp-gmx-bs11>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:59376 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbaLANWs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Dec 2014 08:22:48 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Ladies and gentlemen,

I found some odd behaviour when using trace-cmd together with trace_marker.

I try to use trace-cmd to trace scheduling events to find out latencies on my box.
    trace-cmd record -e 'sched_wakeup*' -e sched_switch

In oder to synchronize the trace I use echoing to /sys/kernel/debug/tracing/trace_marker
    echo Hallo > /sys/kernel/debug/tracing/trace_marker


This works fine so far.

My task in observation is set to run only on one core (on a quad core cpu) 
so I tried to narrow down the focus of tracing (and the data amount) using the -M option:
    trace-cmd record -M 2 -e 'sched_wakeup*' -e sched_switch

But from this point on I am no longer able to write to the trace_marker, instead I get this response:
    bash: echo: write error: Bad file descriptor

Only reboot solves the problem.

Is this some known or even intended behaviour? Or do I use it in some weird way as described?
Maybe I understood something wrong and you can give me a hint how to overcome the obstacle.

Thanks a lot

Juergen
