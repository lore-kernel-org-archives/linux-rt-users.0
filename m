From: =?UTF-8?Q?=22J=C3=BCrgen_Lanner=22?= <jue.lanner@gmx.at>
Subject: Measuring scheduling latency for RT threads
Date: Wed, 19 Nov 2014 13:43:36 +0100
Message-ID: <trinity-4b6e4283-c92f-4553-af86-5fb9e1fb1541-1416401016597@3capp-gmx-bs35>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:51701 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752578AbaKSMni convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Nov 2014 07:43:38 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I have a complex automation project with makes heavy use of real time p=
rio threads working with external hardware connected by e.g. TCP/IP.
IMHO most of my latencies simply come from the fact that there are mult=
iple threads running on the same RT prio being scheduled FIFO. (poor de=
sign, yes, but that's what I want to fix)
Expected response time is in low millsecond area, so no miroseconds jug=
gling here.
The process is running (alone, no other processes there) on one CPU of =
an i5 quad core (using 3.13.0-35 ubuntu 14.04)
=C2=A0
My first goal is to find out about the worst case latency:
Is there a way I can find out how long (worst case) a RT thread being r=
eady to run is just waiting to be dispatched? =C2=A0
I tried /proc/pid/sched and was looking for se.statistics.wait_max but =
this was always 0.
Going through the kernel sources I found out that these value (among ma=
ny of the neighbors) is not calculated for real time threads (rt.c).
Is there a reason for this?
Is there another, maybe better way how I can achieve my goal?
=C2=A0
My second goal would be to identify the tasks (which ones?) consuming s=
o much time (how much?) in this situation and thus causing the delay.
Is there something built in to track down these bad guys?
I think of something that keeps capturing the PIDs and exec time of all=
 dispatched threads while a thread is waiting.
If it turns out that it runs into worst case latency, the collected dat=
a could give a hint where to dig.
On proc/pid/sched there is se.statistics.exec_max, some thread having a=
 large number there can be a candidate, yes, but that is not necessaril=
y causing my latency.. =C2=A0
But I think more of a bad situation where a lot of tasks need to work a=
t the same time bloating the run queue and thus causing the latency.
I feel my solution is more "intelligent workload distribution" by ident=
ifying not so urgent work and shifting it to a later point in time.
=C2=A0
Thanks in advance
=C2=A0
jue
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
