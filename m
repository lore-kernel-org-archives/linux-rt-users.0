From: rosea grammostola <rosea.grammostola@gmail.com>
Subject: Re: Intel i3 | i5 | i7 GPU and RT kernel
Date: Tue, 14 Sep 2010 18:28:05 +0200
Message-ID: <AANLkTi=jvMzc4rErgPbwoCe8po5bUO4-YMfzGFbGtgPP@mail.gmail.com>
References: <AANLkTin8j1A=N_ypaT3S0n4k+++EkpWjb1FZUWaZpcKh@mail.gmail.com>
	<AANLkTi=6Yc7GJa6eJ_=o6=fKymA3za-xsbM+v8GuX71m@mail.gmail.com>
	<AANLkTinBhPWLO3wjNC1fnwf-Uh3c5-KF2Nc0++hCRYnG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Mark Knecht <markknecht@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35966 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215Ab0INQ2G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Sep 2010 12:28:06 -0400
Received: by eyb6 with SMTP id 6so3188069eyb.19
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2010 09:28:05 -0700 (PDT)
In-Reply-To: <AANLkTinBhPWLO3wjNC1fnwf-Uh3c5-KF2Nc0++hCRYnG@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Sep 14, 2010 at 6:27 PM, Mark Knecht <markknecht@gmail.com> wro=
te:
> On Wed, Sep 8, 2010 at 4:43 PM, Mark Knecht <markknecht@gmail.com> wr=
ote:
>> On Wed, Sep 8, 2010 at 1:35 PM, rosea grammostola
>> <rosea.grammostola@gmail.com> wrote:
>>> Hi,
>>>
>>>
>>> How well is the integrated gpu of intel, working with RT kernels?
>>>
>>>
>>> \r
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-rt-=
users" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>>
>> Hi Rosea,
>> =A0 I'm just now in the process of getting my Gentoo box updated so
>> that I can try the RT kernel on my i5-661/DH55HC machine. I'll try t=
o
>> report back in the next day or two what my results are.
>>
>> =A0 From Sven's report it sounds like the results should be good.
>>
>> Cheers,
>> Mark
>>
> Rosea,
> =A0 As reported elsewhere I'm having no problems with the real-time
> kernel on my i5-661. I am using the RME HDSP9652 at sub-1mS delays an=
d
> seeing no xruns. I can certainly recommend the real-time kernel
> running on the i5-661.
>
> =A0 I am however having a HORRIBLE time with the Intel video driver o=
n
> both the real-time and standard kernel. I cannot recommend Intel
> graphics at this time which is unfortunate because months ago with
> earlier versions of the graphics driver things were fine but they see=
m
> to be in a less stable state at the time of this writing.
>
Thanks a lot for testing!
At this point I consider a i5 750 without IGP.

\r
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
