Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EC3C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Jun 2022 15:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346834AbiFOPWy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Jun 2022 11:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244213AbiFOPWx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Jun 2022 11:22:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E515626AD6
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Jun 2022 08:22:52 -0700 (PDT)
Date:   Wed, 15 Jun 2022 17:22:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655306570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7IzuM0uJafA2prtp0UsSnD5cE1QDKAQOLt41/xYRUQ4=;
        b=ThPzR/5phMXGTNM+jaW8Hr+g4KMq0uV+UglBFyNHg1n8GBWNU2SaV+Qdr9PDfMhpL+y+0q
        y1k1I1KVHwQCHK5/bNg+PfpftV8Kv/Ev3AoqGnzw0qNCkihi+BhzsHScNRGnejvgA/bt1V
        o2tLTjTi8sousYmloGDMDJg15Yv94NiAHmXQjCEHBDUK9tPs4j9V71aSICiSj32IipvIyP
        iFXPB5oqzvVWJsSWJuNLClG27i8zJVEmePgAYJQZf8+h0Z4BXntN/7YVaQMJfYaSgXvHaD
        zLooAfYX/LTxbrxthxaeOyMWHyIRt4TE8NvCA9iK8nZpvdLGIC0FNce2b8R8oQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655306570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7IzuM0uJafA2prtp0UsSnD5cE1QDKAQOLt41/xYRUQ4=;
        b=x2G08tpBSiK1KGTdNUR7vb7etvfIbNzH22M9sdjXC2SqljbSEunxEvs5PF5xvVV1Ag/3Ye
        +Z48uK/SraDZqKDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] cyclictest: Delay setting of main_affinity_mask after
 creating threads.
Message-ID: <Yqn5SGdIHNwMREU/@linutronix.de>
References: <YqnExv0GkIKTSwoI@linutronix.de>
 <19f21e80-ce44-07f0-2361-ece8e6a60ad4@arm.com>
 <YqnqcQmELgKYlwWA@linutronix.de>
 <13ae4a81-8bac-0ece-f970-44ca7ddcbf7a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13ae4a81-8bac-0ece-f970-44ca7ddcbf7a@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-06-15 17:18:55 [+0200], Pierre Gondois wrote:
> > If this is *that* important I would lean towards always doing the
> > globalt_barr so all threads start once everything is set up. If I
> > remember correctly, the first few cycles are not counted and just fill
> > the cache.
> 
> Ok yes, I didn't see the globalt_barr barrier. FWIW I tested
> the patch and it works well.

The globalt_barr isn't enabled by default. If that is important then I
recommend doing this by default. I can post patch if you want me to.

> > 
> > > Regards,
> > > Pierre

Sebastian
