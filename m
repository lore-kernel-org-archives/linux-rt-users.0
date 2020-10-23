Return-Path: <SRS0=2Uay=D6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65807C388F9
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07C0F21D47
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEoJPld+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464838AbgJWQBF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374472AbgJWQBF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Oct 2020 12:01:05 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2829BC0613CE
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 09:01:05 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id w9so936086qvj.0
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 09:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=EBM8ICCXy8tIou37Zve5BuPQUAk5PuUFfEVnlGQMHZo=;
        b=kEoJPld+NTla5HyXTpVDfx7dmsT0fxbxzLpvMCWbI6trJrKK7wnvx45M4LJ+KqImqs
         QrasiNOnI1VA+D1bGZnMNNJejQxkxhUbzmNpvODKdDw5b+RJ75wkb3WqBCugM2DaRWMm
         yn7lX16weKhsrjqnxG2U3tWWMqNCV1y54gGLCYOet5Co+EMBDsOUIAwTGcZsFjHfEriQ
         QeARD/fETOgUejL6JxQRNloBO/VBbb+pcvwGqCObLhwXsPBIleZjh7La1GbI5EtyJi1T
         o6iwy1mbrQZYua8Y8v0Jl4agl6NpLjpoeAoET8iQyIpLkZvP22FrI6H89z5jTz9yCBYD
         lMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=EBM8ICCXy8tIou37Zve5BuPQUAk5PuUFfEVnlGQMHZo=;
        b=Yf6pnhBkpfntrMR2YlMAGsgg3HdG9uZo4Sw5kDRcbpr0W6oN2QfTIEtfRDgWMwtSit
         tdfk5Kil1RhQIWdCFNUk5/SV+1YQIRcNl2qwD5ji0vIv+MSlERBangkbR+w89VhUi8KG
         hhIE79uq056eMFuyfYBCZn8IR3BzSHf34Uh1CgoaMziNMUFkD6DXBHWKVazfHXMXCIP6
         6Kw1ZOLFaTu45Gqn3X9U5ZZ5OxznRAd7qUwgj7mlpoJDWGC2Y3+s3EDfHP1ipf8CIi06
         X1yynEEBdLbx/yifbhEIv/v0UVNwfiigcYziYINP8HC01C+CMHZGPig5fMf1vCboeNUl
         IOUw==
X-Gm-Message-State: AOAM531yTBg0t3ayqh+t9ub9u7YI33WyodC/LC5N07dHp+zZX0BSufWG
        HPL/Zz16zeD8YgwsF38+m/g=
X-Google-Smtp-Source: ABdhPJw1yGwQt6jM0qJP3jka81HJk/xmbHIVm7gMT4pJAxjlw9SwHA7GqbN9KN8f+wiUQJiqgM7bMQ==
X-Received: by 2002:a05:6214:594:: with SMTP id bx20mr2971665qvb.2.1603468863773;
        Fri, 23 Oct 2020 09:01:03 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id p13sm975873qkj.58.2020.10.23.09.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:01:03 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 23 Oct 2020 12:01:02 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 03/18] cyclicdeadline: Streamline usage output and
 man page
In-Reply-To: <20201007085653.11961-4-dwagner@suse.de>
Message-ID: <9fc89d36-8b6e-54fa-ffef-a178ade3ecde@redhat.com>
References: <20201007085653.11961-1-dwagner@suse.de> <20201007085653.11961-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 7 Oct 2020, Daniel Wagner wrote:

> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/sched_deadline/cyclicdeadline.8 | 24 ++++++++---------
>  src/sched_deadline/cyclicdeadline.c | 41 +++++++++++++++--------------
>  2 files changed, 33 insertions(+), 32 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.8 b/src/sched_deadline/cyclicdeadline.8
> index 91766fb391c4..6df7faf445f9 100644
> --- a/src/sched_deadline/cyclicdeadline.8
> +++ b/src/sched_deadline/cyclicdeadline.8
> @@ -17,7 +17,7 @@ cyclicdeadline \- This program is used to test the deadline scheduler (SCHED_DEA
>  .PP
>  .SH SYNOPSIS
>  .B cyclicdeadline
> -.RI "[-ha] [-c cpulist] [-i interval] [-s step] [-t nr_threads] [-D duration]
> +.RI "[-ha] [-c CPUSET] [-D TIME] [-i INTV] [-s STEP] [-t NUM]"
>  .PP
>  .SH DESCRIPTION
>  .B cyclicdeadline
> @@ -25,28 +25,28 @@ is a cyclictest style program for testing the deadline scheduler
>  .PP
>  .SH OPTIONS
>  .TP
> -.B \-h
> -Show this help menu
> -.TP
>  .B \-a
>  Use all CPUs
>  .TP
> -.B \-c cpulist
> +.B \-c CPUSET
>  Comma / hypen separated list of CPUs to run deadline tasks on
>  .TP
> -.B \-i interval
> +.B \-D TIME
> +Specify a length for the test to run
> +Append 'm', 'h', or 'd' to specify minutes, hours, or days
> +.TP
> +.B \-h
> +Show this help menu
> +.TP
> +.B \-i INTV
>  The shortest deadline for the tasks in us. (default 1000us)
>  .TP
> -.B \-s step
> +.B \-s STEP
>  The amount to increase the deadline for each task in us. (default 500us)
>  .TP
> -.B \-t nr_threads
> +.B \-t NUM
>  The number of threads to run as deadline (default 1)
> -.TP
> -.B \-D time
> -Specify a length for the test to run
>  .br
> -Append 'm', 'h', or 'd' to specify minutes, hours, or days
>  .SH AUTHOR
>  cyclicdeadline was written by Steven Rostedt <rostedt@goodmis.org>
>  .PP
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index a08e28e73c42..310880805553 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -630,26 +630,25 @@ static void teardown(void)
>  	destroy_cpuset(CPUSET_LOCAL, 1);
>  }
>  
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
> -	       " -a - Use all CPUs\n"
> -	       " -c cpulist - Comma/hyphen separated list of CPUs to run deadline tasks on\n"
> -	       " -i interval(us) - The shortest deadline for the tasks (default 1000us)\n"
> -	       " -s step(us) - The amount to increase the deadline for each task (default 500us)\n"
> -	       " -t threads - The number of threads to run as deadline (default 1)\n"
> -	       " -D time - Specify a length for the test run\n"
> -	       "           Append 'm', 'h', or 'd' to specify minutes, hours or days\n"
> -	       "\n", p);
> -	exit(-1);
> +	printf("cyclicdeadline V %1.2f\n", VERSION);
> +	printf("Usage:\n"
> +	       "cyclicdeadline <options>\n\n"
> +	       "-a                         Use all CPUs\n"
> +	       "-c CPUSET                  Comma/hyphen separated list of 
CPUs to run deadline\n"
> +	       "                           tasks on.\n"
> +	       "-D TIME                    Specify a length for the test run.\n"
> +	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
> +	       "                           days\n"
> +	       "-h                         Show this help menu.\n"
> +	       "-i INTV                    The shortest deadline for the tasks in us\n"
> +	       "                           (default 1000us).\n"
> +	       "-s STEP                    The amount to increase the deadline for each task in us\n"
> +	       "                           (default 500us).\n"
> +	       "-t NUM                     The number of threads to run as deadline (default 1).\n"
> +	       );
> +	exit(error);
>  }
>  
>  static int fail;
> @@ -1057,8 +1056,10 @@ int main (int argc, char **argv)
>  			duration = parse_time_string(optarg);
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
Signed-off-by: John Kacur <jkacur@redhat.com>

Thanks!
