Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CB644CF5A
	for <linux-rt-users@vger.kernel.org>; Thu, 26 Feb 2026 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772138253; cv=none; b=DigBULc5sTO0UIyUvJlyroionIeaP6kqP8+qqVX/YALIOT/Xl4NkZUtzIcaAGu/V1RBAD0B/M//p1Jc4jG76xD44fsG6c3oPXZ7esTMDnhdAMRNF8OW16gLg5fGXb45ZBMwEctdNTxYp8//eh7t38kspN4OEt62tGveQdGHckl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772138253; c=relaxed/simple;
	bh=2AB6E+Ihxd8NhEP88KMnodQfI10RWMCfnM8jObwdBFY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rAwTeFnYw8Z7p46YvFUyi/JqlYJtS8+WkY0jfitiYHbNaBFegN4lhvKaVWk1NjuiEu5gWSdG/iuoW1iFp10+NUWwsJOH8IrFcmwDjQojmjA6TGLdLCRvNycBK13VwRQxfqbUKh/fWrCHyT6uSP8Qj2LENguWKKuoIfQc0TvdQJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKcsQ2c6; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKcsQ2c6"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50697d6a69cso7319001cf.2
        for <linux-rt-users@vger.kernel.org>; Thu, 26 Feb 2026 12:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772138251; x=1772743051; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mM+8dkcLW628FsJ6DgygFDY4qnWqoI//cFkFggwuMjU=;
        b=DKcsQ2c6rXkJetWtuommdHYHHfTznQY30JQqdF8asY9qWtmW2EOB3Is0jQtzvAP5gQ
         AP5lEeLXAdk3w6AKYZfYlo9BaJuWWM1Dabzdg1dplpV34V6hh+3akxsPDmKXzUB9DE7D
         wdbECuSMO9KZEKjC94fQvb1qyEsy8ATt2vussKJ/voCnbnL8vaWMIVfuYijt53Q5MKZn
         xZsS3YJcERtRwntNmwNzMbqDGrGIQPPW7qZC6bUE1+X1z9eL31xZiT0Kew70kheFE8n2
         8FqVpl8ddOX3oLud+I0v5AJ+/g/oY0u4Z5ztpHHbO6+vD5diTeRLYsznwSWzJtygPjrQ
         KTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772138251; x=1772743051;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mM+8dkcLW628FsJ6DgygFDY4qnWqoI//cFkFggwuMjU=;
        b=nrdiCsANEYBbpSXjpUU8vpfXc44c0jfopanq9Arx/5M/wEI6wZlb4po+QpRObGdlLE
         IYwO7jxSOLO5/KL12MJjtAbqK0BRYLMuw12rsqqP8zlsn2Sdhf/+wemUnr2shALxnAQX
         XKH2WuowpDKbHDSOkiacSW6K2MbAXsLfPKH4hv7IEiFzCVXQ99glWzIRBpCtL2nohHzU
         e4VVpwOwcE6Lk90dkjsbCCjYT11xZKHN3aYOCC1U3Dz/Hi2ytqHKERwd5vqBHqWOV9D5
         Ndi1erEfUBEcQjiUd0nvcLpb0WO4C2YiERpLk/9rkH0KINRS8H93lrhZWqnnfm1bakZc
         fxlg==
X-Gm-Message-State: AOJu0YxXmX48TKMUbMoGJQ/TnQfdAgFCaiZpRhw0gVh4KN3uFSBxlzRZ
	TW96WZxD0xQC00u7Km3o48lB2mOtQ4aeiXxohz3H9jzHTZL1g0nqgj8FG9MOxvoC
X-Gm-Gg: ATEYQzzC/ihzKoA/F5pbcWKoIRySztykfgf1PuImZ4DQJxior4FAo6buokLBcPMLPA0
	DDybzJBlwGVmo05L6DL3GgFmU9LK5IlfMyFyjH8YqlEUqsLTo47bcS2LlOjmwOgFdpWuFBnkVZQ
	67gyCpddhJtXqaemliygzFPQRJ/Xpr4Se1+DY/mRYuLCm6IasLuoG2tfUbdCcnJwK1i59+OMf03
	bNtigrhychaM9YONE9UYGmAyolEscN7oUt/HGhMKwOj84UkGijzcQJogLhWdHUvwLqv9e8FNSYS
	VbcUBfH1ckyfpzLPWQ5CYvYa/4Q2ukFaUGt6Espup8UXLLjK9kpJyDVOl4rI0hRlMQdtD9jI1js
	vXRs8lIzKfAZhEH9zfhTlbWbEPhP3X+6hopX7T3YvMPkoMJSUWAOKvETd/M4Ob0gO+JZaDu375e
	eOX+n+Q9PFFj+oGakf5BU6b7M8EOg7ywAJucypqwld6sAXdvcYCyqfNkC0tgBHrh1VfZSyLxabJ
	Q==
