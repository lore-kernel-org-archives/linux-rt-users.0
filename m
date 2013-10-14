From: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@gmail.com>
Subject: Non-Preempt Test v1.01
Date: Mon, 14 Oct 2013 15:05:14 -0400
Message-ID: <525C406A.5050000@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="lS6hG23oIGNS4FIqLSM83tHIUXlRTSpDg"
Cc: lwn@lwn.net
To: linux-rt-users@vger.kernel.org, lttng-dev@lists.lttng.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:48614 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756607Ab3JNTFX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Oct 2013 15:05:23 -0400
Received: by mail-qc0-f179.google.com with SMTP id l4so5289448qcv.10
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Oct 2013 12:05:23 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lS6hG23oIGNS4FIqLSM83tHIUXlRTSpDg
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all !

I just released the Non-Preempt Test (npt) version 1.01 which is
available here: http://git.dorsal.polymtl.ca/?p=3Dnpt.git

The purpose of this tool is to simulate a small real-time system that
runs with a high priority without being stopped or preempted. To do so,
it first sets its environment (cpu affinity, RT scheduler, memory locked
into RAM with mlockall) and can optionally disable the local IRQs if
compiled with the right options (not defined by default).

The core of the application is a loop that calculates the time gap
between the start of two consecutive loops using the rdtsc asm
instruction, thus a similarity with the hwlat_detector kernel module for
kernel analysis. At the end of its execution, npt computes latencies
statistics for each loop and generates a histogram showing the different
latencies reached and the number of time it reached each one.

This tool can be used to analyse and identify overhead of different
realtime applications as we can compare the latencies in each loops and
thus identify the added latency from a "blank" run. It is released
LTTng-ready and can thus be easily traced. Next versions could include
other userspace tracers ability.

Feedback, collaborations and contributions are welcome!

Regards,
Rapha=EBl Beamonte


--lS6hG23oIGNS4FIqLSM83tHIUXlRTSpDg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSXEBvAAoJECV+8Ygg/tEowx8QAJJrYrd6LmhH4OMKlGer9vp8
M0Lj2tXDCuAS6fij8SdE3JAcv37zSP6+k12YHTZDjX3UjOIqPGMJSVgjw249zuYr
WIcFAcaNpEpZF3r3gNzsGDD/EbvM+HM7Sw5psed7VXSgq2a7v4C63kCVVKEzWsvy
jfmDLy2TeiD5WVKRjdEsFSQFASFflEV+NaewFEZNT5ApfJlcZfAOpY9tapU6r8z+
qHuQAeZ2DAEBz9+BNMpTKSVt4ycEeCdcGK0f9pwgfvI2wp3+TYsw/y6U+Cz8UMdQ
byRtCj7K2VDNqk8vXgBGAKV60NQSO6wu6VrRH1YA/50cjMxjaTPTjqlzur2hkGK8
PX6qM8k/oCs2sU1aDapV3cdn6DjIHva+c/dOgKkuQ8fQAS4WX4uXCJFXPrg4sIJ6
WiDoM4wIMNBScThn/ztHnZRlja0rSWM6a7v09QIOitY03QiYqDG+VSUYyKi3rcz0
rOZQ57Z6+89XLJOwZxe+UWkAPkwLg5w6xW+eHCcPuIEhG9+VnoiyeB8+k8r3o3po
7GZxzTyp8lGqtnwWkF0wE1MeVeLPr/3/OAVwai9J/3R+D9Rx0/f07r5Cfd16ma2+
9nbyQCd+8UAwBQTFjilWqfWFi2WAvxaBpQb4Bf7lcbOM9bDG4+OjF05zk320xD7r
rkmA4vPeNdf9T1R8xTW9
=rjm/
-----END PGP SIGNATURE-----

--lS6hG23oIGNS4FIqLSM83tHIUXlRTSpDg--
