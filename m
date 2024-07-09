Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A8B1AB8E0
	for <linux-rt-users@vger.kernel.org>; Tue,  9 Jul 2024 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542399; cv=none; b=tQZIubIR+3W6G9DNcd78cmg0TCoOtgIHA05lldubMmE2Dv1QxMR661Vva79PxnXCStewosSJzuh2q4gHuUMZMIBdtNxQXtojyEdtxwY3QHQLd3pL6pQjhE9eMk3yPYbthNtinVwiCJBKs2IKAJ4EL8OO1Kc0QJ+UPlBmY+xd8d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542399; c=relaxed/simple;
	bh=+7dYzVZOtskswlcfvivqVcHN/JLtfGgopmd8TB6xuSk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Rov6/HgFkqrDAYAzaeYMSx8SckZCaqs6249BPRy7AY7IvWRzUsc3DgzsAxBMoqep6Gs0cU/BvmD8PCrkTlPFuKT4ij75TzFmYC8JIp91RTo5xd3UIv8wLZ/wdIK949MTlae3mwNOcZzWaO9fcQyeMtyVbW+A2bDt23g1LVmE5/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e5rKyOyM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5rKyOyM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720542396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9lvWn/uADiblZis5I9umfk38K2CSc+Hur71VWqDWQAU=;
	b=e5rKyOyMmSdpK0f0CcHYR0qtTrPp+8ubtJVGwgXuiljLBhrR8S6hj7ZGUUw5XKdPbop5oy
	ZbWKWueYvmxqZKyWdfj/s/j3kMrdsM4Yv6FARd6TMhh5n4VygTCUnIYxv3uLLJoaJFuFfe
	8j0aHNZUE+17aYbid+6gTJli7IrXHjw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-JGr6wTB2MFG2U69TdqZbyA-1; Tue, 09 Jul 2024 12:26:35 -0400
X-MC-Unique: JGr6wTB2MFG2U69TdqZbyA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-79f0e024ae2so264534885a.3
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Jul 2024 09:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720542394; x=1721147194;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lvWn/uADiblZis5I9umfk38K2CSc+Hur71VWqDWQAU=;
        b=D+Q5+u+ij83N7+IJq1pmWu1QBtYWalHc/Ln60rBf7ulkVGED5zCvAJpf4OeoQI2xhY
         lX2rUpJBNzFzHh/ClhNWNilDVGRLGDxgp7p924a1MNu14zdRJamCrYW8wVSjmpzjS8WX
         Bh9a7IZCxBFTao6SMvKzRYcxuWz37yU6T31l3UjFjfwRGXv7bjRFPenVxYSuRrmQI4vj
         mkHruVTA/vW1K92mi9ANfYkF6kXxb2iflsvCQ96/S0rS0+8WV/jxMgy/NoShSMGLu1xX
         sOUsydG/bC2GMcnjkt86eP4UH2mkmQ0Y2OMCwhoh7oUrJy9f9BhoMiiYy3JHvuJf2ZUJ
         FOUA==
X-Gm-Message-State: AOJu0YyVuPMqEGRE839e3C3QkGR+w6AzQ47Zq1UVvNZZr6jWS0CT60Bq
	YYT9u9yUxnY8wjhaEwFD/emrWrGvvqqiHLuOHiMDxGOMIoaempH2G4mDj3LfE8hwzOR46drZr91
	7VNMJ21H+xW1zV/2k78psqq2FZXl0MheC6VZ0u0HNHs3z+y1XniSoMwmxRwt26SKP
X-Received: by 2002:a05:620a:4150:b0:79f:87c:a540 with SMTP id af79cd13be357-79f19be6361mr441377485a.58.1720542394658;
        Tue, 09 Jul 2024 09:26:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcm/ArjfOddmRHFJgkUfBJJV2P6Hl9XDsXfE2KPytKr8nEYIyTth5RGNScHK36I2YA42sX1A==
X-Received: by 2002:a05:620a:4150:b0:79f:87c:a540 with SMTP id af79cd13be357-79f19be6361mr441375885a.58.1720542394358;
        Tue, 09 Jul 2024 09:26:34 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-17-76-69-33-221.dsl.bell.ca. [76.69.33.221])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190aca68sm110048685a.115.2024.07.09.09.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 09:26:34 -0700 (PDT)
Date: Tue, 9 Jul 2024 12:26:25 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Anubhav Shelat <ashelat@redhat.com>
cc: linux-rt-users@vger.kernel.org, kcarcia@redhat.com
Subject: Re: [PATCH] rteval: fixed manpage to include stress-ng header
In-Reply-To: <20240709142515.354997-2-ashelat@redhat.com>
Message-ID: <7568cddd-183c-b709-4551-93d429bd0902@redhat.com>
References: <20240709142515.354997-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 9 Jul 2024, Anubhav Shelat wrote:

> Previously stress-ng options were listed with cyclictest options.
> Now they have their own section.
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  doc/rteval.8 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/doc/rteval.8 b/doc/rteval.8
> index 264bf5207716..b818cbe79762 100644
> --- a/doc/rteval.8
> +++ b/doc/rteval.8
> @@ -138,6 +138,7 @@ Send a break trace command if latency exceeds the given number of microseconds.
>  .TP
>  .B \-\-cyclictest-threshold=USEC
>  Exit rteval if latency exceeds the given number of microseconds.
> +.SH STRESS-NG OPTIONS
>  .TP
>  .B \-\-stressng-option=OPTION
>  Pass in command line options for the stress-ng package.
> -- 
> 2.45.2
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

