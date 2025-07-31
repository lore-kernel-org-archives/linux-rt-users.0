Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBFB189F5C
	for <linux-rt-users@vger.kernel.org>; Thu, 31 Jul 2025 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753986904; cv=none; b=h2+rntDUsWPeZsBYgayPoUQ+NmYFS9vOUcwMP56EOnyTlV5Bn9QG/coefzOxKzpN2U8mCLuB2N1xN5/uL9p1JEI7x/xImzVd24VxVgokY5oqXIyQgDCaptP2xPG8BX4wzwjyPAKd2xEivKPMu/KVNeOjsXiURMq27eN7Gv4et/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753986904; c=relaxed/simple;
	bh=TWuZ658L6TwNsx0MI/BGc4/B9jCczc+Yq4fGUgDni5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jv1s0nT1cStQu4ql4n8GcnoUBNQsWHlKu2xvCW9GDgLynA6uA2M2nNZ8n3w40MIbW+8PH7qeOx+QJg5U8ehud4J2ADqjuLM332Mp4Vh2BSgYn+H1qg7reHpWl5PEtAPZUgO4vYLEL/X2WHX21KPxUXoyqn9wmTcXP0AODZ5p8yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fPqI1kTW; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fPqI1kTW"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4aaf43cbbdcso30301cf.1
        for <linux-rt-users@vger.kernel.org>; Thu, 31 Jul 2025 11:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753986902; x=1754591702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sl94WIxMtBCkU36kfiKWNKynhVQAmpLF1VjfHVNOmI=;
        b=fPqI1kTWMUIfgg/w7UXLqhff7GMXLx+0KDtDPA9QoR1pNKI5Wj+PYP6jIme6UDh/NO
         m2TlbaRY6rbPVs2iEpIGjnzEq5OJnkIC1m+MxvGzn1yTijLUP8ME+PZO4ApRixjyQH7c
         1LDEEgVybBpuVd1Ij4C8H8uZK/6xPtWZUpsy6HBCUf6KZ8Ag8xnLA7l08QF+rr3i+DMK
         k/JRDXBL+iQWviCmPZsAF3+5uOCllYaq8Pqyq+w0uLoNO0Vr0+aSomBMW/6QAPGqhc2A
         wolHLooRhczC743PJL7T6zEqO8EJmcGGos4pyb4GQhIKQEWrH8fk1Cs/m1JPCvOfPF/S
         1CWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753986902; x=1754591702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3sl94WIxMtBCkU36kfiKWNKynhVQAmpLF1VjfHVNOmI=;
        b=gnKNFvinbDchH520jhLyzMziI111WSe9pPRFbSu+moswWWz8mR8stGuS77896NJo3H
         l2DY4FVALHtDgiRo6kY37FEazWtBk7Lyy3SJFteplkFIGSLu5olZswYFlsry94uRC8gD
         d9ua87lGDhAGvuVL3jdKA1HpDaXGDw9VnKDB0VKe5x0UsqAYeurNKXkayWyRVKRtMdkB
         CpEKIwQ0pbLzeZZHjx1pZB0S+zZyB2TIc1q2yVxuWdzUKo1Rq8Ju4qCujwf6lqdNhz1V
         p8JYzlo4dGNZdv2yDMj6vghjq4VCFmutRJ3Vc3JbgBVV3vRjvXSSc4D+dO4Nt/jYCqE9
         L6KQ==
X-Gm-Message-State: AOJu0YwstxqYgr/4OG74QH/geCxPqF5jwTVIXVnqmetw2LX93tmvo8fC
	V8pLG99U52fXm9dDJ8iC7ViOTpJqNUMka+FyyPZY9bmsKTzEYhrHaOxUd+hqMbw2dK0znpQXubC
	MXBLXevzHUjzEEZA3OE61yLN16sZgLq4QMS5KfA9+
