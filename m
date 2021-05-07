Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA34C433B4
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A5866145A
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbhEGQp2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhEGQp2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:45:28 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ECCC061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:44:28 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id q136so9055223qka.7
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=MhccmEp2DRAQDkUjO3xdma6maMUM8BQw14d3cLAVRTQ=;
        b=Puloytu0NrxQgU3yYAJ2J+6yQnkN3KWLCvzMySGwWmR6SWvQLYX2MTpIJmTDrucDmM
         8FyPx/G73YRGAS1b6u9d3XhEMv9fuPMXZpfBSGOIjg0AEhd1p7eYjnc3l1c4Dn07oquE
         SK2zDCTmEVOM7iXPKOyq2oe7kjMC+RCxlR8naM8ixjtRCFyqVuzL/LP8jzJjcPxET9g4
         6lNC3G6h4wHbS4MDiHFFTn2tKMU0A4BdtlZ7qoi8B8clHx/WtjaepmuvhV943JdhoTyI
         WMyyLpWXInQmmtl9CMwC6gbUgY66ontYqgEnavLhdg+P5oBmJPlepoZufDsXLCSvIkKr
         Takw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=MhccmEp2DRAQDkUjO3xdma6maMUM8BQw14d3cLAVRTQ=;
        b=ZlA6eA2pT8T5WDz/mgDWVejwOoc8QJPjihoNAKK5HRI98CJikMaT7vvAB3pDsUz58V
         W9HcfU7GPyhtgpq0NKwvqvl+KmyaWBW0Hra3d843s/2+ov5zJEyafttQ44UDGTGKLvO+
         tF+wKqbrBym++5+MAyxIKBHVmOXXdcRs4WdDA4yhY9fUaNyJKYgJzB36LEVKADcKIXEc
         JY+e8ACHJEKY7ruxN4GkUw+Lek2kLxd9yGIZlrL4iYXtSdhTk0K0nQp38JtSWCqtMyhJ
         EZ9kCC3xnk6BRYV9Or/NQ6OhwAR/zst3u9DIbjYGvC6+D2POEx1sgr0o9nSYwbQnLNiH
         TNLg==
X-Gm-Message-State: AOAM531GrmAifgok1c0e9MRQ8VFXVpaBTuefcQQwM1nWSuMY/XGN8oIE
        vNa7jFtSOgNqGPVjHcNrcig=
X-Google-Smtp-Source: ABdhPJyrkZMpriqKRpgwSnDpfHyU1L//5etwfuRI41UW57qj0BmPdOzG46VHJGwOUhf5IW26Igasjw==
X-Received: by 2002:a37:8246:: with SMTP id e67mr10662961qkd.410.1620405867782;
        Fri, 07 May 2021 09:44:27 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id q13sm5311204qkj.43.2021.05.07.09.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:44:27 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:44:26 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 20/33] rt-migrate-test: Record start of test
 execution
In-Reply-To: <20210320183829.1318-21-dwagner@suse.de>
Message-ID: <6ef6c080-b6c-d7a-97a6-a85a70b827f4@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-21-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> Use rt_test_start() to record a timestamp when the test starts.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/rt-migrate-test/rt-migrate-test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
> index cdfbfafb200b..8f628d347a23 100644
> --- a/src/rt-migrate-test/rt-migrate-test.c
> +++ b/src/rt-migrate-test/rt-migrate-test.c
> @@ -621,6 +621,7 @@ int main (int argc, char **argv)
>  
>  	setup_ftrace_marker();
>  
> +	rt_test_start();
>  	for (loop=0; loop < nr_runs; loop++) {
>  		unsigned long long end;
>  
> -- 
> 2.30.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
