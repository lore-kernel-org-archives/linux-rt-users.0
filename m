Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0D133120E
	for <linux-rt-users@vger.kernel.org>; Tue,  6 Jan 2026 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706114; cv=none; b=Gg/21tajzH+bZsmsn0Shh1FThruEoUCVCaLoGSwJZHyJcIGcOy0FFZR1yVafMj+wT50ZBmxoGf1mAdGglLuPFCIN5xU7bnJ4Wt4mrwCVbQxiePiHeCxLWz8rf+Xfg7vlmeWlSRiAR7pZRCtByS9hZsgJmJsK9HBgRzEDPZu/cU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706114; c=relaxed/simple;
	bh=EaCHYfweswjcPjubdFaKYRw/C/RHhMnWX70288nY5Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBsNW6oCEpxxPZcvV21YewMtZPjr6U5qZtHJJzySO0KYBwNQcKKlCZqqsqhNC6s1bnBHnSuskRnVAEkSpPDZjRiMptByLAJxUHok5ImIkpg7V7wlh1/WdsEgVykPYLjf6SghIg+oKYM4ZTacdW9+Lxc3O++gfWl10kgJHgiu+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LJbCZe7N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJbCZe7N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767706111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wvnecLaW5FT9+7NB2+Q1VNeeoiI2qFwQgKifs2ZCPAQ=;
	b=LJbCZe7Nmm+QYf27Ynj0DiH5mn+/vSu3r0FAFwlptAysOMSdPsYXwj7SIF+dQrleoteado
	RKjx7XNOuOzQ9B94k05cVAmbzqs/DpscOLcp1UUXqKGepxCE6XJz5v1solXviJqEmEUJ7p
	BrtLVnonyCfSb1SNfFowwr5jY7Oxbug=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-yW_weEjVNV6W-jCnvKTO5A-1; Tue,
 06 Jan 2026 08:28:30 -0500
X-MC-Unique: yW_weEjVNV6W-jCnvKTO5A-1
X-Mimecast-MFC-AGG-ID: yW_weEjVNV6W-jCnvKTO5A_1767706109
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B671195DE48
	for <linux-rt-users@vger.kernel.org>; Tue,  6 Jan 2026 13:28:29 +0000 (UTC)
Received: from localhost (unknown [10.22.80.183])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7BABC180044F;
	Tue,  6 Jan 2026 13:28:28 +0000 (UTC)
Date: Tue, 6 Jan 2026 10:28:27 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>, Bart Wensley <bwensley@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: Re: [PATCH v2] rt-tests: hwlatdetect: Add MTBF calculation
Message-ID: <aV0N-zTclZAwy1Fv@redhat.com>
References: <20260106091023.1375803-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260106091023.1375803-1-costa.shul@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Jan 06, 2026 at 11:10:23AM +0200, Costa Shulyupin wrote:
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

Hi Costa!

I do like the idea of using the MTBF to better understand the latency
spikes patterns. But I have the impression using the Mean (way better than
average to avoid bias) could still be misleading. Let me give you a few
examples of my doubt scenarios:

Say that you see 10 failures during a 6h test, the first 9 of them happening
within the first hour and the last one happening 5h into the test. That
would greatly skew the MTBF result and wrongly characterize the most common
and periodic failures in that system. (Please keep in mind that I am
familiar with the concept of MTBF - My question is whether the MTBF alone
is enough information)

Another example would be a 30-minute test where you have a latency spike
every 11 minutes (inspired by NTP + efi-rtc for illustration purposes) and
at the last minute you get a spurious latency spike that happens once in a
lifetime. Is the MTBF a good representation of the failure (latency) profile
of that system?

If what I described above makes sense, showing both the mean and
median of the interval between latency spikes would be helpful.

Again, having the MTBF as you proposed in the code is already helpful and a
new data point. I was just wondering if adding a tad bit of extra data
would help.

For future enhancements, maybe even classifying the periodic latency spikes
per duration or a histogram could be interesting. E.g.: the 200~300us latency
spikes happen every ~15 minutes, the latency spikes between 2~3ms happen
every 11 minutes, ...

But that only makes sense if identifying/classifying the latency patterns is
as helpful as I think it is for debugging.

Best regards,
Luis

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
> +
>      if detect.have_msr:
>          finishsmi = detect.getsmicounts()
>          total_smis = 0
> -- 
> 2.52.0
> 
> 
---end quoted text---

