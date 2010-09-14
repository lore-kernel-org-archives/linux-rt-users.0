From: Mark Knecht <markknecht@gmail.com>
Subject: Re: Intel i3 | i5 | i7 GPU and RT kernel
Date: Tue, 14 Sep 2010 09:27:00 -0700
Message-ID: <AANLkTinBhPWLO3wjNC1fnwf-Uh3c5-KF2Nc0++hCRYnG@mail.gmail.com>
References: <AANLkTin8j1A=N_ypaT3S0n4k+++EkpWjb1FZUWaZpcKh@mail.gmail.com>
	<AANLkTi=6Yc7GJa6eJ_=o6=fKymA3za-xsbM+v8GuX71m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: rosea grammostola <rosea.grammostola@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33467 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464Ab0INQ1C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Sep 2010 12:27:02 -0400
Received: by eyb6 with SMTP id 6so3187420eyb.19
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2010 09:27:00 -0700 (PDT)
In-Reply-To: <AANLkTi=6Yc7GJa6eJ_=o6=fKymA3za-xsbM+v8GuX71m@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Sep 8, 2010 at 4:43 PM, Mark Knecht <markknecht@gmail.com> wrot=
e:
> On Wed, Sep 8, 2010 at 1:35 PM, rosea grammostola
> <rosea.grammostola@gmail.com> wrote:
>> Hi,
>>
>>
>> How well is the integrated gpu of intel, working with RT kernels?
>>
>>
>> \r
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>
> Hi Rosea,
> =C2=A0 I'm just now in the process of getting my Gentoo box updated s=
o
> that I can try the RT kernel on my i5-661/DH55HC machine. I'll try to
> report back in the next day or two what my results are.
>
> =C2=A0 From Sven's report it sounds like the results should be good.
>
> Cheers,
> Mark
>
Rosea,
   As reported elsewhere I'm having no problems with the real-time
kernel on my i5-661. I am using the RME HDSP9652 at sub-1mS delays and
seeing no xruns. I can certainly recommend the real-time kernel
running on the i5-661.

   I am however having a HORRIBLE time with the Intel video driver on
both the real-time and standard kernel. I cannot recommend Intel
graphics at this time which is unfortunate because months ago with
earlier versions of the graphics driver things were fine but they seem
to be in a less stable state at the time of this writing.

Hope this helps,
Mark
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
