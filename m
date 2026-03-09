Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD73538E5E1
	for <linux-rt-users@vger.kernel.org>; Mon,  9 Mar 2026 22:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773094934; cv=none; b=NmQyrsIEEnK+TnyK/RpowpytNgHEy0PkcwFC+aEttCqqT9Nm8HPdA/SOR67G6Kxa7Wh32cShE/jOL/TLFIs9NUvapttlEb95gqowT6EnqZRs9H+2J9zFWifrgbo1LLk0fhHot0IkfrIqGVdNzX5k7VNliiitvVneNeFSCvjpC00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773094934; c=relaxed/simple;
	bh=lbYlYio7yRTLGbmrhTZno0aoYKpgCegKKayYiZWX1C8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GsAHPlhvsKRqZZ2TCJEtHC/zqM+K4iVTEVab3ytFphWDgB0VPUnh+SK7KwWLRD0Hjs0OxgYlQsAy1eYaLB4AAzF87AX2Fs/VsxiqFHpWl9YLBvgN0Vv3jMT04T4tBHL7QtWX8L64eVGVv4xpgKzqC7oowagOEnAJAXprHuas6iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irRl1at9; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irRl1at9"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cd751a4e93so177193985a.0
        for <linux-rt-users@vger.kernel.org>; Mon, 09 Mar 2026 15:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773094932; x=1773699732; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l/7spltg2PH1ogFLsR44bxsiLS/iSOb9Ymi0KBFbABM=;
        b=irRl1at9VVglUKrybsMxgmHZQx6L/7o1tEcpQ/QW77GRpUTV2hmyGX8kGuAruJdWiI
         YTODY0hiGO9e5XMl2xt98LvqlhgLVO5An9WCJqPQNkTCvEm9N+Afz4PlE/Kxurtg0rwA
         OaV+DqMyvP1J4LMNDDvqpaMALzavd0Emw1XeD14hAD91B5Q2ompEt+2F4QmonHVwTISt
         JLTDPTBsmVLCpoN0zN8I/rdCpt+BJirhIVldQyTYB2bS6oeKAOWiwGclfKrXIB0+yWwu
         73Ctqd2BHT3FmD1I2pxGrfzVR0H65N/N1cEM+NaNlC+kC8O7nwdcWJhfl5mtMbVK67X3
         1ivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773094932; x=1773699732;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/7spltg2PH1ogFLsR44bxsiLS/iSOb9Ymi0KBFbABM=;
        b=kHCNRYrdm49C0hsrrPCFheCXyPt8x2CwmXpaWMBKP1YSP+5ZWnYHg699h9vsyOkA4P
         E36jeU34G2b2Thh3sjxKBbUe/2ynV4SDq8uum5x4j4kOb0/srlnkDFZhhnSfEbU7a9D2
         xLAo9ztNCwMuXvjAm4h4xaqtT1ZbIYYOYstlQOYdhc0OKtjSq2XTCcKaSqHlHlDZH0Sr
         d7RTXa/F2ceDM7D8LSZ0jD8VLYRn+C4oDm0wq+gb276R6qW8DC5frEBBUMcYfQK7ud9p
         qXTwIL7T663MYLCf/8IuP6Mtbw7/F0DI5Id01K0/VA767InTOMLKK6l0rEbXkvk+rdln
         vEag==
X-Gm-Message-State: AOJu0YxYYhZkl8JMT+Rc+q5c0nltLwSexry5+pJLrCEt+yNEM3ETiT0e
	J1Q2kVf9eL220Lq6A4MRNFSyg6gIkLhQgVAiFJof4dlDGXIRpOSIomxILbB4ZA==
