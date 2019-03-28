Return-Path: <SRS0=3N3c=R7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE82C43381
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 14:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43C221773
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 14:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553782716;
	bh=raNP0o0LHAF54cnpBluCD+15Xf5D06acnuWxoMSOBIk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=fRW9f6+Hp/UZTo+Ujjs0IHMw3gL2KhigK3rcNsNwgsnHK6CITterjrvaO7zKY/om6
	 wtfBwPL1AYEl+rMTOdeihxyP1M+ITw9JghfJCyQo+2RMEKnewTa8bZ6UtQkhSYEM1R
	 YfEcrcw7Wm3pTqDAzybWsc4i9fsFWCq35tdvfYD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbfC1OSg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:18:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfC1OSg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Mar 2019 10:18:36 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5355E2075E;
        Thu, 28 Mar 2019 14:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553782715;
        bh=raNP0o0LHAF54cnpBluCD+15Xf5D06acnuWxoMSOBIk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=q33SWZVqPCQE9IuzO0uCjCEl81rAIyt7uOV3hJGPLIHNpcxPhCtSgoDD4h7GR8QMg
         8BGnbRV7x0bnqN/+1BN9ulBmg1LYhyg314C68P4ljGejg9rsTJV9/C6PiLd8XS2QKX
         SbVy6VUzkI3sPnvVaAJ1Gh3t4dN1c0MJf0FNsNd0=
Message-ID: <1553782714.2655.2.camel@kernel.org>
Subject: Re: ARMv8 fp register corruption in 4.14 PREEMPT_RT series
From:   Tom Zanussi <zanussi@kernel.org>
To:     Allen Martin <amartin@nvidia.com>
Cc:     linux-rt-users@vger.kernel.org, anup.pemmaiah@gmail.com,
        bigeasy@linutronix.de
Date:   Thu, 28 Mar 2019 09:18:34 -0500
In-Reply-To: <20190327213555.GA16845@nvidia.com>
References: <20190327213555.GA16845@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Allen,

On Wed, 2019-03-27 at 14:35 -0700, Allen Martin wrote:
> Hi Tom, I can confirm the ARMv8 fp register corruption reported here:
> 
> https://marc.info/?l=linux-rt-users&m=153930857708206&w=2
> 
> still exists in 4.14.106-rt56.  I was able to reproduce this on both
> A57 and Carmel ARMv8 CPUs using the float_bessel subtest of
> LTP.  This
> fix was to backport the following patch from 4.18.y-rt to 4.14-rt:
> 
>   3afdfe419c33c1655d0763e070350aad44416594
>   arm64: fpsimd: use preemp_disable in addition to local_bh_disable()
> 
> Are you able to pick up this patch into 4.14-rt?  I'm sure Anup and I
> are not the only ones who are hitting this.
> 

Yes, I was just about to start a new 4.14 update and will pull this one
in.  Thanks for letting me know.

Tom

> -Allen
