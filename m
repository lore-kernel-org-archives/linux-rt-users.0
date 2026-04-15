Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447EF3D75D1
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Apr 2026 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264457; cv=none; b=Dh9XaJ0BcCTr19XIJw7tVtZaTRVsnM4lRUlZsHRoskNNV3gwwkHaXySZoceDWbii2UB3Zw+fNoEzDghaNwFx1vAudXa5Q6a+KllHidW34cCmSD7+bkPLVF1ndguxEIEZG8rXtmHlzarBuFj1BXuEzeF0w79LP2cjtp9gh6G9Fxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264457; c=relaxed/simple;
	bh=XPUGhsBoDryVdo/VVOq3l78/7mKiJglSbLysdyg247c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=epMMQkvCkI1JX9nj1RcRSc3gfG7BscdCAgOEq+aLk1S2StfieZO8k/o9PSN0G1QbNJHfBkjKhLiq6mCvh9Gr1JSWHNmyiztW5C2NwuyoAlkaqAyMLDPr2wwWJSDOrW27r47XJFyA3puJjdyQsmIhViBM+9V581u1VkBK0WWKdwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tA6kmGOZ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tA6kmGOZ"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8d6d5e45c43so827705185a.3
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Apr 2026 07:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776264455; x=1776869255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPUGhsBoDryVdo/VVOq3l78/7mKiJglSbLysdyg247c=;
        b=tA6kmGOZWc4pW7QidFNa8BjDNUje+okRbLFFcw8Y+A1t+v+eNu0l0DKB49XEV88byp
         ExgUb5n76aiE6dwlrCur6YdVAUunjwQUh2uOiQeqatllLY3lmYq+kzUVo3HPrFFZxBcj
         dVs2tXNgg1TUY2G+AVsp15Q/m5B7tq69l/pyE1QkMv44XZKstcKhXHRvS20sLfNxNprR
         R8M8iJrKdT0QUj/oEvuQ4s3iMHMY8eh5Kx5igNsLBOAenoqoRsDAWjmXufVgUxPOH0DS
         AfertkXeSYevuHwT2Z9QDAbBsr5pbALR3JVt99/HtYZn0dWsHQ8/0sqDNzoTrP9J6GCt
         22rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776264455; x=1776869255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XPUGhsBoDryVdo/VVOq3l78/7mKiJglSbLysdyg247c=;
        b=MykZJy+jw3FJDgJOz0MbwK5dyjJ4+JEGYwAaCbiK4gHDaMWBrVlczQxKQlQD140G85
         zLjV0cENWwbOjUTNnmPFxa+Gxw6EtQTm61gwp2u5gBdKj+KRTSkVyaglzsNEkkpCPmyo
         pMdkwezmcfj5SRuQMZMF6F2GCbvN8NycCL51Sirq+cMfVuvBcl5rTEqJj1Zt9RpfMDoU
         s9ixp0V2BsDI1DDFzZfIb1/bZcfuTQHYqrUwsxWhAJGSSW++XCg+82EoiXhP/GCu6bMG
         GvMUFTmY4Hv1YrBwtrRPey2B9v8F5MB70/yllwqMj5EkW9Y8Jbeb1FI83x8bwEyFP0L8
         jl2A==
X-Gm-Message-State: AOJu0YzhE/zPJ8URP7e47tXo6cau+kCJ2+F22SW5n5xe6lTPTBXG4EpF
	0u8lfEed/ZGRD6OEXrY0EDozVDaV6kvkrGcRO8rfjvNaR6LOSgFYwGLoggy6xA==
X-Gm-Gg: AeBDieuC/Zx2GXC74O/kOJiwj6IZHWJsPAX7jA0s2tCksDE4U9EpGlJNPGmFFvKJo4y
	uoC0mxzHVIWWOsJBzqsltZAWpUVoqAI0l7YYt8VuXQT0eXxbQePKjhYjQnYYTSHtOilLlR3nzUy
	6fSrjWqQVbEnrqYKiNB++8ycUu7P3nMBKUDdCQp2yh6BGdrjUz/J69ie/DPp+hsPtqvxmzsbyUg
	lnuMm1aft52dhoxLAzZgvQANnQKQ5wGdRaoSwu1+B25/pBgcFgmLMRETz+XauK3COuI3zKYGBCK
	B4WBYb0RYyVjTPhT6FhM37jGsJJfDpqAxHWOr7W8qrjfqUhxK4+2WcvSlECnDZdUH1bwIjClOVK
	WSlYWLegbcpOIr0fOcwUNkCiAYRRALSuNeSMrTUE/38rZOgtBcyFO8iLaI97f8uUcckeeakXrHc
	X2XEEbQkXVNJwkTAVsrrRc5pFuC6AUVjkNtfkPkBvNyWtwwEqSlPlbBZyrAZCmiY9RRNVU9KzpF
	QkLtwDF9i9Q2l1QkyY=
X-Received: by 2002:a05:622a:d01:b0:50d:9175:34e0 with SMTP id d75a77b69052e-50dd5bab1e4mr308579131cf.40.1776264455158;
        Wed, 15 Apr 2026 07:47:35 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1af9e0bcsm14295781cf.15.2026.04.15.07.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:47:34 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/6] cyclictest: Test the return value of timer_create()
Date: Wed, 15 Apr 2026 10:47:17 -0400
Message-ID: <20260415144717.109149-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407-auxclocks-v1-2-1ef80d14eb0a@linutronix.de>
References: 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 07 Apr 2026 at 08:48:42AM +0200, Thomas Weißschuh (Schneider Electric) wrote:
> cyclictest: Test the return value of timer_create()

Applied, thanks!

Signed-off-by: John Kacur <jkacur@redhat.com>
