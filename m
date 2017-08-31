From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: kernel BUG at kernel/locking/rtmutex.c:1059
Date: Thu, 31 Aug 2017 16:54:35 +0200
Message-ID: <20170831145435.lgeod4vih3blevfw@linutronix.de>
References: <86val4928u.fsf@gaheris.avalon.lan>
 <CAAnMKKa2LiYMCr0v32Wnd6TzdpnfZ0qKcecaFp6vpT8gR6+fvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mart van de Wege <mvdwege@gmail.com>,
        linux-rt-users@vger.kernel.org
To: Pratyush Patel <pratyushpatel.1995@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:33453 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbdHaOyg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 31 Aug 2017 10:54:36 -0400
Content-Disposition: inline
In-Reply-To: <CAAnMKKa2LiYMCr0v32Wnd6TzdpnfZ0qKcecaFp6vpT8gR6+fvg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-08-31 16:29:54 [+0530], Pratyush Patel wrote:
> Hello,
Hi,

> I too faced a similar issue on startup when I ran v4.11.12-rt10 on a
> virtual QEMU-KVM setup with Arch Linux. The kernel panics when the
> Locking API test suite runs during the startup. I'm not sure if these
> could be related.

This recursive locking is done by the self-test with the same result. I
suggest you disable it.

Sebastian
