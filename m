Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DB0257AEC
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307280; cv=none; b=NHIB9/cn3QuvgD8UmEqSVKeImaSe5OHcm6UImJzIy1RZfwIB4V4Fmj15stsQfkEmPVabd7J6cnfFPzWmLtuoMT9s8/h9AT96TajnkRVAdScLQGxBe5sHDAlYpQ5LlFtGTEH2W8lBXoEGSSDD1weYgoxDVAOpYGt7yrPt/uHba0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307280; c=relaxed/simple;
	bh=otUl2RWF/5NiEOfr+vHX0DADFDNrxuZrZC/YhlvmnZs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=e6R4SAbL31rORwcGAmEgNi+mSbPJo9wrK0r01qdft5SjmGNHnODb5bbmDkogZJzPcIWpvZkig/kz86b4AUDwdBAxuo4djaO3xGo866bFejf8U+GkvJwPZNY7+SLDaACGQqm+AWJUi0gl8QL9frcum9zOZkUvSN27lpaV+/v/6vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=If2qqC/n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="If2qqC/n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758307277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=foMY9vIe1L+o0sPptkT4c19D9Hjgnpf417BNexvq0Lc=;
	b=If2qqC/nEwNh8dJcy3nxinz1xyCqk/kCLjXp1jtDi6EFJrbhD6xNxJ8jy+AQMnzz9eASAG
	KAvfq8iVIG7dIOX0VdthjKi24WKBrtGjvq5pUqktxF4Y3qJLXV8PFM3lx/b5pKCHCzQQiW
	izUacuEHkCjj4zjmVdbt8gkBUkeEuxI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-o48SFDkoOKKHdvGoQ1l-9w-1; Fri, 19 Sep 2025 14:41:16 -0400
X-MC-Unique: o48SFDkoOKKHdvGoQ1l-9w-1
X-Mimecast-MFC-AGG-ID: o48SFDkoOKKHdvGoQ1l-9w_1758307275
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8217df6d44cso386396385a.2
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 11:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758307275; x=1758912075;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=foMY9vIe1L+o0sPptkT4c19D9Hjgnpf417BNexvq0Lc=;
        b=N/cAE5g1DmoumKv3DlqeGMC6KP94plygjKtrBlKO0TWkVKAeR3sCXJzqoQtJt+Tyb0
         E9HxPc6j06y0Adoo6YI62qluE+X2Y0GC0J4788YSVhVWNFHQGejgwW62cTQ98CoCY0Uq
         OjlH040N0iLTCbgjb1NpNe9Yt7AeKlZ9kKOT969bx3k1iDbaqiYhFJEAaTWjazo6IYb9
         KI+tk4kpXvK8g94gOob0K9POSTg+OfZatUDClcXQeqHa7ffF084v1CS9EFevsLixe4cJ
         9e8oMJi/5bMhIEajOgkQ6bUElBcwP0Qdne2s21qxcqthnWPUV4fjlxnHD6zEAJHskd05
         YMew==
X-Gm-Message-State: AOJu0YwF/GW/XklbieyXjN2rHlkC/BOZirowfy4a1buheFKtW2dWeL95
	sHO+zz4K00H8G5FLhix6n+nFW+Lhb1JgnO7Xg9Cth9fsLmcAo8/ABL5z8tR8/VV2MT0hkLneucw
	6Q6ZRmHHBSyZ+w6IoNY/L//nAzgFgCO0n9tforI5ZQ423WKXvYY0WVpMSbypD7tA/l6pUCe+aPY
	f9+BU=
X-Gm-Gg: ASbGncuFff9my7f+Zh0qPMG2qRVOL5VYOa7DXM6PvwN5ASiUfI9J/11ZwTtUp7ZWiyz
	M2X1G55I/PXChY24PGBRNMTymcAMq406Eb/JiBZ1BKpcPrYy1vamClB6cN4d6gcaVC3NZ241Xl1
	bitl3LDtuf70eN9yMx++KyZq9NhNVGXF101iFxrDMRNwtjPM8UnfnMJZvtnooHM+0Mbsv3mKc+Y
	Kco1xUsvNDyDViHAVhWEKtUvZvUto1KF2J6Gk799Z8rUyyop7q/cnaOmhrMkoHaqtADw/BSyE4W
	+B3MBx9ZPmXTbtdOL4tTGMgfK4bdorEUFHNNKGd0Y1DWNeSA8x6vnlxsyUZtIZa2ZeglSqmwajh
	gFld9BHSVzTE1
