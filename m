Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DEEC61DA3
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Feb 2023 16:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjBUQNq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Feb 2023 11:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjBUQNp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Feb 2023 11:13:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C51872BD
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Feb 2023 08:13:44 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676996022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kHE4CjoVvckPZ8RZhCZC1//cOZCPRjfjAu6DZzurUTE=;
        b=JZtplFEOIA73U5/WnWPs1eLHCy0E2zXmzrCwf04vSce4/lSkJxrzxTQT/jrVc/aodultK0
        Q6euBYDCYSVKlzma7jh/2ENkOBJrelHjKb4U2Y8BROQFWkXgjPFltNXm9izxwNAdDKVyFO
        PaGHEAc+PLuxdpg2SRhJ+YSLZGwUa5fKgbKSiCy9zxOTPYkDlZ6YsLNh5yRr67O9J+S/QS
        sooZEZ8za1cCBvHJ9gBeau2cO+hjPzwF4v3bZ/PlD3vsVa78cXohiGWrpyRDumOCsPiCAn
        MotPavnJ+g14LWjUnxdfNg4CW3bPEacpOFy740g/NNsBhTM+S4e/iaZnMjcJlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676996022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kHE4CjoVvckPZ8RZhCZC1//cOZCPRjfjAu6DZzurUTE=;
        b=RVjH4YZl+Sp8ls2mQuLWu0Ur/e+po3hVmYv9/XYxRfy9Fe70O8A7V7MX8mx0U811LHylP1
        Tsm6ewUvWTynLhCQ==
To:     =?utf-8?Q?Andr=C3=A9?= Pribil <Andre.Pribil@hms-networks.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: printk: console output corrupted
In-Reply-To: <AM5PR10MB162013648CCFDDDC4EE42A3CBDA59@AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM>
References: <AM5PR10MB162013648CCFDDDC4EE42A3CBDA59@AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM>
Date:   Tue, 21 Feb 2023 17:18:24 +0106
Message-ID: <87bklnro9j.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Andre,

On 2023-02-21, Andr=C3=A9 Pribil <Andre.Pribil@hms-networks.com> wrote:
> I'm using a IMX8MP board with kernel 5.10.165-rt81. UART3 is used as
> the console device.  When the device boots the serial outputs on this
> UART get corrupted at some point.  It looks like only one line is
> corrupted. However, this line often confuses my terminal, so that the
> lines behind are also not shown correctly. A reset of the terminal
> fixes that.
>
> I could not figure out why this happens, yet. I only know that the
> issue does not occur when I remove the preempt-rt patch or when I
> specify the "maxcpus=3D1" kernel command line parameter. I also tried to
> enable/disable the "earlycon" setting, but this seem to only change
> the time when this happens during the boot messages.
>
> When the boot messages are afterwards displayed with "dmesg", they do
> not contain corrupted characters. Therefore, I assume that the
> corruption occurs at the UART level.  Maybe some lock issue and
> therefore some concurrent access to the UART registers?

There is a known problem [0] with this printk implementation that it
does not support boot consoles. I will follow-up this email with the
rebased patch from Petr Mladek, which should work around the
issue. Please check if it works for you.

John Ogness

[0] https://lore.kernel.org/lkml/YrCO04oNncE1xF5K@alley
