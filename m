From: Jain Priyanka-B32167 <B32167@freescale.com>
Subject: RE: System freeze while sending data via tcp with 3.6.11-rt30 kernel
Date: Mon, 18 Mar 2013 07:15:17 +0000
Message-ID: <AC83832D6324604BB08FAE5A33553F190B2F3D43@039-SN2MPN1-012.039d.mgd.msft.net>
References: <CAKQvxgXUDJ=o-dvoGg+cVJpNHw_yCBL+0BTv_QZqPv7QZ7WNUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Heiko Schumann <heiko.sirona@gmail.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-db8lp0189.outbound.messaging.microsoft.com ([213.199.154.189]:33619
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751255Ab3CRHa3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Mar 2013 03:30:29 -0400
In-Reply-To: <CAKQvxgXUDJ=o-dvoGg+cVJpNHw_yCBL+0BTv_QZqPv7QZ7WNUg@mail.gmail.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,


Linux network stack use softirqs for TX-RX actions. In PREEMPT_RT kerne=
l, these softirqs run as RT threads at priority 50.
Heavy traffic like ~840Mbps on 2-core machine like P2020 will throttle =
the system.
As scheduler picks the tasks as per priority, the application with SCHE=
D_OTHER policy (non-RT task) will never get a chance to run except in "=
rt_period - rt_runtime " zone specially reserved for non-rt tasks which=
 is very small.

One need to tune various scheduling parameters of various threads runni=
ng on such a system.

We have encountered a similar issue while working on one of networking =
chip while running heavy traffic.  The below article will be useful for=
 you for such kind of problems.
http://www.techonline.com/electrical-engineers/education-training/tech-=
papers/4402454/Challenges-in-Using-Linux-for-CPU-intensive-real-time-ne=
tworking-products


Regards
Priyanka

> -----Original Message-----
> From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-
> owner@vger.kernel.org] On Behalf Of Heiko Schumann
> Sent: Friday, March 15, 2013 4:42 PM
> To: linux-rt-users@vger.kernel.org
> Subject: System freeze while sending data via tcp with 3.6.11-rt30 ke=
rnel
>=20
> Hi,
>=20
> i=B4ve a 3.6.11-rt30 kernel on a QorIQ P2020 Processor.
> Everything works fine, but when i start my application, which sends
> data via tcp socket with a rate of ~840 Mbits to an another computer,
> the QorIQ P2020 freezes within three minutes.
> The application is started with SCHED_OTHER scheduling algorithm the
> standard priority. The system freeze occurs until i start the
> application with the SCHED_FIFO algorithm and a priority higher then
> 50. With this option everything runs stable, but this option
> isn=B4t suitable for the later system.
>=20
> I tried this with the 3.6.11-rt25 kernel too and it had the same prob=
lem.
> With a 3.6.11-rt25 kernel and the "Basic RT" as Preemption Model
> instead of "RT" option in kernel options the freeze doesn=B4t occur,
> while running the application with SCHED_OTHER and no priority.
>=20
> This are the settings of the 3.6.11-rt30 kernel. Maybe are there
> errors i don=B4t see.
>=20
> Thanks for any help with this problem
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
