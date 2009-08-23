From: raz ben yehuda <raziebe@gmail.com>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Sun, 23 Aug 2009 12:09:11 +0300
Message-ID: <1251018551.3810.35.camel@raz>
References: <1250983671.5688.21.camel@raz>
	 <1251004897.7043.70.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: riel@redhat.com, mingo@elte.hu, peterz@infradead.org,
	andrew motron <akpm@osdl.org>, wiseman@macs.biu.ac.il,
	lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750846AbZHWGJJ@vger.kernel.org>
In-Reply-To: <1251004897.7043.70.camel@marge.simson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 2009-08-23 at 07:21 +0200, Mike Galbraith wrote:
> On Sun, 2009-08-23 at 02:27 +0300, raz ben yehuda wrote:
> > 			The Open University of Israel
> > 		  Department of Mathematics and computer science=09
> > 		=09
> > 		  	 	FINAL PAPER
> > 			     OFFLINE  SCHEDULER
> >=20
> >=20
> >=20
> > OFFSCHED is a platform aimed to assign an assignment to an offloade=
d processor.An offloaded processor is a processor that is hot un-plugge=
d from the operating system.
> >=20
> > Description
> >=20
> > In today=E2=80=99s computer world, we find that most processors hav=
e several embedded cores and hyper-threading. Most programmers do not r=
eally use these powerful features and let the operating system do the w=
ork.
> > At most, a programmer will bound an application to a certain proces=
sor or assign an interrupt to a different processor. At the end, we get=
 system busy in maintaining tasks across processors, balancing interrup=
ts, flushing TLBs and DTLBs using atomic operations even when not neede=
d and worst of all, spin locks across processors in vein; and the more =
processors the merrier. I argue that in some cases, part of this behavi=
or is due to fact the multiple core operating system is not service ori=
ented but a system oriented. There is no easy way to assign a processor=
 to do a distinct service, undisturbed, accurate, and fast as long as t=
he processor is an active part of an operating system and still be a pa=
rt of most of the operating system address space.
> >=20
> > OFFSCHED Purpose
> >=20
> > The purpose of the OFFSCHED is to create a platform for services. F=
or example, assume a firewall is being attacked; the Linux operating sy=
stem will generate endless number of interrupts and/or softirqs to anal=
yze the traffic and throw out bad packets. This is on the expense of =E2=
=80=9Cgood=E2=80=9D packets. Have you ever tried to =E2=80=9Cssh=E2=80=9D=
 to an attacked machine? Who protects the operating system ?
> > What if we can simply do the packet analysis outside the operating =
system, without being interrupted ?
> > Why not assign a core to do only =E2=80=9Cfirewalling=E2=80=9D? Or =
just routing? Design a new type of Real Time system? Maybe assign it as=
 an ultra accurate timer? Create a delaying service that does not just =
spin? Offload a TCP stack? perhaps a new type of a locking scheme? New =
type bottom-halves? Debug a running kernel through an offloaded process=
or? Maybe assign a GPU to do other things than just graphics?
> > Amdahl Law teaches us that linear speed-up is not very feasible , s=
o why not spare a processor to do certain tasks better?
> > Technologically speaking, I am referring to the Linux kernel abilit=
y to virtually hot unplug a (SMT) processor ;but instead of letting it =
wonder in endless =E2=80=9Chalts=E2=80=9D, assign it a service.
>=20
> Seems to me this boils down to a different way to make a SW box in a =
HW
> box, which already exists.  What does this provide that  partitioning=
 a
> box with csets and virtualization doesn't?
OFFSCHED does not compete with cpu sets nor virtualization.it is
different.

1. Neither virtuallization nor cpu sets provide hard real time. OFFSCHE=
D
does this with a little cost and no impact on the OS.OFFSCHED is not
just accurate , it is also extremely fast,after all, it is NMI'ed
processor.

2. OFFSCHED has a access to every piece of memory in the system. so it
can act as a centry for the system, or use linux facilities. Also, the
kernel can access OFFSCHED memory, it is the same address space.

3. OFFSCHED can improve the linux OS ( NAPI,OFFSCHED firewall,RTOP ),
while a guest OS cannot.

4. cpu sets cannot replace softirqs and hardirqs. OFFSCHED can. cpu set=
s
deals with kernel threads and user space threads. in OFFSCHED we use
offlets.=20

5. cpu sets and  virtualization are services provided by the kernel to
the "system".who serves the kernel ? who protects the kernel ?=20

6. offlets gives the programmer full control over an entire processor.
no preemption, no interrupts, no quiesce. you know what happens , and
when it happens.

I have this hard real time system several years on my SMP/MC/SMT
machines. It serves me well. The core of OFFSCHED patch was 4 lines.
So,i simply compile a ***entirely regular*** linux bzImage and that's
it. It did not mess with drivers, spinlocks, softirqs ..., OFFSCHED jus=
t
directed the cpu_down to my own hard real time piece of code. The rest
of the kernel remained the same. =20

> 	-Mike
>=20
