From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PATCH 1/2] irq_work: allow certain work in hard irq context
Date: Mon, 03 Feb 2014 05:00:37 +0100
Message-ID: <1391400037.5357.62.camel@marge.simpson.net>
References: <1391178845-15837-1-git-send-email-bigeasy@linutronix.de>
	 <1391314950.5444.18.camel@marge.simpson.net>
	 <52EEA643.1010200@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, tglx@linutronix.de
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64331 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbaBCEAl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 2 Feb 2014 23:00:41 -0500
In-Reply-To: <52EEA643.1010200@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 2014-02-02 at 21:10 +0100, Sebastian Andrzej Siewior wrote:

> According to the backtrace both of them are trying to access the
> per-cpu hrtimer (sched_timer) in order to cancel but they seem to fai=
l
> to get the timer lock here. They shouldn't spin there for minutes, I
> have no idea why they did so=E2=80=A6

Hm. per-cpu...

I've been chasing an rt hotplug heisenbug that is pointing to per-cpu
oddness.  During sched domain re-construction while running Steven's
stress script on 64 core box, we hit a freshly constructed domain with
_no span_, build_sched_groups()->get_group() explodes when we meeting
it.  But if you try to watch the thing appear... it just doesn't.

static int build_sched_domains(const struct cpumask *cpu_map,
                               struct sched_domain_attr *attr)
{
        enum s_alloc alloc_state;
        struct sched_domain *sd;
        struct s_data d;
        int i, ret =3D -ENOMEM;

        alloc_state =3D __visit_domain_allocation_hell(&d, cpu_map);
        if (alloc_state !=3D sa_rootdomain)
                goto error;

        /* Set up domains for cpus specified by the cpu_map. */
        for_each_cpu(i, cpu_map) {
                struct sched_domain_topology_level *tl;

                sd =3D NULL;
                for_each_sd_topology(tl) {
                        sd =3D build_sched_domain(tl, cpu_map, attr, sd=
, i);
BUG_ON(sd =3D=3D spanless-alien) here..
                        if (tl =3D=3D sched_domain_topology)
                                *per_cpu_ptr(d.sd, i) =3D sd;
                        if (tl->flags & SDTL_OVERLAP || sched_feat(FORC=
E_SD_OVERLAP))
                                sd->flags |=3D SD_OVERLAP;
                        if (cpumask_equal(cpu_map, sched_domain_span(sd=
)))
                                break;
                }
        }

        /* Build the groups for the domains */
        for_each_cpu(i, cpu_map) {
                for (sd =3D *per_cpu_ptr(d.sd, i); sd; sd =3D sd->paren=
t) {
                        sd->span_weight =3D cpumask_weight(sched_domain=
_span(sd));
                        if (sd->flags & SD_OVERLAP) {
                                if (build_overlap_sched_groups(sd, i))
                                        goto error;
                        } else {
                                if (build_sched_groups(sd, i))
=2E.prevents meeting that alien here.. while hotplug locked.

static int get_group(int cpu, struct sd_data *sdd, struct sched_group *=
*sg)
{
        struct sched_domain *sd =3D *per_cpu_ptr(sdd->sd, cpu);
        struct sched_domain *child =3D sd->child;
        if (child)
                cpu =3D cpumask_first(sched_domain_span(child));
                ^^^nr_cpus
        if (sg) {
                *sg =3D *per_cpu_ptr(sdd->sg, cpu); BOOM


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
