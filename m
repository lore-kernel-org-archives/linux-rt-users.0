From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/2] irq_work: allow certain work in hard irq context
Date: Mon, 03 Feb 2014 09:31:58 +0100
Message-ID: <52EF53FE.8030004@linutronix.de>
References: <1391178845-15837-1-git-send-email-bigeasy@linutronix.de>	 <1391314950.5444.18.camel@marge.simpson.net>	 <52EEA643.1010200@linutronix.de> <1391400037.5357.62.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, tglx@linutronix.de
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1391400037.5357.62.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 02/03/2014 05:00 AM, Mike Galbraith wrote:
> On Sun, 2014-02-02 at 21:10 +0100, Sebastian Andrzej Siewior wrote:
>=20
>> According to the backtrace both of them are trying to access the
>> per-cpu hrtimer (sched_timer) in order to cancel but they seem to fa=
il
>> to get the timer lock here. They shouldn't spin there for minutes, I
>> have no idea why they did so=E2=80=A6
>=20
> Hm. per-cpu...
>=20
> I've been chasing an rt hotplug heisenbug that is pointing to per-cpu
> oddness.  During sched domain re-construction while running Steven's
> stress script on 64 core box, we hit a freshly constructed domain wit=
h
> _no span_, build_sched_groups()->get_group() explodes when we meeting
> it.  But if you try to watch the thing appear... it just doesn't.
>=20
> static int build_sched_domains(const struct cpumask *cpu_map,
>                                struct sched_domain_attr *attr)
> {
>         enum s_alloc alloc_state;
>         struct sched_domain *sd;
>         struct s_data d;
>         int i, ret =3D -ENOMEM;
>=20
>         alloc_state =3D __visit_domain_allocation_hell(&d, cpu_map);
>         if (alloc_state !=3D sa_rootdomain)
>                 goto error;
>=20
>         /* Set up domains for cpus specified by the cpu_map. */
>         for_each_cpu(i, cpu_map) {
>                 struct sched_domain_topology_level *tl;
>=20
>                 sd =3D NULL;
>                 for_each_sd_topology(tl) {
>                         sd =3D build_sched_domain(tl, cpu_map, attr, =
sd, i);
> BUG_ON(sd =3D=3D spanless-alien) here..

spanless-alien is?
BUG_ON() is actually _very_ cheap. It shouldn't even create any kind of
compiler barrier which would reload variables / registers. It should
evaluate sd and "spanless-alien", do the compare and then go on.

>                         if (tl =3D=3D sched_domain_topology)
>                                 *per_cpu_ptr(d.sd, i) =3D sd;
>                         if (tl->flags & SDTL_OVERLAP || sched_feat(FO=
RCE_SD_OVERLAP))
>                                 sd->flags |=3D SD_OVERLAP;
>                         if (cpumask_equal(cpu_map, sched_domain_span(=
sd)))
>                                 break;
>                 }
>         }
>=20
>         /* Build the groups for the domains */
>         for_each_cpu(i, cpu_map) {
>                 for (sd =3D *per_cpu_ptr(d.sd, i); sd; sd =3D sd->par=
ent) {
>                         sd->span_weight =3D cpumask_weight(sched_doma=
in_span(sd));
>                         if (sd->flags & SD_OVERLAP) {
>                                 if (build_overlap_sched_groups(sd, i)=
)
>                                         goto error;
>                         } else {
>                                 if (build_sched_groups(sd, i))
> ..prevents meeting that alien here.. while hotplug locked.

my copy of build_sched_groups() always returns 0 so it never goes to
the error marker. Did you consider a compiler bug? I could try to
rebuild your source + config on two different compilers just to see if
it makes a difference.

Sebastian
