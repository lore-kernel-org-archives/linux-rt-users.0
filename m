Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB31C433E0
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 08:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ADEC64DD3
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 08:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhBVIf3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 03:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhBVIf1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Feb 2021 03:35:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34591C061574
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 00:34:47 -0800 (PST)
Date:   Mon, 22 Feb 2021 09:34:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613982883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WJI3/B9u40DLL8PwpvQoBHaZb+svMVhxm7VWfJfHL4Y=;
        b=aF3jlsjFo9ZG/8/5Xt3WLUO3evxeLPbN81Cbva/t0lkCFMIC1tfTcPthprc80U5bF9Qz4e
        r1HVIw+7iFLB/ZNaPPqkYot3XdQy7lQiHuB1PV4o/PBixX0NWxGlvu9JmQ7QsO8TEOwtdo
        AADVbBoF4gqezBpRGOlbLcyYnXNgM+vCPv7n8Ba9jUnJSdjiHvk+jpoH8WNAKVPJLJ3VBM
        aAxpDMyfUWP9ULCUboBXYVyAEaxDqMlf7Ear2To845TE+1yzEU3cZeOhza7WM6F0JGu7CZ
        e/TbkV4p5+HKqTiqzfdE692aGPz9SUPwhpg0wc/WQEA9p9XSV+M4tY4cvKiVxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613982883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WJI3/B9u40DLL8PwpvQoBHaZb+svMVhxm7VWfJfHL4Y=;
        b=ps4z6u7Zg/8THaV9nsTLnS8g26GpW9BreNHMOXmPnDEOKvNezUdsCE57em144Sv7x5Eymd
        Jwj8sgzS6orrJSDw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     =?utf-8?B?6bmP6bKy?= <kunpeng0891@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Question about rt-patch use in arm64 kvm host and guest o
Message-ID: <YDNsojcMWpa2Ynsi@lx-t490>
References: <CAJa5FiHcaG7EB3eAD17w_6GhZm0yqvD0Ev3DvJAU7meOG6C--g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJa5FiHcaG7EB3eAD17w_6GhZm0yqvD0Ev3DvJAU7meOG6C--g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Feb 22, 2021, 鹏鲲 wrote:
> I'm trying to use rt-ptach in arm64 kvm to improve real-time performance.
> I couldn’t find useful information on the web so I think this mail
> list is the most appropriate place to ask this question.
>
> Rt-patch can use in arm64 kvm host linux and guest linux ? Where can I
> find reference examples?
>

I've read some articles on the topic last year, and the best (by far)
was this one:

  Realtime KVM
  https://lwn.net/Articles/656807

It written by Bonzini, the KVM maintainer. The includes links/references
are also very valuable.

Good luck,

--
Ahmed S. Darwish
