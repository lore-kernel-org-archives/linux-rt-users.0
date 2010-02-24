From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [ANNOUNCE] 2.6.33-rc8-rt1
Date: Thu, 25 Feb 2010 06:54:10 +0900
Message-ID: <49b7c2351002241354n32a614d4hc4d85f2d378b9b24@mail.gmail.com>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <alpine.LFD.2.00.1002181748460.2811@localhost.localdomain>
	 <alpine.LFD.2.00.1002212322450.2811@localhost.localdomain>
	 <520f0cf11002220311l2a0caa83lf3ae2817b78501b6@mail.gmail.com>
	 <49b7c2351002231708r279049f9hcc9cc6ff205a47fb@mail.gmail.com>
	 <25891f3e1002231719u4d38ed52w99c66ac669c3d965@mail.gmail.com>
	 <49b7c2351002240643s1aebe384wee5ee7951e62640e@mail.gmail.com>
	 <alpine.LFD.2.00.1002241609050.4245@localhost.localdomain>
	 <49b7c2351002240852u3b2e7a56g1b0140d37a02c81f@mail.gmail.com>
	 <alpine.LFD.2.00.1002241849490.4245@localhost.localdomain>
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
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62435 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757904Ab0BXVyL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Feb 2010 16:54:11 -0500
In-Reply-To: <alpine.LFD.2.00.1002241849490.4245@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Feb 25, 2010 at 2:52 AM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
> On Thu, 25 Feb 2010, GeunSik Lim wrote:
>> On Thu, Feb 25, 2010 at 12:09 AM, Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>> >> So, I tried linux-2.6.33-rc8-rt1 based on tip/rt/head as you expl=
ained.
>> >>
>> >> Git development branch:
>> >> =C2=A0 git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.=
6-tip.git rt/head
>> > What's the sha1 of the head commit ?
>> > Thanks,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0tglx
>> >
>> Dear Thoomas,
>>
>> Below was the =C2=A0recent commit number =C2=A0when I typed "git clo=
ne" command.
>>
>> commit ed0799048b4a38ffb6e33755ba5e6b5dfa9a24d2
>> Author: Thomas Gleixner <tglx@linutronix.de>
>> Date: =C2=A0 Sun Feb 21 23:14:28 2010 +0100
>>
>> =C2=A0 =C2=A0 v2.6.33-rt1
>
> So you cloned the rt/2.6.33 branch of tip. rt/head does not have
> release numbers. The version in the Makefile is simply
> 2.6.33-rc8-rt. rt/head is where development happens. When stuff seems
> stable I update rt/2.6.xx and bump the -rt version and tag it.
Thank you for explanation of the rt/*** branch meaning. :)
Currently, I am using the rt/2.6.33 branch
with "git checkout -b  v2.6.33-rc8-rt2 v2.6.33-rc8-rt2" command.

[invain@localhost 2.6.33]$ git branch
  master
  v2.6.33-rc8-rt1
* v2.6.33-rc8-rt2
[invain@localhost 2.6.33]$ pwd
/opt/rt/2.6.33

As I reported finally now is normal with -rc8-rt2.
*  Booting result of linux-2.6.33-rc8-rt2 on Q9400 PC. --> Passed.
http://picasaweb.google.com/leemgs/LinuxRelatedScreenshot#5441865625183=
643634
>
> Thanks,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tglx



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
