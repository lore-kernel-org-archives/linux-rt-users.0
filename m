From: Dave Hylands <dhylands@gmail.com>
Subject: Re: regarding synchronization code
Date: Fri, 24 Sep 2010 22:16:50 -0700
Message-ID: <AANLkTi=Akj+pOSnh1AQDjY4UVQKquk6uOTKMWxOd=HCD@mail.gmail.com>
References: <AANLkTikhWVuL18zRcPTu2TcEQrv8Bpr4O0eafNsPgNjt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kernel-newbies <kernelnewbies@nl.linux.org>,
	Linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sri Ram Vemulpali <sri.ram.gmu06@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56681 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242Ab0IYFQy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 25 Sep 2010 01:16:54 -0400
Received: by qwh6 with SMTP id 6so2233711qwh.19
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Sep 2010 22:16:50 -0700 (PDT)
In-Reply-To: <AANLkTikhWVuL18zRcPTu2TcEQrv8Bpr4O0eafNsPgNjt@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sri,

On Fri, Sep 24, 2010 at 3:56 PM, Sri Ram Vemulpali wrote:
> Hi all,
>
> =A0I am encountering alot macros in the code. I did not understand wh=
at
> those macro means.
>
> =A0Can anyone explain them and the use of them putting them like that=
=2E
>
> =A0 "unlikely"

This has to do with branch prediction. If the architecture that you're
building for supports branch prediction then this provides a hint to
say that the following test is unlikely to pass, so the branch
prediction will be setup to take the likely path.

> =A0 "always_inline" =A0-- defined at the signature of the function.

Exactly what it says - always make the function an inline function.
The inline keyword is normally just a hint or suggestion to the
compiler, whereas the always_inline says that the function should
always be inlined, even if optimizations to perform function inlining
is disabled.
<http://gcc.gnu.org/onlinedocs/gcc-4.0.4/gcc/Function-Attributes.html>

> =A0 "inline" -- I know inline keyword in compiler is used to place th=
e
> code in to the caller function at the time of compiler, but why
> declared as macro

There are some CONFIG options which allow inline behaviour to be tweake=
d:
<http://cateee.net/lkddb/web-lkddb/OPTIMIZE_INLINING.html>

--=20
Dave Hylands
Shuswap, BC, Canada
http://www.DaveHylands.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
