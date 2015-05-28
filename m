From: Joakim Hernberg <jhernberg@alchemy.lu>
Subject: Re: [ANNOUNCE] 4.0.4-rt1
Date: Thu, 28 May 2015 10:33:00 +0200
Message-ID: <20150528103300.08717d25@tor.valhalla.alchemy.lu>
References: <20150519213923.GA26363@linutronix.de>
	<20150527114457.6d5ac8d5@balder.valhalla.alchemy.lu>
	<55659A14.3050904@autostatic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Jeremy Jongepier <jeremy@autostatic.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [94.247.172.109] ([94.247.172.109]:62652 "EHLO
	mailsafe.webbplatsen.se" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752728AbbE1InT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 May 2015 04:43:19 -0400
In-Reply-To: <55659A14.3050904@autostatic.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 27 May 2015 12:19:00 +0200
Jeremy Jongepier <jeremy@autostatic.com> wrote:

> On 05/27/2015 11:44 AM, Joakim Hernberg wrote:
> > On Tue, 19 May 2015 23:39:23 +0200
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >=20
> >> Dear RT folks!
> >>
> >> I'm pleased to announce the v4.0.4-rt1 patch set.
> >=20
> > I see the following trying to build based on archlinux' default
> > config:
> >=20
> > jack@balder /home/jack/archaudio/linux-rt-new/src/linux-4.0 $ make
> >   CHK     include/config/kernel.release
> >   CHK     include/generated/uapi/linux/version.h
> >   CHK     include/generated/utsrelease.h
> >   CALL    scripts/checksyscalls.sh
> >   CHK     include/generated/compile.h
> > kernel/Makefile:133: *** No X.509 certificates found ***
> >   CHK     kernel/config_data.h
> >   CC [M]  sound/soc/intel/sst/sst.o
> >   CC [M]  sound/soc/intel/sst/sst_ipc.o
> > In file included from include/linux/spinlock.h:300:0,
> >                  from include/linux/seqlock.h:35,
> >                  from include/linux/time.h:5,
> >                  from include/linux/stat.h:18,
> >                  from include/linux/module.h:10,
> >                  from sound/soc/intel/sst/sst.c:22:
> > sound/soc/intel/sst/sst.c: In function =E2=80=98sst_restore_shim64=E2=
=80=99:
> > include/linux/spinlock_rt.h:137:2: error: expected expression
> > before =E2=80=98do=E2=80=99 do {      \
> >   ^
> > sound/soc/intel/sst/sst.c:373:2: note: in expansion of macro
> > =E2=80=98spin_unlock_irqrestore=E2=80=99
> > spin_unlock_irqrestore(&ctx->ipc_spin_lock, irq_flags); ^
> > scripts/Makefile.build:258: recipe for target
> > 'sound/soc/intel/sst/sst.o' failed make[4]: ***
> > [sound/soc/intel/sst/sst.o] Error 1 make[4]: *** Waiting for
> > unfinished jobs.... LD      sound/soc/rockchip/built-in.o
> > scripts/Makefile.build:403: recipe for target 'sound/soc/intel/sst'
> > failed make[3]: *** [sound/soc/intel/sst] Error 2
> > scripts/Makefile.build:403: recipe for target 'sound/soc/intel'
> > failed make[2]: *** [sound/soc/intel] Error 2
> > make[2]: *** Waiting for unfinished jobs....
> > scripts/Makefile.build:403: recipe for target 'sound/soc' failed
> > make[1]: *** [sound/soc] Error 2
> > make[1]: *** Waiting for unfinished jobs....
> > Makefile:947: recipe for target 'sound' failed
> > make: *** [sound] Error 2
> > make: *** Waiting for unfinished jobs....
> >=20
> > It wasn't enough to disable CONFIG_SND_SOC_INTEL_SST, I had to
> > disable all of CONFIG_SND_SOC to be able to build it, here is a
> > link to the archlinux config changes for CONFIG_SND_SOC:
> > https://projects.archlinux.org/svntogit/packages.git/commit/trunk?h=
=3Dpackages/linux&id=3Dbd0bf646b706838518f1d104803495806249865e
> >=20
>=20
> Hello Joakim,
>=20
> Looks a lot like:
> http://www.spinics.net/lists/linux-rt-users/msg13403.html
>=20
> Jeremy
>=20

Yeah, fixing the typos allows it to build.  Strange that it built on
vanilla without fix though, but that's not important.  Thanks.

--=20

   Joakim
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
