Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0F425760
	for <linux-rt-users@vger.kernel.org>; Fri, 31 Jan 2025 19:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738350495; cv=none; b=WzaYkBJMwaIXZRtYuGhCT0avTunb262jnovEB0fPuKuOreesMcy/KoKE0U9Ur+gF++qvYn44PkwNLQH3Ar2pSZ4Fq4tL5nxyyfYHlvqRfXgY23q3wS2kUHHvo0Lclv2afHpoT+W2v9i8U++trILsbNiBjpCMx55h4W6vQCRiFFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738350495; c=relaxed/simple;
	bh=AZvRjzFNvszHTqSjJydka46EDIOjDixCAkWrH5MUyZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwKoQqjs3CEMliG6m3dfNJkmB/HSsEdXlPr9f+cQ3AxyroBqnVrUDelosN1qZPcfK2Z5W6pmkszQdHBilo/lMl0YXcASnmtfjlK09ZqMNlOaFR0zznDI1mcPJBy6XO9TNNusoLaxbJEORv/3+Uw+++15rPbPRwJv2uHeQCMqjtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HauLSngk; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HauLSngk"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so4156797a91.3
        for <linux-rt-users@vger.kernel.org>; Fri, 31 Jan 2025 11:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738350493; x=1738955293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BptcAZQ8FMAMA24lWlWlnW2V5MeED4dcrBPdrHcuqtI=;
        b=HauLSngkAC1rJP4FFsCgs17MkIJprV7PRVZh3dvX7k8Od+/9gWU2kIlRifxK9SgHwH
         mbT2ItAAhfLGVOODkBByKYRdT0IMYoxGvpx/DeHQ3kt4LMGl6MTMXR2sGJZYZm8nC3QP
         XoCG1J/gSJ5C6vJeZLv67UrEWIL4WczRvPhI6SQhKnlGxepn9Decff7qyt6kcoj2KXBe
         Kr6BDI7tgrG/FhbMi+FnR68+SGykhLISgCn7eOvERb54YWhvI53Z9ULAE4dAsq4TuY9U
         G7NvwN0TQ7N9YooSuyiZCSZahFEetVmkcRO1XGURdG/uUqjAP51uHd/nom8KqL162Sev
         wqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738350493; x=1738955293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BptcAZQ8FMAMA24lWlWlnW2V5MeED4dcrBPdrHcuqtI=;
        b=W4nqmVYz9Kq8xhhF3pERTNa7gwTbSWdS06g7+hejfFGpxvVGzGps43T0JLLRdsP7yu
         Am8hDMP6spZdczy5PnMh9solFCN8zpqb43t1ARbNRFsqpjGvDtLvPC3+KjuMp3QNpsK0
         PNWkRbf1d1tZysdPknA2k9l9PiHQRX/45cVqPbf/MF2kz4slEElCvfDI4iuFB3h4S2Qx
         LyOiw3D9WvNs02PIfk2W5OKgAt1+rPfbQl5LVR7kPPsrrwdFFfHWe0a4Cr0NRYVkvdxT
         TF3eS3tALQe1VVtV+1I8D9E0f0pSHsC+A0oR+kkLZmdMo+VxBGRafbGRkUu4NTzSGg12
         kUGw==
X-Forwarded-Encrypted: i=1; AJvYcCXYkmVEG8gwIk3AnEKOp9js6dV8smxv/IpDEx8o/AQV2/+z5bp8hcUk0A2kq6h2Y0c5C2XeNpTjoj1kPbz97w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8HIPry8qymSF+OGLd92v9zPfKDF0wUcKCkQu1IGEP28f9VdZd
	XYP+PcM4ghwzpOl4ThIfn7+4GDWccW7SJz0lrgbOFjfZ3717o9mAVv2xQHrP8Ydbbwh5B3Yysq5
	J8hW49MnckhMTJI/aPP35d/cJio0=
X-Gm-Gg: ASbGnctdv0KLnvO1Lq3TmJ8/ClUn0GmZMkiyF3VT39U4CzQNzsUfqQSFcCwajPnEsH0
	hLqO+mQisrNUHe9ol+QpUYmSomHQPBUXTCI5lkZ3QKEX3aaRrGcMFPKMFDrYS5sbxPSgOZ7Md
