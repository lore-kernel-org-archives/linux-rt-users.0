Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D01EC4338F
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Aug 2021 08:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84A4961106
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Aug 2021 08:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbhHSIsm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Aug 2021 04:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbhHSIsk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Aug 2021 04:48:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8969DC061575;
        Thu, 19 Aug 2021 01:48:03 -0700 (PDT)
Date:   Thu, 19 Aug 2021 10:47:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629362881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UGhrbP1M+bRZykm1qw5MiTgXr3U+PK7s8IS34ZgSXfI=;
        b=trRnakSacqt1GZoA9rmQailL5D5FdiYvG9vn4H4IFSVPUuWLCyGNE3upOx6UzCrekwYQu9
        z+t5i2jnQFmKNWirRpJGU5BDAHEh9a6ky98KKNDrifqHIPIcTYV1udP+e+DbWwf/SqA6ei
        CzJbhgveJDyBwI0GQDUOqvq64BNVd1EBJvCrhznR34C+0VwcaY9X7G8TTsBkD/dmIylZgV
        Y1WnfiDhGzEiCift0C/3zHq+48caOnhzgalo/dsrP0+nLYzapQakn+BzJ3hGaOt1IIQo4X
        r8c9w4chvjvgNFkOuXSPEoy42tIlwMRlVLGwbpF8UXsddT5EvY40yYqrsXQiUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629362881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UGhrbP1M+bRZykm1qw5MiTgXr3U+PK7s8IS34ZgSXfI=;
        b=JjvGNmfhOeqlCc3FmDvm6MBn+YE/490dRcvw6yXJbnrf28mkeSruEBZAUMfd8+Jm3ZcESc
        8NxYzP6+dKiU1ZCg==
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
Message-ID: <20210819084759.stnmit32vs2be46m@linutronix.de>
References: <20210817095313.GA671484@ubuntu>
 <20210818161752.vu6abfv3e6bfqz23@linutronix.de>
 <CAJk_X9h_GqUyir7oG33pFrLgknj7DZfd6esiKb07w7QWjZqX0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJk_X9h_GqUyir7oG33pFrLgknj7DZfd6esiKb07w7QWjZqX0g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-19 08:50:27 [+0900], Jeaho Hwang wrote:
> Without RT, udc_irq runs as a forced threaded irq handler, so it runs
> without any interruption or preemption. NO similar case is found on
> non-RT.

I see only a devm_request_irq() so no force-threading here. Booting with
threadirqs would not lead to the problem since commit
   81e2073c175b8 ("genirq: Disable interrupts for force threaded handlers")

=E2=80=A6
> > If this function here is sensitive to timing (say the cpu_relax() loop
> > gets interrupt for 1ms) then it has to be documented as such.
>=20
> The controller sets ENDPTSETUPSTAT register if the host sent a setup pack=
et.
> yes it is a timing problem. I will document that and resubmit again if
> you agree that local_irq_save could help from the timing problem.
>=20
> Thanks for the advice.

If it is really a timing issue in the function as you describe below
then disabling interrupts would help and it is indeed an RT only issue.

So you read OP_ENDPTSETUPSTAT, it is 0, all good.
You write OP_ENDPTPRIME, wait for it to be cleared.
Then you read OP_ENDPTSETUPSTAT again and if it is 0, all good.

And the TWD interrupt could delay say the second read would read 1 and
it is invalidated. Which looks odd.
However, it is "okay" if the TWD interrupt happens after the second
read? Even if the host sends a setup packet, nothing breaks?=20
Do you have numbers on how long irq-off section is here? It seems to
depend on how long the HW needs to clear the OP_ENDPTPRIME bits.

Sebastian
