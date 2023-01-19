Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59932C46467
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Jan 2023 18:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjASSYq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Jan 2023 13:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjASSYo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Jan 2023 13:24:44 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A061A8386E;
        Thu, 19 Jan 2023 10:24:43 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 02183141143;
        Thu, 19 Jan 2023 18:24:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6621F1410BE;
        Thu, 19 Jan 2023 18:24:42 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1674152682; a=rsa-sha256;
        cv=none;
        b=FzboCCTPoGW8k90iF9zhaKMlZfwycAtoBKNrvJrvdBEMlXWgTnwe1PXLTOFKoBx8qDcP/F
        PfE0tBQnMqJ86P+gtGlGejn6jlpa3ICA2pSLDGJHty+r2m3rPXtjt7cL/4AOgVGqVraCZM
        87pKSo3YgBdP170c/e/ghWN8rlHXXVsZ3G4tn54HHijfG8hVvnINaV/6mmLJx5BH/JklYZ
        q5lnW+TKhPfxTKTF/6tElk65SMl5E6hcGiewCQNyclOuUFvOHtM5GA904MaV7vBnu/mftS
        6c/FkfkAQFOOdepQn0gOOJ+q7MNbglH0AfuKGmyESJNOlIKFdgu8/k5lQIWIMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1674152682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=XdMCywKhvt+qgNHKB6pCT4yp65QZ8oX82WvstHDKH30=;
        b=ZRk54CbRXx6xPdPvw0WV51MqLmlMrZFOgIxpaXy/lsN/zGhzP/Hw3OCeabw+zsBBLpkxq2
        Lf8usi+9kBU8bBR8bEAuSWFqBMnORBeh7iPyVwwAwBekQoYiOlNhOlH45ZHuSpwPLJfmXN
        QAx/j6zu/2cA8WQN6PFu6XwEe7HaWbM4EN1HtHV8JtZl7eXvty9vE48VgRJxQJSTynpq5R
        4LqX8AcZhdf1bmANO3fqUSdnrDEd12kjPTbCisIDtWBjV5htLdLpEfoR+gk3ueQWIuBHng
        P1GCkzGgdVxsglqT6+JzP8lT402yqNyqagUMheHrFBWoZb4msPa/jzrH5ZIq9w==
ARC-Authentication-Results: i=1;
        rspamd-7cf955c847-wgrhk;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Grain-Ski: 490dd1944f14967c_1674152682755_1281930886
X-MC-Loop-Signature: 1674152682755:2371508031
X-MC-Ingress-Time: 1674152682755
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.227.166 (trex/6.7.1);
        Thu, 19 Jan 2023 18:24:42 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4NyWHs4t1Jz1W;
        Thu, 19 Jan 2023 10:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1674152682;
        bh=XdMCywKhvt+qgNHKB6pCT4yp65QZ8oX82WvstHDKH30=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=jjejct0Fx77WUGSvJWm7DekSBheCTBqNgNtsWoa5iuj2wsftfyPDonmIBb1Ynp7Iw
         CUVTuCY2BfJEWDO1l8aW5QnVNDiFAoeClhaIePIcmmb7214C8CUm/OuRZHYY/5Mdpj
         qHtS4Wg4JwjYeOYp5tutwgmrb6sIC7iJMScomjdcdBo0n+gkKHWObwPn7YGiQH9qwh
         4qIw9srqsUMv++7KQZeD4T3/KSqTDwi5mLaqImOncg+8/ThYVCwu9Mex2xOQgtAPcx
         AJWU0xdHTG/Zcml6GI6TLz5Eo4d5UohJR8DjboyoU838lPy27LVdSfj4/R4szbfUpg
         GXs8R4puNIFXg==
Date:   Thu, 19 Jan 2023 09:58:18 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <20230119175818.2rc4uvxkr3o6u37o@offworld>
References: <20230117083817.togfwc5cy4g67e5r@techsingularity.net>
 <Y8avJm1FQI9vB9cv@linutronix.de>
 <20230117165021.t5m7c2d6frbbfzig@techsingularity.net>
 <Y8gPhTGkfCbGwoUu@linutronix.de>
 <20230118173130.4n2b3cs4pxiqnqd3@techsingularity.net>
 <Y8j+lENBWNWgt4mf@linutronix.de>
 <20230119110220.kphftcehehhi5l5u@techsingularity.net>
 <Y8lvwKHmmnikVDgk@linutronix.de>
 <20230119174101.rddtxk5xlamlnquh@techsingularity.net>
 <20230119174818.up7haooxje4nzusu@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230119174818.up7haooxje4nzusu@offworld>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 19 Jan 2023, Davidlohr Bueso wrote:

>On Thu, 19 Jan 2023, Mel Gorman wrote:
>
>>The race could be closed by moving wait_lock acquisition before the
>>atomic_sub in rwbase_write_lock() but it expands the scope of the wait_lock
>>and I'm not sure that's necessary for either correctness or preventing
>>writer starvation. It's a more straight-forward fix but expanding the
>>scope of a lock unnecessarily has been unpopular in the past.
>
>Curiously, this is the documented behavior:
>
> * down_write/write_lock()
> *  1) Lock rtmutex
> *  2) Remove the reader BIAS to force readers into the slow path

Nevermind, this was the rtmutex, not the wait_lock, sorry for the noise.
