Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEC0C43381
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45FAF64DDA
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344291AbhCDAWB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbhCDAD3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Mar 2021 19:03:29 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0016C0613E3
        for <linux-rt-users@vger.kernel.org>; Wed,  3 Mar 2021 15:31:43 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id gi9so12689931qvb.10
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Mar 2021 15:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=HwCP78EHPW9nA06wUdWN2u+962ekoC/7rvTL586Hbbk=;
        b=qy3M6ggNVgFbJXu86syguKXrt0ktCdLW7qXY6Eo/NCy92ej3ODYlPFbabzwmUuI8Z6
         MdEeKl8wbFjebg4MF39HqPclyizCIm0vAiC8mRpScHbb8ajr7+bM0ROoez4A3taLf8uL
         n/f3ThPgv93L1xp2RMD7VOeXiAEh9bcvS0xVKwdodEYR/WlOV8yEbUyt8oV6nPKYYvJh
         GcmiUG2u5Q4A+Gg6GVSw6fjLuqV88c35P1CHm5encTuiJo0G3fgj9rE/zbVmXhwvwQke
         Mv+fj5EB3TaqsXZODwYoqcXwwLRlxKAbBF7wydWM1lO1jvQuuLQyw06RPauSmOTJYoBq
         4hpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=HwCP78EHPW9nA06wUdWN2u+962ekoC/7rvTL586Hbbk=;
        b=Z544Vo3LTE2JmqDVr7R06dVDvk6We6RX8MW2Bm2Y5cNbyNbNvqK5PWEsz9V3h4Holj
         MGmv6Bw2xksB+J+jpZuLsWJ6xBIU0nGjSgcKy23fZWYU04ZZ9TtbfbPjd7JsNLgJNLXb
         3kshSaEwwHcfsh1Jjap8to3MKcY8h6JvfxMU7SdsNRqWWzVO/bAoM7QzwRVuYxRiNkxv
         RL3dhNulVVjqrLIMicwchXTBxg2JJJQIFmYysg9WEuFDKV7GHdVh+SsiBalSmduB7GcH
         noJEUUkhNnQuP+Lui9uBx4Vo7SPdLCRwYoOi4mabiYd97MaHHq23KjSRK6wOWeITwgbs
         z18Q==
X-Gm-Message-State: AOAM530dISSmGnDbOonyDK3so/8q1+Z0cIfpOH1+FIePMycI9ttCyWZt
        zxRcSY1lZ3rH0kN/KUq5xyT9Avpco94PsQ==
X-Google-Smtp-Source: ABdhPJwb7ziPhX380HPd096VIeRSvVwwFKWUHulJ/XFdgCcOZ1bHiHvxKs6B/VrYNcp5jnYSQFX73A==
X-Received: by 2002:a0c:b495:: with SMTP id c21mr1368780qve.19.1614814302851;
        Wed, 03 Mar 2021 15:31:42 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id b65sm18306631qkd.120.2021.03.03.15.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 15:31:42 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Wed, 3 Mar 2021 18:31:41 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Christian Eggers <ceggers@arri.de>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] all: Fix printf format errors
In-Reply-To: <20210226073802.9406-1-ceggers@arri.de>
Message-ID: <f782ef4e-fa9-a41c-126c-bb97966a68e3@redhat.com>
References: <20210226073802.9406-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 26 Feb 2021, Christian Eggers wrote:

