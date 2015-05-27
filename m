From: Jeremy Jongepier <jeremy@autostatic.com>
Subject: Re: [ANNOUNCE] 4.0.4-rt1
Date: Wed, 27 May 2015 12:19:00 +0200
Message-ID: <55659A14.3050904@autostatic.com>
References: <20150519213923.GA26363@linutronix.de> <20150527114457.6d5ac8d5@balder.valhalla.alchemy.lu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WWw5ikUfHJIQKc7LLhmFidIvRB2rVJNDl"
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150527114457.6d5ac8d5@balder.valhalla.alchemy.lu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WWw5ikUfHJIQKc7LLhmFidIvRB2rVJNDl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/27/2015 11:44 AM, Joakim Hernberg wrote:
> On Tue, 19 May 2015 23:39:23 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>=20
>> Dear RT folks!
>>
>> I'm pleased to announce the v4.0.4-rt1 patch set.
>=20
> I see the following trying to build based on archlinux' default config:=

>=20
> jack@balder /home/jack/archaudio/linux-rt-new/src/linux-4.0 $ make
>   CHK     include/config/kernel.release
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
> kernel/Makefile:133: *** No X.509 certificates found ***
>   CHK     kernel/config_data.h
>   CC [M]  sound/soc/intel/sst/sst.o
>   CC [M]  sound/soc/intel/sst/sst_ipc.o
> In file included from include/linux/spinlock.h:300:0,
>                  from include/linux/seqlock.h:35,
>                  from include/linux/time.h:5,
>                  from include/linux/stat.h:18,
>                  from include/linux/module.h:10,
>                  from sound/soc/intel/sst/sst.c:22:
> sound/soc/intel/sst/sst.c: In function =E2=80=98sst_restore_shim64=E2=80=
=99:
> include/linux/spinlock_rt.h:137:2: error: expected expression before =E2=
=80=98do=E2=80=99
>   do {      \
>   ^
> sound/soc/intel/sst/sst.c:373:2: note: in expansion of macro =E2=80=98s=
pin_unlock_irqrestore=E2=80=99
>   spin_unlock_irqrestore(&ctx->ipc_spin_lock, irq_flags);
>   ^
> scripts/Makefile.build:258: recipe for target 'sound/soc/intel/sst/sst.=
o' failed
> make[4]: *** [sound/soc/intel/sst/sst.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
>   LD      sound/soc/rockchip/built-in.o
> scripts/Makefile.build:403: recipe for target 'sound/soc/intel/sst' fai=
led
> make[3]: *** [sound/soc/intel/sst] Error 2
> scripts/Makefile.build:403: recipe for target 'sound/soc/intel' failed
> make[2]: *** [sound/soc/intel] Error 2
> make[2]: *** Waiting for unfinished jobs....
> scripts/Makefile.build:403: recipe for target 'sound/soc' failed
> make[1]: *** [sound/soc] Error 2
> make[1]: *** Waiting for unfinished jobs....
> Makefile:947: recipe for target 'sound' failed
> make: *** [sound] Error 2
> make: *** Waiting for unfinished jobs....
>=20
> It wasn't enough to disable CONFIG_SND_SOC_INTEL_SST, I had to disable =
all of CONFIG_SND_SOC to be able to build it, here is a link to the archl=
inux config changes for CONFIG_SND_SOC: https://projects.archlinux.org/sv=
ntogit/packages.git/commit/trunk?h=3Dpackages/linux&id=3Dbd0bf646b7068385=
18f1d104803495806249865e
>=20

Hello Joakim,

Looks a lot like: http://www.spinics.net/lists/linux-rt-users/msg13403.ht=
ml

Jeremy


--WWw5ikUfHJIQKc7LLhmFidIvRB2rVJNDl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJVZZoVAAoJEF63J34m6LiU9PQP/11NPX6EGQi947tFJ+edRBt1
DritTCcQ4n3V5tZvN3a4VqfstOUQNNU3Rq07GhiL78Jk181ubBUUr4ECgL9TVXLO
Xbl26E/pBh6jvWh+KTV54af1hH5p4aukaV4aCk4cjltn0guGSqc/+HFX+2e6GAvP
P0REZ2jFs4Vr8EcqbCp3278Je25XSW/Nn2p8UMSLcgKcsqImEZpQTZRWU9jvq1hR
dlSyu0QT7QA0y40iITtJLgYzNLRuDJ9dmOwnYmG35vuoEOLRFzwadYsMPnQcM0sy
EFOqjzOsyaPYRbjM440Ynfxxk3eET+swGoM2RpPrxzRVSlpJ5trp26AJ44L3X07B
bzeFy/0XPR7IAk0rysC8fakpVdZlr+B6JH0SpuyxC8LOFogE6gFEKSd4qC7QJojj
686cLgybluvGGbFHKDvRkplauJhluBQalEyCINdne6wBPJ1zZf55MeZVQxHNsikJ
HOyVFa91B3mPC4T6pNPnF4/v02ud52DFKJqzYmqxxp/Ue6kvEFhAob0YzwEw5B1E
1PU77KXA4LoEp7Moc1X8ojf1E7NNdHnQX7h2yp96+pH06mkhqxXPSjazEfgWLKh0
3W63XsazpDGC7aOOPrWBsAhHPDP9O7svt0WdGfQe2LLSNkFyuv5t4tINiTK+lawo
n02w3X9o2RVZ1Ssz94vA
=EDF+
-----END PGP SIGNATURE-----

--WWw5ikUfHJIQKc7LLhmFidIvRB2rVJNDl--
