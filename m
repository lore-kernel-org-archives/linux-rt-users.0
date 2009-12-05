From: Hector Perez Tijero <perezh@unican.es>
Subject: Re: Posix Execution time clock
Date: Fri, 04 Dec 2009 18:23:21 -0800
Message-ID: <4B19C419.2020204@unican.es>
References: <4B1508B5.7030202@unican.es> <20091201123228.GM3864@uudg.org>
	<20091202190845.GB22051@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ccserver2.unican.es ([130.206.5.101]:56402 "EHLO
	ccserver2.unican.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbZLECXu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Dec 2009 21:23:50 -0500
Received: from ccserver2.unican.es (ccserver2.unican.es [127.0.0.1])
	by ccserver2.unican.es (Postfix) with ESMTP id D03B8182A46
	for <linux-rt-users@vger.kernel.org>; Sat,  5 Dec 2009 03:23:50 +0100 (CET)
Received: from correo.unican.es (ccserver18.unican.es [130.206.5.18])by
	ccserver2.unican.es (Postfix) with ESMTP id C343A182A44for
	<linux-rt-users@vger.kernel.org>; Sat,  5 Dec 2009 03:23:50 +0100 (CET)
In-Reply-To: <20091202190845.GB22051@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

Just to complete the info. I have repeated a similar test (SMP and=20
scaling frequency disabled in the BIOS, TSC clock) with another functio=
n:

If I measure the attached function with CLOCK_THREAD_CPUTIME_ID, I keep=
=20
getting variable timing results. The execution of this function takes=20
about 400 usecs in my system. Having called it more than 10_000 times,=20
most of the measures are within 100 usecs from this value. This range=20
makes sense to me. But I have found a few measures (less than 10 out of=
=20
10_000) which are over 1100 usecs, which it's a bit suspicious. Since=20
this clock just takes the execution time associated to a single thread=20
(no preemption time should be included) and the function's execution=20
time could be considered as "constant", it seems that something is goin=
g=20
wrong with this kind of clock.

Any idea?

Thanks

Hector

PS: Ubuntu 2.6.24.-25-rt is based on 2.6.24.7-rt27 patch (link=20
<http://packages.ubuntu.com/hardy-updates/linux-restricted-modules-2.6.=
24-25-rt>)

void make_job ()
{
  long temp =3D 0;
  int index, index2 =3D 0;
  for (index =3D 0; index < 5000; index ++) {
     temp +=3D index;
     if (index%97 =3D=3D 0) {
       for (index2 =3D 0; index2 < 1000; index2 ++) {
          temp +=3Dindex;
       }
     }
  }
}

Uwe Kleine-K=F6nig escribi=F3:
> On Tue, Dec 01, 2009 at 10:32:28AM -0200, Luis Claudio R. Goncalves w=
rote:
>  =20
>> Along with that, the latest version for 2.6.24, IIRC, was 2.6.24.7-r=
t27.
>> So, it sounds like you are using older versions of old software.
>>    =20
> The version scheme of Ubuntu doesn't allow to read the used rt patch
> from the kernel version.  The Ubuntu version used is 2.6.24-25-rt.  T=
his
> only means something like:  The 25th Ubuntu revision of the 2.6.24
> kernel in the rt feature set.
>
> Best regards
> Uwe
>
>  =20
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
