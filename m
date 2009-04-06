From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: cyclictest - fix comparison about flexible word counts of
	available_tracers file.
Date: Mon, 6 Apr 2009 11:49:58 +0900
Message-ID: <49b7c2350904051949m3a52d270j912b56693683e27c@mail.gmail.com>
References: <49b7c2350904042345x574edfcbx553ba1caccb8bd06@mail.gmail.com>
	 <20090405095001.6dc50fbc@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:10348 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbZDFCuA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Apr 2009 22:50:00 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2044363wff.4
        for <linux-rt-users@vger.kernel.org>; Sun, 05 Apr 2009 19:49:58 -0700 (PDT)
In-Reply-To: <20090405095001.6dc50fbc@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear Clark

Thanks your patching.

Since I didn't have IRQSOFF or
> PREEMPTOFF set in my kernel, those tracers weren't available and fsca=
nf
> never returned EOF (it kept returning the "nop" tracer).

Clark. I think that Your approach is right.

In fact , I also thought  this case that  a developer disable
PREEMPTOFF or IRQSOFF on "#>make menuconfig" setting menu.
As you know, Most peoples will use -P or -I option when they enabled
PREEMPTOFF or IRQSOFF in Linux Kernel just.

But, Exception Handling is important as your explanation.
Thanks again.


2009/4/5 Clark Williams <williams@redhat.com>:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On Sun, 5 Apr 2009 15:45:33 +0900
> GeunSik Lim <leemgs1@gmail.com> wrote:
>
>> Dear Thomas,
>>
>> I found bug at settracer function of cyclictest.c source (rt-test ve=
r 0.33).
>> settracer func use 10 times in the for() statement to searching trac=
er
>> like preemptoff , irqsoff , preemptirqsoff.
>> But, I think that we have to consider 10+ words in the available_tra=
cers file.
>>
>
> GeunSik,
>
> Good catch! =C2=A0I applied your patch, but then found a bug in eithe=
r
> fscanf or debugfs (probably debugfs). Since I didn't have IRQSOFF or
> PREEMPTOFF set in my kernel, those tracers weren't available and fsca=
nf
> never returned EOF (it kept returning the "nop" tracer). So I reworke=
d
> your patch to read everything in and parse it using strtok(3).
>
> The git tree has been updated and an rt-tests-0.34.tar.gz tarball is
> available at:
>
> http://www.kernel.org/pub/linux//kernel/people/clrkwllms/rt-tests/
>
> Clark
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.10 (GNU/Linux)
>
> iEYEARECAAYFAknYxR4ACgkQHyuj/+TTEp3TNwCbBNrEHMLjPmAS6JciwjyXWqME
> wpcAn3+nUGdOwCJR6sFGfwundPtaITrk
> =3DdT+3
> -----END PGP SIGNATURE-----
>



--=20
Regards,
GeunSik Lim
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