X-Google-Smtp-Source: AGHT+IHCpbDsjKrCV1XWFZ6LTXfpR7TGEMweC7TvuR6g9KBbxjXY6Fp4dkTpD7THwtQXmHsTN2jXYsw35WZa+7fmTog=
X-Received: by 2002:a17:90b:2704:b0:2ee:d433:7c54 with SMTP id
 98e67ed59e1d1-2f83ac09092mr17924058a91.19.1738350493346; Fri, 31 Jan 2025
 11:08:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAArt=LjxU0fUZOj06X+5tkeGT+6RbXzpWg1h4t4Fwa_KGVAX6g@mail.gmail.com>
 <20250123142324.449f21ba@mordecai.tesarici.cz> <CAArt=Li11gQ1XsfpsZuV8afd4E5UjcuHa=r1Ng9q6HG6AjxJWg@mail.gmail.com>
 <20250129103925.7TEmpCt_@linutronix.de> <CAArt=Lj5byHfx7SJXzHiB0ecFDWjhjODyM05=5y27PYj8bGaUQ@mail.gmail.com>
 <20250130075026.RVen6mGf@linutronix.de>
In-Reply-To: <20250130075026.RVen6mGf@linutronix.de>
From: Jillian Donahue <jilliandonahue58@gmail.com>
Date: Fri, 31 Jan 2025 12:08:01 -0700
X-Gm-Features: AWEUYZl8S1sG2eUyfOl15wTjORHJDKHsONez2NI8KGgMrJorqJJ9ut9XksJ6GNg
Message-ID: <CAArt=LgTQHaHmBQZkY3APwuRAH=f-4ABW-8f0joQs3JLocZarA@mail.gmail.com>
Subject: Re: Spinlock in f_midi_transmit causing kernel crash
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petesarik@suse.de>, 
	linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks again for your time. Here is the request patch:

From 1577bf36766218a1902ac92377dbc51798f2e4a0 Mon Sep 17 00:00:00 2001
From: Jill Donahue <jilliandonahue58@gmail.com>
Date: Fri, 31 Jan 2025 11:39:57 -0700
Subject: [PATCH] f_midi_complete to call tasklet_hi_schedule

---
 drivers/usb/gadget/function/f_midi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_midi.c
b/drivers/usb/gadget/function/f_midi.c
index 837fcdfa3..37d438e5d 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -283,7 +283,7 @@ f_midi_complete(struct usb_ep *ep, struct usb_request *=
req)
                        /* Our transmit completed. See if there's more to g=
o.
                         * f_midi_transmit eats req, don't queue it again. =
*/
                        req->length =3D 0;
-                       f_midi_transmit(midi);
+                       tasklet_hi_schedule(&midi->tasklet);
                        return;
                }
                break;
--=20
2.25.1

Jill

On Thu, Jan 30, 2025 at 12:50=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-01-29 14:59:19 [-0700], Jillian Donahue wrote:
> > > So a simple "tasklet_hi_schedule(&midi->tasklet);" instead of "f_midi=
_transmit(midi)" in f_midi_complete() might do the trick.
> >
> > This fixes the problem - do you have any insight to how this worked in
> > the first place? Trying to understand the change.
>
> There are possibilities. The problem is that you send a packet and it
> completes the same moment and the completion callback is invoked which
> deadlocks.
>
> Now:
> - PREEMPT_RT may have moved the timing a bit (makes it behave a bit
>   different or simply make a UP device behave like a SMP one) to the
>   point that it sees the completion of the request where it did not
>   before. So does it occur without PREEMPT_RT?
>
> - It never did work in this combination even without PREEMPT_RT. The
>   driver (f_midi) was never tested with the USB device controller you
>   have and the one it was tested with behaves differently so the
>   recursion never occurred.
>
> - It is an old driver (f_midi). It was never tested on SMP or with
>   enabled lock testing. On UP spinlocks end up almost as NOPs so a
>   deadlock (as in this case) will not be observed.
>
> Either way I would blame f_midi here.
> Once you have the pieces together, mind sending a patch?
>
> Sebastian
