From: Clark Williams <williams@redhat.com>
Subject: Re: Problem with hwlat detector in smp_processor_id()
Date: Mon, 10 Aug 2009 13:58:37 -0500
Message-ID: <20090810135837.5541a2dc@torg>
References: <4A55D53A.6040108@psysteme.de>
	<4A560069.6010602@osadl.org>
	<4A80299F.2040008@psysteme.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/EhI6w4e9xNMdWGoq26/HkMW"; protocol="application/pgp-signature"
Cc: linux-rt-users@vger.kernel.org,
	Carsten Emde <Carsten.Emde@osadl.org>
To: Wolfgang Steinwender <wolfgang@psysteme.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:58357 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbZHJS6y (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Aug 2009 14:58:54 -0400
In-Reply-To: <4A80299F.2040008@psysteme.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/EhI6w4e9xNMdWGoq26/HkMW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Aug 2009 16:07:27 +0200
Wolfgang Steinwender <wolfgang@psysteme.de> wrote:

> Carsten Emde wrote:
> > Does the attached patch help?
>=20
> Sorry for the late reply. I now switched to linux-2.6.29.6-rt23
> (which has the patch included) and verified that the problem is
> solved. Reverting the patch gives the problem again.
>=20
> Now the error messages have disappeared, but I really cannot
> tell if the test is doing something at all.
>=20
> Here's the output from running the python script from rt-tests-50:
> $> hwlatdetect --debug
> debugging prints turned on
> looking for modules
> module path: /lib/modules/2.6.29.6-rt23-pae-debug/kernel/drivers/misc
> checking
> /lib/modules/2.6.29.6-rt23-pae-debug/kernel/drivers/misc/hwlat_detector.ko
> not mounting debugfs
> test duration is 120s
> hwlatdetect:  test duration 120 seconds
>    parameters:
>         Latency threshold: 10us
>         Sample window:     1000000us
>         Sample width:      500000us
>      Non-sampling period:  500000us
>         Output File:       None
>=20
> Starting test
> Starting hardware latency detection for 120 seconds
> enabling detector module
> first attempt at enable
> detector module enabled
> disabling detector module
> first attempt at disable
> detector module disabled
> Hardware latency detection done (0 samples)
> test finished
> Max Latency: 0us
> Samples recorded: 0
> Samples exceeding threshold: 0
> not umounting debugfs
>=20
> The output from the hwlat_detector module is:
> hwlat_detector: version 1.0.0
>=20
> For me, the output "Samples recorded: 0" means that no samples have
> been read at all. Or do I misinterpret the output?

Wolfgang,

The kernel module behavior changed on me. Originally the smi_detector.ko
module just streamed sample data out, most of it being samples of zero
(meaning no gaps in time seen). When Jon re-worked it to use the
ring-buffer structure and renamed it to hwlat_detector.ko, he only
provides sample data if it exceeds the specified threshold.=20

So, long answer to a short question, yes you interpreted the output
correctly, there were no gaps in the TSC values read by the sampling
thread.=20

>=20
> It is also not possible for me to cat the sample entry
> when the module is enabled: "strace cat sample"
> just waits forever:
> open("sample", O_RDONLY|O_LARGEFILE)    =3D 3
> fstat64(3, {st_mode=3DS_IFREG|0444, st_size=3D0, ...}) =3D 0
> read(3,
>=20
> Is there anything else I can try?
>=20

Due to the change in behavior above, the hwlatdetect python script
now opens the "sample" entry with O_NDELAY and polls that descriptor.=20

Clark

--Sig_/EhI6w4e9xNMdWGoq26/HkMW
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkqAbeIACgkQHyuj/+TTEp1rNQCgr5lMNxPaPz2LikuW5FTO4WBa
N8sAoJESr4NLSgR0+UHbjOx8O7a2EO/Y
=AfGR
-----END PGP SIGNATURE-----

--Sig_/EhI6w4e9xNMdWGoq26/HkMW--
