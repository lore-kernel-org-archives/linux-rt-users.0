Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6176D3F412D
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783675890; cv=none; b=gWtIjLdzM/5TRAElREJnO06q6d2Zdsu54jcFjtg4qhO+sKihxV40/nG+xwPBSv1mwart0UfpoxRFGTKlDfpoC+SctVsi5mJSZvFNQ3pgDHWh4uPmRvc1xHI6Q4Xdx1PVLFcY1UACxJRJglwj2tOfqPaM3v2URHm7syJrjQTrDUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783675890; c=relaxed/simple;
	bh=GRombGaF8HtL+INhL6PGaa6Y/1JBVI6n0/XupX+ZaIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/FcxAMFqXZBu2yOEW7xM/lcWC6QhUUJGs2ltmwwMvx0PQNCy822/BQfovdnCH//wf1Pl1rmopWaCTpnCXRFueoUhgsIDWbtbS/g36iR6FJi2O916JGH8LwO7qqyr8mSWjQSUjfesY2GcArwbDZOu15oWJiP+rsEm3Y0bJ76XP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V8gJ3o4k; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mlCGv7fK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8gJ3o4k";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mlCGv7fK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783675888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dlk5gE/7VVmii22IJ3aIscZEZNPF1ijvtGYlZvlwGZE=;
	b=V8gJ3o4kRQNXQCC2Ps2b/0YyIXXOHOZP8cMUfTiySIu04zgaf0jQAnUuLFhm9L/V7gZIjS
	h7U4rwm00rn/ppWEKLcMMz8+UTnQU7UANJsjf1yE/IQF6l1bDm60FZJFhxSAxqheShugv3
	ggmIqR3JS6syWX+Y6XzIQNH8i4ANbrk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-iWuBLegHNM6u4nXBPycb2Q-1; Fri, 10 Jul 2026 05:31:27 -0400
X-MC-Unique: iWuBLegHNM6u4nXBPycb2Q-1
X-Mimecast-MFC-AGG-ID: iWuBLegHNM6u4nXBPycb2Q_1783675886
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4729d2a64efso1034123f8f.0
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 02:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783675886; x=1784280686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dlk5gE/7VVmii22IJ3aIscZEZNPF1ijvtGYlZvlwGZE=;
        b=mlCGv7fKMCUjO5uj6SHmwySnvBpcBSMFmdDpmHAE3u/ZLcdTtD0mmP242zzFlhGQC6
         /wjLCkjAqqadU5iAOxakee3fmKEZX9PAGD3plRlFIQ/IrJkFnpJYTi0M4WqjotVoA3oi
         TNMQJKj+4qJTX70f9o622tE1llD5tHLZN79ro+uRriAgzard0Wberx/jMvAAy5vbEQfs
         aFfSZKX6JWK6eHh26p8m6gVdXpDMnpHN+FY9165vlEInPbj31lFDH1PC/8WNY47h0lAx
         ooTdcGgSf75k3gQkjDT+CtoNbYMTVqDijOyD+2czzv/bvEQtRxRtkQdljdZwaFFPYP2N
         zKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783675886; x=1784280686;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dlk5gE/7VVmii22IJ3aIscZEZNPF1ijvtGYlZvlwGZE=;
        b=CpOr5TzCX80x9GfKidQEq+IYfAC+sZDCdxdjw2znGaayUh+27SyJTvygS0lAvnKgGu
         Df+u9CN1A+1Y6v9yeOMtUGwH6oT0IUlj9lEWi76OPLzAoJAbtf9qVh1Rp+NSIDl6GZdB
         hFQI9JPg/zLbUGAMRBbeAnCf9FC3tQTNg2IyOFLMRT2zEBbDhk1asJkT2h4aQFlyHXY8
         oLA3MqPyeruL+tUkgGuwatXYCtrIwTDRw7pRj/zdL/mw9O1PyMKB2NWDP5Bn5OmzmO43
         MydPStfiqh8vaLOGbbCIuf73Gnwort+8yX0WqeGEH4JxCMEdzpKYtlt41CcBzOqAmA0y
         jDVA==
