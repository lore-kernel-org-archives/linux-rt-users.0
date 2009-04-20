From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH] fix argument -C on cyclictest
Date: Mon, 20 Apr 2009 23:14:27 +0900
Message-ID: <49b7c2350904200714y30776380w9c6999e0e7822c88@mail.gmail.com>
References: <gsfer5$6sr$1@ger.gmane.org>
	 <20090419175218.GA22205@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trem <tremyfr@yahoo.fr>, linux-rt-users@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:30719 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755552AbZDTOO3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Apr 2009 10:14:29 -0400
Received: by yx-out-2324.google.com with SMTP id 3so781471yxj.1
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Apr 2009 07:14:28 -0700 (PDT)
In-Reply-To: <20090419175218.GA22205@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Uwe Kleine-Konig

I already submited same issues.  for example, --context  and --event.
Is your patch proposal is different?

Refer to  http://marc.info/?l=3Dlinux-rt-users&m=3D123919858213957&w=3D=
2 webpage.


Regards,
GeunSik Lim.


2009/4/20 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> Hi,
>
> On Sun, Apr 19, 2009 at 05:09:25PM +0200, trem wrote:
>> The argument -C isn't used in cyclictest, only --context is recogniz=
ed.
>>
>> Signed-off-by: trem <trem@mandriva.org>
>> ---
>> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest=
=2Ec
>> index f878217..e67d0d3 100644
>> --- a/src/cyclictest/cyclictest.c
>> +++ b/src/cyclictest/cyclictest.c
>> @@ -777,7 +777,7 @@ static void process_options (int argc, char *arg=
v[])
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0{"help", no_argument, NULL, '?'},
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0{NULL, 0, NULL, 0}
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int c =3D getopt_=
long (argc, argv, "a::b:Bc:d:fh:i:Il:nNo:p:Pmqrst::vD:",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int c =3D getopt_=
long (argc, argv, "a::b:Bc:Cd:fh:i:Il:nNo:p:Pmqrst::vD:",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0long_options, &option_index);
> After the commit log I would have expected that you remove C from the
> options list. =C2=A0I would suggest something like "make cyclictest a=
ccept -C
> as documented. =C2=A0This is the same as --context".
>
> BTW, I just noticed that both -C and --context don't appear in the ma=
n
> page.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Uwe Kleine-K=C3=B6=
nig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| http://www.pengutronix.de/ =C2=A0|
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
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
