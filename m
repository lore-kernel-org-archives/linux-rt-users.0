Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B21C4338F
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Aug 2021 16:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C00613CD
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Aug 2021 16:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhHWQOw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 23 Aug 2021 12:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhHWQOv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 Aug 2021 12:14:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2045C061575;
        Mon, 23 Aug 2021 09:14:07 -0700 (PDT)
Date:   Mon, 23 Aug 2021 18:14:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629735243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5TGqeZzme/VeIRQngMgDyP5V2bB9RF2o4O2Q2EpI5fs=;
        b=zdxklKf1t3vUeK0iHrIyr2J7Gx4qdLJRu8MhNvYPsZsyWyitSKLMWc6JCXBT2gIYW7mp8t
        EnEZGaQDUonijqDO4CPMzs425lwfb/+bEH1qQaBoiMyXAsaNz5j7OecF3QOKg9MCdZDqlf
        KuiLobWJfR3xctTsqlQNB2eJ/LKFSB2jDvsrBsYuyg09dptfWqBYojMh/0NGaPgYfTrLVT
        RJfnP3HqDv3wxbf9M6+GwwCJVz6xd4GavDlB1LVloyASlVoF9BLHeWGxrBupsmbUmDnbfV
        tvlTS+F/DajM4XkDF3RSfuSPB8Hj0xRku7qgZY8QotCvRK5ev/2wHE2tWGLKeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629735243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5TGqeZzme/VeIRQngMgDyP5V2bB9RF2o4O2Q2EpI5fs=;
        b=7FXYXy05/5pwO89Qoo+bjcBlrE2ri8yo+vfEZLh6jWElo/6wBzwMftmx+z5eSLFZ2LWlst
        0v9qf5YPaw9wGXAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jeaho Hwang <jhhwang@rtst.co.kr>
Cc:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, Linux team <team-linux@rtst.co.kr>,
        =?utf-8?B?67OA66y06rSRKEJ5ZW9uIE1vbyBLd2FuZykv7J6Q64+Z7ZmU7JewKUF1dG9t?=
         =?utf-8?B?YXRpb24gUGxhdGZvcm3sl7DqtaztjIA=?= 
        <mkbyeon@lselectric.co.kr>,
        =?utf-8?B?7LWc6riw7ZmNKENob2kgS2kgSG9uZykv7J6Q64+Z7ZmU7JewKUF1dG9tYXRp?=
         =?utf-8?B?b24gUGxhdGZvcm3sl7DqtaztjIA=?= 
        <khchoib@lselectric.co.kr>
Subject: Re: [PATCH v2] usb: chipidea: local_irq_save/restore added for
 hw_ep_prime
Message-ID: <20210823161401.ix6l33o3sja7sy45@linutronix.de>
References: <20210817095313.GA671484@ubuntu>
 <20210818161752.vu6abfv3e6bfqz23@linutronix.de>
 <CAJk_X9h_GqUyir7oG33pFrLgknj7DZfd6esiKb07w7QWjZqX0g@mail.gmail.com>
 <20210819084759.stnmit32vs2be46m@linutronix.de>
 <CAJk_X9gyWch6Z1=hbe2vvqGu61mdavAU62+6dSka0tZoMzxu5Q@mail.gmail.com>
 <20210821050511.GA14810@Peter>
 <CAJk_X9gqBACA3O=4LdY3XJP5UzJe2p4bE72X_jNEHR1Cn=vDNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJk_X9gqBACA3O=4LdY3XJP5UzJe2p4bE72X_jNEHR1Cn=vDNQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-21 16:04:01 [+0900], Jeaho Hwang wrote:
> 2021=EB=85=84 8=EC=9B=94 21=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 2:05,=
 Peter Chen <peter.chen@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> HI Peter.
>=20
> We configured the kernel as "low latency desktop" and added
> "threadirqs" inside the cmdline parameter.
> Then udc irq handler runs as a thread and shows no suspicious working.
> I Hope It will help.

May I again point out that since commit
   81e2073c175b8 ("genirq: Disable interrupts for force threaded handlers")=
                                                                           =
             =20

the threaded handler runs with disabled interrupts. This time more
verbose. It is available since v5.12-rc4 but it has been also applied
for stable.

> Thanks.

Sebastian
