Return-Path: <SRS0=J2Xz=SG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FEAC4360F
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Apr 2019 15:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A0F20657
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Apr 2019 15:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGIrsKgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfDDPOC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:14:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43315 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfDDPOC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Apr 2019 11:14:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id k17so4242306wrx.10
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Apr 2019 08:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0RSH39m+LNTcKf0XGgLdNnynACrjVEsVT1sbOx6ndWc=;
        b=iGIrsKgyFNn7t/B+EfIVMeBbS5Cl0LTY+vZcK4GURmFyCjJwSxGP3o+5zQY0KFhOIT
         NrmuEobeJlgOpZjciDE1pgYEiDQn+GUjXDvR5fxubyw1M7ByNF4TYUL+tnFwLRPyLqn+
         SA1fwfAoLTE5p9BeHngOCQ7K6HPnaasrksObFQQGiXGE3z2ePiOEIKB5L8xjwyaBi33y
         10Dvj/0YU8nNejZ2ATnaTxWgUZKLee62mT5f2Tkle0K81AxYlSWFnU5oaeEEvysgyUhD
         S6JXPgzKml7k+v6RhPJMMOsHAdaMlySG55hepzi4KRvlmtZIQlF95WRR1/X671CDvFmv
         yIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=0RSH39m+LNTcKf0XGgLdNnynACrjVEsVT1sbOx6ndWc=;
        b=g13OCsDY29EHAelW5A5DEmgJ8pkezFTotOjw+POJA7Z4EUgx/LKYmsC3QmJbD40RdT
         FkkC8YkwLNavHzG6oTMNYEdu7gpgiEJNb2KsRD9SE3R88VjCDiVY7i1v/e3MjwZ6lNZI
         bSVted4PaZWZzkbdAnSCfhLd3ogQ7tt6W9WucmkJZ+sSvRYw3XL8bIbebWill364dRh/
         0u1wo2rk5rAOPzBGbCOCYdunFNNz9KTWQjOpYMcSmGxcgxighXqlaHBT2aZFocp5HaKw
         ILlxcW3TNs4s7ek2+SSbtEiXofaIz2y0uX6Jak/FJ4PcY/RSGue2evcPMdMWGB/8YfjH
         vYGQ==
X-Gm-Message-State: APjAAAXOJvqseiT27ByXkpCkxgv1lXxABIg8HspXPbyljWwO4mFLCbq2
        l1EqM99Ae7rWLSHT05BN0uk=
X-Google-Smtp-Source: APXvYqwl/d2aH0d7k3rcWUVYQX1ByzTC0KHBn9eMYjJrw/+2XtNKxYiqPDf6tShulcvJsNBIfRkfew==
X-Received: by 2002:adf:f607:: with SMTP id t7mr4812925wrp.191.1554390839921;
        Thu, 04 Apr 2019 08:13:59 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id h2sm38648246wro.11.2019.04.04.08.13.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Apr 2019 08:13:58 -0700 (PDT)
Date:   Thu, 4 Apr 2019 17:13:51 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Kurt Kanzenbach <kurt@linutronix.de>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 4/4] rt-tests: deadline_test: add missing frees
In-Reply-To: <20190404134814.13376-5-kurt@linutronix.de>
Message-ID: <alpine.LFD.2.21.1904041712560.11547@planxty>
References: <20190404134814.13376-1-kurt@linutronix.de> <20190404134814.13376-5-kurt@linutronix.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 4 Apr 2019, Kurt Kanzenbach wrote:

> The threads and thread data structures are allocated using calloc(). But never
> free'd. So, free them.
> 
> While here, remove the if statement for setcpu_buf. Free() is NULL safe.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  src/sched_deadline/deadline_test.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
> index 4826557d0624..69e6fd18b73b 100644
> --- a/src/sched_deadline/deadline_test.c
> +++ b/src/sched_deadline/deadline_test.c
> @@ -2092,8 +2092,9 @@ int main (int argc, char **argv)
>  		printf("\n");
>  	}
>  
> -	if (!setcpu_buf)
> -		free(setcpu_buf);
> +	free(thread);
> +	free(sched_data);
> +	free(setcpu_buf);
>  
>  	return 0;
>  }
> -- 
> 2.11.0

Does this remove your own if statement that I didn't even apply yet? :)

Maybe, you want to regenerate this patch without that?

Thanks

John
