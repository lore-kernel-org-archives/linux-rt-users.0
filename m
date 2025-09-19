Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AD0205AB6
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306582; cv=none; b=GXpYjjJr/HM6FJY22TaPJSUCYvX/PqZM9r5qkBSx54A0skFzwZOhY9fVznEn2VyAp2t+3QA8ZkKZUv5GdiRAmnwrnaB1vbIL4lrgYaH2rl3DKKOYrMiobP744lnnKDdkB1yY9Jimw6w9pq0Mu50eDfD6ZHKwAUVd+VZI7idJnzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306582; c=relaxed/simple;
	bh=vM02GwJT5YuG8xiJ+ryVPMWeBsHKbWq1aeah4cxiGRY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Nm/VNWf8j5pX1H9aLSbtUKkXxvFXLlZzn28jNlahY1YlVTIB33Bwi8U90zUrq18dgGxAmKsFqVrDldL93yjXAIXB7G8YuRRGEHRczNlK9G91DVnAePS7BNUhoe+r20yHrmhk0AmD/n1/eYUYtRnfMi7BfkN19RPZp11CAzjHOpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJOMANkn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJOMANkn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758306579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B70Dgt1DkjPrMebTKRuqidFnmK6dBAQdLWRJ8/rYknU=;
	b=PJOMANknChW0HRbttc29hZyURscop0lVdVIGQaGRztil710jRorxFZHFZgd1JSRamh5j8I
	AUwMTEbLG3lSAS1CCNJwipUb+K/nmLpAcTQyzJqxDzTb2lsmNSrnFNctUhsQedcHkPNuXn
	aRgpyrP2hEmmp5yfOP2zi7/55cFudUo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-H1PyKQ0hNxG70t61QzrWfg-1; Fri, 19 Sep 2025 14:29:38 -0400
X-MC-Unique: H1PyKQ0hNxG70t61QzrWfg-1
X-Mimecast-MFC-AGG-ID: H1PyKQ0hNxG70t61QzrWfg_1758306577
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8217df6d44cso384914285a.2
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 11:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306577; x=1758911377;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B70Dgt1DkjPrMebTKRuqidFnmK6dBAQdLWRJ8/rYknU=;
        b=nEQEe5wzzefgRZS/NpZgUtBdAc8PjjPPsvOQwV2HRjmhShh2f5fde72AMi5RTIi48j
         kturfye1U3Q4mWIXWlDbvgwB6/8dP8wkzNzDhekhh1gbKYAQqm6T6Lyp+Tpkq2hvjiHh
         Ly+KOGkoCKxeI6rgxWo6Mkzok3UVsaqM7O4ZJ5ExNUEpxBUNV1SmHJyKdpwcTAhbjApC
         FGnWGxx8PQOn2b2RYYhJSHqRc/0u/w5jLXt+q+5SUZBjyUqufjED5/Yq6yTaK2uu22CK
         MdbBPzG6qTJ5gxrngWl1w8Z4/I+a1SDApWCchc9MeHcYgZ8sXH1SBN7SsexUFKme17aG
         ePEw==
X-Gm-Message-State: AOJu0YwsuMKjvPawOh8vK/nhnIWSlVyIoVMT0o/cpHcBFekV/OkHlI+K
	E8PT5Os95l2FATos2eeT9JYRgOTs/mBdVtJnIIYI23SZgOLvsu7h705Dr9OVjWkQSQQ+EQ2w0ug
	dyo4d46Ip75xfO+JlAZVPf9AXGEHjYfsOqqWYG2+5E62vKVxCJHnLBQWy1htfwH81YdUO
X-Gm-Gg: ASbGncu1m0tTpiK2PassKeUYvs7ZB8W2FQ+IpRs4BbTJm2OGT/8XoNjSAQVOzkG1kKw
	KwJX08n0jmUeqYMAIr2LtXSe9E6bI0MSzo9ISNaomlAtk5dkdAg4kOpapMyg5jwNrNrPCvkAHhP
	bE2+Z91aRIsYDg9tgsuX1vCg4xYHvP3PlfhciSfkbCPBh73amlB3mZkX4mieV7f7GUsfDMUQN0q
	LewgsIhD3HbQRZ3pnnnmYMiM6xNk4T4Y4poMknAd+jHcFz2dndjafyJr6whGeNLzg+DosOLH3AU
	rP6nbuSJERF9bP3Ajd4V5m/CChaZ8ghT7ldWKuBreT4ZTUo6yRpqkTWrs/nuJV81Y+f6VlhR2Wn
	dcEpZxdaPBlVF
