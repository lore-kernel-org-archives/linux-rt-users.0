Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D334A3E
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306034; cv=none; b=UjZuLyng9YyqGC6HeyAnx4zW46/rvuGF+vT+XUUUx9S/WEtmLCWrGliVgElF/bGGwTzg87tOcJmFqrCP8o5nly9WkOPQy+8vrmGzyWRpdHpsXsuqHQDInQ96AcNViNir4E3VxZIm5QqMDUaPPPEyYuiKAsy2PyBgFKW2JVvF548=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306034; c=relaxed/simple;
	bh=NSiePzbXiMqlvB0pjR+yuv35MrNkfWKV+OoS68hYsRg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tFld7SiXjgjCmssXpMOg1BMz0RKtYEhHnaLDN2IRfbYbpaN9uRTyawYBJMawArJ09BE86+k0MLvI3K4J5JPA/MBuPRpUEMiGznqg+tH0eRC7/NhQuRxfvK9pu1y8WTNkGe9jFog7/wmLb4PitEVtNlaFRdHTl0nAMaHDgHM21is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eA6PKx2I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eA6PKx2I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758306032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k9iXI5/R5rD2mMqzOYTyS69puQj4GfGAZzCrP72enpE=;
	b=eA6PKx2I3eVL1JyLTdZET91ucO1WlYkDHRve7BTs6raVZ0/GgStwl1Qn5Z2/sTgJChkiAS
	wUOJpvopHQVYQzM257oCEvh0a6c8SicM02xixZlc2JkElhZ76YNOj2xn0TDmIDf2V1Oqo0
	eOomj8NcQtr7lkV1m9H04K2L52uRCaw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-ZEXQVgj5NK6rwROnnnPJlw-1; Fri, 19 Sep 2025 14:20:30 -0400
X-MC-Unique: ZEXQVgj5NK6rwROnnnPJlw-1
X-Mimecast-MFC-AGG-ID: ZEXQVgj5NK6rwROnnnPJlw_1758306030
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-78ea15d3548so23055166d6.1
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 11:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306030; x=1758910830;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9iXI5/R5rD2mMqzOYTyS69puQj4GfGAZzCrP72enpE=;
        b=J/UhJ8DYxAirW4be0w/IO0m2XTvGehvcOgJ/BNIpTqyFjMw9DMNZWPAyp6ScbFziom
         yie3JRIlDk3DN55JgyRqNDBo0BaTnunTNme2AT+5f/n9nN1W8SXtX1wPj7NdNa3bfKZQ
         9owLlIxAxO7xDOg1pkLjcxAxlf/X6NGCpYWbaapHMzSWkvKGBGv3gXVSEtwFuSMGymsA
         05iLBWz0tXBpPRI9LrYZIh5OZx3/HG6rWzRdsRzDd0gy9soNlVz9c3z1aAKFGp6xzML+
         fhpzmO2OvylHCGORmI0iiVTqCahks/7okhT3dvnATg8U0jZXC3w23z9iyPckO9bm02Xl
         7Xaw==
X-Gm-Message-State: AOJu0YzDzZsZV2ez7KBM8QgqcZoWW5lN6LhUZW3f0QSjPofM36BOkCOn
	T70AsA2oSMAmdpApdd6Bp2CmrvjRL8ljC0TF6z4l4BO8zxRkNJ6CATecxPNSCVMehtV7lMYTDzI
	zD1ZGfoGzB9zhAErmRt9O6pKq9mmNmGYolK8Wp6SLPQMsjLzESChe29ik8iANrTI0Oqye
X-Gm-Gg: ASbGnctAEoq0WcMVsux/VIkcCkezhjqnOKNhHV8fStKvEb9lm7lp/hO8OIxnAbVNYDt
	uicBdGttMlwKThHa1WBqn9AnyBaz9jJWWXBe8qVuveKIzM6Ht+UC5WW2oSCuHYxi5cUiZWA4VtT
	3nIh33mxvdeRzQTouPfp8zhWwP4mbkh5ASIlN65L6rSHVqt5BhNMIzupmw4jrwnnrtluO0pil6o
	CnUP69RJ0Hr/IA+6cXKU1/XJW73nTpoZ1gFsfpkuugh9fPjedT1AtVS17SYUToRRrCiCh6kG8Wu
	PQ9OHGTDKUeAIIp5Efz3t/QTJDMyoaM0T02Aqx93VBZZ9G1vddPRJoMPU1d5Xui/6+d5raTKG8W
	zqbIlMWQWyKIc
