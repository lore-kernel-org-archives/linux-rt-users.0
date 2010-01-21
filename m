From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH]cyclictest: CFLAGS to support static compiliation with ARM
	Crosscompiler
Date: Thu, 21 Jan 2010 01:40:35 +0100
Message-ID: <520f0cf11001201640r4f1cf00ew3b4a4e9424c28602@mail.gmail.com>
References: <1246593855.2153.55.camel@centos51>
	 <1264032570.2121.4.camel@centos51>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	tglx <tglx@linutronix.de>
To: leemgs1@gmail.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:49124 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab0AUAkt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jan 2010 19:40:49 -0500
Received: by ewy1 with SMTP id 1so3733797ewy.28
        for <linux-rt-users@vger.kernel.org>; Wed, 20 Jan 2010 16:40:46 -0800 (PST)
In-Reply-To: <1264032570.2121.4.camel@centos51>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jan 21, 2010 at 1:09 AM, GeunSik Lim <leemgs1@gmail.com> wrote:
>
> Dear williams,
>
> This patch is for support static building using cross-compiler for
> embedded targetboard like ARM.
> When we use -static option for static binary on embedded board after
> patch.
> I tested various toolchain.(e.g: codesourcery toolchain , my self
> toolchain , cross-tool project's toolchain)
> Ref) Don't forget "-static" configuration(CFLAGS =A0+=3D -O2 -static)=
 in
> Makefile When you need static linking.
>
> Before patch)
> /usr/local/arm_v7_vfp_le/bin/../target/usr/lib/librt.a(timer_create.o=
):
> In function `timer_create':
> /home/build/BUILD/glibc-2.5.90/rt/../nptl/sysdeps/unix/sysv/linux/tim=
er_create.c:174: undefined reference to `pthread_attr_init'
> /home/build/BUILD/glibc-2.5.90/rt/../nptl/sysdeps/unix/sysv/linux/tim=
er_create.c:192: undefined reference to `pthread_attr_setdetachstate'
> /usr/local/arm_v7_vfp_le/bin/../target/usr/lib/librt.a(timer_routines=
=2Eo): In function `__start_helper_thread':
> /home/build/BUILD/glibc-2.5.90/rt/../nptl/sysdeps/unix/sysv/linux/tim=
er_routines.c:144: undefined reference to `pthread_attr_init'
> /home/build/BUILD/glibc-2.5.90/rt/../nptl/sysdeps/unix/sysv/linux/tim=
er_routines.c:145: undefined reference to `pthread_attr_setstacksize'
> /home/build/BUILD/glibc-2.5.90/rt/../nptl/sysdeps/unix/sysv/linux/tim=
er_routines.c:171: undefined reference to `pthread_attr_destroy'
> /home/build/BUILD/glibc-2.5.90/rt/../nptl/sysdeps/unix/sysv/linux/tim=
er_routines.c:175: undefined reference to `pthread_atfork'
> /usr/local/arm_v7_vfp_le/bin/../target/usr/lib/librt.a(timer_routines=
=2Eo): In function `timer_helper_thread':
> /home/build/BUILD/glibc-2.5.90/rt/../nptl/sysdeps/unix/sysv/linux/tim=
er_routines.c:114: undefined reference to `pthread_exit'
> collect2: ld returned 1 exit status
> make: *** [cyclictest] Error 1
>
>
> After patch) Success...
> Fedora11$> file ./cyclictest
> ./cyclictest: ELF 32-bit LSB executable, ARM, version 1 (SYSV),
> statically linked, for GNU/Linux 2.6.18, not stripped
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> >From 45e4dbeb8e7723cefa9117736b0ece5ea188ce6a Mon Sep 17 00:00:00 20=
01
> From: Geunsik Lim <geunsik.lim@samsung.com>
> Date: Thu, 21 Jan 2010 09:00:24 +0900
> Subject: [PATCH 2/2] bugfix: Support static linking(-static) with
> Crosscompiler on ARM targetboard.
>
> This patch is for support static building using cross-compiler for
> embedded targetboard like ARM.
> When we use -static option for static binary on embedded board after
> patch.
> I tested various toolchain.(e.g: codesourcery toolchain , my self
> toolchain , cross-tool project's toolchain)
> Ref) Don't forget "-static" configuration(CFLAGS =A0+=3D -O2 -static)=
 in
> Makefile When you need static linking.
>
> Signed-off-by: Geunsik Lim <geunsik.lim@samsung.com>
> ---
> =A0Makefile | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index e14d957..65f506a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3,7 +3,7 @@ VERSION_STRING =3D 0.61
> =A0TARGETS =A0 =A0 =A0 =A0=3D cyclictest signaltest pi_stress \
> =A0 =A0 =A0 =A0 =A0hwlatdetect rt-migrate-test ptsematest sigwaittest=
 svsematest \
> =A0 =A0 =A0 =A0 =A0sendme pip
> -LIBS =A0 =3D -lpthread -lrt
> +LIBS =A0 =3D -lrt -lpthread
> =A0EXTRA_LIBS ?=3D -ldl =A0 =A0 # for get_cpu
> =A0DESTDIR =A0 =A0 =A0 =A0?=3D
> =A0prefix =A0?=3D /usr/local
> --
> 1.6.2.5
>

Did you leave something out?

Thanks
John
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
