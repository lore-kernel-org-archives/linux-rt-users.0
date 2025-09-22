Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036BB2556E
	for <linux-rt-users@vger.kernel.org>; Mon, 22 Sep 2025 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556235; cv=none; b=joU0fZkfIxNudNIT24GkrdavKZqk3EipkuRwPPHxm4O+k8ZnLNCaNdM36W+39+m8PzKtcfXqLLVc8DS9OOyCVu6Y/I2L0jvC5H2dudoqYCwCilM5l4//jR3e+2X8ATgaKo58yaVtnZq6a29U3jBkfj00c4nnSvAlDIfoMKqeX1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556235; c=relaxed/simple;
	bh=N528JzS6YYZmW82pU1oirNGWNtMcXEvTOJfBimaU4eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CA/Cg1CIQzOKv03JdBPdHktd5o5eLgt98v3dPGn3iR8jxgQRwbsbP1N0ycW4iZtOkJqXObFpCuDL3FMsXKzhKKSd3CPM9Jn9DelbXJlussp1XzomAC6Qd6Qrrpw4/510Yc+nUQRlkNrsRLCnPPO/PS5B6XmKeg7hwRvClwpJAdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YLuC4nEW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YLuC4nEW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758556231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N528JzS6YYZmW82pU1oirNGWNtMcXEvTOJfBimaU4eg=;
	b=YLuC4nEWCrwCKfrh6avijkMN//yvMcpDD3PAlrt0xEKrbYpoGXYDnYqtJxWQTMlX0O8cW1
	vkQIY09ojmAqgIHCsL7C7LRMDIxgKwIxOIXR81TaBhGWWuYdbq1lTXFnCT6ll5ULy2Ytmn
	/Nz8mWpORPzwNK2itYLAMN4HdYQrBLA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-PQRZa9CzOrqZXOk-j-H6vg-1; Mon, 22 Sep 2025 11:50:30 -0400
X-MC-Unique: PQRZa9CzOrqZXOk-j-H6vg-1
X-Mimecast-MFC-AGG-ID: PQRZa9CzOrqZXOk-j-H6vg_1758556230
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b60dd9634dso96046671cf.2
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Sep 2025 08:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758556230; x=1759161030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N528JzS6YYZmW82pU1oirNGWNtMcXEvTOJfBimaU4eg=;
        b=HBB8hqIHoS0h45yHncg1jfwYExek0RihhGFXYJHILEkugQhnpKLYY78CmU7aaKVzih
         /zt+jE/2QN47QLs1fTvAuFj3nnoUtPYdOC9OHdIpG/Y5hoH9jAsWgWNaBq3yzRWgzEeh
         Cvo1jcvsYH1ze/dUUc5083ZqebVBBaGjjYiXnKGMIfmZRoKFpY495gIEHR4939tgSnPo
         9Ww2a8W8jKhbtgJd/C/dNe1JxtmCYTb/Q3S99edUwpITP8Q6MK9O+hncpk4wnXhyhV9G
         rLaN65Ac7JW+75lcyUIj/0DAufqRxS5foVqDGOE1u+EbwxXjPJiIYn6/GP4sMEeZwikS
         2buQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT14u7HmBTnszfQ3vWmNngZxDR33SclJfd+UYoI4fr4W3RqNIhNzHz0Qh1dwlH7d80Lq6lTkre/wo5m/lTkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvzfXVtHvaVR4jwfhisPzOxLQx0eYQ9W08iP/PKCeGgsDlBGGl
	KrMVexemhox/MPxzXN+IQqDppapzJXDe/UzaMDPsiiHMKQujHufO9JPwIU1432HVPpH/NKcrXOz
	9rEF5ejdGwjPc+DUxn6hDciVsjo+zmsfG29lzRQgX910x11E9XujxG7YQxFp5suyrk4Tg
X-Gm-Gg: ASbGncv3s6UM18vU3p9ExPHGGesKsxqpbnNRVQyhawNCX/uQqKOCLDeclQX6ypZILf+
	ZqDLbFdpSzm84/2fDu+i9beKSQKUzy/XGA46t+LqOtIhCCOEtIJdr3349/AC2lrnxtT3jChhOMd
	iqKKdG5rA27L3Q0IjvWJXiNlpXUdPtoE1ZzEhYwRtjWyn+omrETDveVb3ei/sftNgtl6ZzgOBJH
	oachxF8vMQf4GIAiEoxfJQP7vsKuXHT5RgUpJmhTDMkPwG1qEqxSIc/CIpW29Or5N/lbVmADGLN
	7Ry2oiSxTKAJOYQpy7EXGvFvFgKEopmCDF6ipg==
X-Received: by 2002:a05:622a:5446:b0:4cc:cfc2:1585 with SMTP id d75a77b69052e-4cccfc217bemr31627301cf.23.1758556230001;
        Mon, 22 Sep 2025 08:50:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiXP02nFn/l5DjYlDEHHEaYmD2sKIfPkJ0bl3FBLKJSk115H6wdD8oAq3zQk4+1h4GA9sv6w==
X-Received: by 2002:a05:622a:5446:b0:4cc:cfc2:1585 with SMTP id d75a77b69052e-4cccfc217bemr31626941cf.23.1758556229451;
        Mon, 22 Sep 2025 08:50:29 -0700 (PDT)
Received: from thinkpad2024 ([71.217.38.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4cc75130868sm15461321cf.29.2025.09.22.08.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:50:28 -0700 (PDT)
Date: Mon, 22 Sep 2025 11:50:26 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH] tuna: Add common virtual envs gitignores
Message-ID: <aNFwQtKJNcLAEsb0@thinkpad2024>
References: <20250813200839.82200-1-jwyatt@redhat.com>
 <3c66730b-a473-f103-bf13-cc19d312880d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c66730b-a473-f103-bf13-cc19d312880d@redhat.com>

On Thu, Sep 18, 2025 at 02:06:06PM -0400, John Kacur wrote:
> I ran in a python virtual environment and only got an env directory which
> I deleted at the end. Are you actually using this

Yes. I was using a virtual environment to resolve issues with my
text editor's linter with GTK. I may need to do other things and
I want this support in there.

> or is this just
> theorectically something we might want to add?

Virtual environments are very common in Python projects. I would encourage
this project to support them. They have a variety of uses including
testing since you can pull in packages and easily use a different Python
version.

> I also understand you are trying to do your due dilligence by referencing
> where you copied this from, but then pulling in another license to do so.
> This is going to cause me headaches for something kind of trivial.

I understand this can pose some challenges, but, it is a snippet from a file
that has a Creative Commons public domain declaration from a well known
company. I suspect there are no license or copyright issues. I wanted to
include that linkage to provide a source for a code snippet, but we can
investigate removing the link and attribution. Being in the public
domain; I believe it should have no attribution requirements. Let me know if
any copyright or license issues arise.

--
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat

