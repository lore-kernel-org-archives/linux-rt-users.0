Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00201B87F0
	for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758916731; cv=none; b=r2wxPl0VgcstK6dHujWZ0zZKMjqQu3cdR8lnR4hm4E8B31DSiJf93oX96ujBkyEJIs3ebV3pehV3zlda5R8rMcybcj1EnGdYg9FfhLq/ykjZtwYCDhxhzPyNhniOQpdChYU3Sok6DnzIgMNFa6TxxIALJpmLwhZkEoQUhyYO1D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758916731; c=relaxed/simple;
	bh=Ho+ttB+p2XlqrxdgT8Y74g0KnQ/wBHOAsWdkHkcGJpk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iyozH8G0Ecu1fmxaf7g6kN416s6o4xAuuPzqa14vK0qm89La0o8EQrpegRtUzlZkXnCtO1ELVVYNYN3tnmMy3b+dyx37TbN7/Q7VQ7IHMImbZUp1rDgAYEIxddzxCVlDDq63kAlvEDALoZix/O9Xosm7bQRVTUxfSNwV526wH/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SAxe8bqQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAxe8bqQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758916728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vL9B7w/tUThkQymUqtk0T0XwDQFrDQ8X0x5YKNf+eVY=;
	b=SAxe8bqQ8Ptdj+RNBHlqrp5MbKTvdn0Q2XN1yhV+j+mWvsIcGtbwIoDcE1bFzA6WZFXG4n
	K9cfi5H3JkTfSArWPRO4TTS3A90sQrxiHRUhZK+HDhP5EtdJqldyUOcx+fbM6+aXYxH8IC
	L7Xo5Oq5EOzinU1cxcZVZdHcfB9qkTo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-XZzfG-XvPRii_n34gTToyA-1; Fri, 26 Sep 2025 15:58:47 -0400
X-MC-Unique: XZzfG-XvPRii_n34gTToyA-1
X-Mimecast-MFC-AGG-ID: XZzfG-XvPRii_n34gTToyA_1758916726
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8574e8993cbso321983285a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 12:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758916726; x=1759521526;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vL9B7w/tUThkQymUqtk0T0XwDQFrDQ8X0x5YKNf+eVY=;
        b=jSLXiiERQXzhOzVQxJAEiBexHLOcqNEtVlRmuL4LEs3W8XPd/tuTCCtEEZqlTFbn3M
         K2axA5U1pPdFR75o9tMgrE1IpDHMZuNuegrTJoW5AhmNwT/hucgEOxRdCXE4o6drP+e+
         4xOozC5zsWJ/66NSmoC4YJZ131cfQoBq1MRcqJpdVPKDRiF87ep7ZMDO3+QW36Wou3Sb
         wX3qiCCyFJQYUvI/Qu9lsh7K4lsYGN7Ith6S2fek7mZctRWN2wkAkm6gPN0J+Mi6fhCi
         RuKOh/Wm0CnxHVjfQfC90gm2Mq9tS3zI64JdNvykKJP82dQ+d9o3c9YqrKxB8nrvYhhd
         ge9w==
X-Forwarded-Encrypted: i=1; AJvYcCX3cSOadM7iq+SiGPxoXhUFAxq/pE5hxAv55IeFuj+99XIqJt7mJlK5Tuw+wF891wFSqAnAOIx2GgN6XU+Rog==@vger.kernel.org
X-Gm-Message-State: AOJu0YywwStXvpIXchwLCca9ckItOxVsdsB7G8kTm6nzm8J7Bs/U4jt4
	kZpF0QH43FO93y1ZSSno6+VPZerXQFVPLa0XEeNUK6FXwz5+GRiSTvryWvcNOLLkKN1vTJqq3sg
	IlDeAadvlaTxX7DIfi+dxR96H7a0WrdOrkGJgLSIc8iU2pIPZXJq0dS47HZIVyFGShKAy
X-Gm-Gg: ASbGncuEiZcB1JE19mAQ3CRTo7wuWQXodCWURgjO9IK49GIYpLJX+2wu7Dkzr+B+Wc9
	tieR+IIv9jOD859cEdaGIzAM8wxyVPgKF0Y/i0ojw+RO3I+X3kUcyqtBr7G8ymWcdGoZVUFDJm1
	qw6jwtzYTCbJxK+YWRGKpMwo9jfW6HsGmPjTR+RtflUW6aSPqqt3LdsHk/8B/8wO5SyNHw236x4
	jeNvNpbLwoBnK8AmQmmquLjUD9xq2TfcVqGGo2/f95AUAXpGOtqp7xhrkwiL1k2nB8C67pPTYfu
	sZDcUcYyWiztibMKB0At/FctqE7cDc1dIk6jN6u0bcCxo4/9hBh2NSdyPLDBtgLP6XKw1fUO0Ew
	Zb7012FOku+NW
