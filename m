Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201FB258ED2
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307177; cv=none; b=Tcpj1Kn/+sWfm3zsLyQwSEhDAhW1zAOOrjDiTF+HSwqOaX6M7ehMWAmr5lg3xetlu/blNCtZAl/bZTursifKbzsb26zjNY3+HySZTsePDin/b+hMrTyiI9FoaRs8aH22qMXySo4lJHt6SV9zf5xUORAn9UctG5aO0Q+jpMrQ1mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307177; c=relaxed/simple;
	bh=WlJ2PsO/UCNntlOsm2zxreHMo9TsfpGcgamm8ry3p5Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dTy4VDNOIJChTVmLuy3x10N6uL74QoHHI5TgPxlYyeQF/FR3g9VMhB4I9KehG/+6XlwsdH19JmneFBw0TTLBMqZV/yIzMe+UX3W2IGmvYm35yrgcSES4jRZkphgPDVH0aBiidyX850ASJxxImndMuRhdXXPoLvsQPWPUvBndm4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=brPnMAM0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="brPnMAM0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758307175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QzBB5mP6pp5mXzdi1taFxt3sW7898zhXjYJayCaIOGI=;
	b=brPnMAM0G/Ih8I6HW7fdCyZZ+PAfALiRiZcEj1h7nVwNwH1RN4hGKeRGcIg5BdGTS6bbGh
	zHyVv3R/qOpTkPFYCw1hZT9DypgN0iY+2ChvV7ktZziyTFC3MLx/g60k8CG1ZXo2R2TaO+
	9bk8WdfSn6rbCAzdCVq2Ex2rg3IazVM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-Mz47bn3YNzS6-N-yQtL4rw-1; Fri, 19 Sep 2025 14:39:33 -0400
X-MC-Unique: Mz47bn3YNzS6-N-yQtL4rw-1
X-Mimecast-MFC-AGG-ID: Mz47bn3YNzS6-N-yQtL4rw_1758307173
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8271bdaccf9so260786985a.0
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 11:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758307173; x=1758911973;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QzBB5mP6pp5mXzdi1taFxt3sW7898zhXjYJayCaIOGI=;
        b=A0zbcW4TC2uQjOwgWDjwqcWQNb35B4oMcTxq7shgPUcNSq+a0PCy/VYzVgSAaYV2yb
         jDZHn/5JvxCNzHCpXNemNx9ugIM2zc3HEOBXfBWsZEOXVKOQ3iy8fBFtRtGEGp9W3hJy
         H2+I5auzdxT2sgOfoJzBLxl2ux2gZGJ72M5SNv0JOTtoDKRLBmOl7cYN1ilN8cz16WCX
         pMAWJ8Ef3HhKjNZZ9mhRlGQu2i/eEcE6MhBP1k8d9rhW9QfKG7xcrQ54TZFqQolKi/jl
         xAJbVWvK2Wf3/pGfNX8NzRE951feYO4AiGnKoznu4GkC+f3NS2m0G6dxJpL3FpN7mgSf
         oOCA==
X-Gm-Message-State: AOJu0YyQiP6Oe88pKgfuSjt/ngtNb00zcieuL4VXHrruQix18eVEpuEq
	q28DozGBsab3gFuhSwHkxvL5hJNNwYjvwjnfdwSHxlbTtOMfRAnJcdEpBWrAlML0k1TU+HdSqDm
	azeHMD38SuSCzM1kax/ORhc17gzwB0q/K5Y7qpPWqEb5am3HMtdRt2GNqveelhQeSZPwJ
X-Gm-Gg: ASbGncs5Q8XJxXVavPD8CXQ/ZJbfH3aQL6iSGCycT0VIk/eNdOJbUZx7lXnUaHmebqg
	NTqMs8K98MzES4ZaV/5uay4qla7xaj+97lFKFbssVXfzrKelgkTJxhLlogxu41MLsYLcIPqh7Ik
	otUrINhWgFqB3E3n6hDW/C0sNsA9J1aM337X5Ze/M+SQWvCg3fizbVMEM53c/ink/xl8FzeFuHU
	C5VGXIuJsOwEu95+R0O0w98GF2+se0r2u7I2MofqhiabtFGzDsJQrwxpQt7s+XBLcctMcQtjgk0
	X3MZ14XkDN0eidBxD+0VOan8gmTbHYg3hq463ZG1QRX4M/m4Ibx8Pec1+UjDrXlvD5v6AhpqQlH
	bSHUKi3tUZTqp
X-Received: by 2002:a05:620a:4495:b0:812:d7b5:b156 with SMTP id af79cd13be357-83ba494eaa5mr493640685a.34.1758307173347;
        Fri, 19 Sep 2025 11:39:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3D7B2SAd8EZHbpumyo5JB9qIB9Xb4+ItdxgEeIdFQ/EtnXMbw3uREIKnJN813XLX6Wpr3ug==
X-Received: by 2002:a05:620a:4495:b0:812:d7b5:b156 with SMTP id af79cd13be357-83ba494eaa5mr493638085a.34.1758307172944;
        Fri, 19 Sep 2025 11:39:32 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0604w-grc-05-70-53-55-167.dsl.bell.ca. [70.53.55.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8363198b0fbsm374959685a.50.2025.09.19.11.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:39:32 -0700 (PDT)
Date: Fri, 19 Sep 2025 14:39:31 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>, 
    Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 04/10] queuelat, rt-migrate-test: Use tracefs for
 tracing
In-Reply-To: <20250903111717.1391196-5-bigeasy@linutronix.de>
Message-ID: <3b3623d2-9fc3-a04e-6cf2-397ac9957e19@redhat.com>
References: <20250903111717.1391196-1-bigeasy@linutronix.de> <20250903111717.1391196-5-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 3 Sep 2025, Sebastian Andrzej Siewior wrote:

> Instead of looking at all possible folders underneath debugfs for
> tracing, look directly at /sys/kernel/tracing/. It no longer lives
> underneath debugfs.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  src/queuelat/queuelat.c               | 2 +-
>  src/rt-migrate-test/rt-migrate-test.c | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
> index 28cf7abe83ae6..5a3d0c61a3fc4 100644
> --- a/src/queuelat/queuelat.c
> +++ b/src/queuelat/queuelat.c
> @@ -331,7 +331,7 @@ static void trace_open(void)
>  {
>  	int fd;
>  
> -	fd = open("/sys/kernel/debug/tracing/trace_marker", O_RDWR);
> +	fd = open("/sys/kernel/tracing/trace_marker", O_RDWR);
>  
>  	if (fd == -1) {
>  		perror("open");
> diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
> index 8afe0834905bd..ccc2caf77d735 100644
> --- a/src/rt-migrate-test/rt-migrate-test.c
> +++ b/src/rt-migrate-test/rt-migrate-test.c
> @@ -39,9 +39,7 @@ static void setup_ftrace_marker(void)
>  {
>  	struct stat st;
>  	char *files[] = {
> -		"/sys/kernel/debug/tracing/trace_marker",
> -		"/debug/tracing/trace_marker",
> -		"/debugfs/tracing/trace_marker",
> +		"/sys/kernel/tracing/trace_marker",
>  	};
>  	int ret;
>  	unsigned int i;
> -- 
> 2.51.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

