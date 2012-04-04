From: Tom Cook <tom.k.cook@gmail.com>
Subject: NVIDIA binary driver with rt patch
Date: Wed, 4 Apr 2012 16:37:37 +0100
Message-ID: <CAFSh4Uy41q=Q5Na_15iLVo8ohpD2mkx0iVMcpCi-fRhnBJ9Qfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:56775 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932261Ab2DDPhh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Apr 2012 11:37:37 -0400
Received: by dake40 with SMTP id e40so410375dak.11
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Apr 2012 08:37:37 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I'm quite new to linux-rt.  I'm trying to get a usable RT kernel on an
Ubuntu 11.10 system.  It has an nVidia Quadro NVS 285 video card and
I'm trying to get the binary drivers working, too.

I've built the 3.0.25 kernel with the rt44 patcheset applied.  I've
also modified it slightly so that migrate_enable, migrate_disable and
__init_rt_mutex are exported using EXPORT_SYMBOL rather than
EXPORT_SYMBOL_GPL (note I am aware of the legal issues surrounding
this and won't be distributing the resulting kernel or source).  I've
then patched the nVidia driver source, replacing atomic_spinlock with
raw_spinlock, down/up with mutex_lock/mutex_unlock and semaphores with
mutexes.

The resulting system runs and has quite good RT performance (max
latency <20us reported by cyclictest, at least on short tests with
full Ubuntu desktop running).  However, the performance of X is dire -
I get about two screen updates per second.  The mouse still moves
smoothly, but everything else only updates once or twice per second.
It seems to be something quite far down the graphics processing chain
that is slow, not individual operations - for instance, opening a page
in Firefox doesn't take much longer than usual, it's just that I get
no response at all for nearly a second and then the rendered page
appears.  It's like the screen is rendered into a buffer very fast but
then flipping that buffer to the display is very slow.

Does anyone have any suggestions for what might cause this or tools
for tracking down where the problem comes from?  I've spent a couple
of days googling now with no success.

Thanks for any help,
Tom
