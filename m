From: Xavier Miller <xavier.miller@cauwe.org>
Subject: Re: Best gcc flags?
Date: Sat, 23 Jan 2010 21:11:34 +0100
Message-ID: <4B5B57F6.3050304@cauwe.org>
References: <5bdc1c8b1001221054g406baa9cp226a478be7342c0e@mail.gmail.com>	 <520f0cf11001221409t2eda34e6kae393afde012d6fc@mail.gmail.com> <5bdc1c8b1001221458j74d36fdbl3f154f8b539791dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Kacur <jkacur@redhat.com>, RT <linux-rt-users@vger.kernel.org>
To: Mark Knecht <markknecht@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:39842 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752636Ab0AWULf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Jan 2010 15:11:35 -0500
In-Reply-To: <5bdc1c8b1001221458j74d36fdbl3f154f8b539791dd@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Don't play with CFLAGS/LDFLAGS. -march=3Dnative will let GCC find the b=
est
(and most sable) options for your compiler.
Playing with unsafe CFLAGS/LDFLAGS will produce unstable system, hard t=
o
debug.

Kind regards,
Xavier Miller.

Le 22/01/10 23:58, Mark Knecht a =C3=A9crit :
> On Fri, Jan 22, 2010 at 2:09 PM, John Kacur <jkacur@redhat.com> wrote=
:
>> On Fri, Jan 22, 2010 at 7:54 PM, Mark Knecht <markknecht@gmail.com> =
wrote:
>>> Hi,
>>>   I've got a new Intel Core i5-661 machine that I'm loading Gentoo
>>> on. I wonder if anyone here has any strong opinion son the best gcc
>>> options for this sort of machine and specifically what makes for th=
e
>>> best rt performance?
>>>
>>
>> AFAIK, there are no -rt specific requirements for gcc, just use what=
 you
>> would normally use.
>>
>> John
>>
>=20
> Yes that's my understanding also, but this is a brand new machine to
> me, Gentoo based where I can set all my gcc flags pretty easily, and
> for the Core i5-661 I'm not finding much info on what's recommended
> for gcc. -march=3Dnative? Or maybe use specific settings such as thos=
e
> for an i7?
>=20
> I'm just grasping around for ideas mostly.
>=20
> Thanks!
>=20
> - Mark
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
