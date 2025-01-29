Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD0A191489
	for <linux-rt-users@vger.kernel.org>; Wed, 29 Jan 2025 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738187973; cv=none; b=qU4bWUcre2hs9Yyz3dID79BAv/KiKZoFe9KOEApyfp5wxd4AF7oY6ZZvyju0wAY/sRnlzbwqo2IdbZ5/8PzYhxMZhTHyakawXqECErVZevzUhk0QwlGGgx+WRwymNv2cEdTO0LHahCY754HNM2KlE9PR/yA9rpGYY/0ga+RzRbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738187973; c=relaxed/simple;
	bh=RoT8oEYnAiD9qBRoKVTiNs80NRjK00B6mAbi7arPHWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thZvW5ZIq3uPdwtr2VImmpAFYsspK3BBBQXS/uRfi4aWteRQeXzaR54Oryh/DAwUwmcB4dPIfbqPFndCkoCUYJx4YX+7eU15OCkhJBCVanDrpeBfyoO44hc1jLFZ29M13T7GBe4iE61v2GBWAM+W4DgNTvDQB1uwb//8BHBA/90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJzorN1n; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJzorN1n"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso123302a91.2
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Jan 2025 13:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738187971; x=1738792771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLHxSeERVU93eRe8zJRkMpHN5433f54HAauRN4gA/w0=;
        b=bJzorN1n1R4IFW53BOhFSDcZv1qpm1Bb0O0hpG951vYQGjJ0XvPWilkZRwn6h2meGq
         lquBghvT/oPVK+jgg4ZQD+n08A9c0O5EYprRrjIk4tkda+dczh3UmL+r4hSE5DuOMw5Y
         UhDH+6VtgQaNelaADEtjUo9Vm5cSnaR0oewH+3tJHMgHeWBlVdnCUqqsxCPLkBUQOq5C
         pzwKrFJt7PkGEclCoOhQC5lMpYOklRz/BNEQYSYuQVm9Xm/pjEWBQBwKP8Yy7OOf7zk1
         nMcKn6B1s1KtYkE+QaDC9JGS7vpOA2GSTolglZ4evnC+udPCD36DqFIyDqRZU20pXKz1
         9uGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738187971; x=1738792771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLHxSeERVU93eRe8zJRkMpHN5433f54HAauRN4gA/w0=;
        b=v7muJLK8xhb2ZPy8UT6j64Ex0UbvU0GQJg3SMRUrp0oltJiIXKX7SFmOSxyl/gGOk7
         Ea6YOwPZ4JTSfvzCl8y0UdvY/FmUwxLBC8gw/l4MW+zkIICgrFyQwIU02jEV0wzLiv5f
         H2UPOCrPquxEzVfkkJ8j+vmLJArpKu8HwlZwjxfiuoz5NhXsC25b9KRt8vrNGLSUikP8
         8tMya+LlilekWvEcCBGbiOQBSXgZeuIBtQG4WQbF8/9xCfYYH+SsGK5XSeJNHwNil0Qz
         e69htgwHu4IL5AKeO0j07vlGD+ziJs5fFnZht7TvtejD1kuGl6nQC1vDjs3sDRvoVNpj
         clsA==
X-Forwarded-Encrypted: i=1; AJvYcCU5ji5y384eD2kpQbZ/Dr9q9IJoizF2qrewvqQ744cCtDLK6ls5hrsomOMP/d4WssHKX6EGce3wr3QWSAXhqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgUQ7KRW6UYu4WkSf+Mq1XMn2e4Mte2KIfECCjgwHIOKz9ZYU8
	DdIe60cjHv5Fy1EwcVNIXp1nl6alFEsQfRR8PtWdbZjL+5odsv9cddEsmlVgRgVRmCttlJ5SMpi
	Bl2KYZ2nMu0N1Vu0dK5JtCKPvv2hB4d3J
X-Gm-Gg: ASbGncvNxokv1/WIMRXd5AD+HexbQUjY7gZU8RPNM7gchJS/8Z8sYZc+1+ZHT1p95sb
	hTPC7lhC9kHVQbvMyyUKModWhJla0u1Mj6keXCpZ4mG6WricEmBXcnaup5cybPv0AqOoak2sN
