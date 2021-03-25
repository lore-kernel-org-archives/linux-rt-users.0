Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CC5C433C1
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Mar 2021 12:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D65F619BF
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Mar 2021 12:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhCYMzG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 25 Mar 2021 08:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhCYMzA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 25 Mar 2021 08:55:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D07C06174A
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Mar 2021 05:55:00 -0700 (PDT)
Date:   Thu, 25 Mar 2021 13:54:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616676898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8+SlQpbMOqeNKi8QrDDkQSKNpGU6phFDn1bHduu0Vgs=;
        b=Y2KVm9f4ORXWXiUIwNs1MmqRb8h1fyAZGDX/eFMvN4YWASV4jQut5o3cqIdPQBX3lvB8RY
        kvO9rIKk1b6n3dDKtgwiXRMFONbg3K1xf1afVxnBxXcCLOcyVLehMUk7WC06H0ecOOQIAi
        aQecQgN8jUdTdOO88ZHAHvMy/9YcSH4fg1wHnsLcSgn0rDXwsZklq9GqlgSuC2JtCoVZL6
        jE5yqpeQ6dkJhm8FQiybF7E/hCMBAidzqN0qbf7pQ7vly32rXkPvViVMpFM5H8IHKvpQuK
        vnnFvAj1mwecI31fAfn/E0iHRXHyRjeuoM9gHPUWlp0rCByXJhMwOFg/JFVqjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616676898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8+SlQpbMOqeNKi8QrDDkQSKNpGU6phFDn1bHduu0Vgs=;
        b=HA20Egyx5Gx57W45gjWn7zpf1dYeNipyB6xODM7CrZVXYcSd776DerKgaumH1Ru+4RNbOc
        g2dFkDZQFI2VccCA==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     jack@madeinspaceeurope.com
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Application of standard kernel patch and then RT patch with
 Petalinux
Message-ID: <YFyIIB/B2XbY7khU@lx-t490>
References: <dd27ce028fb9b2423ec99985c290b19b30083b34.camel@madeinspaceeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd27ce028fb9b2423ec99985c290b19b30083b34.camel@madeinspaceeurope.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Jack,

On Mar 25, 2021, Jack wrote:
>
> I am having problems applying kernel patches in the context of a Xilinx
> Petalinux project (Yocto-based).
>
> Xilinx provides a 5.4.0 kernel, according to make kernelconfig, though
> how this corresponds to the upstream 5.4.0 kernel, I'm not sure.
>

What Xilinx provides in its linux-xlnx tree is quite different from the
mainline v5.4 kernel. You can see all the differences by diffing against
219d54332a09 ("Linux 5.4").

> My understanding is that, in order to apply the latest 5.4 rt patch
> (106-rt54), I have to apply the upstream 106 patch first. Is this
> correct?
>

No, it doesn't work out that way, especially that the Xilinx kernel is
quite different at core kernel components.

The RT kernel releases are meant to be taken as a whole, by picking one
of the stable versions shown at:

  https://wiki.linuxfoundation.org/realtime/preempt_rt_versions

> When applying the patches using petalinux-config -c kernel, the
> upstream patch appears to be accepted, but the rt patch is not. I get
> the sequence of errors below, picked out in red.
>

FYI, in general, it's advised to separate kernel development from
"integration" development (e.g. yocto, peta linux, etc.)

> I am not familiar enough with the kernel, or the Petalinux tools, to
> get a handle on the problem. The log file mentioned at the bottom does
> not exist following the completion of the command.
>
> Is anyone able to help with this?

Unfortunately, if you're going to do RT things on top of an SoC kernel,
you're on your own — and some kernel development expertise will be
needed.

There are only two sane ways out:

1) Clone one of the stable RT kenrels trees (e.g., v5.4.106-rt45), then
*carefully* pull in what you need from the Xilinx kernel tree. Then do
proper stress and latency tests to make sure that everything is still in
line.

2) Ask a supplier with sufficient embedded/kernel/RT expertise to do it
for you.

Good luck,

--
Ahmed S. Darwish
Linutronix GmbH
