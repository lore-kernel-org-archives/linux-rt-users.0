From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: Re: [Question] Hooks for scheduler tracing (CFS)
Date: Mon, 16 Jul 2007 16:07:00 -0400
Message-ID: <20070716200700.GA1119@Krystal>
References: <3efb10970707161246se06ab22i32872cfe6fa4f2f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT-Users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: linux@bohmer.net, Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762935AbXGPUHi@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3efb10970707161246se06ab22i32872cfe6fa4f2f6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Remy Bohmer (l.pinguin@gmail.com) wrote:
> Hello,
>=20
> I am looking for some tool/kernel machanism that enables me to track
> every schedule change on the CFS scheduler of the RT-kernel for some
> period of time.
> Thus a tool that gives me an overview after some time which task got
> "scheduled in/out" at "which timestamp" and at "which CPU". ( I need
> the raw data)
>=20
> In a far past (on Montavista kernels) I used LTT for this to log for
> some time with only the SCHED_CHANGE filter and text output. But, I
> cannot find any LTT(ng) support for any RT-kernel, and support for th=
e
> new CFS (like in 2.6.22.1-rt4) is even harder.
>=20
> So I was wondering if anybody knows some tool/kernel mechanism which
> can do this?
> If not, I will build a kernel extension for it myself (new extension
> to 'latency_trace' ?)
> In that case can anybody with in depth CFS scheduler knowledge please
> point me which hooks are safe to use for this?
>=20
> I need it to get a detailed insight in my RT-system with its RT and
> non-RT applications.
> Thus to know when a certain task gets scheduled (and to calculate its
> per thread min/max/avg latencies), which task preempts another task,
> and to get a complete overview of what the RT system (and scheduler)
> is doing during time etc.
>=20

Hi Remy,

I think Thomas may have worked on a port of recent LTTng to the -RT
kernel.

If not, I think you needs are quite easy to fulfill with a small amount
of work.

Basically, you could take a recent copy of LTTng, which comes in a set
of logically separated patches:

http://ltt.polymtl.ca/lttng/patch-2.6.22-rc4-mm2-lttng-0.9.10.tar.bz2

=46ollow the Compatibility List to see which other packages you need
(ltt-control and lttv) :
http://ltt.polymtl.ca/svn/ltt/branches/poly/doc/developer/lttng-lttv-co=
mpatibility.html

Then, when applying the LTTng patches to the -RT kernel, a few things
must be taken care of:

1 - "instrumentation" patches : you won't care about most of the
rejects, since you only care about the schedule() calls.

2 - You'll have to see how schedule() is instrumented and port that to
the CFS.

3 - Make sure the Linux Kernel Markers (linux/marker.h) _really_ call
preempt_disable()/preempt_enable() (is it a underscored function in
-rt ?).=A0It is used for correct teardown of probe handlers with
synchronize_sched(). Probe sites execute very quickly, do it won't add
significant latency to your system.

4 - Ping me for problematic rejects.

Mathieu

>=20
> Kind Regards,
>=20
> Remy B=F6hmer
>=20

--=20
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE =
9A68
