From: jordan <triplesquarednine@gmail.com>
Subject: Re: rt for newbie
Date: Thu, 27 Oct 2011 15:01:51 -0400
Message-ID: <CAOcfFMyOZ5zu9NgS4tdw8eVm0fU88R6rtOmODNN5mRAAwuAHew@mail.gmail.com>
References: <CADZpk3tRdH2uPw-Kq_qiowThtBicqP=0S-=knvgYCSNfUrY+kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: sashka@mail.ru
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52840 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab1J0TBw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Oct 2011 15:01:52 -0400
Received: by iaby12 with SMTP id y12so3225780iab.19
        for <linux-rt-users@vger.kernel.org>; Thu, 27 Oct 2011 12:01:52 -0700 (PDT)
In-Reply-To: <CADZpk3tRdH2uPw-Kq_qiowThtBicqP=0S-=knvgYCSNfUrY+kw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> =A0I'm new to rt-linux.Didn't know where to find answers for my
> questions. Hope this is right place.
> =A0When I started researching what are requirement for rt kernel, I
> found couple guides which somehow =A0were telling to do completely
> opposite things. =A0(for example: you need to disable acpi.. and anot=
her
> you need acpi for high frequency timer). Guides I found were for
> kernel 2.6.x and I see now there is 3.0 kernel and rt patch was
> rewritten, if I understood correctly.

What Linux distribution are you using? - for example, if you are using
Ubuntu, you can probably get an rt-kernel either from a PPA, or the
Kxstudio repositories. Archlinux has packages available in AUR (Arch
User Repository). Fedora should also have rt-kernels available through
Planet CCRMA.

> =A0Can you point me into right direction on how properly configure 3.=
0-rt.
> =A0Is 3.0-rt considered stable?

It's pretty stable over here;

[ninez@ninez ~]$ uname -a
Linux ninez 3.0-rt #1 SMP PREEMPT RT Sat Oct 22 11:44:07 EDT 2011
x86_64 AMD Phenom(tm) II X4 965 Processor AuthenticAMD GNU/Linux

I am using the last official release, linux-rt 3.0.7-rt20. it works
very well, although i had to patch the kernel to allow the proprietary
Nvidia driver to build and install properly. (this isn't included in
the RT patch, as it violates the GPL, and thus the patch cannot be
distributed).

I'm using Archlinux, and to 'point you in the right direction' as to
what needs to be enabled/disabled in the kernel .config ... i will
point you to the AUR for linux-rt. From there just download the
tarball. after unzipping it, you will see the latest rt-patches,
configs for x86 (labeled config) and x86_64 ...

https://aur.archlinux.org/packages.php?ID=3D51360

That PKGBUILD also has links to the kernel sources, but doesn't
include them in the tarball or anything. Arch's PKGBUILDs are like
gentoo's ebuild's , you run the script and it downloads the sources,
patches them, compiles it and installs it. (it does all the work).

I myself, haven't seen any tutorials for linux-rt 3.0 , but i if
someone else knows, i am sure they will pass along a link.

I would be surprised though, if you couldn't find RT already built,
assuming you are using one of the major distros.

cheerz
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
