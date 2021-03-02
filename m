Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EDEC4332E
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Mar 2021 06:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AD1164EC6
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Mar 2021 06:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbhCCGYB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446121AbhCBT7M (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Mar 2021 14:59:12 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E06EC061788
        for <linux-rt-users@vger.kernel.org>; Tue,  2 Mar 2021 11:58:31 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id n4so8212172qvl.4
        for <linux-rt-users@vger.kernel.org>; Tue, 02 Mar 2021 11:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=8ipbFrCLkXXlwLam3PRw2jxFjLyFMCrSKAV6EqkP31c=;
        b=ftH//Yzg1Go62oX9fpoaoNVMN10vA+MPWg0P6gUrDoJ+0fRsMYJ4aahYexDTsl5Wh3
         PC+8EgG5IhYM57eY1SH0r8Mg0gxM5UTraCGh9rRVaxltrbDcM7phRpZd8wMh/vwfLLRf
         VhAKeZQK5+gHVm3lRbHR8vF17kNB6hrpgo/sMPUOauUd+lbg5nW912jCHxFdfPdBeohW
         DcvOHxLHgyudwecJRssZb6Ypb90NxI4L1feBsqIcbHcz+mg/qG4NNQbweFZhcgsTfdtC
         PLdfA5WFS6YJu2T1qzF+art2Y3gM6+uJC7FxfZMn9ILdZDarr39iVZGUl3d3Lj4iBc5Q
         k/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=8ipbFrCLkXXlwLam3PRw2jxFjLyFMCrSKAV6EqkP31c=;
        b=BBciTjkW9wwq16ZA9/h3d1RUzytDbQznK9xMTUIFkApng+EGvQvuBinAWN9Q76OI8B
         rz92Ny8eYmqKH83/bXBaDNQCJadqAI2hYuEK+Mg5+UZMO5PP7yJ0euebetlKSXzKbfl5
         YAu6zBLbRNmjT2j0Rtym87lcm2FfUsPTYq6o6Y4nVNFcMu96z+X3si4rcdcfi3/Emver
         IFmaDf6zuUuM4OHbdDeH7kShd4/XZjaCZ73CWUg4GcsYGo/d32IdhGvh8acVa9vIebG7
         cmIpK2NQKcZ10xjcEtnIs1nQ+DaTqOZ1tzoJiEvBJgQIVLsNlYfCJA0+jiMQSdpPhr4d
         kfbQ==
X-Gm-Message-State: AOAM532YR0TD+VMHU/YLMDJWX5Tcm3lNH2M1FV8y6+/fee+xgninzKPN
        Fn65q8vne5RENmudV+Bm7NDA+twsTKaMTA==
X-Google-Smtp-Source: ABdhPJx7c4kQa5tD6swpMWfwReWXjLt1I9UTyW9IgJJ48NKPC+o4nY768q3ZxpgtHrA1XfJ/KPl+XA==
X-Received: by 2002:ad4:56e9:: with SMTP id cr9mr21656647qvb.4.1614715110451;
        Tue, 02 Mar 2021 11:58:30 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id v2sm2297888qkp.119.2021.03.02.11.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 11:58:29 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 2 Mar 2021 14:58:22 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Christian Eggers <ceggers@arri.de>
cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] all: Fix printf format errors
In-Reply-To: <20210226073802.9406-1-ceggers@arri.de>
Message-ID: <ef6ce578-18c2-562a-222-c83d449ccd3@redhat.com>
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
Are you seeing a compile time warning on some systems?

John
