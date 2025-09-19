Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC478227BA4
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758308334; cv=none; b=m9ohzcSJLSWU1UZvhDXj4QSM9URWFB29g4Wy+xQT/NYtSdGRJ6SLnhj8UjJyVGh8aMSMtzA9MvQWikQoHsYh/A7Ds8twyvIsPUgvxmXdBk7SB1TkSoH6MOzcp/VQJQU1JiLE9r2/Sv57XNyb+Qn4hphcWPRvl5ytUImLLvKuU44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758308334; c=relaxed/simple;
	bh=VPsuWgLPq3m2/Qu8l3wCbd35smx25/KDSUtWLBUaF8U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Xs08jdUWiaOgqqLp7Kjx4fFV1ckUicfPlPqundq4SpAFYed0FIM9/BcNLqSA2Vptzrjfnj2Aiws6so4KEkeCPUb+kQ1e1h55TjavWf24/dLpL7fviJ4Z5jt26E9OYuubhg+UTFoGjECrshhgyi8IwbEpY/+5JTR4dToU8uCSp8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TAx5suLc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAx5suLc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758308331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NgxNpQs8jNUymMesJl239AmT9Xjcef7uS3J/qlxrU+4=;
	b=TAx5suLcbjBmiQNC0Nm8decxaPJzV1Z1WB2oXBXofglgqF3CQk2eHyy7vgiFY0xU3hNoWx
	K3XmfIxve5J9KAVBlk6bSsdlHOLK5gy9I05bUFLieVqcoO7Nd2MntYTGhMkX9HVfa3MKTW
	mejpCiferXjpY2meTauIeksFv8t/awE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-TU4WwR_0OOW2qAIe8kpMKw-1; Fri, 19 Sep 2025 14:58:50 -0400
X-MC-Unique: TU4WwR_0OOW2qAIe8kpMKw-1
X-Mimecast-MFC-AGG-ID: TU4WwR_0OOW2qAIe8kpMKw_1758308330
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7966a34e19dso21115256d6.0
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 11:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758308330; x=1758913130;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NgxNpQs8jNUymMesJl239AmT9Xjcef7uS3J/qlxrU+4=;
        b=pPPVT/Hi6Gx5g7zbwluw8WmZTD0RfqQw0dgM57uvJapiwARhg+N12VHeweetLAHvYl
         h8PQaa+f7Q2Yznn+2MAIO/RMn9MBgf2+ZFlFijv7ZHOHo9chmcpqFjI9ituUSJbVPtcC
         9ofHeU1VACBVy99DELqdymC9e1TYpFvM6uZjDB4cV9avHeVrDb0xKIdGcRBF92VHSvv7
         BdPUBlaOpTOYuM08JMYSkxg0ZtJYzUOoLXlbhqtZc3BFMnYoSMWFvjGcNC/V/dHJBKz+
         0xZclfxH1YeARiHUx3aarVvaTJlpvfyJvMrd3L/w/Jfj2uyO+lVZM5tWqwwXt1avRHQp
         K3Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWJjklxhTACYkM0UojYQeqK1GbaOtkcJmQB9lbhTUdzU5zcq9EZfTujNPqO6HcVfpW+FVw1c58tnMNilhUrUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMbmZhW9Qyvq6QViJGP+dQpV959uTR1mExqlXg+HR8izV7FqQz
	TiT+g03zrsR7ff1/JY9x1XCsZmgde2SPuCY3XUECz3gMRBg45gmHh9JVq1wLtRj/dfpGC5CPqGq
	QCpuTxKcvNlOCOSAOcAk7Kvg79QLGYTFBY/oEc9mgedjSfRmSukCgvUm7ndweY0nhiNIF
X-Gm-Gg: ASbGnct5ivu5Zom3numygbmbuTT4AuWHLaiV/vRlHs5YDRmBWCtkrZkEB/R+/C/eIDB
	qz0Vz1o8deW48u/CqLK0VYISvJ3z3KmebTm9jwrz/QpeqgPvAYcaWP1zaEWEuZwucrDokmeXVwZ
	Shpi3pHxXmWxHuXpUUKG+7lltnVnhx9Qgmdids+cNhzgv1CDhbgkxtdq/+vnCmAbJIL2jcQmFid
	bu3QYEYRgo0R7TyIE5Xu7+fHJ+MLp0NtgdmdcAErap0aUkOfo5/74kMpRm0MiDbjt/Oxp4/OHdm
	HjM94KjzIX3w3TCqO1DIsZH2+Ah2HVjm6jtQ/GPZX2dVSUfYHcLX9BOSjA79YO859r0vl31oD9T
	IWDHT+yx86mtI
