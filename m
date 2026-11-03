Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730520;
	b=Oem4HLLeoMOMEu+NbiNw6EYupxtq4xKH/s6D2+om4SdkiE3Z2lTWq5ys9urOB1y53B1Y
	 BKV7rUZ2PfECwDR6QzaYOG2uLIHEG9nxv3mK1AAFhOl7fCQjZYbrTkwMbRnrlUot9YGP4
	 JMPlfuVotMcwjqSwdIm5echcrInlm0qjFpFqTfJm/LicWgqxvW1+lwkx0wUp1W8utBPRC
	 H07sI6lQO2pNXyXzxg51DyziZW9cKOz2usuJREDyu7sZb2paEtfLGU+gz8GavXD3YHpR9
	 k1UphQAOwpHMgfRMhKoZlBOrBQK70e+MSsU4+FP1BiOMPhtCUCF/TgxaWfyNAeVK9Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730520;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=/P9l0XzUDKBxfbJYNFsurl3JtxLLNN6HBoUEFo1Tkp0=;
	b=fOp8qZDWJule40UZ1RqkZJ27T14RtEuscVPSAMOaPmkF0fEJIpLeWaSo0Q4NVTE3I0NG
	 EdEmOlcHUjMQGRvuC4D9bWx/t41VBdfwEIaE1i3oxRI0+LIZbooBZY9uN/V6kvI4FBtfy
	 84Dh45jnK2yX7xoywJmxGeOlXOOtMQtdBCx1eO+dihUkq0Blj5PIRwKgCYBsv9okexvne
	 CijMgg/nKbyIJLM2IEHWNH9eSU4IDVOBPgBcZzNgUCx9W/xuHALdmq89h0tXI2VJOBOvL
	 dgtOhhEf6CxqJrsLu8VcaY4Bp4CyWeBJq7VgeKUCcVetFmDV9AEkzy7nDuKcLNkWbzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MeI2RRpU;
	arc=none smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD555606A31B
	for <linux-rt-users@vger.kernel.org>; Tue,  3 Nov 2026 18:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD555606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MeI2RRpU
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67583c777abso1262002d50.1
        for <linux-rt-users@vger.kernel.org>; Tue, 03 Nov 2026 10:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793730519; x=1794335319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/P9l0XzUDKBxfbJYNFsurl3JtxLLNN6HBoUEFo1Tkp0=;
        b=MeI2RRpUccgCWSooF/V4SIkoffmadDyKnngGeu3UPv9S6jBnFecSQG3QxZhvQWoLqU
         xYFFapzhhyuqZqwGg6OVbxAlgLDmvwpcqWcRlaH0oh45WFzljuBxm4/i0EzH7A1N/XfZ
         PKtMBojC0BXOQsYjCOirZY0qH8B6Wbr0UjtopswCjSK4jSg4WiEgkKp2G+lL7gKaGa7F
         dyugk4MgGEeZkgFGJSRth17uEVpnCIg67Ml37cSquYxGbQiINerYIfEDuUCB2vXxvNta
         LNoHsJxFnpuEhwRWg9tiVeYkud9tcK81Di7F9rQ3CSgbqrfRXLbeYvDIj8v/8hVPED/9
         CgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793730519; x=1794335319;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/P9l0XzUDKBxfbJYNFsurl3JtxLLNN6HBoUEFo1Tkp0=;
        b=kmQEHnnkb/LziSExLEWt7Esp/t6rCondhS7Z2Da7Bn/fOSLHhIhV9giyDwe7JpJ+b6
         CGIm1vNg+hQl7MRxMYuga7JfcicKvAiEk+EagdD0ac3GP6IJJaxPpb8tSVSVYitXCNgp
         oCAyNgwP8nIL4sBSjFESR/ghYoNDhW6Kz3veqjYHnUKx9zMzD68hYVEJqAreJ4AgFdRd
         WZKafaqYMeyVeFUMVs3euaV/4Q7kHtUg6dMIY++ClHdwfs/hb6z4Sc3XvPYrsGnwnNXr
         poU0ebp0sNmFevGcDBsTO3+h6og2Nt8Ywc37+SQBWJd+pbS6dVKPMi+7YGXvwj8u+BJ4
         0+Qw==
