From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: version 0.37 of rt-tests available
Date: Thu, 30 Apr 2009 14:26:52 +0900
Message-ID: <49b7c2350904292226r5c130b3ct1c520f2c25fb01cc@mail.gmail.com>
References: <20090429155011.09e2218f@torg>
	 <49b7c2350904291830u79c827e6od323164fc19725e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:9182 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbZD3F0x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Apr 2009 01:26:53 -0400
Received: by yw-out-2324.google.com with SMTP id 5so949287ywb.1
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Apr 2009 22:26:52 -0700 (PDT)
In-Reply-To: <49b7c2350904291830u79c827e6od323164fc19725e6@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear Clark Willams.

It's strange. It seems that you did't run "#> git commit -a" command.

When I visited http://git.kernel.org/?p=3Dlinux/kernel/git/clrkwllms/rt=
-tests.git;a=3Dsummary
webpage, I can't find v0.37 related "diff" contents in the shortlog
table.

Please, Check "commit" command.
How about the others?

Thanks,
GeunSik Lim.

2009/4/30 GeunSik Lim <leemgs1@gmail.com>:
> Thank you for thinking about needs of the frace options using cyclict=
est.
>
> As you said, I think that most rt developers will need ftrace utility=
 based on
> command line for tuning internal kernel latencies in their complicate=
d
> realtime system.
>
> Maybe, If cyclictest is written by contribution of many developers su=
ccessfully,
> Most peoples will use this cyclictest utility generally.
> In special, Interested developers will make gui based
> cyclictest(ex:gcyclictest) utility
> additionally like gmplayer based on mplayer and tsclient based on rde=
sktop.
>
> So, I agree with your opinion absoultely.
>
> And, Clark Williams. Is a below remark right?
> This year is 2009 as you know.
> How about you modify =C2=A0date info from "(C) 2008-2008 " to "(C) 20=
08-2009".
> (Just my thinking...)
>
> I am happy because you append your name in cyclictest source code.
> In gerneal, When some developers want to send their patches and
> opinion, They often
> find author and maintainer from source code like me.
>
> < cyclictest source file>
> =C2=A0* High resolution timer test software *
> =C2=A0* (C) 2008-2008 Clark Williams <williams@redhat.com>
> =C2=A0* (C) 2005-2007 Thomas Gleixner <tglx@linutronix.de>
>
>
>
> 2009/4/30 Clark Williams <williams@redhat.com>:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>>
>> I've pushed 0.37 of the rt-tests up to my git repo at:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
>>
>> tarballs available at:
>>
>> http://www.kernel.org/pub/linux/kernel/people/clrkwllms/rt-tests/
>>
>> This version has a couple of fixes from GeunSik Lim
>> <geunsik.lim@samsung.com> (man page fixes and two new options for
>> wakeup and wakeup_rt tracing).
>>
>> After seeing that we have a never-ending stream of ftrace tracing
>> functions and options available to us, I decided that we need a bett=
er
>> way to specify the tracers. So I added the --tracer option (which
>> accepts the name of a tracing function) and the --traceopt option
>> (which accepts tracing options), e.g.:
>>
>> $ cyclictest -b 500 --tracer=3Devents --traceopts=3Dnoraw --traceopt=
s=3Dnohex
>>
>> I guess I could make traceopts take a comma separated list, but for =
now
>> it was just easier to allow multiple invocations on a command line.
>>
>> I've left the other tracing options alone for now, since I'm sure pe=
ople
>> have scripts that use them. I wouldn't mind getting rid of them in t=
he
>> future though.
>>
>> Clark
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v2.0.10 (GNU/Linux)
>>
>> iEYEARECAAYFAkn4vYoACgkQHyuj/+TTEp0eRgCgyJy7jg4o7qEGxqlwCoZRqwBq
>> Ct4An129sVkC7Md6fokUDpW8QOw03PPR
>> =3DHPJj
>> -----END PGP SIGNATURE-----
>>
>
>
>
> --
> Regards,
> GeunSik Lim
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
