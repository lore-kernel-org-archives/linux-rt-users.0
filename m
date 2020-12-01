Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB88C64E7A
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 07:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E1B6216C4
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 07:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9mMSX16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgLAHP0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 02:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgLAHPZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Dec 2020 02:15:25 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB16CC0613CF
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 23:14:39 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id j23so604680iog.6
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 23:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=N2qWjEXmjqK+oHXa2udRgeoAcHVxz9bmFyOg5tzBQZ8=;
        b=g9mMSX16WgHxyMV42whxGDVFnDHbCjYFvaomp2rN/i32edIW5pkKnpFMdF4BzAaILH
         44AU7Jd3kwyPk9k/Z07rVcTb6d6dAnPZuvp9IfhIKKQALrqV/QmftiRneCCVpG8/Wdd3
         JyIaKxwYKPHJnG0c/tomEFLT6uSSqUcpnNS2Kwv2iAu9xARgN4vPWouOiCKwYaH2B3vu
         xOXU63HJwNH4xKCpOL8D0YBXZyZR46zVRoWXMaqVpPOKfDIvaYpb7ZS/4925yVuv3iiy
         i6o8o5NR1uiPSU1SHuGRTciit91eWJpG+wZqdqnlSvmwuGHroSUF/lG8jKUs1xN09agH
         9ncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=N2qWjEXmjqK+oHXa2udRgeoAcHVxz9bmFyOg5tzBQZ8=;
        b=pgOZ+qq+QBtCxaZ9QcL0wAto9RZXuqoCvUtwMb39gv4K9+IKPPt8QoRw9q5YV35cmD
         rVq+M3+tiX9hbhyATcXjDXd0ov6B8F4WSUMHVukLICOYiqJm3JE4NTgah/LY0V242ni9
         WXNTVqU8T8alelUGNipM5PFWUorXJ2UOAnVZV+xjnMXtvPyFTgfGd3QN3SLLuI3O+zsO
         TDg9wJ4sMCzE39pu0lLSbDnYefY3+0TgV2xvNr5gemoVBF58+b30iGlqNvUlVzyqTwiT
         h5OF2XBEoDu/1pRpWWWGiLH5job6uZYIoilLp1QOxSzaLZFUz0W5dusQqfl/RSza3YMx
         +frA==
X-Gm-Message-State: AOAM530vx8l/rOO2PBgspeYcJVEV2p/1D/vmlm/Fdk4WDY2u+lr3YzpP
        WqHzAoeZhxeDQ+1cEQ9x+Ts=
X-Google-Smtp-Source: ABdhPJyEL3jKwcVLpwmVqVfoPj1tjwpqRHF3bV5wslVI5UT4OBKM/dr5CjiTQHRRmJYHpM9fNBEHDw==
X-Received: by 2002:a02:9708:: with SMTP id x8mr1507191jai.43.1606806879239;
        Mon, 30 Nov 2020 23:14:39 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id w14sm623620ilu.54.2020.11.30.23.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 23:14:38 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 1 Dec 2020 02:14:34 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 10/12] sigwaittest: Move statictic output into
 print_stat()
In-Reply-To: <20201118190642.16006-11-dwagner@suse.de>
Message-ID: <66f433e-e75e-e4a5-cabc-f4d94d9f257a@redhat.com>
References: <20201118190642.16006-1-dwagner@suse.de> <20201118190642.16006-11-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 18 Nov 2020, Daniel Wagner wrote:

