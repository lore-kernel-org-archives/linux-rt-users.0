From: Clark Williams <williams@redhat.com>
Subject: Re: simulate load with cycletest
Date: Thu, 2 Feb 2017 13:08:58 -0600
Message-ID: <20170202130858.7dd64c4c@tagon.lan>
References: <CAJ2oMhKQkSsNqsmmJnnQ=JO9Haqoo4y10cg6JDFwAWVjt=YxnA@mail.gmail.com>
        <20170202145347.GT5599@jcartwri.amer.corp.natinst.com>
        <CAJ2oMhJJ+6u2azXh4OBHpLu2orfsOmZ412vbOChe9NVNwSW08A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/81Nbja7B6DO_x6rDXou.X9k"; protocol="application/pgp-signature"
Cc: Julia Cartwright <julia@ni.com>, linux-rt-users@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750934AbdBBTJJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 Feb 2017 14:09:09 -0500
In-Reply-To: <CAJ2oMhJJ+6u2azXh4OBHpLu2orfsOmZ412vbOChe9NVNwSW08A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/81Nbja7B6DO_x6rDXou.X9k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Feb 2017 18:48:41 +0200
Ran Shalit <ranshalit@gmail.com> wrote:

> On Thu, Feb 2, 2017 at 4:53 PM, Julia Cartwright <julia@ni.com> wrote:
> > On Thu, Feb 02, 2017 at 07:53:55AM +0200, Ran Shalit wrote: =20
> >> Hello, =20
> >
> > Hello Ran-
> > =20
> >> I have followed instruction for using cycletest in:
> >> https://rt.wiki.kernel.org/index.php/Cyclictest
> >>
> >> It described command lines for different scenarios.
> >> usually one with load and the next without load.
> >> Yet, I see no difference between the load 100% and no-load commands.
> >>
> >> How can you simulate load with cycletest ? =20
> >
> > cyclictest itself doesn't do any loading, it's common to run it with
> > some other processes in the background which generate a simulated load.
> >
> > Keep in mind that the using a utility like the ones I've listed below is
> > only _simulating_ what a load _might_ be like in a real application.
> > The best thing to do is to actually test your application.
> >
> >    - hackbench - scheduling load (nice because it's part of rt-tests)
> >    - stress - load-generating swiss-army knife
> >    - xfstests - disk / filesystem load
> >    - 'make -j' in a kernel source tree
> >    - iperf - network load
> >    - glxgears - gfx load
> >
> > (those are the ones that come to mind, there are others I'm forgetting)
> >
> >   Julia =20
>=20
> Hi Julia , Joakim , Kannan,
>=20
> Thank you very much for answering my question !

You might want to look at 'rteval', which runs hackbench and 'make -j' whil=
e running cyclictest. When the run duration is done it does some statistics=
 calculations on the cyclictest histogram.=20

https://git.kernel.org/cgit/linux/kernel/git/clrkwllms/rteval.git/

I'm looking at adding a 'stress' module to it as well.=20

/me takes note of the other loads that Julia listed...

Clark

--=20
The United States Coast Guard
Ruining Natural Selection since 1790

--Sig_/81Nbja7B6DO_x6rDXou.X9k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJYk4PKAAoJEBO1XdB8U7hR1cQQALuZ7kEZJOYAAWF54DLM3o4k
cmtkuEhvZCRzhJq0olAHCPMgAS//4+FVX6xIRHURWMqwMEvkq2+1egg2Yva32ZJ/
CnFlVmrKMBYOfGYaRUrwrOCQg82jfindbE2afKxdJU5pHmjcOmPWuAvOI8W/Zyyo
Qt7xnEAIKebDVZNwd0Jp3nMpE3vOV2el+HtuyGOOGXhy/r+D7cIAocBg1vP846/5
/qa7DW6t4cpsnuZ7JpcvsKOM4hbQi+IeESsKMHrp+igYY3gQFsmoukjqhs6Ax7/m
0DFOvFQt1J6lMkYoXx/I35tODO+7YqJtj0C/J/xnkpMJNXH6kvScaYocaOsNU3Jw
+W38hk3I3qjYP3bffUsnts0jAlFKpt7upXYCDHF/IbqiGIpqHRAVE0XMnMneaBVH
dNjQTpvMNVXfpO46scZ8QNffHdvxy5SlV+XfLRn7NlZI2MaVfsEWlqS/ngcjMZFk
QnnR+Zlt61dcFjQNdRrtf/6YWsZwSRHDJKZNVmuVvDBr7VxjvmHtEWYgqHm2MmU1
0Zm2IaOYS9YOoct6tQ/6F/VzCCXMTB/KefaGv4UueM+xXtJi9QIpg2rdbWRU+/ts
zpv+fKdbvQUUaOKsTCIGJm+a0OldAT/QVR0WfRrUo25Hm0NEQnOm3gm8wEbCNu0V
GV1OjriFDeZb3qXG3KLW
=jhiv
-----END PGP SIGNATURE-----

--Sig_/81Nbja7B6DO_x6rDXou.X9k--