> time_t is "long" or "long long" (depending on the system).  So it should
> be safe to convert it to "long long", in order to get a consistent data
> type on all systems.
> 
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---
>  src/cyclictest/cyclictest.c         | 8 ++++----
>  src/hackbench/hackbench.c           | 2 +-
>  src/sched_deadline/cyclicdeadline.c | 6 +++---
>  src/signaltest/signaltest.c         | 6 +++---
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 157047837259..8a7784e645da 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1751,15 +1751,15 @@ static void write_stats(FILE *f, void *data)
>  			if (s->hist_array[j] == 0)
>  				continue;
>  			fprintf(f, "%s", comma ? ",\n" : "\n");
> -			fprintf(f, "        \"%u\": %" PRIu64, j, s->hist_array[j]);
> +			fprintf(f, "        \"%u\": %ld", j, s->hist_array[j]);
>  			comma = 1;
>  		}
>  		if (comma)
>  			fprintf(f, "\n");
>  		fprintf(f, "      },\n");
> -		fprintf(f, "      \"cycles\": %" PRIu64 ",\n", s->cycles);
> -		fprintf(f, "      \"min\": %" PRIu64 ",\n", s->min);
> -		fprintf(f, "      \"max\": %" PRIu64 ",\n", s->max);
> +		fprintf(f, "      \"cycles\": %lu,\n", s->cycles);
> +		fprintf(f, "      \"min\": %ld,\n", s->min);
> +		fprintf(f, "      \"max\": %ld,\n", s->max);
>  		fprintf(f, "      \"avg\": %.2f,\n", s->avg/s->cycles);
>  		fprintf(f, "      \"cpu\": %d,\n", par[i]->cpu);
>  		fprintf(f, "      \"node\": %d\n", par[i]->node);
> diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
> index 268c23233004..785b9c076256 100644
> --- a/src/hackbench/hackbench.c
> +++ b/src/hackbench/hackbench.c
> @@ -505,7 +505,7 @@ int main(int argc, char *argv[])
>  	/* Print time... */
>  	if (timer_started) {
>  		timersub(&stop, &start, &diff);
> -		printf("Time: %lu.%03lu\n", diff.tv_sec, diff.tv_usec/1000);
> +		printf("Time: %lld.%03lld\n", (long long)diff.tv_sec, (long long)diff.tv_usec/1000);
>  	}
>  	else
>  		fprintf(stderr, "No measurements available\n");
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index ed3c960d9916..1c66a227f156 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -978,9 +978,9 @@ static void write_stats(FILE *f, void *data)
>  	for (i = 0; i < nr_threads; i++) {
>  		s = &sd[i].stat;
>  		fprintf(f, "    \"%u\": {\n", i);
> -		fprintf(f, "	 \"cycles\": %" PRIu64 ",\n", s->cycles);
> -		fprintf(f, "	 \"min\": %" PRIu64 ",\n", s->min);
> -		fprintf(f, "	 \"max\": %" PRIu64 ",\n", s->max);
> +		fprintf(f, "	 \"cycles\": %lu,\n", s->cycles);
> +		fprintf(f, "	 \"min\": %ld,\n", s->min);
> +		fprintf(f, "	 \"max\": %ld,\n", s->max);
>  		fprintf(f, "	 \"avg\": %.2f\n", s->avg/s->cycles);
>  		fprintf(f, "    }%s\n", i == nr_threads - 1 ? "" : ",");
>  	}
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index b1a7e1db8302..b39e9d2a96d6 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -392,9 +392,9 @@ static void write_stats(FILE *f, void *data)
>  	for (i = 0; i < num_threads; i++) {
>  		fprintf(f, "    \"%u\": {\n", i);
>  		s = &par->stats[i];
> -		fprintf(f, "      \"cycles\": %" PRIu64 ",\n", s->cycles);
> -		fprintf(f, "      \"min\": %" PRIu64 ",\n", s->min);
> -		fprintf(f, "      \"max\": %" PRIu64 ",\n", s->max);
> +		fprintf(f, "      \"cycles\": %lu,\n", s->cycles);
> +		fprintf(f, "      \"min\": %ld,\n", s->min);
> +		fprintf(f, "      \"max\": %ld,\n", s->max);
>  		fprintf(f, "      \"avg\": %.2f,\n", s->avg/s->cycles);
>  		fprintf(f, "      \"cpu\": %d\n", par->cpu);
>  		fprintf(f, "    }%s\n", i == num_threads - 1 ? "" : ",");
> -- 
> Christian Eggers
> Embedded software developer
> 
> Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
> Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
> Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
> Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
> Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler
> 
> 

I took the patches that Daniel Wagner already sent for cyclictest and 
cyclicdeadline. Please make sure they work for you.

If you send me separate patches for hackbench and for signaltest I'll
take them.

Thanks

John Kacur
