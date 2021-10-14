Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26530C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 18:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E31611C1
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 18:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhJNSdY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Oct 2021 14:33:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56303 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230183AbhJNSdW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Oct 2021 14:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634236277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QhCnltBQ2EJcY91Meb1ukTzFbaAJ62SYie5VmfRVol0=;
        b=VA+sXJAhTjJJ77M+aTOwiPY00BYEuXuXCM7IzO3sjEu2bN6jzYqwJOxjmWbqah2aDS6TVx
        2kZ1Se6lyJEcr/7+6FeNAnHzTs36DPOD+9L0rerZ1P7w74zR6G02ZCrBlps7iBpUepmi50
        BV1tRrcUWq1+UK+BKRvTENINRkpQ3wk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-S_T1kCtiOkOeHfX9ouAfJw-1; Thu, 14 Oct 2021 14:31:15 -0400
X-MC-Unique: S_T1kCtiOkOeHfX9ouAfJw-1
Received: by mail-qk1-f198.google.com with SMTP id e22-20020a05620a209600b0045f81b8f89cso5127805qka.5
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Oct 2021 11:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=QhCnltBQ2EJcY91Meb1ukTzFbaAJ62SYie5VmfRVol0=;
        b=xv1hk8jWy+UEBjNJfEYi8uhMxjbsI6uhyUJ4n87o4YFzHH4Gbyh4XliNnyd+dwN+Mb
         QOsNOx05+suSUuI7lMf3f3yP4P+Dnba/ytMG9SbzzWsfrUVtE/pV06JE9jZ40Cxvk+53
         gySzPGzDQjngcm04jopH5grhG4W9XZLt94veQiMyqnIbvQ1DloVNwZ4n9UrVo8aCYPRd
         t3vztjge6CQcIbN6pB1T8uvoZWMBnOXIm0xXitRIrkUVtFfBVsa58Xd3DtgI2bLv+IWo
         B9iaylBjJcNEdiL3kg5y4OplSLnlLP0Ut4zaQrQ135zQquu4/R7Did1tMeT/LHPAxQSW
         9bew==
X-Gm-Message-State: AOAM532GBbicJ0F275cuCe9N+7CHnV2jOrrBz0uk4Bas4R4uixeWCmVA
        spHLnA4WScn0r0SsvepAl1YcqyWX0gvHamjhyniViBjK/BxqDkNy/Z6Wcne383j4S7RTDXmuCl0
        8gAPjUHAsMDjknMMJFm2G4Q9uJxM=
X-Received: by 2002:a05:620a:31a2:: with SMTP id bi34mr6203149qkb.331.1634236275446;
        Thu, 14 Oct 2021 11:31:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgD7Kw0ojK2chSHmL0IiEpp0a3/yW2pki4fnIKvtvcE1YPQNmMlt5VSGSIH0Nn2+jNPtFDmw==
X-Received: by 2002:a05:620a:31a2:: with SMTP id bi34mr6203131qkb.331.1634236275245;
        Thu, 14 Oct 2021 11:31:15 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id f3sm1853027qko.32.2021.10.14.11.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 11:31:14 -0700 (PDT)
Date:   Thu, 14 Oct 2021 14:31:13 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC 5/7] rt-tests: cyclictest: Move signal handler to avoid
 function declaration
In-Reply-To: <20211014071247.4165329-6-punitagrawal@gmail.com>
Message-ID: <4ddcdfd6-f5cf-757d-7b27-534b1d2665b8@redhat.com>
References: <20211014071247.4165329-1-punitagrawal@gmail.com> <20211014071247.4165329-6-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 14 Oct 2021, Punit Agrawal wrote:

> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> 
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> ---
>  src/cyclictest/cyclictest.c | 78 ++++++++++++++++++-------------------
>  1 file changed, 37 insertions(+), 41 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 9c67a3ce3034..48a782fe167d 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -220,10 +220,6 @@ static char jsonfile[MAX_PATH];
>  static struct thread_param **parameters;
>  static struct thread_stat **statistics;
>  
> -static void print_stat(FILE *fp, struct thread_param *par, int index, int verbose, int quiet);
> -static void rstat_print_stat(struct thread_param *par, int index, int verbose, int quiet);
> -static void rstat_setup(void);
> -
>  static int latency_target_fd = -1;
>  static int32_t latency_target_value = 0;
>  
> @@ -1311,43 +1307,6 @@ static int check_timer(void)
>  	return (ts.tv_sec != 0 || ts.tv_nsec != 1);
>  }
>  
> -static void sighand(int sig)
> -{
> -	if (sig == SIGUSR1) {
> -		int i;
> -		int oldquiet = quiet;
> -
> -		quiet = 0;
> -		fprintf(stderr, "#---------------------------\n");
> -		fprintf(stderr, "# cyclictest current status:\n");
> -		for (i = 0; i < num_threads; i++)
> -			print_stat(stderr, parameters[i], i, 0, 0);
> -		fprintf(stderr, "#---------------------------\n");
> -		quiet = oldquiet;
> -		return;
> -	} else if (sig == SIGUSR2) {
> -		int i;
> -		int oldquiet = quiet;
> -
> -		if (rstat_fd == -1) {
> -			fprintf(stderr, "ERROR: rstat_fd not valid\n");
> -			return;
> -		}
> -		rstat_ftruncate(rstat_fd, 0);
> -		quiet = 0;
> -		dprintf(rstat_fd, "#---------------------------\n");
> -		dprintf(rstat_fd, "# cyclictest current status:\n");
> -		for (i = 0; i < num_threads; i++)
> -			rstat_print_stat(parameters[i], i, 0, 0);
> -		dprintf(rstat_fd, "#---------------------------\n");
> -		quiet = oldquiet;
> -		return;
> -	}
> -	shutdown = 1;
> -	if (refresh_on_max)
> -		pthread_cond_signal(&refresh_on_max_cond);
> -}
> -
>  static void print_tids(struct thread_param *par[], int nthreads)
>  {
>  	int i;
> @@ -1566,6 +1525,43 @@ static void rstat_print_stat(struct thread_param *par, int index, int verbose, i
>  }
>  
>  
> +static void sighand(int sig)
> +{
> +	if (sig == SIGUSR1) {
> +		int i;
> +		int oldquiet = quiet;
> +
> +		quiet = 0;
> +		fprintf(stderr, "#---------------------------\n");
> +		fprintf(stderr, "# cyclictest current status:\n");
> +		for (i = 0; i < num_threads; i++)
> +			print_stat(stderr, parameters[i], i, 0, 0);
> +		fprintf(stderr, "#---------------------------\n");
> +		quiet = oldquiet;
> +		return;
> +	} else if (sig == SIGUSR2) {
> +		int i;
> +		int oldquiet = quiet;
> +
> +		if (rstat_fd == -1) {
> +			fprintf(stderr, "ERROR: rstat_fd not valid\n");
> +			return;
> +		}
> +		rstat_ftruncate(rstat_fd, 0);
> +		quiet = 0;
> +		dprintf(rstat_fd, "#---------------------------\n");
> +		dprintf(rstat_fd, "# cyclictest current status:\n");
> +		for (i = 0; i < num_threads; i++)
> +			rstat_print_stat(parameters[i], i, 0, 0);
> +		dprintf(rstat_fd, "#---------------------------\n");
> +		quiet = oldquiet;
> +		return;
> +	}
> +	shutdown = 1;
> +	if (refresh_on_max)
> +		pthread_cond_signal(&refresh_on_max_cond);
> +}
> +
>  /*
>   * thread that creates a named fifo and hands out run stats when someone
>   * reads from the fifo.
> -- 
> 2.32.0
> 
> 

NACK: What's wrong with function declarations? They allow the freedeom to 
put your function where you wish. This patch is unnecessary churn, sorry.

