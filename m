Return-Path: <SRS0=2Uay=D6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8CEC4363A
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 16:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1483C2168B
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 16:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/FvCxgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465155AbgJWQKP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S465138AbgJWQKP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Oct 2020 12:10:15 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54974C0613CE
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 09:10:15 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c15so1333656qtc.2
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 09:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=kHZU7r3IdDJvHAj+/4U+geBXcddEJfmvFeHVZUal4Gk=;
        b=R/FvCxgqqfK788HR+jigLCc2xK7XYyJNCr/HzYBUqx4+3ck0ZkQ/bNN3JbxlcImg4Z
         XE1NNsIfBXASe0pi36Jyu8uBJYlskdz/IDTfAipV6VjyEWq58pqaP6wzSeU3sWGizCI3
         MYE4RWjw5gubR3EghrfyZPC4jIFHWE4Vj74xxIhOGwrcSsBejSzSX6s2um4aAZicnWHY
         0EdZoRZc1pn+9UV+qoaFaWJEHSaHH1eEXAKVICIwNPX7QCN3o4S/lUDhGWiP+m98X2u4
         eZahRPXvFw1vzulU9yPTiOmaasPq0PvlxUnF6yMfsKVcE9Nwd/quhybbqB1wNBaZDEEF
         x9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=kHZU7r3IdDJvHAj+/4U+geBXcddEJfmvFeHVZUal4Gk=;
        b=MkDG/9YK/2UwuFeXyP6okcVtWw+8KdzbQbT5+3KEESf4F2XxwBz1rlpK4SyxtSTtlL
         3FJnZd1PUdYt+7OsYrMwSjD/midyuHS/H3o8fBoa2UntWiC74C8HuSKBoxhncAmA1UGS
         YsltbNAz3MoZ5wdqvzyccGGkrWiZrIDOxmSBdbMko14nkeaUbFghAMGD819dsF1lQmtT
         8rWY1ioSL5CDc5aMJoBjZRDwlBpoGbKF5wAyhf/4j7zOGGww70XiU6qGzdU6ttc/1Dkx
         PdrXvi5UIwuQjje4Q7/saLnftHDXLGjUFQeiyizUrHjcaSjMpueMz1dlTRCikrpvVLqy
         31gw==
X-Gm-Message-State: AOAM531boUNvZ7UHv2xWDGJQBZ+EttJz5R5i7Y1tANRoqmwWKTvJx2kY
        uR/mSKKciH+t/2Qq+LXwFJE=
X-Google-Smtp-Source: ABdhPJw7sPXWvxmFLkCeNovId8UQsX1gDUtPkKHc+I9KwXA1xSLqdDFoKWyoqUqCwck+9txVxJFK4w==
X-Received: by 2002:ac8:5903:: with SMTP id 3mr2916924qty.166.1603469414480;
        Fri, 23 Oct 2020 09:10:14 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id 185sm998853qke.16.2020.10.23.09.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:10:13 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 23 Oct 2020 12:10:13 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 05/18] deadline_test: Streamline usage output and
 man page
In-Reply-To: <20201007085653.11961-6-dwagner@suse.de>
Message-ID: <a6c01f93-cca-b351-855f-bc3ad7c98e17@redhat.com>
References: <20201007085653.11961-1-dwagner@suse.de> <20201007085653.11961-6-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 7 Oct 2020, Daniel Wagner wrote:

> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/sched_deadline/deadline_test.8 | 37 ++++++++++++-----------
>  src/sched_deadline/deadline_test.c | 47 +++++++++++++++---------------
>  2 files changed, 41 insertions(+), 43 deletions(-)
> 
> diff --git a/src/sched_deadline/deadline_test.8 b/src/sched_deadline/deadline_test.8
> index 5dc99c0bfc63..8f32c5b6feb6 100644
> --- a/src/sched_deadline/deadline_test.8
> +++ b/src/sched_deadline/deadline_test.8
> @@ -19,45 +19,44 @@ deadline_test \- High resolution test program
>  This program is used to test the deadline scheduler (SCHED_DEADLINE tasks)
>  .SH SYNOPSIS
>  .B deadline_test
> -.RI "[ \-hb ] [ \-r prio ] [ \-c cpulist ] [ \-i interval ] [ \-p percent ] [ \-P percent ] [ \-t threads ] [ \-s step[us) ]"
> -
> +.RI "[ \-hb ] [ \-c CPUSET ] [ \-i INTV ] [ \-p PERCENT ] [ \-P PERCENT ] \
> +[ \-r PRIO ]  [ \-s STEP ] [ \-t NUM ]"
>  .SH OPTIONS
>  .TP
> -.B \-h
> -Show this help menu
> -.br
> -.TP
>  .B \-b
>  Bind on the last cpu. (shortcut for -c <lastcpu>)
>  .br
>  .TP
> -.B \-r prio
> -Add an RT task with given prio to stress system
> +.B \-c CPUSET
> +Comma/hyphen separated list of CPUs to run deadline tasks on
>  .br
>  .TP
> -.B \-c cpulist
> -Comma/hyphen separated list of CPUs to run deadline tasks on
> +.B \-h
> +Show this help menu
>  .br
>  .TP
> -.B \-i interval
> +.B \-i INTV
>  The shortest deadline for the tasks
>  .br
>  .TP
> -.B \-p percent
> +.B \-p PERCENT
>  The percent of bandwidth to use (1-90%)
>  .br
>  .TP
> -.B \-P percent
> -The percent of runtime for execution completion
> -              (Default 100%)
> +.B \-P PERCENT
> +The percent of runtime for execution completion (default 100%)
>  .br
>  .TP
> -.B \-t threads
> -The number of threads to run as deadline (default 1)
> +.B \-r PRIO
> +Add an RT task with given prio to stress system
>  .br
>  .TP
> -.B \-s step(us)
> -The amount to increase the deadline for each task (default 500us)
> +.B \-s STEP
> +The amount to increase the deadline for each task in us (default 500us)
> +.br
> +.TP
> +.B \-t NUM
> +The number of threads to run as deadline (default 1)
>  .br
>  .SH AUTHOR
>  Deadline test was written by Steven Rostedt <rostedt@goodmis.org>
> diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
> index 4cef2609912e..060ac896aef2 100644
> --- a/src/sched_deadline/deadline_test.c
> +++ b/src/sched_deadline/deadline_test.c
> @@ -46,33 +46,30 @@
>  
>  /**
>   * usage - show the usage of the program and exit.
> - * @argv: The program passed in args
> + * @error: Exit error code to be used
>   *
> - * This is defined here to show people looking at this code how
> + * This is defined here to show peoplde looking at this code how
>   * to use this program as well. 
>   */
> -static void usage(char **argv)
> +static void usage(int error)
>  {
> -	char *arg = argv[0];
> -	char *p = arg+strlen(arg);
> -
> -	while (p >= arg && *p != '/')
> -		p--;
> -	p++;
> -
> -	printf("usage: %s [options]\n"
> -	       " -h - Show this help menu\n"
> -	       " -b - Bind on the last cpu. (shortcut for -c <lastcpu>)\n"
> -	       " -r prio - Add an RT task with given prio to stress system\n"
> -	       " -c cpulist - Comma/hyphen separated list of CPUs to run deadline tasks on\n"
> -	       " -i interval - The shortest deadline for the tasks\n"
> -	       " -p percent - The percent of bandwidth to use (1-90%%)\n"
> -	       " -P percent - The percent of runtime for execution completion\n"
> -	       "              (Default 100%%)\n"
> -	       " -t threads - The number of threads to run as deadline (default 1)\n"
> -	       " -s step(us) - The amount to increase the deadline for each task (default 500us)\n"
> -	       "\n", p);
> -	exit(-1);
> +	printf("deadline_test V %1.2f\n", VERSION);
> +	printf("Usage:\n"
> +	       "deadline_test <options>\n"
> +	       "-b                         Bind on the last cpu. (shortcut for -c <lastcpu>)\n"
> +	       "-c CPUSET                  Comma/hyphen separated list of CPUs to run deadline\n"
> +	       "                           tasks on\n"
> +	       "-h                         Show this help menu\n"
> +	       "-i INTV                    The shortest deadline for the tasks\n"
> +	       "-p PERCENT                 The percent of bandwidth to use (1-90%%)\n"
> +	       "-P PERCENT                 The percent of runtime for execution completion\n"
> +	       "                           (default 100%%)\n"
> +	       "-r PRIO                    Add an RT task with given prio to stress system\n"
> +	       "-s STEP                    The amount to increase the deadline for each task in us\n"
> +	       "                           (default 500us)\n"
> +	       "-t NUM                     The number of threads to run as deadline (default 1)\n"
> +	       );
> +	exit(error);
>  }
>  
>  #define _STR(x) #x
> @@ -1753,8 +1750,10 @@ int main (int argc, char **argv)
>  			rt_task = atoi(optarg);
>  			break;
>  		case 'h':
> +			usage(0);
> +			break;
>  		default:
> -			usage(argv);
> +			usage(1);
>  		}
>  	}
>  
> -- 
> 2.28.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com

Thanks!