X-Received: by 2002:a05:6214:400a:b0:77e:aba2:c8b1 with SMTP id 6a1803df08f44-7926c0d20famr78359936d6.22.1758308329596;
        Fri, 19 Sep 2025 11:58:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZbDIJf+TcIllfML1DxXaDI/cXC44K04tveXF6bBZcdGeQerxQjxdPIjhgM7zHKt4gaaTzLg==
X-Received: by 2002:a05:6214:400a:b0:77e:aba2:c8b1 with SMTP id 6a1803df08f44-7926c0d20famr78359656d6.22.1758308329161;
        Fri, 19 Sep 2025 11:58:49 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0604w-grc-05-70-53-55-167.dsl.bell.ca. [70.53.55.167])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793533affbcsm33852786d6.49.2025.09.19.11.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:58:48 -0700 (PDT)
Date: Fri, 19 Sep 2025 14:58:47 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Derek Barbosa <debarbos@redhat.com>
cc: williams@redhat.com, linux-rt-users@vger.kernel.org, crwood@redhat.com, 
    oleg@redhat.com, shichen@redhat.com
Subject: Re: [PATCH v3] ssdd: mitigate tracee starvation
In-Reply-To: <3yq34kwrfmwvhy5la5wutnmbdd6pf4rwnvnvnapegvx7acq7xu@pghcpahcvndz>
Message-ID: <e73857cf-00a0-00ff-17ed-73d95c147705@redhat.com>
References: <3yq34kwrfmwvhy5la5wutnmbdd6pf4rwnvnvnapegvx7acq7xu@pghcpahcvndz>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 19 Sep 2025, Derek Barbosa wrote:

