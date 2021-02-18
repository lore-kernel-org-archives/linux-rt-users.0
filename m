Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC1EC433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 12:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8EFF64D79
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 12:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhBRL4h (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Feb 2021 06:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhBRJ2h (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Feb 2021 04:28:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6B6C061756
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Feb 2021 01:27:54 -0800 (PST)
Date:   Thu, 18 Feb 2021 10:27:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613640473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rhFl2a9CMbOIoF03W9/6lOSpzk4xQRNGyZJOlYIF7mM=;
        b=KVlWyEEuDrM2W4OX7FSa3Jp+6yxvUb9xkAxzx/NGfz/kgVu2RrjaCR0F1nTE3ikq0fsyYc
        K1JzLTfJjRSb+Awi8JFOQ6S7REal6+BfKNuCzAySLLIYUbSNHRcpwcsyf/qVRJrKRNdcRe
        AtUeQGXNFOdWrpJUotwMnmSl+K9aXQNGQJEliWpLymmjMqLnI/GKvmCMkyZSF/XAPhWSOr
        nQTGnsJ8r7oNR8kHnzVqniQvgnif0+WdqQd5digvzQgOwzotIxJP41FfWgK5zgLtrzK3t3
        9IzIY6xtTTjVcw1IRK/ndImS41TiMg31auPnwNsDwm/B3SikMQzF4V+W7zQT+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613640473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rhFl2a9CMbOIoF03W9/6lOSpzk4xQRNGyZJOlYIF7mM=;
        b=09jaN4WdwOOONuZ+8wExMZv56AT81m0xQo0pwhMuq8b1UL8z9QQqkasZhUv6nJgE9PSTGi
        tH2r0qtcAFAgPICA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     David Runge <dave@sleepmap.de>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]
Message-ID: <20210218092751.ahn262llcpp2loz7@linutronix.de>
References: <YBVG/PG7syFIUBno@hmbx>
 <20210201083441.ocucdvdrv37goz2s@linutronix.de>
 <20210205112638.xuduvuefy3auycht@linutronix.de>
 <YB3TLNN39/XhUyUY@hmbx>
 <YB+5tdIpbTfnDnIi@hmbx>
 <20210208091940.csuyf7l73n4ofpmz@linutronix.de>
 <YCl28sXo7LEyCK8y@hmbx>
 <20210218083849.iitcrhdgv2oajfhv@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210218083849.iitcrhdgv2oajfhv@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-02-18 09:38:49 [+0100], To David Runge wrote:
> On 2021-02-14 20:16:02 [+0100], David Runge wrote:
> > The current config can be found on the AUR [1].
> 
> So this did make a difference. 

made _no_ difference. Sorry for the confusion.

Sebastian
