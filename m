Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4209188907
	for <linux-rt-users@vger.kernel.org>; Tue, 12 Nov 2024 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422973; cv=none; b=UjXRfjQU0KSu6G7xyNy/SCBZt+m+L8hAh0/FswSlkcZod/JzYKY0ovV0+S+1zlhJF64HaOquhTBI+PAosaarMSeyimA6JmQ+4c/nJEd9OpV55lGVPYI07f0cxN/KgB5xbc66pRu4FzMVCBBV2Og2egyV+e0nVD4X0W5NFIE48BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422973; c=relaxed/simple;
	bh=Efs5Tr0NRWbY7pzYfLtJnwwfH7yAcOhfms8/OfLKvR4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ue4PaoPjoxygDQzddADzpcAzBfpln5+P1UfomtklO4VS09Y3DourSCFLkq9cawFpyB8HCaAvlxMQQ3oxkz9dTAnXL/rb9laBz9ECJKk+ECnxE+K5lR60E+nrlW6e2boOZzstnYUFCITKMqmxc+s4xzVTaxzJg9bm5mG0Cdkgsqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/jyRz7b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/jyRz7b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731422969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pwfct7AN64gX2HFI9fp5syFJVBNoE3ku3FTUvfo3rgs=;
	b=h/jyRz7b5mRKsglm90eAtZqaiaSpmnmrVU9zZNoXK7IKJgfRvdAwWtnq9tPKkTdE/tBq+q
	Cj5FFVjEYWTIHM0rN+L1ygLBa4lxJfazbaj6qqdyhXMh3zv8YHW6YMN10lCV2abuFqQ3rj
	kBRbelNoOY6K9SBv6xdIBloletgLe0U=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-mO_F5hEENkOt8ld39b4fdA-1; Tue, 12 Nov 2024 09:49:28 -0500
X-MC-Unique: mO_F5hEENkOt8ld39b4fdA-1
X-Mimecast-MFC-AGG-ID: mO_F5hEENkOt8ld39b4fdA
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b155c120daso778339885a.3
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Nov 2024 06:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731422967; x=1732027767;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pwfct7AN64gX2HFI9fp5syFJVBNoE3ku3FTUvfo3rgs=;
        b=KrtSJt46ubFGxKHFCA70IQUZ3B3AVUocvYMdyYBSu25HTddt+UCMoNXRvAdljBDw8n
         qLyq8LUidKei7rKF8VKgHsdD4Mx0WfaO8mLuuKorhVNUbyIPpsL70TgRdH26Zy2wbM2E
         YvYcpIvt6HJbKFPdsnN8JCBP5CkYkCyC0tXYxS1s+JxNF4lBlEYIgI9Y9m1FdEPl206w
         EGYjZ8b8AWeH98wbUMqEF+c4KDD7axLo0kYgsqiHtva9wrn5Hg0m4PMoJ+GpDzAj5SbK
         Uk0CDnZ+2POla+/UgR7WA8itmRPfZdJSxh7F7mx+OC2MOXb2bhPmb62ifiuW6KsOFggq
         DpYw==
X-Gm-Message-State: AOJu0YxzpRl/bFmqUxgwWaTPE5USD12VFtFWtgbAToQVPRd1GaSIINdH
	wDI4TyYxvthDjbkdfhGCKCrerzljs3SEDeItYqylsKmMvmtokubHv4LEGFHcayYcG4eRPTyVRe/
	SkqCmDkkom610ZfDAD6GzjcRVoDoiaTTGRAFkkfdNEcPV2Z1NPQnN6R59yqvmMKdcEz0S5Gdt
X-Received: by 2002:a05:620a:1a14:b0:7b1:e77b:26cc with SMTP id af79cd13be357-7b331e88d38mr2004167185a.9.1731422967160;
        Tue, 12 Nov 2024 06:49:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHT6hxKh8aS/PaM0XrSn8qIth5FeYDaMyCH9UNUCWqBUbODAagvv/4uLPve39UmQ1hHREzW3Q==
