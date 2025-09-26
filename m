Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E647A13A
	for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758916819; cv=none; b=d8HXSLFjqhSM9BXmUOCNVKBjrAzidEV05Z3HniCPHPfGIb4Vcfmisdx7qi0NEU0YzlfKj8AGVgYDVkOktlYY9Ix092KwGmvxYmqvoR9bO5rsQNe6rBouHHPY7vB1+tI/aR2RpNX/YCtmo/887wgVHjInCHghQE3QpofDUf0ZWW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758916819; c=relaxed/simple;
	bh=4K0dvrAgMXfGvJAnWAlcsl7+D2qJsEbmNA0675bSQjo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=inW20NWHXU1X6FOEBD4rkPOuTkVw7bxCiuWTCk6iCy2ors1+T6ATpuqcoRFzjMrRTrEKrgouEdIMT1zMj8sfXjm4Xt9+0XAS3F44vlgkTND+AeCDMXdsdVIi0FUPLw0RnS1NvCkUkeCBTYpXoBg8MjgGDfoI1sBaUzkewTuvCL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2q1GNkE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2q1GNkE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758916813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D1QX0ORwlba9bHmyanfy8uidP6D/sJoLpt80fIXrdGg=;
	b=a2q1GNkE+9X+immlTC7DWltangE4kl5vrEImeovm1nrB2SeFAq7NLuh3Q2a55iY6eO84aQ
	ey5/jc62ry+Qya7D1pZ0cxlXz0EdCau3EBLgV8V9UKftXcVihfIVbIcVlVeQwI++6OFRpc
	zR7OA35pWLR5VpgIw/V3gywywPmJUag=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-TI5cM5s3NG28YM4j4M2GSQ-1; Fri, 26 Sep 2025 16:00:12 -0400
X-MC-Unique: TI5cM5s3NG28YM4j4M2GSQ-1
X-Mimecast-MFC-AGG-ID: TI5cM5s3NG28YM4j4M2GSQ_1758916812
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-844772ccee9so514965285a.0
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 13:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758916811; x=1759521611;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1QX0ORwlba9bHmyanfy8uidP6D/sJoLpt80fIXrdGg=;
        b=soITgwRZCBmFoqG+IGfNEzktUD0+SxTbm0KNJiyyx3+XAX9A+/g41OtFnUQ5ibVhFd
         /PY7ExA+v14G1p6TtJPr2z6RwPXN/MorU8lItrktiPaQ+Hi29sEIV3+z6zch4t/2jt/1
         +AoaU8shq3kOk4mBLZ06laT65YGuJoAuEhhsbmLTipJ3A5LbIhmsbShU5rzVIy2E1HVa
         EWSbEO59sUM6E6QzVqj4le4fB8ReAclpbj+HYk6XiZslOTKQKwQfdkUuw+oWSAU73WbY
         4asL/ENg/WnhxV29JLCnU0WjoTKeM/PbvcNDXIyWZ8E2RwekXU3fgH5jJSs1M6CZUnVW
         +5rg==
X-Forwarded-Encrypted: i=1; AJvYcCX5KI+gjH2l8Qd4oec/kexEvlVAxGkJ9r4bClNzNIi/irfe1AOZvcqmqK6l+RdxFx5U+BKvbXyFZMXXlqHCZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs/QAEYerxZ4UUOKRfrEcws4p8CAJCRVgyme04g4HiWhiR7tsV
	zfOqRcxToVh3me9kYrAl/EU7rHIK4V4UTxn9s36lBFiQD3A1kNkEvlO1kXE1k1ZXIYRtk6tB3E+
	Tf2ChbJCqQl2UKJyQsKPej91CWeHD9n6wELE/1BjFoJZ7SbR/sYdS1o9/bMJSF4P7lfVm
X-Gm-Gg: ASbGncuwXd4O6Q3uA/EJSl3Zv5lSZWIqvJ7BUsaftco18S53d93rKLhBbhOCAQC9RNh
	yclLSLvTFovw33eqk5pDgJ806jaCwIZv+WW5AZRp3nO0ZULvDG+q44b/6nEXGGrWygnLp9uXSmQ
	ld9Y+a6Hn5YWC0gs9EAFiguD0oDQbiQOSknhgaPsX0wczOqw9K+TApYWxMnzxcnyirSmA7gx/cf
	Iw+qdyUJoMEOaAip0tWMJZr3kgCCC/wO3pUEdcqMkGaWtqv/Rv7brOHOrHhXzeaQBsD+hgFJD8D
	+j0COGT1ccsiF2nggi1TD+sqqCLqvKFSs//EzoBeGUsJsvGQ1wF/dR4zTF0RY6P42MyugKmlB5v
	ZidSSYMMLhytS
