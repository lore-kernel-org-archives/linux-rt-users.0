From: Oleksandr Natalenko <pfactum@gmail.com>
Subject: Re: v2.6.21.4-rt11
Date: Sun, 10 Jun 2007 10:34:47 +0000 (UTC)
Message-ID: <loom.20070610T123332-722@post.gmane.org>
References: <20070609210507.GA29194@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:47983 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467AbXFJKkO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 10 Jun 2007 06:40:14 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HxKq2-0002rv-9V
	for linux-rt-users@vger.kernel.org; Sun, 10 Jun 2007 12:40:02 +0200
Received: from 62.68.95.23 ([62.68.95.23])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Sun, 10 Jun 2007 12:40:02 +0200
Received: from pfactum by 62.68.95.23 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Sun, 10 Jun 2007 12:40:02 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Ingo Molnar <mingo <at> elte.hu> writes:

>=20
>=20
> i'm pleased to announce the v2.6.21.4-rt11 kernel, which can be=20
> downloaded from the usual place:
>=20
>      http://people.redhat.com/mingo/realtime-preempt/
>=20
> more info about the -rt patchset can be found in the RT wiki:
>=20
>      http://rt.wiki.kernel.org
>=20
> -rt11 is a bit more experimental than usual: it includes the CFS=20
> scheduler. Several people have suggested the inclusion of CFS into th=
e=20
> -rt tree: the determinism of the CFS scheduler is a nice match to the=
=20
> determinism offered by PREEMPT_RT. The port of CFS to -rt was done by=
=20
> Dinakar Guniguntala. Tested on i686 and x86_64.
>=20
> to build a 2.6.21.4-rt11 tree, the following patches should be applie=
d:
>=20
>     http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.21.4.tar.bz2
>     http://people.redhat.com/mingo/realtime-preempt/patch-2.6.21.4-rt=
11
>=20
> 	Ingo
>=20

I've tried to compile it, but i've got the following:

  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
kernel/built-in.o: In function `__schedule':
(.sched.text+0xe0): undefined reference to `pick_next_task'
make[1]: *** [.tmp_vmlinux1] =D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 1
make[1]: Leaving directory `/usr/src/linux-2.6.21.4-rt11-cfs17-arsenic'
make: *** [debian/stamp-build-kernel] =D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=
=B0 2

It seems that patch is broken.
