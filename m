Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E63C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 May 2022 11:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240935AbiEKLzM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 11 May 2022 07:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbiEKLzA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 May 2022 07:55:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF86131F22;
        Wed, 11 May 2022 04:54:58 -0700 (PDT)
Date:   Wed, 11 May 2022 13:54:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652270097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ik0+Jc80krWiudtLaGNDRbmUn/iIBLzgEWndCzx/YpI=;
        b=yM8YAfM761iJSlXTBG+cYM7dxLdwq9Yz5gROVT50m3CT1FZlNFH4KV6ute57MDfKE9MLLR
        PyFwQIqajTbevXyQJqVRTQZP64y6sjh1Z/coN5IDA0aA0K8hJtDT3BQGcWLudJXG9ZfK6I
        GCGLPeay7C2aC05OyjmfqbjSfYQk16sCV/V2YGxCxvYWsPSXSF2vr76QDPTLCLp4Kvklvp
        9UKvrtocrM+808KryTTTCKlUI/oRYtbK5m2PmXTWHQBw1JJvD9lZHwROHjlzsUKbBGft7w
        LGEtlV2urH/JRn43gB+1X303D88DmmzlyL6y5IXeUWsey6T26Els3fau438RkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652270097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ik0+Jc80krWiudtLaGNDRbmUn/iIBLzgEWndCzx/YpI=;
        b=Fn510XHqq7PmT/MhN4djHSJEujyLM+OrL0suSPcsJbAAQCRd11c6eeD6aXqZSQ+drM0wTg
        6k1GbnuRZ8Nle8DA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RT][PATCH 2/2] tick: Fix timer storm since introduction of
 timersd
Message-ID: <YnukEFBsOJqBnq9j@linutronix.de>
References: <20220405010752.1347437-1-frederic@kernel.org>
 <20220405010752.1347437-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220405010752.1347437-2-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-04-05 03:07:52 [+0200], Frederic Weisbecker wrote:
> If timers are pending while the tick is reprogrammed on nohz_mode, the
> next expiry is not armed to fire now, it is delayed one jiffy forward
> instead so as not to raise an inextinguishable timer storm with such
> scenario:

The series of two has been applied.

Sebastian