> When ssdd is invoked with nforks > 100 && niters == 10000 on a tuned,
> realtime kernel, the following error messages can be seen:
> 
> EXITING, ERROR: wait on PTRACE_SINGLESTEP #385: no SIGCHLD seen (signal count == 0), signo 5
> EXITING, ERROR: wait on PTRACE_SINGLESTEP #398: no SIGCHLD seen (signal count == 0), signo 5
> EXITING, ERROR: wait on PTRACE_SINGLESTEP #385: no SIGCHLD seen (signal count == 0), signo 5
> ...
> 
> This behavior is caused by ptrace_stop() being unable to sleep after
> taking tasklist_lock().
> 
> As forktest() generates "niter" PTRACE_SINGLESTEP's for nforks, in the
> rare event where nforks exceeds the defaults by a large order of
> magnitude, the sporadic test failures caused by missing SIGCHLDs
> indicates that the tracees are unable to effectively wait for their
> asynchronous signals to arrive --as denoted in the previous sleeps for
> check_sigchld().
> 
> Therefore, by performing an sigtimedwait() in check_sigchld(), we
> give the tracee enough CPU time to call
> do_notify_parent_cldstop()->send_signal_locked().
> 
> The observed behavior after appling this patch mitigates the
> aforementioned issue in scenarios with a high number of nforks.
> 
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Suggested-by: Crystal Wood <crwood@redhat.com>
> Signed-off-by: Derek Barbosa <debarbos@redhat.com>
> ---
> V1 -> V2: Addressed review comments, removed usleep() in favor of
> sigtimedwait().
> V2 -> V3: Addressed checkpatch.pl complaints.
> 
>  src/ssdd/ssdd.c | 65 ++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 48 insertions(+), 17 deletions(-)
> 
> diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
> index 50f7424..63130cd 100644
> --- a/src/ssdd/ssdd.c
> +++ b/src/ssdd/ssdd.c
> @@ -30,6 +30,7 @@
>  #include <getopt.h>
>  #include <string.h>
>  #include <signal.h>
> +#include <time.h>
>  #include <errno.h>
>  
>  #include <sys/types.h>
> @@ -67,7 +68,7 @@ static const char *get_state_name(int state)
>  static int quiet;
>  static char jsonfile[MAX_PATH];
>  
> -static int got_sigchld;
> +volatile int got_sigchld;
>  
>  enum option_value { OPT_NFORKS=1, OPT_NITERS, OPT_HELP, OPT_JSON, OPT_QUIET };
>  
> @@ -127,23 +128,33 @@ static int do_wait(pid_t *wait_pid, int *ret_sig)
>  	return STATE_UNKNOWN;
>  }
>  
> -static int check_sigchld(void)
> +static int check_sigchld(sigset_t *set)
>  {
> -	int i;
> +
> +	struct timespec timeout;
> +
> +	timeout.tv_sec = 10;
> +	timeout.tv_nsec = 0;
> +	int recv_sig = 0;
> +
>  	/*
> -	 * The signal is asynchronous so give it some
> -	 * time to arrive.
> +	 * Check the handler flag, then if need be, wait for the signal to
> +	 * arrive
>  	 */
> -	for (i = 0; i < 10 && !got_sigchld; i++)
> -		usleep(1000); /* 10 msecs */
> -	for (i = 0; i < 10 && !got_sigchld; i++)
> -		usleep(2000); /* 20 + 10 = 30 msecs */
> -	for (i = 0; i < 10 && !got_sigchld; i++)
> -		usleep(4000); /* 40 + 30 = 70 msecs */
> -	for (i = 0; i < 10 && !got_sigchld; i++)
> -		usleep(8000); /* 80 + 70 = 150 msecs */
> -	for (i = 0; i < 10 && !got_sigchld; i++)
> -		usleep(16000); /* 160 + 150 = 310 msecs */
> +	if (!got_sigchld)
> +		recv_sig = sigtimedwait(set, NULL, &timeout);
> +
> +	if (sigprocmask(SIG_UNBLOCK, set, NULL) == -1) {
> +		printf("EXITING, ERROR: unable to mask signal set\n");
> +		exit(1);
> +	}
> +
> +	if (recv_sig == -1) {
> +		printf("EXITING, ERROR: Timeout: no signal received in 10 seconds\n");
> +		exit(1);
> +	} else if (recv_sig == SIGCHLD) {
> +		got_sigchld = 1;
> +	}
>  
>  	return got_sigchld;
>  }
> @@ -195,6 +206,20 @@ static int forktests(int testid)
>  		exit(1);
>  	}
>  
> +	/*
> +	 * Block the signal before it is generated
> +	 * Ensures we can synchronously wait for it.
> +	 */
> +	sigset_t set;
> +
> +	sigemptyset(&set);
> +	sigaddset(&set, SIGCHLD);
> +
> +	if (sigprocmask(SIG_BLOCK, &set, NULL) == -1) {
> +		printf("EXITING, ERROR: unable to mask signal set\n");
> +		exit(1);
> +	}
> +
>  	/*
>  	 * Attach to the child.
>  	 */
> @@ -224,7 +249,7 @@ static int forktests(int testid)
>  		       ret_sig);
>  		exit(1);
>  	}
> -	if (!check_sigchld()) {
> +	if (!check_sigchld(&set)) {
>  		printf("forktest#%d/%d: EXITING, ERROR: "
>  		       "wait on PTRACE_ATTACH saw a SIGCHLD count of %d, should be 1\n",
>  		       testid, getpid(), got_sigchld);
> @@ -238,6 +263,12 @@ static int forktests(int testid)
>  	 * step the tracee.
>  	 */
>  	for (i = 0; i < nsteps; i++) {
> +
> +		if (sigprocmask(SIG_BLOCK, &set, NULL) == -1) {
> +			printf("EXITING, ERROR: unable to mask signal set\n");
> +			exit(1);
> +		}
> +
>  		pstatus = ptrace(PTRACE_SINGLESTEP, child, NULL, NULL);
>  
>  		if (pstatus) {
> @@ -271,7 +302,7 @@ static int forktests(int testid)
>  			       testid, getpid(), i, ret_sig);
>  			exit(1);
>  		}
> -		if (!check_sigchld()) {
> +		if (!check_sigchld(&set)) {
>  			printf("forktest#%d/%d: EXITING, ERROR: "
>  			       "wait on PTRACE_SINGLESTEP #%d: no SIGCHLD seen "
>  			       "(signal count == 0), signo %d\n",
> -- 
> 2.50.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

