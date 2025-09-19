Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C0425F780
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307974; cv=none; b=RiEAI1xIfQ6jiD6Ni07nRb8jgPyszjcSP2V2i+UuGmSo37y1/EIwkMCBAEcu68yehUIW9O1RUUMQijFfLfvWc/998QgLKjNKf0gQGBhwcKIUEjJZxCjtguOdRSoJJGqCRBBMiNhcCQxALRPCeSkWvfu0YW1CuoX/78PduWI9hxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307974; c=relaxed/simple;
	bh=cU8GgmN8yq4eu+HMyXpjeY+IqAoCgsaRD9RflVjfr+U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=e7vrPx29sIFp8+GGlGfe+IhXMKfueALf83Q5q42/cQsYA/ZbHGpj5oUfxmuxc3rniSokz3HiT90iQyzz0GTIzWHJzTEbbWQsFPkxJ58vWRKYkKEjHGH1IJIPtUQWO7dyJQvCneC3JG9j06ux1buYkivqC8s/Du+/sZv5xtXmfUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZmvlIBmo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmvlIBmo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758307971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=waMPl3aUDeRLfFphri0iQRK0tWRAfxNQuPLwp+FEh+4=;
	b=ZmvlIBmoq85CHz7Q7OCNymWKCfk6/wkSY1tBThbxcO6ueHdHkcbbNlqO1Jzd52P+AspFUF
	KJo75tXOVI8YDOG/dC4LZoHcdEbv0UtaWAX9+ypC6rgBUtceT2dGbyo3kfED4echAKssQd
	pysZ4lr8tEI2BrhLGcFZ+yj+I/NOY60=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-Y84vly1BPom799XkdxO2HA-1; Fri, 19 Sep 2025 14:52:48 -0400
X-MC-Unique: Y84vly1BPom799XkdxO2HA-1
X-Mimecast-MFC-AGG-ID: Y84vly1BPom799XkdxO2HA_1758307967
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-79390b83c48so45422306d6.1
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 11:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758307967; x=1758912767;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=waMPl3aUDeRLfFphri0iQRK0tWRAfxNQuPLwp+FEh+4=;
        b=X08TzhTcpLw+b/F+xwSv8WDMM/W2j6iCLiTWQgm5j43qkG14X0bIHgMi0lqdu6M0NQ
         fkf2bbaWAHLwmCdYad8wk9FinTwFX2wICivEJloZlY616UVY7wu0XIReebh089HQwSCH
         FSU/TqjCMYZ61sKvWI/Fz/Xv/5x47obsEHG3cDdZoU76K7df8kbU0yMR/IzPdrFQIQzX
         WMyBVmMb8ZJ1oqSy1yY14XIAVXMhiA86LsKQAUDBMMjeV5F2yPF/UBBizl8zj+BryLYu
         wMrteBlORkSgcPGzaXNyPJeyhi+yXnBjpPWJDGX15K+UNOU2SztF2dVdyiluLyHfyYp4
         76qQ==
X-Gm-Message-State: AOJu0YzoiQewtr1Ty7/vLGTKprsWsYwdfsu/1biD2gi+z6t35ubqClQ5
	chUgRF70rNuwpprObG6oX0wvboYSSOGiwC+oRonY9rKcH8xk396/X9/UiCeNK3tw5uoB6H/TJJN
	RydV/1liLjONXTcz+NBgrA+dm5Y0h6tSWwvki1KlpqQ7JxO+3GuxYM1EDR7rE9okoG/9i
X-Gm-Gg: ASbGnctAtLrxdwn3ZVyIVY6jXY+miNeULOw3JDLIRQDEMXhO7ZG9URDcK2IxEMGTwD2
	oXxdVbxOv+Biqsp+173lZUIOMr0KtENeDI39NAj45MnMlJnaq84KtlnocVxqD4Us6eI6UQbMtQR
	cmfd+cSOU36J75zj44HXI32RIkJ2pIhJDfWuM1QlpauiFiGgmSqu88wgfL/iRMIkyUrzCdLpNiz
	jYsVqXjpghh8gv8Dr5r2ik3f53+HpK4+kDKS0Vxnl/maMrZi/+9eCDEfC9hH8jEEhkX24w/zMqi
	rVEOQy7X1qP4+mJONmT5J8s328PV4LsdXYTcMA7a/nVFjBDcx3xdrgSK/50YtvlT1qgW49gsyfh
	aEwqf8tkM+kvp
X-Received: by 2002:a05:6214:5287:b0:793:69d9:8d3f with SMTP id 6a1803df08f44-79910ca621amr44334806d6.8.1758307967483;
        Fri, 19 Sep 2025 11:52:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+8qNUp2VFXh7H2LRzbBFqLSzQyM7CPd1IdRPYAGve6r69NKTttNLAZ6ZeR/YiwoDXEIem2w==
X-Received: by 2002:a05:6214:5287:b0:793:69d9:8d3f with SMTP id 6a1803df08f44-79910ca621amr44334576d6.8.1758307967081;
        Fri, 19 Sep 2025 11:52:47 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0604w-grc-05-70-53-55-167.dsl.bell.ca. [70.53.55.167])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793472c37e7sm33664456d6.27.2025.09.19.11.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:52:46 -0700 (PDT)
Date: Fri, 19 Sep 2025 14:52:45 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>, 
    Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 08/10] sched_deadline: Use tracemark() from rt-utils
 instead cusstom implementation
In-Reply-To: <20250903111717.1391196-9-bigeasy@linutronix.de>
Message-ID: <e8f477eb-5179-72f2-3783-71fc8d4a1961@redhat.com>
References: <20250903111717.1391196-1-bigeasy@linutronix.de> <20250903111717.1391196-9-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 3 Sep 2025, Sebastian Andrzej Siewior wrote:

