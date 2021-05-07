Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0C3C433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5411F6145E
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbhEGQ4q (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhEGQ4q (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:56:46 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AB8C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:55:45 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id i67so9118724qkc.4
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=mVQ02uDE+DlOqdnxkBrA02QQyAZhjWboos5ckNWDR+Q=;
        b=fRnzECbELRCiyAczO1kM4TJWXwslgppSO29ll7wHVsJl/TaCErJgLILS0U5nDfnAVp
         2njpKqcBroeaP3SCU/PoOJvAx3ZN7JCpV0enOUUnmo/t5/Te/LH4iwyETJ4g7MokLbm9
         HiI0fcYGl1hu9QfzstY1oSgVfe8F99PhTIo/snnulLxHsqPZ116R9w4SSAJBWcl1ltEY
         to9G+AqHYksnLJS437xoburZTOd35ivC3pD3068z+v8DOyplV0yb3n7r+3SQ03muMf7u
         NqTF5gsj1M09Qv5gshbQ00kIUOqQxumeAr+YyaURPyDQHF7NBLEr2Iu5DF6qMgmrHsAa
         Zr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=mVQ02uDE+DlOqdnxkBrA02QQyAZhjWboos5ckNWDR+Q=;
        b=uMjbsd+YedaS73lAMvSAV2A6njTsZfLPVAgiZYCrimAwk91q4IP3i6BJ9zX3zozASy
         nViTIJPqxEe7/WmKnt+a7dmCVIjO/SFpTY4NH9fEJ6Aqwr0LDTKErT62gTORC9ApgxCV
         Iky2/rkjKoqQ2w8VEFw6ZjSnXlS1wVzadksVPZNvjI6VnM6oDvK7tsKW5mFegfTT8ned
         x8ofX6aVTqVHaZrWWiz1PC6Agqt5/CpFwVIZSBQHBtvbCf5YWX2pGIbFUdN3xq9eqJ6O
         E0om3SNUL7PtBmyS8WlXVBVuwH5ORGK7W/T+eyxuOL0efKhTUMeCXKiPFBNvipi4Z8bQ
         7T+Q==
X-Gm-Message-State: AOAM530E1q+syFLuf1xxoZRxqMSUGWh1BjxgLX7QOcX9zz6CgKvDlw4+
        yLgTnDgecznOnUCtFuyfNnI=
X-Google-Smtp-Source: ABdhPJyBlHA/wml4bFHRMSzznwHYBpbzWkUniW+C1ceqIjr8YPiCFxo7+IEFlHXldS7SoekBvj6u9Q==
X-Received: by 2002:a37:4496:: with SMTP id r144mr10487747qka.242.1620406545036;
        Fri, 07 May 2021 09:55:45 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id g7sm5076830qts.90.2021.05.07.09.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:55:44 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:55:43 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 28/33] pip_stress: Prepare arg parser to
 accept only long options
In-Reply-To: <20210320183829.1318-29-dwagner@suse.de>
Message-ID: <863ebc47-1af7-9db1-6a1e-21864d99f96@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-29-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> Introduce the option value enums to be able to parse only long
> options.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/pi_tests/pip_stress.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
> index ed034799da66..0831f698ff1d 100644
> --- a/src/pi_tests/pip_stress.c
> +++ b/src/pi_tests/pip_stress.c
> @@ -77,6 +77,10 @@ static void usage(int error)
>  	exit(error);
>  }
>  
> +enum option_values {
> +	OPT_HELP=1
> +};
> +
>  int main(int argc, char *argv[])
>  {
>  	void *mptr;	/* memory pointer */
> @@ -87,14 +91,15 @@ int main(int argc, char *argv[])
>  
>  	for (;;) {
>  		struct option long_options[] = {
> -			{ "help",	no_argument,		NULL,	'h' },
> -			{ NULL,		0,			NULL,	0 },
> +			{"help",	no_argument,		NULL, OPT_HELP},
> +			{NULL,		0,			NULL, 0}
>  		};
>  
> -		int c = getopt_long(argc, argv, "s:h", long_options, NULL);
> +		int c = getopt_long(argc, argv, "h", long_options, NULL);
>  		if (c == -1)
>  			break;
>  		switch (c) {
> +		case OPT_HELP:
>  		case 'h':
>  			usage(0);
>  			break;
> -- 
> 2.30.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
