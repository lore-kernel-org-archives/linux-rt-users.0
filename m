Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510536;
	b=0xLELnWYZ+9bUuQ2DiigRKw/XdjSehD8Tbst4iXLvasoXpdPgan49z/vu/bxy5/hwhei
	 ZSuZC8C2oMKHpMcgRtA8jHZPKokjk/85uuOLS9oKG3HwHt99B/zvOVvIXazXhrbfe9c6F
	 oduHoisxdZALWnGBEYbHwrv18R+nMVxFXB/rUXt0IGnIGghMv2knaPgo9BwlZXSYyvt3t
	 kF7Aw6bvQFf443PlKsz7g9R6WuAttKltydkSJWPTOVT/kgOxCvxEJhVmnsiIB/ua/l9Im
	 vqUc60tYw4Y60B2x8cGoRU9OH4XeKTaF2Wg0uTps8pCiCn0e56uD+cMaMmzlfbnaglg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=RjhvmF5HEb05/Yvpj4XGwv2fVmIKxeIWCKHqFD2OJeQ=;
	b=NJtNr87VZVw7srMfzZN+N4L3xa7dyRFHobUVyo8o+D+gidmRo7cHihCVg90GAICiwcKo
	 9VoOWtZZy5CadxelK3MNN1f0qgr4keZ29D+vdTImUYzKCZuYNGJtPhlLD0l0L1/K1WOtl
	 fvrW2QJ/8qd2TuxfCDn3XrEwxfCtxuyjtvr8okRmlqEWvAVaib5pvjAO/R7Tjf/LfmfzW
	 hZ3zBWg6ZKbTzhKSM2CD0dP1BqxGqnKirMYCUdZnoRTZ2LPl8QfqhW2Th5I2bPOxqaRrJ
	 TU+pQgjpfpCUV5X9XFqI8OHmH7kA9yv2KmPoD9nfzLwQOlYAeR0PkUffy6GluAkmrBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RDsVtmdc;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9C6606A321
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Nov 2026 19:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C9C6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RDsVtmdc
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53fdd2fb171so489091cf.2
        for <linux-rt-users@vger.kernel.org>; Thu, 12 Nov 2026 11:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794510535; x=1795115335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RjhvmF5HEb05/Yvpj4XGwv2fVmIKxeIWCKHqFD2OJeQ=;
        b=RDsVtmdcQzuLR6P+4cazN+yJLspwjYkpsI0ThFP6bVRhw6rMg023Pvs09dyB9QnD3B
         N+ZNjwwVqgOcd12zVINaNJi18a8ANO6F5H6HVNokChUbYSSASQXcgYRRGD7VIkGl/P8P
         k6nMQE88adv8P59MRSXuhaVue6a5sWuoQhfDC0/1fXnwSLcpNGY5dYEtkJfaApzDxJMo
         juKTOJug5GIaTh0qJLjJfMTdCDbDTu+ZRAGKE9sAGCzbtVvEsXnI13Dm+yVtAoG7T0I2
         WZ5fQAol7UEqgP6zXSMhOG0WpSEVvFV0mymtp9lOB+HDS+Kv7QZRldSjxPUCiNVjOcEU
         XZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794510535; x=1795115335;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RjhvmF5HEb05/Yvpj4XGwv2fVmIKxeIWCKHqFD2OJeQ=;
        b=o89YV9mS0ptiLS0k/n9nRfbu6wQvf8TqaY4KZ2npL7d3jFeVV9qxa7KRLGawCs+sqB
         X7yqLlqdOyqPMtGRyDBHovaBhCBLelnI8McNv59JWgZD8KgXlG2R5EEdzo5/NbS05ZPn
         eforU49v2eohENVRMuZyv9mycKJrDqKuc+FiSc+zT+3RpCYTfIraR8CPjWomi0gJ9K9g
         4YPPu9wUFwoM61EHGACb/xFAFTvOtR//lRm2VuOSUj1qaAQGgTRh3y6WISv7+NghjDnL
         IvNkXmZfH74FrbafXgz6AE0Sx6F8PM2cKjjXXDgzX49bEHMvvboTCd8KPgm4SDJj52cK
         O3dg==
X-Gm-Message-State: APuU4Z+FLjBwLPC066/2hj6yKnx7Ojmaj8xJoCe8ysZALj8rnklgvO7v
	W8CHGez4kp65Uwf2KFB7MITga9ERIN6+LXpgQ02I1fRZ127zCVZ3XzQrVdCQIw==
X-Gm-Gg: AYBFou3sgs5M3L6P0Gcj+2Iav2Hx9ZH9XUEQecC5F1p1ysnIyShpp8rR1eIaTv7NZQ7
	GHBlXTkHgwSDfgsiEzs/EYYVdigiFyDXvuxd9TZduW2RAC+GoJ/LxvhPcdGEMq5uSphvYeR/9+8
	NaXQ7x9ON43cUslRTyc9snb1Wg223wrd9MZ6J6uQJ0rmHeptnoXvNZPrZSCi3pibI2o3IJKPTlY
	HfIHzkjw+d0X+3SvXGMOdOabp6pOj3CBUJRit7l71RuljipY+l8LUtzE5QcyTAkodk+RVSqfuVV
	OUXaZk+qjpLsQDCwW/ZAT/q6GhrtMDSv2BxTogTr6iI9zsfPXkQNQqDT5YfVyIfFEgfQZ2LRbea
	EYImZEhzBa6ig00ytUkGfyjoD/t93rpcIOBks896s+JpCSx/BPfE/YtGJpzVzi8aZXIzUxu2BiB
	pf8K139MxePcigfiPwVD5+oPEAQTzizG6FuWAY2oDE3ujwsX+XBaJ7Y0NchcnIfbz3vjO8X54ca
	6jX5wOgokWUojbjQD5rTxG27E1Ra4jTNRKedxC2HRIsqlkzl21B0pN9BJUXFSoF9T4VduxXSE+k
	KoTIiPXBuf4hFcgO2XIY40PE9g9wb1l1/5xw2mZ3eVBqzvbxW/enjmVX3kk//Hyu7UVLq+G9hQj
	PylobLmqC1xDZd0w=
