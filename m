Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from frisell.zx2c4.com ([192.95.5.64]:46889 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755899AbeFONBE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Jun 2018 09:01:04 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 3bfc572a
        for <linux-rt-users@vger.kernel.org>;
        Fri, 15 Jun 2018 12:55:41 +0000 (UTC)
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 24952c8f (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-rt-users@vger.kernel.org>;
        Fri, 15 Jun 2018 12:55:41 +0000 (UTC)
Received: by mail-oi0-f52.google.com with SMTP id a141-v6so8708256oii.8
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Jun 2018 06:01:03 -0700 (PDT)
MIME-Version: 1.0
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 15 Jun 2018 15:00:51 +0200
Message-ID: <CAHmME9p1TZV9i6EBuFR+Pqf+8yg-sjM0f=uYzqdYKMxxUiHuRw@mail.gmail.com>
Subject: kernel_fpu_begin and spinlocks
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

Hello,

In order to do fast crypto, people like to use vector instructions,
which make use of the FPU registers. Typically things resemble this
pattern:

kernel_fpu_begin();
encrypt();
kernel_fpu_end();

If there are multiple things to encrypt, one pattern is:

for (thing) {
  kernel_fpu_begin();
  encrypt(thing);
  kernel_fpu_end();
}

But it turns out this is slow, so instead it's better to:

kernel_fpu_begin();
for (thing)
  encrypt(thing);
kernel_fpu_end();

However, what if that innerloop has some spinlocks?

kernel_fpu_begin();
for (thing) {
  encrypt(thing);
  spin_lock(queue_lock);
  add_to_queue(queue, thing);
  spin_unlock(queue_lock);
}
kernel_fpu_end();

On normal kernels, that's certainly okay. But on rt kernels, spinlocks
call schedule(), and kernel_fpu_begin() explicitly disables
preemption, so everything explodes.

I'm wondering if -rt has any ideas about not having a strict
preemption requirement for kernel_fpu_begin/end, so that the ordinary
pattern can work on -rt kernels without exploding.

Regards,
Jason