X-Gm-Gg: ATEYQzxUSduwAI7NVOzYuvU7fmNtkSqclIrQnPxdQE0JjH8zLM4Ghnbt8gbmY8IxZxs
	afEbdL1bJjKjQRVnHNwYyafR6L2zKR/3Hp8LjosSaYhqsm5yfxtFb+WOcGftk80P3VIay00KrA+
	glPNw3oipLh6z7pgIJj0xeISvZVsHcJRngBFrFUXawzWAQMrdf5pBpzBSDo+QzLJIxipbI3wDa7
	q1z2wD/7WD/+xj2xkgYSPBfKns7i5UU7EtxI+xmSI4hJ5GHgm4HCoa9CBP/Z9ACVESN8bzT3BRp
	zn95tzqlM/E/js5qINHymJExeUsgDmIHb5zk4c1KWpXNSZzWms0sszWd3wsU3j+G0cZdcJhSZDp
	OJxCRL0m5lPNK26tsS8wbgQNgVyaov3KixgkmmxtaG2qVZWpXQPOCM/Du4DoiAV0m37Flry1F0c
	51C7Y2W26Cq75w6CSCyMPhOY1EMGF+9uDrzBOLBqL7nlrQny8Kt8jRoXp7095Hoh5oiRZU13Krs
	Q==
X-Received: by 2002:a05:620a:f05:b0:8c5:2ce6:dae with SMTP id af79cd13be357-8cd6d371a2bmr1612168985a.29.1773094931703;
        Mon, 09 Mar 2026 15:22:11 -0700 (PDT)
Received: from Cumhall ([70.50.116.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f4840b1sm766860085a.1.2026.03.09.15.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 15:22:11 -0700 (PDT)
Date: Mon, 9 Mar 2026 18:21:59 -0400 (EDT)
From: John Kacur <jkacur@gmail.com>
To: Costa Shulyupin <costa.shul@redhat.com>
cc: linux-rt-users <linux-rt-users@vger.kernel.org>, 
    John Kacur <jkacur@redhat.com>, 
    "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v1] rt-tests: hwlatdetect: Add timestamp delta
In-Reply-To: <20260302193310.1712952-1-costa.shul@redhat.com>
Message-ID: <06a3f0b6-2cee-3ac6-8b0b-c63621a76c75@gmail.com>
References: <20260302193310.1712952-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 2 Mar 2026, Costa Shulyupin wrote:

> Add delta field that calculates the time interval between consecutive
> samples. For the first sample, the previous timestamp is initialized to
> 'nan' (Not a Number), so the first delta is also 'nan'.
> 
> This helps identify periodic issues during hardware latency testing.
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  src/hwlatdetect/hwlatdetect.py | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
> index 42b9f301718a..f95e771048f6 100755
> --- a/src/hwlatdetect/hwlatdetect.py
> +++ b/src/hwlatdetect/hwlatdetect.py
> @@ -253,7 +253,8 @@     def detect(self):
>  
>      class Sample:
>          'private class for tracer sample data'
> -        __slots__ = 'cpu', 'timestamp', 'inner', 'outer', 'count'
> +        __slots__ = 'cpu', 'timestamp', 'delta', 'inner', 'outer', 'count'
> +        prev = 'nan'

	prev = float('nan')


>  
>          def __init__(self, line):
>              fields = line.split()
> @@ -276,14 +277,15 @@         def __init__(self, line):
>              i, o = fields[6].split('/')
>              ts = fields[7][3:]
>              self.timestamp = str(ts)
		ts_float = float(ts)

> +            self.delta = float(ts) - float(self.__class__.prev)
		self.delta = ts_float - self.__class__.prev
> +            self.__class__.prev = ts
		self.__class__.prev = ts_float
>              self.inner = int(i)
>              self.outer = int(o)
>              self.count = int(kv["count"]) if "count" in kv else None
>  
>          def __str__(self):
> -            if self.count is not None:
> -                return f"ts: {self.timestamp}, inner:{self.inner}, outer:{self.outer}, cpu:{self.cpu}, count:{self.count}"
> -            return f"ts: {self.timestamp}, inner:{self.inner}, outer:{self.outer}, cpu:{self.cpu}"
> +            s = f"ts: {self.timestamp}, delta:{self.delta:.6f}, inner:{self.inner}, outer:{self.outer}, cpu:{self.cpu}"
> +            return s if self.count is None else s + f", count:{self.count}"
>  
>          def display(self):
>              """ convert object to string and print """
> -- 
> 2.53.0
> 
> 
> 
