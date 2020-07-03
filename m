Return-Path: <SRS0=rnfU=AO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAB8C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Jul 2020 19:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3585208C7
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Jul 2020 19:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mvqttFzP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ltMM7nm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgGCTth (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Jul 2020 15:49:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34984 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCTth (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Jul 2020 15:49:37 -0400
Date:   Fri, 3 Jul 2020 21:49:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593805775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tIaTpq38MmojOSvR1P9sTtaDp4YhCE3qrNpkc2QM/Gs=;
        b=mvqttFzP7xSAl9mlui3zGWq7XZbcYrz4jJOxlzNe0pjDb4vDOAoj0nAE/QtmPzjCr6uZNZ
        YXcxkRijwSWWJbdDqS66t9CdEs82ie3u8fwfOOfVD5WYw9m0G2V7PCxb+jji9OBf64cvq8
        0QMKtzBbxWRsftceLxX+17kTUzORbmWFSdObhjbZh90iOEYtV6Gu42nXh33WZFO3vYu0NI
        +eJFMa2BzdwPakyncuVfdyDNRV9IS/Jm5zeRx9O9DnvA8/KVmG79sUCt3/ANUt2TsgBk8C
        ybN+2AI21N+3tSwZXmfj+1Q3e1NUsOamGy7mPtJdrfdVpxE7qLy/oiFdoK9paA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593805775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tIaTpq38MmojOSvR1P9sTtaDp4YhCE3qrNpkc2QM/Gs=;
        b=ltMM7nm+CQXwhcFlvvf5Z/cicSWbYLwGxYiAFuZj25m0mGIwIhX8JdzcpCDv7C1DW/46VV
        Lv6NhWcVmQYND+CQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Udo van den Heuvel <udovdh@xs4all.nl>
Cc:     RT <linux-rt-users@vger.kernel.org>
Subject: Re: 5.4.13-rt7 stall on CPU?
Message-ID: <20200703194934.c5sdqwxwgzmgobtq@linutronix.de>
References: <3ef1ba37-6b83-e12a-e493-9c45fa3bb3c1@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3ef1ba37-6b83-e12a-e493-9c45fa3bb3c1@xs4all.nl>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-06-27 15:30:20 [+0200], Udo van den Heuvel wrote:
> Hello,
Hi,

> Found this in /var/log/messages:
>=20
> Jun 25 16:31:39 vuurmuur pppd[1522583]: local  LL address fe80::ed36:3ac4=
:4115:e23e
> Jun 25 16:31:39 vuurmuur pppd[1522583]: remote LL address fe80::2a8a:1cff=
:fee0:9484
> Jun 26 04:50:24 vuurmuur kernel: 002: rcu: INFO: rcu_preempt self-detecte=
d stall on CPU
> Jun 26 04:50:24 vuurmuur kernel: 002: rcu:      2-....: (5336 ticks this =
GP) idle=3Df6a/1/0x4000000000000002 softirq=3D347363113/347363115 fqs=3D2430
> Jun 26 04:50:24 vuurmuur kernel: 002:   (t=3D5250 jiffies g=3D608224341 q=
=3D1297)
> Jun 26 04:50:24 vuurmuur kernel: 002: NMI backtrace for cpu 2
=E2=80=A6
> Jun 26 04:50:24 vuurmuur kernel: 002: RIP: 0010:__fget_light+0x3d/0x60
> Jun 26 04:50:24 vuurmuur kernel: 002: Code: ca 75 2e 48 8b 50 50 8b 02 39=
 c7 73 21 89 f9 48 39 c1 48 19 c0 21 c7 48 8b 42 08 48 8d 04 f8 48 8b 00 48=
 85 c0 74 07 85 70 7c <75> 02 f3 c3 31 c0 c3 ba 01 00 00 00 e8 22 fe ff ff =
48 85 c0 74 ee
=E2=80=A6
> Jun 26 04:50:24 vuurmuur kernel: 002:  do_select+0x350/0x7a0
> Jun 26 04:50:24 vuurmuur kernel: 002:  core_sys_select+0x1d0/0x380
> Jun 26 04:50:24 vuurmuur kernel: 002:  __x64_sys_pselect6+0x141/0x190
=E2=80=A6
> Jun 26 05:03:01 vuurmuur named[1433212]: received control channel command=
 'flush'
>=20
>=20
> What went wrong?

ntpq entered into kernel via pselect(). In that syscall it looped at
somepoint and RCU couldn't make any progress. Assuming you have
CONFIG_HZ=3D250 then it didn't make any progress for 5250/250 =3D 21
seconds. This stall piled 1297 callbacks up. The situation resolved by
itself later because this "rcu_preempt self-detected stall" did not
appear again.

> How bad is this?
Each callback would free a data structure i.e. give back memory to the
system. Since ntpq lead to a RCU stall, the system could no release
memory. You will run eventually out of memory if this situation does not
get resolved.

> How to avoid?
Can you reproduce this or was this one a time thing?
I *think* this happened within the loop in __fget_files(). This function
is inlined by __fget_light() and the loop has a RCU-section so it would
make sense.
Do you run something at an elevated priority in the system? I don't know
what the other part was doing but somehow one of the file descriptors
(network sockets probably) was about to be closed while the other side
tried to poll() on it.

> Kind regards,
> Udo

Sebastian
