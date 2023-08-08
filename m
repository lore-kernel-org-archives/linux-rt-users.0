Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A781C001DB
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Aug 2023 19:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbjHHTeB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbjHHTdk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Aug 2023 15:33:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A5B2D5E
        for <linux-rt-users@vger.kernel.org>; Tue,  8 Aug 2023 11:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691521118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qHUrSn/4FHcytXUlMEVnt9uArhOzFLfCV0XsRhN2Ld0=;
        b=DXNhf6wXYzrYooArSjQOtzx0MMA1EoW6gpIPMHyvJThRCNcoiUnprvLa4c6OufL/e4eMk6
        CvvyurDwm9Ns1iF1UzJh3waFRuQdVRSVF/P8lVNnuqn3k9dG6rQQ5ICrN/Tcq9vJTCcebc
        sUVb9e7lCctwDggBGdWznvEs6On2sqI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-WddCEoduNTaKZgU-amI88g-1; Tue, 08 Aug 2023 14:58:36 -0400
X-MC-Unique: WddCEoduNTaKZgU-amI88g-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-40ff89fcb76so48872111cf.2
        for <linux-rt-users@vger.kernel.org>; Tue, 08 Aug 2023 11:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691521116; x=1692125916;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHUrSn/4FHcytXUlMEVnt9uArhOzFLfCV0XsRhN2Ld0=;
        b=PYnpu9TUtaHzXX1kmRgzDpT7FIWWWgBAeteEGU9tZE4yEc3oyatBAN18LKlGSa9shR
         dAsSQ68hge4+x+emgpnix8LW+YHLX+NnBom0TuSvctAHpO2U+ZhCEturnrgM7ImZlSGt
         OyLCfyJQn7WGgBD0c9Y8pOuVNs0Q+NZz59WN44RYl/+qvyTOc4cyQFVWSanua+Qyd7wB
         S5rhgWLpX6vcAXVLiNrdAjAczuaB03zL/3tCnHPOfWeGb2cOkes5z+zYKH/vHlIzRIzl
         nMDrYzCMTwxCqb+6Bd3BP4Y1nNHHhzi9cgeewfJ1P9FgWE8v0FwimQ+2vTMlzQtmmqcQ
         Okbg==
X-Gm-Message-State: AOJu0YxqzNr9Dzcd4AosW2Xr+4AEIAom5biutIFIFQ5wNinTMkpZu0dc
        KIcPS5Zmy6VkgsDN3/mofR4FFYiKaj4pu4QZCxsU3MAjKyyDYZKOFF9zOvN03zP6fU5p6/Dkct+
        558fnrPEeFdhPCYwU4hLW89kHKjw=
X-Received: by 2002:ac8:59ce:0:b0:40f:2e2c:6df4 with SMTP id f14-20020ac859ce000000b0040f2e2c6df4mr868434qtf.6.1691521116040;
        Tue, 08 Aug 2023 11:58:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRhJYCNPYGTdH3qNjuGQSm4p27eSdnv09CbLZ6Z3TNY2byM4wmXmOie10Qp5PErivbDiEygQ==
X-Received: by 2002:ac8:59ce:0:b0:40f:2e2c:6df4 with SMTP id f14-20020ac859ce000000b0040f2e2c6df4mr868422qtf.6.1691521115840;
        Tue, 08 Aug 2023 11:58:35 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-157.dsl.bell.ca. [184.147.140.157])
        by smtp.gmail.com with ESMTPSA id a5-20020aed2785000000b00407ffb2c24dsm3568046qtd.63.2023.08.08.11.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 11:58:35 -0700 (PDT)
Date:   Tue, 8 Aug 2023 14:58:34 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org, kcarcia@redhat.com
Subject: Re: [PATCH] cyclicdeadline: removed unnesessary text in usage
 message
In-Reply-To: <20230728152955.48977-1-ashelat@redhat.com>
Message-ID: <30b8b1e0-f73c-cd85-257e-3eec5a86f5ad@redhat.com>
References: <20230728152955.48977-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 28 Jul 2023, Anubhav Shelat wrote:

> removed unnesessary text in usage message
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  src/sched_deadline/cyclicdeadline.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index fbe3a75c60b8..4b4050fcbbb7 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -685,7 +685,6 @@ static void usage(int error)
>  	       "-a [CPUSET] --affinity     Comma/hyphen separated list of CPUs to run deadline\n"
>  	       "                           tasks on. An empty CPUSET runs on all CPUs a deadline\n"
>  	       "                           task.\n"
> -	       "                           on CPU 4, and thread #5 on CPU 5.\n"
>  	       "-D TIME  --duration        Specify a length for the test run.\n"
>  	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
>  	       "                           days\n"
> @@ -1234,7 +1233,7 @@ int main(int argc, char **argv)
>  		percent = nr_cpus * 80 / nr_threads;
>  	}
>  
> -	/* Set up the data while sill in SCHED_FIFO */
> +	/* Set up the data while still in SCHED_FIFO */
>  	for (i = 0; i < nr_threads; i++) {
>  		sd = &sched_data[i];
>  		/*
> -- 
> 2.39.3
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

