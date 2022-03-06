Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C148C433F5
	for <linux-rt-users@archiver.kernel.org>; Sun,  6 Mar 2022 10:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbiCFKgy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 6 Mar 2022 05:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbiCFKgy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 6 Mar 2022 05:36:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756D341FBF;
        Sun,  6 Mar 2022 02:36:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA708B80E5C;
        Sun,  6 Mar 2022 10:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB06C340EE;
        Sun,  6 Mar 2022 10:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646562959;
        bh=gvEYtQYF7ha3DiR4nG7noqhI3AFlwCUzsE5pl8SAOVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pw7oNzVz8iktT3an9ByXr3nocIiWUaUSqcaSHI4LWojeQCmrtBaH3VwTfmUv/VTai
         9drPYcAZz2gQGAjZxNpa2nXXtSe5Nd0oRERD9U411fpL7DF/QbW79zylOCaAzv88O1
         UwhFY8W/m3T9Wl0W89NlboE2etDlo2AZFJIcB7Ak=
Date:   Sun, 6 Mar 2022 11:35:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yunhao Tian <t123yh.xyz@gmail.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: PREEMPT_RT causes scheduling errors with f_rndis USB gadget
Message-ID: <YiSOjGLzMCvKOm0G@kroah.com>
References: <CAFQXTv2B10=i6DMV1iJpOT-Mj9F93hOi_415cn49N6X_yDFw2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFQXTv2B10=i6DMV1iJpOT-Mj9F93hOi_415cn49N6X_yDFw2g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, Mar 06, 2022 at 06:17:54PM +0800, Yunhao Tian wrote:
> Hi everyone,
> 
> I'm using Linux 5.15.24-rt31 kernel with PREEMPT_RT enabled, on my
> RK3308 board. I set up f_rndis gadget with the following script, and
> plugged my board to a x86 Linux computer running 5.15.25 kernel:

Does the same thing happen with the non-rt kernel?

thanks,

greg k-h
