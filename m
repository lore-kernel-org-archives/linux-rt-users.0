Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51853624BC
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Feb 2026 11:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770032547; cv=pass; b=uACkhuDGYTix19dj9zlzWfp1y6CfSQ2a56gp/Ha98nmT05psP5rwVZtd+ylsjtEr4tVvuQBQJd8tncVaSq2UAGCrU15ULl0D7f9/mRa7YZITNxg0pq4E+T6T5gsJwOAoBNeW/M2M+SkqEI8eG1dyfY1Pf0gvf5TG4uDID10GjqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770032547; c=relaxed/simple;
	bh=uxogTBSoZdcKIBUflYZgwLlchoG6O6ET2G0L6ScFggA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CDquVoDvjyPr1hoGOj94LaRrcOdPw3WrHkLKEWi/+rqK/mQjEqYcsdiaEhaDMlxBmZsUwqvJpiK5TYCURd9H46tujMGwChqsGuBRH98WeGjZZYNnePCnGyWNj4kRXpFn22Mv+h4rovkGg7TTYyaQyMqslrpotpli6A+JeTIhK7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCIVBj01; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCIVBj01"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59dd490be5fso5569736e87.2
        for <linux-rt-users@vger.kernel.org>; Mon, 02 Feb 2026 03:42:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770032541; cv=none;
        d=google.com; s=arc-20240605;
        b=NRkA5+2ILxjSLl+4ZGaFFIMbmkhvt8iW5OkzA6LMZbcDWDKk6eWdnpNdqKpf6/4XBA
         +zpoRdq8zY/mxNRCtcmBI6LL+nZaUrI9HpOFSop09avj4e+mL2vhx34yRk9+gCF6Kg8C
         bDHtdmxxrLPKQnAe1fSatPvpEWRN0Qg9ZUInJINVxOwnkNHrIb9hHepRQ+7Vu3FWnYkY
         7YwjxmylVIJM/kwFFzDMZFfOVa8CoNQBonOqosnlURqfZMuStpHSEXvJz+4tTS/l2AG3
         2a1dxtCC8iV5NYRTUMvN8AenwT1DOGGL6MbHHVjlpFcujNekV11ur5rWgTCCsjP8og2d
         piwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=uxogTBSoZdcKIBUflYZgwLlchoG6O6ET2G0L6ScFggA=;
        fh=3byEJjXsHEe0LsUVc+7oI5ETe+uPw2m3X5rwolFG6l4=;
        b=MCHo7fUdqJ31mpIrinOn1AjztCXqd78vJFaKd6qiKJXIExR301K4FirtXowhgg8hfm
         xWkJuLqxN4IuT/2ghHAD0FT+shj7cr4Kp4bb/w3m032btkaWmVyHYUQA3+9pyaAFfopV
         9nQQmeRJvdRKPjXaIM0kQjKQyCQZiJQQkgx9NDqxqfZdcYYczCuswLc8iUxK4fi3kQbw
         pJf+3CPKA12G4NTHfcJg6zkXI8Y9/RP2S5wbvghjXeH32rlQu1CG70MozWqb4LWGztnB
         QpsT+xWKNlCSeB3zOFqjDuly9lYyYaRAptD8CsiWg68iU0kQW8XmIrEWk+pcDkBoz5wB
         qeKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770032541; x=1770637341; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uxogTBSoZdcKIBUflYZgwLlchoG6O6ET2G0L6ScFggA=;
        b=fCIVBj01ZU+0BEHEDVoeHwwVxK/EB9vA8vTWRbBSXrtVbM3JpSYlfkZWIuBoJvFHOy
         vE1K7s0Iq69ocvFtKGK2e0Ku1YJ1Z8auyxIfG/2Et0RRzFe4gNbMoeZxWhZsuvOORNAc
         QEsAu5x+1EebG09J7hx3a9yj6zIge3caEWzxPgCe4VHelWf8EY79ATJBtaHoMD0QbV9k
         AzmDxGmthIbnC0r8Rg5pdjDDKQXv0gMa4BS4LftcUXyRr+o2qqyYLZDWBYDr7LFtcpkT
         vUkl835Q+hTmSsW682cvraDJznqPoywaQs9+rKpwryFOBIzFFw/FVOs/syaKU9FFdTYu
         97oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770032541; x=1770637341;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxogTBSoZdcKIBUflYZgwLlchoG6O6ET2G0L6ScFggA=;
        b=hbeKjwO0BTjoGQMpdGtkMJ6WPVN3Pdl5SrTJ0lBR4BgGIXxDDMLc4T5zaYLjgBpNLj
         5Jv6Ms19i0cPcRD6M5Nu04/BKb8+NXw7AUQHD27X99umbGwDDRFJsx+qk2CRufRsqCpC
         hSaLbgF309nKweANeU/MfGy6ZhGKae04J3nc+GEqXtbBNfDHzM8uvZ9sz4TStQhdtbLS
         nCVVOzFFaHopI8VCV2JvchVN38knsEOMWtLjYPM7KkOyT1/hkAsHtPo8xkD65HRBcJBB
         dphrwctrn/qQqZb58JipDOpnq7eCVsGf1Hc+N7NhnIw9kCi/BsDdCqPt01vkf416rIKb
         OSLA==
