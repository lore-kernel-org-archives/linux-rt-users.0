Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C43C64E7B
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 07:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD8532087D
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 07:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDOIBhMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgLAHDO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 02:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgLAHDO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Dec 2020 02:03:14 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49DAC0613CF
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 23:02:33 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id d8so551722ioc.13
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 23:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=2Aq8lsft9cPMVHzniehGL6sy3eRiQ764uPwLMDVEAkk=;
        b=DDOIBhMDgTurMo/lSy8T8g70ZEYu0YLFh3KjlTc+/RTMdUlL0NNtHRjnJMck0ZG5Dk
         aUxuO54lop54yyI68fo/XETH8zDrwjSbIhw8SgLTcOgyKQ0ACvQhgIf3BzX4d+7jFlKS
         ANK36qySm2l6WTA4ajoJG84eXfP37k4fyiLAGRsvJy8xdno5Jx0PLm6cOvTtkBUjd1OY
         DwBwalBz9lKkWkuvs7zow96I3Jt1Xw21nl9rt6Ppe3R21cp5hIs5mPhZFNGD7hvPAOlT
         gIV583BaIkTVHqL5NJvJByExOBwhqj9Xa97zWIoXHahulMHinjse5yaWfWx+x6oordw1
         FRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=2Aq8lsft9cPMVHzniehGL6sy3eRiQ764uPwLMDVEAkk=;
        b=p85QCkw1DKR04v29EvBDhqawTKDDLJqPaAMnJkalhxMhlHoZnZ7KtX88X3sTcdQJaA
         h4DvmSEugIA3GxLuRt1+vTL9EX2DxsVUJ740ndRA4U/iY8JnyrRpzzDgVVzwusp04JyS
         /KkgFXeGpx4tMeOWFZeY51sqPBrqghrdBF8TGtScSMZHtXUOuBPMxpPWQzM9hx7gyaAR
         QUBYJSrNDTfoLiVYM/8vMn3xnenjc1mHpMgX0+LweRtkydoyw23/P4Mzb1ZKgqCIvTtj
         CigGHaZgtNa+qLMdCCfglr0+Np1eTvcwomtr9MVVYFe0JkSb416msrWiqlgK56MiwytJ
         g3vg==
X-Gm-Message-State: AOAM533XHjKjwQCs/eZfOaPvOJxt7mVitKw3i9+Qkbu+Ojmfs2Be7zeB
        Bwo+QhAy+k7dY3raC8WG7I4=
X-Google-Smtp-Source: ABdhPJy6HA+fHnL9ZvqYR/acXXqjoTYK3rnyiJfd8S6aoCrDaRM6X1f3L7g3K7VvDthmW4PxdzUBrA==
X-Received: by 2002:a05:6638:3006:: with SMTP id r6mr1493005jak.72.1606806153111;
        Mon, 30 Nov 2020 23:02:33 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id l78sm617497ild.30.2020.11.30.23.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 23:02:32 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 1 Dec 2020 02:02:28 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 04/12] pmqtest: Move statictic output into
 print_stat()