X-Received: by 2002:a05:620a:f0c:b0:853:64e7:8f2f with SMTP id af79cd13be357-85ae96afdc1mr1035696485a.77.1758916726205;
        Fri, 26 Sep 2025 12:58:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrcxvtP7eN+Ily5YHzHyWejjYxvwciV4nkdkoEowCUI0vEuq631eZJe5lyyBOxT6fPx3tYKg==
X-Received: by 2002:a05:620a:f0c:b0:853:64e7:8f2f with SMTP id af79cd13be357-85ae96afdc1mr1035693985a.77.1758916725768;
        Fri, 26 Sep 2025 12:58:45 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0604w-grc-05-70-53-55-167.dsl.bell.ca. [70.53.55.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c28a8d4d8sm334592385a.25.2025.09.26.12.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 12:58:45 -0700 (PDT)
Date: Fri, 26 Sep 2025 15:58:44 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
cc: williams@redhat.com, linux-rt-users@vger.kernel.org, 
    jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH v2 5/8] cyclicdeadline.c: Check return values of write()
 and ftruncate()
In-Reply-To: <20250726091837.493915-6-yphbchou0911@gmail.com>
Message-ID: <1754ddca-5493-98ff-ff0e-6b05dfc1c44c@redhat.com>
References: <20250726091837.493915-1-yphbchou0911@gmail.com> <20250726091837.493915-6-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sat, 26 Jul 2025, Cheng-Yang Chou wrote:

> Add error handling for write() to tracefs, cpuset control files, and
> system() calls to avoid ignoring errors.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  src/sched_deadline/cyclicdeadline.c | 32 ++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 04e61ed..6b5d3e0 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -206,6 +206,7 @@ static void ftrace_write(char *buf, const char *fmt, ...)
>  {
>  	va_list ap;
>  	int n;
> +	int ret;
>  
>  	if (mark_fd < 0)
>  		return;
> @@ -214,7 +215,9 @@ static void ftrace_write(char *buf, const char *fmt, ...)
>  	n = my_vsprintf(buf, BUFSIZ, fmt, ap);
>  	va_end(ap);
>  
> -	write(mark_fd, buf, n);
> +	ret = write(mark_fd, buf, n);
> +	if (ret < 0)
> +		perror("ftrace write failed");
>  }
>  
>  static void setup_ftrace_marker(void)
> @@ -448,6 +451,10 @@ static int mount_cpuset(void)
>  	if (fd < 0)
>  		return fd;
>  	ret = write(fd, "0", 2);
> +	if (ret < 0) {
> +		close(fd);
> +		return ret;
> +	}
>  	close(fd);
>  
>  	return 0;
> @@ -634,7 +641,14 @@ static void destroy_cpuset(const char *name, int print)
>  		sprintf(buf, "%d", pid);
>  		if (print)
>  			printf("Moving %d out of %s\n", pid, name);
> -		write(fd, buf, strlen(buf));
> +		ret = write(fd, buf, strlen(buf));
> +		if (ret < 0 && errno == ENOSPC) {
> +			fclose(fp);
> +			close(fd);
> +			fatal("Cannot move tasks out of cpuset %s\n", name);
> +		}
> +
> +
>  	}
>  	fclose(fp);
>  	close(fd);
> @@ -656,19 +670,24 @@ static void destroy_cpuset(const char *name, int print)
>  static void teardown(void)
>  {
>  	int fd;
> +	int ret;
>  
>  	if (all_cpus)
>  		return;
>  
>  	fd = open_cpuset(CPUSET_PATH, "cpuset.cpu_exclusive");
>  	if (fd >= 0) {
> -		write(fd, "0", 2);
> +		ret = write(fd, "0", 2);
> +		if (ret < 0)
> +			perror("cpuset.cpu_exclusive");
>  		close(fd);
>  	}
>  
>  	fd = open_cpuset(CPUSET_PATH, "cpuset.sched_load_balance");
>  	if (fd >= 0) {
> -		write(fd, "1", 2);
> +		ret = write(fd, "1", 2);
> +		if (ret < 0)
> +			perror("cpuset.sched_load_balance");
>  		close(fd);
>  	}
>  
> @@ -1164,6 +1183,7 @@ int main(int argc, char **argv)
>  	int nr_cpus;
>  	int i;
>  	int c;
> +	int ret;
>  
>  	rt_init(argc, argv);
>  
> @@ -1387,7 +1407,9 @@ int main(int argc, char **argv)
>  				  CPUSET_FL_CLONE_CHILDREN |
>  				  CPUSET_FL_TASKS, pids);
>  
> -		system("cat /sys/fs/cgroup/cpuset/my_cpuset/tasks");
> +		ret = system("cat /sys/fs/cgroup/cpuset/my_cpuset/tasks");
> +		if (ret < 0)
> +			perror("system call failed");
>  	}
>  
>  	debug(debug_enable, "main thread %d\n", gettid());
> -- 
> 2.48.1
> 
> 
> 
    - Fixed merge conflict due to bd5967b42597 which removed 
ftrace_write()
    Signed-off-by: John Kacur <jkacur@redhat.com>

