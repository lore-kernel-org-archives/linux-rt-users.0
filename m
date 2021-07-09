Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0E8C07E9C
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 18:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A7C3613D6
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 18:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhGISLS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 14:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58288 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229819AbhGISLR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Jul 2021 14:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625854113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8SIu9U7T5qSa8XxCqd+g85JXWtl3YSC/rCsQ6xj10k8=;
        b=Zo+04FvFfCRSJsdQJFQ37sifSerHUAjQFyxWR5edTxA6tPG2iC0gDJrjHH6fCO0iUmLlFK
        cwXSeyOAydjTjp5bbUwxmFZBAW3IcsMaxY+fb6iD7C+yJ55cbZ6UTwRjxF1R0sEbxlIEez
        RehHAy31OwCsVNdtjgmeGIwmf6Sq4Ag=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-FdfNYe8_Ojyk0wRNLH9IUA-1; Fri, 09 Jul 2021 14:08:32 -0400
X-MC-Unique: FdfNYe8_Ojyk0wRNLH9IUA-1
Received: by mail-qk1-f200.google.com with SMTP id c3-20020a37b3030000b02903ad0001a2e8so6913298qkf.3
        for <linux-rt-users@vger.kernel.org>; Fri, 09 Jul 2021 11:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=8SIu9U7T5qSa8XxCqd+g85JXWtl3YSC/rCsQ6xj10k8=;
        b=nraAk4Qei10d8cV7dbIh7QSbklWkFQFTdz6GhhrX9bbA/2rjVENxRQZyOY0tFp9Syh
         K2OzFEkB2mwz7wZ2+OvQ418NFwSEAHHapnAhk1zr3A7JIDHdzoC7G/C+fWTEK/Y9jOFz
         Yb+mGergQkTJNetE2SUZDc1jFyAWgnhlJX3e2Wuxor12hXCK5ncwyebDWrvgRodxHrJG
         L+r4h5UjVccXfjcUkl9F9mvmzIvWSh9tkbE7FhZUL++Jf3BTZgz3XWvN6BSJJ86oMhFq
         MLm/u6+bFhQeKNN7/nz0IFYlo9sf8q5l7depf2OwhjpjgibEcOiZ9sS/2A9mcd2GECl9
         Rhow==
X-Gm-Message-State: AOAM533o5DhuHP8FS97BZHse4xa4fc7UdxPD+21beVjuY+urWyC19tQV
        0MxT8+DAeg8zdgn/HOxetorEyxSZsawehMRD0zped23t+hwdCvMBZ1W69S0A1GmypSZLOqrUmgb
        f2S++3lBDRWoSMk/Ji9pCdd6GFLM=
X-Received: by 2002:a37:5d46:: with SMTP id r67mr39078774qkb.12.1625854112367;
        Fri, 09 Jul 2021 11:08:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxm7wALqmtW5vDYU7cPeB0PCjo3rTqotsurUWtL6VZAjIkP7cLwFvqo4nu0/3e3TGTeeDuYZg==
X-Received: by 2002:a37:5d46:: with SMTP id r67mr39078762qkb.12.1625854112218;
        Fri, 09 Jul 2021 11:08:32 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-243.dsl.bell.ca. [184.147.141.243])
        by smtp.gmail.com with ESMTPSA id f2sm2411945qth.11.2021.07.09.11.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 11:08:31 -0700 (PDT)
Date:   Fri, 9 Jul 2021 14:08:30 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
cc:     linux-rt-users@vger.kernel.org, peterx@redhat.com,
        williams@redhat.com
Subject: Re: [PATCH 2/2] oslat: Don't take trace_threshold into account during
 preheat
In-Reply-To: <20210707084849.304329-2-nsaenzju@redhat.com>
Message-ID: <384bc432-e3df-d487-6c7-544edcd2bd1@redhat.com>
References: <20210707084849.304329-1-nsaenzju@redhat.com> <20210707084849.304329-2-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 7 Jul 2021, Nicolas Saenz Julienne wrote:

> The point of preheat is to make sure CPUs are out of idle and running at
> max frequency by the time the real test starts. So it's expected to
> incur into extra latencies we don't really mean to measure. With this in
> mind, it doesn't make sense to take into account the trace threshold
> during that run. So don't do it.
> 
> Note that this has been observed in practice. The threshold would be hit
> during preheat but not during the real test.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> ---
>  src/oslat/oslat.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index 1cba6fc..6ff5ba8 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -29,6 +29,7 @@
>  #include <numa.h>
>  #include <math.h>
>  #include <limits.h>
> +#include <stdbool.h>
>  
>  #include <sys/prctl.h>
>  #include <sys/stat.h>
> @@ -150,6 +151,7 @@ struct thread {
>  struct global {
>  	/* Configuration. */
>  	unsigned int          runtime_secs;
> +	bool		      preheat;
>  	/*
>  	 * Number of threads running for current test
>  	 * (either pre heat or real run)
> @@ -299,7 +301,7 @@ static void insert_bucket(struct thread *t, stamp_t value)
>  	us = index + 1;
>  	assert(us > 0);
>  
> -	if (g.trace_threshold && us >= g.trace_threshold) {
> +	if (!g.preheat && g.trace_threshold && us >= g.trace_threshold) {
>  		char *line = "%s: Trace threshold (%d us) triggered with %u us!\n"
>  		    "Stopping the test.\n";
>  		tracemark(line, g.app_name, g.trace_threshold, us);
> @@ -515,11 +517,12 @@ static void write_summary_json(FILE *f, void *data)
>  	fprintf(f, "  }\n");
>  }
>  
> -static void run_expt(struct thread *threads, int runtime_secs)
> +static void run_expt(struct thread *threads, int runtime_secs, bool preheat)
>  {
>  	int i;
>  
>  	g.runtime_secs = runtime_secs;
> +	g.preheat = preheat;
>  	g.n_threads_started = 0;
>  	g.n_threads_running = 0;
>  	g.n_threads_finished = 0;
> @@ -846,14 +849,14 @@ int main(int argc, char *argv[])
>  		g.n_threads = 1;
>  	else
>  		g.n_threads = g.n_threads_total;
> -	run_expt(threads, 1);
> +	run_expt(threads, 1, true);
>  	record_bias(threads);
>  
>  	if (!g.quiet)
>  		printf("Test starts...\n");
>  	/* Reset n_threads to always run on all the cores */
>  	g.n_threads = g.n_threads_total;
> -	run_expt(threads, g.runtime);
> +	run_expt(threads, g.runtime, false);
>  
>  	if (!g.quiet)
>  		printf("Test completed.\n\n");
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

