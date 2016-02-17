From: Tim Sander <tim@krieglstein.org>
Subject: Bisect results for 4.4.1-rt[4,5]
Date: Wed, 17 Feb 2016 09:14:27 +0100
Message-ID: <6333508.b5IKNpgbEX@dabox>
References: <20150816135630.GE7004@linutronix.de> <1614199.PesBpXyHut@dabox> <56BDA0EF.7090503@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56BDA0EF.7090503@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Sebastian

Am Freitag, 12. Februar 2016, 10:07:59 schrieben Sie:
=2E..
> What about rt4? It is only the stable update so you should see here t=
he
> numbers from rt3. If that is true and your numbers are stable it shou=
ld
> be easy to run git bisect between rt4 and rt5. And looking at
>   https://git.kernel.org/rt/linux-rt-devel/h/v4.4.1-rt5
> the only non-cosmetic change in -rt5 that should affect you is the
> migrate-disable fixup from Mike.
I have done a bisect run, its a rather innocent looking on liner which =
seems=20
to cause the problems. The numbers where reasonably stable so i am pret=
ty=20
confident that this is the patch giving ~26=B5s additional latency on t=
he Altera
SOC plattform:

eec2bf477ac674583a7d73b9d00f47c528b7266d is the first bad commit
commit eec2bf477ac674583a7d73b9d00f47c528b7266d
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Thu Feb 4 16:38:10 2016 +0100

    kernel/perf: mark perf_cpu_context's timer as irqsafe
   =20
    Otherwise we get a WARN_ON() backtrace and some events are reported=
 as
    "not counted".
   =20
    Cc: stable-rt@vger.kernel.org
    Reported-by: Yang Shi <yang.shi@linaro.org>
    Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Here are the numbers of the bisect run for reference:
=3D=3D> g0dd3bdd <=3D=3D
# Total: 100000000 099999829
# Min Latencies: 00010 00010
# Avg Latencies: 00020 00021
# Max Latencies: 00084 00101
# Histogram Overflows: 00000 00000

=3D=3D> gbbc7819 <=3D=3D
# Total: 100000000 099999798
# Min Latencies: 00010 00010
# Avg Latencies: 00021 00021
# Max Latencies: 00086 00091
# Histogram Overflows: 00000 00000

=3D=3D> geec2bf4 <=3D=3D
# Total: 099998713 100000000
# Min Latencies: 00010 00010
# Avg Latencies: 00020 00021
# Max Latencies: 00113 00070
# Histogram Overflows: 00000 00000

Best Regards
Tim
