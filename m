Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AA02EFDA8
	for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466104; cv=none; b=EBk/lqRx9EdP4YguYz6XxopWe4Bgi5qKHt+QcOdjO/K5RdgOb7NJARLIuLS9pH9MEPj5J6wgHmc1dysX9m87uNcsVoGCkO/q5aE9CUPp1DT7tXJdntdMx9eJV2PcrJ8rrzoF4/08wAFOH0fDPVukgDo/VSGOTM4uiKfMlwFDn+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466104; c=relaxed/simple;
	bh=D8LCiiOnh1ciGtN3M1PwN9coXeiorEjGuImBF9wxl4o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GzxHdo3IuqBOGHRdV6KHcwP3NbhTLr9OiMhdumvREdf+XM+ZUPD81OV++N9aBaMce/cnLUp0UZFKx2JUV9Zt+svjEmQ4BJGSXUlv+4VO/uKlWEja1pdADCcEuswew0/gCmI2OcGYQ/8OGz+U683yHluRG29TQvqShNNerzSjkYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vl30ASby; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vl30ASby"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753466101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ektlJIrszixC61nKMMEHhKMEbavNHbCtywfWm3KxNu8=;
	b=Vl30ASbyPKC68K5I4mm5aWcAaj0cbjeE6CBkmrPSdgh0jwUdMEdxWUYTDmAEP2a2nPGPN7
	PIC6HGzcq+GzYag5+3RjG6uWboZcPFsqjsGyz2YCVMxwCOV0TEPcf+JtS/3LgmBnXlOgsS
	lTp7x5dJiYG/v42BRpz9t2a8M2v/mXg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-2NURjWZ2PveWJdGkEexx_w-1; Fri, 25 Jul 2025 13:54:58 -0400
X-MC-Unique: 2NURjWZ2PveWJdGkEexx_w-1
X-Mimecast-MFC-AGG-ID: 2NURjWZ2PveWJdGkEexx_w_1753466098
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-478f78ff9beso82934401cf.1
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 10:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753466098; x=1754070898;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ektlJIrszixC61nKMMEHhKMEbavNHbCtywfWm3KxNu8=;
        b=LgCitFo7P56eLuNYv43LWGeffIYjbrz4RMyN63CVudphPJQQhIPmgzhllVhXlEisAM
         0fPf+Q5n2xdNfsUunoIyz5K4nMZBL3BxvPO4kPdXPKALvYXqZWZwIeShpE6r3wfDnaTB
         NUaLvB9RfadywkBGbkrpmKlSH/8SutjFDwC3/m20gOZ1YeiihGAlEXVO4RKei/sELFk1
         j0a08dwF+1jZJva8D0noSLdUnZph1XXvxVI5Dsoi4c/swiFWDq+ly1rQeLgCG/Bkqn+N
         XDvBrNIVZjCwasHW36wtALjHAL8RBFgfs5LywFxLow4p26+R9HNQxAknLK4h9C942GnG
         4EyA==
X-Forwarded-Encrypted: i=1; AJvYcCVkS40BgJnjlJmf4oqGebusJ1dwAjLp44l+b7LUG3lFAqeTFZkdBPWBXNr+nfKW9BJYlrc4xx6AjAHLqTEgNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yws92EQyG/pBt/torsm30b+0aiudX2Ong42+K4yDjJiNJ7XYXnI
	gvhTXM3zg5n9dv2AqqVDq0DSJGHBT+ajoFNdguAXjdlBjpZ7jgxOJIVu2r0GBmvbLj7DhD/cI/t
	2dkkjlYkPt8uXWUihPVV+TgAg0PAddAgQ6bQjZJzFkS4F8Bmo82uTM0uRjKl6TJaX7ypD4pLnIo
	xx
X-Gm-Gg: ASbGncvLZlixxVXyxXs3hH6Z20mHFKW2ddPWyaQ+ZXO2A3y6dH8geID9CfmxE0w86eA
	gquGrhRVvYoXYEz/nvOf46M0KSIspLtqG3ZJInBapPQfkfPc53DSbPeddFbx76njU6vJpUzBumN
	ICt4w42sABtf2cgmXX30RFzeJeVqu0+CsuhuUu9ah4bhRBUR4myAp6JpHw76HSwPuhL6D4nqy1V
	6WL7KuZKJoVvlKSydnYe6CxZHtYdDf/ofpnIbg2sK8wCeU5dnGezULkeibANxXqHXcMC4D4b5K9
	1gFyqIe07ECop+j2ZPEWt/4OiqUDAQ==
X-Received: by 2002:ac8:59d3:0:b0:476:964a:e335 with SMTP id d75a77b69052e-4ae8efe3b10mr33229411cf.24.1753466097546;
        Fri, 25 Jul 2025 10:54:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE3XHKP6nO4vnVYSo6iGL40oCHEhBATHMrjLE5BEpCLNnCIgOOXRjiCY/EvAPIzZNx2Z1LCw==
X-Received: by 2002:ac8:59d3:0:b0:476:964a:e335 with SMTP id d75a77b69052e-4ae8efe3b10mr33228981cf.24.1753466097097;
        Fri, 25 Jul 2025 10:54:57 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae99516fcesm2820951cf.9.2025.07.25.10.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 10:54:56 -0700 (PDT)
Date: Fri, 25 Jul 2025 13:54:55 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org, 
    kernel-rts-sst <kernel-rts-sst@redhat.com>, 
    "John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH] tuna: Add Pyright helper
In-Reply-To: <20250722213710.14464-1-jwyatt@redhat.com>
Message-ID: <d797a0e1-b5a5-9cb1-1d66-5d69cc99658c@redhat.com>
References: <20250722213710.14464-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 22 Jul 2025, John B. Wyatt IV wrote:

> Pyright is a common tool to assist with linting and finding errors in
> Python programs with an LSP like Visual Studio Code, Neovim, and Emacs. _("")
> syntax convention is used by gettext for translations and is a common default
> but Pyright needs to be set to not give an error for it. Add 
__builtins__.pyi
> with the _() convention to satisfy Pyright.
> 
> Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
> ---
>  __builtins__.pyi | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 __builtins__.pyi
> 
> diff --git a/__builtins__.pyi b/__builtins__.pyi
> new file mode 100644
> index 0000000..0e3a4b2
> --- /dev/null
> +++ b/__builtins__.pyi
> @@ -0,0 +1 @@
> +def _(s: str) -> str: ...
> -- 
> 2.50.1
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