X-Received: by 2002:a05:620a:3190:b0:81d:26e6:ef8c with SMTP id af79cd13be357-85aeada6539mr1005733085a.79.1758916811492;
        Fri, 26 Sep 2025 13:00:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYfaRrUQJrda+dFw9KkoR6hPSYfiZPCRW3OMuKgSLnDrAgKrU3iX/tuZorCbveegi1lGbMvg==
X-Received: by 2002:a05:620a:3190:b0:81d:26e6:ef8c with SMTP id af79cd13be357-85aeada6539mr1005727085a.79.1758916810960;
        Fri, 26 Sep 2025 13:00:10 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0604w-grc-05-70-53-55-167.dsl.bell.ca. [70.53.55.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c307ad101sm325422385a.36.2025.09.26.13.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 13:00:10 -0700 (PDT)
Date: Fri, 26 Sep 2025 16:00:09 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
cc: williams@redhat.com, linux-rt-users@vger.kernel.org, 
    jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH v2 6/8] deadline_test.c: Check return values of write()
 and ftruncate()
In-Reply-To: <20250726091837.493915-7-yphbchou0911@gmail.com>
Message-ID: <b8b68d23-bc6d-e580-b974-310fa93ab8be@redhat.com>
References: <20250726091837.493915-1-yphbchou0911@gmail.com> <20250726091837.493915-7-yphbchou0911@gmail.com>
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
>  src/sched_deadline/deadline_test.c | 37 ++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
> index ca2da47..a74d514 100644
> --- a/src/sched_deadline/deadline_test.c
> +++ b/src/sched_deadline/deadline_test.c
> @@ -325,6 +325,7 @@ static void ftrace_write(char *buf, const char *fmt, ...)
>  {
>  	va_list ap;
>  	int n;
> +	int ret;
>  
>  	if (mark_fd < 0)
>  		return;
> @@ -333,7 +334,9 @@ static void ftrace_write(char *buf, const char *fmt, ...)
>  	n = my_vsprintf(buf, BUFSIZ, fmt, ap);
>  	va_end(ap);
>  
> -	write(mark_fd, buf, n);
> +	ret = write(mark_fd, buf, n);
> +	if (ret < 0)
> +		perror("ftrace write failed");
>  }
>  
>  /**
> @@ -626,6 +629,10 @@ static int mount_cpuset(void)
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
> @@ -875,7 +882,19 @@ static void destroy_cpuset(const char *name, int print)
>  		sprintf(buf, "%d", pid);
>  		if (print)
>  			printf("Moving %d out of %s\n", pid, name);
> -		write(fd, buf, strlen(buf));
> +		ret = write(fd, buf, strlen(buf));
> +		if (ret < 0 && errno == ENOSPC) {
> +			/*
> +			 * If we get ENOSPC, then we have a problem, as it
> +			 * means that the cpuset is full, and we cannot move
> +			 * the tasks out of it.
> +			 */
> +			fclose(fp);
> +			close(fd);
> +			fprintf(stderr, "Failed to move %d out of %s\n", pid, name);
> +			perror("write");
> +			return;
> +		}
>  	}
>  	fclose(fp);
>  	close(fd);
> @@ -910,16 +929,21 @@ static void destroy_cpuset(const char *name, int print)
>  static void teardown(void)
>  {
>  	int fd;
> +	int ret;
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
> @@ -1790,6 +1814,7 @@ int main(int argc, char **argv)
>  	int rt_task = 0;
>  	int i;
>  	int c;
> +	int ret;
>  
>  	cpu_count = sysconf(_SC_NPROCESSORS_CONF);
>  	if (cpu_count < 1) {
> @@ -2041,7 +2066,9 @@ int main(int argc, char **argv)
>  			exit(-1);
>  		}
>  
> -		system("cat /sys/fs/cgroup/cpuset/my_cpuset/tasks");
> +		ret = system("cat /sys/fs/cgroup/cpuset/my_cpuset/tasks");
> +		if (ret < 0)
> +			perror("system call failed");
>  	}
>  
>  	pthread_barrier_wait(&barrier);
> -- 
> 2.48.1
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