X-Gm-Gg: ASbGncvd4qipY6bPSzmx+cnqGzLrhgbw+V19gVfeylKBFg4+qX5bUOXaVtFtk5kum0Z
	jYSDHTIXTgaC7elVMga14bfi+A8OvcQyD2B1z0UPGY/cMGFvczK9XCSKxGrKPlkcCqFWozMtcg6
	A912L6EgLv4QBZqFVUBhc+vaOdq5veJTM/kQrpMHGBJVIKQSBuGkNziou7c2/RCBLCvYUNXvkpo
	bfG
X-Google-Smtp-Source: AGHT+IG8dwAOmNJsGh6zbRM/I8aJX8Oc13ieikcMJPqAfmSx5slCeVWy09nxhdeNWTrV7C3cx23F34V9sDwqMcPRfbM=
X-Received: by 2002:a05:622a:28d:b0:4a7:1743:106b with SMTP id
 d75a77b69052e-4aefe4c6e4bmr401021cf.6.1753986901330; Thu, 31 Jul 2025
 11:35:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com>
In-Reply-To: <DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com>
From: Frank van der Linden <fvdl@google.com>
Date: Thu, 31 Jul 2025 11:34:50 -0700
X-Gm-Features: Ac12FXyPY6jyMNK1z0Sa1pOKvQufurZYXqkKaBQWTzR7vxpq5Jd4_LdZXos92u0
Message-ID: <CAPTztWYf82p6hq=Q2mVq6_9WTjRaQiH81z4idZL6MZ1PXufPwQ@mail.gmail.com>
Subject: Re: Realtime threads delayed due to kcompactd0
To: Alexander Krabler <Alexander.Krabler@kuka.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Dennis Schimmel <Dennis.Schimmel@kuka.com>, 
	Daniel Braunwarth <Daniel.Braunwarth@kuka.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 10:30=E2=80=AFPM Alexander Krabler
<Alexander.Krabler@kuka.com> wrote:
>
> Hi all,
>
> some of our realtime tasks get delayed from time to time due to activity =
of kcompactd0.
> Out of nothing, realtime tasks go into uninterruptable sleep for some tim=
e.
> This delay can be as much as 1.1ms, which is not acceptable for us.
>
> Our hardware is an aarch64-based SOC with 8 A72 cores, kernel is 6.12.17 =
with PREEMPT_RT.
> We have CONFIG_COMPACTION and CONFIG_MIGRATION enabled.
>
> Here are some snippets from ftrace:
>              kcompactd0-88    [001] 13112.100041: mm_compaction_begin:  z=
one_start=3D0x80000 migrate_pfn=3D0x80000 free_pfn=3D0xffe00 zone_end=3D0x1=
00000, mode=3Dsync
> ...
>              kcompactd0-88    [001] 13112.159782: mm_compaction_isolate_m=
igratepages: range=3D(0x85800 ~ 0x85841) nr_scanned=3D65 nr_taken=3D32
>              kcompactd0-88    [001] 13112.159810: mm_compaction_isolate_f=
reepages: range=3D(0xddc40 ~ 0xddc48) nr_scanned=3D8 nr_taken=3D8
>              kcompactd0-88    [001] 13112.160002: irq_handler_entry:    i=
rq=3D11 name=3Darch_timer
>              kcompactd0-88    [001] 13112.160012: irq_handler_exit:     i=
rq=3D11 ret=3Dhandled
>              kcompactd0-88    [001] 13112.160121: mm_compaction_migratepa=
ges: nr_migrated=3D32 nr_failed=3D0
>              kcompactd0-88    [001] 13112.160122: mm_compaction_finished:=
 node=3D0 zone=3DDMA      order=3D-1 ret=3Dcontinue
