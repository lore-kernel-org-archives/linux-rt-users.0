Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491D7C2B9F4
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Jun 2021 14:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3233661C76
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Jun 2021 14:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhF1OPk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 28 Jun 2021 10:15:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47302 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhF1OPk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Jun 2021 10:15:40 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 036A422498;
        Mon, 28 Jun 2021 14:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624889594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u+mHKq7qTTJCoVp4riFxvnW5aDGyigNAF0z1SpQNLpI=;
        b=GYeAUuIvOglBswcJ6jcRaESdDDwXafBYYFFe+ILYBN+Ly/PlYlolrovHsmzTmjbVr6wdRa
        DhmPzXqBVBcfFCyySSwT9QbpCFLMBFORj9OtZwmTrMka/KDp6UwrwZ9NTdjIKwFWNze2fM
        VB8y1EJd9NSWFNvWzH0HlVAHQrNCIAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624889594;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u+mHKq7qTTJCoVp4riFxvnW5aDGyigNAF0z1SpQNLpI=;
        b=86swravYrb0sUf0IfviqrwIuMHLhO/tnGiC8S/yaGR8fxMtSKKleUL5bWC9oVJkTs6UbiR
        OTUo3tla1Cwjn0Cw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id E801811906;
        Mon, 28 Jun 2021 14:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624889593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u+mHKq7qTTJCoVp4riFxvnW5aDGyigNAF0z1SpQNLpI=;
        b=EkpMQCIuybFAPsF4B72o0VGO/jl85VFH4iNASylyYgw13ytPhj8Lw9DRVNVAwM77XKqD+9
        J+odxaKWcr60oUWfDM/q/6jRO89sWYsfBLHnJpCth+dhxCP3Fm5vUhExESmkqC9yj0UqQU
        Z07T9P6WE3JTO5QWz93Ptv3SIip8Blc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624889593;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u+mHKq7qTTJCoVp4riFxvnW5aDGyigNAF0z1SpQNLpI=;
        b=7KdjcoOY1/zsSeaVjSyHo5trgte3+Kv6IjgpfqRI6j8UJ7zRVlDM/GJq9WbrjXPiR5QYjk
        KjVPaa3XL7eXvsAg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id SemMOPnY2WAkBAAALh3uQQ
        (envelope-from <dwagner@suse.de>); Mon, 28 Jun 2021 14:13:13 +0000
Date:   Mon, 28 Jun 2021 16:13:13 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Daniel Wagner <wagi@monom.org>, Mike Galbraith <efault@gmx.de>,
        RT <linux-rt-users@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Johnathan Schwender <schwenderjonathan@gmail.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [ANNOUNCE] rt-tests-2.0
Message-ID: <20210628141313.3fixpscbdc4ugnld@beryllium.lan>
References: <20210625160801.9283-1-jkacur@redhat.com>
 <549a4a5579068b9b1ca7741cb0f4aafbd04f4389.camel@gmx.de>
 <1c1966dd51ae6f8ddcd892cba485c332281fbd37.camel@gmx.de>
 <3d6a6c593eed6f5d59209ba2d8db29fadcc72ad7.camel@gmx.de>
 <20210628081135.l7yvya7iaygb23ye@beryllium.lan>
 <f31d9d37-df6d-90b0-8bf9-95156c27e8d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f31d9d37-df6d-90b0-8bf9-95156c27e8d@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Jun 28, 2021 at 09:50:25AM -0400, John Kacur wrote:
> > I'd say the tsbuf access is the one which triggers a pagefault.
> > 
> > John, I would suggest to move the rt_test_start() into rt_init() and
> > take the timestamp at the execution start (as my initial version was). I
> > think the additional pain in slightly more correct start timestamp
> > (which is also not defined what it actually means in this context) is
> > just not worth the effort.
> > 
> > Thanks,
> > Daniel
> > 
> 
> Send me a patch, and I'll have a look. The timerthread()function is
> sensitive anyway, so it's probably a good idea not to put that kind
> of thing there.
> 
> Note that the the code following the /* Get Current Time */
> is getting the time, but you probably want something rougher that
> you can call strftime on?

I think it's just the buffer strftime is writting into it. The page is
probably not mapped and hence the pagefault in the first access.

Anyway, I'll send a patch which moves the rt_test_start() into rt_init().
