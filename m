From: =?UTF-8?B?U3TDqXBoYW5lIGFuY2Vsb3Q=?= <sancelot@numalliance.com>
Subject: Re: rt patch
Date: Thu, 11 Jun 2015 13:26:54 +0200
Message-ID: <5579707E.3080902@numalliance.com>
References: <5576FC70.8050908@numalliance.com> <CABgxDo+cC7n8AbWvuwRrUWj-08DvtApL78OsqX66gN7U519iXA@mail.gmail.com> <5577DCE0.3000805@numalliance.com> <CABgxDoJdNJMc3tE1=pzhP-=VsSB6irPT7q3_CPJpJJuGwSwRmA@mail.gmail.com> <5577E019.6030106@numalliance.com> <20150610144047.GB31886@zipoli.ccur.com> <00f101d0a394$d66f73a0$834e5ae0$@pont@sdcsystems.com> <55792961.8080002@numalliance.com> <20150611101937.07d65235@archlinux> <55794C28.60505@numalliance.com> <55794FA1.20405@numalliance.com> <alpine.DEB.2.11.1506111256520.3786@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Mardorf <ralf.mardorf@alice-dsl.net>,
	linux-rt users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from num-trut.pck.nerim.net ([62.212.97.179]:58254 "EHLO
	mail.numalliance.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751786AbbFKL1D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jun 2015 07:27:03 -0400
In-Reply-To: <alpine.DEB.2.11.1506111256520.3786@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

THANKS GUYS IT IS SOLVED.

On 11/06/2015 13:03, Thomas Gleixner wrote:
> On Thu, 11 Jun 2015, St=C3=A9phane ancelot wrote:
>
>> Using a more recent system, I have following mistakes:
>> trying to patch a file not present in the kernel.
>> Sincerely, I do not understand what is the problem !
>
> Ok. This is the last attempt to help you. I told you before, that:
>
>>>>> zcat ../patches-3.18.13-rt10.tar.gz |patch -p1 --dry-run
>>>>
>>>> You are trying to apply a tarball of patches instead of a single
>>>> combined patch. Use patch-3.18.13-rt10.patch.gz instead.
>
> https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.1=
3-rt10.patch.gz
>
> This file can be applied with "patch -p1" after decompression.
>
> The tarball, which you are trying to use contains a series of patches
> and CANNOT be applied with patch.
>
> Thanks,
>
> 	tglx
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