X-Google-Smtp-Source: AGHT+IH6otJYa3LLpmHoMy9LEI3Acr6tPHZ/edyRjWrYmZqTMRPK2SRyi+FM8tnT7+VResgq1kdR9+mdmSBIb11I0TY=
X-Received: by 2002:a17:90b:2dd2:b0:2ee:b6c5:1de7 with SMTP id
 98e67ed59e1d1-2f83abbd65dmr7293046a91.2.1738187971309; Wed, 29 Jan 2025
 13:59:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAArt=LjxU0fUZOj06X+5tkeGT+6RbXzpWg1h4t4Fwa_KGVAX6g@mail.gmail.com>
 <20250123142324.449f21ba@mordecai.tesarici.cz> <CAArt=Li11gQ1XsfpsZuV8afd4E5UjcuHa=r1Ng9q6HG6AjxJWg@mail.gmail.com>
 <20250129103925.7TEmpCt_@linutronix.de>
In-Reply-To: <20250129103925.7TEmpCt_@linutronix.de>
From: Jillian Donahue <jilliandonahue58@gmail.com>
Date: Wed, 29 Jan 2025 14:59:19 -0700
X-Gm-Features: AWEUYZme5f0kZ_7onWbWRPRbWTw6xPsdA-WS1QdfSpxabLcIaxFg77dY5hZMV-g
Message-ID: <CAArt=Lj5byHfx7SJXzHiB0ecFDWjhjODyM05=5y27PYj8bGaUQ@mail.gmail.com>
Subject: Re: Spinlock in f_midi_transmit causing kernel crash
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petesarik@suse.de>, 
	linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> So a simple "tasklet_hi_schedule(&midi->tasklet);" instead of "f_midi_tra=
nsmit(midi)" in f_midi_complete() might do the trick.

This fixes the problem - do you have any insight to how this worked in
the first place? Trying to understand the change.

On Wed, Jan 29, 2025 at 3:39=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-01-24 15:21:21 [-0700], Jillian Donahue wrote:
> =E2=80=A6
> > I have tried the proposed fixes and cherry-picked commits c7d9efdff68e
> > and 8653d71ce376 (the equivalent fix in f_midi.c), and upgraded to
> > v5.10rt. I still see the spin lock in both cases but the trace is
> > slightly different:
> >
> > [  193.010603] kernel BUG at /kernel-source//kernel/locking/rtmutex.c:1=
048!
>
> This means the caller already owns the lock it asked for.
>
> > [  193.010609] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> > [  193.010644] Process kworker/4:2H (pid: 847, stack limit =3D 0x000000=
006e538c8b)
> =E2=80=A6
> > [  193.010729] Call trace:
> =E2=80=A6
> > [  193.010742]  f_midi_transmit+0x90/0x5d8 [usb_f_midi]
> The lock it asks for
>
> > [  193.010745]  f_midi_complete+0x11c/0x138 [usb_f_midi]
> > [  193.010754]  usb_gadget_giveback_request+0x10/0x18
> > [  193.010758]  __usbhsg_queue_pop+0x3c/0x58
> > [  193.010760]  usbhsg_queue_done+0x44/0x60
> > [  193.010763]  usbhsf_pkt_handler+0x80/0x120
> > [  193.010766]  usbhs_pkt_start+0x10/0x18
> > [  193.010768]  usbhsg_queue_push.isra.0+0x44/0x50
> > [  193.010771]  usbhsg_ep_queue+0x2c/0x40
> > [  193.010773]  usb_ep_queue+0x24/0x40
> > [  193.010776]  f_midi_transmit+0x238/0x5d8 [usb_f_midi]
> The lock it already acquired.
>
> > [  193.010779]  f_midi_in_work+0x10/0x18 [usb_f_midi]
> > [  193.010786]  process_one_work+0x1e8/0x340
> > [  193.010788]  worker_thread+0x40/0x458
> > [  193.010792]  kthread+0x16c/0x170
> > [  193.010797]  ret_from_fork+0x10/0x1c
> =E2=80=A6
> >
> > Let me know if there is anything more useful here or if there's any
> > other information I can provide.
>
> Looking at v6.13, the code flow is still the same. I don't see how !RT
> is not affected by this. The tasklet to workqueue change didn't change
> the logic here, it only changed the API and the context but the
> recursion remains.
>
> So a simple "tasklet_hi_schedule(&midi->tasklet);" instead of
> "f_midi_transmit(midi)" in f_midi_complete() might do the trick.
>
> > Thanks
>
> Sebastian