X-Received: by 2002:a05:620a:6cc5:b0:827:1a76:e910 with SMTP id af79cd13be357-83ba589a4d6mr548991285a.38.1758307275173;
        Fri, 19 Sep 2025 11:41:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuNE87xIAyg47es+sLn5IUrklq5e+w47NZrCTIRQW1Si3FjukEnijz1JSiLJmbgExpXYTPJQ==
X-Received: by 2002:a05:620a:6cc5:b0:827:1a76:e910 with SMTP id af79cd13be357-83ba589a4d6mr548988585a.38.1758307274784;
        Fri, 19 Sep 2025 11:41:14 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0604w-grc-05-70-53-55-167.dsl.bell.ca. [70.53.55.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83630481f38sm375626585a.39.2025.09.19.11.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:41:14 -0700 (PDT)
Date: Fri, 19 Sep 2025 14:41:13 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>, 
    Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 05/10] rt-utils: Remove fileprefix.
In-Reply-To: <20250903111717.1391196-6-bigeasy@linutronix.de>
Message-ID: <73fef5ee-c88b-6ce1-0460-5d448e17bf10@redhat.com>
References: <20250903111717.1391196-1-bigeasy@linutronix.de> <20250903111717.1391196-6-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 3 Sep 2025, Sebastian Andrzej Siewior wrote:

> Remove fileprefix and use tracefs_prefix directly.
> There is no need for having both.
> Since sprintf() will complain that output buffer has the same size as
> the first input buffer so it could write more bytes use snprintf() and
> catch that possible overflow.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  src/lib/rt-utils.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index 696bca2657d18..0e6e6056a4392 100644
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -33,7 +33,6 @@
>  #define  MAX_TS_SIZE 64
>  
>  static char tracefs_prefix[MAX_PATH];
> -static char *fileprefix;
>  static int trace_fd = -1;
>  static int tracemark_fd = -1;
>  static __thread char tracebuf[TRACEBUFSIZ];
> @@ -363,12 +362,17 @@ int parse_mem_string(char *str, uint64_t *val)
>  static void open_tracemark_fd(void)
>  {
>  	char path[MAX_PATH];
> +	int n;
>  
>  	/*
>  	 * open the tracemark file if it's not already open
>  	 */
>  	if (tracemark_fd < 0) {
> -		sprintf(path, "%s/%s", fileprefix, "trace_marker");
> +		n = snprintf(path, sizeof(path), "%s/%s", tracefs_prefix, "trace_marker");
> +		if (n >= sizeof(path)) {
> +			warn("tracefs path too long\n");
> +			return;
> +		}
>  		tracemark_fd = open(path, O_WRONLY);
>  		if (tracemark_fd < 0) {
>  			warn("unable to open trace_marker file: %s\n", path);
> @@ -382,7 +386,11 @@ static void open_tracemark_fd(void)
>  	 * if we hit a breaktrace threshold
>  	 */
>  	if (trace_fd < 0) {
> -		sprintf(path, "%s/%s", fileprefix, "tracing_on");
> +		n = snprintf(path, sizeof(path), "%s/%s", tracefs_prefix, "tracing_on");
> +		if (n >= sizeof(path)) {
> +			warn("tracefs path too long\n");
> +			return;
> +		}
>  		if ((trace_fd = open(path, O_WRONLY)) < 0)
>  			warn("unable to open tracing_on file: %s\n", path);
>  	}
> @@ -408,7 +416,7 @@ static int trace_file_exists(char *name)
>  
>  static void tracefs_prepare(void)
>  {
> -	fileprefix = get_tracefs_prefix();
> +	get_tracefs_prefix();
>  	if (!trace_file_exists("tracing_enabled") &&
>  	    !trace_file_exists("tracing_on"))
>  		warn("tracing_enabled or tracing_on not found\n"
> -- 
> 2.51.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

