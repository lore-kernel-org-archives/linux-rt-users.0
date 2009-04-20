From: Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: "RT_PREEMPT for loongson" is updated to patch-2.6.29.1-rt8
Date: Mon, 20 Apr 2009 22:22:03 +0800
Message-ID: <1240237323.8884.42.camel@falcon>
References: <1240193547.25532.52.camel@falcon>
	 <20090420050419.GA22520@adriano.hkcable.com.hk>
	 <1240211926.8884.27.camel@falcon> <20090420080155.GA11621@linux-mips.org>
	 <20090420131022.GA10183@linux-mips.org>
Reply-To: wuzhangjin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zhang Le <r0bertz@gentoo.org>, linux-kernel@vger.kernel.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>, zhangfx@lemote.com,
	loongson-dev@googlegroups.com, yanh@lemote.com,
	linux-mips@linux-mips.org, linux-rt-users@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:39936 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755459AbZDTOWU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Apr 2009 10:22:20 -0400
In-Reply-To: <20090420131022.GA10183@linux-mips.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2009-04-20 at 15:10 +0200, Ralf Baechle wrote:
> On Mon, Apr 20, 2009 at 10:01:55AM +0200, Ralf Baechle wrote:
>=20
> > > I have divided ftrace to several commits in the above git tree, h=
ope you
> > > can check it, thx :-)=20
> > >=20
> > > in addition to the static/dynamic/graph function tracer & system =
call
> > > tracer implementation, a mips specific ring_buffer_time_stamp
> > > (kernel/trace/ring_buffer.c) is also implemented to get 1us preci=
sion
> > > time, this is very important to make ftrace available in mips,
> > > otherwise, we can only get 1ms precision time for the original
> > > ring_buffer_time_stamp is based on sched_clock(jiffies based).=20
> > >=20
> > > perhaps we can implement a more precise sched_clock directly, jus=
t as
> > > x86 does(native_sched_clock, tsc based), but in mips, there is on=
ly a
> > > 32bit timer count which will quickly overflow, so it will need an=
 extra
> > > overflow protection, which may influence the other parts of the k=
ernel.
> >=20
> > My git clone is still running to I'm commenting only on the patches=
 you
> > posted earlier.  #ifdef-MIPS'ing things into the generic kernel cod=
e
> > definately won't be an acceptable way to get =C2=B5s resolution.
>=20

just fix it via moving mips specific ring_buffer_time_stamp to
arch/mips/kernel/ftrace.c via defining the original one as
__attribute__(weak).

in arch/mips/kernel/ftrace.c:=20

u64 native_ring_buffer_time_stamp(...) {
=2E..
}
u64 ring_buffer_time_stamp(...)
__attribute__((alias("native_ring_buffer_time_stamp")));

in kernel/trace/ring_buffer.c:

-u64 ring_buffer_time_stamp(struct ring_buffer *buffer, int cpu)
+ u64 __attribute__((weak)) ring_buffer_time_stamp(struct ring_buffer
*buffer, int cpu)

*** not push to the git tree yet.

> In changeset e67f78d663a84ef93aa12c3c8c1adf3033c4f9a1 you introduce
> <asm/rwsem.h> but because RWSEM_GENERIC_SPINLOCK is always set that f=
ile
> won't ever be included.
>=20

Yes, currently, I'm trying to fix it.

>   Ralf

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