X-Received: by 2002:a05:622a:e144:10b0:55a:df3b:38d4 with SMTP id d75a77b69052e-55adf3b74d2mr976781cf.75.1794510535008;
        Thu, 12 Nov 2026 11:08:55 -0800 (PST)
Received: from fionn.redhat.corp ([70.53.46.49])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad0534196sm1604811cf.9.2026.11.12.11.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:08:54 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Sana Sharma <sansshar@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	darwi@linutronix.de
Subject: Re: [PATCH v5] rteval: Add multi stressor support
Date: Thu, 12 Nov 2026 14:08:39 -0500
Message-ID: <20261112190839.71376-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <avTIInVsSYe4YhSa@sansshar-thinkpadp1gen4i.boston.csb>
References: 
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 11 Nov 2026 at 02:55:14PM -0500, Sana Sharma wrote:
> [PATCH v5] rteval: Add multi stressor support

Thanks for the v5, Sana. Moving validation into __init__ so sys.exit(1)
runs on the main thread, the clean exit in validate_stressors(), and the
subject fix all look good. Unfortunately the new 'workers' handling in
__init__ introduces a regression that breaks the default run, so this
needs another spin.

1) stressng now runs on every rteval invocation, even when no stressor was
   requested - and then crashes.

   'workers' has a default of "0" in ModuleParameters(), and
   SetupModuleOptions() registers the option before argparse runs, so
   self.cfg.workers is "0" on every run whether or not the user asked for
   stress-ng. This block then unconditionally clears _donotrun:

> +        if self.cfg.workers is not None:
> +            try:
> +                val = int(self.cfg.workers)
> +                if val >= 0:
> +                    workers = str(val)
> +                    self._donotrun = False
> +            except (ValueError, TypeError):
> +                self._log(Log.WARN,"Stress-ng workers must be an int >= 0")
> +                self._donotrun = True

   So with no --stressng-stressor/--stressng-stressors, the stressor block
   above correctly sets _donotrun = True, and then this block immediately
   sets it back to False. Two consequences:

     - stressng calls set_exclusive(), so once it is "will run", Start()
       calls set_donotrun() on the other loads - kcompile and hackbench get
       disabled.
     - _WorkloadPrepare() then does `for stressor in self.cfg.stressors`
       with stressors=None -> TypeError: 'NoneType' object is not iterable,
       and the load thread dies.

   The net effect is that a plain `rteval -d ...` (and `make runit`) with
   the default config no longer runs its normal loads. On main the
   no-stressor case leaves _donotrun = True and stressng simply opts out.

   _donotrun should be decided only by whether a stressor was requested.
   The workers check should validate the value and, at most, set
   _donotrun = True on bad input - never clear it. Something like:

        if requested is None:
            self._donotrun = True
        else:
            self.cfg.stressors = validate_stressors(requested)
            self._donotrun = False

        if self.cfg.workers is not None:
            try:
                if int(self.cfg.workers) < 0:
                    raise ValueError
            except (ValueError, TypeError):
                self._log(Log.WARN, "Stress-ng workers must be an int >= 0")
                self._donotrun = True

   Note int() already rejects a negative only if you check it - the v5
   `if val >= 0:` has no else, so --stressng-workers -1 passes silently and
   -1 is handed to stress-ng. The raise above closes that.

2) The 'workers is not None' guard I wrote out last time is still missing in
   _WorkloadPrepare():

> +        stressors = self.cfg.stressors
> +        workers = self.cfg.workers
> +        for stressor in stressors:
> +            self.args.extend([f'--{stressor}', workers])

   If workers is ever None, self.args gets a None element, and the
   `" ".join(self.args)` in _WorkloadTask() raises TypeError (not caught by
   the `except OSError` there). The "0" default happens to mask this today,
   but it is fragile - please guard it as before:

        workers = self.cfg.workers
        for stressor in stressors:
            self.args.append(f'--{stressor}')
            if workers is not None:
                self.args.append(workers)

   Relatedly, the `workers = str(val)` computed in __init__ is dead - it is
   a local that is never read, since _WorkloadPrepare() goes back to
   self.cfg.workers. Either use the sanitized value or drop the assignment.

Minor:

 - validate_stressors() docstring still says "Raises: ValueError", but it
   now prints and sys.exit(1)s. Please update it.

With (1) and (2) sorted this is close. Thanks again.

To make this easier to check against, I'm sending a test patch as a
follow-up to this mail - it adds tests to tests/test_stressng.py that drive
the Stressng class directly (not just the module functions), covering the
_donotrun opt-out logic and the _WorkloadPrepare() arg building. Three of
them fail on v5 as it stands and pin exactly (1) and (2) above; please fold
them into your v6 and make them pass. The multi-stressor arg test already
passes - it just keeps that behaviour from regressing later.

John
