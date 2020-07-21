Return-Path: <SRS0=rES8=BA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A5AC433E1
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Jul 2020 22:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53B4120709
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Jul 2020 22:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h22d2+nx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgGUW3l (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Jul 2020 18:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgGUW3l (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Jul 2020 18:29:41 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A07C061794
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Jul 2020 15:29:41 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id p7so201910qvl.4
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Jul 2020 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Ce79H5GH0oqrv/4oRIO4gGikmiyWo/VMIvuZU8LB6jQ=;
        b=h22d2+nxVjAZFmhuUb2yuRM+wOTj6JRitYKlLdi2e0kI8Ru7UJDNmm/2I4A5crEXxW
         +pN/52m1PGN3fBgEdO4dhR5RfqTlBO30gvSs5Tg+vCwlhFvA6sm8U57xERG+5vnGEcgG
         8tUZK2VFzIJDECTFMUoQueQsJY0sHAG2dWqNoMkqinBda9yYrNzxZ/1bB4vbQMAUsEGa
         68Pyr3UYQfBeLSjts2lQZrBTP6C6l9K5sCvIH2Bhuia5A2icqori5lY1gOwLLdKvVYM8
         fJ2CInsEeWdJovTpcx3CAr7oTayAFB0+O1l5zYBWPTNRteGf90KqFlMhHcr8xbHxaBdR
         pGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=Ce79H5GH0oqrv/4oRIO4gGikmiyWo/VMIvuZU8LB6jQ=;
        b=H6AfAYqqFTt4SiQMeurf7Zb2fCmh130d9pVl9X9RJF9R4M7vpXzRb90a2sm+e1530X
         WQglKDYshJKfFySUC+ZA1eTLEgU0HJOBT15gQNVZ/Pi5LTxElnP7jmIzvxoLCEAT5G4+
         qxUwDNS0a9hfdjfXbgiNYPc45g0GsvGC0OARrOY+yJAv6pnnSHrlx/5tKNv/ShsIukbJ
         P3x4mpPPYJCdNZ/UuExbzshWvbLZ3R3Yr0jAnSDjR5EYg5bM27EE3Tkxtad7iXJU/p3Z
         3MSG/ycH2hdJ6lRjtTmhUWIsefU61FLWQCssUF49XRfAfrc1m8FAVPqmrnzCZGNhNhol
         mdkg==
X-Gm-Message-State: AOAM5327OXQLPTe5CvTl0fnhVVg6xi0qW86o7TbSsl6ezY1iP8nMzVr5
        nudzDErwEahl2Lq/d2BSQCKwaUUv
X-Google-Smtp-Source: ABdhPJzBQ6s+ERYInsM6vlPX6XyAOEFVRXmNL6RIME/lmD0KkEP07wJBYTFSTSvSoaYw0bbQZxgfkA==
X-Received: by 2002:ad4:4d06:: with SMTP id l6mr28190783qvl.93.1595370580564;
        Tue, 21 Jul 2020 15:29:40 -0700 (PDT)
Received: from fionn (rdwyon0600w-lp140-02-142-113-120-236.dsl.bell.ca. [142.113.120.236])
        by smtp.gmail.com with ESMTPSA id l1sm23845877qtk.18.2020.07.21.15.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 15:29:40 -0700 (PDT)
Date:   Tue, 21 Jul 2020 18:29:32 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@fionn
To:     Clark Williams <williams@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] pi_stress: limit the number of inversion groups to the
 number of online cores
In-Reply-To: <20200721211022.734344-1-williams@redhat.com>
Message-ID: <alpine.LFD.2.23.451.2007211829040.195349@fionn>
References: <20200721211022.734344-1-williams@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 21 Jul 2020, Clark Williams wrote:

> Each inversion group is three SCHED_FIFO threads, so the chances of more groups
> than online cores actually getting to run is very slim. Limit the number of
> groups requested to be <= the number of online cpus.
> 
> Signed-off-by: Clark Williams <williams@redhat.com>
> ---
>  src/pi_tests/pi_stress.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> index 0ed844c636cd..ce446d4ea037 100644
> --- a/src/pi_tests/pi_stress.c
> +++ b/src/pi_tests/pi_stress.c
> @@ -1327,6 +1327,12 @@ void process_command_line(int argc, char **argv)
>  			break;
>  		case 'g':
>  			ngroups = strtol(optarg, NULL, 10);
> +			if (ngroups > num_processors) {
> +				pi_error("the number of groups cannot exceed "
> +					 "the number of online processors (%d)\n",
> +					 num_processors);
> +				exit(-1);
> +			}
>  			pi_info("number of groups set to %d\n", ngroups);
>  			break;
>  		case 'r':
> -- 
> 2.26.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
