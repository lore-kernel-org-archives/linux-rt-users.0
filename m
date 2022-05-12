Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09802C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 May 2022 05:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349661AbiELFwW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 May 2022 01:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbiELFwU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 May 2022 01:52:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB291612A6
        for <linux-rt-users@vger.kernel.org>; Wed, 11 May 2022 22:52:19 -0700 (PDT)
Date:   Thu, 12 May 2022 07:52:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652334737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cl0Q7G/E3IGAWAkntR3r3aS/8iPPqNz2YDe4iEavShE=;
        b=uOumCxhFxfBdlpQyhQUH6E6V0Gb+TUw+Hyzw5OXTMCDKz+R0NGKn2ZiPywP2S3MMKERZZF
        nAeibbOUnWpQvMtLozrDQTFseUd95Es1lIpVvWazfxueEkL5nJ2JXWQa6bgEr6YyOm0fdt
        aEzcTCUiduFkkvpyY2ju546jBMY+z7MBNTIuZedv8dRJtclfAsQ7HGWg7UcECBDyIHMZjN
        EEH+D+GJe4FIHtH3V6cKuScdjWMQvByK5YGwL3KWxjSWssF/oVrVZMbzMGYEkQYivF5ncm
        wCOhjrUrL80MKNtpuf77+nN4ULWizU1Tkx6dWWBOSyp1iq2x033kBOJV2+zGVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652334737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cl0Q7G/E3IGAWAkntR3r3aS/8iPPqNz2YDe4iEavShE=;
        b=nRjxJeDMTF8/zSF3lrGAKJxVPztxTr7Ca9erwLk1m8cssZ/Y4tmhuilJjsI+GqiBwlRvqV
        V9+Nn5g//XrAZEAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Yimin Deng <yimin11.deng@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Oops or bad page in page_alloc.c
Message-ID: <YnygkFUIdOo1DpBm@linutronix.de>
References: <CAAh1qtktzZQxXp_t43YhxL6FZTS58rn_xvK2Zrq33-s3=j_sGQ@mail.gmail.com>
 <Ynvh8Nh7hyp4tSKk@linutronix.de>
 <CAAh1qtme2Lefj5XZsNoPOmGqhjcf=qkWzs3z_=tbYH209QgLyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAh1qtme2Lefj5XZsNoPOmGqhjcf=qkWzs3z_=tbYH209QgLyQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-05-12 11:55:49 [+0800], Yimin Deng wrote:
> Hi Sebastian,
Hi Yimin,

> Thanks a lot for your quick reply!
> 
> CONFIG_HAVE_PREEMPT_LAZY=y
> CONFIG_PREEMPT_NONE=y
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT__LL is not set
> # CONFIG_PREEMPT_RTB is not set
> # CONFIG_PREEMPT_RT_FULL is not set
> 
> CONFIG_SLAB=y
> # CONFIG_SLUB is not set
> # CONFIG_SLOB is not set
> 
> CONFIG_PREEMPT_RT_FULL is not enabled, neither CONFIG_SLUB. I think
> it's not related to the issue fixed in f1aca90802af9 ("Revert "slub:
> delay ctor until the object is requested""). We share the kernel
> source code but using different configuration on different products.
> The applications on this product are non-RT applications.

If you are not using PREEMPT_RT at all then just remove the PREEMPT_RT
patch. Then you will know if this error comes from the patch or not.
It might be something that effects !RT configurations.

> B.R.
> Yimin

Sebastian