X-Gm-Message-State: APuU4Z9C+ke+i/1vYY+xvxv0a5UnhAiJcv9RMZd52pU6WN9V4LI1UnIb
	sO9+cP2IXPyeQO3NARdFITf7h+Zzc6oJJ5PhJzfrUWoYYr5vM0HRT0MSaioq8w==
X-Gm-Gg: AYBFou0q65x7I//J0gvEckVKP+MTr7ZNSd3iZubP4hdSD8C4Mf+3DPQUFcZdkjWjFk/
	nbY55u0nOPnXRqx+wUuvhOEeknH7tCkdSOTpdsSahjn+ddXJ+ZDCLAqS3DTxbe8NgAQ5iiY2r6O
	4iUjwd7dT1ydEp6cQxNZ2q5O/lPXFCDRaKBW1uVIhvoOvxxMSbFZPJ7ZKgtg57mUmneVBLVlcK6
	YEDz47oCXwQy4BtBY3/NLpWO5cR3qPZ2OSuNSIHKLDTbyOS5E4qNJ0se09vQuJeVGqRl44lrSWK
	ZxGb9sX7qL42E+TtGZzgBAPN6siGuJvDVcTtT2KO5a5uLYC14b34SOQgBEyuI57Vh+TTNAWFMmZ
	u5mAji201nGgVgERGJc+0NxpTVM8Oou/vew1rz7jmE8a40nuTulDXU3P0ru4UWgZDQyHaPVBsHr
	5OUv7phPMn56XiQPcV6sODPPwsd/zTZJLP686Ps669IYu93itps+7uL+iH7saDqB3wHDkBqjI8o
	xNyW7sc9aT9ZO3SoH2JF1dOgpkPi342dq6Elj8DNskt81wW3Gh1nH1MI/rV68pZbW706E61w5aJ
	RNSXkdE0xbjf4oEzGToHvv0igM8I7wWitjLF6l7dz5oEiLU44EBHSnEDRGUv8CsseSiXF4dODLV
	7uQMl+Ncv
X-Received: by 2002:a05:690e:191a:b0:679:ac65:487b with SMTP id 956f58d0204a3-67a8d396d2dmr12409465d50.15.1793730518564;
        Tue, 03 Nov 2026 10:28:38 -0800 (PST)
Received: from fionn.home ([70.50.116.123])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67baf2701f8sm7500889d50.6.2026.11.03.10.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:28:38 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Sana Sharma <sansshar@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] rteval: Fixed hardcoded paths in class TestCpusetManagerCLIIntegration
Date: Tue,  3 Nov 2026 13:28:23 -0500
Message-ID: <20261103182823.120528-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <auI9GfqN-g0YtJhD@fedora>
References: <auI9GfqN-g0YtJhD@fedora>
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

On Wed, 28 Oct 2026 at 14:21:13 -0400, Sana Sharma wrote:
> [PATCH v2] rteval: Fixed hardcoded paths in class TestCpusetManagerCLIIntegration

Thanks for the patch Sana. Good catch dropping the hardcoded
/home/jkacur path - it would only ever have worked on my machine - and
the switch to pathlib matches what we already do in
tests/test_stressng.py. Two small things to fix, then I'll take it.

1. Don't compute the repo root twice.

> +sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
...
> +    srcdir = str(Path(__file__).resolve().parent.parent)

The same str(Path(__file__).resolve().parent.parent) is evaluated once
here and then again as the class attribute. Name it once at module scope
and reuse it:

    SRCDIR = str(Path(__file__).resolve().parent.parent)
    sys.path.insert(0, SRCDIR)

and in the class:

    srcdir = SRCDIR

It needs to stay at module level (not inside the class), because the
sys.path.insert has to run before the top-of-file "from rteval ..."
imports, and the class is not defined yet at that point.

2. Extra space after the comma.

> +            [sys.executable,  f"{self.srcdir}/rteval-cmd",

There are two spaces after "sys.executable," in each of these calls; it
should be one. pylint won't catch this (it dropped its whitespace checks
a few releases ago), but a formatter like ruff or black will flag and fix
it for you automatically, e.g.:

    ruff format tests/test_cpusetmanager.py

With those addressed I'm happy to apply it.

John
