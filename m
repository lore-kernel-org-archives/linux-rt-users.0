Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B2D3A8CB
	for <linux-rt-users@vger.kernel.org>; Mon,  3 Feb 2025 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738605072; cv=none; b=RH4dU/s7AB8l2xYgJ0NIs0rd0RJa+5S8LFgccHwZ1Of04beGydRlXR2dxOHIJ1SKpiAanhHU7J1fKW/Odwj+6eCDPiO6OvSPMNIzIbMQUu6PiBj/Hd7/VXlIjhpNpbgDL0iWf6loWHjD9zlr7RdLDqK61SzOjoHwYVkOCE6hxf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738605072; c=relaxed/simple;
	bh=inoxGV8EVJTAFWFfX0fcU317th7V6V4Z3V5oe3Mluf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2gzM1pCWA8BmLB1dUBhyW6Lr/HCLIkpxzcpPHE+6sgMqk0rGQUW1+T0txFEmvx0SnTbRjO/xmcAC64SLiRFjYB03PBIyIICb57rvLOfleV1qXWlDOyDfBUH3Bgx+WnwHzFoYaZMfZ/FsvJTvq3c2qGoJtyNX0vVZi5iARPZn2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nm1yuUlp; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nm1yuUlp"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so8126866a91.1
        for <linux-rt-users@vger.kernel.org>; Mon, 03 Feb 2025 09:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738605069; x=1739209869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CPyGX0asTGsxZFHCJk6cyjFWPbLFRxEm0Ul44Jw/SGA=;
        b=Nm1yuUlpE4ImnNv3R+/QiM2+duT6OnouHiP0DP4IYAFZA+ke7C+z4G/57v80fGaGtA
         1zisRKh/FcE9TseYKDE41y5fZTf4qaiV76SeCqtYvC4yE1UrIjfrkQEwrUNxI2C9a+8T
         CPawTI2G6PHB1CA/9vCQwRjlRD67r8d48uEMEwKGUPF8ttisp2cKU5LdmG5MJPw9prvH
         yT/c04Y//k1HqcufnwHQ+4a0TZHgG7RBYwDYJQwgVGviZ4o15OZIkL9hDpshmo2752Bu
         cBkVEqgYNKi7b2TgDUn8FSbOrkd4BY6PTWpyLY3U5H0Shi+N7Eb7z6v69XU5dAFdbyZe
         ciVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738605069; x=1739209869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPyGX0asTGsxZFHCJk6cyjFWPbLFRxEm0Ul44Jw/SGA=;
        b=wm0iGNDKnNMJbinl+7seYzwZ0pANt2eIvlxnGInxLUznP0yv4tLtfhJb1OdmzuPEMZ
         Hn1Gbop24SXaY/CK+7YU5OgBVrxLKWKAlMSpJBavG+zXnkoh9pL5bNHBoraKjdc8A4dd
         OyO4IjEg7hZ8Bo9ltjm+kQ02OpgJaeVvpV5hBPaD8l7Z80Tmm4mEWOwcQpLN3PUby2IE
         rIdtwkPRkgHe/2u0udbk93pxMA/DzgSh07+vhniUndgdTKxKF0ii6I6NJPU/kIk4VFWV
         AMbjTQT9jXY0dJaS6zf7nxBuw2TP2/vorqaNzEWaArQB74TR9QF39tglVHGrWmwak9+q
         IDJA==
X-Forwarded-Encrypted: i=1; AJvYcCVZjftmtoi2z+9QMm5GM2SSpGW8z2Hcijw9QE+1+aW8O/4d6tLyDRzNlZrfjtlGtcPletvTIyfqSDyNPvVPnw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26TRIQBVqDQpU7LtlGPo09x6QcFXr5YmwjbjcZ1ckX0/G0fz0
	MwYvlRC0DRbnFHzcXSTnd/UemRWqQ2aGPAwWY1vBAL97jX1efiOKH0Q9uqrjSm9z689LgZDoMTK
	Drl5qec8nYXAScHylcTC+cz2H75s=
