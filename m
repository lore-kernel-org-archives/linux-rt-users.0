Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2777191489
	for <linux-rt-users@vger.kernel.org>; Wed, 29 Jan 2025 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738187688; cv=none; b=rhLjNsCS4oDLlcjtRtArvU7GFRHDve5HPL+pptVBQHIl+ok/9/O/UV2qicF7zirJEj9TLzGlxajPyXcdAhOJB0r8p++6N7E5l4cIAFdfeE6DhOyP2Tq/dnt357dIfO2z+MNFpu6dVs+KzR8XdgURmhwlK6JLa9B38ADGQinRhwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738187688; c=relaxed/simple;
	bh=dXzauwuo9t3YX6jHww/eae9dEQOZLpwLcz6Yw0bKZ8E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Xl+kSwFLEBMdmr9Mzdq5KgNWgp6x8Uz06xj3LmUmMLnBtQGHTcVsX/jFoDv9H5wVs6do9kE8WEUm1qBigK5eY1qcu9RnErloV8ogO3fdVaQFr1eXOzNDJ5mDGT2uaz0GSef+aAhJmT4CRbVb5jPWHo64QM7n0TIUm5dOzYJx/1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bas8WYRU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bas8WYRU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738187685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0tjGDsHo6XzDnk2uZ0P6uKu24vKEvyYL+aEwndR94Eo=;
	b=Bas8WYRU3EEkeEdL6xNSSnh+oR6CikSdiaOK2soXinsOqzm34vM8e1FqFfNZEbMfNQCC4P
	WcPHzrCrb0FPwdnSfGNM2xNKilGQaCiwKsoYNSTbDTOW4Sa3JPhnAF4VkVrl+bk5Oj4So4
	e3T2eYybuecZGegtLMrgEcx0/aikGlQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-siax5q0KOC-lkC_nmvxdRg-1; Wed, 29 Jan 2025 16:54:44 -0500
X-MC-Unique: siax5q0KOC-lkC_nmvxdRg-1
X-Mimecast-MFC-AGG-ID: siax5q0KOC-lkC_nmvxdRg
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7be6ccb09f9so20102285a.2
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Jan 2025 13:54:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738187683; x=1738792483;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tjGDsHo6XzDnk2uZ0P6uKu24vKEvyYL+aEwndR94Eo=;
        b=iM/BGQa5HDS7OwwLsW5n5KQQUozMXww74Fo4A8uU3+Crsq0+Fdjx4nZrLSlf/wUxqm
         DZ66jZmIVnkd3DQqy14KZAfAfph7i6Q4GCntJRbNc+WMwXypED58sRqj5pqmWfqdh+M5
         SZIyslbvjXMUqwSp36OVj/mOnWE8rbQHMv/Zb52G/wPX4E6JimPlZb86IdprfY+RCbhm
         nsmMHF/2atkKvIzj8VrMbslwvhxXndsV0SFkBTYNra6vzaImgamHRzO3vhIxzsDZ3g21
         xe808+0ek3/WYCWG3w5jd55blY8GB/jrJ5/FuCw04dtc5v0kmvTzGDWVwRYR99Y9ey4q
         SvEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmM4Bd98hSjTC6Ueyu91iDJLBcH7bAUqaocDUirFjYHJsQvjtFNhA++TzTWmeAnANnfiIq0ItToFacv4F0fA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuv5ko/BlwKsEhLXB5BPbYSaY4Vn1nJi808mrZ58Oy2mNe1vuw
	imHcbTGPYYiWs11Daz0ENEX0Ntl/w5QSL9pRh4Ig12+TDWYdsHN77dNtIdke5R2CNvbCEYU4YwB
	qcuOVqjFAKDhsQfSDdoG0V7TIWo1Yw8rdhodG6RpIE8/7cdLUaKZS40Q1zykfrNpE
X-Gm-Gg: ASbGnct1U3K/c+Fzvgt9/vn7bWpQcy21Juk7pPNeuWQ6Mxy5UwKI+r3t2ds3eIc5N6v
	TGQYfIGS3qGFVwQgWbNk3h4ta7HEESEt9LzpHpXrZGIuaWPZkNxZ9NI0YACTvso3909276P0bV3
	EQeljn3jKsMp3jJOhtXj2zfh3GSljX1CbjgcbIJufL2LitJhdym0ACFdpuUuNLV66Ls5ogDHUj+
	ipSXwGjtJqUwFntOEHmRYV7/o37uJr9OUe2lqu66I376VEOK3BjjpPTE91On11kBGXy3Ok=
X-Received: by 2002:a05:620a:bc7:b0:7b6:d8da:9095 with SMTP id af79cd13be357-7bffcce51a3mr745557385a.13.1738187683587;
        Wed, 29 Jan 2025 13:54:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIHy/pqqiBCFcLhbRwxk3acejFRXbQ5Q7lJ67sX1DeRs2a3HFoeaMrbLPhdMfJ6/MNR12CiQ==
X-Received: by 2002:a05:620a:bc7:b0:7b6:d8da:9095 with SMTP id af79cd13be357-7bffcce51a3mr745555185a.13.1738187683273;
        Wed, 29 Jan 2025 13:54:43 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a7ef092sm8783885a.0.2025.01.29.13.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 13:54:42 -0800 (PST)
Date: Wed, 29 Jan 2025 16:54:41 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Khem Raj <raj.khem@gmail.com>
cc: Clark Williams <williams@redhat.com>, 
    rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] sched_attr: Do not define for glibc >= 2.41
In-Reply-To: <20250128230838.2311298-1-raj.khem@gmail.com>
Message-ID: <06e5ea58-b30e-0a8b-c9e8-226e8c20d70d@redhat.com>
References: <20250128230838.2311298-1-raj.khem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 28 Jan 2025, Khem Raj wrote:

> glibc 2.41+ has added [1] definitions for sched_setattr and sched_getattr functions
> and struct sched_attr. Therefore, it needs to be checked for here as well before
> defining sched_attr
> 
> Define sched_attr conditionally on SCHED_ATTR_SIZE_VER0
> 
> Fixes builds with glibc/trunk
> 
> [1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=21571ca0d70302909cf72707b2a7736cf12190a0;hp=298bc488fdc047da37482f4003023cb9adef78f8
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: John Kacur <jkacur@redhat.com>
> Cc: rt-users <linux-rt-users@vger.kernel.org>
> ---
>  src/include/rt-sched.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/src/include/rt-sched.h b/src/include/rt-sched.h
> index 80171c7..9cf0e3a 100644
> --- a/src/include/rt-sched.h
> +++ b/src/include/rt-sched.h
> @@ -42,6 +42,8 @@
>  #define __NR_sched_getattr		275
>  #endif
>  
> +/* sched_attr is not defined in glibc < 2.41 */
> +#ifndef SCHED_ATTR_SIZE_VER0
>  struct sched_attr {
>  	uint32_t size;
>  	uint32_t sched_policy;
> @@ -68,4 +70,6 @@ int sched_getattr(pid_t pid,
>  		  unsigned int size,
>  		  unsigned int flags);
>  
> +#endif /* SCHED_ATTR_SIZE_VER0 */
> +
>  #endif /* __RT_SCHED_H__ */
> 
> 

Does the following fix your problem?

From 280e198c39d1b17d0491d7c4e7afda97ae6c8e6f Mon Sep 17 00:00:00 2001
From: Yaakov Selkowitz <yselkowi@redhat.com>
Date: Wed, 29 Jan 2025 16:46:11 -0500
Subject: [PATCH] Fix rt-tests build with glibc-2.41

The sched_*attr APIs were added to glibc
https://sourceware.org/git/?p=glibc.git;a=commit;h=21571ca0d70302909cf72707b2a7736cf12190a0

This fixes the build conflict in rt-tests with glibc-2.4

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/include/rt-sched.h | 2 ++
 src/lib/rt-sched.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/src/include/rt-sched.h b/src/include/rt-sched.h
index 80171c76e0ee..dfd7f45f51cc 100644
--- a/src/include/rt-sched.h
+++ b/src/include/rt-sched.h
@@ -42,6 +42,7 @@
 #define __NR_sched_getattr		275
 #endif
 
+#if ! __GLIBC_PREREQ(2, 41)
 struct sched_attr {
 	uint32_t size;
 	uint32_t sched_policy;
@@ -67,5 +68,6 @@ int sched_getattr(pid_t pid,
 		  struct sched_attr *attr,
 		  unsigned int size,
 		  unsigned int flags);
+#endif
 
 #endif /* __RT_SCHED_H__ */
diff --git a/src/lib/rt-sched.c b/src/lib/rt-sched.c
index 8023bc70c473..2500abde26e4 100644
--- a/src/lib/rt-sched.c
+++ b/src/lib/rt-sched.c
@@ -14,6 +14,7 @@
 
 #include "rt-sched.h"
 
+#if ! __GLIBC_PREREQ(2, 41)
 int sched_setattr(pid_t pid,
 		  const struct sched_attr *attr,
 		  unsigned int flags)
@@ -28,3 +29,4 @@ int sched_getattr(pid_t pid,
 {
 	return syscall(__NR_sched_getattr, pid, attr, size, flags);
 }
+#endif
-- 
2.47.1

