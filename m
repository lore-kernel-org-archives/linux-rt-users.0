Return-Path: <SRS0=2Uay=D6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544E8C4363A
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 14:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C3921D47
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 14:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgY70Wmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460908AbgJWOxE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Oct 2020 10:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460728AbgJWOxE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Oct 2020 10:53:04 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663AAC0613CE
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 07:53:04 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z33so1108631qth.8
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 07:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=x4A9ocG508M69K4fQGaio5lofZPo3G6FtPlrzNa6shs=;
        b=mgY70WmyQrRaS2m/Zf/CzeB3w4bNAIU+OeSwAX+lYKtpfLE4NZf8l1W2qYjdwKvQ5V
         0Jwd55ELZqYPv6IA+jKq9TZMjtVrKHEI+0j3TKE4nuBwhQX1upGQrAz+B/20o6fbfW6z
         BTteWxvLVG88lYJai/4SqYnd60romyIfUT5D0vDP8DFbnNGALnGl2rwEoQFDgMO2y7gD
         LsU2QB4ym/U31rmCMZTtNsxGBdiQcjszY6Zeju0uIsyikdbyZzgIZA9/4FNFUhfKJpeX
         mbgGIvBqyK6ovkQpS68J0fb90suD2Y444qufUh7I/JEVWOTkxeDCbpq+nN6XV5ot6arR
         dNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=x4A9ocG508M69K4fQGaio5lofZPo3G6FtPlrzNa6shs=;
        b=b/f0+gl4bEDcRILhy91kGyiQ0huVfvyiYNzSwmztPJDV0sCTUW2T2rZng+gEWEXFNk
         Az1n0en8rqso5VO8udcAq2w3dCxcDk/CweL9UWvh/kQFHFsn9Di28zL9Rymp3X3UodnG
         mFhxrbu9vNmhBdHv7WGsgNdhi3tXyVOALxz4kap0116oHYWrOO43AqwPZIrEOCCBjBY9
         0e620HfAZkbw82osAuJzLN7JeT3DoeJcY88KcvwXM2kPFBYxl2ZvaoHz4pkmR6zkqcW/
         zTHi//A3K/arbou2b9ZtkVC50OQ3fKciY+wmZGB3q5ybk7gSgREUeNt23xQ+lW/kasA0
         y9Fw==
X-Gm-Message-State: AOAM532SxCNZfa/25rZSrUsoc3pNHW2bRhKOsVkwVhZrh7mOY9NSaa2I
        vuclGwP3+iQ9yS4wy832UsfkteGRxihihA==
X-Google-Smtp-Source: ABdhPJzk3MzCGbl2yWWC7kE8fIODx/oxE2IYgBfB+rSLsf49vionohVUIhbHwy9HxCz9OU9Trq3dQQ==
X-Received: by 2002:ac8:5816:: with SMTP id g22mr2311338qtg.316.1603464783586;
        Fri, 23 Oct 2020 07:53:03 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id q19sm566526qkq.129.2020.10.23.07.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 07:53:02 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 23 Oct 2020 10:52:54 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Peter Xu <peterx@redhat.com>
cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>,
        Randy Witt <randy.e.witt@linux.intel.com>
Subject: Re: [PATCH] rt-tests: oslat: Allow build for not supported archs
In-Reply-To: <20201001184726.82245-1-peterx@redhat.com>
Message-ID: <e4f9bdc7-dbe8-b45a-ec9d-65e34bbdbf42@redhat.com>
References: <20201001184726.82245-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 1 Oct 2020, Peter Xu wrote:

> Now rt-tests won't build for archs other than x86/i386/ppc64 after oslat is
> merged.  Instead of failing the build, let's make it pass.  However, whenever
> oslat is executed, instead of running the real program, dump an error message,
> so that people can try to implement the frc() function for it when there's a
> real need for the new arch.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> 
> Just in case this got lost - I'm posting as a formal patch.  Please feel free
> to comment here directly.
> ---
>  src/oslat/oslat.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index f1a82f2..a8b6155 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -69,7 +69,9 @@ static inline void frc(uint64_t *pval)
>  	__asm__ __volatile__("mfspr %0, 268\n" : "=r" (*pval));
>  }
>  # else
> -#  error Need frc() for this platform.
> +#  define relax()          do { } while (0)
> +#  define frc(x)
> +#  define FRC_MISSING
>  # endif
>  #else
>  # error Need to add support for this compiler.
> @@ -810,6 +812,12 @@ int main(int argc, char *argv[])
>  	int i, n_cores;
>  	cpu_set_t cpu_set;
>  
> +#ifdef FRC_MISSING
> +	printf("This architecture is not yet supported. "
> +	       "Please implement frc() function first for %s.\n", argv[0]);
> +	return 0;
> +#endif
> +
>  	CPU_ZERO(&cpu_set);
>  
>  	g.app_name = argv[0];
> -- 
> 2.26.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
