From: Aaditya Kumar <aaditya.kumar.30@gmail.com>
Subject: Re: [RFC][RT][PATCH] mm: Do not use stop_machine() for
 __zone_pcp_udpate() for CONFIG_PREEMPT_RT_FULL
Date: Mon, 25 Jun 2012 13:30:41 +0530
Message-ID: <CAEtiSatmBC4Xs9bahDn9QZE-2RMD2hxksEn-vCcJRnwxKPPHhA@mail.gmail.com>
References: <CAEtiSauEdKP3Jsi_O6Q=yc9AWkSKDvNrLe0faicQWJGqdKxLwg@mail.gmail.com>
	<CAHGf_=r8Goe6EEC1eS_Azxc1nQcEq4txRMDPGRLVLoyF3xFriA@mail.gmail.com>
	<CAEtiSas-oueW0K0E0Rg52Ym0--iPomEmXeyE+PzHpyHjSdaQwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, mingo@kernel.org, C.Emde@osadl.org,
	jkacur@redhat.com, frank.rowand@am.sony.com, tim.bird@am.sony.com,
	takuzo.ohara@ap.sony.com, kan.iibuchi@jp.sony.com,
	aaditya.kumar@ap.sony.com,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	linux-rt-users@vger.kernel.org
To: KOSAKI Motohiro <kosaki.motohiro@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34803 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab2FYIAn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jun 2012 04:00:43 -0400
In-Reply-To: <CAEtiSas-oueW0K0E0Rg52Ym0--iPomEmXeyE+PzHpyHjSdaQwQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, Jun 24, 2012 at 10:25 PM, Aaditya Kumar
<aaditya.kumar.30@gmail.com> wrote:
> On Sat, Jun 23, 2012 at 9:07 AM, KOSAKI Motohiro
> <kosaki.motohiro@gmail.com> wrote:
>> (6/19/12 2:32 PM), Aaditya Kumar wrote:
>>> The code path of __zone_pcp_update() has following locks, which in
>>> CONFIG_PREEMPT_RT_FULL=3Dy are rt-mutex.
>>> =A0 - pa_lock locked by cpu_lock_irqsave()
>>> =A0 - zone->lock locked by free_pcppages_bulk()
>>>
>>> Since __zone_pcp_update() is called from stop_machine(), so with
>>> CONFIG_PREEMPT_RT_FULL=3Dy
>>> we get following backtrace when __zone_pcp_update() is called durin=
g
>>> memory hot plugging while
>>> doing heavy file I/O.
>>>
>>> I think stop_machine() may not be required for calling __zone_pcp_u=
pdate()
>>> in case of CONFIG_PREEMPT_RT_FULL=3Dy as acquiring pa_lock in __zon=
e_pcp_update()
>>> should be sufficient to isolate pcp pages and to setup per cpu page=
sets.
>>>
>>> Can someone please let me know if am missing anything here?
>>
>
> Hello Kosaki-san,
>
>> First off, you should cc memory hotplug experts when discussing memo=
ry
>> hotplug topic.
>
> Sorry for that.
>
>> Second, stop_machine() is required because usually zone->pageset is
>> per-cpu variable.
>> the regular access rule is, 1) owner cpu can always access their own
>> pcp, 2) offlined cpu's
>> pcp can be accessed from any cpus because is has no race chance 3)
>> otherwise caller must
>> use stop_machine for preventing owner cpu accesses pcp.
>
> Thank you very much for your explanation, yes, my approach was not co=
rrect.

Hello Kosaki-san,

I revisited my first approach of simply calling __zone_pcp_update() dir=
ectly
(without stop_machine() ).

The RT-patch set seems to follow following protocol for accessing per
cpu pageset pages:
(http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/patch-3.4.3-rt1=
2-rc1.patch.xz)
 - Basically each cpu's pcp is protected by a per cpu spin lock.
   (DEFINE_LOCAL_IRQ_LOCK(pa_lock) ).
 - So in brief, to access a particular cpu's pcp we just need to take
the lock on
   the spinlock corresponding to that cpu.
 - cpu_lock_irqsave() in __zone_pcp_update() is locking the cpu's
   pcp spinlock (whose pcp it accesses).

So I feel that my first approach should work, please let me know if I
am missing something.

  --- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3868,7 +3868,11 @@ static int __zone_pcp_update(void *data)

 void zone_pcp_update(struct zone *zone)
 {
+#ifndef CONFIG_PREEMPT_RT_FULL
       stop_machine(__zone_pcp_update, zone, NULL);
+#else
+       __zone_pcp_update(zone);
+#endif
 }


> Since =A0"mm: page_alloc: rt-friendly per-cpu pages" from RT patch se=
t
> introduces a preemptible lock
> (pa_lock which becomes an rt-mutex) for accessing pcp,
> (http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/patch-3.4.3-r=
t12-rc1.patch.xz)
>
> So while calling zone_pcp_update() (with RT-patch set applied and wit=
h
> CONFIG_PREEMPT_RT_FULL=3Dy),
> we have possibly two options to fix the BUG caused by taking a
> sleeping lock in stop_machine.
> =A0Option 1. Revert the patch which introduces the sleeping(pa_lock) =
lock.
> =A0Option 2. Fix the calling frame work.(Use another framework)
>
> Since usually memory hot plug is not that frequent an activity in the=
 system,
