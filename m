Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F31FC433B4
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D759C6145D
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbhEGQul (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhEGQul (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:50:41 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CA4C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:49:41 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id y12so7042491qtx.11
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=GQnrCH/+0d4/SepsuaTKY/o77uDxlabmFhtVWTfVDao=;
        b=OnZN0YUw4XAXsvlKFloS3gJ09TTEykXvVtOXDq7l4GgNlwWGeb+PWSeZsjgYSa27bR
         idP0ni1dzdyb5ix+ytKK0joYtlZDGDcNCf4eBnQ0Vs4MS44z4vLW+stpoG6vkBFCcTIE
         a5n23ivZZQRKQ/FBNUC+W+A414jYC24OZerki43QycgMNymDPg2jru8+PVrPMKI/5uen
         AQb4wx2Eud7Tgz1RWzWtByL0VRwtOSxPE7OqnNk8frc5VkRHZRrmyHZRHqId9p5/ueGV
         dtrU6wrA5JbxzeVo5aEBc6BC7yiCtdfIOajGtvfLCXB8gPUd+20ZfDegDSVXDQWY49rP
         NmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=GQnrCH/+0d4/SepsuaTKY/o77uDxlabmFhtVWTfVDao=;
        b=NXT7+RDSKl1/nRhaZYjoKMBiDZ3w1l9y8ymUZvXBA6Iw40fkZvQJFCmVGqbgevelFR
         VWBMjvzjZ138kasBaj8vkIUQfAAr5fQ0dsVLuD4tgZII5M6uDKVicOyFg58G9spK9p4V
         nfH+/+TmBZldZ3BhlrdWy/bg01ZrUFyuwUG7vmlh1wHGMPtPesiky7K0CRE6rMWmpDtM
         9CNoJx0a3uI/Qakq6X0TQwgYDj9h0OxafyZ+PTn9KcA31/PwcYAcPUbobFjto7ra7s0V
         WqTghMiEsJuvF/1J/Zpb/y1iLL3q/2DvGMWRxLETBI9pLgZJnM7k+XFN9ly4tNDjAvaj
         Xvcw==
X-Gm-Message-State: AOAM5337ZX8Xsr5+zoV9y2OOBZ1X1fRs8AGDbIggClYQmAagDAY5ha6B
        EAt5ts70JEu5xn2QBy9KF8dVWSSFLMNDPg==
X-Google-Smtp-Source: ABdhPJzNg6dVXVCwlb4oKnxHaL2/jrxqyCtjYtqNQQWVzPg9m1d2roknkCXQXTSP+D5+XNASBgEjTw==
X-Received: by 2002:ac8:d03:: with SMTP id q3mr10296221qti.183.1620406180522;
        Fri, 07 May 2021 09:49:40 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id p2sm5154942qkg.49.2021.05.07.09.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:49:40 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:49:39 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 25/33] rt-util: Add return_code to common
 section of JSON output
In-Reply-To: <20210320183829.1318-26-dwagner@suse.de>
Message-ID: <69f9e18d-8686-a45-f25e-b32898695bc@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-26-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> Many rt-tests return an error code if the test fails. Let's add
> this information to the common section.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/cyclictest/cyclictest.c           |  2 +-
>  src/include/rt-utils.h                |  2 +-
>  src/lib/rt-utils.c                    | 11 ++++++++---
>  src/oslat/oslat.c                     |  2 +-
>  src/pmqtest/pmqtest.c                 |  2 +-
>  src/ptsematest/ptsematest.c           |  2 +-
>  src/rt-migrate-test/rt-migrate-test.c |  2 +-
>  src/sched_deadline/cyclicdeadline.c   |  2 +-
>  src/signaltest/signaltest.c           |  2 +-
>  src/sigwaittest/sigwaittest.c         |  2 +-
>  src/svsematest/svsematest.c           |  2 +-
>  11 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 033b95a3a19a..59dda1973b1a 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -2135,7 +2135,7 @@ int main(int argc, char **argv)
>  		printf("\033[%dB", num_threads + 2);
>  
>  	if (strlen(outfile) != 0)
> -		rt_write_json(outfile, write_stats, NULL);
> +		rt_write_json(outfile, ret, write_stats, NULL);
>  
>  	if (quiet)
>  		quiet = 2;
> diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
> index 42c2772262db..f07b57d5f7c1 100644
> --- a/src/include/rt-utils.h
> +++ b/src/include/rt-utils.h
> @@ -84,7 +84,7 @@ void rt_init(int argc, char *argv[]);
>  
>  void rt_test_start(void);
>  
> -void rt_write_json(const char *filename,
> +void rt_write_json(const char *filename, int return_code,
>  		   void (*cb)(FILE *, void *),
>  		   void *data);
>  
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index efb5d1d9e866..d264c348ad42 100644
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -534,7 +534,7 @@ void rt_test_start(void)
>  	get_timestamp(ts_start);
>  }
>  
> -void rt_write_json(const char *filename,
> +void rt_write_json(const char *filename, int return_code,
>  		  void (*cb)(FILE *, void *),
>  		  void *data)
>  {
> @@ -572,6 +572,7 @@ void rt_write_json(const char *filename,
>  	fprintf(f, "  \"rt_test_version:\": \"%1.2f\",\n", VERSION);
>  	fprintf(f, "  \"start_time\": \"%s\",\n", ts_start);
>  	fprintf(f, "  \"end_time\": \"%s\",\n", ts_end);
> +	fprintf(f, "  \"return_code\": %d,\n", return_code);
>  	fprintf(f, "  \"sysinfo\": {\n");
>  	fprintf(f, "    \"sysname\": \"%s\",\n", uts.sysname);
>  	fprintf(f, "    \"nodename\": \"%s\",\n", uts.nodename);
> @@ -579,9 +580,13 @@ void rt_write_json(const char *filename,
>  	fprintf(f, "    \"version\": \"%s\",\n", uts.version);
>  	fprintf(f, "    \"machine\": \"%s\",\n", uts.machine);
>  	fprintf(f, "    \"realtime\": %d\n", rt);
> -	fprintf(f, "  },\n");
>  
> -	(cb)(f, data);
> +	if (cb) {
> +		fprintf(f, "  },\n");
> +		(cb)(f, data);
> +	} else {
> +		fprintf(f, "  }\n");
> +	}
>  
>  	fprintf(f, "}\n");
>  
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index 2f02f5399405..37d528f0f7ff 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -863,7 +863,7 @@ int main(int argc, char *argv[])
>  	write_summary(threads);
>  
>  	if (strlen(g.outfile) != 0)
> -		rt_write_json(g.outfile, write_summary_json, threads);
> +		rt_write_json(g.outfile, 0, write_summary_json, threads);
>  
>  	if (g.cpu_list) {
>  		free(g.cpu_list);
> diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
> index adf72c10ce83..af10b416600c 100644
> --- a/src/pmqtest/pmqtest.c
> +++ b/src/pmqtest/pmqtest.c
> @@ -652,7 +652,7 @@ int main(int argc, char *argv[])
>  			.receiver = receiver,
>  			.sender = sender,
>  		};
> -		rt_write_json(outfile, write_stats, &ps);
> +		rt_write_json(outfile, 0, write_stats, &ps);
>  	}
>  
>  nomem:
> diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
> index 471f1b307c14..70eb79e89635 100644
> --- a/src/ptsematest/ptsematest.c
> +++ b/src/ptsematest/ptsematest.c
> @@ -520,7 +520,7 @@ int main(int argc, char *argv[])
>  			.receiver = receiver,
>  			.sender = sender,
>  		};
> -		rt_write_json(outfile, write_stats, &ps);
> +		rt_write_json(outfile, 0, write_stats, &ps);
>  	}
>  
>  nomem:
> diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
> index 8f628d347a23..1e0abdd6c0fa 100644
> --- a/src/rt-migrate-test/rt-migrate-test.c
> +++ b/src/rt-migrate-test/rt-migrate-test.c
> @@ -664,7 +664,7 @@ int main (int argc, char **argv)
>  	print_results();
>  
>  	if (strlen(outfile) != 0)
> -		rt_write_json(outfile, write_stats, NULL);
> +		rt_write_json(outfile, check < 0, write_stats, NULL);
>  
>  	if (stop) {
>  		/*
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index a649e5a0fe5e..8d801b4c154a 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -1228,7 +1228,7 @@ int main(int argc, char **argv)
>  	}
>  
>  	if (strlen(outfile) != 0)
> -		rt_write_json(outfile, write_stats, sched_data);
> +		rt_write_json(outfile, 0, write_stats, sched_data);
>  
>  	if (setcpu_buf)
>  		free(setcpu_buf);
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index 7327d0d0144d..f43920e1a853 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -559,7 +559,7 @@ int main(int argc, char **argv)
>  			free(stat[i].values);
>  	}
>  	if (strlen(outfile) != 0)
> -		rt_write_json(outfile, write_stats, par);
> +		rt_write_json(outfile, ret, write_stats, par);
>  
>  	free(stat);
>   outpar:
> diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
> index 6e8bc7b50d5f..fda44724dd62 100644
> --- a/src/sigwaittest/sigwaittest.c
> +++ b/src/sigwaittest/sigwaittest.c
> @@ -707,7 +707,7 @@ int main(int argc, char *argv[])
>  			.receiver = receiver,
>  			.sender = sender,
>  		};
> -		rt_write_json(outfile, write_stats, &ps);
> +		rt_write_json(outfile, 0, write_stats, &ps);
>  	}
>  
>  nomem:
> diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
> index 7533b1b569cc..9485ab6d95c8 100644
> --- a/src/svsematest/svsematest.c
> +++ b/src/svsematest/svsematest.c
> @@ -779,7 +779,7 @@ int main(int argc, char *argv[])
>  			.receiver = receiver,
>  			.sender = sender,
>  		};
> -		rt_write_json(outfile, write_stats, &ps);
> +		rt_write_json(outfile, 0, write_stats, &ps);
>  	}
>  
>  nosem:
> -- 
> 2.30.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
