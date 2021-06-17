Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C96AC48BE5
	for <linux-rt-users@archiver.kernel.org>; Thu, 17 Jun 2021 06:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81FBE613FE
	for <linux-rt-users@archiver.kernel.org>; Thu, 17 Jun 2021 06:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhFQGm4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 17 Jun 2021 02:42:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53454 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhFQGm4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 17 Jun 2021 02:42:56 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1109121A90;
        Thu, 17 Jun 2021 06:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623912048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qb9cSUVmkOTSXIohw7I1d84zyxgYIHlxnwVv6rpgo5E=;
        b=St4QvR5l/jE5w78HYutDQW9Qp44ypFS0KpB7UvwaG8I90phxQDnUgyL3v+7x162E+OTQ97
        kMKNWXQbH0/S/eYqPkp8EiWNjwZj2X7pBx+v+68AL9LLnCj/7ORQ6xydLnNc03MdnEKvr8
        ldIqvvpZ9yq/2PLqlVXutRPwEM3dT/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623912048;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qb9cSUVmkOTSXIohw7I1d84zyxgYIHlxnwVv6rpgo5E=;
        b=3vAlObH4we5KZeKgnmgSFTe82z83R/EVUpUYuhg9Gwx8SHFDRxkQ1brfu40els0gh+cnrP
        XE2I3zZtD/GWaABw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id E1303118DD;
        Thu, 17 Jun 2021 06:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623912047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qb9cSUVmkOTSXIohw7I1d84zyxgYIHlxnwVv6rpgo5E=;
        b=mN756NTy0/cOWBQCY96jPqi5clfpLfreow8/VX/RKHYdbkIdXCYniClWbJGsRbXs6LGKdU
        /Nr525EuEM2c4ChLxcXCgAYXWS5/BWPXH2pmqkSxUbpi93FQxwdvpewoznrElh1YnbsPJ8
        r7JExMOQfTmj1TddBAncs/KaE38erVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623912048;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qb9cSUVmkOTSXIohw7I1d84zyxgYIHlxnwVv6rpgo5E=;
        b=3vAlObH4we5KZeKgnmgSFTe82z83R/EVUpUYuhg9Gwx8SHFDRxkQ1brfu40els0gh+cnrP
        XE2I3zZtD/GWaABw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id O+13Nm/uymArawAALh3uQQ
        (envelope-from <dwagner@suse.de>); Thu, 17 Jun 2021 06:40:47 +0000
Date:   Thu, 17 Jun 2021 08:40:47 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Jonathan Schwender <schwenderjonathan@gmail.com>
Subject: Re: [PATCH 3/3] rt-tests: cyclictest: Add entry for mainaffinity in
 the manpage
Message-ID: <20210617064047.glshmt3r6phsrfjm@beryllium.lan>
References: <20210616231800.19228-1-jkacur@redhat.com>
 <20210616231800.19228-3-jkacur@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616231800.19228-3-jkacur@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

On Wed, Jun 16, 2021 at 07:18:00PM -0400, John Kacur wrote:
> Add an entry for mainaffinity in the manpage.
> Tweek the output in cyclictest for mainaffinity as well.
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  src/cyclictest/cyclictest.8 | 3 +++
>  src/cyclictest/cyclictest.c | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index 4fe42e502535..abc56e8e4970 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -94,6 +94,9 @@ Set the number of loops. The default is 0 (endless). This option is useful for a
>  .B \-\-laptop
>  Save battery when running cyclictest. This will give you poorer realtime results, but will not drain your battery so quickly.
>  .TP
> +.B \-\-mainaffinity=CPUSET
> +Run the main thread on CPU #N. This only affects the main thread and not the measurement threads

Nitpick: the .RI section is missing the --mainaffinity.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
