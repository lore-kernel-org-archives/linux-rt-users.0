Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33B82E2DDD
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Feb 2026 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771532853; cv=none; b=uGicd6d0j6hgOVib1PeAFrKiUwCuEbY9YxcjHUFYOkoKVYxfom/ZvcJhmia/1cBSb6p1ycsoFZMwj2ia3Zjr2lT7kroNRV85UMObCyMEvpgpnv4KrZ9J29B4SF9/lJ7Cf+cf9iKcvxBEfREX+lpx9Ye32jWpPRSP7WRVSp8Fn0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771532853; c=relaxed/simple;
	bh=TkApw+/13YAWhZh3TrRViaTduuGXSjo3Iy6zles876A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SdDx98HAVWiZfM5AUWbBq9DLumTQl4CgXYEleXKFVY5xHjNwlryn3o1k8XAFmZ57UQDoKnbwjNDiHGR5lRM2+XLAlATjIm/LvNxG9Ynd73NDVyci5z750J2DYtukpZgyaiO57ej8UvreBvezaPBZjeFKh+Ljhzs629N4QKsX5Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxXf4Nle; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxXf4Nle"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8954c181830so15666346d6.1
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Feb 2026 12:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771532851; x=1772137651; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CYriQIU0F+utOjVClWaePgXORuUtWsr9qXUrfVJjiHw=;
        b=PxXf4NleCa8HpwhicQhew/vmjtrKw64MLBU8S8magjoNsNkuyGuRLnEaXyzycn3Gxp
         A2Fk8bHlMwI7sGxt/YN+FWfz9tFTbNz6W9djR6Ab3fFdH4tMJXsCoqKKESH0rFrkMwhm
         j+WY+EK3IFLzFxeHxUW2ChITjG6QWJZ4h13DiL1iqStwfM9nyyQrXm11Qjn5xsfAPUJw
         XItX8i5QH4S2Cdr5lVCAXm3/xotVjMtLPoIfmm8ItKiXAtTiitf2bg2wYeAl3UtTkEt0
         ZjASwQ3EqqWnyEphvszG0usyUKjf0QU5kUXEurIjMjQXCCTCJg6O+tNEu+SGb3Y8GpLu
         qevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771532851; x=1772137651;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYriQIU0F+utOjVClWaePgXORuUtWsr9qXUrfVJjiHw=;
        b=cckNBtMgLdb8zrFKgiN4pYhQGi3y6sfQuA3miiBysxA5NPKdP8nW/NPFuzqsZl3R58
         TYv/kV2EDDh2SUuYo31OT5GBo/3sD+ngivYCoNlUKtI7Nvodlxwe2nRN3mK5mSJ+WmYg
         32o1a2ktGGqPHAQcjhQWUVTdKIoJ0ZuG0PKaT3yNSg5tNANnspVW7am6qxpBSMIK/ACe
         bvuGEgo9JeApuOjy5gisNw7UohEUKZ6gCu1FstE2UBM82bQtnegMWQskWkSI/LRq8eFq
         DV2FpnnHmM3sD0yP1peRW1mAZ9nVHy/Kb0hnbOn0jBq2b87KSKaXWQQT5ikruDhfa6UT
         s+dg==
X-Gm-Message-State: AOJu0Yz7u4Sm93X55odI6NWcUj8IVMQtk3N1VziKtiwDojeyeYdgDML/
	dCW2BEjYfDERq1zwni0dgEUKoe9bOFJIWSkbqjFfVyU7sEi7lDqZGfpu
