Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REtkRTWT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272EFBD
	for <linux-rt-users@vger.kernel.org>; Wed, 22 Nov 2023 01:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700646130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YD2HIfXr37MdyhlBF+IPzSWEmco8f7sGmYRWr8IBCHk=;
	b=REtkRTWTJB8h+j4tmpwqkkf+XqkKJJKPhfITjm7OynfZtfG5See6TYTMdjrXYNONy2DsoM
	jf8NOU8on0/gjt17KyufLREaTw9hWzr1oCRx2AWjwZ4Z1z+5wnbdHJpo/PPWdVww/EORBk
	hKtC95vziLW3wtXuaENPdIcxPYSYrrs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-ku0ieFNZOIerl2XHNoaFRA-1; Wed, 22 Nov 2023 04:42:09 -0500
X-MC-Unique: ku0ieFNZOIerl2XHNoaFRA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a029b93e484so95561166b.0
        for <linux-rt-users@vger.kernel.org>; Wed, 22 Nov 2023 01:42:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700646127; x=1701250927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YD2HIfXr37MdyhlBF+IPzSWEmco8f7sGmYRWr8IBCHk=;
        b=JpRTUUgWd+RzT9rOBUV9RoILSdVK96P+mSbi7O0J62GH1HMuAxyBPNdyPKgYZsGHEy
         odsb5vDH6Rz/LY4AlxwvXaAl9WEXbvw4J/0Awx7K1Ke4FhRljPMQb3SdtWpbetpHrO9Y
         AqXL988KZVf/CtcEmfYAMWCXL42uOyiBIsX5bvbvci3kFyawJPW74jCd+rWBAkyc8/cB
         DgsHfrslXYPD9/4e3yiDubYJ6VmKEtWD3sSTdntzqR9+ZTdUoAUisqmSmYrERolX2cRF
         /R9+fSJzlYPigeS9y6/gmg9JP8jbr1JyrdZ2ppg7te/WfqdaFYcItco0DNnyLx79LBTS
         rnzQ==
X-Gm-Message-State: AOJu0Yz9iqO2DNBHeB0IJhDoBAJtOon1rOq035FNKQ7C938WDMfu+MFi
	jVevZN6Vs/EsFLP2TA7GMCOyPphe01O79WdSADovaEEYOEDQt+ZYVm6oyfw7MDmpSGyGNM/o9ed
	kxkn715BvIiMcebn+3/sH4py+kY3a58JEidASWIXAlbbhZrGUm3kVbw==
X-Received: by 2002:a17:906:c3a4:b0:a03:9671:14d5 with SMTP id t36-20020a170906c3a400b00a03967114d5mr1185917ejz.32.1700646127355;
        Wed, 22 Nov 2023 01:42:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMjT5GLB9WLaONvEIogYI/7gi1srQBXhIMvL8cK18KPCJAvGqZuWM88EeCwnSWsCjPz8egkCIbEel71yoJMFA=
X-Received: by 2002:a17:906:c3a4:b0:a03:9671:14d5 with SMTP id
 t36-20020a170906c3a400b00a03967114d5mr1185899ejz.32.1700646127011; Wed, 22
 Nov 2023 01:42:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114121808.154654-1-tglozar@redhat.com> <20231114121808.154654-4-tglozar@redhat.com>
In-Reply-To: <20231114121808.154654-4-tglozar@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 22 Nov 2023 10:41:56 +0100
Message-ID: <CAP4=nvQqM+O3UXuHa0bG2FHMFwrbKG9-bfouewT5vvTj67pT1Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] rteval: Convert CpuList class to a module
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Content-Type: text/plain; charset="UTF-8"

I discovered that I missed some calls to expand_cpulist and
compress_cpulist in rteval-cmd, making rteval fail when run with
--measurement-cpulist.

I will send a v2 with that fixed.

Tomas

