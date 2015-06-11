From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: rt patch
Date: Thu, 11 Jun 2015 10:19:37 +0200
Message-ID: <20150611101937.07d65235@archlinux>
References: <5576FC70.8050908@numalliance.com>
	<CABgxDo+cC7n8AbWvuwRrUWj-08DvtApL78OsqX66gN7U519iXA@mail.gmail.com>
	<5577DCE0.3000805@numalliance.com>
	<CABgxDoJdNJMc3tE1=pzhP-=VsSB6irPT7q3_CPJpJJuGwSwRmA@mail.gmail.com>
	<5577E019.6030106@numalliance.com>
	<20150610144047.GB31886@zipoli.ccur.com>
	<00f101d0a394$d66f73a0$834e5ae0$@pont@sdcsystems.com>
	<55792961.8080002@numalliance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail230c50.megamailservers.eu ([91.136.10.240]:49028 "EHLO
	mail37c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752267AbbFKITo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jun 2015 04:19:44 -0400
Received: from archlinux (x5ce0d252.dyn.telefonica.de [92.224.210.82])
	(authenticated bits=0)
	by mail37c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id t5B8Jb5n003331
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Jun 2015 08:19:39 +0000
In-Reply-To: <55792961.8080002@numalliance.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 11 Jun 2015 08:23:29 +0200, St=C3=A9phane ancelot wrote:
>can you give me working md5sum of files downloaded ?

"These checksums are NOT intended to replace the web of trust. It is
merely a way for someone to quickly verify whether contents on one of
the many kernel.org mirrors match the contents on the master mirror.
While you may use them to quickly verify whether what you have
downloaded matches what we have on our central storage system, you
should still use the GPG web of trust to verify whether the release
tarball actually matches what the kernel developer published." -
https://www.kernel.org/category/signatures.html

Begin forwarded message:

Date: Thu, 11 Jun 2015 01:25:50 +0200 (CEST)
=46rom: Thomas Gleixner
To: St=C3=A9phane ancelot
Cc: Romain Perier, linux-rt-users@vger.kernel.org
Subject: Re: rt patch

[snip]

> here is an example with linux-3.18.13 and patch 3.18.13-rt10:
> 3.18.13-rt10
>=20
> zcat ../patches-3.18.13-rt10.tar.gz |patch -p1 --dry-run

You are trying to apply a tarball of patches instead of a single
combined patch. Use patch-3.18.13-rt10.gz instead.
[snip]
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
