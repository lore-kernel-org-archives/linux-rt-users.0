From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: Latest PreemptRT patch error on imx35
Date: Mon, 31 Aug 2009 13:48:23 +0200
Message-ID: <4A9BB887.1040407@osadl.org>
References: <200908311143.08952.tim01@vlsi.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:42942 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753AbZHaMnZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Aug 2009 08:43:25 -0400
In-Reply-To: <200908311143.08952.tim01@vlsi.informatik.tu-darmstadt.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Tim,

> I just bootet 2.6.31-rc8-rt9 on the phycore-imx35 development board,=20
> without any additional patches. The FEC Ethernet Controller went bell=
y=20
> up, but the system booted nevertheless. I tried cyclictest:
> root@pmx:~ cyclictest -t1 -p 80 -n -i 10000 -l 10000
As a role of thumb, the -i option is normally set to twice the expected
latency. If, for example you expect 100 us, set it to -i200. Your loop
end is then reached 50 times faster, or - what is much better - you may
specify 50 times more loops for a test of the same duration which
considerably increases the quality of your assessment. Normally,
however, you would probably wait for 100 million or even a billion loop=
s.

> 0.05 0.10 0.05 1/39 570
> T: 0 (  570) P:80 I:10000 C:  10000 Min:     14 Act:   20 Avg:   19 M=
ax:      27
> These  are Numbers from an Idle Machine (no network), but they look r=
eally good.
With an average of 19 and a maximum of 27, the result is probably not
very relevant. This indicates that the CPU was idle most of the time
when the wakeup occurred - every OS can do this. The challenge of an
RTOS is to wakeup in time also when the kernel is not idle, e.g. from
kernel or driver code while a lock is held. Therefore, adequate stress
tools must be running during a latency measurement.

> They are much better than my last tests on the imx31 with an older pr=
eemptrt-kernel=20
> (2.6.29) which had idle latencys up to 80=B5s.=20
> Given the fact, that ftrace is enabled, this is really impressive pro=
gress!
Please keep in mind that ftrace configured is not ftrace enabled. To
enable it, use cyclictest's -f option or execute
  echo function >/sys/kernel/debug/tracing/current_tracer
  echo 1 >/sys/kernel/debug/tracing/tracing_enabled
from command line.


I hope that this hasn't tempered your joy with your new hardware.

	Carsten.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
