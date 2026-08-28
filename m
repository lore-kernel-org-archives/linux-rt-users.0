Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A5345CCE
	for <linux-rt-users@vger.kernel.org>; Fri, 28 Aug 2026 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927227; cv=none; b=vD0FdZBjKu+hSZWyV471Qoq8BQuLIpnPaJjTqKTa+Q8pOzHHcrG71Sj2Yzztk73BlWg6Xd25bHFzH7E2ZAM2+0fUeuz8/KA1lDEObLMlt4eRI7ynUhVXZJP4qNKHkyXs9cCjDUokpHBZJ0mnVbwSWglR530W8ALPWRDYFleMRPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927227; c=relaxed/simple;
	bh=lGtOITKwKbt35OPLFPdvoDJ+3wy/VVirUoh1wSY9t5k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=K5mzY2D+90nusOkgNrgWTaRa7vtHke/bs0GaO85mHggW8fiQQeBEssumhHzoyc/Gut9IwxVgtPpR99/cpaiJQjxa9pO9+JWBhGBtzqjFOezQ9u8o12nyuQGaxw1kj8aELW1l6dFBejRoCGjVC0UhHNL/mDvxSkpdzKJEt14fBeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6RhHpal; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6RhHpal"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92ea24a2dbfso90635785a.0
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Aug 2026 07:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787927224; x=1788532024; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lOW/N6N6t3UElFoRPKbQsCa4mbADDfNoUSTe26bW3vk=;
        b=I6RhHpalTG4JoJMhMZiqjJ8N/EE5/Y7292tKO0jmsQQ4eUmEPNb6zkJhjbSxEES3P4
         UoTc1P4huqPgACF7DSaoYwvoRQbNJvPORxFNoQa/LA9lH/i94Yw6Lq6rjzFThi2WOnVu
         sf6P/B1XlSsGu4O1tnInx8MbSO4cN8YUgy1LHJPK6VTRhtZO/Z5kjujer3kTvBrG8pEl
         8WPyU1VWCAua7EBVPDnbpcoFaWdt8NY6a3n6n2I1C62lle3Fuv3VjAzqqxR4Ko8giHbf
         Wb2XIP1X92Eo1Rrq0m8+pNVvjB33Ljq0UDafjUN/ciIxjeJQFf72pPUmkA3UJ4bB/qFO
         CNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787927224; x=1788532024;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lOW/N6N6t3UElFoRPKbQsCa4mbADDfNoUSTe26bW3vk=;
        b=S5RM74ZBPrJiQaEKZzIkwtcAoWOx4AhSbMipohbFAjhdV7c3QzAj4jf6gMdtbadHbv
         +eSu+t6U27Eat1KLdopW+1aS1BzeIO1oSv+hxX8568rEmUei5p8TUmqSbgkaln251RFI
         sFl1GR4Is+EjjPII/HO3Xw8DjfJ/ou/IqPLUgiAhr45bOXSQgTlpKYEQ3hNrYvZzn7jG
         EoOqWYwT/QEty/8F1Ut8iFUwALYDdqe8oxaMPno/5ayaZkdObPPu0ms8WNCQX13sNa/B
         zx/pTKhnb5w0eyoVlytbVAVdkXXvbg5xYd6tcfmgI7En4Dz+5oGUpLs+zaVsvCnUgddu
         0KiQ==
X-Gm-Message-State: AFuF++lAJLK9NEnrP4BiaAHGSPfUK3iU4EzZUABOnvLaR0vEHRhW8Mem
	jat59O40/OosWO0s7yB+CQLakY16OrKA5zVW+fo1Te4zG8X+kgX0kwayEnlsIg==
X-Gm-Gg: AR+sD11VepE6z9hh1XAtcP9nbmisn2SsbIxTd+Gomt+kXDLqeOUmWxTBPltNabO9dqn
	9/zbuaOgsLBUoPmnA6K1wGwe6wY9G8xiYiiA6zpazKbe/Ucva7p8+KkSmJUCh3h5VL0DYy2caBW
	7+M90OJJg84KRNAohURLgqCMBHd8YaksvlPvr6UMNzfyjgdcoJxrmTxk6bQbpYs05XqcO0sdEPW
	Eu5wgrZSoV8hYaW8qmZcgC7iAQ4ye0fZPDPeuOxykO2dYidJbH9G45GOTAm35fn3anF7QcOLXtq
	jfOiWXyrNd2N3dZdc6y9Uw2iRy4pYmgyyxzBrTynfqlkLpYgXkXXHezrhdp1tunFBik75ihbAhf
	ZvdPaSpESUCb2O6JbPksozqcTib0eC4TMZd6hD4Y69fn15MvF46EVSdYL15tDAW22K7Vzlk3G9U
	e7Wia+QUheb8FBAZmUml8BW9JMh6MlZRukYn1BUA/iQTBno0VZVkth0pB2kPaz9vfgAjaDWicpl
	LqqXM0oFgWiYBf1KsZv162gCnUweasTlMyg