X-Gm-Message-State: AOJu0YzM4b/dOrRx2vKKNlCzTr/I+7uRG6XB88HD/AmgoElfVjw+eP85
	K+unTuNFJg0LiCIzJLom+HDsJjZ9ss05CZ8PSsRzvc7FlFBV9WdVFwP21SA1TywKhd/vfBiAupm
	opBPO/dH/8VEYp3za28QYhWmEYbkSiOVc+DJI
X-Gm-Gg: AZuq6aIYPftYRv6oCt6+4XLnFsSKE1YTuXlEJw1KRAkbM4f7J62xzNJwN4R1ATC6KQR
	A9WO0KHPUM2d6RWZHCiQd4vzTzLgxrCWUYlP3c40rsqEkRpJcy/UpgdlplMcf8yOg5PmeA+4Io/
	IgbCom/Ne0FVMZvDbDaYNfRvkytxRxvTQ6LsK7EzZd6Ztu1uNOXOCS1FdY+CLUqVqywMwGgcYlB
	rplDUQCEldjIjzVTOVdKbtWZEe+eScw4nobFzRo2K4nQ6iVRCDbkry4MM2dayLsAVPnOvlfNCyy
	hTjlQiA=
X-Received: by 2002:a05:6512:318c:b0:59e:49a:1eaf with SMTP id
 2adb3069b0e04-59e1643002bmr3788443e87.40.1770032541211; Mon, 02 Feb 2026
 03:42:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: vigashini kesavan <vigashinikesavan@gmail.com>
Date: Mon, 2 Feb 2026 13:42:07 +0200
X-Gm-Features: AZwV_QgqXw3FDikS_69GdOHojHmwttn1F09XB6PBOjjU7IpPdHmTBTF80mKRqP4
Message-ID: <CAOcTU28hkopDkCRHert9J43V_1rcq2uwnPAeE2D5r6rY0Xb7Kg@mail.gmail.com>
Subject: RT wakeup latency due to unbound workqueue execution (runtime mitigation?)
To: linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I am investigating occasional cyclictest wakeup latency spikes on a
PREEMPT_RT system (Linux 6.1.158-rt) and have traced it to the
execution of unbound workqueue items (flush_memcg_stats_dwork,
wb_workfn) on the measurement CPU.

These are observed under default Boot-time parameters, without any
modification to parameters such as isolcpus, nohz_full parameters or
workqueue cpumask. The intention is to analyze latency behaviour under
default boot-time configuration, relying only on runtime mechanisms
such as cgroup configuration or task level CPU affinity.
Manual pinning of kworker threads through task affinity was tried
without success.

Question:
Is there a supported or recommended runtime mechanism to prevent
unbound workqueue execution on a specific CPU. Or to defer this class
of work away from any CPU? (without any boot-time workqueue cpumasks)

Also, is there any option to attribute the unbound workqueue execution
to any kernel subsystems or runtime activities that could queue this
work. To better understand any potential userspace triggers for this.

Any guidance would be appreciated.

Thanks,
Vigashini Kesavan
