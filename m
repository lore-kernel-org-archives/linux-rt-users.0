Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCA7C433B4
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16EEA61008
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbhEGQzd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237089AbhEGQzc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:55:32 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981BCC061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:54:32 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g13so7069843qts.4
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=0y6iAUuST5et7vews89aGuECqKBoJ9gksr/b1MqlpD8=;
        b=Nw8Gpx9Ruf828kMtlhJPKrNKfpNhxK3y+D0julszuslL+GGT4Kc/REb45wxyyy9vy3
         /GesBfglTcoopclcHdp4MTvOGcaNCXtxJFThTSbzqo4RUqB6nbdwug/Nbu6kNDzxNubh
         HpGq09H3unh5v04HxBn5yrcIdxJ6UWvxHujfpWGFg25buVXPlmCcoe+5wxECy2Ly+kFC
         PpchT2b4JAOlqyNtsmSgynGVW+1NtJG9xSK7o3jxn2sQUNKdQeyh1AshjSpFN4TJolnW
         YkYPolxxuXVPodTYMx9YgsOoVsjXUyXI0HaQZDqe7bbx68UVNMcF8OkKxFJ3fuqKs3Na
         Sixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=0y6iAUuST5et7vews89aGuECqKBoJ9gksr/b1MqlpD8=;
        b=hke7W4aveYYD/qMptngOWKjO0nrj5CalCxfiIkkJS4vGQlyBm2b+1eMnM0OSe2fghe
         Yb2N+smMbCwcQmZtn+o+AsD1n9I/JQPhugOLLiVX8bAqdnFqWS2v9EhYt8+m04DissQr
         RRSCfJmX6barS4MbKJ8gHAi45uXSZAAqhKKrQdx91rcnFUakgThpQCXvoTg5iVy57qJo
         xhJQ5QllENy8mDs5hrbzeVxk8Z0rHSvwWxbgol8vD3DugnS9LABPhSN2Xy2k5fWLkV7C
         0vNOOWaQHw8vX2PR+6JdEr947SGAOrXIzERH4KZcB9Oqo2BQ3/gUCC6jwNg4uasafoYM
         XaRw==
X-Gm-Message-State: AOAM532FnX0lIzBVcZahsrwCJG5Hm22kX4n49hJ91cpUSKQOjk/pW5cJ
        x5syDwWlVkvS33GUiMm1yOI=
X-Google-Smtp-Source: ABdhPJyj6dAqLVqL9Ine3tSrzC7/EpV1avqVm3E/W8xkZVZD9Cvbn6M6o4cVnV+F1UPbNf5WNbI5Ug==
X-Received: by 2002:ac8:48cf:: with SMTP id l15mr9735517qtr.283.1620406471918;
        Fri, 07 May 2021 09:54:31 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id d10sm5291361qki.122.2021.05.07.09.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:54:31 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:54:30 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 27/33] pip_stress: Return failure code if
 test fails
In-Reply-To: <20210320183829.1318-28-dwagner@suse.de>
Message-ID: <d979f62-e4bc-3f4d-b520-da3ca6e48199@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-28-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> Let the test return a failure code when the test fails.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/pi_tests/pip_stress.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
> index 2c3288984202..ed034799da66 100644
> --- a/src/pi_tests/pip_stress.c
> +++ b/src/pi_tests/pip_stress.c
> @@ -160,11 +160,11 @@ int main(int argc, char *argv[])
>  		}
>  	}
>  
> -	if (statep->inversion)
> -		printf("Successfully used priority inheritance to handle an inversion\n");
> -	else
> +	if (!statep->inversion) {
>  		printf("No inversion incurred\n");
> -
> +		exit(1);
> +	}
> +	printf("Successfully used priority inheritance to handle an inversion\n");
>  	exit(0);
>  }
>  
> -- 
> 2.30.2
> 
> 

It isn't really an error if no priority inheritance occurs.
An error from this program would be something like mmap returning an error 
code.

I'm not sure this one is suitable for the json treatment, it's more of a 
demonstration of how to use priority inheritance with processes instead of 
threads. Thomas told me this was possible and I was curious to see if this 
was true, so I scratched that itch. Not sure if it is useful as a test.

Let's leave pip_stress alone for now please
