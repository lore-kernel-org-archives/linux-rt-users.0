From: Rolf Peukert <rolf.peukert@imms.de>
Subject: Re: [PATCH RT 0/4] Linux 3.2.60-rt89-rc1
Date: Wed, 16 Jul 2014 12:28:12 +0200
Message-ID: <53C653BC.5020708@imms.de>
References: <20140714200634.590977709@goodmis.org> <53C4623F.5090901@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from infosrv.imms.de ([194.95.250.51]:51838 "EHLO infosrv.imms.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753296AbaGPK2Q (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Jul 2014 06:28:16 -0400
In-Reply-To: <53C4623F.5090901@pavlinux.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 15.07.2014 01:05, Pavel Vasilyev wrote:
> 15.07.2014 00:06, Steven Rostedt =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Dear RT Folks,
>>
>> This is the RT stable review cycle of patch 3.2.60-rt89-rc1.
>=20
> Actually 3.2.61
>=20
> kernel/irq/manage.c
> kernel/rtmutex.c
>=20
> This files FUZZED :(

Just for the record, the (incremental) patch applies and runs without
problems on an 3.2.60-rt88 (built for ARM).

Regards
Rolf

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
