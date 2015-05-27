From: Joakim Hernberg <jhernberg@alchemy.lu>
Subject: Re: [ANNOUNCE] 4.0.4-rt1
Date: Wed, 27 May 2015 11:44:57 +0200
Message-ID: <20150527114457.6d5ac8d5@balder.valhalla.alchemy.lu>
References: <20150519213923.GA26363@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150519213923.GA26363@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 19 May 2015 23:39:23 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Dear RT folks!
>=20
> I'm pleased to announce the v4.0.4-rt1 patch set.

I see the following trying to build based on archlinux' default config:

jack@balder /home/jack/archaudio/linux-rt-new/src/linux-4.0 $ make
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
kernel/Makefile:133: *** No X.509 certificates found ***
  CHK     kernel/config_data.h
  CC [M]  sound/soc/intel/sst/sst.o
  CC [M]  sound/soc/intel/sst/sst_ipc.o
In file included from include/linux/spinlock.h:300:0,
                 from include/linux/seqlock.h:35,
                 from include/linux/time.h:5,
                 from include/linux/stat.h:18,
                 from include/linux/module.h:10,
                 from sound/soc/intel/sst/sst.c:22:
sound/soc/intel/sst/sst.c: In function =E2=80=98sst_restore_shim64=E2=80=
=99:
include/linux/spinlock_rt.h:137:2: error: expected expression before =E2=
=80=98do=E2=80=99
  do {      \
  ^
sound/soc/intel/sst/sst.c:373:2: note: in expansion of macro =E2=80=98s=
pin_unlock_irqrestore=E2=80=99
  spin_unlock_irqrestore(&ctx->ipc_spin_lock, irq_flags);
  ^
scripts/Makefile.build:258: recipe for target 'sound/soc/intel/sst/sst.=
o' failed
make[4]: *** [sound/soc/intel/sst/sst.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  LD      sound/soc/rockchip/built-in.o
scripts/Makefile.build:403: recipe for target 'sound/soc/intel/sst' fai=
led
make[3]: *** [sound/soc/intel/sst] Error 2
scripts/Makefile.build:403: recipe for target 'sound/soc/intel' failed
make[2]: *** [sound/soc/intel] Error 2
make[2]: *** Waiting for unfinished jobs....
scripts/Makefile.build:403: recipe for target 'sound/soc' failed
make[1]: *** [sound/soc] Error 2
make[1]: *** Waiting for unfinished jobs....
Makefile:947: recipe for target 'sound' failed
make: *** [sound] Error 2
make: *** Waiting for unfinished jobs....

It wasn't enough to disable CONFIG_SND_SOC_INTEL_SST, I had to disable =
all of CONFIG_SND_SOC to be able to build it, here is a link to the arc=
hlinux config changes for CONFIG_SND_SOC: https://projects.archlinux.or=
g/svntogit/packages.git/commit/trunk?h=3Dpackages/linux&id=3Dbd0bf646b7=
06838518f1d104803495806249865e

--=20

   Joakim