X-Received: by 2002:a05:6214:501b:b0:76e:7c27:f040 with SMTP id 6a1803df08f44-7991ec5f13cmr55168396d6.54.1758306029754;
        Fri, 19 Sep 2025 11:20:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAhvcxTpbTgx4/1KPui+LkrTGG7fILKwvRA8hGVbNvBlxojQ0fIUHeWNfBvsQQ7GNNxu9Tjw==
X-Received: by 2002:a05:6214:501b:b0:76e:7c27:f040 with SMTP id 6a1803df08f44-7991ec5f13cmr55167776d6.54.1758306029051;
        Fri, 19 Sep 2025 11:20:29 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0604w-grc-05-70-53-55-167.dsl.bell.ca. [70.53.55.167])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79347e50865sm32914866d6.33.2025.09.19.11.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:20:28 -0700 (PDT)
Date: Fri, 19 Sep 2025 14:20:26 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>, 
    Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 02/10] rt-utils: Remove mount_debugfs()
In-Reply-To: <20250903111717.1391196-3-bigeasy@linutronix.de>
Message-ID: <3f21a3f1-4cf6-5d01-368f-f4157d995a51@redhat.com>
References: <20250903111717.1391196-1-bigeasy@linutronix.de> <20250903111717.1391196-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 3 Sep 2025, Sebastian Andrzej Siewior wrote:

> The requirement to mount debugfs is very old. It originated from a time
> where it was "fairly new" and was not mounted by distros at the time.
> These days debugfs gets mounted during boot and more importantly the
> tracing directory moved out over 10years ago.
> 
> Don't try to mount debugfs anymore.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  src/include/rt-utils.h |  1 -
>  src/lib/rt-utils.c     | 29 -----------------------------
>  2 files changed, 30 deletions(-)
> 
> diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
> index f6b3fede06f7b..95964f70a6310 100644
> --- a/src/include/rt-utils.h
> +++ b/src/include/rt-utils.h
> @@ -12,7 +12,6 @@
>  
>  int check_privs(void);
>  char *get_debugfileprefix(void);
> -int mount_debugfs(char *);
>  int get_tracers(char ***);
>  int valid_tracer(char *);
>  
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index 6bbd25a8ba53f..7e96950ef9887 100644
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -99,32 +99,6 @@ char *get_debugfileprefix(void)
>  	return debugfileprefix;
>  }
>  
> -int mount_debugfs(char *path)
> -{
> -	char *mountpoint = path;
> -	char cmd[MAX_PATH];
> -	char *prefix;
> -	int ret;
> -
> -	/* if it's already mounted just return */
> -	prefix = get_debugfileprefix();
> -	if (strlen(prefix) != 0) {
> -		info(1, "debugfs mountpoint: %s\n", prefix);
> -		return 0;
> -	}
> -	if (!mountpoint)
> -		mountpoint = "/sys/kernel/debug";
> -
> -	sprintf(cmd, "mount -t debugfs debugfs %s", mountpoint);
> -	ret = system(cmd);
> -	if (ret != 0) {
> -		fprintf(stderr, "Error mounting debugfs at %s: %s\n",
> -			mountpoint, strerror(errno));
> -		return -1;
> -	}
> -	return 0;
> -}
> -
>  static char **tracer_list;
>  static char *tracer_buffer;
>  static int num_tracers;
> @@ -451,9 +425,6 @@ static int trace_file_exists(char *name)
>  
>  static void debugfs_prepare(void)
>  {
> -	if (mount_debugfs(NULL))
> -		fatal("could not mount debugfs");
> -
>  	fileprefix = get_debugfileprefix();
>  	if (!trace_file_exists("tracing_enabled") &&
>  	    !trace_file_exists("tracing_on"))
> -- 
> 2.51.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