X-Received: by 2002:a05:620a:1a19:b0:80c:a9c2:d0c6 with SMTP id af79cd13be357-83bae440ea6mr411824385a.84.1758306577377;
        Fri, 19 Sep 2025 11:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPuxdL81g6hywgekTzjD0sEpu64xQTr0WFwPjWcX8mkkdXevOrcWjcc03ZCj2cEEckMb/ABQ==
X-Received: by 2002:a05:620a:1a19:b0:80c:a9c2:d0c6 with SMTP id af79cd13be357-83bae440ea6mr411819085a.84.1758306576311;
        Fri, 19 Sep 2025 11:29:36 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0604w-grc-05-70-53-55-167.dsl.bell.ca. [70.53.55.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836344940basm377244785a.69.2025.09.19.11.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:29:35 -0700 (PDT)
Date: Fri, 19 Sep 2025 14:29:34 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>, 
    Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 03/10] rt-utils: Rename get_debugfileprefix() and let it
 look for tracefs
In-Reply-To: <20250903111717.1391196-4-bigeasy@linutronix.de>
Message-ID: <72f57987-7212-e2c4-dc76-1aa2ed530a91@redhat.com>
References: <20250903111717.1391196-1-bigeasy@linutronix.de> <20250903111717.1391196-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 3 Sep 2025, Sebastian Andrzej Siewior wrote:

