From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH] rt-tests - allow build without NUMA
Date: Mon, 26 Sep 2011 13:16:19 -0700
Message-ID: <4E80DD93.3090908@am.sony.com>
References: <4E7CDD4B.2070202@am.sony.com>	<20110923194632.GT20550@pengutronix.de> <20110923160918.582041c8@redhat.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>,
	"Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:15826
	"EHLO DB3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752432Ab1IZUSZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Sep 2011 16:18:25 -0400
In-Reply-To: <20110923160918.582041c8@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 09/23/11 14:09, Clark Williams wrote:
> On Fri, 23 Sep 2011 21:46:32 +0200
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
>> On Fri, Sep 23, 2011 at 12:26:03PM -0700, Frank Rowand wrote:
>>>
>>>
>=20
>=20
> How about this?
>=20
> diff --git a/Makefile b/Makefile
> index 4f51154..4776391 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -14,7 +14,11 @@ bindir  ?=3D $(prefix)/bin
>  mandir ?=3D $(prefix)/share/man
>  srcdir ?=3D $(prefix)/src
> =20
> -NUMA   :=3D 1
> +machinetype =3D $(shell uname -m | \
> +    sed -e 's/i.86/i386/' -e 's/mips.*/mips/' -e 's/ppc.*/powerpc/')
> +ifneq ($(filter x86_64 i386 ia64 mips powerpc,$(machinetype)),)
> +NUMA   :=3D 1
> +endif
> =20
>  CFLAGS =3D -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include
> =20
> @@ -26,7 +30,7 @@ else
>         CFLAGS  +=3D -O0 -g
>  endif
> =20
> -ifdef NUMA
> +ifeq ($(NUMA),1)
>         CFLAGS +=3D -DNUMA
>         NUMA_LIBS =3D -lnuma
>  endif

That works for me.

The change from Uwe doesn't solve the NUMA issue for me because I
cross-compile, but I am quite happy to type:

   make NUMA=3D0 CC=3D"${CROSS_COMPILE}gcc"

which does solve the NUMA issue for me.

-Frank

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
