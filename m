From: Mark Knecht <markknecht@gmail.com>
Subject: Re: Intel graphics and kernel RT failure
Date: Fri, 5 Jun 2009 08:30:05 -0700
Message-ID: <5bdc1c8b0906050830y23c9dde8u4b617b4bdac3a605@mail.gmail.com>
References: <695e1a650906041442q445109a2p5871a1ff9f1d3f5a@mail.gmail.com>
	 <alpine.LSU.2.00.0906050020110.8173@fbirervta.pbzchgretzou.qr>
	 <1244164487.27779.31.camel@quadrophenia.thebigcorporation.com>
	 <alpine.LSU.2.00.0906051706040.6401@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sven-Thorsten Dietrich <sven@thebigcorporation.com>,
	Hector Centeno <hcengar@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:39397 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbZFEPaD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Jun 2009 11:30:03 -0400
Received: by yw-out-2324.google.com with SMTP id 5so936898ywb.1
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Jun 2009 08:30:05 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.00.0906051706040.6401@fbirervta.pbzchgretzou.qr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jun 5, 2009 at 8:07 AM, Jan Engelhardt<jengelh@medozas.de> wrot=
e:
>
> On Friday 2009-06-05 03:14, Sven-Thorsten Dietrich wrote:
>>On Fri, 2009-06-05 at 00:21 +0200, Jan Engelhardt wrote:
>>>
>>> Cc'ing linux-rt. Mabye someone has a flash of an idea.
>>>
>>> On Thursday 2009-06-04 23:42, Hector Centeno wrote to Jan Engelhard=
t:
>>> >
>>> >I hope it is OK to contact you directly to this email. I've been
>>> >trying to use your 2.6.29 RT kernel for OpenSuse 11.1 and came acr=
oss
>>> >some problems related to the Intel graphics driver (I have a lapto=
p
>>> >with intel GMA 950). The problem seems to be related to the new in=
tel
>>> >driver development that is going on and that seems to affect older
>>> >hardware like mine. I get a constantly growing list of errors in
>>> >/var/log/mesages like these:
>>> >
>>
>>Try this patch:
>>
>>Signed-off-by: Sven-Thorsten Dietrich <sdietrich@suse.de>
>>
>>Index: b/arch/x86/mm/iomap_32.c
>>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>--- a/arch/x86/mm/iomap_32.c
>>+++ b/arch/x86/mm/iomap_32.c
>>@@ -38,7 +38,7 @@ void *kmap_atomic_prot_pfn(unsigned long
>>- =C2=A0 =C2=A0 =C2=A0idx =3D type + KM_TYPE_NR * smp_processor_id();
>>+ =C2=A0 =C2=A0 =C2=A0idx =3D type + KM_TYPE_NR * raw_smp_processor_i=
d();
>>@@ -69,7 +69,7 @@ void
>>- =C2=A0 =C2=A0 =C2=A0enum fixed_addresses idx =3D type + KM_TYPE_NR*=
smp_processor_id();
>>+ =C2=A0 =C2=A0 =C2=A0enum fixed_addresses idx =3D type + KM_TYPE_NR*=
raw_smp_processor_id();
>
> Yes, it does fix the problem. Enabling PAE and not having applied
> this patch also produces a working system for the original poster.
>
> My thought was that this function kmap_atomic_prot_pfn is not used,
> or used differently, under PAE. Could this be?

I have a system that's got an Intel chip on-board. It started failing
in strange ways when Gentoo decided that xorg-server-1.5 should go
stable and a newer version of the intel-video driver came along with
it. Searching around I found people saying turn on PAE, turn off PAE,
that it had nothing to do with PAE. I got the same failures on both
the standard and rt kernels. There are a number of bugs reported at
the Xorg site about this recent driver.

After 3 weeks of no MythTV on that machine I gave up and bought a
newer NVidia card. No problems since.

Just info.

cheers,
Mark
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