X-Forwarded-Encrypted: i=1; AHgh+Rqf0UQmLDtQjupr7749UzvfBrXitluTTRqITzGEn+oNT5zF8ckYuTB6dxWNtiPRc/FcAySLu969Xr0PlKj5gw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzD2782p310BdkgKBfVCIIVpWbQraVxzDeZCFkCt4Mr2EvS/FzL
	0RXm2v6RdHG33WC8qqEjHZxtwpUarboCRIDJXtB7pVYc31DdWtVGx/hggz+zAX07X2ndipS+7q8
	Ca/Y+wyAW+cKjXX5rXrmyaALNH/U6YH1B9nZKUL6sKmq2kM6HPma6Obv2i6Oe1U/hdpPuzQ5kwD
	2t
X-Gm-Gg: AfdE7cmP+Xb3uqd3UNaQ0tKUgJr46ZS6rbVm2QAOV6lVR4qLd3CfkuM9h5RqjE81vE+
	AjyJitQsVQWKZVXVozf+cIUCEMv57Nm1hUNl2QdIlq5fnlWiBVuvy72FGoCWcz4gJtUYk5OQqhG
	7evEsfq5vWnXqBJe6XLf9rtRsaDZdVavNaW8dIlBfOIF+HtscgU/+jgRylPtBsRyoiyuTXYUn7P
	ARZzzW+qiBBDm4XwIpZZVIstT9lchc/bXBBKnAAW1lMzw9qGZJuoLdFPcxmX77zTX4opMG0t4YJ
	ZIzjMtjxGsA7Q4x4NhKxjz1qHZalRgH9tWJp8LS7UOP1xTwhlryfuc/uwT5/DtZQDNZCNpLoJwf
	hYx4oSQEtZWjtMg0ATsi7hWu0ImIp1b9qMPfeLuLf0w==
X-Received: by 2002:a05:6000:25c6:b0:475:da0e:744d with SMTP id ffacd0b85a97d-47f06d9f312mr3348895f8f.8.1783675885753;
        Fri, 10 Jul 2026 02:31:25 -0700 (PDT)
X-Received: by 2002:a05:6000:25c6:b0:475:da0e:744d with SMTP id ffacd0b85a97d-47f06d9f312mr3348850f8f.8.1783675885324;
        Fri, 10 Jul 2026 02:31:25 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.133.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039b0cesm59603204f8f.22.2026.07.10.02.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:31:24 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:31:22 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: peterz@infradead.org, bristot@kernel.org, mingo@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [REGRESSION 6.12 -> 6.18] fair (dl-)server delivers no bandwidth
 to CFS under a CPU-bound RT task on a nohz_full isolated core
Message-ID: <alC76ozQqJ1shU5a@jlelli-thinkpadt14gen4.remote.csb>
References: <20260709165912.518175-1-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709165912.518175-1-ionut.nechita@windriver.com>

Hello,

Thanks for reporting!

On 09/07/26 19:59, Ionut Nechita (Wind River) wrote:
> Hi,
> 
> I'm chasing what looks like a fair (dl-)server regression between 6.12 and
> 6.18 and wanted to ask whether this behaviour is known/expected before I
> spend build cycles on a full bisect.
> 
> Question in one line: on a nohz_full isolated core, with a CPU-bound
> SCHED_RR task pinned to it, should the fair_server still guarantee its
> 50ms/1s (5%) to a co-scheduled SCHED_OTHER task? On 6.12 it does; on 6.18
> it delivers essentially nothing (~0.2%).

I believe it should still guarantee the 5%.

Can you please check if the following fixes the issue?

https://lore.kernel.org/lkml/20260513-upstream-fix-dlserver-nohzfull-b4-v2-1-d3e9cbe5c845@redhat.com/

Thanks,
Juri

