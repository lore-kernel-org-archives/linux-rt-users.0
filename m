From: Simon Falsig <simon@newtec.dk>
Subject: SV: Configuration of real-time tasks in PREEMPT_RT kernels > 2.6.33
Date: Tue, 27 Aug 2013 08:17:15 +0200
Message-ID: <34eaa2e2f9bbbbd9d32b88b66f8d16e8@mail.gmail.com>
References: <OF6C5E1E92.67FE0167-ONC1257BD3.0043D8B2-C1257BD3.00448947@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Wolfgang Wallner <Wolfgang.Wallner@br-automation.com>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:45736 "HELO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752358Ab3H0GRS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Aug 2013 02:17:18 -0400
Received: by mail-lb0-f179.google.com with SMTP id v1so3180245lbd.10
        for <linux-rt-users@vger.kernel.org>; Mon, 26 Aug 2013 23:17:15 -0700 (PDT)
In-Reply-To: <OF6C5E1E92.67FE0167-ONC1257BD3.0043D8B2-C1257BD3.00448947@br-automation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

-----Oprindelig meddelelse-----
=46ra: linux-rt-users-owner@vger.kernel.org
[mailto:linux-rt-users-owner@vger.kernel.org] P=E5 vegne af Wolfgang Wa=
llner
Sendt: 26. august 2013 14:29
Til: linux-rt-users@vger.kernel.org
Emne: Configuration of real-time tasks in PREEMPT_RT kernels > 2.6.33
>
>Dear RT community,
>
>I have a question regarding the configuration of real-time tasks in
PREEMPT _RT kernels > 2.6.33.
>Up to now, I only have experience with 2.6.33-rt.
>
>I use the openPOWERLINK[1] real-time ethernet stack, and have it runni=
ng
on an x86-box with Ubuntu 13.04.
>I try to use it with two different kernel versions:
>* 2.6.33.7.2-rt30
>* 3.2.48-rt69
>
>When I use kernel version 2.6.33, I get very good results (jitter of
ethernet frames on the network < +/-10us).
>But when I use kernel version 3.2, the results are much worse. The jit=
ter
on the network increases up to +/-50us.
>
>In my configuration, the openPOWERLINK stack consists of a kernel modu=
le
(data link layer) and a user space application.
>
>I know that in 2.6.33 there were splitted softirqs, and that it was
possible to configure each thread with its own priority.
>What are the steps that need to be done in 3.x to achieve similar resu=
lts
as in 2.6.33?
>
>kind regards,
>Wolfgang Wallner
>
>[1] http://sourceforge.net/projects/openpowerlink/
>
>PS: Running cyclictest (e.g. sudo cyclictest -p 99 -n -i 500) on both
kernels shows very similar results (avg latency: 15us, max latency 35us=
).

Hi Wolfgang,

=46rom the openPOWERLINK documentation (linux-x86.txt):

Kernel 3.x
   The behaviour of a 3.X real-time kernel changed. Splitted softirq
threads
   are no longer available. To get a good real-time behaviour the
following
   steps have to be made:
   1. A multicore processor is required for these optimizations!
   2. Ensure that the following configuration options are set for your
      real-time kernel:
      CONFIG_RT_GROUP_SCHED is not set
      CONFIG_RCU_BOOST=3Dy
      CONFIG_RCU_BOOST_PRIO=3D99
   3. Isolate the second core of the multi-core processor to be used
      exclusively for openPOWERLINK by specifying the kernel-commandlin=
e
parameter
      isolcpus=3D1
   4. Set the default interrupt affinity to all other cores, e.g. for a
      dual-core system to core 0 by setting the kernel-commandline
parameter
      irqaffinity=3D0
   5. Disable IRQ balancing by disable irqbalance. This depends on your
      Linux distribution. For example in Ubuntu edit
/etc/default/irqbalance

So to get similar performance on 3.x, it seems that you'll need to assi=
gn
a core solely for the openPOWERLINK stack. I've wondered a bit about
whether there might be a different solution myself, but hadn't had the
time to investigate much further.

Best regards,
Simon Falsig
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
