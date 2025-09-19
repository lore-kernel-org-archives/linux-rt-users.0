Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C2C24E4D4
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758308058; cv=none; b=faXNqnD+SGEgqm9YBkCAEWPRPIAvTCJrbALGdpafmrQwOrN0QLLHt4FxAuubG+ilwBg9lbFiHFWQzaqKO5o9TFqAwjE45dC2nSjnyffKIX3XuaWXHuld97B5ufUWOhSoVGfu+iP/flvo4w0wHwgl0lzP60/v7uAJOq7odxxy4SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758308058; c=relaxed/simple;
	bh=F4sSf0FN7OzK0ofjoJWXb8AM1NfjhbxyUzgGBcUL6dk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZJY0iOZVwpFtZ33mk1OrVCY59HpjlJjsV38iwoKMMm/LxxAyhyfRHv60huu54/R9HSNcCMDGP/vwRL6QjSNS/gktCvV7WJ7xFr1phHS5otHTQEA85WCMi4P7mTlAHtXO4dGoGWGIJvRFXw/qTMhgMemo84M2uRobxNsXrix1Q7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YucNUJRv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YucNUJRv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758308051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QrtAxgPMXSLIzvBORxzVfiWbDF98SZkIwferOQ9DLPg=;
	b=YucNUJRvM1A/P9Zc9wVsu+FM1+cBoSymW0tkc52WFTwMFXnM4q8BqHs+kQi/Xbp68mwm1w
	sWNOD7OdjKqXQZV5acKwIV3euy/zb6szlGHSKW9fyk5LUmlpXX/oaR2WEJWukOpMxKBWdf
	nM3Krj/VDaXwyx5jMispizwQvf1VJeM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-ZFAreSHNOQutWBY5gZPTSw-1; Fri, 19 Sep 2025 14:54:09 -0400
X-MC-Unique: ZFAreSHNOQutWBY5gZPTSw-1
X-Mimecast-MFC-AGG-ID: ZFAreSHNOQutWBY5gZPTSw_1758308049
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b78fb75a97so26313021cf.1
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 11:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758308049; x=1758912849;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrtAxgPMXSLIzvBORxzVfiWbDF98SZkIwferOQ9DLPg=;
        b=XakDfF7hdJd+AitHAPjMc8MAqJ6pbgwISluNCsKFtFAHZNfVul5DaDx0RTzvGKXN2g
         SPVjJWG2231B63w6BCmrhx72IusfzlmUYq3ctDxZD8a2cHOcwQ2GLASim7lQ97xWV9n7
         AKYwGfaQVJeHxpnBUw+ocR7qd7pcpPgEsbfI0y+8sICthCVQeR2+Ls7E2GZGzm9YQDef
         MHDATDEe9lWoSV+f8krf7aHyPH2bkw0Sk56mU2aTPBJtRHbu06x+dozIH9qQSd3fU0BN
         YY0tNTCbXqH8TpmGmMYEVlF2gxLacq4pcP368nnTuK6zsF0qMXiwqArT5Dd+0xx8yha0
         BfaQ==
X-Gm-Message-State: AOJu0YwDfOK7NjuQIS8psddF9dLwtdzGmGyTDyghwJcCCgY1lfHNQVdD
	bVCG00EaB358WSmAKcgCR8L3n+5X9EPKoka5aoj2s+81Sg1caUGi07MDYoJ3xjQdePIcZvCwduT
	cJzicT09Pu4ghqHxG/iHVU2NbkXgng/Qk5MIEM6k+QyJKRpFG6FzX1ukjh+SHCsVPLWxu
X-Gm-Gg: ASbGncurDnv75Z69/dZKw+ebgan0tiAS4VIhAWySalv6zsd2QhIHMJ/f4mTvVa4daRT
	Hhij5Rbe1vBMUXzV9el5u7XhLchwWm1vmC8+19We47PoU4VSW+dEpCNoDyyUZW+iTFJ9MyKEvdM
	20Aw+1wRHei60f24sXwWoRaNXSmQLGXMq6OSNKJD1Gq61OeITCYYoG/wmCtdNJlbO7xh4zDcxKf
	Go33kQoIfg3j9vPMHKHz3tOTBoxkkn5nGQBXGnuecmK5BROmLP2bA77VQQIS5ON01jbPYYUGXky
	AUcqUTDHL29r0rHRsJHnObZtWV9nWMLNFIYbo59aHWNttBXPWDb/+7ThDU3XuSGdlrjqJV2/nLz
	E+2VTHWgdzqs8
X-Received: by 2002:a05:622a:1794:b0:4b7:9c5b:8d13 with SMTP id d75a77b69052e-4c0752ba01fmr42440961cf.84.1758308048621;
        Fri, 19 Sep 2025 11:54:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG634d3uUr2iBT8Xswo82FYnuYfm2SlsBmWc3f3gF52kYNKf7ofCFnNkJt/SxrcI6YQ+Sx3w==
X-Received: by 2002:a05:622a:1794:b0:4b7:9c5b:8d13 with SMTP id d75a77b69052e-4c0752ba01fmr42440591cf.84.1758308048166;
        Fri, 19 Sep 2025 11:54:08 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0604w-grc-05-70-53-55-167.dsl.bell.ca. [70.53.55.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836332662c4sm384768385a.60.2025.09.19.11.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:54:07 -0700 (PDT)
Date: Fri, 19 Sep 2025 14:54:06 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>, 
    Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 09/10] sched_deadline: Check the resulting size returned
 from snprintf()
In-Reply-To: <20250903111717.1391196-10-bigeasy@linutronix.de>
Message-ID: <ee1329ea-a073-0401-c828-5f489a50b753@redhat.com>
References: <20250903111717.1391196-1-bigeasy@linutronix.de> <20250903111717.1391196-10-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 3 Sep 2025, Sebastian Andrzej Siewior wrote:

> The code simply assumes that the built path does not exceed MAX_PATH.
> Since the previous change the compiler started to complain but I don't
> see a connection other than the removal of one find_debugfs() user.
> 
> Make sure the resulting path is not truncated.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  src/sched_deadline/cyclicdeadline.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 82e640409ecef..89b7c0b8deb21 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -160,12 +160,16 @@ static int fill_sched_features(char *path)
>  	if (strlen(debugfs) == 0)
>  		return -1;
>  
> -	snprintf(path, MAX_PATH, "%s/sched/features", debugfs);
> +	ret = snprintf(path, MAX_PATH, "%s/sched/features", debugfs);
> +	if (ret >= MAX_PATH)
> +		return -1;
>  	ret = check_file_exists(path);
>  	if (ret)
>  		return 0;
>  
> -	snprintf(path, MAX_PATH, "%s/sched_features", debugfs);
> +	ret = snprintf(path, MAX_PATH, "%s/sched_features", debugfs);
> +	if (ret >= MAX_PATH)
> +		return -1;
>  	ret = check_file_exists(path);
>  	if (ret)
>  		return 0;
> -- 
> 2.51.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

