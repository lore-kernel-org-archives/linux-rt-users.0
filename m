Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDC9C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 May 2022 15:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbiEWPox (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 23 May 2022 11:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiEWPon (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 May 2022 11:44:43 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336EF381
        for <linux-rt-users@vger.kernel.org>; Mon, 23 May 2022 08:44:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=wuyihao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VED2ovt_1653320676;
Received: from B-V5AVMD6P-1927.local(mailfrom:wuyihao@linux.alibaba.com fp:SMTPD_---0VED2ovt_1653320676)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 23 May 2022 23:44:36 +0800
Subject: Re: [PATCH 2/2] hackbench: Add af_inet mode besides af_unix and pipe
From:   Yihao Wu <wuyihao@linux.alibaba.com>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org
References: <20220428103726.108597-1-wuyihao@linux.alibaba.com>
 <20220428103726.108597-3-wuyihao@linux.alibaba.com>
Message-ID: <716e374e-f4c4-8d2f-4369-d22fe8e89114@linux.alibaba.com>
Date:   Mon, 23 May 2022 23:44:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220428103726.108597-3-wuyihao@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

I regenerated the second patch and sent it to you. Now it should be 
applied successfully without the first patch.

Thanks a lot for your patient reviewing and comments!

Yihao

On 2022/4/28 18:37, Yihao Wu wrote:
> We observerved strange performance regression with hackbench, but only with
> its default mode instead of pipe mode. It turned out it was unix domain
> socket to blame rather than the scheduler. Because on older kernels, there
> was a big lock. And modifications to the scheduler made the contension
> worse.
> 
> However pipe mode is much different from the default af_unix mode. So it's
> hard to prove it's really the case. So we think it might be a good idea to
> have af_inet mode for hackbench.
> 
> After implementing it, we compare these three modes. And the result shows
> as what we expect, that only af_unix mode has regression, the others don't.
> This proves adding af_inet mode is valuable.
> 
> Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
> ---
>   src/hackbench/hackbench.c | 57 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
> index b9b0af6..030342f 100644
> --- a/src/hackbench/hackbench.c
> +++ b/src/hackbench/hackbench.c
> @@ -20,11 +20,14 @@
>   #include <string.h>
>   #include <errno.h>
>   #include <unistd.h>
> +#include <sys/ioctl.h>
>   #include <sys/types.h>
>   #include <sys/socket.h>
>   #include <sys/wait.h>
>   #include <sys/time.h>
>   #include <sys/poll.h>
> +#include <netinet/in.h>
> +#include <arpa/inet.h>
>   #include <limits.h>
>   #include <getopt.h>
>   #include <signal.h>
> @@ -46,6 +49,7 @@ static unsigned int fifo = 0;
>   static unsigned int process_mode = PROCESS_MODE;
>   
>   static int use_pipes = 0;
> +static int use_inet = 0;
>   
>   struct sender_context {
>   	unsigned int num_fds;
> @@ -99,6 +103,7 @@ static void print_usage_exit(int error)
>   	       "-h       --help            print this message\n"
>   	       "-l       --loops=LOOPS     how many message should be send\n"
>   	       "-p       --pipe            send data via a pipe\n"
> +	       "-i       --inet            send data via a inet tcp connection\n"
>   	       "-s       --datasize=SIZE   message size\n"
>   	       "-T       --threads         use POSIX threads\n"
>   	       "-P       --process         use fork (default)\n"
> @@ -106,11 +111,52 @@ static void print_usage_exit(int error)
>   	exit(error);
>   }
>   
> +static int inet_socketpair(int fds[2])
> +{
> +	int s1, s2;
> +	struct sockaddr_in sin;
> +	unsigned long ul = 1;
> +
> +	if ((s1 = socket(AF_INET, SOCK_STREAM, 0)) < 0)
> +		barf("socket");
> +	if ((s2 = socket(AF_INET, SOCK_STREAM, 0)) < 0)
> +		barf("socket");
> +
> +	socklen_t len = sizeof(sin);
> +	bzero(&sin, len);
> +	sin.sin_family = AF_INET;
> +	sin.sin_port = 0;
> +	sin.sin_addr.s_addr = inet_addr("127.0.0.1");
> +
> +	if (bind(s1, &sin, len) < 0)
> +		barf("bind");
> +	getsockname(s1, &sin, &len);
> +	if (listen(s1, 10) < 0)
> +		barf("listen");
> +	if (ioctl(s2, FIONBIO, &ul) < 0)
> +		barf("ioctl");
> +	if (ioctl(s1, FIONBIO, &ul) < 0)
> +		barf("ioctl");
> +	connect(s2, &sin, len);
> +	if ((fds[0] = accept(s1, &sin, &len)) < 0)
> +		barf("accept");
> +	ul = 0;
> +	if (ioctl(s2, FIONBIO, &ul) < 0)
> +		barf("ioctl");
> +	fds[1] = s2;
> +	close(s1);
> +
> +	return 0;
> +}
> +
>   static void fdpair(int fds[2])
>   {
>   	if (use_pipes) {
>   		if (pipe(fds) == 0)
>   			return;
> +	} else if (use_inet) {
> +		if (inet_socketpair(fds) == 0)
> +			return;
>   	} else {
>   		if (socketpair(AF_UNIX, SOCK_STREAM, 0, fds) == 0)
>   			return;
> @@ -364,13 +410,14 @@ static void process_options(int argc, char *argv[])
>   			{"help",	no_argument,		NULL, 'h'},
>   			{"loops",	required_argument,	NULL, 'l'},
>   			{"pipe",	no_argument,		NULL, 'p'},
> +			{"inet",	no_argument,		NULL, 'i'},
>   			{"datasize",	required_argument,	NULL, 's'},
>   			{"threads",	no_argument,		NULL, 'T'},
>   			{"processes",	no_argument,		NULL, 'P'},
>   			{NULL, 0, NULL, 0}
>   		};
>   
> -		int c = getopt_long(argc, argv, "f:Fg:hl:ps:TP",
> +		int c = getopt_long(argc, argv, "f:Fg:hl:pis:TP",
>   				    longopts, &optind);
>   		if (c == -1) {
>   			break;
> @@ -402,6 +449,9 @@ static void process_options(int argc, char *argv[])
>   		case 'p':
>   			use_pipes = 1;
>   			break;
> +		case 'i':
> +			use_inet = 1;
> +			break;
>   		case 's':
>   			if ((datasize = atoi(optarg)) <= 0) {
>   				fprintf(stderr, "%s: --datasize|-s requires an integer > 0\n", argv[0]);
> @@ -418,6 +468,11 @@ static void process_options(int argc, char *argv[])
>   			print_usage_exit(1);
>   		}
>   	}
> +
> +	if (use_pipes && use_inet) {
> +		fprintf(stderr, "%s: --pipe|-p and --inet|-i cannot be used together\n", argv[0]);
> +		print_usage_exit(1);
> +	}
>   }
>   
>   void sigcatcher(int sig) {
> 
