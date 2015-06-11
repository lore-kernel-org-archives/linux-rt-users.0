From: =?UTF-8?B?U3TDqXBoYW5lIGFuY2Vsb3Q=?= <sancelot@numalliance.com>
Subject: Re: rt patch
Date: Thu, 11 Jun 2015 10:51:52 +0200
Message-ID: <55794C28.60505@numalliance.com>
References: <5576FC70.8050908@numalliance.com>	<CABgxDo+cC7n8AbWvuwRrUWj-08DvtApL78OsqX66gN7U519iXA@mail.gmail.com>	<5577DCE0.3000805@numalliance.com>	<CABgxDoJdNJMc3tE1=pzhP-=VsSB6irPT7q3_CPJpJJuGwSwRmA@mail.gmail.com>	<5577E019.6030106@numalliance.com>	<20150610144047.GB31886@zipoli.ccur.com>	<00f101d0a394$d66f73a0$834e5ae0$@pont@sdcsystems.com>	<55792961.8080002@numalliance.com> <20150611101937.07d65235@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Ralf Mardorf <ralf.mardorf@alice-dsl.net>,
	linux-rt users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.numalliance.com ([83.206.84.204]:36721 "EHLO
	mail.numalliance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772AbbFKIwD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jun 2015 04:52:03 -0400
In-Reply-To: <20150611101937.07d65235@archlinux>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/06/2015 10:19, Ralf Mardorf wrote:
> On Thu, 11 Jun 2015 08:23:29 +0200, St=C3=A9phane ancelot wrote:
>> can you give me working md5sum of files downloaded ?
>
> "These checksums are NOT intended to replace the web of trust. It is
> merely a way for someone to quickly verify whether contents on one of
> the many kernel.org mirrors match the contents on the master mirror.
> While you may use them to quickly verify whether what you have
> downloaded matches what we have on our central storage system, you
> should still use the GPG web of trust to verify whether the release
> tarball actually matches what the kernel developer published." -
> https://www.kernel.org/category/signatures.html
>
> Begin forwarded message:
>
> Date: Thu, 11 Jun 2015 01:25:50 +0200 (CEST)
> From: Thomas Gleixner
> To: St=C3=A9phane ancelot
> Cc: Romain Perier, linux-rt-users@vger.kernel.org
> Subject: Re: rt patch
>
> [snip]
>
>> here is an example with linux-3.18.13 and patch 3.18.13-rt10:
>> 3.18.13-rt10
>>
>> zcat ../patches-3.18.13-rt10.tar.gz |patch -p1 --dry-run
>
> You are trying to apply a tarball of patches instead of a single
> combined patch. Use patch-3.18.13-rt10.gz instead.
> [snip]
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
Ok, I checked,

signatures are right. files well downloaded.

I have always mistake while patching. software release problems?

unxz version 4.999.9beta
patch version 2.6
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
