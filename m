From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: rt patch
Date: Thu, 11 Jun 2015 01:25:50 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1506110123520.3786@nanos>
References: <5576FC70.8050908@numalliance.com> <CABgxDo+cC7n8AbWvuwRrUWj-08DvtApL78OsqX66gN7U519iXA@mail.gmail.com> <5577DCE0.3000805@numalliance.com> <CABgxDoJdNJMc3tE1=pzhP-=VsSB6irPT7q3_CPJpJJuGwSwRmA@mail.gmail.com> <5577E019.6030106@numalliance.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2140757472-1433978751=:3786"
Cc: Romain Perier <romain.perier@gmail.com>,
	linux-rt-users@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_ancelot?= <sancelot@numalliance.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54396 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbbFJX0N (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Jun 2015 19:26:13 -0400
In-Reply-To: <5577E019.6030106@numalliance.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2140757472-1433978751=:3786
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 10 Jun 2015, Stéphane ancelot wrote:

Please:
      - Do not top post
      - Trim your replies

> here is an example with linux-3.18.13 and patch 3.18.13-rt10:
> 3.18.13-rt10
> 
> zcat ../patches-3.18.13-rt10.tar.gz |patch -p1 --dry-run

You are trying to apply a tarball of patches instead of a single
combined patch. Use patch-3.18.13-rt10.gz instead.

Thanks,

	tglx
--8323329-2140757472-1433978751=:3786--
