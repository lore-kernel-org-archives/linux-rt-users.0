Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1B422A4EB
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758308155; cv=none; b=Vd622l2rJ91ahOL9j54MU88Y1/3wB3SJ8BkCznxxE0ssP+Du6GIujdtSu2QXg6mDS8ovBJCJKgBgUTTVEBIM+gvHRxcJoG8L3Rg62nuVhcwxuRW/xMNFIAODWodab4aq2MPG8ClKW66VQcu1x8S84NgYPxJ7fvpsrX4AP9NdC8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758308155; c=relaxed/simple;
	bh=QcTbSVJXkR/xYCVAsVSswA4J0MnptG9VWnQhjJF91JA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZpM7tC5vok5f3aw3sPl/434UMhfRr6EZbq+jhRR8kq1rYUauw0ofaPTbmAZAyUsfFEa1QF2txodG3XN1dwXLXxt/yiqMl+4U8rLhmAGQumwUlQE8n4yl0fGaeDi8JSpibFD7XsC01Nmg3GsFOykuyBw04xI6dJEmaEuaEs0TTKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LB6NlQHM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LB6NlQHM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758308152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=76IDZszVI4CmORf0lM3qqzvOI5+Kke/rvj/Jy35tugQ=;
	b=LB6NlQHMawQ3lF8tlSnqFg6wRf84CDkT/J+5MybZIf8T6/oV6UWapoJnOR83nY9GIqqixL
	OWeIGhT108yhWopcnZKn7Wnu/nF71WZ0sKXNYACvnqAlN3k+Fma83jOPAk9Y0O2jrBP1Ao
	XCtGWXdrJ+hJT/+RJXgefvmcXL3TH9E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-tgelu6QuPhOYBrzi16nY0w-1; Fri, 19 Sep 2025 14:55:51 -0400
X-MC-Unique: tgelu6QuPhOYBrzi16nY0w-1
X-Mimecast-MFC-AGG-ID: tgelu6QuPhOYBrzi16nY0w_1758308151
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-79a3c16b276so21251806d6.0
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 11:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758308151; x=1758912951;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76IDZszVI4CmORf0lM3qqzvOI5+Kke/rvj/Jy35tugQ=;
        b=pamTlcLUNQeq2XpE/RdIhf3HjRWCZVBI7PUNx9nt8lRNHv1g8woOgcWRK/MvFLrvQv
         U/fFQxsKm+EoMcmQ7qNwXm2AEJoS3FJy0KUnHLnqKLoH6U9cZ9khmwuKrQyxiijnEAZN
         epKRCFo5ewuBzAyYne7El674H6eMqSdfh5Oi3zeJnqZt73Ja3G14W8uccAraP3YYJW0K
         APvTDoU0XZX+27dzLG91vVPvTycnXP51QzRrEQ/IA/Mf1CVJdcNhhL3KLA9A3UsIh+Cb
         1b9pd54f/MdKmI4owlzBeqkGKtomsgSZHXfcCtvxrK405TppfYWAVbfPmDLaO7et144d
         ggPA==
X-Gm-Message-State: AOJu0YxbzLCNQLR/4HaVK3IPvv/E8nl5tgq4HqARO5ltgCk9aJD3SgKo
	p/T8ts1LYMoDzRiZQdtaxJqPgD/i/TSc5SfpbfSJiPnpwHIPYr1DkGW4qKNtu4g02kV/BtzYwmJ
	C2Dlz6TYKlFKrOSwmP4SS7/DuCibRS4JkUPACc50gMljVR6CfcEgGI0O9spDxuxYq4qy3BS5VZs
	I8
X-Gm-Gg: ASbGncu0+C6G5+RupITX/wsORWPYins8ZmaktJsXGV0S0TLk7bJW0WHLefPhIe44ndi
	8w4K5elXVJ982mJqQYEwZwmgxIIx7m/WAkqEwanv7LlMjHnX0y/rMQpPySyI+lhgzBaWGzmi+8c
	eCABl3coDXxRyabi9Xj7/KKgd7yNp9a1CxeV2dl9a32RRMraCHy3wD8XCcnSsW1soiW1oBGUVWB
	wqPma9U3fzlh49zGTBd/hlT6ij29ZVSogRaCjAI+dTzvCRq3E9Tnp0Fo53UNMU4EHJKEUWQsGrk
	MIrbneYvUoAmA8wGo2l3NIEYsaFOQmrfhDfUWc+FMp/j5/ZwSKWMmTlg6mvJ+FUbtGtXU5+VW2P
	7iyWsI3Us24R9
X-Received: by 2002:a05:6214:2626:b0:782:1086:f68c with SMTP id 6a1803df08f44-7991d54f9f8mr51031776d6.58.1758308150812;
        Fri, 19 Sep 2025 11:55:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5X66nvODTfVMyayNQe02t5/pd1G85EnZsI/99oe4ggaX0xb/8DjRrHvxpZygldaxMnD+Nqw==
X-Received: by 2002:a05:6214:2626:b0:782:1086:f68c with SMTP id 6a1803df08f44-7991d54f9f8mr51031556d6.58.1758308150305;
        Fri, 19 Sep 2025 11:55:50 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0604w-grc-05-70-53-55-167.dsl.bell.ca. [70.53.55.167])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793548c63desm32963946d6.57.2025.09.19.11.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:55:49 -0700 (PDT)
Date: Fri, 19 Sep 2025 14:55:48 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>, 
    Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 10/10] cyclicdeadline: Don't test for
 /sys/kernel/debug/sched_features
In-Reply-To: <20250903111717.1391196-11-bigeasy@linutronix.de>
Message-ID: <9f32f0e7-cc41-9f1f-584e-e8c84930ff76@redhat.com>
References: <20250903111717.1391196-1-bigeasy@linutronix.de> <20250903111717.1391196-11-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 3 Sep 2025, Sebastian Andrzej Siewior wrote:

> sched_features was renamed to sched/features in commit 8a99b6833c884
> ("sched: Move SCHED_DEBUG sysctl to debugfs") which was merged in v5.13.
> 
> It is probably okay to remove it from the fallback list.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  src/sched_deadline/cyclicdeadline.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 89b7c0b8deb21..4ee3717a767e9 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -167,17 +167,8 @@ static int fill_sched_features(char *path)
>  	if (ret)
>  		return 0;
>  
> -	ret = snprintf(path, MAX_PATH, "%s/sched_features", debugfs);
> -	if (ret >= MAX_PATH)
> -		return -1;
> -	ret = check_file_exists(path);
> -	if (ret)
> -		return 0;
> -
>  	memset(path, 0, MAX_PATH);
> -
>  	return ret;
> -
>  }
>  
>  static int setup_hr_tick(void)
> -- 
> 2.51.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