X-Received: by 2002:a05:620a:3c96:b0:937:690d:a37c with SMTP id af79cd13be357-939137b46a8mr580312285a.3.1787927223371;
        Fri, 28 Aug 2026 07:27:03 -0700 (PDT)
Received: from Cumhall ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939173e8e32sm150362185a.36.2026.08.28.07.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 07:27:02 -0700 (PDT)
Date: Fri, 28 Aug 2026 10:26:59 -0400 (EDT)
From: John Kacur <jkacur@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 5/5] cyclictest: Add a timestamp of the last update
In-Reply-To: <20260826132153.2476006-6-bigeasy@linutronix.de>
Message-ID: <f6692168-cc78-d625-f750-bf979be73dfe@gmail.com>
References: <20260826132153.2476006-1-bigeasy@linutronix.de> <20260826132153.2476006-6-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 26 Aug 2026, Sebastian Andrzej Siewior wrote:

> Add a timestamp once the the MAX value is updated. This is useful to
> figure out when a certain value was updated and if an update occurred on
> multiple CPUs at same. The output is seconds accurate, the ns are
> stripped for now.
> 
> I'm limiting this to the the -M switch, which I am using, but there
> should be nothing wrong with using it unconditionally.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  src/cyclictest/cyclictest.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 1cad1bf6b929e..1c14d13b7cd80 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -145,6 +145,7 @@ struct thread_stat {
>  	long redmax;
>  	long cycleofmax;
>  	unsigned long smi_count;
> +	struct timespec max_update_ts;
>  };
>  
>  static pthread_mutex_t trigger_lock;
> @@ -834,8 +835,10 @@ static void *timerthread(void *param)
>  			stat->min = diff;
>  		if (diff > stat->max) {
>  			stat->max = diff;
> -			if (refresh_on_max)
> +			if (refresh_on_max) {
>  				need_refresh_max = true;
> +				clock_gettime(CLOCK_REALTIME, &stat->max_update_ts);
> +			}
>  		}
>  		if (need_refresh_max) {
>  			if (!pthread_mutex_trylock(&refresh_on_max_lock)) {
> @@ -1599,6 +1602,18 @@ static void print_stat(FILE *fp, struct thread_param *par, int index, int verbos
>  				stat->act, stat->cycles ?
>  				(long)(stat->avg/stat->cycles) : 0, stat->max);
>  
> +			if (refresh_on_max) {
> +				char ts_str[64];
> +				struct tm tm;
> +				time_t ts;
> +
> +				ts = stat->max_update_ts.tv_sec;
> +				localtime_r(&ts, &tm);
> +				/* RFC 2822-compliant date format */
> +				strftime(ts_str, sizeof(ts_str), "%a, %d %b %Y %T %z", &tm);

This creates a really long line with redundant information, for example

T: 0 (36716) P: 0 I:1000 C:   1331 Min:      1 Act:    2 Avg:   12 Max:      
71 Fri, 28 Aug 2026 10:18:32 -0400
T: 1 (36717) P: 0 I:1500 C:    887 Min:      1 Act:    2 Avg:   10 Max:      
62 Fri, 28 Aug 2026 10:18:32 -0400
T: 2 (36718) P: 0 I:2000 C:    665 Min:      1 Act:    2 Avg:   28 Max:      
56 Fri, 28 Aug 2026 10:18:32 -0400
T: 3 (36719) P: 0 I:2500 C:    532 Min:      1 Act:   52 Avg:   36 Max:      
57 Fri, 28 Aug 2026 10:18:32 -0400
T: 4 (36720) P: 0 I:3000 C:    443 Min:      1 Act:   51 Avg:   21 Max:      
55 Fri, 28 Aug 2026 10:18:32 -0400
T: 5 (36721) P: 0 I:3500 C:    380 Min:      1 Act:    2 Avg:    1 Max:      
12 Fri, 28 Aug 2026 10:18:32 -0400
T: 6 (36722) P: 0 I:4000 C:    332 Min:      1 Act:   52 Avg:   49 Max:      
62 Fri, 28 Aug 2026 10:18:32 -0400

Why not strftime(ts_str, sizeof(ts_str), "%T", &tm);
This will still go over 80 char, but it's more succinct.


T: 0 (40468) P: 0 I:1000 C:    282 Min:      1 Act:   52 Avg:   17 Max:      
65 10:25:32
T: 1 (40469) P: 0 I:1500 C:    188 Min:      1 Act:   51 Avg:   22 Max:      
56 10:25:31
T: 2 (40470) P: 0 I:2000 C:    141 Min:      1 Act:    2 Avg:    7 Max:      
55 10:25:31
T: 3 (40471) P: 0 I:2500 C:    113 Min:      1 Act:   63 Avg:   19 Max:      
63 10:25:32
T: 4 (40472) P: 0 I:3000 C:     94 Min:      1 Act:   52 Avg:   27 Max:      
54 10:25:31
T: 5 (40473) P: 0 I:3500 C:     80 Min:      1 Act:    5 Avg:   43 Max:      
56 10:25:32
T: 6 (40474) P: 0 I:4000 C:     70 Min:      1 Act:   51 Avg:   27 Max:      
55 10:25:32

The other patches in this series look fine.

John
