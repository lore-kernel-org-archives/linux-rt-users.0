Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DBB284B35
	for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758916892; cv=none; b=cBXKIn4X+loddGdQ13+OPzI1zQfXHTsiEO35Ukmv66Pe3O7v2EfUlbILN1VE0TWsoiNpkOeUHOs1zk6XASn16cYoQFxqICf1SBS14h3pafxdzVwvSID8hf0V8G3Pq46LLHcr4sfUEdzHKGA8VZScdomifJJUXlPTxQuN8Lnj9K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758916892; c=relaxed/simple;
	bh=S4T8o10VC2rnXrL5PWg7nOCEyBNmVWOzZNQB9gPK04k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KMhont2xMcR39Ig1a1AZGdQD9tzQXPKoeThcaKIDPZJQqVMJjQEuWSADLXWFTrRKCLMfHnwavDxc8nA0rxSIT1HUOHHDKbAB308q2hJjQE5C2EpxDa8oD2wdgTYng5qD3YL+x41EHYIG0v2KKyIJZDpHYyMORlrekYaIarcMTPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJJa9Bs2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJJa9Bs2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758916889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yYE2K5DSHy2syVVcuxTgDd7RVCWOjo/9RDulxTsE9CI=;
	b=dJJa9Bs2a+xDjFM2GVWfgCS0oKk/DJDa85+o/uo8TLsLCi0Gq/j01WbjfX0l9H8zPPnxxZ
	m2JyRorWoGtFiM6sK95WG97BYBzXBVwh0CBQQF2HDGoaiC9mDZEdESnARzoiLpUg7s62k4
	fZ3m9F/imOgMCAMGTNuQZ78TrQZegXU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-qxbWWsuYPAmW_pqG9aEzHA-1; Fri, 26 Sep 2025 16:01:28 -0400
X-MC-Unique: qxbWWsuYPAmW_pqG9aEzHA-1
X-Mimecast-MFC-AGG-ID: qxbWWsuYPAmW_pqG9aEzHA_1758916887
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4de5fe839aeso17914861cf.3
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 13:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758916887; x=1759521687;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYE2K5DSHy2syVVcuxTgDd7RVCWOjo/9RDulxTsE9CI=;
        b=L9AW3zKdOyb8nvctRQ03GI+YOWILvG73SdA+wmIC6EZ3SvazQ+Ooh/MSY7svY7jst4
         nIuUN9pW3K6Lx7/5qiU9xDhCFGk5JfsJaxbvyuW9M+oT8mDYIoJoSjRr2ErdtxEiA/eC
         zt9fd6Vn1UZyES/5Zk6EtjJQ+nr2ydAXhII8s20aqSzWGzFDJlxhjqJzaOtHXaM612Rc
         shWjGrbxAB+B+S039g0rRZTAgtgDyr7fCgeEqg1W1phS2kzCGk3yWo+XcrcN3u9dHGLF
         fFc25ecgC98uizxo1zEp1kHHP/0I5p+G8k0VlrSRwPFHKGLq34BA5SAI5RCDMUggJ6Eb
         FNdg==
X-Forwarded-Encrypted: i=1; AJvYcCU9SA8I26UtSDeHHe+IiXcirNZIKhIF9VfwGcawb2smcVKiVohZTc3HBIP3fnce7B0MW/6cFv8Fd6n0eTFX5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCN5jZ9U6Puqo764TL+S+iwZwLFar9jugP7NaFNzJtqgA78cuy
	7dO0GJIvFvogNK/Dm1y8kvntLBFKa0LUU3RB5kr0UgwjuhwYVepB6BWz3FaIRs2tm4pU6AzkFlJ
	rdY0ExBZNm1SpCTaq9gVK0KDZ6YNU9ant090PacYYKW+nKkYsybLeJxsKaxAWcZ34Rw3d
