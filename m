Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816242B9D8
	for <linux-rt-users@vger.kernel.org>; Tue,  2 Apr 2024 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712090410; cv=none; b=f4WjrpgIYYYXAm0mIFA21vPPEgwFweLrq+7eLcH58vDACSLr0Qt+LGo9wOP2WuLQUSfX6zyQWXTBx2/ImAqf2uM5ER1+/ULZNLikSUKwpgIn5xGUHg7uLB1MT5Wh7F7p8k8cB6bnJ02e2O5eoPtFyRKnXe6dn2wJnwgcHLutblU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712090410; c=relaxed/simple;
	bh=d3PQI1nGjYR2wxpceb71VKk6aoSFhnRn54QOfdJajw8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GHOvdxNIA91Pv0hgiXLIINDPj6jXouqVBV1q+ScePCuwDj0rA0JEbLJMk75pvaUBHUevf7+zFqaDeq2gHYsGLirGxAD1PChK6JTmNEzJfZAV7LSClcFNM3KYYrFsc9LU+sGwK/4yvObQymCc50x5vwOmAkdpllmN9dD4cznkgng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWlI4VDj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWlI4VDj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712090407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DsgO2gqGRq2OmbkYbX4mo/EkDNI9DMlX/n+pXx23DiQ=;
	b=ZWlI4VDjSF+Tb66y+PbXb0OvxwiolXLUZm+IJlMwVcdu77OtTO9TmiI0EXgCcXZuPrkn+3
	K6688OFCEJmwsZd12wItBuok+K1fjE//ZqHfpHm2hpO9vb8OsLsrTnN+5XvFJq1sp8GAtn
	o486REadG43WE8Gx1Q3WMYhArR+D+Ww=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-6e8EwxfLMPurVVpmSqQxLg-1; Tue, 02 Apr 2024 16:40:06 -0400
X-MC-Unique: 6e8EwxfLMPurVVpmSqQxLg-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-4da8259e984so124733e0c.1
        for <linux-rt-users@vger.kernel.org>; Tue, 02 Apr 2024 13:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712090406; x=1712695206;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DsgO2gqGRq2OmbkYbX4mo/EkDNI9DMlX/n+pXx23DiQ=;
        b=q9u2ghSVjg4wjZCh7dRb3SkeZWG/i4BcbydZ99XPNKC7BrzwkPyRN6sNQa+LMZzH8L
         ++7GG4O9Ex6tzEZf07K/BsfaPuTk9pr4o/OoHyvYokBpHGegBdUuMcBrro0GF3zzqBud
         TL2P49tLtVlMWf4InROjbvJqa1WZhigDu7xnmnHrNEgNWRyhXCh8NQU2Olfo36mPb28u
         Bzr3hE9lyOA4AWW+0TrbK8PIYC3f0H8CEDp9EgsphipgJnZ74q4fm8G/IkU502ZQYtsG
         wflOR5bB+Gy/ToiRyvg8GmQJNoRRpr7kOC/7+ebg7NGj6U68TUiOzVypxSgYUrPKov7N
         qH7A==
X-Forwarded-Encrypted: i=1; AJvYcCUKh7ysWZ4X6gtZnJ60+B7whmSZYg8dZoXAZyJeGhLxz3Ea2l7GVsgbbsi+UMALWO39nVdFyuQ2s9TvrPrBNW5lmTnTko3AFt3HrBFcVHs=
X-Gm-Message-State: AOJu0Yx0ka4lw3uG/+6jg+rg5DiWDR2iCTZNmqD2Fq9rVkxZSELcQ64I
	DsLgr4A0ecEjaEs/lBZkBmbPc9fnucUQITmEWbPRElcIiEkijwUHiOqKV/bg+7HafcEPuyLDR7T
	yt4nJmSE0UnfKASeMd5MalnCkleu9TG1mHLRMZgPAonrTQKMskC5Rh7nmLqVHinwn
X-Received: by 2002:a05:6122:3bc9:b0:4d8:7a5e:392f with SMTP id ft9-20020a0561223bc900b004d87a5e392fmr10251474vkb.12.1712090405758;
        Tue, 02 Apr 2024 13:40:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh3YhuRRrKnioSOe726GE84/8fZ6XcK7cg3cw/jRON+q13GRtyoJfHIuQ8gp54y+evvvgFjA==
X-Received: by 2002:a05:6122:3bc9:b0:4d8:7a5e:392f with SMTP id ft9-20020a0561223bc900b004d87a5e392fmr10251470vkb.12.1712090405513;
        Tue, 02 Apr 2024 13:40:05 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-08-184-147-142-166.dsl.bell.ca. [184.147.142.166])
        by smtp.gmail.com with ESMTPSA id gv5-20020a056214262500b00696b1050be8sm5823591qvb.133.2024.04.02.13.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 13:40:04 -0700 (PDT)
Date: Tue, 2 Apr 2024 16:39:58 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 4/5] rteval: Break out of main loop faster on
 interrupt/stoptime
In-Reply-To: <20240304211655.20174-5-crwood@redhat.com>
Message-ID: <8f2a4613-e273-3328-acfd-8a46729ffd75@redhat.com>
References: <20240304211655.20174-1-crwood@redhat.com> <20240304211655.20174-5-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 4 Mar 2024, Crystal Wood wrote:

> Waiting up to a full minute for rteval to stop on ctrl-c can be
> frustrating.  Likewise, if a very short run is requested
> (e.g. for testing rteval itself) rounding it up to a minute is
> not polite.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
>  rteval/__init__.py | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/rteval/__init__.py b/rteval/__init__.py
> index 5d43615af5bb..72e3412a860e 100644
> --- a/rteval/__init__.py
> +++ b/rteval/__init__.py
> @@ -32,12 +32,11 @@ RTEVAL_VERSION = version.RTEVAL_VERSION
>  
>  earlystop = False
>  
> -stopsig_received = False
> +stopsig = threading.Event()
>  def sig_handler(signum, frame):
>      """ Handle SIGINT (CTRL + C) or SIGTERM (Termination signal) """
>      if signum in (signal.SIGINT, signal.SIGTERM):
> -        global stopsig_received
> -        stopsig_received = True
> +        stopsig.set()
>          print("*** stop signal received - stopping rteval run ***")
>      else:
>          raise RuntimeError(f"SIGNAL received! ({signum})")
> @@ -208,8 +207,8 @@ class RtEval(rtevalReport):
>              currtime = time.time()
>              rpttime = currtime + report_interval
>              load_avg_checked = 5
> -            while (currtime <= stoptime) and not stopsig_received:
> -                time.sleep(60.0)
> +            while (currtime <= stoptime) and not stopsig.is_set():
> +                stopsig.wait(min(stoptime - currtime, 60.0))
>                  if not measure_profile.isAlive():
>                      stoptime = currtime
>                      earlystop = True
> @@ -238,7 +237,7 @@ class RtEval(rtevalReport):
>              signal.signal(signal.SIGTERM, signal.SIG_DFL)
>  
>          except RuntimeError as err:
> -            if not stopsig_received:
> +            if not stopsig.is_set():
>                  raise RuntimeError(f"appeared during measurement: {err}")
>  
>          finally:
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

