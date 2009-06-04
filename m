From: Grammostola Rosea <rosea.grammostola@gmail.com>
Subject: Re: realtime kernel for Debian
Date: Thu, 04 Jun 2009 11:28:57 +0200
Message-ID: <4A2793D9.308@gmail.com>
References: <f1357b430903280615u215182fan2e62581394174603@mail.gmail.com> <alpine.DEB.2.00.0903282331360.22173@wr-linux02> <49CF50D3.1080000@gmail.com> <49CFBDBE.5020408@gmail.com> <20090329185525.GB25154@pengutronix.de> <49CFC58D.4010803@gmail.com> <20090329195638.GA25453@pengutronix.de> <49DF05B6.6000603@gmail.com> <20090413195356.GA13942@pengutronix.de> <4A09CEBC.70207@gmail.com> <20090513093517.GA11278@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Debian Developers <debian-devel@lists.debian.org>,
	linux-rt-users@vger.kernel.org, 521893@bugs.debian.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpq2.gn.mail.iss.as9143.net ([212.54.34.165]:54226 "EHLO
	smtpq2.gn.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750885AbZFDJtM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Jun 2009 05:49:12 -0400
In-Reply-To: <20090513093517.GA11278@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Uwe Kleine-K=F6nig wrote:
> Hi,
>
>  =20
>>>> I was wondering about how far are we with implementing a RT kernel=
 in=20
>>>>  Debian... Some progress here? Would be nice.
>>>>    =20
>>>>        =20
>>> The patch I created that "fits" on Debian's vanilla kernel creates
>>> conflicts on the sources with the Debian patches.
>>> I hope to be able to clean that up by minimizing the -rt series (e.=
g.
>>> the first broken out patch consists usually of various bits from th=
e
>>> -tip tree that are (AFAIK) not all needed.)
>>>
>>> So just have some more patience.
>>>
>>>  =20
>>>      =20
>> How are things going? Just interest...
>>    =20
> Hhhm, well, I spottet a problem.  The thing is that linux-rt does man=
y
> deep changes in the kernel and I won't be able to support the harder
> problems.  And upstream probably won't help because the Debian rt-ker=
nel
> isn't a vanilla rt-kernel.  Moreover even the broken out rt-patch isn=
't
> nicely sorted (e.g. bisectable, some patches undo changes of other
> patches earier in the series etc. pp), so I fear the Debian kernel te=
am
> isn't filled with enthusiasm when asked to add an rt variant.
>
> I already thought about packaging debian-kernel + rt for Debian and
> vanilla-kernel + rt for a non-Debian package repository such that it'=
s
> easy for bug reporters to try out a vanilla kernel.  But that still n=
eeds
> more work.
>
> I currently investigate how the Debian kernel packages are created.  =
Any
> help is welcome.  Probably the first step will be to create a vanilla=
-rt
> package, but that wont be accepted to go into Debian main.
>
>  =20
Just trying to keep thinks a bit alive here ;)

How are things going Uwe?

Kind regards,

\r

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
