From: Aymeric <ejisneos@gmail.com>
Subject: Re: 2.6.26 freezes since rt13
Date: Fri, 30 Jan 2009 10:31:03 +0100
Message-ID: <4982C8D7.60304@gmail.com>
References: <4981AB45.8000202@gmail.com> <20090129142722.5825d4eb@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:11143 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839AbZA3JbH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 Jan 2009 04:31:07 -0500
Received: by nf-out-0910.google.com with SMTP id d3so69691nfc.21
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jan 2009 01:31:06 -0800 (PST)
In-Reply-To: <20090129142722.5825d4eb@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clark Williams =E3=81=95=E3=82=93=E3=81=AF=E6=9B=B8=E3=81=8D=E3=81=BE=E3=
=81=97=E3=81=9F:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On Thu, 29 Jan 2009 14:12:37 +0100
> Aymeric <ejisneos@gmail.com> wrote:
>
>  =20
>> I also wanted to ask why the patch you gave at the beginning of janu=
ary,
>> to make alsa_seq work, hasn't been applied to the official RT kernel=
,
>> even to the GIT one, because I systematically have to use it each ti=
me I
>> compile a new version of the RT patch.
>>
>>    =20
>
> It's in 2.6.26.8-rt14. Looks like it got lost in the shuffle for a bi=
t.=20
>  =20

Indeed. My mistake.

But the freezes are still here.
I don't know if it can be of any help, but here's what I get with dmesg=
=20
before:

Real Time Clock Driver v1.12ac
rtc: lost 13 interrupts
rtc: lost 10 interrupts
CE: hpet increasing min_delta_ns to 15000 nsec
rtc: lost 8 interrupts
rtc: lost 18 interrupts
CE: hpet increasing min_delta_ns to 22500 nsec

Those lines get erased when I restart the computer.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
