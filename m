Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96B1239E9E
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128879; cv=none; b=H6fLQjhWO7l24CAfLMX/2/1lq8V5KNpesgLMQDaJiX0EMiA+fSX5//Vngqb5NsAiLBWuwMjcB68icNJbk4eouXYivNzi4mkDW8627LtQv58zOIcRBXv/YKbCqyAz/1U18TeZI/YzYgOMKKojeEb3218kJS8wHul0ZKbsDJ+t214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128879; c=relaxed/simple;
	bh=nOA11x8A6UnqF5v5wW6ru4VHZ8p9i04T1bkKi+cqIhg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RIhejPOtOGguMrTzXTIIrA9wSlW5QKJWgWp48sVk1T4LC+D6mtLOy/3dTeMGKUFkH2RpSo5xPhEghFG9wf2aUutoP5iNwHyZeg2zj28MGVL5TdOzS7eyIY6xPI5OPYshbWcR0D2+4hzx2O+NeM53iaA1rXhbZdJzIfcfyvy6u/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WE7Sv02U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WE7Sv02U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753128874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ApwTLcwxN9V0UXZCIz6+Rb5RZkggfpD2ZhktelUIHgY=;
	b=WE7Sv02UXx/aohVIybJRFeotIBB17D9qkVxb8RPssrwiJFkyLU6EN4JrIrkdOCzTzK+vhd
	orLVO2NhVGhwiCO8/FRu0rbe6+CcPvTO6K+OvOA83dxy1CG2VAU8sfjDCLfl4T6mc+63e9
	SYofAy31DpkVcL6hAIY4vbIa6/NiI0g=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-GXmj1abJNH2Aj7LuMT1H7Q-1; Mon, 21 Jul 2025 16:14:33 -0400
X-MC-Unique: GXmj1abJNH2Aj7LuMT1H7Q-1
X-Mimecast-MFC-AGG-ID: GXmj1abJNH2Aj7LuMT1H7Q_1753128872
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4abafdba95fso83502481cf.2
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 13:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753128872; x=1753733672;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApwTLcwxN9V0UXZCIz6+Rb5RZkggfpD2ZhktelUIHgY=;
        b=O2FmivilfhjBEmG4LjAVGjs0hqLiNS38IzwZdFvaFIsbh4rKza3Rcr3L55tjHhUwtU
         FpF+3gLtmb+PYWZAjOWXEcNC9z1c70Y5GRghb7gKoh39Th6fS/0VmPv5UkXY37u+HuRi
         kPP2c6eQZvzWluBROF2vxWD+GzHs8NPrOJ2K3oVUT3F3B54B40BY7mLtm4J2k0D+LYzC
         kquK4hnrBZ0AxLMa3ZnkjfZz2ugJC8u9d4j7UeZdga3NRHzGr0EGQYvnuuNn8yK6mDdv
         3DJWx+C7Taz9fsUS81dtjFh35I6NdqD5OrhYwVMCmXbnt0O0JRn9BeoVedQ18pi5eC/X
         qV0A==
X-Gm-Message-State: AOJu0YyF1QL5FgHNcl63IGMzpH1JD+ZAhUzUZSjIwdWUbRNXpnIDLE7q
	q64JyZaQpHzsKTpd5vKi7WTfxTFJeBXf+zk96r8dxxqOTBcxC6rft1aAWQ0N49+k09x5yLylyds
	4qttqTObBKcCOuavQFeE59HVMyH4AucoHEpQXPoGSspkYeD95YyIfVjzXgLYKMVyJRETarKJaAT
	b3
X-Gm-Gg: ASbGncsH6Lt2GO1otbEbbL6sfq2d8E7+eA29bLub+va2HsT/pI0MPMgGKJ3WkdePQQI
	dZbgqXB9jQxQWVITYlVTQBLSJe1wJFVxwQzl62YomsK2smYlsJd0EC8TBxlF9caAVx5sfpqX4WW
	o2R0E8b9T1T4OCT5PlU13dpKoZyK/F5G4DEk7anFnnLuLBxCnlQlhgvKxE3TcrCBoXG4/Vn88fo
	RRZlxSyHK4Nb9744NUBRmp72qqdWPcTb88wYot3XNWaxJ4BNYSJR/iymGa8naztMBVjEg3FipcC
	fB1ASZV0CvZ+RURXthPjjX8lcU94sg==
X-Received: by 2002:a05:622a:5815:b0:4a9:db25:8b6f with SMTP id d75a77b69052e-4ab93cc977amr353492231cf.23.1753128872139;
        Mon, 21 Jul 2025 13:14:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhZFGuh0P/Qbjl1g6pl81cXKBvyR4Lok5QFd0t/gH+Ge/2sYxQi+KBf8zm2c4/GkBYo9eMZg==
X-Received: by 2002:a05:622a:5815:b0:4a9:db25:8b6f with SMTP id d75a77b69052e-4ab93cc977amr353491931cf.23.1753128871717;
        Mon, 21 Jul 2025 13:14:31 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b491c2sm46055521cf.69.2025.07.21.13.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 13:14:31 -0700 (PDT)
Date: Mon, 21 Jul 2025 16:14:29 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 24/28] cyclictest.8: System options: Deprecate
 --laptop
In-Reply-To: <20250704132721.13325-25-darwi@linutronix.de>
Message-ID: <481fea7f-6f10-23cd-40b1-5a6089d6d6b0@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-25-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:

> Per 61ba1aa3a0db ("rt-tests: cyclictest: Add --default-system option"),
> explicitly mark the --laptop option as obsolete and recommend using
> --default-system instead.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index f320f66..aff900d 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -92,8 +92,7 @@ cpus.
>  .
>  .TP
>  .B \-\-laptop
> -Save battery when running cyclictest. This will give you poorer realtime
> -results, but will not drain your battery so quickly.
> +Obsolete option.  Please use \-\-default\-system instead.
>  .
>  .SS "Sleep-mechanism clock options"
>  .
> -- 
> 2.49.0
> 
> 
> 
I think this requires a patch to cyclictest as well, but otherwise
Signed-off-by: John Kacur <jkacur@redhat.com>

