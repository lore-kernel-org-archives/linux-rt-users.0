Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BF6C433DB
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 10:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A184464E25
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 10:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhBVKPb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 05:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhBVKOl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Feb 2021 05:14:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA01C061786
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 02:14:00 -0800 (PST)
Date:   Mon, 22 Feb 2021 11:13:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613988839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g1FhF8KlR+JaQg0qnIxhyjFdWHf7x04D7JO7o5ul/qA=;
        b=MEuYaBCHIe2yehlZXrIYZ7OJiVZzMU4qGUF1RM3VLobQ007kg2+T1cR98JxmR26sVc6HAO
        /kyApDPe1c3rQgPaMTkG06dmuBZCtOH+udY/rxEPlcEZgQtpKRJqlMwmrKySYqwzwVVULA
        dkS0sIDECYOWTjki7tAF7WbYhD6M1fuI4rYv8K6YxAnBZrQALCA+Ef2MzJEXVVvEGp/vvn
        vBMuOSJamk6FQoreRRwVMTn0KYYjflvtTIa867diyI+x+8g6zU76g3BzeDV9qNARe221ZB
        /YpbCrI3W1Qub/yKWm+NfhRJf7pzvxnCOaabCF57a26Bvh0TPVAQVXPqMZEZDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613988839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g1FhF8KlR+JaQg0qnIxhyjFdWHf7x04D7JO7o5ul/qA=;
        b=a0TlWEtfZvW6UHZQ3SLsh14o3U1WFj0ClbutD9QrJ7iKbldH8vXwkItsXHNLV1ICfS+d6P
        wTttyaWC1c2U0hBw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     =?utf-8?B?6bmP6bKy?= <kunpeng0891@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Question about rt-patch use in arm64 kvm host and guest o
Message-ID: <YDOD5om6XVA4gbmp@lx-t490>
References: <CAJa5FiHcaG7EB3eAD17w_6GhZm0yqvD0Ev3DvJAU7meOG6C--g@mail.gmail.com>
 <YDNsojcMWpa2Ynsi@lx-t490>
 <CAJa5FiExdgUfpXMje0cAe_KH+0M53MunejedM1bzEKh5xnt93g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJa5FiExdgUfpXMje0cAe_KH+0M53MunejedM1bzEKh5xnt93g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Feb 22, 2021 at 05:29:47PM +0800, 鹏鲲 wrote:
>
> I have read this article carefully before, but this article focuses on
> the x86 system.
>

Most of the details in that article are not x86-specific.

> I don't know if anyone has used rt-patch successfully on arm64 kvm? Or
> have a lot of problems with arm64 kvm?
>

Maybe someone on the list can jump-in and provide their experience.

In general though, you will have to try things by yourself. Properly
configure both the host and guest kernels for preempt_rt, monitor
VMexits through "perf kvm" and try to minimize them, run cyclictest
inside and outside of the guest, and see how things goes...

And if this is an embedded device, you can also try Jailhouse.

Good luck,

--
Ahmed S. Darwish
