From: Mark Knecht <markknecht@gmail.com>
Subject: Re: Intel i3 | i5 | i7 GPU and RT kernel
Date: Tue, 14 Sep 2010 09:37:28 -0700
Message-ID: <AANLkTin8ccsibz9gQ1pFO5Vp5n0zorTQ02kXQhAJEGvG@mail.gmail.com>
References: <AANLkTin8j1A=N_ypaT3S0n4k+++EkpWjb1FZUWaZpcKh@mail.gmail.com>
	<AANLkTi=6Yc7GJa6eJ_=o6=fKymA3za-xsbM+v8GuX71m@mail.gmail.com>
	<AANLkTinBhPWLO3wjNC1fnwf-Uh3c5-KF2Nc0++hCRYnG@mail.gmail.com>
	<AANLkTi=jvMzc4rErgPbwoCe8po5bUO4-YMfzGFbGtgPP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: rosea grammostola <rosea.grammostola@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:40227 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671Ab0INQh3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Sep 2010 12:37:29 -0400
Received: by wwb18 with SMTP id 18so149847wwb.1
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2010 09:37:28 -0700 (PDT)
In-Reply-To: <AANLkTi=jvMzc4rErgPbwoCe8po5bUO4-YMfzGFbGtgPP@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Sep 14, 2010 at 9:28 AM, rosea grammostola
<rosea.grammostola@gmail.com> wrote:
> On Tue, Sep 14, 2010 at 6:27 PM, Mark Knecht <markknecht@gmail.com> w=
rote:
>> On Wed, Sep 8, 2010 at 4:43 PM, Mark Knecht <markknecht@gmail.com> w=
rote:
>>> On Wed, Sep 8, 2010 at 1:35 PM, rosea grammostola
>>> <rosea.grammostola@gmail.com> wrote:
>>>> Hi,
>>>>
>>>>
>>>> How well is the integrated gpu of intel, working with RT kernels?
>>>>
>>>>
>>>> \r
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-rt=
-users" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info=
=2Ehtml
>>>>
>>>
>>> Hi Rosea,
>>> =C2=A0 I'm just now in the process of getting my Gentoo box updated=
 so
>>> that I can try the RT kernel on my i5-661/DH55HC machine. I'll try =
to
>>> report back in the next day or two what my results are.
>>>
>>> =C2=A0 From Sven's report it sounds like the results should be good=
=2E
>>>
>>> Cheers,
>>> Mark
>>>
>> Rosea,
>> =C2=A0 As reported elsewhere I'm having no problems with the real-ti=
me
>> kernel on my i5-661. I am using the RME HDSP9652 at sub-1mS delays a=
nd
>> seeing no xruns. I can certainly recommend the real-time kernel
>> running on the i5-661.
>>
>> =C2=A0 I am however having a HORRIBLE time with the Intel video driv=
er on
>> both the real-time and standard kernel. I cannot recommend Intel
>> graphics at this time which is unfortunate because months ago with
>> earlier versions of the graphics driver things were fine but they se=
em
>> to be in a less stable state at the time of this writing.
>>
> Thanks a lot for testing!
> At this point I consider a i5 750 without IGP.
>
> \r
>

Check out this page for specs.

http://www.intel.com/consumer/products/processors/corei5-specs.htm

If you're considering the i5-750 then maybe as an alternative the
i5-670 in a motherboard that doesn't use IGP and a good Nvidia
graphics card would be a good alternative. The 670 has a higher clock
rate and the turbo boost really moves you up. I only see lower cache
which is typical of the hyperthreaded designs as you really get
2MB/core.

The 670 wasn't available when I bought my 661 or likely I would have
gotten that one. The 661 price at NewEgg is about the same as the 750.
The 670 is, unfortunately, $100 more. (Sorry!) ;-)

i5-750 =3D $195
i5-670 =3D $299
i5-661 =3D $209

Have fun and don't using Intel stock cooling! :-)

- Mark
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
