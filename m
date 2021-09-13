Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DABAC433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 18:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6184860F9F
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 18:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347322AbhIMSjd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 14:39:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43360 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347169AbhIMSjc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Sep 2021 14:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631558296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sCqYLqN3bHekKN6TuivbPYQ3tXklKvgvGo/M3yZP67Q=;
        b=Mi0rseKYnD7zeLRlPM+DK92g7HWC2smSu+WV2P8I2p6enQF3BMMFD1pHKv63XxoKlQfT1d
        LiIKKfoJyLD05YVwKLniKEFRJKcx4kDhbEcz0s0seJjDc/P1ViP+tEHCofFd4/0KUNbRTa
        uyHmNvWpUS7AuyZjnuwP6TgIr5DgJlk=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-4pfUc_lfNZ2XiGnONUSBpw-1; Mon, 13 Sep 2021 14:38:14 -0400
X-MC-Unique: 4pfUc_lfNZ2XiGnONUSBpw-1
Received: by mail-io1-f72.google.com with SMTP id i78-20020a6b3b51000000b005b8dd0f9e76so14460007ioa.9
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Sep 2021 11:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=sCqYLqN3bHekKN6TuivbPYQ3tXklKvgvGo/M3yZP67Q=;
        b=l86ffExE4PYczPEoYYRK3o3DDcW9iD/FME8+lsjf1kuPkhsboClV9vTCpFC3ilQrM7
         YLYls1pp2GO0fYCUih0O0Ou6c0ddfkTFPnbNjw0c35kw54iXkDruu4yNEIbEtaf+ZZ8/
         qudqTp1U4ba023r7izhcVTjxvzyZHkWAr1FmbD3UzT05T1VBJmssYIGVYplwFoN+Ilsb
         Nz3LkgVnHfpOaZENPyQYbu1g3l5zVGaNPp58FF75E6lYqpDlhBtQfg4fWuNamKzoxTWP
         /Y5pLBUQhd+exmmF8lWQA6Jd3GVUL9S4QjodpMkMZV9DnK7ax5W3JVcs5tR6XA/JFWhr
         1JAw==
X-Gm-Message-State: AOAM5302cM8OKhGdQE/eu0v4AHGVrB1urYq4ECIi0fuQQtD54QyDHD59
        SkyJTMthjG16UpniE/hBExRHGNWSuT5191eXmkcIKFyoPC3Kdbhipq+x0rkmQr7xzCS5MQnP3UZ
        EUtdzxjQqCR1ihIX0Qv/3PVn1DLQ=
X-Received: by 2002:a05:6e02:198c:: with SMTP id g12mr9047462ilf.77.1631558293991;
        Mon, 13 Sep 2021 11:38:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+vg57G90qo4ekk6NQarasa7qv0WeO/6Bjskf24V4x3sWrx+Tz1wDnpxmqFyh7oeLhxBmVHA==
X-Received: by 2002:a05:6e02:198c:: with SMTP id g12mr9047441ilf.77.1631558293726;
        Mon, 13 Sep 2021 11:38:13 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id n37sm4720854ioz.5.2021.09.13.11.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:38:13 -0700 (PDT)
Date:   Mon, 13 Sep 2021 14:38:12 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
cc:     linux-rt-users@vger.kernel.org, peterx@redhat.com,
        williams@redhat.com
Subject: Re: [PATCH v2 1/3] oslat: Rename cpu_mhz/cpu_hz to
 counter_mhz/counter_hz
In-Reply-To: <20210913083908.48408-1-nsaenzju@redhat.com>
Message-ID: <87972b-6e82-b2d5-ead8-87c24851be39@redhat.com>
References: <20210913083908.48408-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 13 Sep 2021, Nicolas Saenz Julienne wrote:

> 'cpu_mhz' in oslat actually represents the frequency at which the high
> frequency counter we measure with ticks. There is no requirement for the
> counter to match the CPU frequency, nor is forced to do so on any of the
> supported architectures[1][2]. So rename it to 'counter_mhz' in order to
> better match reality.
> 
> [1] x86_64
> Intel TRM Vol 3B, 17.17 Time Stamp Counter:
> "Constant TSC behavior ensures that the duration of each clock tick is
> uniform and supports the use of the TSC as a wall clock timer even if
> the processor core changes frequency."
> 
> [2] ppc64
> From __ppc_get_timebase() manpages: The Time Base Register is a 64-bit
> register provided by Power Architecture processors. It stores a
> monotonically incremented value that is updated at a system-dependent
> frequency that may be different from the processor frequency. Note that
> glibc's __ppc_get_timebase() and oslat's ppc64 frc() implementations are
> the same.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> ---
> 
> Changes since v1:
>  - More complete commit message
>  - s/timer/counter/
> 
>  src/oslat/oslat.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index 6ff5ba8..33cccd3 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -123,7 +123,7 @@ struct thread {
>  	pthread_t            thread_id;
>  
>  	/* NOTE! this is also how many ticks per us */
> -	unsigned int         cpu_mhz;
> +	unsigned int         counter_mhz;
>  	cycles_t             int_total;
>  	stamp_t              frc_start;
>  	stamp_t              frc_stop;
> @@ -228,7 +228,7 @@ static int move_to_core(int core_i)
>  	return sched_setaffinity(0, sizeof(cpus), &cpus);
>  }
>  
> -static cycles_t __measure_cpu_hz(void)
> +static cycles_t __measure_counter_hz(void)
>  {
>  	struct timeval tvs, tve;
>  	stamp_t s, e;
> @@ -244,13 +244,13 @@ static cycles_t __measure_cpu_hz(void)
>  	return (cycles_t) ((e - s) / sec);
>  }
>  
> -static unsigned int measure_cpu_mhz(void)
> +static unsigned int measure_counter_mhz(void)
>  {
>  	cycles_t m, mprev, d;
>  
> -	mprev = __measure_cpu_hz();
> +	mprev = __measure_counter_hz();
>  	do {
> -		m = __measure_cpu_hz();
> +		m = __measure_counter_hz();
>  		if (m > mprev)
>  			d = m - mprev;
>  		else
> @@ -263,7 +263,7 @@ static unsigned int measure_cpu_mhz(void)
>  
>  static void thread_init(struct thread *t)
>  {
> -	t->cpu_mhz = measure_cpu_mhz();
> +	t->counter_mhz = measure_counter_mhz();
>  	t->maxlat = 0;
>  	t->overflow_sum = 0;
>  	t->minlat = (uint64_t)-1;
> @@ -288,7 +288,7 @@ static void thread_init(struct thread *t)
>  
>  static float cycles_to_sec(const struct thread *t, uint64_t cycles)
>  {
> -	return cycles / (t->cpu_mhz * 1e6);
> +	return cycles / (t->counter_mhz * 1e6);
>  }
>  
>  static void insert_bucket(struct thread *t, stamp_t value)
> @@ -296,7 +296,7 @@ static void insert_bucket(struct thread *t, stamp_t value)
>  	int index, us;
>  	uint64_t extra;
>  
> -	index = value / t->cpu_mhz;
> +	index = value / t->counter_mhz;
>  	assert(index >= 0);
>  	us = index + 1;
>  	assert(us > 0);
> @@ -450,7 +450,7 @@ static void write_summary(struct thread *t)
>  	calculate(t);
>  
>  	putfield("Core", t[i].core_i, "d", "");
> -	putfield("CPU Freq", t[i].cpu_mhz, "u", " (Mhz)");
> +	putfield("Counter Freq", t[i].counter_mhz, "u", " (Mhz)");
>  
>  	for (j = 0; j < g.bucket_size; j++) {
>  		if (j < g.bucket_size-1 && g.output_omit_zero_buckets) {
> @@ -494,7 +494,7 @@ static void write_summary_json(FILE *f, void *data)
>  	for (i = 0; i < g.n_threads; ++i) {
>  		fprintf(f, "    \"%u\": {\n", i);
>  		fprintf(f, "      \"cpu\": %d,\n", t[i].core_i);
> -		fprintf(f, "      \"freq\": %d,\n", t[i].cpu_mhz);
> +		fprintf(f, "      \"freq\": %d,\n", t[i].counter_mhz);
>  		fprintf(f, "      \"min\": %" PRIu64 ",\n", t[i].minlat);
>  		fprintf(f, "      \"avg\": %3lf,\n", t[i].average);
>  		fprintf(f, "      \"max\": %" PRIu64 ",\n", t[i].maxlat);
> -- 
> 2.31.1
> 
> 
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>

