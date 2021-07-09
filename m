Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D70C07E9B
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 18:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DB9461241
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 18:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGISEX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 14:04:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229499AbhGISEW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Jul 2021 14:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625853698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bwrAie83gkqnQLmySLjVrHNZkxMVorv7oVtlY1bH3js=;
        b=hV9y5KetwWkKd1yKGoimDuXCiPwudk8fheMMW/48Wo5wIy4MspVoQS/aefHITyyNSCoazV
        dmfjFkFIiIudwp/ptXoTCGsrcCPAZQN6/W5Q/d6qPygfNMhhgxfFR2nIXsuoNr+9E2KEm+
        McKaU5ZiNzTV0bhqodzYl2sVckHtQTY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-8s3g038rNumA4JuZ1kDs5Q-1; Fri, 09 Jul 2021 14:01:37 -0400
X-MC-Unique: 8s3g038rNumA4JuZ1kDs5Q-1
Received: by mail-qk1-f198.google.com with SMTP id n77-20020a3740500000b02903b496f6f425so6920387qka.1
        for <linux-rt-users@vger.kernel.org>; Fri, 09 Jul 2021 11:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=bwrAie83gkqnQLmySLjVrHNZkxMVorv7oVtlY1bH3js=;
        b=ECCiz4H0WHrp62q1Xjt1LJ75cToAlxvC5Lu5Zyxp1I+P027qZT0HMKim55rYxU/qBv
         6iNguD3BWFEtQVKm1gd39ALiCmMyKkhTLpM9KyZ6aVTlhvgMqegCUlbvvCn17bAwaxTP
         m6cvaZbf57E3GsY+Pz8R6t/RgvqOq8e33a62c2bbV7zzklFwPo1x0MWzYU8CLO3N+NWe
         hZE3A9LexaNAD5ofGSHGtiyg9GLNpwl5EPUVjWpwL7t8OfP/SLL4gnW1M8FHSYjofJ3U
         CPp9Joy17cqMDimNmXX6xjXdh54/LI4JnIAKK33FVrxM2OELl9ccET3NkA4cYeNP2Dlk
         looA==
X-Gm-Message-State: AOAM532TyUOVolYm1aW+oVEl6fM7BrzY9Lsc1oMT3cHeGyxxf3JkmIq4
        x8eQiY0qd3UkKd0gAaNvkcJyaEOyVOS/4EA+Ikx2KCPwIdDcHYgsl0tJ3PyJdOAAXG4OtpubprT
        FOKu2D/JA3+ww12kJfZwt0PCfq+s=
X-Received: by 2002:a05:622a:4f:: with SMTP id y15mr181637qtw.122.1625853696580;
        Fri, 09 Jul 2021 11:01:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnfbwX6nkZn/ufNVFj+bsrgZLHJCjOf2/MaUHtqTXTB1Xixc2Z1ZES3A+lIB5j2o8cRaks1g==
X-Received: by 2002:a05:622a:4f:: with SMTP id y15mr181623qtw.122.1625853696427;
        Fri, 09 Jul 2021 11:01:36 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-243.dsl.bell.ca. [184.147.141.243])
        by smtp.gmail.com with ESMTPSA id 9sm2816549qkp.14.2021.07.09.11.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 11:01:36 -0700 (PDT)
Date:   Fri, 9 Jul 2021 14:01:35 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v2 3/3] cyclicdeadline: Fix buffer allocation
In-Reply-To: <20210708151827.21430-4-dwagner@suse.de>
Message-ID: <64899f-ab54-4a29-73a7-32b79ab6a1e6@redhat.com>
References: <20210708151827.21430-1-dwagner@suse.de> <20210708151827.21430-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463755774-1299145996-1625853695=:10671"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463755774-1299145996-1625853695=:10671
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 8 Jul 2021, Daniel Wagner wrote:

> gcc complains with "‘sprintf’ output between 2 and 12 bytes" but
> the buffer is only 10 bytes long. Update the buffer size to hold
> the complete range of [-2147483648, 2147483646].
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/sched_deadline/cyclicdeadline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index ffefa9e6fecb..8447424273ee 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -1092,7 +1092,7 @@ int main(int argc, char **argv)
>  
>  	/* Default cpu to use is the last one */
>  	if (!all_cpus && !setcpu) {
> -		setcpu_buf = malloc(10);
> +		setcpu_buf = malloc(12);
>  		if (!setcpu_buf)
>  			fatal("malloc");
>  		sprintf(setcpu_buf, "%d", cpu_count - 1);
> -- 
> 2.32.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

I applied this but there are others.

git grep PRIu64
src/oslat/oslat.c:              snprintf(bucket_name, sizeof(bucket_name), 
"%03"PRIu64
src/oslat/oslat.c:              putfield(bucket_name, t[i].buckets[j], 
PRIu64,
src/oslat/oslat.c:      putfield("Minimum", t[i].minlat, PRIu64, " (us)");
src/oslat/oslat.c:      putfield("Maximum", t[i].maxlat, PRIu64, " (us)");
src/oslat/oslat.c:      putfield("Max-Min", t[i].maxlat - t[i].minlat, 
PRIu64, " (us)");
src/oslat/oslat.c:              fprintf(f, "      \"min\": %" PRIu64 
",\n", t[i].minlat);
src/oslat/oslat.c:              fprintf(f, "      \"max\": %" PRIu64 
",\n", t[i].maxlat);
src/oslat/oslat.c:                      fprintf(f, "        \"%" PRIu64 
"\": %" PRIu64,
src/oslat/oslat.c:      printf("Workload mem: \t\t%"PRIu64" (KiB)\n",
src/pi_tests/pi_stress.c:               printf(" runtime %" PRIu64 " 
deadline %" PRIu64 " period %" PRIu64 "\n",

---1463755774-1299145996-1625853695=:10671--

