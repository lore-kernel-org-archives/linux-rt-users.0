From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [ANNOUNCE] 2.6.33-rc8-rt1
Date: Thu, 25 Feb 2010 06:46:19 +0900
Message-ID: <49b7c2351002241346g6b07f9b7u9d9ad67dc63c5b8f@mail.gmail.com>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <alpine.LFD.2.00.1002181748460.2811@localhost.localdomain>
	 <alpine.LFD.2.00.1002212322450.2811@localhost.localdomain>
	 <520f0cf11002220311l2a0caa83lf3ae2817b78501b6@mail.gmail.com>
	 <49b7c2351002231708r279049f9hcc9cc6ff205a47fb@mail.gmail.com>
	 <25891f3e1002231719u4d38ed52w99c66ac669c3d965@mail.gmail.com>
	 <49b7c2351002240643s1aebe384wee5ee7951e62640e@mail.gmail.com>
	 <alpine.LFD.2.00.1002241609050.4245@localhost.localdomain>
	 <49b7c2351002240852u3b2e7a56g1b0140d37a02c81f@mail.gmail.com>
	 <49b7c2351002240905n299f86fcq67a16fd97c47021@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dhaval Giani <dhaval.lists@thegianis.in>,
	John Kacur <jkacur@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Robin Gareus <robin@gareus.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Philippe Reynes <philippe.reynes@isismpp.fr>,
	Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>, Jan Blunck <jblunck@suse.de>,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	Jon Masters <jcm@redhat.com>,
	Mark Knecht <markknecht@gmail.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f174.google.com ([209.85.222.174]:64422 "EHLO
	mail-pz0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758098Ab0BXVqW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Feb 2010 16:46:22 -0500
In-Reply-To: <49b7c2351002240905n299f86fcq67a16fd97c47021@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> I will move rt number from v2.6.33-rc8-rt2 to v2.6.33-rc8-rt2.
oops. sorry. from v2.6.33-rc8-rt1 to v2.6.33-rc8-rt2.

On Thu, Feb 25, 2010 at 2:05 AM, GeunSik Lim <leemgs1@gmail.com> wrote:
> Thomas. Um. =C2=A0I checked new -rt tag now.
> I will move rt number from v2.6.33-rc8-rt2 to v2.6.33-rc8-rt2.
> And then, I will test v2.6.33-rc8-rt2 on my desktop pc
> 1) intel core2 quad Q6600 (SSD 64G , 2G DDR RAM )
> 2) intel core2 quad Q9400 (SATA 320G, 2G DDR RAM)
>
> Thanks,
> Geunsik Lim.
>
> On Thu, Feb 25, 2010 at 1:52 AM, GeunSik Lim <leemgs1@gmail.com> wrot=
e:
>> On Thu, Feb 25, 2010 at 12:09 AM, Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>>>> So, I tried linux-2.6.33-rc8-rt1 based on tip/rt/head as you expla=
ined.
>>>>
>>>> Git development branch:
>>>> =C2=A0 git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6=
-tip.git rt/head
>>> What's the sha1 of the head commit ?
>>> Thanks,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0tglx
>>>
>> Dear Thoomas,
>>
>> Below was the =C2=A0recent commit number =C2=A0when I typed "git clo=
ne" command.
>>
>> commit ed0799048b4a38ffb6e33755ba5e6b5dfa9a24d2
>> Author: Thomas Gleixner <tglx@linutronix.de>
>> Date: =C2=A0 Sun Feb 21 23:14:28 2010 +0100
>>
>> =C2=A0 =C2=A0v2.6.33-rt1
>>
>> =C2=A0 =C2=A0Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>
>> commit b635a77f9aadc5ed3fc5a949e3f219c24cdd254c
>> Author: Carsten Emde <C.Emde@osadl.org>
>> Date: =C2=A0 Sat Jan 16 17:14:04 2010 +0100
>>
>> =C2=A0 =C2=A0hwlat_detector-avoid-smp_processor_id.patch
>>
>> =C2=A0 =C2=A0Avoid smp_processor_id() in preemptible code.
>>
>> =C2=A0 =C2=A0Signed-off-by: Carsten Emde <C.Emde@osadl.org>
>> =C2=A0 =C2=A0Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 . . . . . . below omission=
 . . . . . .
>>
>>
>> and, version info is 2.6.33-rc8-rt1 as belows.
>>
>> [invain@localhost head]$ head Makefile
>> VERSION =3D 2
>> PATCHLEVEL =3D 6
>> SUBLEVEL =3D 33
>> EXTRAVERSION =3D -rc8-rt1
>> NAME =3D Man-Eating Seals of Antiquity
>>
>> # *DOCUMENTATION*
>> # To see a list of typical targets execute "make help"
>> # More info can be located in ./README
>> # Comments in this file are targeted only to the developer, do not
>>
>>
>> Thanks,
>> Geunsik Lim.
>>
>> --
>> Regards,
>> GeunSik Lim ( Samsung Electronics )
>> Blog : http://blog.naver.com/invain/
>> e-Mail: geunsik.lim@samsung.com
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 leemgs@gmail.com , leemgs1@gmail.=
com
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>>
>
>
>
> --
> Regards,
> GeunSik Lim ( Samsung Electronics )
> Blog : http://blog.naver.com/invain/
> e-Mail: geunsik.lim@samsung.com
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 leemgs@gmail.com , leemgs1@gmail.c=
om
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>



--=20
Regards,
GeunSik Lim ( Samsung Electronics )
Blog : http://blog.naver.com/invain/
e-Mail: geunsik.lim@samsung.com
           leemgs@gmail.com , leemgs1@gmail.com
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
