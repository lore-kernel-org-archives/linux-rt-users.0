Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93245318146
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Nov 2025 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762801661; cv=none; b=o3rwfHFRJhduFqesEwPWF9FT/CHibwfJ6G78XHN5Lh8rJhFPbDZlVragIqb1BZQ+DO6BrR4dAfwgI1dBtTY2z1wPRyIUOK3r01LiyjJ9Py6YHPTw7vEDbQTNix6Xz7PYo+CKAbnc1pBhyKv1KadDlAO+ht7QAxou28P6WTSSFOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762801661; c=relaxed/simple;
	bh=RyByvN5KwIbkDibnWHP95UrSJ9tqI6N0Z4QR16cczig=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pK7+ctlGuWTr6TGwHkvJnbIG9mAL0a6EfpOYCdOd+Y/7RWv27qVzsZLI8F+Fi1BtBQuargdJd3vXOivhGDP4xJIbUrg4k2eJVhYA2rOTSZk79EyTbRi/BkmaISXMq7znm6LUxyNOYp5rM6GY8TD+vbZNkyILO2is9IN5gyIYIJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4dLQxmw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITRAWY7F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4dLQxmw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITRAWY7F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762801658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RyByvN5KwIbkDibnWHP95UrSJ9tqI6N0Z4QR16cczig=;
	b=h4dLQxmwNAaRsqmSNkDLjusR5p7XRz+mAeQ9P9ULbk5DU5sR+KFjqooixfAU2Wi6UVcb1a
	TLWAcsuG2DLNyrODlBiPlty4h00NvIdPdhO2b7sWN8je1DbHYhNlhtC4YjNXFLYOgRUc0p
	72mjc5W8R6JMNxC89MDet1/Nvia0724=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-sIDExJHCOxOPu7iz0yhIhg-1; Mon, 10 Nov 2025 14:07:37 -0500
X-MC-Unique: sIDExJHCOxOPu7iz0yhIhg-1
X-Mimecast-MFC-AGG-ID: sIDExJHCOxOPu7iz0yhIhg_1762801656
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4eda95d8809so51152481cf.3
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Nov 2025 11:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762801656; x=1763406456; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RyByvN5KwIbkDibnWHP95UrSJ9tqI6N0Z4QR16cczig=;
        b=ITRAWY7FObeg21XjUau2GPuvzttI9RfCGnVpSfMZoNqi23wB40k3c33kQUL2TuY5g+
         rxNKzzb8pLR9+2otuUhEEjxqjhrdJ7eaaSZw9fTvlfrDhCcsEFvBtkKscSKSBL8yHrRb
         gstE19q8DpbMvTuc2r4wkP85fNVCxiAbbhuoe9Awla9snQu7uOM+hZSx3+EI13ko3dxi
         /bmwc5i2/qhMauDXIu5x5TgPQ4CNPaILbhznPLZ4H/zsC2EZ71mRpVY9D5SuIsMIIjgv
         LThxAa2eRjHAQSHHB4zovhsGvwUSSp2Vd5K9oJMSYoHuuB2DdiWFEH6EiGu1dKxt+4Z0
         8W7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762801656; x=1763406456;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RyByvN5KwIbkDibnWHP95UrSJ9tqI6N0Z4QR16cczig=;
        b=v0M4fnmE/G1ySFB0FfTg9m6cZa39JxO/Za45JcJqf8s8Hm+TLWjjesMXw0d0QFoZJM
         zz6HqhSVrlQy1eX63lcqXgrbTR13KyYPrknRB19hmMO7LP4UBtereqRJv9CZuRFmJrEy
         uw1jm0kuQEWExfIJjeQ6LhT7reqhuQW9S5KChWuQrN/IifYHprZFi8xU6berapbvb6v/
         tYCkA3Hlv4oVfGhXW0FbzDC+wYvnsiwzCHAoGJQw3MrcwKAEGdumbRYbT2zStTy4eE7u
         SCf96+elqq9ElDArUyMNY+OgIYI6f94Alvpa5PvcOyx/3AcKJbx8TOFhTAdSzCj1MNPl
         6ADA==
X-Forwarded-Encrypted: i=1; AJvYcCWhChoe3YqLF1aaz27ShTalyvdMLMg35I2hlEIgxHOfRP8PEnJ4EirZbhpXQjqGod5eD+x6xJ5nUgth0DEwqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWGeacyVk7cBuH1m5+3RFoMIfHshsYT01ioLL+cBh0TCqBHwga
	kazzT14y54TJyPR474HsomLiH4IkYGD5HmGGIQVBhTtxl5rGdkPRz+MqvL99wiR80My3j/GyShd
	LnQqWfVnkAcz3Hg1bdLxZ3y0VtvQiUQUGKnt5DNXU5PucNeiYe2nYV0nuLqMfEQYLFUTN
X-Gm-Gg: ASbGncuPFN6zHR5ZOYdElpgE5xH2oss7viEr8dPkc37ZWS1ReHSL1mDae1F68BhQExk
	2L1rQOwlgpkJz9i/F24r7qeLC7dx5DeXjIPizb7VLM7VyT52gN+dDvu0899NwpwP347VO+x4oZz
	JY6rP0c1dPsXAdXtnXGGxclWsSpTodD04MKLj26A1LTC2fCK/Uq6EuuPs48PpaKVW0tnkeRGCok
	hQ5pYqTf3QZJJiTn+z7GMzyGdj6zRsvJEq4H/uwfPKwWarO3FWmWZ0Z/x4pUldHlit2dwtEKLbQ
	tCz/7UV6PigIEPwhjjszyRRXgz1lbamJfeeVMGV5G/Q9jkAUa3K7oOYXHcy0QX+GWCNUqK03IPr
	PuMuFbWTE09Kc/7uDMJN+eXbzA9wfZmeB4rc20D54JpftBxJJ
X-Received: by 2002:a05:622a:1921:b0:4ed:7074:423d with SMTP id d75a77b69052e-4eda4e8bda8mr103771461cf.1.1762801656305;
        Mon, 10 Nov 2025 11:07:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPjwRmxoTkWjwvwnBojf1k5djeL5FM7B5sRX4oyrVrsMbNVbN796nXeSRNmsCyKfhmNMkuQQ==
X-Received: by 2002:a05:622a:1921:b0:4ed:7074:423d with SMTP id d75a77b69052e-4eda4e8bda8mr103771161cf.1.1762801655973;
        Mon, 10 Nov 2025 11:07:35 -0800 (PST)
Received: from fionn (bras-base-rdwyon0604w-grc-08-174-88-40-44.dsl.bell.ca. [174.88.40.44])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda5785f89sm53287591cf.23.2025.11.10.11.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 11:07:35 -0800 (PST)
Date: Mon, 10 Nov 2025 14:07:33 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: Clark Williams <williams@redhat.com>, 
    Linux RT Users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] rteval: Introduce E2E tests with output
 checking
In-Reply-To: <20251107134749.257350-1-tglozar@redhat.com>
Message-ID: <e24beb3c-e511-aa59-7986-38dd44a06180@redhat.com>
References: <20251107134749.257350-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


8<

Signed-off-by: John Kacur <jkacur@redhat.com>

