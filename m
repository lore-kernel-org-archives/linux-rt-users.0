Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A573ECAAD2
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Sep 2022 21:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiIAVQ2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Sep 2022 17:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbiIAVQ1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Sep 2022 17:16:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62766EF01;
        Thu,  1 Sep 2022 14:16:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90349B8293B;
        Thu,  1 Sep 2022 21:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2418C433D7;
        Thu,  1 Sep 2022 21:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662066984;
        bh=X+gJcdZ9YPLa1BE3uX4TgQx40NOCborVQZJFGVa3iJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fFw6aH37IqXWz/hsME4RvNZf6/bEaZJ6jnp2etGPNCOiFZnK90LbzXmBwMsXiREnP
         3wAgnXdEEbOyXB6GlBY4cWDPYXxaYqgMhGNdmiqV9Kt4PnlsWjKIwMOY7xUFbaJWjH
         pIK0s37vYoOd32EhIW9QKCFvKcn+ni1gtnUnBxkPU9TpFsIsm4w7T7bNw1+nZQzUvB
         tLggnezYH0WHwhOCWyV4llZMMxvsmtQ9JoZW5pcXJL+ZE7v/W7/GndYn0rWcyeEDjL
         lyXpz0kj668HMuYP56FTKZhgcW5BtPVs7KxzFoaXTLOqzpDzCXXqQfX3xQyx0ZxPqQ
         7W/segMGH9tNQ==
Date:   Thu, 1 Sep 2022 14:16:22 -0700
From:   Mark Gross <markgross@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Mark Gross <markgross@kernel.org>, linux-rt-users@vger.kernel.org,
        stable-rt@vger.kernel.org, Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [PATCH 0/9 v4.9-RT] Backports to fix random core
Message-ID: <YxEhJqm40AIPxCTX@T470>
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
Sorry for taking so long to start working these.  Are these patches to be
applied to v4.9.320, or to the RT patches prior to the linux-stable merge?

Or are these patches the updates to the patches that conflict with v4.9.320 as
I rebase?

I'm guessing the latter as the patches don't seem to work on just the last RT
release or v4.9.320 directly.

Bottom line, I'm not sure how you expected me to use these 9 patches.

Sorry for being dense.

--mark

