Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EFB305046
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Feb 2026 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771534787; cv=none; b=fbYNFLtgzpPy6jmbB8vFay6ZEEbKtlUK8a+DWHy3jtKgp/15R7GJTxbgbMRFg28VDNBh2A2zrb4bbXWMB/Da/x/6xV170VDCo1ulir/QxL5D2QP7FC6cQH+bNsbMwWb9GDTKfL/uwMx6b/ZaCVluYPx9NoRZIAdOWHGANfbVRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771534787; c=relaxed/simple;
	bh=pD8H0WYTRW1o+y8pSVAfXCOx8TJwO5oDwMcqHen9u2w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Qp3Y0hw18PhICTdOx7qRFjbfvBqdmW7OX6lXiklLYSljDL0JIiSjx22Cm7Q4HozGsU+C+X1IaW08AJUCPj9AHJ4Nzd1UwmVulGPl9Wh9VwfZT64EGcR79yhZ0kOQ185IK91F+tVMJUlOhlzOkjmoGyev8S2EIOMIIT36UD3nJB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFeMstKR; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFeMstKR"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-896ff127650so22269506d6.3
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Feb 2026 12:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771534785; x=1772139585; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sxi4+a0eW6tFp+NCTA8B6g3PquzV6LDdu7PeBQsRb7o=;
        b=hFeMstKR8bIWl4nTpeRHUzPWfXqZkwwK7hzITQH1CQGP72lQrweC5+3WDs6fK1ERsE
         882oKt4FrSQgyQqLuBAafl4kpuXRi8P4obh2g0cv7FGv1Hr04ySsLf/1lM9ks9ZHs5nO
         lVxrpMe9PMbIkiWEAVo4umNJKmdDmABgnEVOi9c9DB1sIAfe+wSwviYyGv1Q7GdulO+w
         Hu+Px5Nd5msf+vSyk2rg6xXOBfBA77124udzOzMcqB/Eku21dr4m+mM4F3kLG2Rz4zmL
         HnSneJ6UXwc9sbKkak/DhVWbRWILBWX90q3zpCD2DamYYHASTBbXgxmukP6wQUoozyLz
         lczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771534785; x=1772139585;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sxi4+a0eW6tFp+NCTA8B6g3PquzV6LDdu7PeBQsRb7o=;
        b=PKuRGqanoZDDgHa0LWhzedy2PIJlr4VKJNtML4YQ8eqJ7qwwXgh/9Im13P1r0G5vty
         QtFsTycCWR3+i700bLWWvjMo0iH6L1s0u+48fh6xJFYMu20CgdPovBoYZQ1reSlP9NNs
         V3rguV7nCV8IYjAwMa9jCwUp9eXQejzwEMnKC20+g/75ePHbZEU+zKBs726Jfydaoecw
         ZHU/mXkbeW0NFavga/4grOEAFTM6xBwma3ko6R6fhQQVs8YXfHeqRDJh5xAcfpztdKvo
         dwEa/cfWqJgScWc4WbX5CI8FNrD95FWcorD0ScO4kuHgBWPnpqyUKPib125nHUd65CN+
         Z8mA==
X-Gm-Message-State: AOJu0YzM7R6k8aLEa2oBaTsxl4UTg61R1HLKKiAfDAug0V3JIBswAxZZ
	4Grh6fVk55RxQ+j9C9E5DFeO7ZKfpuWwBO63ARUpC/GdZPaYR+oFne6+
X-Gm-Gg: AZuq6aLW8UHHD0ye4kTPf9M00ojb3cA+9e6jiEKf+MXi71F6RSNpov5YVL17dS3np1z
	g/GwLjGO25oNVgbhyUFR2eScaCID0yaqgk3iMwE3Cv5HGW4Prt73CXsEpxDi0LkszNIqt3jrs+B
	XqemiyLtOb4HY0hORu29SWdpEqaBFIKR9YYPnRhBbfJ3VaX/czI1d6X07QZU8hqdz1+kVzE3ZcM
	8XQ5USolgkdqWPiP3tVfD3K0wwjbC4xqPUp88Fd3z4GOPJKP2tZZ/my6Rpyqs3LKzYrYNKu/R43
	T7QUm/xn/bDe36um/T1v4XKmc711bIzcoJuCc41CDhf6EKLEn4J0P+3telkQyUSpE4v7aXHysM8
	Tnk6tuGPbueOewvpglHU7tWWCPHiVrta+oIkVdFLfy7PbcZhqJFnhG8V0wjcHFVyJQ8QeYVutn/
	2oZEfcHcELoXOGPq5o2eMllgnpsOab8gG851L6LpVsNzppDS3HfT/G1TU8KsSpq2xUjL1jiZGYn
	WR27ofi76nl
