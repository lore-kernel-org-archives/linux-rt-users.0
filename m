From: Bruce Ashfield <bruce.ashfield@gmail.com>
Subject: Re: RT on 2.6.34
Date: Fri, 8 Oct 2010 14:51:38 -0300
Message-ID: <AANLkTinLDKZVZk2trzN4B-s2Deo09Q_H4d4ejrA6huZk@mail.gmail.com>
References: <4CAC19EE.1010208@gmail.com>
	<20101008020925.GB14157@ubuntu.mshome.net>
	<87aampt8e0.fsf@eha.doredevelopment.dk>
	<20101008083700.GC14157@ubuntu.mshome.net>
	<4CAEFB8A.7090602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: walimis <walimisdev@gmail.com>,
	Esben Haabendal <eha@doredevelopment.dk>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44303 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932610Ab0JHRvj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Oct 2010 13:51:39 -0400
Received: by iwn6 with SMTP id 6so723649iwn.19
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Oct 2010 10:51:38 -0700 (PDT)
In-Reply-To: <4CAEFB8A.7090602@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Oct 8, 2010 at 8:07 AM, Sven-Thorsten Dietrich
<thebigcorporation@gmail.com> wrote:
> =A0On 10/08/2010 01:37 AM, walimis wrote:
>>
>> On Fri, Oct 08, 2010 at 10:07:35AM +0200, Esben Haabendal wrote:
>>>
>>> walimis<walimisdev@gmail.com> =A0writes:
>>>
>>>> On Tue, Oct 05, 2010 at 11:40:46PM -0700, Sven-Thorsten Dietrich w=
rote:
>>>>>
>>>>> If I read this correctly, WR ported RT to 2.6.34.
>>>>>
>>>>> Anyone out there to confirm?
>>>>
>>>> Yes, it's true.
>>>
>>> Ok, where do I download this from?
>>
>> there is a open source version of windriver kernel:
>> git://git.pokylinux.org/linux-2.6-windriver
>> please try "preempt_rt" branch.
>>
>
> Thanks.
>
> Just for clarity, does this mean you also have a non-open-source vers=
ion of
> the WR Linux Kernel?

Nope, there is the kernel that ships with the Wind River Linux product,=
 but
it is just as open source as any other maintained Linux kernel. The
source is available
with every copy of the product at release, and is also made available
through other channels as appropriate.

I maintain both the poky, and Wind River commercial kernel, so feel
free to contact me with any questions, technical or not.

Cheers,

Bruce


>
> Sven
>
>
>> walimis
>>>
>>> /Esben
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
"Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end"
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
