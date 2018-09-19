Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43283 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731221AbeISURw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 Sep 2018 16:17:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so6061214wre.10
        for <linux-rt-users@vger.kernel.org>; Wed, 19 Sep 2018 07:39:38 -0700 (PDT)
Date: Wed, 19 Sep 2018 16:39:28 +0200 (CEST)
From: John Kacur <jkacur@redhat.com>
Subject: Re: [patch 1/2] add -h option to queuelat
In-Reply-To: <20180904115700.461458689@redhat.com>
Message-ID: <alpine.LFD.2.21.1809191638280.6250@planxty>
References: <20180904115633.410153367@redhat.com> <20180904115700.461458689@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>



On Tue, 4 Sep 2018, Marcelo Tosatti wrote:

> Add -h (help) option to queuelat, which lists all 
> options.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
>  src/queuelat/README     |    1 +
>  src/queuelat/queuelat.c |   17 ++++++++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> Index: rt-tests/src/queuelat/README
> ===================================================================
> --- rt-tests.orig/src/queuelat/README	2018-09-03 16:31:38.578945651 -0300
> +++ rt-tests/src/queuelat/README	2018-09-03 16:31:56.083000015 -0300
> @@ -51,6 +51,7 @@
>  mpps(million-packet-per-sec): million packets per second (float).
>  tsc_freq_mhz: TSC frequency in MHz, as measured by TSC PIT calibration 
>  (search for "Detected XXX MHz processor" in dmesg, and use the integer part).
> +timeout: timeout (in seconds).
>  
>  How it works
>  ============
> Index: rt-tests/src/queuelat/queuelat.c
> ===================================================================
> --- rt-tests.orig/src/queuelat/queuelat.c	2018-09-03 16:31:38.578945651 -0300
> +++ rt-tests/src/queuelat/queuelat.c	2018-09-03 16:31:56.084000018 -0300
> @@ -532,6 +532,18 @@
>  	return nr_packets_drain_per_block;
>  }
>  
> +
> +void print_help(void)
> +{
> +	printf("usage: queuelat [options]\n");
> +	printf("-h show this help menu\n");
> +	printf("-m max-queue-len (maximum latency allowed, in nanoseconds) (int)\n");
> +	printf("-c cycles-per-packet (number of cycles to process one packet (int)\n");
> +	printf("-p million-packet-per-sec (million packets per second) (float)\n");
> +	printf("-f tsc-freq-mhz (TSC frequency in MHz) (float)\n");
> +	printf("-t timeout (timeout, in seconds) (int)\n");
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	double tsc_freq_mhz;
> @@ -549,7 +561,7 @@
>  
>  	opterr = 0;
>  
> -	while ((c = getopt (argc, argv, "m:c:p:f:t:q:")) != -1)
> +	while ((c = getopt (argc, argv, "m:c:p:f:t:q:h")) != -1)
>  		switch (c)
>  		{
>  		case 'm':
> @@ -570,6 +582,9 @@
>  		case 'q':
>  			qvalue = optarg;
>  			break;
> +		case 'h':
> +			print_help();
> +			return 0;
>  		case '?':
>  			if (optopt == 'm' || optopt == 'c' || optopt == 'p' ||
>  			    optopt == 'f' || optopt == 't' || optopt == 'q')
> 
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com