X-Gm-Gg: ASbGncslnPogn2eP4/825tf3PyOUKeLfc6AokL3zWU2Ir7nhgnaVKR+9ijadW5gXPkr
	vpM3lIDrL5puuOTCwgwwlMy9kMUyGgLsCreOwBuMKrsoveL20mam5RlAL6s2rFuw6bW25t3RE
X-Google-Smtp-Source: AGHT+IFz9B63wrFbCX9mG0h0ek6ibH8HnKi0jbB8zmDa8w3J35cbjoVnO5+A7fOMd/roX3nsc9oFVVK3ypqninDfq0o=
X-Received: by 2002:a17:90b:53c7:b0:2ee:7870:8835 with SMTP id
 98e67ed59e1d1-2f83ac83791mr39040350a91.33.1738605068974; Mon, 03 Feb 2025
 09:51:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAArt=LjxU0fUZOj06X+5tkeGT+6RbXzpWg1h4t4Fwa_KGVAX6g@mail.gmail.com>
 <20250123142324.449f21ba@mordecai.tesarici.cz> <CAArt=Li11gQ1XsfpsZuV8afd4E5UjcuHa=r1Ng9q6HG6AjxJWg@mail.gmail.com>
 <20250129103925.7TEmpCt_@linutronix.de> <CAArt=Lj5byHfx7SJXzHiB0ecFDWjhjODyM05=5y27PYj8bGaUQ@mail.gmail.com>
 <20250130075026.RVen6mGf@linutronix.de> <CAArt=LgTQHaHmBQZkY3APwuRAH=f-4ABW-8f0joQs3JLocZarA@mail.gmail.com>
 <Z6C6ZHQh3jc_iJLk@uudg.org> <20250203132232.ZLq9fj5q@linutronix.de>
In-Reply-To: <20250203132232.ZLq9fj5q@linutronix.de>
From: Jillian Donahue <jilliandonahue58@gmail.com>
Date: Mon, 3 Feb 2025 10:50:57 -0700
X-Gm-Features: AWEUYZnoloYF8-kpqw0t5BAhIoDTT-F_r2XlV5YWy1DfcRSVUbCCgtepW7B_p-Q
Message-ID: <CAArt=Lgo=mXXoFLZx1b0pGruiP2r9g-dmTnfEGzX5N6=+3cmcQ@mail.gmail.com>
Subject: Re: Spinlock in f_midi_transmit causing kernel crash
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petesarik@suse.de>, 
	linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From a97fceb3e51c478dee6d63caafb92c867432c042 Mon Sep 17 00:00:00 2001
From: Jill Donahue <jilliandonahue58@gmail.com>
Date: Mon, 3 Feb 2025 10:46:31 -0700
Subject: [PATCH] f_midi_complete to call tasklet_hi_schedule

When using USB MIDI, a spinlock is hit causing a kernel oops. This
happens because a lock is attempted to be acquired twice through
f_midi_transmit. The fix lies in calling tasklet_hi_schedule() in
f_midi_complete to remove the repeated call to f_midi_transmit.

Link: https://lore.kernel.org/all/CAArt=LjxU0fUZOj06X+5tkeGT+6RbXzpWg1h4t4Fwa_KGVAX6g@mail.gmail.com/

Fixes: d5daf49b58661 ("USB: gadget: midi: add midi function driver")
---
 drivers/usb/gadget/function/f_midi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_midi.c
b/drivers/usb/gadget/function/f_midi.c
index 837fcdfa3..37d438e5d 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -283,7 +283,7 @@ f_midi_complete(struct usb_ep *ep, struct usb_request *req)
                        /* Our transmit completed. See if there's more to go.
                         * f_midi_transmit eats req, don't queue it again. */
                        req->length = 0;
-                       f_midi_transmit(midi);
+                       tasklet_hi_schedule(&midi->tasklet);
                        return;
                }
                break;
-- 
2.25.1
