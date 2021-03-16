Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F28C433E6
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Mar 2021 06:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E806E6520E
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Mar 2021 06:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhCPGU5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Mar 2021 02:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhCPGUx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Mar 2021 02:20:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F188DC06174A
        for <linux-rt-users@vger.kernel.org>; Mon, 15 Mar 2021 23:20:52 -0700 (PDT)
Date:   Tue, 16 Mar 2021 07:20:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615875651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/hIBek1N3k8EqKVz6XxrREeOuq3mMKmc03fNU3uicUk=;
        b=b5zBSz11xpOUJwYX8jZ8sHipVZ8yCPpbVo+s3q3nL74kyDNzxvm7Pj6oW9orTloVx8egYt
        ITXk6NyH+H0eZm0NovAe9VA4GJEmb64a9wgsS0BeCXNi/lT4uOsHHO53wVkcFwa0OpAoY8
        2vKYZRNI2B0l/SfYxJiwTHZVDhPlS6n4qGj+iLfTUROWWjYed6DNj9U1sjGVPQ2SI1VyLA
        pDBUxGsdoStfB/kbeUFp+yVTqcLSJouytkckwWheX2xtRGDbfJkdB9KrASgHx1VTvhKHRM
        c4wNelAxOTl4MvehbHsKfW7pj0deCbn/aOTAI7mj3s+HjylA1DJdHBir/MRBNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615875651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/hIBek1N3k8EqKVz6XxrREeOuq3mMKmc03fNU3uicUk=;
        b=EOERk49pz32dh3i8xTrlNhjxar+HVko+BNP8+Gl2oTsIvAZ6O+r6qfg/YPNEKM7nxg57q8
        cvtukprUMz9Cq/Dw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: about preempt-rt patches
Message-ID: <YFBOQdCxc9QyBk2Z@lx-t490>
References: <CAOuPNLjoAST=rQ4NmGkVjqxi3iNqPg2MmqjCdr6=8smUwryX8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuPNLjoAST=rQ4NmGkVjqxi3iNqPg2MmqjCdr6=8smUwryX8A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Mar 15, 2021, Pintu Agarwal wrote:
>
> I just wanted to know if this is the right list for posting
> changes/discussions related to preempt-rt patch set and linux-rt in
> general.
>

Yes, this is the right list.

In the future, don't waste people's time by asking questions like this.
Just check the mailing list's archive and its meta pages:

    https://lore.kernel.org/linux-rt-users
    https://wiki.linuxfoundation.org/realtime/communication/mailinglists

Good luck,

--
Ahmed S. Darwish
