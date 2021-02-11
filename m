Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C386C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Feb 2021 08:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EC0664E7D
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Feb 2021 08:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhBKIDn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Feb 2021 03:03:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:59372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229971AbhBKIDk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Feb 2021 03:03:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 233D3AE05;
        Thu, 11 Feb 2021 07:45:30 +0000 (UTC)
Date:   Thu, 11 Feb 2021 08:45:29 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Pradipta Kumar Sahoo <psahoo@redhat.com>,
        "Reported-by : Peter Xu" <peterx@redhat.com>
Subject: Re: [PATCH] rt-tests: oslat: print version string
Message-ID: <20210211074529.wxm66aeszzfs5gek@beryllium.lan>
References: <20210211044221.27851-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211044221.27851-1-jkacur@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -512,7 +512,6 @@ static void handle_alarm(int code)
>  
>  static void usage(int error)
>  {
> -	printf("oslat V %1.2f\n", VERSION);
>  	printf("Usage:\n"

Why do you remove the version string in the usage output. Every other
tool prints it?

