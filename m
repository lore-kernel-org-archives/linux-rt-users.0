Return-Path: <SRS0=2Uay=D6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940E6C4363A
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 17:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E68821527
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 17:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY8imOM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbgJWR0A (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Oct 2020 13:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461030AbgJWR0A (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Oct 2020 13:26:00 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC70CC0613CE
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 10:25:58 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id v200so1890520qka.0
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 10:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=gMBg1cJukyddbJcrxLUSWaK/97H+EF9S1vbjeUGSrls=;
        b=AY8imOM+593pV/wNbIPyggqgPtjZ8z4/Qz8Yy7XSN8hyqi3q6r2n6Kd3MXjFcb9SK6
         sF+bBqEl9l0DzcMblHasM6eDqhA7ife4lP1ME1S6zlbthpBwFs1TQNPXe3oULEehtm2O
         PzwyllQl840OVbWkibBkH0ALnviRBRUEVF+6GE2ng5E2ehmVp+fO4or8CD4ZiQfGeuEh
         v002P3FcQ6hDU5AFB0GYZ4jbDark6AvwVs7pth6YnkDL5oMO+W1jTpIC0lW+FLq584uQ
         OgQZJdrWRydB59aPKxsITUwuwYZLIBeX5h3U7vzq7XR5ympLBY9LkDhYIWB/+vejdoK+
         ZBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=gMBg1cJukyddbJcrxLUSWaK/97H+EF9S1vbjeUGSrls=;
        b=pqbIIEAqMH/zF4ZPn2ps0t90TkIhICBj8Z4pKPjnv1I1q5IUT0PeaZBXoPKAkX6knl
         neafvrV2icLm8KODh1xPYJ9um83Z5yJxL1JAuws/vqTfFM6aN4KM6isDnAQrVVZUSgDK
         DYgiJ9/Y0izoZlE7jQDsa7enaIr3xavGZP7tHwh8ShM5zj0Dm0vgRyCl9nnooLFKt+NG
         TvaWT/wurZW7FdMyjWsKb+jgQ6lQz6HvEsGb3l/Uw7aC6JjVhIYUPID1gpMBXP8yblGL
         aTg9XtqE3KDlcL+crod9X5TrryRnFyo0g3DtL/5b+qrZId/HPM3NcfWTWE/f1/yYteCM
         qgeA==
X-Gm-Message-State: AOAM533lzVRXRDJaMpenscJl6luW3vi890bwiof2tlGDBDvDhxxKZv8X
        Zz21pAcwyH7VS34AO0gWb6U=
X-Google-Smtp-Source: ABdhPJwcOV/0VstXuWdHwwpDJbTxpfjindOIhtWR52IkwF9mxr8LJRHn27kM7Uk35oFVoqY9ryBPHQ==
X-Received: by 2002:a37:686:: with SMTP id 128mr3085336qkg.421.1603473957934;
        Fri, 23 Oct 2020 10:25:57 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id g2sm1304929qts.8.2020.10.23.10.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 10:25:57 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 23 Oct 2020 13:25:56 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 07/18] oslat: Use string parser utilies
In-Reply-To: <20201007085653.11961-8-dwagner@suse.de>
Message-ID: <7caa4ef3-3348-26f6-1822-47090b1c989@redhat.com>
References: <20201007085653.11961-1-dwagner@suse.de> <20201007085653.11961-8-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 7 Oct 2020, Daniel Wagner wrote:

> Use available parse_time_string() instead locally implemented
> version. While at it move the mem parser helper to the global utility
> header.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/oslat/oslat.c | 67 ++---------------------------------------------
>  1 file changed, 2 insertions(+), 65 deletions(-)
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index fafbdd694326..9df1a58f640d 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -570,69 +570,6 @@ static int parse_cpu_list(char *cpu_list, cpu_set_t *cpu_set)
>  	return n_cores;
>  }
>  
> -static int parse_runtime(const char *str)
> -{
> -	char *endptr;
> -	int v = strtol(str, &endptr, 10);
> -
> -	if (!*endptr)
> -		return v;
> -
> -	switch (*endptr) {
> -	case 'd':
> -	case 'D':
> -		/* Days */
> -		v *= 24;
> -	case 'h':
> -	case 'H':
> -		/* Hours */
> -		v *= 60;
> -	case 'm':
> -	case 'M':
> -		/* Minutes */
> -		v *= 60;
> -	case 's':
> -	case 'S':
> -		/* Seconds */
> -		break;
> -	default:
> -		printf("Unknown runtime suffix: %s\n", endptr);
> -		v = 0;
> -		break;
> -	}
> -
> -	return v;
> -}
> -
> -static int parse_mem_size(char *str, uint64_t *val)
> -{
> -	char *endptr;
> -	int v = strtol(str, &endptr, 10);
> -
> -	if (!*endptr)
> -		return v;
> -
> -	switch (*endptr) {
> -	case 'g':
> -	case 'G':
> -		v *= 1024;
> -	case 'm':
> -	case 'M':
> -		v *= 1024;
> -	case 'k':
> -	case 'K':
> -		v *= 1024;
> -	case 'b':
> -	case 'B':
> -		break;
> -	default:
> -		return -1;
> -	}
> -
> -	*val = v;
> -
> -	return 0;
> -}
>  
>  static int workload_select(char *name)
>  {
> @@ -700,7 +637,7 @@ static void parse_options(int argc, char *argv[])
>  			}
>  			break;
>  		case 'D':
> -			g.runtime = parse_runtime(optarg);
> +			g.runtime = parse_time_string(optarg);
>  			if (!g.runtime) {
>  				printf("Illegal runtime: %s\n", optarg);
>  				exit(1);
> @@ -734,7 +671,7 @@ static void parse_options(int argc, char *argv[])
>  			}
>  			break;
>  		case 'm':
> -			if (parse_mem_size(optarg, &g.workload_mem_size)) {
> +			if (parse_mem_string(optarg, &g.workload_mem_size)) {
>  				printf("Unknown workload memory size '%s'.\n\n", optarg);
>  				exit(1);
>  			}
> -- 
> 2.28.0
> 
> 

This one is pending either your changes that I requested to the first 
patch, or an argument as to why I should accept the first patch.

Cheers!

John