In-Reply-To: <20201118190642.16006-5-dwagner@suse.de>
Message-ID: <66a8325d-48b4-52ab-13fb-b50cb67d4f2@redhat.com>
References: <20201118190642.16006-1-dwagner@suse.de> <20201118190642.16006-5-dwagner@suse.de>
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
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/pmqtest/pmqtest.c | 64 ++++++++++++++++++-------------------------
>  1 file changed, 26 insertions(+), 38 deletions(-)
> 
> diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
> index a1e487b85d2c..b0a2cbede4a0 100644
> --- a/src/pmqtest/pmqtest.c
> +++ b/src/pmqtest/pmqtest.c
> @@ -64,7 +64,6 @@ struct params {
>  	char recvsyncmsg[MSG_SIZE];
>  	char recvtestmsg[MSG_SIZE];
>  	struct params *neighbor;
> -	char error[MAX_PATH * 2];
>  };
>  
>  void *pmqthread(void *param)
> @@ -192,9 +191,7 @@ void *pmqthread(void *param)
>  					write(tracing_enabled, "0", 1);
>  					close(tracing_enabled);
>  				} else
> -					snprintf(par->error, sizeof(par->error),
> -					    "Could not access %s\n",
> -					    tracing_enabled_file);
> +					fatal("Could not access %s\n", tracing_enabled_file);
>  				par->shutdown = 1;
>  				par->neighbor->shutdown = 1;
>  			}
> @@ -376,6 +373,27 @@ static void sighand(int sig)
>  	shutdown = 1;
>  }
>  
> +static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
> +		       int verbose, int quiet)
> +{
> +	int i;
> +
> +	for (i = 0; i < num_threads; i++) {
> +		printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: ID%d, P%d, CPU%d, TO %d, Cycles %d\n",
> +			i*2, receiver[i].tid, receiver[i].priority, receiver[i].cpu,
> +			receiver[i].delay.tv_nsec / 1000,
> +			i*2+1, sender[i].tid, sender[i].priority, sender[i].cpu,
> +			receiver[i].timeoutcount, sender[i].samples);
> +	}
> +	for (i = 0; i < num_threads; i++) {
> +		printf("#%d -> #%d, Min %4d, Cur %4d, Avg %4d, Max %4d\n",
> +			i*2+1, i*2,
> +			receiver[i].mindiff, (int) receiver[i].diff.tv_usec,
> +			(int) ((receiver[i].sumdiff / receiver[i].samples) + 0.5),
> +			receiver[i].maxdiff);
> +	}
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	int i;
> @@ -385,8 +403,6 @@ int main(int argc, char *argv[])
>  	sigset_t sigset;
>  	int oldsamples = INT_MAX;
>  	int oldtimeoutcount = INT_MAX;
> -	int first = 1;
> -	int errorlines = 0;
>  	struct timespec maindelay;
>  	int oflag = O_CREAT|O_RDWR;
>  	struct mq_attr mqstat;
> @@ -489,38 +505,8 @@ int main(int argc, char *argv[])
>  
>  		if (minsamples > 1 && (shutdown || newsamples > oldsamples ||
>  			newtimeoutcount > oldtimeoutcount)) {
> -
> -			if (!first)
> -				printf("\033[%dA", num_threads*2 + errorlines);
> -			first = 0;
> -
> -			for (i = 0; i < num_threads; i++) {
> -				printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: ID%d, P%d, CPU%d, TO %d, Cycles %d   \n",
> -				    i*2, receiver[i].tid, receiver[i].priority, receiver[i].cpu,
> -				    receiver[i].delay.tv_nsec / 1000,
> -				    i*2+1, sender[i].tid, sender[i].priority, sender[i].cpu,
> -				    receiver[i].timeoutcount, sender[i].samples);
> -			}
> -			for (i = 0; i < num_threads; i++) {
> -				printf("#%d -> #%d, Min %4d, Cur %4d, Avg %4d, Max %4d\n",
> -					i*2+1, i*2,
> -					receiver[i].mindiff, (int) receiver[i].diff.tv_usec,
> -					(int) ((receiver[i].sumdiff / receiver[i].samples) + 0.5),
> -					receiver[i].maxdiff);
> -				if (receiver[i].error[0] != '\0') {
> -					printf("%s", receiver[i].error);
> -					errorlines++;
> -					receiver[i].error[0] = '\0';
> -				}
> -				if (sender[i].error[0] != '\0') {
> -					printf("%s", sender[i].error);
> -					errorlines++;
> -					receiver[i].error[0] = '\0';
> -				}
> -			}
> -		} else {
> -			if (minsamples < 1)
> -				printf("Collecting ...\n\033[1A");
> +			print_stat(stdout, receiver, sender, 0, 0);
> +			printf("\033[%dA", num_threads*2);
>  		}
>  
>  		fflush(NULL);
> @@ -539,6 +525,8 @@ int main(int argc, char *argv[])
>  
>  	} while (!shutdown);
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