> Somehow cyclicdeadline has its implementation to write to the
> trace_marker and it also uses tracemark() from rt-utils.
> Since now tracemark() is not stopping the trace anymore it can be used
> as-is.
> This has the advantage of removing some code and automaticly using
> trace_marker from tracefs :)
> 
> Remove ftrace_write(), setup_ftrace_marker() and use tracemark()
> instead.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  src/sched_deadline/cyclicdeadline.c | 116 ++--------------------------
>  1 file changed, 5 insertions(+), 111 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index e2f827deb275a..82e640409ecef 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -72,8 +72,6 @@ struct sched_data {
>  	int bufmsk;
>  
>  	struct thread_stat stat;
> -
> -	char buff[BUFSIZ+1];
>  };
>  
>  static int shutdown;
> @@ -92,7 +90,6 @@ static int cpu_count;
>  static int all_cpus;
>  static int nr_threads;
>  static int use_nsecs;
> -static int mark_fd;
>  static int quiet;
>  static char jsonfile[MAX_PATH];
>  
> @@ -136,107 +133,6 @@ static const char *find_debugfs(void)
>  	return debugfs;
>  }
>  
> -static int my_vsprintf(char *buf, int size, const char *fmt, va_list ap)
> -{
> -	const char *p;
> -	char tmp[100];
> -	char *s = buf;
> -	char *end = buf + size;
> -	char *str;
> -	long long lng;
> -	int l;
> -	int i;
> -
> -	end[-1] = 0;
> -
> -	for (p = fmt; *p && s < end; p++) {
> -		if (*p == '%') {
> -			l = 0;
> - again:
> -			p++;
> -			switch (*p) {
> -			case 's':
> -				if (l)
> -					fatal("Illegal print format l used with %%s\n");
> -				str = va_arg(ap, char *);
> -				l = strlen(str);
> -				strncpy(s, str, end - s);
> -				s += l;
> -				break;
> -			case 'l':
> -				l++;
> -				goto again;
> -			case 'd':
> -				if (l == 1) {
> -					if (sizeof(long) == 8)
> -						l = 2;
> -				}
> -				if (l == 2)
> -					lng = va_arg(ap, long long);
> -				else if (l > 2)
> -					fatal("Illegal print format l=%d\n", l);
> -				else
> -					lng = va_arg(ap, int);
> -				i = 0;
> -				while (lng > 0) {
> -					tmp[i++] = (lng % 10) + '0';
> -					lng /= 10;
> -				}
> -				tmp[i] = 0;
> -				l = strlen(tmp);
> -				if (!l) {
> -					*s++ = '0';
> -				} else {
> -					while (l)
> -						*s++ = tmp[--l];
> -				}
> -				break;
> -			default:
> -				fatal("Illegal print format '%c'\n", *p);
> -			}
> -			continue;
> -		}
> -		*s++ = *p;
> -	}
> -
> -	return s - buf;
> -}
> -
> -static void ftrace_write(char *buf, const char *fmt, ...)
> -{
> -	va_list ap;
> -	int n;
> -
> -	if (mark_fd < 0)
> -		return;
> -
> -	va_start(ap, fmt);
> -	n = my_vsprintf(buf, BUFSIZ, fmt, ap);
> -	va_end(ap);
> -
> -	write(mark_fd, buf, n);
> -}
> -
> -static void setup_ftrace_marker(void)
> -{
> -	struct stat st;
> -	const char *debugfs = find_debugfs();
> -	char files[strlen(debugfs) + strlen("/tracing/trace_marker") + 1];
> -	int ret;
> -
> -	if (strlen(debugfs) == 0)
> -		return;
> -
> -	sprintf(files, "%s/tracing/trace_marker", debugfs);
> -	ret = stat(files, &st);
> -	if (ret >= 0)
> -		goto found;
> -	/* Do nothing if not mounted */
> -	return;
> -found:
> -	mark_fd = open(files, O_WRONLY);
> -}
> -
>  /*
>   * Return true if file exists
>   */
> @@ -804,16 +700,15 @@ static u64 do_runtime(struct sched_data *sd, u64 period)
>  		 * preempting us when we started. If that's the case then
>  		 * adjust the current period.
>  		 */
> -		ftrace_write(sd->buff,
> -			     "Adjusting period: now: %lld period: %lld delta:%lld%s\n",
> -			     now, period, delta, delta > sd->deadline_us / 2 ?
> -			     " HUGE ADJUSTMENT" : "");
> +		tracemark("Adjusting period: now: %lld period: %lld delta:%lld%s\n",
> +			  now, period, delta, delta > sd->deadline_us / 2 ?
> +			  " HUGE ADJUSTMENT" : "");
>  		period = now;
>  		next_period = period + sd->deadline_us;
>  	}
>  
> -	ftrace_write(sd->buff, "start at %lld off=%lld (period=%lld next=%lld)\n",
> -		     now, now - period, period, next_period);
> +	tracemark("start at %lld off=%lld (period=%lld next=%lld)\n",
> +		  now, now - period, period, next_period);
>  
>  
>  	diff = now - period;
> @@ -1293,7 +1188,6 @@ int main(int argc, char **argv)
>  	if (mlockall(MCL_CURRENT|MCL_FUTURE) == -1)
>  		warn("mlockall");
>  
> -	setup_ftrace_marker();
>  	if (tracelimit && trace_marker)
>  		enable_trace_mark();
>  
> -- 
> 2.51.0
> 
> 
    - fixed spelling of automatically
    Signed-off-by: John Kacur <jkacur@redhat.com>

