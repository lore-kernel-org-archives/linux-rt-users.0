Return-Path: <SRS0=sIfm=UM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96029C31E49
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jun 2019 15:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F34020B7C
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jun 2019 15:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWix+YLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbfFMPMT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:12:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34970 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732285AbfFMNsr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Jun 2019 09:48:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so1895091wrv.2
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Jun 2019 06:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Dzfr5SyOM9qV1CZIkfiMxo+nQ5UAZX1PucOxrMSlHoo=;
        b=IWix+YLzwZ7TFR+EcV0tluT8q3C8A7gSx4go2KrKKQT8jTPlQdQsh7Td6ay3XLFU3e
         MpX+ODX2FEfBC+qA4p7wHZUpaVWA0UjnXWJRxUHIeUHxBalvL8RpD2xw3DVFfmSrStrW
         TAqjNUwa5QOsm/1ukYh1DdpQejk+rC4kYzHHyamLPMtUWUKkWfPEiu32Hz/OPzeFT3K6
         RnZzr+gnsTzTVEQv5LkY+R0AtVJuuswZ/x1L92IcOzwLjU5FOD3XS0yIir8XOxPD5w23
         8MYActSbTZf9cKql3Zwjeb07vPm1iQBvQfiaZPSpZRsldhASvOqBAhRqM5YVIEaQqjh2
         X7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=Dzfr5SyOM9qV1CZIkfiMxo+nQ5UAZX1PucOxrMSlHoo=;
        b=JMesuiRnDl83AtAkg1nZkheqHxOLSu6WIbUHg95R6KDS91opmr7uhj7dMoUURLi0J4
         HRv2hbKdu8ogk5L4mGtTnqMCIsvZuOIjCBLAHWk/uEYopwIVNzW/4juXSVQgN/5KpCRs
         Y2GQe5T263Z8klYJO/pk4/6uXylmaIlw2zbU5NJbmLdRx4J/eLrqpx1HhQ9OMa4ttpn+
         0f4cHtBA9XjbEHAGhBg+zoRckJylAJ7tHqctBTIcu0ERh+Z4soC2kGzOsDmCefoA7dLG
         rkIdKOtDQ5ydJj13P9WMJ1E5CkdH61qalJjYtGi3Me4zWYl+U7ESbCsITHJixJBFWoI3
         tlLA==
X-Gm-Message-State: APjAAAVfVLWYvo1AyABVWFMl+G67MtwYYmQq0hAnHmNRAuqP92V4Yu8n
        iFeUqk8gpXg2hR5gxOeB/Qk529EYrMQ=
X-Google-Smtp-Source: APXvYqwtuuMFIJlSWKFVk/Ksmy23Ixfqtl+Yfy/v5aNRew1hnuy6/J5um2ARyUQgkKYZCR9OrresJA==
X-Received: by 2002:a5d:5089:: with SMTP id a9mr2841915wrt.290.1560433725072;
        Thu, 13 Jun 2019 06:48:45 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id h8sm2591078wmf.12.2019.06.13.06.48.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 06:48:44 -0700 (PDT)
Date:   Thu, 13 Jun 2019 15:48:18 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Daniel Wagner <wagi@monom.org>
cc:     linux-rt-users@vger.kernel.org,
        Daniel Wagner <daniel.wagner@siemens.com>
Subject: Re: [PATCH v2 01/12] rt_numa.h: Remove unused function
In-Reply-To: <20190605160617.22987-2-wagi@monom.org>
Message-ID: <alpine.LFD.2.21.1906131547520.8187@planxty>
References: <20190605160617.22987-1-wagi@monom.org> <20190605160617.22987-2-wagi@monom.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463804494-2118788883-1560433723=:8187"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-2118788883-1560433723=:8187
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 5 Jun 2019, Daniel Wagner wrote:

> From: Daniel Wagner <daniel.wagner@siemens.com>
> 
> GCC on a BeagleBoneBlack complains:
> 
> In file included from src/cyclictest/cyclictest.c:39:0:
> src/cyclictest/rt_numa.h:253:13: warning: ‘numa_on_and_available’ defined but not used [-Wunused-function]
>  static void numa_on_and_available()
>              ^~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Daniel Wagner <daniel.wagner@siemens.com>
> ---
>  src/cyclictest/rt_numa.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
> index e8cd7f481baa..e0f4b2e9d8b2 100644
> --- a/src/cyclictest/rt_numa.h
> +++ b/src/cyclictest/rt_numa.h
> @@ -249,13 +249,6 @@ static inline void rt_bitmask_free(struct bitmask *mask)
>  	free(mask);
>  }
>  
> -
> -static void numa_on_and_available()
> -{
> -	if (numa) /* NUMA is not defined here */
> -		fatal("numa mode and numa functions not available.\n");
> -}
> -
>  #endif	/* NUMA */
>  
>  /*
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>
---1463804494-2118788883-1560433723=:8187--
