From: rosea grammostola <rosea.grammostola@gmail.com>
Subject: Re: realtime kernel for Debian
Date: Fri, 02 Oct 2009 23:04:39 +0200
Message-ID: <4AC66AE7.9080706@gmail.com>
References: <alpine.DEB.2.00.0903282331360.22173@wr-linux02> <49CF50D3.1080000@gmail.com> <49CFBDBE.5020408@gmail.com> <20090329185525.GB25154@pengutronix.de> <49CFC58D.4010803@gmail.com> <20090329195638.GA25453@pengutronix.de> <49DF05B6.6000603@gmail.com> <20090413195356.GA13942@pengutronix.de> <4A09CEBC.70207@gmail.com> <20090513093517.GA11278@pengutronix.de> <20091002202003.GB30475@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Debian Developers <debian-devel@lists.debian.org>,
	pkg-multimedia-maintainers@lists.alioth.debian.org,
	linux-rt-users@vger.kernel.org, 521893@bugs.debian.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f211.google.com ([209.85.219.211]:49589 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbZJBVHR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Oct 2009 17:07:17 -0400
Received: by ewy7 with SMTP id 7so1390997ewy.17
        for <linux-rt-users@vger.kernel.org>; Fri, 02 Oct 2009 14:07:20 -0700 (PDT)
In-Reply-To: <20091002202003.GB30475@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Uwe Kleine-K=F6nig wrote:
> Hello,
>
> On Wed, May 13, 2009 at 11:35:17AM +0200, Uwe Kleine-K=F6nig wrote:
>  =20
>> Hi,
>>
>>    =20
>>>>> I was wondering about how far are we with implementing a RT kerne=
l in=20
>>>>>  Debian... Some progress here? Would be nice.
>>>>>    =20
>>>>>          =20
>>>> The patch I created that "fits" on Debian's vanilla kernel creates
>>>> conflicts on the sources with the Debian patches.
>>>> I hope to be able to clean that up by minimizing the -rt series (e=
=2Eg.
>>>> the first broken out patch consists usually of various bits from t=
he
>>>> -tip tree that are (AFAIK) not all needed.)
>>>>
>>>> So just have some more patience.
>>>>
>>>>  =20
>>>>        =20
>>> How are things going? Just interest...
>>>      =20
>> Hhhm, well, I spottet a problem.  The thing is that linux-rt does ma=
ny
>> deep changes in the kernel and I won't be able to support the harder
>> problems.  And upstream probably won't help because the Debian rt-ke=
rnel
>> isn't a vanilla rt-kernel.  Moreover even the broken out rt-patch is=
n't
>> nicely sorted (e.g. bisectable, some patches undo changes of other
>> patches earier in the series etc. pp), so I fear the Debian kernel t=
eam
>> isn't filled with enthusiasm when asked to add an rt variant.
>>
>> I already thought about packaging debian-kernel + rt for Debian and
>> vanilla-kernel + rt for a non-Debian package repository such that it=
's
>> easy for bug reporters to try out a vanilla kernel.  But that still =
needs
>> more work.
>>    =20
> OK, the vanilla-kernel + rt is done.  See
>
> 	http://mid.gmane.org/20090926171218.GD13150@pengutronix.de
>
> for an announcment and=20
>
> 	http://www.pengutronix.de/software/linux-rt/debian_en.html
>
> for the documentation how to install it.
Looks like this is great news! Thanks for your time and effort Uwe!

\r

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
