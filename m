Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795614371;
	b=33g2IwgTsmLF7eh4u+hoEmqLQX73rMXov6FQng07dCvcK0wmYJZw9yh6m2PN+pNQuhuK
	 tnWPPwgFs5VtJd/Ie0dKDBrCdAy9rOAyTGeInGTPiAurmf0WuHJmT8bnH5DZ8inOOJFi7
	 vj8O2gI1J3MhODE99anNaFQPMtdn3XVc/T7yZPcXufdfzGRiWIbBIeY3kSbAUchgdJfW1
	 wxs0Mnn540rhbDY2Rx4H1UegAtQqDvKLuDhrW7Z7lglqsBAuFwUVcpBs7R+iBtCNSYKa1
	 HYk0JHvT5R9yss4+x+u/zTirZb2RnF1Et5q/cDi78415aSl0s11isItbJFtdzuZVzaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=C8OlVAjai3JAwDsu1Ot49CBgGSMHNvrOJ/XAEFCCfXg=;
	b=FDcuWI0RIaF7cDb1Q9Kop7BB1pDUqI+vs1xq8NUFTWiz7eBhqoIVfw29dsvIwsnfy1Iv
	 hBMBq1HTBmW50LyAsrhxklpC0Cd9vXtDd+slK/vDgoF8D3SOv3Y7/HWR7hqO/mhzrfBUX
	 QH0QyWPlJM3eG+6QW6q3RDIBn1uBwmdhs27nZJpcW5WDsN6ag9SsSw8pweqealegBAuvP
	 aJsz58grDQFGQwy75qewSSyoQbxQFA+HYVa925riaU+v3yQ4bCAvgytSoM/rHg13o9+8O
	 H8bSwYIfZn8SQV2G9c+ETw5HP0C2ZjZLeGVbBpFEvg/UUXjyasd8iM7PrC5PA1O31Wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gQpsgrZj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397FC606A33D
	for <linux-rt-users@vger.kernel.org>; Wed, 25 Nov 2026 13:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 397FC606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gQpsgrZj
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5c1c0c8d61aso3844532e87.1
        for <linux-rt-users@vger.kernel.org>; Wed, 25 Nov 2026 05:46:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795614369; cv=none;
        d=google.com; s=arc-20260327;
        b=VimSRW6n5fX8aYWp1WdjJPy494NzLrjTfI/tZ15kdHxS8S7Fc0dwei+xjuMJSfvloH
         UfNz6hor7nU87mKU26VLui07O7iqFrti8QRTj38qjvGRFaRrDIa08REnjM3FnGaRfH3r
         RHuEPS1GtGd7DjavNEprrOx85OLn08/NYk2WKRpO4JF96IkWNylm117b1sK0EPWfXRRf
         2FC2EHzPoGqE9MfAz6J5Df5kJV4Bvu1/rVIxivXqiomu1JCwnQvGPCdhFd3yWH9rybbs
         anCwmvZczKGg/1u78iT+lLMertACnVehUobPhjqKU7V+vryUnYQjN7E6kFQ7FsDS8Bhe
         fi4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=C8OlVAjai3JAwDsu1Ot49CBgGSMHNvrOJ/XAEFCCfXg=;
        fh=R0MRK7X7cGzt+O+dKl4jx5KouLlzfKua0XuQ+CKFWwU=;
        b=AFCMyTxuMbv6u+pbqulGxARE3YTgd7KJhpPNszEU48YIz5zofLsW7UoU0RUpD1tiaj
         v6mWHo9EVzxnrvH/lhhlHIIQB69uYsy1jrhq6Y4BIfnQHQUOi7B4T3KwhFlDRKwuu2SM
         wQlxuHYNglVbbui8XcTfA4YC3NSeG9OUQqpWqxeT3N6jGA6ZKdYDLTvOMNOfZwRcaIb9
         yTwnERnAsV7gCgHwWvxtcf4Mo9Br+pJ0VVB8FaWK9ek2cm4sWnfsoSQ63BPDVwgTt68U
         GQY1cNhP/gIJod+nSKuFP2sCXo/vJ9cM33BlM7mK9CATNnab6sYnu8myOjXY3Ubh2rBy
         SX8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795614369; x=1796219169; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C8OlVAjai3JAwDsu1Ot49CBgGSMHNvrOJ/XAEFCCfXg=;
        b=gQpsgrZjCseYaeoFbtRFkla9R4ComrG+UpUV2tkM2f56MGLbaF6mJpPow7XPeu52E+
         UYuSv1KaTBYDyZx0U5hu/mmeFqmmbe38ZPi5TXvRsrUYEZwXJVeVjWczNaejryHwRW3/
         Cnxre1Gsr+dhIzF80hlQwrHU+P3b4lw9dqlKMtDqJiVz0FR2yF6R5G2etvhoTIGfbv+Q
         pRm4zboHaRopf8mlx+Omnxit1y1ySx+od5AlNNEpNqLek+O5hzth5GUu+u8hBCMw5DJV
         QUs+07cTzPOODIr0RG7wYjQhXeYEhhEbsGBgK+jAimTSLHu3PB5iwQgXTNyXnwK74cE8
         OXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795614369; x=1796219169;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C8OlVAjai3JAwDsu1Ot49CBgGSMHNvrOJ/XAEFCCfXg=;
        b=XqxqyGik/8TfbsN6wjSm6Sq8cDokvjsSXQBoyGCVH/m4S0nN2qGYvUwkNe9JjnJsmC
         oFshf4j3oNuJPuXOL+fOxufBbqF5kZ1Rii7010+sHlnzt53kQfLO5AMt3NQ1wcVrFwUO
         YBTh15h4JJ3lap8BbFu9HUSbjcxJzhCWyCH2/VH8RWV0AFBimKy7x4yHfolHAb4RsHnm
         tbCPSGr8gfzMc4MHdLLp9w/uftDHJNJERTaehh9kuRVE8exGj38PR1ShWVUaTThZEecf
         p9DKPa5op0QZwdvU8lT3HYrw5jpmlYyKkeiSU2Fhc94D/vOoFhQmJxPycx77Hk7hdIN2
         aU9w==
