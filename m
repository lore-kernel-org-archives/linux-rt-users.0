From: "Braud Caroline" <Caroline.Braud@univ-lille1.fr>
Subject: Re: RT + comedi (dual boot ubuntu 9.10/debian 7.0)
Date: Mon, 14 Oct 2013 13:11:56 +0200
Message-ID: <3c67-525bd180-8f-4d3d4300@252202304>
References: <52554911.4020109@nnytech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: "Martin K" <martin@nnytech.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp02.univ-lille1.fr ([193.49.225.20]:52082 "EHLO
	smtp02.univ-lille1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652Ab3JNLMC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Oct 2013 07:12:02 -0400
in-reply-to: <52554911.4020109@nnytech.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 Thanks Martin K, I'll try that.


 =20
Le Mercredi 9 Octobre 2013 14:16 CEST, Martin K <martin@nnytech.net> a =
=C3=A9crit:=20
=20
> On 10/9/2013 3:47 AM, Braud Caroline wrote:
> >   Hello,
> >
> > I'm back with my old distribution and I decided not to touch it any=
more ...
> > I will install RT with a more recent distrib in a separate computer=
=2E
> >
> > Please can you advise me the most appropriate recent distribution t=
o use the RT kernel and comedi drivers ?
> > (if you have a step by step installation of the RT kernel, it would=
 be perfect !)
> >
> > Thanks,
> > Karo
> >  =20
> >
>=20
> Karo,
> Recently I started with a fresh installation of Kubuntu version 13.04
>=20
> I installed the source and header packages for the kernel version tha=
t=20
> came with 13.04. Also several packages were needed for building the =0D
> kernel on Ubuntu I did not rebuild this kernel or use this kernel=20
> version (keep reading).
> See:
> http://www.howtoforge.com/kernel_compilation_ubuntu
>=20
> 1. I then looked up the latest released RT patch set on kernel.org:
> https://www.kernel.org/pub/linux/kernel/projects/rt/3.10/
>=20
> 2. I downloaded
> https://www.kernel.org/pub/linux/kernel/projects/rt/3.10/patches-3.10=
=2E14-rt9.tar.bz2
>=20
> 3. And the corresponding linux version (3.10.14)
> https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.10.14.tar.bz2
>=20
> 4. I unzipped both, putting the patches directory into the linux sour=
ce dir
>=20
> 5. I installed quilt and applied the patch series (from the linux-x.x=
=2Ex/=20
> directory) using the command:
> quilt push -a
>=20
> 6. I copied the default kernel configuration from the stock linux=20
> version to use as a template:
> cp /boot/config-`uname -r` ./.config
>=20
> 7. Configure the kernel (enable RT PREEMPT)
> make menuconfig
>=20
> 8. Build the kernel
> make-kpkg clean
> fakeroot make-kpkg --initrd --append-to-version=3D-karo kernel_image=20
> kernel_headers
>=20
> 9. Install
> cd ../
> [look for kernel*dpkg here]
> dpkg -i ...
>=20
> 10. reboot and check to see if it worked.
>=20
> ---
> I welcome critique on my method. I am not a kernel developer.
>=20
> One question I have, and I'm sorry for being ignorant:
> - If I had wanted to apply the RT patch for linux 3.8.13.7, how do I =
get=20
> kernel source version 3.8.13.7?
> There is no release that I'm aware of for this version, and I was una=
ble=20
> to find this in the kernel git repository. Was I looking in the wrong=
 one?
>=20
> -
> Martin Klingensmith
>=20
>=20
=20
=20

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