X-Gm-Gg: ASbGncv28GYJbHN7k1yHdt9wqtE3hWA8mypYBZOR3eYaPDoKV089wlVFBEJcWuNOXt/
	/N4g96XKOI4KdZ90ZX19KW281r1rArIWz3OaoP7g1+myhEED1oFr05+IWDJqNriNJVkWiKkn5fo
	eYXZYJFYQi2PtOXfYCTEX+TEVTRTMh12R+gL/+AWCgJRRRpRxQvF2eoFwEXv2Slz7vU1EP/igiV
	CJk0JBSk16yPA5gIr2k7x1fk4nXbZ4o52+4pMFTJ0mW1oLIAokOCqoL/OfUAnAkPGiToqiF6vOF
	FEhpsE4fyWv9o6n5wsaxm3MMFiQYQtOjRNaYtw5MQSTncIumHm1rRJIzEuBvmKd+B3lx62aoYXh
	uEjk2xrTklIq/
X-Received: by 2002:ac8:6f1b:0:b0:4dc:cb40:7078 with SMTP id d75a77b69052e-4dccb4072d2mr85624501cf.19.1758916887170;
        Fri, 26 Sep 2025 13:01:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYeHx+8p1hS3uX+jzDlKJnBOi2vVc56i+06rYdeLNWVudaBkX+J2Tjyks5GTSCS3YhBZ7UyA==
X-Received: by 2002:ac8:6f1b:0:b0:4dc:cb40:7078 with SMTP id d75a77b69052e-4dccb4072d2mr85623721cf.19.1758916886499;
        Fri, 26 Sep 2025 13:01:26 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0604w-grc-05-70-53-55-167.dsl.bell.ca. [70.53.55.167])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0b94599esm31065421cf.16.2025.09.26.13.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 13:01:26 -0700 (PDT)
Date: Fri, 26 Sep 2025 16:01:25 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
cc: williams@redhat.com, linux-rt-users@vger.kernel.org, 
    jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH v2 7/8] sigwaittest.c: Check return values of write()
 and ftruncate()
In-Reply-To: <20250726091837.493915-8-yphbchou0911@gmail.com>
Message-ID: <dffea510-0d4e-4bc5-0c46-fdcf87c897da@redhat.com>
References: <20250726091837.493915-1-yphbchou0911@gmail.com> <20250726091837.493915-8-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sat, 26 Jul 2025, Cheng-Yang Chou wrote:

> Add error handling for write() to tracefs and ftruncate() on shared memory
> to avoid ignoring errors.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  src/sigwaittest/sigwaittest.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
> index 026cc81..3944b54 100644
> --- a/src/sigwaittest/sigwaittest.c
> +++ b/src/sigwaittest/sigwaittest.c
> @@ -72,6 +72,7 @@ void *semathread(void *param)
>  	cpu_set_t mask;
>  	int policy = SCHED_FIFO;
>  	struct sched_param schedp;
> +	int ret;
>  
>  	memset(&schedp, 0, sizeof(schedp));
>  	schedp.sched_priority = par->priority;
> @@ -168,7 +169,10 @@ void *semathread(void *param)
>  				int tracing_enabled =
>  				    open(tracing_enabled_file, O_WRONLY);
>  				if (tracing_enabled >= 0) {
> -					write(tracing_enabled, "0", 1);
> +					ret = write(tracing_enabled, "0", 1);
> +					if (ret < 0)
> +						fatal("Could not write to %s: %s\n",
> +						      tracing_enabled_file, strerror(errno));
>  					close(tracing_enabled);
>  				} else
>  					fatal("Could not access %s\n",
> @@ -489,7 +493,12 @@ int main(int argc, char *argv[])
>  			fprintf(stderr, "Could not create shared memory\n");
>  			return 1;
>  		}
> -		ftruncate(shmem, totalsize);
> +		if (ftruncate(shmem, totalsize) == -1) {
> +			perror("ftruncate failed");
> +			close(shmem);
> +			shm_unlink("/sigwaittest");
> +			return 1;
> +		}
>  		param = mmap(0, totalsize, PROT_READ|PROT_WRITE, MAP_SHARED,
>  		    shmem, 0);
>  		if (param == MAP_FAILED) {
> -- 
> 2.48.1
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

