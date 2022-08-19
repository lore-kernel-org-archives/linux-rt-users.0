Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4FDC32771
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Aug 2022 15:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349665AbiHSPOX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Aug 2022 11:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349111AbiHSPOW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Aug 2022 11:14:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF91B46237;
        Fri, 19 Aug 2022 08:14:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9409061573;
        Fri, 19 Aug 2022 15:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE92C433C1;
        Fri, 19 Aug 2022 15:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660922060;
        bh=T7HmoTEwZ8JCC3rUt5o2UG7e7BqxziQDc9LBVkbvG1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZzLyjsvEDw46oPCnobgQaCqvdYYCAiNaMoG1Sbxnm4KNR0FTgIoTm4MsZDU2DqPcm
         ErzsKnDnd0xIg4kG8MJ4lnGpTEreT9eIdOsfulk/vqVanJWOXCEJVPRKLO5Eb6kf8j
         D1ji4P1jIpzUtnhK8OI3jqqEOG6qVoJ90dJqfQoBwStlNKQTFmi3ocntxGFTAeywZw
         x4RIfSbYRNuuZ9pNxGcCW5nJoc+mPd6hEq6rZ5KbDFeI3P1reTELvHnT4Kd8x4QQg7
         r9GB020b+bTCh7ppklBYSlF6d0Wpf9TLR/SApyEcf1lVO0O44G/vVWnuwgOdh3Idry
         BEyimZCVH5f8Q==
Date:   Fri, 19 Aug 2022 08:14:18 -0700
From:   Mark Gross <markgross@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Mark Gross <markgross@kernel.org>, linux-rt-users@vger.kernel.org,
        stable-rt@vger.kernel.org, Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [PATCH 0/9 v4.9-RT] Backports to fix random core
Message-ID: <Yv+oyqiBmKwtwH6t@T470>
References: <20220819092446.980320-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819092446.980320-1-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Aug 19, 2022 at 11:24:37AM +0200, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> in v4.9.320 some random-core patches broke RT. This is a series of
> backports to align with later RT versions and keep things working again.
> 
> Sebastian
Thanks so much!

--mark
