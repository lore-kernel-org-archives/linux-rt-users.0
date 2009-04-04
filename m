From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: About "error mounting as ext3" when using 2.6.29-rt2 on
 Fedora.
Date: Sat, 4 Apr 2009 06:40:16 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0904040637480.12916@localhost.localdomain>
References: <49b7c2350904021920o1fbffeffn22b9fa7ea1365db1@mail.gmail.com> <49b7c2350904031904w7fd63cc9o2c0f700a879e217@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: GeunSik Lim <leemgs1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:46652 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973AbZDDEkZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 4 Apr 2009 00:40:25 -0400
In-Reply-To: <49b7c2350904031904w7fd63cc9o2c0f700a879e217@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 4 Apr 2009, GeunSik Lim wrote:

> I solved  mounting error  with "acpi=off  noapic nodma" options about
> below problem .
>  ( reference : ./linux-2.6.29-rt2/Documentation/x86/x86_64/boot-options.txt )

Ouch. That's not a real solution.

> Hope this helps for fedora users.
> This is kernel issues? In fact, I am not sure.

Hmm. You said the same kernel works fine on other distros, right ? Do
you use the same .config for the different distros. If not you could
try to build the kernel on fedora with the other-distro config.

Thanks,

	tglx
