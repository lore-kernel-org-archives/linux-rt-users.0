Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93449C433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CBC26145E
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbhEGRAF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 13:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbhEGRAF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 13:00:05 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B548C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:59:05 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id p6so7064666qtk.13
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=W1A1LP8orspCsCviu4p3kmsynJbr2s81/yj6HaAQfho=;
        b=YEscfICaQkR1AzKyfTrlOmPj7I9uVo3mXTulAHOerrdbAof48d+jahXbIvuLYAxXnZ
         g3DbmmljIsULN2XfWKbXJ0xt6eSgb8inAy49bxpbBBQEL3n6rJQ1iUM+tpD97tW5TPDL
         DiuUTZYpg8fTIicLsfPkdLs/yYkCmFSnrHaaWp/2atYnoGCC0V6eZP5DAZBXemKGpP8j
         lP7qsiHM6oN7PkS6oISb4vxHbrVjQgDbr7NECXAdNWDrgvCMPWYsEvsBqcsrfxKAoLjL
         iL9vnbCqJKouFFdfqk8AINW7YQzqFqZZY33GWw8DfHkzV2PywaCvA6HwJa/ZpCFEMXPk
         gBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=W1A1LP8orspCsCviu4p3kmsynJbr2s81/yj6HaAQfho=;
        b=tpZ2tbPn0qW3XM5un6NNKBeOPsnmctdAY6m6TWmjYuLAUpdd5yfmlNhTHZ0fgPhZ4m
         z6BPsacC/28JOp5+0M9XSimmEG6Rhjn1rnBObHO0tYls6eXQeOq1Caq4Cx85QJSZSNe4
         8QtG4W70ZJ49/0hJipLm9s8ATUydu9tlc8zhaVy0vscH8arUFtwsS7zELe85bplYfNsE
         Q437VrMIc23WIRsRmHFOZK5ve49FElLKboRJwS4+QBaQXWnf25lPqrq7QghXCRJPIzND
         w9JYQPOJ7eY7Deb0IxZxkTyMjGng+IeqLwTYvkVAK15XueaMEDlzA1rOYQ21X4FSPMo2
         w0Rg==
X-Gm-Message-State: AOAM532jihIwahnWlkNqs9VG3aH8SUh31s8Tr79hoJM3Tc/FtsAnVeu0
        JXSNslYFwtGHScRkTqb+xf+xmmHDf4V25g==
X-Google-Smtp-Source: ABdhPJw+XXhrhOHAqqHZXN+6+ZHA8AiAitQ35DTei1mO4NmQIRuM90hVkl+bXG4MKM5ih+wScizjaQ==
X-Received: by 2002:ac8:53c7:: with SMTP id c7mr1512401qtq.74.1620406744801;
        Fri, 07 May 2021 09:59:04 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id h19sm5144521qkj.33.2021.05.07.09.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:59:04 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:59:03 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 31/33] pi_stress: Add JSON output feature
In-Reply-To: <20210320183829.1318-32-dwagner@suse.de>
Message-ID: <28158ea-eeca-1ff5-355a-1ba4f54665@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-32-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> Write the test results as JSON output to a file. This allows to
> simplifies any parsing later on.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/pi_tests/pi_stress.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> index 73f0e6a402e3..3f93d4aadd53 100644
> --- a/src/pi_tests/pi_stress.c
> +++ b/src/pi_tests/pi_stress.c
> @@ -99,6 +99,9 @@ int debugging = 0;
>  
>  int quiet = 0;	/* turn off all prints, default = 0 (off) */
>  
> +/* filename for JSON output */
> +char outfile[MAX_PATH];
> +
>  /* prompt to start test */
>  int prompt = 0;
>  
> @@ -209,6 +212,7 @@ int create_group(struct group_parameters *group);
>  unsigned long total_inversions(void);
>  void banner(void);
>  void summary(void);
> +void write_stats(FILE *f, void *data);
>  void wait_for_termination(void);
>  int barrier_init(pthread_barrier_t *b, const pthread_barrierattr_t *attr,
>  		 unsigned int count, const char *name);
> @@ -235,6 +239,7 @@ int main(int argc, char **argv)
>  
>  
>  	/* process command line arguments */
> +	rt_init(argc, argv);
>  	process_command_line(argc, argv);
>  
>  	/* set default sched attributes */
> @@ -299,6 +304,7 @@ int main(int argc, char **argv)
>  	}
>  	/* report */
>  	banner();
> +	rt_test_start();
>  	start = time(NULL);
>  
>  	/* turn loose the threads */
> @@ -335,6 +341,10 @@ int main(int argc, char **argv)
>  		kill(0, SIGTERM);
>  	finish = time(NULL);
>  	summary();
> +
> +	if (strlen(outfile) != 0)
> +		rt_write_json(outfile, retval, write_stats, NULL);
> +
>  	if (lockall)
>  		munlockall();
>  	exit(retval);
> @@ -983,6 +993,7 @@ void usage(int error)
>  	       "-h       --help            print this message\n"
>  	       "-i INV   --inversions=INV  number of inversions per group (default is infinite)\n"
>  	       "-m       --mlockall        lock current and future memory\n"
> +	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
>  	       "-p       --prompt          prompt before starting the test\n"
>  	       "-q       --quiet           suppress running output\n"
>  	       "-r       --rr              use SCHED_RR for test threads [SCHED_FIFO]\n"
> @@ -1276,7 +1287,7 @@ int process_sched_line(const char *arg)
>  
>  enum option_values {
>  	OPT_DEBUG=1, OPT_DURATION, OPT_GROUPS, OPT_HELP, OPT_INVERSIONS,
> -	OPT_MLOCKALL, OPT_PROMPT, OPT_QUIET, OPT_RR, OPT_SCHED,
> +	OPT_MLOCKALL, OPT_OUTPUT, OPT_PROMPT, OPT_QUIET, OPT_RR, OPT_SCHED,
>  	OPT_UNIPROCESSOR, OPT_VERBOSE, OPT_VERSION,
>  };
>  
> @@ -1290,6 +1301,7 @@ void process_command_line(int argc, char **argv)
>  			{"help",		no_argument,		NULL, OPT_HELP},
>  			{"inversions",		required_argument,	NULL, OPT_INVERSIONS},
>  			{"mlockall",		no_argument,		NULL, OPT_MLOCKALL},
> +			{"output",		required_argument,	NULL, OPT_OUTPUT},
>  			{"prompt",		no_argument,		NULL, OPT_PROMPT},
>  			{"quiet",		no_argument,		NULL, OPT_QUIET},
>  			{"rr",			no_argument,		NULL, OPT_RR},
> @@ -1336,6 +1348,9 @@ void process_command_line(int argc, char **argv)
>  		case 'm':
>  			lockall = 1;
>  			break;
> +		case OPT_OUTPUT:
> +			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
> +			break;
>  		case OPT_PROMPT:
>  		case 'p':
>  			prompt = 1;
> @@ -1439,6 +1454,11 @@ void summary(void)
>  	       t->tm_yday, t->tm_hour, t->tm_min, t->tm_sec);
>  }
>  
> +void write_stats(FILE *f, void *data)
> +{
> +	fprintf(f, "  \"inversion\": %lu\n", total_inversions());
> +}
> +
>  int
>  barrier_init(pthread_barrier_t *b, const pthread_barrierattr_t *attr,
>  	     unsigned int count, const char *name)
> -- 
> 2.30.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