> Prepare the code to introduce the quiet command line option by moving
> the statistic output code into print_stat(). We follow here the
> pattern from cyclictest.
> 
> While at it replace the rather sophisticated error printing code with
> a fatal(). Just fail if something is not working.
> 
> Also reorder the include headers so that project local headers follow
> the system include headers.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/sigwaittest/sigwaittest.c | 97 ++++++++++++++++-------------------
>  1 file changed, 43 insertions(+), 54 deletions(-)
> 
> diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
> index 8a5d73b14fc2..d3be2fd9508c 100644
> --- a/src/sigwaittest/sigwaittest.c
> +++ b/src/sigwaittest/sigwaittest.c
> @@ -38,10 +38,11 @@
>  #include <sys/time.h>
>  #include <linux/unistd.h>
>  #include <utmpx.h>
> +#include <pthread.h>
> +
>  #include "rt-utils.h"
>  #include "rt-get_cpu.h"
> -
> -#include <pthread.h>
> +#include "error.h"
>  
>  enum {
>  	AFFINITY_UNSPECIFIED,
> @@ -69,7 +70,6 @@ struct params {
>  	struct timeval unblocked, received, diff;
>  	pthread_t threadid;
>  	struct params *neighbor;
> -	char error[MAX_PATH * 2];
>  };
>  
>  static int mustfork;
> @@ -184,9 +184,8 @@ void *semathread(void *param)
>  					write(tracing_enabled, "0", 1);
>  					close(tracing_enabled);
>  				} else
> -					snprintf(par->error, sizeof(par->error),
> -					    "Could not access %s\n",
> -					    tracing_enabled_file);
> +					fatal("Could not access %s\n",
> +					      tracing_enabled_file);
>  				par->shutdown = 1;
>  				neighbor->shutdown = 1;
>  			}
> @@ -348,6 +347,39 @@ static void sighand(int sig)
>  	mustshutdown = 1;
>  }
>  
> +static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
> +		       int verbose, int quiet)
> +{
> +	int i;
> +
> +	for (i = 0; i < num_threads; i++) {
> +		int receiver_pid, sender_pid;
> +		if (mustfork) {
> +			receiver_pid = receiver[i].pid;
> +			sender_pid = sender[i].pid;
> +		} else {
> +			receiver_pid = receiver[i].tid;
> +			sender_pid = sender[i].tid;
> +		}
> +		printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: ID%d, P%d, CPU%d, Cycles %d\n",
> +			i*2, receiver_pid, receiver[i].priority,
> +			receiver[i].cpu, receiver[i].delay.tv_nsec /
> +			1000, i*2+1, sender_pid, sender[i].priority,
> +			sender[i].cpu, sender[i].samples);
> +	}
> +
> +	for (i = 0; i < num_threads; i++) {
> +		if (receiver[i].mindiff == -1)
> +			printf("#%d -> #%d (not yet ready)\n", i*2+1, i*2);
> +		else
> +			printf("#%d -> #%d, Min %4d, Cur %4d, Avg %4d, Max %4d\n",
> +				i*2+1, i*2,	receiver[i].mindiff,
> +				(int) receiver[i].diff.tv_usec,
> +				(int) ((receiver[i].sumdiff /
> +					receiver[i].samples) + 0.5),
> +				receiver[i].maxdiff);
> +	}
> +}
>  
>  int main(int argc, char *argv[])
>  {
> @@ -540,56 +572,14 @@ int main(int argc, char *argv[])
>  	}
>  
>  	while (!mustshutdown) {
> -		int printed;
> -		int errorlines = 0;
> -
>  		for (i = 0; i < num_threads; i++)
>  			mustshutdown |= receiver[i].shutdown |
>  			    sender[i].shutdown;
>  
>  		if (receiver[0].samples > oldsamples || mustshutdown) {
> -			for (i = 0; i < num_threads; i++) {
> -				int receiver_pid, sender_pid;
> -				if (mustfork) {
> -					receiver_pid = receiver[i].pid;
> -					sender_pid = sender[i].pid;
> -				} else {
> -					receiver_pid = receiver[i].tid;
> -					sender_pid = sender[i].tid;
> -				}
> -				printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: "
> -				    "ID%d, P%d, CPU%d, Cycles %d\n",
> -				    i*2, receiver_pid, receiver[i].priority,
> -				    receiver[i].cpu, receiver[i].delay.tv_nsec /
> -				    1000, i*2+1, sender_pid, sender[i].priority,
> -				    sender[i].cpu, sender[i].samples);
> -			}
> -			for (i = 0; i < num_threads; i++) {
> -				if (receiver[i].mindiff == -1)
> -					printf("#%d -> #%d (not yet ready)\n",
> -					    i*2+1, i*2);
> -				else
> -					printf("#%d -> #%d, Min %4d, Cur %4d, "
> -					    "Avg %4d, Max %4d\n",
> -					    i*2+1, i*2,	receiver[i].mindiff,
> -					    (int) receiver[i].diff.tv_usec,
> -					    (int) ((receiver[i].sumdiff /
> -					    receiver[i].samples) + 0.5),
> -					    receiver[i].maxdiff);
> -				if (receiver[i].error[0] != '\0') {
> -					printf("%s", receiver[i].error);
> -					receiver[i].error[0] = '\0';
> -					errorlines++;
> -				}
> -				if (sender[i].error[0] != '\0') {
> -					printf("%s", sender[i].error);
> -					sender[i].error[0] = '\0';
> -					errorlines++;
> -				}
> -			}
> -			printed = 1;
> -		} else
> -			printed = 0;
> +			print_stat(stdout, receiver, sender, 0, 0);
> +			printf("\033[%dA", num_threads*2);
> +		}
>  
>  		sigemptyset(&sigset);
>  		sigaddset(&sigset, SIGTERM);
> @@ -601,11 +591,10 @@ int main(int argc, char *argv[])
>  
>  		sigemptyset(&sigset);
>  		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
> -
> -		if (printed && !mustshutdown)
> -			printf("\033[%dA", num_threads*2 + errorlines);
>  	}
>  
> +	printf("\033[%dB", num_threads*2 + 2);
> +
>  	for (i = 0; i < num_threads; i++) {
>  		receiver[i].shutdown = 1;
>  		sender[i].shutdown = 1;
> -- 
> 2.29.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