>              kcompactd0-88    [001] 13112.160185: mm_compaction_isolate_m=
igratepages: range=3D(0x85841 ~ 0x85a00) nr_scanned=3D447 nr_taken=3D166
>              kcompactd0-88    [001] 13112.160204: mm_compaction_isolate_f=
reepages: range=3D(0xddc48 ~ 0xddd80) nr_scanned=3D312 nr_taken=3D196
>               tRealtime-16499 [004] 13112.160511: sched_switch:         t=
Realtime:16499 [25] D =3D=3D> tKRC:16479 [39]
>               tRealtime-16499 [004] 13112.160512: kernel_stack:         <=
stack trace >
> =3D> __schedule (ffffcde843022d6c)
> =3D> schedule (ffffcde843023464)
> =3D> io_schedule (ffffcde8430235ec)
> =3D> migration_entry_wait_on_locked (ffffcde8424a1ad8)
> =3D> migration_entry_wait (ffffcde84254c400)
> =3D> do_swap_page (ffffcde8424f7fac)
> =3D> __handle_mm_fault (ffffcde8424f8b64)
> =3D> handle_mm_fault (ffffcde8424f9bc0)
> =3D> do_page_fault (ffffcde843030380)
> =3D> do_translation_fault (ffffcde84303072c)
> =3D> do_mem_abort (ffffcde84222f674)
> =3D> el0_ia (ffffcde84301eb20)
> =3D> el0t_64_sync_handler (ffffcde84301f020)
> =3D> el0t_64_sync (ffffcde842211514)
>              kcompactd0-88    [001] 13112.160557: sched_pi_setprio:     c=
omm=3Dkcompactd0 pid=3D88 oldprio=3D39 newprio=3D120
>              kcompactd0-88    [001] 13112.160569: sched_waking:         c=
omm=3DtKRC pid=3D16479 prio=3D39 target_cpu=3D004
>              kcompactd0-88    [001] 13112.160986: sched_waking:         c=
omm=3DtKRC pid=3D16479 prio=3D39 target_cpu=3D004
>              kcompactd0-88    [001] 13112.161412: sched_waking:         c=
omm=3DtOther pid=3D16520 prio=3D40 target_cpu=3D004
>              kcompactd0-88    [001] 13112.161457: sched_pi_setprio:     c=
omm=3Dkcompactd0 pid=3D88 oldprio=3D40 newprio=3D120
>              kcompactd0-88    [001] 13112.161465: sched_waking:         c=
omm=3DtOther pid=3D16520 prio=3D40 target_cpu=3D004
>              kcompactd0-88    [001] 13112.161654: sched_waking:         c=
omm=3DtRealtime pid=3D16499 prio=3D25 target_cpu=3D004
>
> In our setup kcompactd0 gets enough CPU time (on core 1), however, it see=
ms strange that it doesn't get the priority inherited from blocked realtime=
 tasks.
> (It does for short amounts of time, which seems to be due to the locks in=
side migration_entry_wait_on_locked.)
>
> Is there anything we can do here?
>
> Thanks,
> Alexander

Yes, we have (likely) seen this issue too, in a !CONFIG_PREEMPT setting.

The basic problem is that the calling thread (kcompactd or it could be
any thread that goes in to direct compaction) creates a resource that
needs to be waited for until it's done, in the form of the migration
PTEs. Since a migration PTE is not a lock that is held by the thread
doing the migration, there is no priority inheritance in the realtime
case, and priority inversion can happen.

This issue has always been there, but it has been made more prominent
with batch migration. With batch migration, all migration PTEs are set
up in the first step, followed by a TLB flush, and then the copy / new
map setup is done. So, the migration PTEs stick around for longer, and
the chance that other threads block on them is higher. For the
!CONFIG_PREEMPT case, the cond_resched() in the loop can also cause
the thread creating the migration PTEs to be descheduled while a
number of migration PTEs are in place, so there is a similar priority
inversion chance.

Not sure what the right thing to do would be. Either explicitly boost
the priority of a thread temporarily during migrate_pages_batch, or
mitigate the issue by dealing with 'busy' pages more quickly in
migrate_pages_batch.

- Frank
