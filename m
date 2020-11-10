Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0136BC388F7
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 20:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94BA320781
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 20:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dt9Qn6i6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgKJUHW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Nov 2020 15:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgKJUHV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Nov 2020 15:07:21 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43513C0613D1
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2020 12:07:21 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id j31so9522750qtb.8
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2020 12:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=cGOPu7+4kxpfylNmdQKBOqQRlmH43GluFafWEvtTOrw=;
        b=dt9Qn6i6uAZyPEbJTjiyNSSh69iiprAa4jlpRZFjq10hAzOutBdr3C3gxxrzSyTUDI
         ncfcUDRhXQXJVPN6x4HsWwVwSKyCGMCXBR9TYto+I6x4jaWBgltJJ7vii1nLuRrawLtn
         2binrDn8DYIGGvAbM+mJyDkoztwbChJB3jseojGZou8wyB8C7RmNfddTmWaRVdJHPMX0
         3muUQPTafWTk9CzxfDpI/T/zlkJk0hWZs9SmHMyh6G220a+zy4RCMrv8It2Y1Y/oX0vn
         yfrBYJB/5hh5Sv8QxRwWodmrCH9HdmwyLdZIcBSL25v5A1DEozf9lMmXO6k9tIRNZsFI
         RMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=cGOPu7+4kxpfylNmdQKBOqQRlmH43GluFafWEvtTOrw=;
        b=ArMTPuUoJNk/DeQWMvOSzh6XslLMdo8JtSCN/VujR9GKwDZ+I3ADn4IlCC3jaP7bMd
         /aPr3P3Alhv2Tvl27UbyYppP16fqXkvEYLairTRbwuv4lOaGPRcsTct2UY4oTK+pnlDH
         VDeA5jg+3meAHImiaL8Dy/2JueaY8pVQOZ3vf8YxwNQkG8trDsngabD/7K4uPDHx8cOv
         c0er5OiqiGrf8wqOH+cXMmit6R7epliStCSkUE1/gTeIXyXN1YAAoEBjudvswcsAvc9u
         7sM5WqIywwAHhDmCCKrIH9NpBRL2Uf+pEZ7OIEK501Q5Or70WDeMNvcjsnij4Fe7HFeI
         GD9A==
X-Gm-Message-State: AOAM531QWPRNSc5sEG8X04d6wc+y53GN8TUbDUqYKf7aLgYFdGneqYUK
        a5u7XM++7Z/NLgH2Cb5yN0I=
X-Google-Smtp-Source: ABdhPJwjE2MyywKpImvgeGICP1BZJRl6it83JlU15AgzDyQsIzHa/GvwPJOVDDTkkJm3fTlgUMW1Mw==
X-Received: by 2002:a05:622a:291:: with SMTP id z17mr19859558qtw.180.1605038840543;
        Tue, 10 Nov 2020 12:07:20 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id k17sm6176144qkj.51.2020.11.10.12.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 12:07:20 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 10 Nov 2020 15:07:19 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH 2/5] signaltest: Remove drunk code
In-Reply-To: <20201110180036.859080-3-bigeasy@linutronix.de>
Message-ID: <66cc4498-e7d0-4e33-9efd-8f60c1d13edb@redhat.com>
References: <20201110180036.859080-1-bigeasy@linutronix.de> <20201110180036.859080-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 10 Nov 2020, Sebastian Andrzej Siewior wrote:

> `oldtrace' is set for kernels prior 2.6.18. Remove "support" for them.
> 
> The alternative code (for new kernels) issues
> 	prctl(0, [01]);
> 
> which is not valid the kernel returns an error. I have no idea what its
> purpose is, remove it.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  src/signaltest/signaltest.c | 29 -----------------------------
>  1 file changed, 29 deletions(-)
> 
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index 1cc3236a8f377..aceb714d3e9d3 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -62,7 +62,6 @@ struct thread_stat {
>  
>  static int shutdown;
>  static int tracelimit;
> -static int oldtrace;
>  
>  
>  /*
> @@ -105,13 +104,6 @@ void *signalthread(void *param)
>  
>  	stat->threadstarted++;
>  
> -	if (tracelimit) {
> -		if (oldtrace)
> -			gettimeofday(0, (struct timezone *)1);
> -		else
> -			prctl(0, 1);
> -	}
> -
>  	clock_gettime(CLOCK_MONOTONIC, &before);
>  
>  	while (!shutdown) {
> @@ -152,10 +144,6 @@ void *signalthread(void *param)
>  
>  		if (!stopped && tracelimit && (diff > tracelimit)) {
>  			stopped++;
> -			if (oldtrace)
> -				gettimeofday(0, 0);
> -			else
> -				prctl(0, 0);
>  			shutdown++;
>  		}
>  		stat->act = diff;
> @@ -260,21 +248,6 @@ static void process_options(int argc, char *argv[])
>  		display_help(error);
>  }
>  
> -static void check_kernel(void)
> -{
> -	size_t len;
> -	char ver[256];
> -	int fd, maj, min, sub;
> -
> -	fd = open("/proc/version", O_RDONLY, 0666);
> -	len = read(fd, ver, 255);
> -	close(fd);
> -	ver[len-1] = 0x0;
> -	sscanf(ver, "Linux version %d.%d.%d", &maj, &min, &sub);
> -	if (maj == 2 && min == 6 && sub < 18)
> -		oldtrace = 1;
> -}
> -
>  static void sighand(int sig)
>  {
>  	shutdown = 1;
> @@ -323,8 +296,6 @@ int main(int argc, char **argv)
>  			goto out;
>  		}
>  
> -	check_kernel();
> -
>  	sigemptyset(&sigset);
>  	sigaddset(&sigset, signum);
>  	sigprocmask(SIG_BLOCK, &sigset, NULL);
> -- 
> 2.29.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
