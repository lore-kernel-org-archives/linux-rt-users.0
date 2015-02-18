From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: kernel BUG at /build/linux-rt/kernel/locking/rtmutex.c:997!
Date: Wed, 18 Feb 2015 09:32:29 +0100
Message-ID: <54E44E1D.4060302@linutronix.de>
References: <CADLDEKuPf3UNf-CB_xpmjcmQxQA_drFkXzBMQYUF_7K0dM7V3w@mail.gmail.com> <20150217141333.GR26177@linutronix.de> <54E4453C.8060508@fos4x.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: =?UTF-8?B?UGhpbGlwcCBUw7Zsa2U=?= <philipp.toelke@fos4x.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46590 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbbBRIca (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Feb 2015 03:32:30 -0500
In-Reply-To: <54E4453C.8060508@fos4x.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/18/2015 08:54 AM, Philipp T=C3=B6lke wrote:
>> Do you see the same problem with v3.18-RT?
>=20
> I do feel kind of stupid to ask this: Where would I find 3.18-RT? The
> git only goes to 3.14...

https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/

>=20
> Cheers,

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
