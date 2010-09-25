From: Sri Ram Vemulpali <sri.ram.gmu06@gmail.com>
Subject: Re: regarding synchronization code
Date: Sat, 25 Sep 2010 13:04:53 -0400
Message-ID: <AANLkTikdH19K-0Hc7DDn2aa7O-eFcoNkaNu-QF3eq2jE@mail.gmail.com>
References: <AANLkTikhWVuL18zRcPTu2TcEQrv8Bpr4O0eafNsPgNjt@mail.gmail.com>
	<20100925084816.GA2946@michaelblizek.twilightparadox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kernel-newbies <kernelnewbies@nl.linux.org>,
	Linux-rt-users <linux-rt-users@vger.kernel.org>
To: Michael Blizek <michi1@michaelblizek.twilightparadox.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61135 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700Ab0IYREy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 25 Sep 2010 13:04:54 -0400
Received: by pvg2 with SMTP id 2so920490pvg.19
        for <linux-rt-users@vger.kernel.org>; Sat, 25 Sep 2010 10:04:53 -0700 (PDT)
In-Reply-To: <20100925084816.GA2946@michaelblizek.twilightparadox.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I am just saying I know inline keyword. But what is always_inline.

Thanks for replies and explanations. I got it now.

Regards,
Sri.

On Sat, Sep 25, 2010 at 4:48 AM, Michael Blizek
<michi1@michaelblizek.twilightparadox.com> wrote:
> Hi!
>
> On 18:56 Fri 24 Sep =C2=A0 =C2=A0 , Sri Ram Vemulpali wrote:
>> Hi all,
>>
>> =C2=A0 I am encountering alot macros in the code. I did not understa=
nd what
>> those macro means.
>>
>> =C2=A0 Can anyone explain them and the use of them putting them like=
 that.
>>
>> =C2=A0 =C2=A0"unlikely"
>
> likely() and unlikely() are wrappers around gcc extensions to give hi=
nts about
> whether a given branch will likely be taken or not. When done correct=
ly, this
> can improve performance.
>
>> =C2=A0 =C2=A0"always_inline" =C2=A0-- defined at the signature of th=
e function.
>
> This can be used because "inline" is not always inlined. There should=
 be a gcc
> option which causes all inline code to be not inlined.
>
>> =C2=A0 =C2=A0"inline" -- I know inline keyword in compiler is used t=
o place the
>> code in to the caller function at the time of compiler, but why
>> declared as macro
>
> Where do you see inline declared as a macro?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-Michi
> --
> programing a layer 3+4 network protocol for mesh networks
> see http://michaelblizek.twilightparadox.com
>
>



--=20
Regards,
Sri.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
