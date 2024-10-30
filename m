Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3CD1BD9DC
	for <linux-rt-users@vger.kernel.org>; Wed, 30 Oct 2024 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730326135; cv=none; b=X6Wis5eCFGxFmhtNPcJmjZTev2y8w+Ue2oeqO/ctYohMJfyiyCtn1smngKgLKh9YQOQPLfSddTmazKzXEeTC7NGri5v4ABFNzEMsAbh7gPzgG0u1Z7X54S93XKDFAoTpWELD7Lwx8HAbNH8Xnoz8zZPJ7+Tx51lNRudGAfYqdck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730326135; c=relaxed/simple;
	bh=V/sCKXbG9fdIALFvAHnkHiub3gyhlUgq+qvMMyJoGJE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QYVJs5M83loWj75ZmmMEPBTmyvXR49g4q2l8FJnEs0OLyyvDw5cNY4y4q4KRT9nF07LpRSw8n81LqFvH2Ow/a5XmTYnG7zcgqYHnNpPuDU0VFUuxOf1idxYL/AHC8Ksm8Or8muJ2d03gHg0haeW7eUb5EScLawXq//sUkdD8N+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aahaOk90; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aahaOk90"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730326132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nM16z2bPKZDdfrvtYt7i8f8IPwdgNG8iF95zc+1oV7s=;
	b=aahaOk90CytyEj+ndNpHDsEIhM0MHtW+QObbMNn4YheajpHNqLxrie/KPIcuimomgMWXYC
	8xnYLxN5ZpKW7vqTW/qUQfyiE8d9tbGIMGMFJuh9U673SVBtaJOxBqSq9r2FjI9tr4P1Zy
	OyQnwlDmDko5qpkeiovrgNp+i42XUUc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-Goo_mSGCMEmgyRi0dh0Z6Q-1; Wed, 30 Oct 2024 18:08:51 -0400
X-MC-Unique: Goo_mSGCMEmgyRi0dh0Z6Q-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b17d635be6so56956685a.1
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Oct 2024 15:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730326130; x=1730930930;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nM16z2bPKZDdfrvtYt7i8f8IPwdgNG8iF95zc+1oV7s=;
        b=bW8BxuyFtuZEB+Rh77Hdkegb08ReMN0ui5pxJtSD3pVGRui/69xZUvRsUqf0VMg44n
         EQ5E2v1RULFopS9mXzgWvGFbkHR3MSCYaN3MvH1dIvc9VP011bGsY/WWjOOAv/PUFeYV
         BKjb1Hom/KqME8XcoG3AgNQ0kFI2/OY9C6+oFNo+9S14G4lh2Gv7l6UZXkJv8DTZeJ/O
         AoDuiQnt3BuRzc2iPd4Ol+vlHpZYWTa70SANY7nxuIsXmm7ZICu+6VKy1XxYtdibyopA
         OZLnGbHE4ckEIy3BuNvABzKbnl4uzMg+FfSTEwgDtI0Xhyq1bwGOrHXFdZ4R+A29RjjT
         BEKw==
X-Forwarded-Encrypted: i=1; AJvYcCXMVo1zYGF90EjlOynlrEQEW32z8Ygdgx9xchmekHR4xSvRXf23OYma7jq8RAHFTZ//LLrBDANfqsLYyVRKsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxcWE8C5MEzOh0px0WpRcjz06U1SRJ/7UgciIW4y60IvKqR7Rj
	elc7chWeKqRas3AasMd9mUAsyEyaYJDFdHvaWAb+d4Hjp8rB1N/M4tdLFaAgg74JC1B4CFgHwps
	xqAXMpX+9DUQJ3JXipklUHvgNOXXCUjvTTIPaS+/r4DepYGFP9hEMeWYAXIpaZpmg
X-Received: by 2002:a05:620a:c47:b0:7b1:516c:8601 with SMTP id af79cd13be357-7b1aed92253mr528993785a.20.1730326130543;
        Wed, 30 Oct 2024 15:08:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9pU+gqtdIpxz5rrLKAEIRqvd4i75+yfUEf9hj8zLTHNK/Nm8193qMpEUzzEC3XsESIbhyqw==
X-Received: by 2002:a05:620a:c47:b0:7b1:516c:8601 with SMTP id af79cd13be357-7b1aed92253mr528990985a.20.1730326130215;
        Wed, 30 Oct 2024 15:08:50 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a12489sm8443185a.65.2024.10.30.15.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 15:08:49 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:08:47 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org, 
    kernel-rts-sst <kernel-rts-sst@redhat.com>, 
    "John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH v2] tuna: Fix string syntax warnings with raw strings
In-Reply-To: <20241028215717.250390-1-jwyatt@redhat.com>
Message-ID: <67fb2f6e-15d5-6a16-f1bd-6cd194be7168@redhat.com>
References: <20241028215717.250390-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 28 Oct 2024, John B. Wyatt IV wrote:

> tuna save <filename> allows you to save your kthreads tunables to
> a file to be used by rtctl. There were several backslashes that produce
> an error that pylint and Python (at least 3.12) gives a SyntaxWarning:
> invalid escape sequence
> 
> Switch the strings written to the file with raw strings to resolve the
> warning for this section of the code.
> 
> Tested by comparing the diffs of the files.
> 
> Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
> ---
> 
> Changes in v2:
> 	- Combine the second lines of '\n' to be concatenated with the
> 	  raw strings.
> 
> ---
>  tuna/tuna.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tuna/tuna.py b/tuna/tuna.py
> index bd678e2..d4c3e2c 100755
> --- a/tuna/tuna.py
> +++ b/tuna/tuna.py
> @@ -669,7 +669,7 @@ def generate_rtgroups(filename, kthreads, nr_cpus):
>  # The regex is matched against process names as printed by "ps -eo cmd".
>  
>  ''' % filename)
> -    f.write("kthreads:*:1:*:\[.*\]$\n\n")
> +    f.write(r"kthreads:*:1:*:\[.*\]$" + "\n\n")
>  
>      per_cpu_kthreads = []
>      names = list(kthreads.keys())
> @@ -688,7 +688,7 @@ def generate_rtgroups(filename, kthreads, nr_cpus):
>              elif common[:8] == "softirq-":
>                  common = "(sirq|softirq)" + common[7:]
>                  name = "s" + name[4:]
> -            regex = common + "\/.*"
> +            regex = common + r"\/.*"
>          except:
>              idx = 0
>              regex = name
> @@ -701,9 +701,9 @@ def generate_rtgroups(filename, kthreads, nr_cpus):
>          else:
>              mask = ",".join([hex(a) for a in \
>                       procfs.hexbitmask(kt.affinity, nr_cpus)])
> -        f.write("%s:%c:%d:%s:\[%s\]$\n" % (name, \
> +        f.write(r"%s:%c:%d:%s:\[%s\]$" % (name, \
>                             tuna_sched.sched_str(kt.policy)[6].lower(), \
> -                            kt.rtprio, mask, regex))
> +                            kt.rtprio, mask, regex) + "\n")
>      f.close()
>  
>  
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

Thank you John Wyatt

