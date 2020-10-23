Return-Path: <SRS0=2Uay=D6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903C1C4363A
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 17:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2058D21527
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 17:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABLjkr3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753286AbgJWRTk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Oct 2020 13:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753284AbgJWRTk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Oct 2020 13:19:40 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD237C0613CE
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 10:19:39 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 140so1859079qko.2
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 10:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=EcW0mXCo8kjaGY5W2x6eUVcbjSNJSYcwonopSH5TQQ0=;
        b=ABLjkr3A5tgAzmovObmlMNSgnHabMh+lK4fycJijQZWp/uDlMoOBBm4PFAARqTUtOD
         dyvYtOSDjYGxXMP6aMiyl9a98IufJUtgaM9AW+WP+BmsjKvGnIQr91972z9gbRFv/jzU
         DSqeLzxbWNADxtC7VENrWlFj9yy4G6gWJbqbkxcGcVpkdonJIw5aAaDGqbjivKXevYj3
         +ojc6hZgOyrGbPcaOvNFbbyCBj3v0VoYDKb0IunJBpsLhoZiYCrgDTNhp3fD12s4M6lM
         rPnKk9OdjpZNiV0gtzasNYBQgdHkxaovE2zHOdJUdCX0CUU+hhOfyr4cbVlNcg27IYsw
         qH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=EcW0mXCo8kjaGY5W2x6eUVcbjSNJSYcwonopSH5TQQ0=;
        b=UCSd1eTI2oaMWJ6tk7kSwhAbtZhjA7+AhVWK3Hm4uIXsHyhpuOQm11Z4M9UJhtB0Hs
         3oU450MN7jCqxbilEZoTxifLEvzrv5IWL2BdZidGw802bvZiKdFb3ms9Pm2eCw+JEYuq
         uhg4zvvvleNp2T5G3YJmaRp1yD7//D/NzmZ9v40vgeAXIkApOOhv/R+b+SMFKHKABDMo
         sFeI7wwGPUOaP1kTcrx3WH1vM1CjgeN4f50Q3roPOGmHvV5Y8eWSmEzjeN9DTQjINg11
         sDY1eg0Uuo2P4y0JAL9IX7wIAnx5No2S5H4XkD1lii/NClXavvVpIWpDmdWvTEBEtI4/
         K1JA==
X-Gm-Message-State: AOAM532NcvF8iCOrntBYZWXs+/60IrvSrK4KXckJEBC16k+AwOGZWcdK
        R7Ew5Xu69WjyJszFoUql/EU=
X-Google-Smtp-Source: ABdhPJw+tRa/+uxzl4VbzvE6TjnCBLt5pTW2wWuDyhD4U2kcEfpp9/WnyMnP2z0U7Ic3FdfO1jt2Nw==
X-Received: by 2002:a37:d84:: with SMTP id 126mr3074065qkn.155.1603473578711;
        Fri, 23 Oct 2020 10:19:38 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id w40sm1348128qtj.48.2020.10.23.10.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 10:19:37 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 23 Oct 2020 13:19:36 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 06/18] oslat: Streamline usage output and man
 page
In-Reply-To: <20201007085653.11961-7-dwagner@suse.de>
Message-ID: <d313f57-ad99-d953-59f9-e72539a7688@redhat.com>
References: <20201007085653.11961-1-dwagner@suse.de> <20201007085653.11961-7-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 7 Oct 2020, Daniel Wagner wrote:

> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/oslat/oslat.8 |  2 +-
>  src/oslat/oslat.c | 78 ++++++++++++++++++++++-------------------------
>  2 files changed, 38 insertions(+), 42 deletions(-)
> 
> diff --git a/src/oslat/oslat.8 b/src/oslat/oslat.8
> index 85f2c5bcdf5c..b481d8d82783 100644
> --- a/src/oslat/oslat.8
> +++ b/src/oslat/oslat.8
> @@ -36,7 +36,7 @@ Total memory usage will be this value multiplies 2*N,
>  because there will be src/dst buffers for each thread, and
>  N is the number of processors for testing.
>  .TP
> -.B \-t, \-\-runtime=SEC
> +.B \-D, \-\-duration=TIME
>  Specify test duration, e.g., 60, 20m, 2H (m/M: minutes, h/H: hours, d/D: days).
>  By default the unit is s/second.
>  .TP
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index f1a82f2367d2..fafbdd694326 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -507,42 +507,37 @@ static void handle_alarm(int code)
>  	g.cmd = STOP;
>  }
>  
> -const char *helpmsg =
> -"Usage: %s [options]\n"
> -"\n"
> -"This is an OS latency detector by running busy loops on specified cores.\n"
> -"Please run this tool using root.\n"
> -"\n"
> -"Available options:\n"
> -"\n"
> -"  -b, --bucket-size      Specify the number of the buckets (4-1024)\n"
> -"  -B, --bias             Add a bias to all the buckets using the estimated mininum\n"
> -"  -c, --cpu-list         Specify CPUs to run on, e.g. '1,3,5,7-15'\n"
> -"  -C, --cpu-main-thread  Specify which CPU the main thread runs on.  Default is cpu0.\n"
> -"  -f, --rtprio           Using SCHED_FIFO priority (1-99)\n"
> -"  -m, --workload-mem     Size of the memory to use for the workload (e.g., 4K, 1M).\n"
> -"                         Total memory usage will be this value multiplies 2*N,\n"
> -"                         because there will be src/dst buffers for each thread, and\n"
> -"                         N is the number of processors for testing.\n"
> -"  -s, --single-preheat   Use a single thread when measuring latency at preheat stage\n"
> -"                         NOTE: please make sure the CPU frequency on all testing cores\n"
> -"                         are locked before using this parmater.  If you don't know how\n"
> -"                         to lock the freq then please don't use this parameter.\n"
> -"  -t, --runtime          Specify test duration, e.g., 60, 20m, 2H\n"
> -"                         (m/M: minutes, h/H: hours, d/D: days)\n"
> -"  -T, --trace-threshold  Stop the test when threshold triggered (in us),\n"
> -"                         print a marker in ftrace and stop ftrace too.\n"
> -"  -v, --version          Display the version of the software.\n"
> -"  -w, --workload         Specify a kind of workload, default is no workload\n"
> -"                         (options: no, memmove)\n"
> -"  -z, --zero-omit        Don't display buckets in the output histogram if all zeros.\n"
> -"\n"
> -;
> -
> -static void usage(void)
> +static void usage(int error)
>  {
> -	printf(helpmsg, g.app_name);
> -	exit(1);
> +	printf("oslat V %1.2f\n", VERSION);
> +	printf("Usage:\n"
> +	       "oslat <options>\n\n"
> +	       "This is an OS latency detector by running busy loops on specified cores.\n"
> +	       "Please run this tool using root.\n\n"
> +	       "Available options:\n\n"
> +	       "-b, --bucket-size      Specify the number of the buckets (4-1024)\n"
> +	       "-B, --bias             Add a bias to all the buckets using the estimated mininum\n"
> +	       "-c, --cpu-list         Specify CPUs to run on, e.g. '1,3,5,7-15'\n"
> +	       "-C, --cpu-main-thread  Specify which CPU the main thread runs on.  Default is cpu0.\n"
> +	       "-D, --duration         Specify test duration, e.g., 60, 20m, 2H\n"
> +	       "                       (m/M: minutes, h/H: hours, d/D: days)\n"
> +	       "-f, --rtprio           Using SCHED_FIFO priority (1-99)\n"
> +	       "-m, --workload-mem     Size of the memory to use for the workload (e.g., 4K, 1M).\n"
> +	       "                       Total memory usage will be this value multiplies 2*N,\n"
> +	       "                       because there will be src/dst buffers for each thread, and\n"
> +	       "                       N is the number of processors for testing.\n"
> +	       "-s, --single-preheat   Use a single thread when measuring latency at preheat stage\n"
> +	       "                       NOTE: please make sure the CPU frequency on all testing cores\n"
> +	       "                       are locked before using this parmater.  If you don't know how\n"
> +	       "                       to lock the freq then please don't use this parameter.\n"
> +	       "-T, --trace-threshold  Stop the test when threshold triggered (in us),\n"
> +	       "                       print a marker in ftrace and stop ftrace too.\n"
> +	       "-v, --version          Display the version of the software.\n"
> +	       "-w, --workload         Specify a kind of workload, default is no workload\n"
> +	       "                       (options: no, memmove)\n"
> +	       "-z, --zero-omit        Don't display buckets in the output histogram if all zeros.\n"
> +	       );
> +	exit(error);
>  }
>  
>  /* TODO: use libnuma? */
> @@ -661,7 +656,7 @@ static void parse_options(int argc, char *argv[])
>  			{ "bucket-size", required_argument, NULL, 'b' },
>  			{ "cpu-list", required_argument, NULL, 'c' },
>  			{ "cpu-main-thread", required_argument, NULL, 'C'},
> -			{ "runtime", required_argument, NULL, 't' },
> +			{ "duration", required_argument, NULL, 'D' },
>  			{ "rtprio", required_argument, NULL, 'f' },
>  			{ "help", no_argument, NULL, 'h' },
>  			{ "trace-threshold", required_argument, NULL, 'T' },
> @@ -673,7 +668,7 @@ static void parse_options(int argc, char *argv[])
>  			{ "version", no_argument, NULL, 'v'},
>  			{ NULL, 0, NULL, 0 },
>  		};
> -		int i, c = getopt_long(argc, argv, "b:Bc:C:f:hm:st:w:T:vz",
> +		int i, c = getopt_long(argc, argv, "b:Bc:C:D:f:hm:sw:T:vz",
>  				       options, NULL);
>  		long ncores;
>  
> @@ -704,7 +699,7 @@ static void parse_options(int argc, char *argv[])
>  				exit(1);
>  			}
>  			break;
> -		case 't':
> +		case 'D':
>  			g.runtime = parse_runtime(optarg);
>  			if (!g.runtime) {
>  				printf("Illegal runtime: %s\n", optarg);
> @@ -761,8 +756,11 @@ static void parse_options(int argc, char *argv[])
>  		case 'z':
>  			g.output_omit_zero_buckets = 1;
>  			break;
> +		case 'h':
> +			usage(0);
> +			break;
>  		default:
> -			usage();
> +			usage(1);
>  			break;
>  		}
>  	}
> @@ -821,8 +819,6 @@ int main(int argc, char *argv[])
>  	/* Run the main thread on cpu0 by default */
>  	g.cpu_main_thread = 0;
>  
> -	printf("\nVersion: %1.2f\n\n", VERSION);
> -
>  	parse_options(argc, argv);
>  
>  	TEST(mlockall(MCL_CURRENT | MCL_FUTURE) == 0);
> -- 
> 2.28.0
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>

Thanks

In the future at least put one line in the text though, not just a title.