> So a little more overhead occurred while taking option 2, I think is =
acceptable.
>
> My approach in my below patch for zone_pcp_update() is:
> 1. For each online cpu, setup pageset of a cpu by scheduling =A0work =
on that cpu.
> 2. For each offline cpu, setup pageset of a cpu from current cpu.
> 3. Flush the all the work spawned in step1.
>
> I will re-send this as a formal patch if there are no objections to
> this approach.
>
>
> ---
> =A0mm/page_alloc.c | =A0 74 =A0 =A0 =A0 =A0 74 + =A0 =A00 - =A0 =A0 0=
 !
> =A01 file changed, 74 insertions(+)
>
> Index: b/mm/page_alloc.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -111,6 +111,16 @@ unsigned long totalreserve_pages __read_
> =A0int percpu_pagelist_fraction;
> =A0gfp_t gfp_allowed_mask __read_mostly =3D GFP_BOOT_MASK;
>
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +struct zone_pcp_work {
> + =A0 =A0 =A0 int cpu;
> + =A0 =A0 =A0 struct zone *zone;
> + =A0 =A0 =A0 struct work_struct work;
> +};
> +
> +static DEFINE_PER_CPU(struct zone_pcp_work, zone_pcp_update_work);
> +#endif
> +
> =A0#ifdef CONFIG_PM_SLEEP
> =A0/*
> =A0* The following functions are used by the suspend/hibernate code t=
o
> temporarily
> @@ -3926,6 +3936,7 @@ int zone_wait_table_init(struct zone *zo
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +#ifndef CONFIG_PREEMPT_RT_FULL
> =A0static int __zone_pcp_update(void *data)
> =A0{
> =A0 =A0 =A0 =A0struct zone *zone =3D data;
> @@ -3949,13 +3960,69 @@ static int __zone_pcp_update(void *data)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +#else
> +
> +static void __zone_cpu_pcp_update(struct work_struct *work)
> +{
> + =A0 =A0 =A0 struct zone_pcp_work *work_data =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 contain=
er_of(work, struct zone_pcp_work, work);
> + =A0 =A0 =A0 struct zone *zone =3D work_data->zone;
> + =A0 =A0 =A0 int cpu =3D work_data->cpu;
> + =A0 =A0 =A0 unsigned long batch =3D zone_batchsize(zone), flags;
> + =A0 =A0 =A0 struct per_cpu_pageset *pset;
> + =A0 =A0 =A0 struct per_cpu_pages *pcp;
> + =A0 =A0 =A0 LIST_HEAD(dst);
> +
> + =A0 =A0 =A0 pset =3D per_cpu_ptr(zone->pageset, cpu);
> + =A0 =A0 =A0 pcp =3D &pset->pcp;
> +
> + =A0 =A0 =A0 cpu_lock_irqsave(cpu, flags);
> + =A0 =A0 =A0 isolate_pcp_pages(pcp->count, pcp, &dst);
> + =A0 =A0 =A0 free_pcppages_bulk(zone, pcp->count, &dst);
> + =A0 =A0 =A0 setup_pageset(pset, batch);
> + =A0 =A0 =A0 cpu_unlock_irqrestore(cpu, flags);
> +
> +}
> +#endif
> +
> =A0void zone_pcp_update(struct zone *zone)
> =A0{
> +
> +#ifdef CONFIG_PREEMPT_RT_FULL
> + =A0 =A0 =A0 int cpu;
> +
> + =A0 =A0 =A0 get_online_cpus();
> + =A0 =A0 =A0 for_each_possible_cpu(cpu) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct zone_pcp_work *zone_pcp_work =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &per_cpu(zone_pcp_update_work, cpu);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 zone_pcp_work->zone =3D zone;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 zone_pcp_work->cpu =3D cpu;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_online(cpu))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule_work_on(cpu, &=
zone_pcp_work->work);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __zone_cpu_pcp_update(&=
zone_pcp_work->work);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for_each_online_cpu(cpu) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct zone_pcp_work *zone_pcp_work =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &per_cpu(zone_pcp_update_work, cpu);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flush_work(&zone_pcp_work->work);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 put_online_cpus();
> +
> +#else
> +
> =A0 =A0 =A0 =A0stop_machine(__zone_pcp_update, zone, NULL);
> +#endif
> =A0}
>
> =A0static __meminit void zone_pcp_init(struct zone *zone)
> =A0{
> +#ifdef CONFIG_PREEMPT_RT_FULL
> + =A0 =A0 =A0 int cpu;
> +#endif
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * per cpu subsystem is not up at this point. The foll=
owing code
> =A0 =A0 =A0 =A0 * relies on the ability of the linker to provide the
> @@ -3967,6 +4034,13 @@ static __meminit void zone_pcp_init(stru
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_DEBUG " =A0%s zone: %lu pa=
ges, LIFO batch:%u\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0zone->name, zone->pres=
ent_pages,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 zone_batchsize(zone));
> +#ifdef CONFIG_PREEMPT_RT_FULL
> + =A0 =A0 =A0 for_each_possible_cpu(cpu) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct zone_pcp_work *zone_pcp_work =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &per_cpu(zone_pcp_update_work, cpu);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_WORK(&zone_pcp_work->work, __zone_=
cpu_pcp_update);
> + =A0 =A0 =A0 }
> +#endif
> =A0}
>
> =A0__meminit int init_currently_empty_zone(struct zone *zone,
>
>
>
>
>
>>
>> stop_machine and send ipi are common technique for per-cpu area hack=
=2E
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
