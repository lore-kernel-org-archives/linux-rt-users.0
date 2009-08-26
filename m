From: Raz <raziebe@gmail.com>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Wed, 26 Aug 2009 10:16:59 +0200
Message-ID: <5d96567b0908260116w2e1bcffeqb67f92d89b34b2c@mail.gmail.com>
References: <1250983671.5688.21.camel@raz> <1251021133.14003.172.camel@marge.simson.net>
	<alpine.DEB.1.10.0908251122020.26329@gentwo.org> <1251222993.7023.53.camel@marge.simson.net>
	<alpine.DEB.1.10.0908251402300.17963@gentwo.org> <1251227322.7538.1172.camel@twins>
	<4A943A00.9080609@nortel.com> <1251264700.7538.1178.camel@twins>
	<1251282598.3514.20.camel@raz> <1251273755.16910.16.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Zijlstra <peterz@infradead.org>,
	Chris Friesen <cfriesen@nortel.com>,
	Christoph Lameter <cl@linux-foundation.org>, riel@redhat.com,
	mingo@elte.hu, andrew motron <akpm@linux-foundation.org>,
	wiseman@macs.biu.ac.il, lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:57314 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbZHZIRT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Aug 2009 04:17:19 -0400
In-Reply-To: <1251273755.16910.16.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Aug 26, 2009 at 10:02 AM, Mike Galbraith<efault@gmx.de> wrote:
> On Wed, 2009-08-26 at 13:29 +0300, raz ben yehuda wrote:
>
>> OFFSCHED is bad name to my project. My project is called SOS =3D Ser=
vice
>> Oriented System.
>> SOS, has nothing to do with Real time.
>
> ??
>
> The paper you pointed me at maintains it's very much about realtime.
>
> <quote>
> This paper argues that OFFSCHED fits to the niche of Multiprocessors
> real time systems by partitioning a system to two; the operating syst=
em
> and OFFSCHED. OFFSHCED is a hybrid system. It is hybrid because it is
> both real time and still a regular Linux server. Real time is mainly
> achieved by the NMI characteristic and the CPU isolation. It is a hyb=
rid
> system because OFFSCHED scheduler interacts with the operating system=
=2E
> </quote>
>
> =A0 =A0 =A0 =A0-Mike.
>
>
Mike Hello
Correct. OFFSCHED has a real time facet that puts it in the SMP real
time system arena. it has other facets such as security and
monitoring. If you take a look at OFFSCHED-RTOP and OFFSCHED-SECURED
you will see that I can actually get information and change a system
properties  (very pool implementation so far, i am a bit tired...)
even if this kernel is not **accessible**.

Raz
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