X-Received: by 2002:a05:622a:1896:b0:501:1466:8419 with SMTP id d75a77b69052e-5075289dd8dmr3934281cf.29.1772138250837;
        Thu, 26 Feb 2026 12:37:30 -0800 (PST)
Received: from Cumhall ([142.189.59.50])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744afa7d7sm27516721cf.32.2026.02.26.12.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 12:37:30 -0800 (PST)
Date: Thu, 26 Feb 2026 15:37:28 -0500 (EST)
From: John Kacur <jkacur@gmail.com>
To: Costa Shulyupin <costa.shul@redhat.com>
cc: linux-rt-users <linux-rt-users@vger.kernel.org>, 
    John Kacur <jkacur@redhat.com>, 
    "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v4] hwlatdetect: Add MTBF calculation
In-Reply-To: <20260225133232.756608-1-costa.shul@redhat.com>
Message-ID: <29ea4c85-1ce6-ada8-3cdf-dc6ca79f432c@gmail.com>
References: <20260225133232.756608-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 25 Feb 2026, Costa Shulyupin wrote:

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
> starts and stops, not by the system's failure behavior, which adds
> measurement bias.  The resulting MTBF will vary between runs even for
> stable periodic failures.
> 
> To reduce this bias, calculate MTBF using only the time between the
> first and last failure, divided by the number of intervals (failures
> minus one).
> 
> Additionally, hwlatdetect only samples during the 'width' period within
> each 'window' cycle. The non-sampling periods contribute to the error
> margin. The MTBF is therefore adjusted by multiplying it by the ratio
> of window to width:
> 
> MTBF = (timestamp of last failure - timestamp of first failure) * window
> / ((number of failures - 1) * width)
> 
> In hwlatdetect, the failures are called samples. The failure count is
> the sum of counters from all samples.
> 
> This metric enables meaningful comparison of hardware latency across
> different test runs, hardware configurations, and kernel versions.  It
> can be considered a KPI for real-time stability, relevant for
> certification and SLA evaluation.
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
> 
> v4: Adjust MTBF by multiplying by the ratio of window to width
> v3:
> - Fix formatting
> - Make first and last instance variables
> v2:
> - Use another more stable calculation of MTBF
> ---
>  src/hwlatdetect/hwlatdetect.py | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
> index 38671724f3e3..abfbb954fe75 100755
> --- a/src/hwlatdetect/hwlatdetect.py
> +++ b/src/hwlatdetect/hwlatdetect.py
> @@ -306,6 +306,8 @@     def __init__(self):
>              raise DetectorNotAvailable("hwlat", "hwlat tracer not available")
>          self.type = "tracer"
>          self.samples = []
> +        self.first = None
> +        self.last = None
>          self.set("enable", 0)
>          self.set('current_tracer', 'hwlat')
>  
> @@ -338,6 +340,8 @@     def detect(self):
>                  pollcnt += 1
>                  val = self.get_sample()
>                  while val:
> +                    self.first = self.first or val.timestamp
> +                    self.last = val.timestamp
>                      self.samples.append(val)
>                      if watch:
>                          val.display()
> @@ -559,6 +563,11 @@     def cleanup(self):
>      exceeding = detect.get("count")
>      info(f"Samples exceeding threshold: {exceeding}")
>  
> +    if exceeding > 1:
> +        mtbf = ((float(detect.last) - float(detect.first)) * int(detect.get('window'))
> +                / ((exceeding - 1) * int(detect.get('width'))))
> +        info(f"MTBF: {mtbf:.3f} seconds")
> +
>      if detect.have_msr:
>          finishsmi = detect.getsmicounts()
>          total_smis = 0
> -- 
> 2.53.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
