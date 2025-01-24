Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB719224CC
	for <linux-rt-users@vger.kernel.org>; Fri, 24 Jan 2025 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737757296; cv=none; b=BbXXjIwtQ9c5TWm4k68qo0Hl112TB6LaAQeOZ5Rkw0iG+B9fJMiF/y8K2359GY/WVg4LTc/uHLF9vQ/jM+ImLgicClL+ld9oQkcboq+ZM6OZrhSO9+/iFdnMYrRlXMj1ddpDiLaxnSpOuhqOGASEVRxL1ln9HbGabs4rO85sGIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737757296; c=relaxed/simple;
	bh=wGt6mSGO9TssbZ003OU9BVS83eIc2mT5WjMbbgIxsM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HnceC0Y15Ez4L4agEuxsSpmJBDV3Dbx84yp/zMY3m6fmbiBgokbDkpi7PSiN8NP/h0ERgYZZDUpg/J6yOCCE08Qo1rwltIsG74oBbISbbbZy7h/plA5ug1xkIkaYGr/s41hl+Rf/Mh9n8qfWVSVqlhekgDGp2GFz5chnAY2bD6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+1uyEAz; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+1uyEAz"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso3681664a91.2
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jan 2025 14:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737757294; x=1738362094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCrgmnIVH3vMjdCMn2Z5sK64BxaEiP6x8zgM82oX2n8=;
        b=m+1uyEAzYbuZiZ9hETPbyE0W7U7KOK9NLzlQ/tLLkVUcPaV5pQuNl5POFTv/jUYMxR
         tGg6LT6EnyRxD1mlP5Xvh3qefWPWNTXdhNTlPx625cN93aSgSbef84kfsreZxIguqU8G
         pUnvcrBgM/EpTHQrQ6lVRrj9D3ZuyUFxOxQYteMAm05Nc398nhHvrOdg6kfh6+zJllcA
         Gwn/9urX05XH1eAHWvorOefmTbJtxhhp7+KmsXqBYbrUPjLN4sIf7oxXpjGFcJ2wGf1x
         Df9YcZRl8LxTneX5Ks9OC9sPmW2F0jUPMz89zFeGw+bd3HymMMajjfucJcA3s/+/Kqu+
         PWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737757294; x=1738362094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCrgmnIVH3vMjdCMn2Z5sK64BxaEiP6x8zgM82oX2n8=;
        b=C/FHNDiqddJCHCS3Y0C79qrrmE4E2sqJUUqq45bzoUpvfx2vAikRlu0atrEY7N36S/
         DJnYiyEP4ilBsQGbhJ3lN6pIjkGNJeWLQL9YP+WLS3IB8Lsh8QavT7pTEagWgDiU0o4Q
         0LXtpYwej355TB3u6BQ76d7NPyRAUk5g3gefT8j1ZpzEK8z6K090OqXjZm0Rkg+5foQR
         v2qitda49gLIP8GQg1nc914xQa8ydPrmqfWzUOTIBF6K4VFOMzXWWaItm0OiWH32UQdR
         4yS+0th+zRDv5hS3CXqP/O0hEQR6mLtVaZ7ybB9GNg7XSSFNKoe9fyVFy5AoXW7uW5Dl
         mpDA==
X-Gm-Message-State: AOJu0YwNCsNf49rgc16dGSzWLMNVNjopHq6rIZwcpk9W9W8w4iW5yoVu
	2a4AWpivEN0DmMXT0oESey0arsiG58DN8LdvrVfnQ2qubZuHhIPFATCoKeo2q8/qtj0soQxlWeP
	zSjzEw67K3B10ypuLT693v2TpELgXZrQ0
X-Gm-Gg: ASbGncvrSqvbG/SloIei9v4H84r+Ems874Z+mJlfl3dRJbgNtcTta7qjTvqqGq4Eza0
	KKQOn81/700znu+E0kxP76qMaFYRoTL1nqXZojZfJZlFWTCjUoqTMRVArc/AFPw==
