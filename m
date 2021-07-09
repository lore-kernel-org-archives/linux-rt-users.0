Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF717C07E99
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 18:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C94613CA
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 18:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhGISFc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 14:05:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39116 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229491AbhGISFc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Jul 2021 14:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625853768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RlfhwWj2QfI2s5Xd4fBu8NtzeIfuN9I9l5Qwd6fv5W8=;
        b=J+y7xFcEegZ/Pceo1S4TJZvUU11/zMbXyfKC4Nbc53T4uR+1Pgx8IjZzjQe542TvbJD8Yt
        7MjQ3jLKBMDuO8rt8wTOJDZOyid15Ew+WX/xEIeR5NiuXFxGzHxrPLHL9efa4v5SsYhSvu
        xrHYfERkuDj2Maas30I9Xahz3hc8+YU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-tljaA5YvOQObhue23e12ow-1; Fri, 09 Jul 2021 14:02:47 -0400
X-MC-Unique: tljaA5YvOQObhue23e12ow-1
Received: by mail-qv1-f69.google.com with SMTP id q10-20020a056214018ab029027751ec9742so6947092qvr.7
        for <linux-rt-users@vger.kernel.org>; Fri, 09 Jul 2021 11:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=RlfhwWj2QfI2s5Xd4fBu8NtzeIfuN9I9l5Qwd6fv5W8=;
        b=kRl+1Bkqo7vTxDDtDdWb2/yzksK3cFYWSgBLuRtncNZtfEtDmGmR0IiPVksIKoOIyy
         woFihRfGCcrsnM6D29qTxqxuUgenSbf8LT3sVVTpKCOPSHN8/siU6eyY8nxI8Z00F5zw
         4H2IVQs7FzCrrJemphoh6PNw/8baKSRsTVL+I7XJE7oyHn0m+Pp4dEODW9dzc1owUk6e
         FNtyY2m83Y7liylV/xzIYmmJKX+WgeOXHqSEZjBuLOG8rKu38V5xA+Cp/NALlW+TmsnL
         zEGoUr9fsl2q+VDYuiqBDd0WHQuAITPDYfeKOBon2WWVFOEt9JbIlYPusm9Dv9OrbDE0
         C+8Q==
X-Gm-Message-State: AOAM532+pWQRAR/wTmb+eU5TAEjYKpC6gW9C6aN1sJezRcAMNsyWiHdH
        AdybNsBNrJ7TckHlgAxGxOCEgAY2S2xq+gpr4yuTGawarGsZHtkbWYQguJgBRB8NtUEvNjEGg/B
        qhmxA1BYmHjlrBxnIhJx45LR8xEo=
X-Received: by 2002:a05:620a:4086:: with SMTP id f6mr39995106qko.95.1625853766452;
        Fri, 09 Jul 2021 11:02:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDJpBY5U/Efxe0JtqecXeSHwYCkRNoVnzJWTQdk5DsArlCN85xYlsEbEVUz9m4LhcrzSgveg==
X-Received: by 2002:a05:620a:4086:: with SMTP id f6mr39995096qko.95.1625853766325;
        Fri, 09 Jul 2021 11:02:46 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-243.dsl.bell.ca. [184.147.141.243])
        by smtp.gmail.com with ESMTPSA id s81sm2740454qka.82.2021.07.09.11.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 11:02:46 -0700 (PDT)
Date:   Fri, 9 Jul 2021 14:02:45 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v2 3/3] cyclicdeadline: Fix buffer allocation
In-Reply-To: <20210708151827.21430-4-dwagner@suse.de>
Message-ID: <ab947e70-821c-5088-20d9-27cb2d71f4a1@redhat.com>
References: <20210708151827.21430-1-dwagner@suse.de> <20210708151827.21430-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463755774-1102342066-1625853765=:10671"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463755774-1102342066-1625853765=:10671
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
---1463755774-1102342066-1625853765=:10671--

