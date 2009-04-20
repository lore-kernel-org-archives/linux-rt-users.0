From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: "RT_PREEMPT for loongson" is updated to patch-2.6.29.1-rt8
Date: Mon, 20 Apr 2009 10:01:55 +0200
Message-ID: <20090420080155.GA11621@linux-mips.org>
References: <1240193547.25532.52.camel@falcon> <20090420050419.GA22520@adriano.hkcable.com.hk> <1240211926.8884.27.camel@falcon>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zhang Le <r0bertz@gentoo.org>, linux-kernel@vger.kernel.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>, zhangfx@lemote.com,
	loongson-dev@googlegroups.com, yanh@lemote.com,
	linux-mips@linux-mips.org, linux-rt-users@vger.kernel.org
To: Wu Zhangjin <wuzhangjin@gmail.com>
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <1240211926.8884.27.camel@falcon>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Apr 20, 2009 at 03:18:46PM +0800, Wu Zhangjin wrote:

> On Mon, 2009-04-20 at 13:04 +0800, Zhang Le wrote:

> to Ralf,=20
>=20
> I have divided ftrace to several commits in the above git tree, hope =
you
> can check it, thx :-)=20
>=20
> in addition to the static/dynamic/graph function tracer & system call
> tracer implementation, a mips specific ring_buffer_time_stamp
> (kernel/trace/ring_buffer.c) is also implemented to get 1us precision
> time, this is very important to make ftrace available in mips,
> otherwise, we can only get 1ms precision time for the original
> ring_buffer_time_stamp is based on sched_clock(jiffies based).=20
>=20
> perhaps we can implement a more precise sched_clock directly, just as
> x86 does(native_sched_clock, tsc based), but in mips, there is only a
> 32bit timer count which will quickly overflow, so it will need an ext=
ra
> overflow protection, which may influence the other parts of the kerne=
l.

My git clone is still running to I'm commenting only on the patches you
posted earlier.  #ifdef-MIPS'ing things into the generic kernel code
definately won't be an acceptable way to get =B5s resolution.

  Ralf
