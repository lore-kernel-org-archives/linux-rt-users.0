From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: Building 4.9 RT kernel help
Date: Mon, 26 Dec 2016 21:40:46 +0100
Message-ID: <1482784846.9839.1.camel@alice-dsl.net>
References: <CAHS-zUEv6uBTR8yo9PPWvV8wEurG6ojaa9UjBT11yZ0abPEo6g@mail.gmail.com>
         <20161226212405.7758bea5@archlinux.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail79c50.megamailservers.eu ([91.136.10.89]:54064 "EHLO
        mail70c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755608AbcLZUkv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Dec 2016 15:40:51 -0500
Received: from archlinux.localdomain (x5ce0d10d.dyn.telefonica.de [92.224.209.13])
        (authenticated bits=0)
        by mail70c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id uBQKekgx019878
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Mon, 26 Dec 2016 20:40:48 +0000
In-Reply-To: <20161226212405.7758bea5@archlinux.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2016-12-26 at 21:24 +0100, Ralf Mardorf wrote:
> On Mon, 26 Dec 2016 15:01:01 -0500, Vasiliy Gagin wrote:
> > I was able to build plain kernel v4.9.
> > It builds v4.9-rt1 fine too, but fails when I try to install it.
> > 
> > console message is
> 
> Message of what?
> 
> Did you try to install packages, perhaps a linux package, before a
> linux-header package was installed?
> 
> > run-parts: executing /etc/kernel/postinst.d/dkms 4.9.0-rt1
> > /boot/vmlinuz-4.9.0-rt1
> > Error! Bad return status for module build on kernel: 4.9.0-rt1 (x86_64)
> > 
> > and there is following in make.log
> > 
> > KMS make.log for open-vm-tools-9.4.6 for kernel 4.9.0-rt1 (x86_64)
> > Mon Dec 26 14:09:03 EST 2016
> > /bin/sh: 1: test: -I./arch/x86/include: unexpected operator
> > Using standalone build system.
> > Makefile:167: Makefile.normal: No such file or directory
> > make[3]: *** No rule to make target 'Makefile.normal'.  Stop.
> > /bin/sh: 1: test: -I./arch/x86/include: unexpected operator
> > Using standalone build system.
> > Makefile:167: Makefile.normal: No such file or directory
> > make[3]: *** No rule to make target 'Makefile.normal'.  Stop.
> > 
> > I'm very new to the linux building process. Please Help
> 
> There seems to be a DKMS hook. DKMS fails to build kernel modules. The
> kernel itself and all other modules might be installed, just some
> custom modules perhaps failed to build.
> 
> I build 4.9-rt1 without issues and had also good luck with DKMS. It was
> able to build vbox modules.
> 
> $ ls -hAl /lib/modules/4.9.0-rt1-1-rt-presonus/kernel/misc/ total 688K
> -rw-r--r-- 1 root root 582K Dec 24 08:14 vboxdrv.ko
> -rw-r--r-- 1 root root  16K Dec 24 08:14 vboxnetadp.ko
> -rw-r--r-- 1 root root  41K Dec 24 08:14 vboxnetflt.ko
> -rw-r--r-- 1 root root  39K Dec 24 08:14 vboxpci.ko
> 
> However, sometimes DKMS can't build those modules, but then the kernel
> still could be used, just vbox doesn't work with this kernel.
> 
> In your case, KMS is something graphics related and you seemingly use
> VMware.

Hahaha :D, pardon, "KMS" most likely is from "DKMS", just the "K" is
missing. But, the rest still might be correct. Did you try to boot the
kernel? I suspect it is installed, just running VMware might fail.
Assuming just a header package wasn't installed, simply reinstall the
kernel package, after the the headers are installed, or run DKMS
manually from command line.

> Again, perhaps a linux-header package wasn't installed and after
> installing the linux package DMKS was missing headers.
> 
> Regards,
> Ralf
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
