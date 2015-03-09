From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH v2 2/2] mce: don't try to wake thread before it exists.
Date: Mon, 9 Mar 2015 07:38:43 +0100
Message-ID: <54FD3FF3.5080009@bmw-carit.de>
References: <1425046838-4868-1-git-send-email-daniel.wagner@bmw-carit.de> <1425046838-4868-3-git-send-email-daniel.wagner@bmw-carit.de> <20150306210127.GH10155@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-rt-users@vger.kernel.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:33170 "EHLO
	mail.bmw-carit.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbbCIGiw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Mar 2015 02:38:52 -0400
In-Reply-To: <20150306210127.GH10155@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/06/2015 10:01 PM, Sebastian Andrzej Siewior wrote:
> * Daniel Wagner | 2015-02-27 15:20:38 [+0100]:
>=20
>> From: Paul Gortmaker <paul.gortmaker@windriver.com>
> =E2=80=A6
>> [wagi: Replaced WARN_ON_ONCE with a 'creative' defer logic]
>> Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
>=20
> You can't use Paul's From: and submit a different patch with only one
> change hit "creative".

Sure, I should have known better. @Paul I owe you a beer :)

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
