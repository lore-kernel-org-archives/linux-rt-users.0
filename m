Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0231156676
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Jan 2025 04:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736913924; cv=none; b=NAjq1bYbsPVayNHpsNvp5ASC9jvplqF3/7aqu13XjVwF1a7Nq8M/jbMjg1lt/8B95MMdbG1lR3iUmhGzxmtWgVg7eT3tAeXbggM6YbC2mignrSobVz9hk6HmEL2GiU7dl9xCUN2Awjx5D3sBEVTcwQ0WPxqO71vH90LbPtTKNlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736913924; c=relaxed/simple;
	bh=bJusuufe5XiSP8uPZHi+9vsewgN0Lvtfsx3paAC9sMI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=sXHWYR7kTiak+L3ARLZHmsiGx/G0o13BbQuC66afNQkK1eBjj75EW3MvG9Vm7QfzMBo4CsYPC3KSOsyFWqJ0R3cd8/HqC9HUhYVR71CDD69wF8++YF6Zexb5zCsUKr74ky2wRTpVZtgNopXLzUhqH0fo4FBqHqPh24zCt/pZeds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ7w/S26; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ7w/S26"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2efded08c79so8337605a91.0
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Jan 2025 20:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736913922; x=1737518722; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m06Jv4k5D+4XZ0bVQenPuBM4e05F87N42tzIAcalprw=;
        b=fZ7w/S263gatZCMDNT7owTOv9NTP4sGxc3Ihd/m3zSPXaKiDVFF+N2Cc1lYcda4oR5
         4o0lNy6OmVmTBrb550e5PZbzCLH+ZFb5OrCGkvrLgZqiuayGzzHqNNOFOnh0TXn55kXY
         lkTGkOaFxyjJYk4ddzf5PbtbBoQuxy5IzvKAiE5i4+QmKlCl/2/MPno8gTZknfHedzEh
         KHoQ892PUiDfXUe3IPLtVoriEtb9vSXQNT5LKaGYZvHEHihZaoXG86Prlkx5kfbZ38hL
         9oeezaHvvrb05BESjPCEMygQ1gyqEEcfhGKdVWTGKRPNPEalcCd/1d5jgVMjHbCtzmny
         k0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736913922; x=1737518722;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m06Jv4k5D+4XZ0bVQenPuBM4e05F87N42tzIAcalprw=;
        b=awpHuyjObia0qpwkCQwZhaIAgpePBAEoq1DnOpYYpkcqAqA0HCeSl17JanIQQONBV0
         c675hASltdkAOYrJUWoXjSnDs2H1GSP4zTz5FnXlc8bRrjApO14r1wpN/TMYVk53nLBS
         6BapuuLo60aRldkoLO25Ut5leSK1sdDj8VgATyFMfxBow/gWRF9EjsS6iV9e6ZSaZDua
         schsCaPCJ+h93oakzjiEspCVql40L0q0AJPiN9T8Zx9x5RahnFg8kxVENcwVrtQ1mPWE
         dGPANHwYswgZc6EfltABIBDlUdJtoTmAjJTi4drbgotIhG9YX8D86C/r8jQ1bLBRo1n9
         XzPQ==
X-Gm-Message-State: AOJu0Yxsh/DkxYqy2GaeWWfsIMYuJ0jYmKUVAt+paI5JixoQSYGpT65f
	BGQ/Ow/mOlZ9FhEM91+wRu4qPNogBL6XiADqT6IbSo8D/HOolM4Hd5xWzswqH0mH+iExaAwejPJ
	ymQts5EeFkSQEoQYq4YK9oyAykS60vjyU
X-Gm-Gg: ASbGncsOTjyb6QsteGDDCo+tRBNCy3kbDinA4oaM9nazws/8NyHZ4Jb8kVG0x3/tsB1
	5RLqJbf1V7Dp+uBIprWRgol9oMoQ+TCPsE6dt2w==
X-Google-Smtp-Source: AGHT+IHL3wM58gsBXta7etWlT9Itst6CvKli8ghY1wmi/kM8SGHdCWv1sNZCOUGM0pYESe6Gd4haAeFpvtxEesqvCes=
X-Received: by 2002:a17:90a:fc48:b0:2ef:e0bb:1ef2 with SMTP id
 98e67ed59e1d1-2f548ecc3a7mr36926668a91.19.1736913921811; Tue, 14 Jan 2025
 20:05:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jillian Donahue <jilliandonahue58@gmail.com>
Date: Tue, 14 Jan 2025 23:05:10 -0500
X-Gm-Features: AbW1kvbzQf45eMRy8eZBwl7nRoKy2CJ2FuiaAroLqe1iM5A9MEitUrGOGHaEgyM
Message-ID: <CAArt=LjxU0fUZOj06X+5tkeGT+6RbXzpWg1h4t4Fwa_KGVAX6g@mail.gmail.com>
Subject: Spinlock in f_midi_transmit causing kernel crash
To: linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am working on getting USB MIDI enabled for my device and keep
running into this issue:

[  125.702601] kernel BUG at /kernel-source//kernel/locking/rtmutex.c:1048!
[  125.702607] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP

[  125.702764] Call trace:
[  125.702770]  rt_spin_lock_slowlock_locked+0x280/0x2b8
[  125.702774]  rt_spin_lock_slowlock+0x5c/0x90
[  125.702779]  rt_spin_lock+0x60/0x70
[  125.702792]  f_midi_transmit+0x90/0x5d8 [usb_f_midi]
[  125.702797]  f_midi_complete+0x11c/0x138 [usb_f_midi]
[  125.702809]  usb_gadget_giveback_request+0x10/0x18
[  125.702814]  __usbhsg_queue_pop+0x3c/0x58
[  125.702818]  usbhsg_queue_done+0x44/0x60
[  125.702822]  usbhsf_pkt_handler+0x80/0x120
[  125.702826]  usbhs_pkt_start+0x10/0x18
[  125.702830]  usbhsg_queue_push.isra.0+0x44/0x50
[  125.702834]  usbhsg_ep_queue+0x2c/0x40
[  125.702837]  usb_ep_queue+0x24/0x40
[  125.702843]  f_midi_transmit+0x238/0x5d8 [usb_f_midi]
[  125.702848]  f_midi_in_tasklet+0xc/0x18 [usb_f_midi]
[  125.702860]  tasklet_action_common.isra.2+0xcc/0x1f0
[  125.702864]  tasklet_hi_action+0x20/0x28
[  125.702869]  do_current_softirqs+0x19c/0x248
[  125.702873]  run_ksoftirqd+0x24/0x40
[  125.702883]  smpboot_thread_fn+0x1b0/0x2b8
[  125.702887]  kthread+0x16c/0x170
[  125.702894]  ret_from_fork+0x10/0x1c
[  125.702900] Code: a90363b7 f9000fb4 f90023b9 f9002bbb (d4210000)
[  125.966631] ---[ end trace 0000000000000002 ]---

Seen in the driver code here:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/usb/gadget/function/f_midi.c?h=v4.19.182#n683

We are running a 4.19.182 kernel patched to PREEMPT RT.

Has anyone come across this before?
I also ask if we've uncovered a bug when using the midi usb gadget
with PREEMPT RT.
If so, do you have any suggestions for a proper fix?

Thanks for your help,
~Jill Donahue
