Return-Path: <SRS0=0dn7=D5=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24267C388F7
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Oct 2020 14:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA1012463B
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Oct 2020 14:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YDnTYZMo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BcE2susZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368226AbgJVOwS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Oct 2020 10:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368214AbgJVOwR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Oct 2020 10:52:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0A9C0613CE
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2020 07:52:17 -0700 (PDT)
Date:   Thu, 22 Oct 2020 16:52:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603378336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xSZ91gtPGljSv7CiI3W5P8NB/J7EKjPg07el2dSsmk0=;
        b=YDnTYZMoKZM5JTzi+QDestpQbhElmOVzWOx57g6xPx1aqQs9n1lrxr1ymxJtPXJ8XKOhrp
        A/OhArNLGKDcvCGb1pUzSfrjePmuKM/5AA4m7L0Kz13MfB+KmQCAy0o/O704aNs77YxmRE
        /sUU/z+UOtdNRurFkpZFblTkyGwyjczNajDH0wtwqYnjMasvcfItuAWVJv22t/lLOVaOmY
        hrDfPRWMn29MzOWnYVvZxQY41gRUWm1NMs+2ieL8kOevkY1J93244s67m5qXDujebj8DcK
        /KA75lz69/SXY68U/ore90Kts1t1eqyR/IQE4yAdy65XaD4s5/yFzJxv1btR5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603378336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xSZ91gtPGljSv7CiI3W5P8NB/J7EKjPg07el2dSsmk0=;
        b=BcE2susZJMIG529vqI2yiuqnP012ImUTIwL5hJ0dh5aNO5rhDIAOM8rP7+gNVEmWTWeQUX
        0u5p8B+vWiU/AiDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: printk: add pr_flush()
Message-ID: <20201022145214.a5sm66naswycezae@linutronix.de>
References: <15cd3dc322eb1485fe1e67df465febdc6ad389d8.camel@gmx.de>
 <20201022141529.zvwafoqglnhyklj5@linutronix.de>
 <43c56d9bd7c5d0b7c455a5ba3c00080b1600b718.camel@gmx.de>
 <c2965ef22b5e95db0d9e214efb6f653628549579.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c2965ef22b5e95db0d9e214efb6f653628549579.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-10-22 16:47:20 [+0200], Mike Galbraith wrote:
> Um, that "yup" is predicated upon you meaning reset_on_progress, that
> being the only bool.

That was my question and you answered if perfectly fine. Thank you.
I saw "hangs" on reboot while I had quite a large backlog which was not
yet printed. So that was expected. I'm currently stuck on your seqcount
report so=E2=80=A6

> 	-Mike

Sebastian
