Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494F1CEADB
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Feb 2026 18:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771525132; cv=none; b=FanHv9Vy2u6TmuUJsYl3aMAcaNdkK0hznKw4zkPpB4P33s2nGCFYI1Fds8E/R+w0Cx4O9ReuDAru50KPpAiloVNCJgA2AGGzU6K2yTKquiNK4hcLPDDApJuYUON7QU4SuYyotXMT5Vd5cLsTC21/QDh446YjoijDBg8tItbhbdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771525132; c=relaxed/simple;
	bh=1rTxsZpNJFbo1oc7hR8HGKWuItY5iUg39+xH6Ty6KVQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UkWo14v3KDuFTP5eDFGUj0M2t9TngNP/YiWK993lhQcInh0zKLNXPVqaWBiDW2DW6CwATyWpZZwmhQwKnlLG2hwwLbc1CPJJ/wLKx5TAc3tfhXyD2+DeEZdqFDIo96n1nGFstWbzOs6KdXNbNa67UADgvbfrmdSS0BOwfBcXSFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAx1Uxcu; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAx1Uxcu"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb4097794dso125501785a.3
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Feb 2026 10:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771525130; x=1772129930; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ajZP0wCyMA1Cjhjlzfy9A+mz2813bO6ZG19STs00Fg=;
        b=TAx1UxcupiC90Dm7e+2M6C0Mf7pqSRaCKLffBUOfkpyNUtuL4sr/H8E0BnHHz39TSP
         IYF5UspumN2ImGxRUeJchoa2fr4v1raepxmUO3HjWAYVtQa06NW+cTXq3Cqca9d35O1J
         WuMbCddBXh2/t+uNhizAMMlwPStaIEWO6YP0ASBLMZAkvvMb4yPANUodbjh/U07Erl4B
         PzdsZgSs5aQYgxhG8uajoX4opxDRjXCPvsBICFKbvno+OKKmtMnp0OAuS7RfjWIG722e
         +lRNiQTaVt+9buNVNk9YmB6U0olXpqtpUI8oqXqvc446zOFQ2RulM5awwDIOGWw8+4cU
         6DOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771525130; x=1772129930;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ajZP0wCyMA1Cjhjlzfy9A+mz2813bO6ZG19STs00Fg=;
        b=f/DCxdURBMtI676T15LbeYCwFv4Qj4yG8spKbgxzQjy2O+Ch0ykvsHvbowQz0Qd5gB
         6UGpR535bJ/09NCT3KRWuw4yTUqLJIycaNfaZYvLDV7oNMgmCTFKfXZOhks6aKraNwmS
         2+m3IWZ0PtekgvP30ZDiIE9LoyWkLt9JhINImFHoXh4FLrqM8kssoP/VNL2voXdcFnsf
         9gccbcYaTrZS/l5NbYES2fzTnmaDzyunfJfjV+uoiuOhEI6Ltk08rOKdbYaxhZdDzhf1
         j8nGA8JvsC9+tzFnvC++sfU6If/PPTkpW6E/uz3pRwOYJ44JNXkZMO40y2fwBGn1jujP
         Fbsg==
X-Gm-Message-State: AOJu0YxCy0oNxmhyvXocCyT29IUdC5P9JuTHEWtE1QbhUWnXEhDg2CPu
	HAXbUjuy+Hz7A5Kcd9ufnXeKVC/cZJq754OrYfeCjW3APyU0ZbKcTVgk
X-Gm-Gg: AZuq6aKjuz/k/RvFsJUpiT+XHGikJyc6ltbYsiB7LUJRTGMy1z9O3TARLxD8eBhzNj4
	QcHohaxULcoTlqR/mRmAy/TIiycQLLWSUx7w+mv5Rg+xBJUyF17teJH8eDBtUXIuKj75rDNY2r4
	H2y5Cm92Ue8lqemQ7dN60PGW4fr+NcgAxq4fOEtDRz6Bnu5tyO814ULL6nAhrVhEDUoC8N9P2qj
	UY2rWOnoRoKyz77RxlJk6QsXBCmWXB9td0fkYNZh/cqF56mJeSdqWklj8W6nN7/zVhQjySc2U+R
	2YnKmqNJXl5W+5zSuhCYBNKqGq03QNI78YEz2x2gjByZ9gwq9E6DUYmkh+MRqbBaun9hAMWADsn
	iSikdv3W/yluaq+15L96pb/vU8aEJfsRCwF/VomMvyGtQh5A2XwZY4UiBDxCgASqqHWA4dQ5GTQ
	teeZShM5sWXc38X+oKKT4P60J1rEtknnRKzq0oTKis+bqE6SNzVaiif64En0qL3l3JlxzXiv3ng
	Q==
X-Received: by 2002:a05:620a:711b:b0:8ca:3c67:8914 with SMTP id af79cd13be357-8cb79f448bfmr550500785a.72.1771525130343;
        Thu, 19 Feb 2026 10:18:50 -0800 (PST)
Received: from Cumhall ([142.189.59.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0db51fsm2108792185a.14.2026.02.19.10.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 10:18:49 -0800 (PST)
Date: Thu, 19 Feb 2026 13:18:17 -0500 (EST)
From: John Kacur <jkacur@gmail.com>
To: Gabriele Monaco <gmonaco@redhat.com>
cc: linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>, 
    Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] rt-utils.c: Fix write() return value check
In-Reply-To: <20260212111342.71398-1-gmonaco@redhat.com>
Message-ID: <7d50c77e-de2d-1b35-c896-62fc70453a4e@gmail.com>
References: <20260212111342.71398-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 12 Feb 2026, Gabriele Monaco wrote:

> The write() return value check in tracemark() is a copy-paste from the
> one in tracing_stop() which checks for 2 bytes to be written. As a
> result, tracemark() is almost always warning.
> 
> Check for the write() return value to be equal to the written length,
> which is the value returned if no error occurred.
> While at it, add "\n" to the warn messages.
> 
> Fixes: 60d60540c009 ("rt-utils.c: Check return values of write()")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  src/lib/rt-utils.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index d800b5f..aa70c78 100644
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -437,8 +437,8 @@ void tracemark(char *fmt, ...)
>  
>  	/* write the tracemark message */
>  	ret = write(tracemark_fd, tracebuf, len);
> -	if (ret != 2)
> -		warn("trace stop write failed");
> +	if (ret != len)
> +		warn("trace mark write failed\n");
>  }
>  
>  void tracing_stop(void)
> @@ -449,7 +449,7 @@ void tracing_stop(void)
>  		return;
>  	ret = write(trace_fd, "0\n", 2);
>  	if (ret != 2)
> -		warn("trace stop write failed");
> +		warn("trace stop write failed\n");
>  }
>  
>  void enable_trace_mark(void)
> 
> base-commit: 4e68b52f0e0c9777c91088948374c6ee3d4a1f6b
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>
