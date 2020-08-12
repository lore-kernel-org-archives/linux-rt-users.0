Return-Path: <SRS0=Foxt=BW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB764C433DF
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Aug 2020 12:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B202E204FD
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Aug 2020 12:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=omicronenergy.com header.i=@omicronenergy.com header.b="PTaPEzxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgHLM6I (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:58:08 -0400
Received: from ns.omicron.at ([212.183.10.25]:35464 "EHLO ns.omicron.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbgHLM6H (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Aug 2020 08:58:07 -0400
X-Greylist: delayed 746 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Aug 2020 08:58:05 EDT
Received: from MGW02-ATKLA.omicron.at ([172.25.62.35])
        by ns.omicron.at (8.15.2/8.15.2) with ESMTPS id 07CCjbiO001972
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Aug 2020 14:45:37 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 ns.omicron.at 07CCjbiO001972
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omicronenergy.com;
        s=default; t=1597236338;
        bh=gTDzMPzqbhTVnvgvJgLCH+Lh7+XChOpn9UYNBDP8hFU=;
        h=Subject:From:To:CC:Date:In-Reply-To:References:From;
        b=PTaPEzxoeCAmuZ8zBYCrdEofuGMPWbr5po2ZsRojK5v4Q8Gs591pPteAh3h9jESR0
         1pJWqP7au0P7gedPiy9Zt4S88mr0O6mqVnRqwZZLKQ5XRf2yEPuagnkqWjpiMlrn/K
         DX6aOOSXbQwkTdqAktHgEQ7Z8Cnm4B8I9KocgQ+w=
Received: from MGW02-ATKLA.omicron.at (localhost [127.0.0.1])
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTP id BD644A0077;
        Wed, 12 Aug 2020 14:45:36 +0200 (CEST)
Received: from MGW01-ATKLA.omicron.at (unknown [172.25.62.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTPS id B7803A0053;
        Wed, 12 Aug 2020 14:45:36 +0200 (CEST)
Received: from EXC03-ATKLA.omicron.at ([172.22.100.188])
        by MGW01-ATKLA.omicron.at  with ESMTP id 07CCjbHi028720-07CCjbHk028720
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=CAFAIL);
        Wed, 12 Aug 2020 14:45:37 +0200
Received: from thogra12.omicron.at (172.22.33.211) by EXC03-ATKLA.omicron.at
 (172.22.100.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 12 Aug
 2020 14:45:30 +0200
Subject: Re: Kernel crash due to memory corruption with v5.4.26-rt17 and
 PowerPC e500
From:   Thomas Graziadei <thomas.graziadei@omicronenergy.com>
To:     "'Sebastian Andrzej Siewior'" <bigeasy@linutronix.de>,
        Mark Marshall <markmarshall14@gmail.com>
CC:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Mark Marshall <mark.marshall@omicronenergy.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Date:   Wed, 12 Aug 2020 14:45:22 +0200
In-Reply-To: <eeeae7d9-c028-47f0-ab5b-7983e32f36cb@EXC03-ATKLA.omicron.at>
References: <CAD4b4WK9W+dNZZ_WPt-9ZNpSHvyxdwPW86Rtq4AKOONuvyR37A@mail.gmail.com>
         <20200529131452.pgj7mx7xaz7n4kz3@linutronix.de>
         <CAD4b4WLS36JKepz31m98Z3Ve05d63GnfBGsuuWRXpjXZqPoBrA@mail.gmail.com>
         <20200529161518.svpxhkeljafbtdz2@linutronix.de>
         <20200529163722.mdxzrj4n3lyzjtfu@linutronix.de>
         <20200706165004.7m57fvspmwnjcjxh@linutronix.de>
         <eeeae7d9-c028-47f0-ab5b-7983e32f36cb@EXC03-ATKLA.omicron.at>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-Originating-IP: [172.22.33.211]
X-ClientProxiedBy: EXC03-ATKLA.omicron.at (172.22.100.188) To
 EXC03-ATKLA.omicron.at (172.22.100.188)
Message-ID: <c1ef757b-4cd6-410e-a647-a3303cef4b1b@EXC03-ATKLA.omicron.at>
X-FE-Policy-ID: 1:1:1:SYSTEM
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

any progress on your side?

Do you think the patch could be applied for the next versions?

Regards,
Thomas

On Fri, 2020-07-10 at 10:59 +0000, Thomas Graziadei wrote:
> Hi Sebastian,
>=20
> thanks for looking into this.
>=20
> We could reproduce the issue with QEMU.
> At runtime you need to set mdev as the kernel's hotplug client
> (/proc/sys/kernel/hotplug) and give it a dummy /etc/mdev.conf like
> (.* 1:1 777). Then just do a loop and insmod/rmmod crc4.ko and
> crc7.ko.
>=20
> Swapping the mm assignment did not work -> exception after 1900
> iterations
> Your second suggestion with check.patch (attached to this email for
> completeness, only protecting the exec_mmap function) did not work
> eighter -> exception after 2600 iterations
>=20
> Your third suggestion (a modification to the original revert)
> enclosed in this e-mail does seem to work. Still no problems after
> 30000 iterations.
>=20
> By the way, as noticed in your kernel config, we would be quite
> interested in a gcc 9 compiler for our platform. Is there a
> mainline/maintained version or fork for this or another possibility
> to get it?
> =20
> Regards,
> Thomas
>=20
> -----Original Message-----
> From: Sebastian Andrzej Siewior [mailto:bigeasy@linutronix.de]=20
> Sent: Monday, July 06, 2020 6:50 PM
> To: Mark Marshall <markmarshall14@gmail.com>
> Cc: linux-rt-users <linux-rt-users@vger.kernel.org>; Mark Marshall <
> mark.marshall@omicronenergy.com>; Thomas Graziadei <
> thomas.graziadei@omicronenergy.com>; Thomas Gleixner <
> tglx@linutronix.de>; linux-kernel@vger.kernel.org;=20
> rostedt@goodmis.org
> Subject: Re: Kernel crash due to memory corruption with v5.4.26-rt17
> and PowerPC e500
>=20
> On 2020-05-29 18:37:22 [+0200], To Mark Marshall wrote:
> > On 2020-05-29 18:15:18 [+0200], To Mark Marshall wrote:
> > > In order to get it back into the RT queue I need to understand
> > > why=20
> > > it is required. What exactly is it fixing. Let me stare at for a=20
> > > little=E2=80=A6
> >=20
> > it used to be local_irq_disable() which then became
> > preempt_disable()
> > local_irq_disable() due to ARM's limitation.
>=20
> Any luck on your side?
>=20
> I *think* if you swap the mm assignment in exec_mmap() then it should
> be gone. Basically:
> >         tsk->active_mm =3D mm;
> >         tsk->mm =3D mm;
>=20
> However I think to apply something like this:
>=20
> diff --git a/fs/exec.c b/fs/exec.c
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1035,11 +1035,15 @@ static int exec_mmap(struct mm_struct *mm)
>  		}
>  	}
>  	task_lock(tsk);
> +
> +	task_lock_mm();
>  	active_mm =3D tsk->active_mm;
>  	membarrier_exec_mmap(mm);
>  	tsk->mm =3D mm;
>  	tsk->active_mm =3D mm;
>  	activate_mm(active_mm, mm);
> +	task_unlock_mm();
> +
>  	tsk->mm->vmacache_seqnum =3D 0;
>  	vmacache_flush(tsk);
>  	task_unlock(tsk);
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -176,4 +176,31 @@ static inline void task_unlock(struct
> task_struct *p)
>  	spin_unlock(&p->alloc_lock);
>  }
> =20
> +#ifdef CONFIG_PREEMPT_RT
> +/*
> + * Protects ->mm and ->active_mm.
> + * Avoids scheduling so switch_mm() or enter_lazy_tlb() will not
> read=20
> +the
> + * members while they are updated.
> + */
> +static inline void task_lock_mm(void)
> +{
> +	preempt_disable();
> +}
> +
> +static inline void task_unlock_mm(void) {
> +	preempt_enable();
> +}
> +
> +#else
> +
> +static inline void task_lock_mm(void)
> +{
> +}
> +
> +static inline void task_unlock_mm(void) { } #endif
> +
>  #endif /* _LINUX_SCHED_TASK_H */
> diff --git a/mm/mmu_context.c b/mm/mmu_context.c
> --- a/mm/mmu_context.c
> +++ b/mm/mmu_context.c
> @@ -25,6 +25,7 @@ void use_mm(struct mm_struct *mm)
>  	struct task_struct *tsk =3D current;
> =20
>  	task_lock(tsk);
> +	task_lock_mm();
>  	active_mm =3D tsk->active_mm;
>  	if (active_mm !=3D mm) {
>  		mmgrab(mm);
> @@ -32,6 +33,7 @@ void use_mm(struct mm_struct *mm)
>  	}
>  	tsk->mm =3D mm;
>  	switch_mm(active_mm, mm, tsk);
> +	task_unlock_mm();
>  	task_unlock(tsk);
>  #ifdef finish_arch_post_lock_switch
>  	finish_arch_post_lock_switch();
> @@ -55,10 +57,12 @@ void unuse_mm(struct mm_struct *mm)
>  	struct task_struct *tsk =3D current;
> =20
>  	task_lock(tsk);
> +	task_lock_mm();
>  	sync_mm_rss(mm);
>  	tsk->mm =3D NULL;
>  	/* active_mm is still 'mm' */
>  	enter_lazy_tlb(mm, tsk);
> +	task_unlock_mm();
>  	task_unlock(tsk);
>  }
>  EXPORT_SYMBOL_GPL(unuse_mm);
> --
> 2.27.0
>=20
> > > > Best regards,
> > > > Mark
>=20
> Sebastian

