Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA31FC4338F
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Aug 2021 07:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE3A611C6
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Aug 2021 07:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243490AbhHFHA5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 03:00:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57400 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243487AbhHFHA4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Aug 2021 03:00:56 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AA257223B4;
        Fri,  6 Aug 2021 07:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628233240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gYRfQFPpoeE3yf0K02MkpUYYoJO/tHcf+RG54xZmCHk=;
        b=BzoeWUbMxehopPuLIzfy40/SOYFdeAUqBAmbSxgz61X7nwM0VDHeDiBw9PljFMgjBI+6fd
        Bbk2M35SVDHwwyY1PS8wRvkfONiJPVtTQJlFC5vRayqmbKURt/VXARekFKu4HHjronaemJ
        Xc08QcCE32vY8Gh+smUMi+FBt28cSsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628233240;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gYRfQFPpoeE3yf0K02MkpUYYoJO/tHcf+RG54xZmCHk=;
        b=3srs4CvwJw+Zc+6Q66HHQT50/TI2aIBLvvXR/daUZCv8YnIFUecLP0A4xk7OK0FpamogSK
        s29jaQZXw0vFcfAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9ACA9136D9;
        Fri,  6 Aug 2021 07:00:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id EIK6JRjeDGGbDAAAGKfGzw
        (envelope-from <dwagner@suse.de>); Fri, 06 Aug 2021 07:00:40 +0000
Date:   Fri, 6 Aug 2021 09:00:40 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Alison Chaiken <achaiken@aurora.tech>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: hyperthreading and RT latency
Message-ID: <20210806070040.ryvka6lnpn24ink5@beryllium>
References: <CAFzL-7sj+Y79UC-CnB+6qDRe7EgPnjb0be63CwEJOfkdCvJYVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFzL-7sj+Y79UC-CnB+6qDRe7EgPnjb0be63CwEJOfkdCvJYVw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Alison,

On Thu, Aug 05, 2021 at 01:16:17PM -0700, Alison Chaiken wrote:
> The advice in the RT wiki
> 
>     https://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application#Hyper_threading
> 
> about configuring the kernel and building RT applications was written
> in 2014, when we were on the 3.x series.   That makes one wonder how
> relevant some of it is for the 5.x series, especially since processors
> in common use have changed some since then.  Some of the advice,
> notably about power management, obviously is timeless.
> 
> In particular, Daniel Wagner added:
> 
>     https://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application#Hyper_threading
> 
>     "Hyper threading and also out of order execution of CPUs introduces
>     'random' latencies. As mentioned in power management, it is
>      recommended to disable these feature (if possible) or carefully
>      benchmark the performance."
> 
> Is the advice still current?

I don't think the situation has changed. Though, I don't run these test
on modern hardware on regular basis. The last time I played with it on a
bit more modern hardware it was still measurable by cyclictest with
hackbench as workload.

> Should we RT-users all still turn hyperthreading off?

Obviously, it depends on your use case. If your application can tolerate
the added noise by SMT, you don't have to disable it.

> Given the security vulnerabilities associated
> with hyperthreading, there are clearly some use cases where doing so
> is indicated anyway.

Again it depends on your use case.

Daniel
