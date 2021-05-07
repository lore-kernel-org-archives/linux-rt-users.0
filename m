Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550D0C433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1701B61431
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbhEGQqk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbhEGQqk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:46:40 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B13C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:45:40 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 76so9064976qkn.13
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=NpbHGUT+ZRE4sm6sauG/izp+iGtuu6NP4kUqtRZ1T/Y=;
        b=RU8VYxo+D5aOE+2uXKvUs9SDInd/GH/TUYjadj0l7nhfAc04cjZrcdRcbfJvPf6sMW
         1DzcoZ6sXhDBolEtYbzMXQ75xJXBhgPB/8rCHM8OsNeNAkxXUhEj4MCbVGP2UcQkVmUb
         WTxLARlJKUrRuA/+ZE7ppjF9Gr2P8QZXV9RoO0TLw645m6dG3+8ISuH3f3JqwI0FLnO0
         cyAJWc5wqndDPLTtyYbtp7peY3beXzge3jgFX6eac6YUeVSdTeh7+9XfINFU9Wywd53H
         7pn0bblWTT8QFjO5REfT5mti2O9gTsZEKk1PxuUTsuE1fP7s0WBKutFPbD6LKJn9Gemw
         B2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=NpbHGUT+ZRE4sm6sauG/izp+iGtuu6NP4kUqtRZ1T/Y=;
        b=CcAM8rq5blAxx6VFxKMWLHK9uvnmpChm83Zys8AH5rds6uv/YgkRO5SMeyLuS36+2y
         TYIXheY8cddBM0s0r8OgdswC8URcHLomU8qLoz15hQmfRRCkifwCRNgmE8KQAX1lZBNL
         9GEFGjTyrinT04BYfyv934zm17bjGpzs8OHSGeXsyomA0aRHcFcFWTzoiDvS9towg2HU
         2lPxEHXEroU96CMhgz+CwSAwF73YyvUe6myrq4t4bfEtOe+j5tMPrlWtYPF+AHVOYE38
         NSZ64Fqf77PrmpIXOWANfGHLuR6b6VND6vopzklsjMGKkbymtTVF0UwEDiQX2yTOY3Q7
         KLsg==
X-Gm-Message-State: AOAM530iUNWpYZuW8tjcSOoTvAFc6T262dLNozrjZbvYvs54gxGyVo5Q
        LqQnW7MpHCweq0uDdYZ3BU8=
X-Google-Smtp-Source: ABdhPJwksB4kfT8TtCBaEtrW2YLlGSA0jnmFKaWc2e61ine9tc2WY9xykNvxlZYSltF4xT13dLvaEQ==
X-Received: by 2002:a37:9d12:: with SMTP id g18mr6143874qke.199.1620405939463;
        Fri, 07 May 2021 09:45:39 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id 2sm5398041qtr.64.2021.05.07.09.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:45:39 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:45:38 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 22/33] signaltest: Record start of test
 execution
In-Reply-To: <20210320183829.1318-23-dwagner@suse.de>
Message-ID: <7a7cd138-dd5-7c8-b0a0-5932c8d7aec9@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-23-dwagner@suse.de>
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
>  src/signaltest/signaltest.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index 6abf38b7821c..7327d0d0144d 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -500,6 +500,7 @@ int main(int argc, char **argv)
>  			      strerror(status));
>  	}
>  
> +	rt_test_start();
>  	while (!shutdown) {
>  		int allstarted = 1;
>  
> -- 
> 2.30.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
