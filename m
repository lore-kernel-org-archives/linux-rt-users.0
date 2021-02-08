Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE70C433E6
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Feb 2021 09:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D5F64E8C
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Feb 2021 09:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhBHJV1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Feb 2021 04:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhBHJUH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Feb 2021 04:20:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F32C061756
        for <linux-rt-users@vger.kernel.org>; Mon,  8 Feb 2021 01:19:45 -0800 (PST)
Date:   Mon, 8 Feb 2021 10:19:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612775982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NveZGsowCI0hguI8ut59jsvV7SwzJitBaNvEeFq1kF0=;
        b=IEEQ4CUya/G2fKJBQDEFfBtjn8D2f/VvpW2YfNipkwH5pJlk21ZD3wBmyqgZqzttAnKcAP
        pd3E4ZQlxbcpL2gIEWMhm9pSjLHfoBs11av3aIgzqAfrreyeg7ZgCVVL74AWEvMgRwzk3o
        j4aFN7NQelsbrKtJvRtmFn7Dm7FCU7ZgQRG8aX5xtVFTlHoPaZSIUKQ8BM0+LDiuyq40Al
        ZmE+3AYwUnlqnuhuhbBgarn8c0yzsWfgKv7oIZ1JP9AgLzHPEjPTAS/tHUUkZ5g4ax3P+/
        +IALQQfphvvWZb1bZBZ4cqs8TWfvS7zetw5adxkO30yVG5q8yQm/8V1LvWTbZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612775982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NveZGsowCI0hguI8ut59jsvV7SwzJitBaNvEeFq1kF0=;
        b=ydKrquny/glDJIuetZvqSDsH8UbvQ3zsxIejB8WHIu14mV5MENW+rbjlvN8cpHrUjczFcZ
        a/EA1vxve0LFQFAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     David Runge <dave@sleepmap.de>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]
Message-ID: <20210208091940.csuyf7l73n4ofpmz@linutronix.de>
References: <YBVG/PG7syFIUBno@hmbx>
 <20210201083441.ocucdvdrv37goz2s@linutronix.de>
 <20210205112638.xuduvuefy3auycht@linutronix.de>
 <YB3TLNN39/XhUyUY@hmbx>
 <YB+5tdIpbTfnDnIi@hmbx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YB+5tdIpbTfnDnIi@hmbx>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-02-07 10:58:13 [+0100], David Runge wrote:
> With 5.10.12-rt26 the controller still does not initialize at all
> though (/dev/fw0 does not appear):
> https://pkgbuild.com/~dvzrv/bugs/2021/01/linux-5.10.12-rt26-kernel.log

So it is either config or chipset specific. Did you posted a link to
your .config?

> Best,
> David
> 

Sebastian
