From: Bruce Ashfield <bruce.ashfield@gmail.com>
Subject: Re: RT on 2.6.34
Date: Fri, 8 Oct 2010 16:01:03 -0300
Message-ID: <AANLkTikk14=DMaKp0QpXPTiWseJMX4xpMT+jfzGD08E5@mail.gmail.com>
References: <4CAC19EE.1010208@gmail.com>
	<20101008020925.GB14157@ubuntu.mshome.net>
	<87aampt8e0.fsf@eha.doredevelopment.dk>
	<20101008083700.GC14157@ubuntu.mshome.net>
	<C9FF0312D04B4FE5BB869BC1347021C0@e1705>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Madovsky <infos@madovsky.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:44987 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932444Ab0JHTBE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Oct 2010 15:01:04 -0400
Received: by pxi15 with SMTP id 15so276632pxi.19
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Oct 2010 12:01:04 -0700 (PDT)
In-Reply-To: <C9FF0312D04B4FE5BB869BC1347021C0@e1705>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Oct 8, 2010 at 3:20 PM, Madovsky <infos@madovsky.org> wrote:
>
> ----- Original Message ----- From: "walimis" <walimisdev@gmail.com>
> To: "Esben Haabendal" <eha@doredevelopment.dk>
> Cc: "Sven-Thorsten Dietrich" <thebigcorporation@gmail.com>; "linux-rt=
-users"
> <linux-rt-users@vger.kernel.org>
> Sent: Friday, October 08, 2010 4:37 AM
> Subject: Re: RT on 2.6.34
>
>
>> On Fri, Oct 08, 2010 at 10:07:35AM +0200, Esben Haabendal wrote:
>>>
>>> walimis <walimisdev@gmail.com> writes:
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
>> walimis
>>>
>>> /Esben
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
> why is it not in the official RT directory ?

Because it isn't official from the RT maintainers in any way shape or
form. It isn't applied on top of a stock 2.6.34 kernel context and has
been modified to work with a particular feature mix, and per board
deployment. In other words, the source comes along with our product,
but outside of that it isn't designed to be a pristine upstream, or dep=
loyed
outside of a specific configuration.

Hope that helps.

Bruce

> thanks
>
> Franck
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
