Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3159AC433DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Jan 2021 01:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83152343B
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Jan 2021 01:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbhAMXx4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Jan 2021 18:53:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729638AbhAMXwr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Jan 2021 18:52:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 050EC2250E;
        Wed, 13 Jan 2021 23:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610581824;
        bh=n7YXgMJK4exfAdhH0ZlRuWIleZ/O3yTamEthjIUsP5c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qTZvVGHO5xkgxLTNWBficKuvKvJ2AJvrzQz3PZkBU4r6hmI/HI9b8x9wDGzlGBBcY
         DYN7ivH/SZg/kSHslr0oEgV0ZiCU/ZPkkaDwh9eiViCOLJj65ZV0GDOdlbYV6J6mC0
         V6Rwbi4vhK4PRxVWG2qBiNhH6nbIR2mZbiApCpvefyt651eGs7DZSWviACy9e3O9jU
         p9Q5hdBMbliTrUe0y4CYPa/YMIze5rGBVLfIkSphLCz0JOx3sWxv+N8SX8htJTjsuj
         kCBQPZ2Ch4brgC0WfehQ8zKr1JPivxVSYqwcWvcX7riCaq3DTuOgANvCAY77mSowcI
         lilxyC/d9qzPw==
Date:   Wed, 13 Jan 2021 15:50:23 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sebastien Laveze <sebastien.laveze@oss.nxp.com>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: use __napi_schedule() for PREEMPT_RT
Message-ID: <20210113155023.1f52ee4f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210112140121.1487619-1-sebastien.laveze@oss.nxp.com>
References: <20210112140121.1487619-1-sebastien.laveze@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 12 Jan 2021 15:01:22 +0100 Sebastien Laveze wrote:
> From: Seb Laveze <sebastien.laveze@nxp.com>
> 
> Use of __napi_schedule_irqoff() is not safe with PREEMPT_RT in which
> hard interrupts are not disabled while running the threaded interrupt.
> 
> Using __napi_schedule() works for both PREEMPT_RT and mainline Linux,
> just at the cost of an additional check if interrupts are disabled for
> mainline (since they are already disabled).
> 
> Similar to the fix done for enetc:
> 215602a8d212 ("enetc: use napi_schedule to be compatible with PREEMPT_RT")
> 
> Signed-off-by: Seb Laveze <sebastien.laveze@nxp.com>

Fixed up the commit message to appease checkpatch and applied, thanks!
