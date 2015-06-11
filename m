From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: rt patch
Date: Thu, 11 Jun 2015 13:03:34 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1506111256520.3786@nanos>
References: <5576FC70.8050908@numalliance.com> <CABgxDo+cC7n8AbWvuwRrUWj-08DvtApL78OsqX66gN7U519iXA@mail.gmail.com> <5577DCE0.3000805@numalliance.com> <CABgxDoJdNJMc3tE1=pzhP-=VsSB6irPT7q3_CPJpJJuGwSwRmA@mail.gmail.com> <5577E019.6030106@numalliance.com>
 <20150610144047.GB31886@zipoli.ccur.com> <00f101d0a394$d66f73a0$834e5ae0$@pont@sdcsystems.com> <55792961.8080002@numalliance.com> <20150611101937.07d65235@archlinux> <55794C28.60505@numalliance.com> <55794FA1.20405@numalliance.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-871652265-1434020615=:3786"
Cc: Ralf Mardorf <ralf.mardorf@alice-dsl.net>,
	linux-rt users <linux-rt-users@vger.kernel.org>
To: =?ISO-8859-15?Q?St=E9phane_ancelot?= <sancelot@numalliance.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55937 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbbFKLET (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jun 2015 07:04:19 -0400
In-Reply-To: <55794FA1.20405@numalliance.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-871652265-1434020615=:3786
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 11 Jun 2015, Stéphane ancelot wrote:

> Using a more recent system, I have following mistakes:
> trying to patch a file not present in the kernel.
> Sincerely, I do not understand what is the problem !

Ok. This is the last attempt to help you. I told you before, that:

> > > > zcat ../patches-3.18.13-rt10.tar.gz |patch -p1 --dry-run
> > > 
> > > You are trying to apply a tarball of patches instead of a single
> > > combined patch. Use patch-3.18.13-rt10.patch.gz instead.

https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.13-rt10.patch.gz

This file can be applied with "patch -p1" after decompression.

The tarball, which you are trying to use contains a series of patches
and CANNOT be applied with patch.

Thanks,

	tglx

--8323329-871652265-1434020615=:3786--