X-Gm-Gg: AZuq6aKPD1/myivl1PbvG4nzaD/fpDpzOI3HRpHu6yh3GqIHqkBaJBRYjAGH7f34cCF
	t2/olJrKfzeE0PMdJTFOHzZlIdBOT2uI6Bz1W+IRIY1GqeKP725F6ThLkHIR7HIJO35aJ5RJO9M
	DzQgOWtkDb2bPF28iKJCO0OQ003yJRZssD2rMGv71kwQXCg6av+t1Uxyr3QFb76o0JEpHTk3bOb
	UwN6ANp0frKEgM9PStYqLueMT7l8xaSu2SrwiqPQXQ12zKHa/aow9JSnEiPduaDyFZI30tkjxyF
	NeSMV3AxGZIAl+pFyWAlhRb4YdQtRDVBWMrecbn5ZX+S69Df/ieTosFdcuZFRyE1nwzPDORKSt0
	6K3DvZHCphUVTDK8Z4FeMFczct+oGmVcyKfrTOu/veOjMPJKyaKgCZDkJRL3zpj8QuBN8xQ9pX6
	3hgVPc0PXNC+cGNo1glIQQNiE61KnG/LJKV8mwmVlhRhrYEvl8MqwcNaiVpuDuIMDB9aZoXYgRv
	g==
X-Received: by 2002:a05:6214:c21:b0:895:4852:ef49 with SMTP id 6a1803df08f44-8974047b877mr267688006d6.34.1771532850681;
        Thu, 19 Feb 2026 12:27:30 -0800 (PST)
Received: from Cumhall ([142.189.59.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc823a4sm213161886d6.8.2026.02.19.12.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 12:27:29 -0800 (PST)
Date: Thu, 19 Feb 2026 15:27:27 -0500 (EST)
From: John Kacur <jkacur@gmail.com>
To: Costa Shulyupin <costa.shul@redhat.com>
cc: linux-rt-users <linux-rt-users@vger.kernel.org>, 
    John Kacur <jkacur@redhat.com>, Bart Wensley <bwensley@redhat.com>, 
    Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RESEND v1] rt-tests: hwlatdetect: Add field count to
 samples output
In-Reply-To: <20251016181933.418200-1-costa.shul@redhat.com>
Message-ID: <acbf295f-1eb6-a5df-9ab8-52da187f6d56@gmail.com>
References: <20251016181933.418200-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 16 Oct 2025, Costa Shulyupin wrote:

> Kernel commit b396bfdebffc ("tracing: Have hwlat ts be first instance
> and record count of instances") adds field `count`.
> 
> Add processing of `count` field to hwlatdetect.py.
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  src/hwlatdetect/hwlatdetect.py | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
> index 68f312db639f..af9852cc95e8 100755
> --- a/src/hwlatdetect/hwlatdetect.py
> +++ b/src/hwlatdetect/hwlatdetect.py
> @@ -38,6 +38,17 @@
>      return ','.join([num_hex[max(i - 8, 0):i] for i in range(len(num_hex), 0, -8)][::-1])
>  
>  
> +def key_values(fields):
> +    """ Extract key:value pairs from a list of fields and return them as a dictionary """
> +    return {
> +        k: v
> +        for field in fields
> +            if ':' in field
> +                for k, v in [field.split(":", 1)]
> +                    if k and v
> +    }
> +
> +
>  #
>  # Class used to manage mounting and umounting the debugfs
>  # filesystem. Note that if an instance of this class mounts
> @@ -242,19 +253,21 @@     def detect(self):
>  
>      class Sample:
>          'private class for tracer sample data'
> -        __slots__ = 'cpu', 'timestamp', 'inner', 'outer'
> +        __slots__ = 'cpu', 'timestamp', 'inner', 'outer', 'count'
>  
>          def __init__(self, line):
>              fields = line.split()
> +            kv = key_values(fields)
>              self.cpu = int(fields[1][1:-1])
>              i, o = fields[6].split('/')
>              ts = fields[7][3:]
>              self.timestamp = str(ts)
>              self.inner = int(i)
>              self.outer = int(o)
> +            self.count = int(kv["count"])
>  
>          def __str__(self):
> -            return f"ts: {self.timestamp}, inner:{self.inner}, outer:{self.outer}, cpu:{self.cpu}"
> +            return f"ts: {self.timestamp}, inner:{self.inner}, outer:{self.outer}, cpu:{self.cpu}, count:{self.count}"
>  
>          def display(self):
>              """ convert object to string and print """
> @@ -286,7 +299,7 @@     def set(self, field, val):
>  
>      def get(self, field):
>          if field == "count":
> -            return len(self.samples)
> +            return sum(s.count for s in self.samples)
>          if field == "max":
>              max = 0
>              for values in self.samples:
> -- 
> 2.51.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

