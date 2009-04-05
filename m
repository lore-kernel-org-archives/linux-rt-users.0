From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: About "error mounting as ext3" when using 2.6.29-rt2 on
 Fedora.
Date: Sun, 5 Apr 2009 16:10:51 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0904051606170.747@localhost.localdomain>
References: <49b7c2350904021920o1fbffeffn22b9fa7ea1365db1@mail.gmail.com>  <49b7c2350904031904w7fd63cc9o2c0f700a879e217@mail.gmail.com>  <alpine.LFD.2.00.0904040637480.12916@localhost.localdomain>
 <49b7c2350904041951i2d984221qca33229dff6f0df4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: GeunSik Lim <leemgs1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:51079 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754549AbZDEOLA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Apr 2009 10:11:00 -0400
In-Reply-To: <49b7c2350904041951i2d984221qca33229dff6f0df4@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 5 Apr 2009, GeunSik Lim wrote:
> > Hmm. You said the same kernel works fine on other distros, right ? Do
> > you use the same .config for the different distros. If not you could
> > try to build the kernel on fedora with the other-distro config.
> Yes.
> I used the same kernel on various distros as I said previously.
> ( config file :
> http://leemgs1.googlecode.com/files/i386.2.6.29-rt2.ftrace.config-invain-invain.20090402)
> for example,
> At first,I built linux-2.6.29.rt2 kernel source.
> And then,  I tested
> kernel booting with this same kernel
> binary(ex:vmlinuz,Systemmap,initrd , /lib/modules/2.6.29.rt2) on other
> distros.

Ok, can you try the following ? Boot into fedora, copy the fedora
config file into your -rt build directory and enable preempt-rt on
it. Now build the kernel and install it with "make modules_install
install". Does this work ?

Thanks,

	tglx
