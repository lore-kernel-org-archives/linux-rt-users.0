Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7324015278E
	for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758907022; cv=none; b=H5iSEp5Kp7zkR0O8+FKhoftU3llTZWWWur7kN3rX5vza3PA35EzhNg03+xBfVpdFF9HozLLYwDFZpTxpkbvqkoJfSGQ0XAF3o/maRQUEtWz6uduBN6F5s0NRCwToIjjg1SfZG51tKu6PORtpDeEVUQ0E1F8etwRK1AVzoIOYvqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758907022; c=relaxed/simple;
	bh=giiIVNjBQDci0++ll0l+2lSlsUqzhAlWOGpa2KhFgyU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WELk6D+hO3fezvbG/BSrzv3uMUr7p9jDNNrjFPklciXs+/F2SZbfj4UQzdGfuCeGglacVis6TThJm2Vynm52QtWWMvpoIZcF42m2ppHEfKAyaZMJlwWvh4Agz6UgpkCgmaGDTBc7hbVO+DaDPeSY9NI0Ja3+O80nhgx+MlWv98M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X9yx6Vpg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9yx6Vpg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758907019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2J2eyfvUb5mqlckSdhPK3o02GWAQ1uSy3Rla6FpgBlA=;
	b=X9yx6VpgvMuJqaJhp3Fx0aJlsV8ZWXkLgxDceJsGiLdeHqNEXhaCK7jSXAtphTf6+LiMhO
	eZBWfCGfV+igjbStJclCIKmMVI/JBw3KzwVgv2tUdaXmkTet88sy6VN8Z3HI5kPx1SCkBH
	EvypLvr9L95SSm2AR1sw5NN0/CTfQsc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-AONKa0fmOZOOep-PC0Jdfw-1; Fri, 26 Sep 2025 13:16:56 -0400
X-MC-Unique: AONKa0fmOZOOep-PC0Jdfw-1
X-Mimecast-MFC-AGG-ID: AONKa0fmOZOOep-PC0Jdfw_1758907016
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4de801c1446so11669481cf.3
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 10:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758907016; x=1759511816;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2J2eyfvUb5mqlckSdhPK3o02GWAQ1uSy3Rla6FpgBlA=;
        b=og3IMtUCe4Uz2Dl9SYQ6Z1sBtUcEaZSHUeUWvm++BcN6Vcxwwq57uOmRophHOqJlbE
         t4s/5JS82KORSxh5pB/9kdub3ZO6Pe/ygU3AYqGf0tUfN6N0ogYFs1O03S0mcCcs0rMb
         6yRsCFJRTDfxQ758MWqerShee1pH2qEqg7dEeKkpLOy3TsFjul696t1nRb+t2NJ9EZGj
         fDW9sCEm+S7ex8HMDUhnwkM2mWCmTrsHFdKZkLv76qmWVN6GQuU+OfSwLvNCmVQymoHR
         EU+5rKYCGrhMp1DR/g38Rgf1bEpU43OXT+DJj/0e7KZEC83c/ahoRJRgl4QektDP4zOT
         b35w==
X-Forwarded-Encrypted: i=1; AJvYcCWogAxBH+PSvL6ctIgpC6MCSBCRRpPIQAow/C+khIHEPK5PtS9BOYvrg5h8XTaxcR6Wr+JKS+Kqj8Ino2C1uA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwUKurWQ2/qJLinFBCLclhL/8xWa9EWw0BEptKGtBJL8pRe8RD
	7yFAUu5Z9bqQSbA34lNi4os/Kx67G+eatGilMF+j3yT/GH0TDOGq5n+oNTHjbttYnBK4LxlHplr
	yuk5bGkSSkQE4A61iNqO6xdn5csZacIReSqjEPDs4NkUlTrNXsGLAD250rb6e8hAa/MCv
X-Gm-Gg: ASbGncsYz5A9v9zFoaGKzyM9AT2exYCKY+YAQwSdV7tE4JBHjt63noPUGetJ5U9ZA1C
	HoTXZCKqNCaAusib+7GMUROlzdP6KBya5DELr2RuXbE1YbVxhKNIQiT3GAIcTfuql6ULnVFFqD6
	GrUkLlqIEhaAGh2icVye+gSlsPcGyv08VVFgraYvwNMTRC90gQxj/fqtrzueDzb8oPaIWIkRKcU
	sl+rq/SxaXDIC6mNlPYt29sYhRX7Ype19S1Y+74fv+43hUVaHMezgT9fIVTjeMXECoD6R60ftnh
	Dqz0Mn5r5ZH3kQTv8dm4paw5kw==
X-Received: by 2002:ac8:5a0b:0:b0:4d9:639:e9dc with SMTP id d75a77b69052e-4da4d8e1a79mr121723351cf.84.1758907016196;
        Fri, 26 Sep 2025 10:16:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJTwiltP4+BitPJ36rr0VHv0gWVLMN6k5xtVF8Q0pgbZwohXLcFm+AHt9+TNq0lWmn4YkKmQ==
X-Received: by 2002:ac8:5a0b:0:b0:4d9:639:e9dc with SMTP id d75a77b69052e-4da4d8e1a79mr121722891cf.84.1758907015754;
        Fri, 26 Sep 2025 10:16:55 -0700 (PDT)
Received: from fionn ([70.53.55.167])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db11cd26ddsm29636431cf.45.2025.09.26.10.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 10:16:55 -0700 (PDT)
Date: Fri, 26 Sep 2025 13:16:43 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Derek Barbosa <debarbos@redhat.com>
cc: williams@redhat.com, linux-rt-users@vger.kernel.org, crwood@redhat.com, 
    oleg@redhat.com, shichen@redhat.com
Subject: Re: [PATCH v3] ssdd: mitigate tracee starvation
In-Reply-To: <3yq34kwrfmwvhy5la5wutnmbdd6pf4rwnvnvnapegvx7acq7xu@pghcpahcvndz>
Message-ID: <f39ff2a8-452f-8239-2809-0b30ca67eea9@redhat.com>
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

Signed-off-by: John Kacur <jkacur@redhat.com>