X-Received: by 2002:a05:620a:1a14:b0:7b1:e77b:26cc with SMTP id af79cd13be357-7b331e88d38mr2004165485a.9.1731422966869;
        Tue, 12 Nov 2024 06:49:26 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac666efsm594856485a.60.2024.11.12.06.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 06:49:26 -0800 (PST)
Date: Tue, 12 Nov 2024 09:49:25 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: linux-rt-users <linux-rt-users@vger.kernel.org>, 
    Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 1/2] rt-tests: Detect libcpupower presence
In-Reply-To: <20241107152049.822810-1-tglozar@redhat.com>
Message-ID: <3030d57a-8d22-66c9-72ba-2b7d17e415d0@redhat.com>
References: <20241107152049.822810-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 7 Nov 2024, tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> Add test to detect the presence of libcpupower on the system, allowing
> to conditionally build features that depend on it.
> 
> The test uses a similar mechanism to the Linux kernel's tools' feature
> detection: a small C program using the library is compiled, and based on
> the success of the compilation, the presence of the library is
> determined.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>


This seems overly complicated, how about just doing

ldconfig -p | grep -q libcpupower

if it returns 0, the lib is there, if it returns 1, it's not there.

This is the mechanism that perf uses, you can see in 
tools/perf/Makefile.config

 	ifneq ($(shell ldconfig -p | grep libasan >/dev/null 2>&1; echo $$?), 0)
          $(error No libasan found, please install libasan)
        endif


> ---
>  Makefile                   | 11 +++++++++++
>  feature/Makefile           | 12 ++++++++++++
>  feature/test-feature.mak   |  4 ++++
>  feature/test-libcpupower.c |  8 ++++++++
>  4 files changed, 35 insertions(+)
>  create mode 100644 feature/Makefile
>  create mode 100644 feature/test-feature.mak
>  create mode 100644 feature/test-libcpupower.c
> 
> diff --git a/Makefile b/Makefile
> index e2f8579..1f698cf 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,4 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
> +include feature/test-feature.mak
> +
>  VERSION = 2.7
>  CC = $(CROSS_COMPILE)gcc
>  AR = $(CROSS_COMPILE)ar
> @@ -37,6 +39,15 @@ LDFLAGS ?=
>  
>  PYLIB ?= $(shell python3 -m get_pylib)
>  
> +# Check for optional libcpupower dependency
> +ifeq ($(call test-feature,libcpupower), 0)
> +CPPFLAGS += -DHAVE_LIBCPUPOWER_SUPPORT
> +LDFLAGS += -lcpupower
> +else
> +$(warning libcpupower is missing, building without --deepest-idle-state support.)
> +$(warning Please install libcpupower-dev/kernel-tools-libs-devel)
> +endif
> +
>  # Check for errors, such as python3 not available
>  ifeq (${PYLIB},)
>  	undefine PYLIB
> diff --git a/feature/Makefile b/feature/Makefile
> new file mode 100644
> index 0000000..085e3a9
> --- /dev/null
> +++ b/feature/Makefile
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +all: feature-libcpupower
> +
> +feature-libcpupower: $(OBJDIR)/test-libcpupower.o
> +
> +$(OBJDIR)/test-libcpupower.o: feature/test-libcpupower.c
> +	@$(CC) $(CFLAGS) $(CPPFLAGS) $< -lcpupower -o $@
> +
> +.PHONY: clean
> +
> +clean:
> +	rm -f $(OBJDIR)/test-*.o
> diff --git a/feature/test-feature.mak b/feature/test-feature.mak
> new file mode 100644
> index 0000000..fffddef
> --- /dev/null
> +++ b/feature/test-feature.mak
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +define test-feature
> +$(shell $(MAKE) OBJDIR=$(OBJDIR) -f feature/Makefile feature-$1 clean >/dev/null 2>/dev/null; echo $$?)
> +endef
> diff --git a/feature/test-libcpupower.c b/feature/test-libcpupower.c
> new file mode 100644
> index 0000000..cd16269
> --- /dev/null
> +++ b/feature/test-libcpupower.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <cpuidle.h>
> +
> +int main(void)
> +{
> +	int rv = cpuidle_state_count(0);
> +	return rv;
> +}
> -- 
> 2.47.0
> 
> 
> 