X-Received: by 2002:ad4:5941:0:b0:895:54f:d87 with SMTP id 6a1803df08f44-897402c8e58mr305948746d6.14.1771534784659;
        Thu, 19 Feb 2026 12:59:44 -0800 (PST)
Received: from Cumhall ([142.189.59.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cddc120sm273172696d6.52.2026.02.19.12.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 12:59:44 -0800 (PST)
Date: Thu, 19 Feb 2026 15:59:43 -0500 (EST)
From: John Kacur <jkacur@gmail.com>
To: Costa Shulyupin <costa.shul@redhat.com>
cc: linux-rt-users <linux-rt-users@vger.kernel.org>, 
    John Kacur <jkacur@redhat.com>, Bart Wensley <bwensley@redhat.com>, 
    Clark Williams <williams@redhat.com>
Subject: Re: [PATCH v2] rt-tests: hwlatdetect: Add MTBF calculation
In-Reply-To: <20260106091023.1375803-1-costa.shul@redhat.com>
Message-ID: <7ed5c387-04b3-2086-5066-c7160b269355@gmail.com>
References: <20260106091023.1375803-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463749118-263486296-1771534784=:75424"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463749118-263486296-1771534784=:75424
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 6 Jan 2026, Costa Shulyupin wrote:

> Hwlatdetect reports the number of latency spikes but provides no
> information about their frequency distribution over time. This makes it
> difficult to compare results - a test with 10 spikes over 1 hour is very
> different from 10 spikes over 24 hours, but both show 'spikes = 10'.
> 
> Add Mean Time Between Failures (MTBF) calculation to quantify spike
> frequency.
> 
> By definition MTBF = total operating time / number of failures.
> 
> When the failure interval is large relative to test duration, this
> formula is biased.  For example, imagine stable periodic failures.  The
> total operating time will include time before the first failure and
> after the last failure.  These intervals are determined by when the test
> starts and stops, not by the system’s failure behavior, which adds
> measurement bias.  The resulting MTBF will vary between runs even for
> stable periodic failures.
> 
> To reduce this bias, calculate MTBF using only the time between the
> first and last failure, divided by the number of intervals (failures
> minus one):
> 
> MTBF = (timestamp of last failure - timestamp of first failure)
> / (number of failures - 1)
> 
> In hwlatdetect, the failures are called samples.
> 
> This metric enables meaningful comparison of real-time performance
> consistency across different test runs, hardware configurations, and
> kernel versions.  It can be considered a KPI for real-time stability,
> relevant for certification and SLA evaluation.
> 
> ---
> 
> Changed in v2:
> - Use another more stable calculation of MTBF
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  src/hwlatdetect/hwlatdetect.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
> index 68f312db639f..6d9db9aec933 100755
> --- a/src/hwlatdetect/hwlatdetect.py
> +++ b/src/hwlatdetect/hwlatdetect.py
> @@ -19,6 +19,7 @@
>  debugging = False
>  quiet = False
>  watch = False
> +first = last = 0
>  
>  
>  def debug(dstr):
> @@ -306,6 +307,10 @@     def detect(self):
>                  pollcnt += 1
>                  val = self.get_sample()
>                  while val:
> +                    global first, last
> +                    if not first:
> +                        first = val.timestamp
> +                    last = val.timestamp
>                      self.samples.append(val)
>                      if watch:
>                          val.display()
> @@ -527,6 +532,9 @@     def cleanup(self):
>      exceeding = detect.get("count")
>      info(f"Samples exceeding threshold: {exceeding}")
>  
> +    if exceeding > 1:
> +        info(f"MTBF: {(float(last)-float(first))/ (exceeding - 1):.3f} seconds")

exceeding = detect.get("count"), but now we have a count that isn't the 
same as a sample, you might have to rework this for newer kernels.

> +
>      if detect.have_msr:
>          finishsmi = detect.getsmicounts()
>          total_smis = 0
> -- 
> 2.52.0
> 
> 
> 
---1463749118-263486296-1771534784=:75424--
