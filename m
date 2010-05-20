From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Subject: Re: PREEMPT_RT (2.6.33-rt17) disabled printk-to-console after console_init
Date: Thu, 20 May 2010 12:33:55 +0400
Message-ID: <201005201233.56877@zigzag.lvk.cs.msu.su>
References: <AANLkTimxLHngWamPvWt-htGoZ7Nub72rvJAnmGtw4Eqw@mail.gmail.com> <AANLkTinClrTDoXH4NPP2-SgSYH24ZTnqsop88aocdg4R@mail.gmail.com> <alpine.LFD.2.00.1005182143100.3368@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1005182143100.3368@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> > I could not get dmesg output to console/serial and
> > klogd(/var/log/messages) anymore with 2.6.33-rt17 _after_ the kernel
> > boot is done(on non-RT kernel it works fine). I made below changes it
> > starts to work again, however I'm unsure how safe the change is.
> > Please advise.
>
> Well, obviously it's unsafe if you remove safety checks. And if you
> care to look at the changelog of kernel/printk.c you'll find out why.

Hmm... did a quick look and could not find anything related there.
Could you please give a pointer?