> get_debugfileprefix() used to look for debugfs and added the tracing
> suffix to it. In the early days it it was not always monted at the same
> destination. Later, that function got a fastpath to look directly at
> "/sys/kernel/debug/tracing". This avoids parsing the mounted filesystem
> and looking for debugfs.
> 
> Since about v4.1 (released over 10 years ago) that tracing folder moved
> out debugfs and got its own filesystem (tracefs) and is mounted at
> /sys/kernel/tracing. Since then that /sys/kernel/debug/tracing folder is
> just an automount/ alias to /sys/kernel/tracing.
> Since v6.17 that automount can be disabled and is schedulued for
> removal.
> Strart using tracefs directly instead that alias:
> - Replace that "debug" prefix with tracefs since debugfs is no longer
>   the thing that is used
> - Look directy for /sys/kernel/tracing
> - If it is not there, look for tracefs filesystem in case it is mounted
>   at an unusual spot.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  src/backfire/sendme.c         |  2 +-
>  src/include/rt-utils.h        |  2 +-
>  src/lib/rt-utils.c            | 51 ++++++++++++-----------------------
>  src/pmqtest/pmqtest.c         |  2 +-
>  src/ptsematest/ptsematest.c   |  2 +-
>  src/sigwaittest/sigwaittest.c |  2 +-
>  src/svsematest/svsematest.c   |  2 +-
>  7 files changed, 23 insertions(+), 40 deletions(-)
> 
> diff --git a/src/backfire/sendme.c b/src/backfire/sendme.c
> index da10397846f79..1c3e8b0c4c1b9 100644
> --- a/src/backfire/sendme.c
> +++ b/src/backfire/sendme.c
> @@ -45,7 +45,7 @@ static int interval = 1000;
>  static int kernvar(int mode, const char *name, char *value, size_t sizeofvalue)
>  {
>  	char filename[128];
> -	char *fileprefix = get_debugfileprefix();
> +	char *fileprefix = get_tracefs_prefix();
>  	int retval = 1;
>  	int path;
>  	size_t len_prefix = strlen(fileprefix), len_name = strlen(name);
> diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
> index 95964f70a6310..569023c5d3051 100644
> --- a/src/include/rt-utils.h
> +++ b/src/include/rt-utils.h
> @@ -11,7 +11,7 @@
>  #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>  
>  int check_privs(void);
> -char *get_debugfileprefix(void);
> +char *get_tracefs_prefix(void);
>  int get_tracers(char ***);
>  int valid_tracer(char *);
>  
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index 7e96950ef9887..696bca2657d18 100644
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -32,7 +32,7 @@
>  #define  MAX_COMMAND_LINE 4096
>  #define  MAX_TS_SIZE 64
>  
> -static char debugfileprefix[MAX_PATH];
> +static char tracefs_prefix[MAX_PATH];
>  static char *fileprefix;
>  static int trace_fd = -1;
>  static int tracemark_fd = -1;
> @@ -41,28 +41,21 @@ static char test_cmdline[MAX_COMMAND_LINE];
>  static char ts_start[MAX_TS_SIZE];
>  
>  /*
> - * Finds the tracing directory in a mounted debugfs
> + * Finds the tracing directory
>   */
> -char *get_debugfileprefix(void)
> +char *get_tracefs_prefix(void)
>  {
>  	char type[100];
>  	FILE *fp;
> -	int size;
>  	int found = 0;
>  	struct stat s;
>  
> -	if (debugfileprefix[0] != '\0')
> +	if (tracefs_prefix[0] != '\0')
>  		goto out;
>  
>  	/* look in the "standard" mount point first */
> -	if ((stat("/sys/kernel/debug/tracing", &s) == 0) && S_ISDIR(s.st_mode)) {
> -		strcpy(debugfileprefix, "/sys/kernel/debug/tracing/");
> -		goto out;
> -	}
> -
> -	/* now look in the "other standard" place */
> -	if ((stat("/debug/tracing", &s) == 0) && S_ISDIR(s.st_mode)) {
> -		strcpy(debugfileprefix, "/debug/tracing/");
> +	if ((stat("/sys/kernel/tracing", &s) == 0) && S_ISDIR(s.st_mode)) {
> +		strcpy(tracefs_prefix, "/sys/kernel/tracing/");
>  		goto out;
>  	}
>  
> @@ -73,14 +66,8 @@ char *get_debugfileprefix(void)
>  	while (fscanf(fp, "%*s %"
>  		      STR(MAX_PATH)
>  		      "s %99s %*s %*d %*d\n",
> -		      debugfileprefix, type) == 2) {
> -		if (strcmp(type, "debugfs") == 0) {
> -			found = 1;
> -			break;
> -		}
> -		/* stupid check for systemd-style autofs mount */
> -		if ((strcmp(debugfileprefix, "/sys/kernel/debug") == 0) &&
> -		    (strcmp(type, "systemd") == 0)) {
> +		      tracefs_prefix, type) == 2) {
> +		if (strcmp(type, "tracefs") == 0) {
>  			found = 1;
>  			break;
>  		}
> @@ -88,15 +75,11 @@ char *get_debugfileprefix(void)
>  	fclose(fp);
>  
>  	if (!found) {
> -		debugfileprefix[0] = '\0';
> +		tracefs_prefix[0] = '\0';
>  		goto out;
>  	}
> -
> -	size = sizeof(debugfileprefix) - strlen(debugfileprefix);
> -	strncat(debugfileprefix, "/tracing/", size);
> -
>  out:
> -	return debugfileprefix;
> +	return tracefs_prefix;
>  }
>  
>  static char **tracer_list;
> @@ -113,7 +96,7 @@ int get_tracers(char ***list)
>  	int ret;
>  	FILE *fp;
>  	char buffer[CHUNKSZ];
> -	char *prefix = get_debugfileprefix();
> +	char *prefix = get_tracefs_prefix();
>  	char *tmpbuf = NULL;
>  	char *ptr;
>  	int tmpsz = 0;
> @@ -193,7 +176,7 @@ int valid_tracer(char *tracername)
>   */
>  int setevent(char *event, char *val)
>  {
> -	char *prefix = get_debugfileprefix();
> +	char *prefix = get_tracefs_prefix();
>  	char buffer[MAX_PATH];
>  	int fd;
>  	int ret;
> @@ -417,19 +400,19 @@ static void close_tracemark_fd(void)
>  static int trace_file_exists(char *name)
>  {
>  	struct stat sbuf;
> -	char *tracing_prefix = get_debugfileprefix();
> +	char *tracing_prefix = get_tracefs_prefix();
>  	char path[MAX_PATH];
>  	strcat(strcpy(path, tracing_prefix), name);
>  	return stat(path, &sbuf) ? 0 : 1;
>  }
>  
> -static void debugfs_prepare(void)
> +static void tracefs_prepare(void)
>  {
> -	fileprefix = get_debugfileprefix();
> +	fileprefix = get_tracefs_prefix();
>  	if (!trace_file_exists("tracing_enabled") &&
>  	    !trace_file_exists("tracing_on"))
>  		warn("tracing_enabled or tracing_on not found\n"
> -		     "debug fs not mounted");
> +		     "tracefs not found");
>  }
>  
>  void tracemark(char *fmt, ...)
> @@ -455,7 +438,7 @@ void tracemark(char *fmt, ...)
>  
>  void enable_trace_mark(void)
>  {
> -	debugfs_prepare();
> +	tracefs_prepare();
>  	open_tracemark_fd();
>  }
>  
> diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
> index 04e36a1ad9795..a25b5cd2c24a1 100644
> --- a/src/pmqtest/pmqtest.c
> +++ b/src/pmqtest/pmqtest.c
> @@ -184,7 +184,7 @@ void *pmqthread(void *param)
>  			if (par->tracelimit && par->maxdiff > par->tracelimit) {
>  				char tracing_enabled_file[MAX_PATH];
>  
> -				strcpy(tracing_enabled_file, get_debugfileprefix());
> +				strcpy(tracing_enabled_file, get_tracefs_prefix());
>  				strcat(tracing_enabled_file, "tracing_on");
>  				int tracing_enabled =
>  				    open(tracing_enabled_file, O_WRONLY);
> diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
> index d21166946f6ac..00871d08df3a8 100644
> --- a/src/ptsematest/ptsematest.c
> +++ b/src/ptsematest/ptsematest.c
> @@ -107,7 +107,7 @@ void *semathread(void *param)
>  			if (par->tracelimit && par->maxdiff > par->tracelimit) {
>  				char tracing_enabled_file[MAX_PATH];
>  
> -				strcpy(tracing_enabled_file, get_debugfileprefix());
> +				strcpy(tracing_enabled_file, get_tracefs_prefix());
>  				strcat(tracing_enabled_file, "tracing_on");
>  				int tracing_enabled =
>  				    open(tracing_enabled_file, O_WRONLY);
> diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
> index 026cc81510157..e55f7fd2411f6 100644
> --- a/src/sigwaittest/sigwaittest.c
> +++ b/src/sigwaittest/sigwaittest.c
> @@ -163,7 +163,7 @@ void *semathread(void *param)
>  			if (par->tracelimit && par->maxdiff > par->tracelimit) {
>  				char tracing_enabled_file[MAX_PATH];
>  
> -				strcpy(tracing_enabled_file, get_debugfileprefix());
> +				strcpy(tracing_enabled_file, get_tracefs_prefix());
>  				strcat(tracing_enabled_file, "tracing_on");
>  				int tracing_enabled =
>  				    open(tracing_enabled_file, O_WRONLY);
> diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
> index f3cddf8545757..093f3c473f0a1 100644
> --- a/src/svsematest/svsematest.c
> +++ b/src/svsematest/svsematest.c
> @@ -170,7 +170,7 @@ void *semathread(void *param)
>  			if (par->tracelimit && par->maxdiff > par->tracelimit) {
>  				char tracing_enabled_file[MAX_PATH];
>  
> -				strcpy(tracing_enabled_file, get_debugfileprefix());
> +				strcpy(tracing_enabled_file, get_tracefs_prefix());
>  				strcat(tracing_enabled_file, "tracing_on");
>  				int tracing_enabled =
>  				    open(tracing_enabled_file, O_WRONLY);
> -- 
> 2.51.0
> 
> 
> 

   - a few quick spelling and grammar fixes
    Signed-off-by: John Kacur <jkacur@redhat.com>