X-Google-Smtp-Source: AGHT+IFHgYO/20nYQZFb9yCy77SRArGhhXqriYBf6XAR95cvuXyAnsnEf+EcsOpyaEWoD8OPZNCujxSw2begmGWSWU8=
X-Received: by 2002:a17:90b:2d4b:b0:2ee:96a5:721c with SMTP id
 98e67ed59e1d1-2f782c997e4mr42687455a91.21.1737757292583; Fri, 24 Jan 2025
 14:21:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAArt=LjxU0fUZOj06X+5tkeGT+6RbXzpWg1h4t4Fwa_KGVAX6g@mail.gmail.com>
 <20250123142324.449f21ba@mordecai.tesarici.cz>
In-Reply-To: <20250123142324.449f21ba@mordecai.tesarici.cz>
From: Jillian Donahue <jilliandonahue58@gmail.com>
Date: Fri, 24 Jan 2025 15:21:21 -0700
X-Gm-Features: AWEUYZmIP-g9yrHsNq0-kESPxxQg4asCLoThQNrF99dB10EStyAbBrHNkwKaqgk
Message-ID: <CAArt=Li11gQ1XsfpsZuV8afd4E5UjcuHa=r1Ng9q6HG6AjxJWg@mail.gmail.com>
Subject: Re: Spinlock in f_midi_transmit causing kernel crash
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petesarik@suse.de>
Cc: linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your suggestion,

I should mention that I only see the spinlock on the midi transmit
side, not when receiving.
I have tried the proposed fixes and cherry-picked commits c7d9efdff68e
and 8653d71ce376 (the equivalent fix in f_midi.c), and upgraded to
v5.10rt. I still see the spin lock in both cases but the trace is
slightly different:

[  193.010603] kernel BUG at /kernel-source//kernel/locking/rtmutex.c:1048!
[  193.010609] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[  193.010644] Process kworker/4:2H (pid: 847, stack limit =3D 0x000000006e=
538c8b)
[  193.010666] Workqueue: events_highpri f_midi_in_work [usb_f_midi]
[  193.010671] pstate: 60000085 (nZCv daIf -PAN -UAO)
[  193.010686] pc : rt_spin_lock_slowlock_locked+0x280/0x2b8
[  193.010690] lr : rt_spin_lock_slowlock_locked+0x34/0x2b8
[  193.010691] sp : ffff00000c273a60
[  193.010693] x29: ffff00000c273a60 x28: ffff80053573c000
[  193.010696] x27: ffff80053573c220 x26: 0000000000000000
[  193.010699] x25: ffff80053575bc00 x24: 0000000000000000
[  193.010702] x23: ffff80053573c1d0 x22: ffff00000c273af8
[  193.010705] x21: ffff800537ced400 x20: ffff00000c273af8
[  193.010707] x19: ffff80053573c1e8 x18: 0000000000000000
[  193.010709] x17: 0000000000000000 x16: 0000000000000000
[  193.010711] x15: 0000000000000400 x14: 0000000000000400
[  193.010713] x13: 0000000000000001 x12: 0000000000000000
[  193.010715] x11: 00000000000001a4 x10: 0000000000000a10
[  193.010718] x9 : ffff00000c273d60 x8 : 0000000000000000
[  193.010720] x7 : ffff800537ced400 x6 : ffff800537ced401
[  193.010722] x5 : ffff80053573c200 x4 : ffff800537ced401
[  193.010724] x3 : 0000000000000001 x2 : 0000000000000000
[  193.010726] x1 : ffff800537ced400 x0 : ffff800537ced400
[  193.010729] Call trace:
[  193.010733]  rt_spin_lock_slowlock_locked+0x280/0x2b8
[  193.010736]  rt_spin_lock_slowlock+0x5c/0x90
[  193.010739]  rt_spin_lock+0x60/0x70
[  193.010742]  f_midi_transmit+0x90/0x5d8 [usb_f_midi]
[  193.010745]  f_midi_complete+0x11c/0x138 [usb_f_midi]
[  193.010754]  usb_gadget_giveback_request+0x10/0x18
[  193.010758]  __usbhsg_queue_pop+0x3c/0x58
[  193.010760]  usbhsg_queue_done+0x44/0x60
[  193.010763]  usbhsf_pkt_handler+0x80/0x120
[  193.010766]  usbhs_pkt_start+0x10/0x18
[  193.010768]  usbhsg_queue_push.isra.0+0x44/0x50
[  193.010771]  usbhsg_ep_queue+0x2c/0x40
[  193.010773]  usb_ep_queue+0x24/0x40
[  193.010776]  f_midi_transmit+0x238/0x5d8 [usb_f_midi]
[  193.010779]  f_midi_in_work+0x10/0x18 [usb_f_midi]
[  193.010786]  process_one_work+0x1e8/0x340
[  193.010788]  worker_thread+0x40/0x458
[  193.010792]  kthread+0x16c/0x170
[  193.010797]  ret_from_fork+0x10/0x1c
[  193.010801] Code: a90363b7 f9000fb4 f90023b9 f9002bbb (d4210000)
[  193.271972] ---[ end trace 0000000000000002 ]---
[  193.271976] note: kworker/4:2H[847] exited with preempt_count 1