X-Gm-Message-State: APuU4Z9ouS7ZLbH0OpyBv9Wn3VgVCrphDsuMZbtfnbS6BRBf0WljZ5Ol
	WYv+6SLznWHf4GWTNppqQBFqayJs2yS2FCToLW2Q9WjnGOWWr+U4Xcby5upVsk5MQvA7fVGG1wc
	lyRN35ZOJFIS5xsujBvxwVK0Ovh3+H44=
X-Gm-Gg: AZFdTZeL+bHY97qc2vptklFKxzBWap6Fa7w10ftdQqSWcYOTT8ShIv7upRr+aVNZIcM
	ce85H5OAXsIg8eYQSWSPhsW64s2hHr3rfuggTH1THUIhjYrRoHGDL4YAcxzddnapewMM3DDm23J
	lW9kJHGaWtWvfc9KJzu/RNH892I9NDBLWNtCG8mDXjzTeZW+U/yD6kttGwhq0gopG6MKOqCG03H
	jclzQXc7ycxV/+I+EFoqy4c64aVtQY6sRXA8kqyG8DdWb5cUUy3zntpyT3wkrCUtrk9nRep/rAD
	E/ONevTGJmBf3sVmzo25NfuaANQMDMxMXNkXQlWtugA4aX05X9lRAd4SSCYTrn/n3kwBp6ezw0w
	tEcS31iMS5MJR/HIItrffrU8vAu3HXiURwm+x+zT3x+Hf8mus6u8+/AjzaFK8gfIDGyXIwd9KP0
	nvrfulfQK9IzupGYjqWiFcVlTqme4NV+VQlaHSjezpM5xplaM=
X-Received: by 2002:a05:6512:239f:b0:5c1:5e33:6994 with SMTP id
 2adb3069b0e04-5c1bc7ad610mr5398378e87.12.1795614369139; Wed, 25 Nov 2026
 05:46:09 -0800 (PST)
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Yaroslav Hryhorenko <yarik13371337@gmail.com>
Date: Wed, 25 Nov 2026 15:45:58 +0200
X-Gm-Features: Aa3M54qfw1xih4TunPy2heBPMcnHjKj6CZSIHeiEthI619RGetlQV9X4f-E-X2c
Message-ID: <CANTFvqGaCZq4huxya4um4zpoa7tGSKA_Og8smcE9ssgteVrbKg@mail.gmail.com>
Subject: rt-tests: QNX 8.0 port, would you take three small patches?
To: williams@redhat.com, jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Clark, John,

I ported rt-tests 2.11 to QNX 8.0 (aarch64, built with the QNX SDP's
qcc, run on QEMU) for a hackathon. Most of the work lives outside your
tree, in a small shim that gives the Linux affinity calls a QNX
equivalent. Three changes did need to touch the sources, and I'm
writing to ask if you would want them.

All three are inside #ifdef __QNX__, so nothing should change on Linux.
I have only built them on QNX, not on Linux with the QNX paths off, so
please check that on your side.

1/3 Build cyclictest and the libraries on QNX: no SCHED_DEADLINE, no
    getcpu(), SIGEV_THREAD_ID is SIGEV_SIGNAL_THREAD, no /proc/loadavg
    and similar, and pip_stress needs fd -1 for its anonymous mmap.
2/3 pi_stress: QNX has no thread attribute for the CPU mask, so each
    thread binds itself after it starts.
3/3 ptsematest: the test unlocks a mutex from another thread, which
    QNX does not allow, so it hands the lock over with semaphores there.

The patches are in git format here:
https://github.com/Fuze5k/rt-tests-qnx/tree/main/patches

If you would like them as a proper series on the list, I will send them
with git send-email. If you would rather not carry QNX code upstream,
that is fine too; the repo stays up either way.

Thanks,
Yaroslav Hryhorenko