Let me know if there is anything more useful here or if there's any
other information I can provide.

Thanks

On Thu, Jan 23, 2025 at 6:23=E2=80=AFAM Petr Tesa=C5=99=C3=ADk <petesarik@s=
use.de> wrote:
>
> V Tue, 14 Jan 2025 23:05:10 -0500
> Jillian Donahue <jilliandonahue58@gmail.com> naps=C3=A1no:
>
> > Hello,
> >
> > I am working on getting USB MIDI enabled for my device and keep
> > running into this issue:
> >
> > [  125.702601] kernel BUG at /kernel-source//kernel/locking/rtmutex.c:1=
048!
> > [  125.702607] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> >
> > [  125.702764] Call trace:
> > [  125.702770]  rt_spin_lock_slowlock_locked+0x280/0x2b8
> > [  125.702774]  rt_spin_lock_slowlock+0x5c/0x90
> > [  125.702779]  rt_spin_lock+0x60/0x70
> > [  125.702792]  f_midi_transmit+0x90/0x5d8 [usb_f_midi]
> > [  125.702797]  f_midi_complete+0x11c/0x138 [usb_f_midi]
> > [  125.702809]  usb_gadget_giveback_request+0x10/0x18
> > [  125.702814]  __usbhsg_queue_pop+0x3c/0x58
> > [  125.702818]  usbhsg_queue_done+0x44/0x60
> > [  125.702822]  usbhsf_pkt_handler+0x80/0x120
> > [  125.702826]  usbhs_pkt_start+0x10/0x18
> > [  125.702830]  usbhsg_queue_push.isra.0+0x44/0x50
> > [  125.702834]  usbhsg_ep_queue+0x2c/0x40
> > [  125.702837]  usb_ep_queue+0x24/0x40
> > [  125.702843]  f_midi_transmit+0x238/0x5d8 [usb_f_midi]
> > [  125.702848]  f_midi_in_tasklet+0xc/0x18 [usb_f_midi]
> > [  125.702860]  tasklet_action_common.isra.2+0xcc/0x1f0
> > [  125.702864]  tasklet_hi_action+0x20/0x28
> > [  125.702869]  do_current_softirqs+0x19c/0x248
> > [  125.702873]  run_ksoftirqd+0x24/0x40
> > [  125.702883]  smpboot_thread_fn+0x1b0/0x2b8
> > [  125.702887]  kthread+0x16c/0x170
> > [  125.702894]  ret_from_fork+0x10/0x1c
> > [  125.702900] Code: a90363b7 f9000fb4 f90023b9 f9002bbb (d4210000)
> > [  125.966631] ---[ end trace 0000000000000002 ]---
> >
> > Seen in the driver code here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/d=
rivers/usb/gadget/function/f_midi.c?h=3Dv4.19.182#n683
> >
> > We are running a 4.19.182 kernel patched to PREEMPT RT.
> >
> > Has anyone come across this before?
> > I also ask if we've uncovered a bug when using the midi usb gadget
> > with PREEMPT RT.
> > If so, do you have any suggestions for a proper fix?
>
> AFAICT the proper fix would be to replace tasklets with a work (as done
> in commit c7d9efdff68e). IOW either upgrade to v5.10rt, or backport the
> referenced commit.
>
> HTH
> Petr T
