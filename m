Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA353F4127
	for <linux-rt-users@vger.kernel.org>; Thu, 14 May 2026 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778749337; cv=none; b=Ea5zpMe+CinKsE+GRKJ5yIOkjDR6kj/+Xg+fgqazwzEbibi/U4gkOFNnNPt7TbgGQ2ZJsmaQkhU6WCK0KHnm+bj5WWtOQPawgUuBCdIVXSSwJOLBzLLKg4ccdlhub0aYteL0iEDNWs7fLhYdf97lPHequHMgxcYsPhj89tcCksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778749337; c=relaxed/simple;
	bh=AKHkI7lvIXAw4tdBY7IMvBTBDqMVAbldLotTGcjg2SY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=udPEdhqoRm5BSJ4n2eEdueV89mWA3jDgqr+0jlWgjtBvSbU8YgDvyISdqRn+Z8YHLNnzbJx2QJyxnNAEuzvLzzmGOH3Vqcd2a51C8iSe7fMPEFPW0tobw5nLpIcIL7uZcODz0fEihkw7KvuRa7axDBjjVGxIDvofE1UUj2/FnIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pq9bks1a; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pq9bks1a"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891b0786beso49402155e9.1
        for <linux-rt-users@vger.kernel.org>; Thu, 14 May 2026 02:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778749334; x=1779354134; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYRLkpnnItYDtdC6ybp8/1SRvJWhxj9cPjjMAg1izOg=;
        b=Pq9bks1auh7YntglYVfy2bZbgmXnDrFikS0vs2Ud5j+4vfiVGheRjIM0fPE7V8On8o
         53/g+JeKsc7Rm1yyLzTrItVfwu/h+jgP/1Ic5iyq6970AjGmWyt+4aID8MLgB6lvOAMG
         UDi55V8lpXidiLMAdLDhdoYrtlMtDRBUDVWVByDljJvbZWxJkm/VqfpCexmLdeJTvDI4
         TGoeGJxfKJ6v4xVfL20mMuLaZhx/hFKqjLKH3auZZw2vHwipb2J3YMHQODuIqEByM6sg
         bakdrujwOlRPAFsz5lDzNuWu56GvjKIMxuAS/GWwr+O1UWk/K30ZVf+qv+uzIRUogff6
         wKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778749334; x=1779354134;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jYRLkpnnItYDtdC6ybp8/1SRvJWhxj9cPjjMAg1izOg=;
        b=kPOUWvKGs85ZOPx/1zkXKwAMTZAc6QJ+vmE+WSwdmpsTZDciLZ2vVln4LtCzp+5jZe
         4Jy/PdsOOUnZF4qCuROr55XwIGLW8xCDR3lMSHjOSWoN89SscMES0Kwtx9TPk3JVtSBc
         GYSi6xaKumtia2hiimaLrTK03GHl9Xrsz2HHLsrMz7ZCwO5KKjSjVUX7MClbSQYW+Rit
         yuYusIQQYgxp995Bss2WqW3wDtPIrnuEC0tu0M7tq6XnedSvAKdcvH3/46/vshYqOzhk
         my9prW+BGbRXRZe185xQN3QV20p3aj4qnPmlAIG1OzuPwBdAHAvwQhY3tmimfsblcVMy
         WFfA==
X-Gm-Message-State: AOJu0Yz/3zBseFbmmTfmju9fhv+we5L8CM48l7SvyhpVfgN7DOHnHLAk
	BH0+Qt5h60crYpSBl9HMaMLchj3Y+GHyvjyJft4zC2NZYJrzU3kmn9dntwwabNu5
X-Gm-Gg: Acq92OHQIr02Kdz2iL5tdvw4TTV8kTr7ykmKm57c+VrUDSqoglV8KbiQdvZYK7rbqg9
	fyYRD4ITpCLvRuigmQ3NVy1JpObBJfWb98Mmj62fvSWwoOEwg8ggpdaCWNZfNp8PC3RbXGB6kFh
	kNvalv2fIfK3kG+kRCHk+amtZa6yAIeUV2xuKxmjwB9oM7ZfKv+2RsyJeUa4gYmSfQWh/q5t0hr
	plgucTeDkQSujlU5kmdtzOkTS1AC/B+cBBiBJQJXO0L8RKNUEZ7FnEKs1Y2QzDqu/hW/X+kdz2S
	pTvCemN06BSlPYrtSSsvJeMf6iPmkjN2J+RHpwoEpHE7zB4LMCiWVWFqrwL56auWzMfeB1vspR5
	ZsrQvg9mq/HiEtCQuo3tsvG5qBUzjyQRKCFF7tBgbtE0tTVeJcKGxJ+qdqzSfmcvvuDLOGkacSd
	FUALwRvu6oAyQU58Oz6TJtjvRR6MRGSRI=
X-Received: by 2002:a05:600c:4ed0:b0:485:3b9e:caa7 with SMTP id 5b1f17b1804b1-48fcea12514mr106574675e9.23.1778749333786;
        Thu, 14 May 2026 02:02:13 -0700 (PDT)
Received: from [192.168.1.114] ([31.223.9.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd630b2b8sm21599545e9.3.2026.05.14.02.02.13
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 02:02:13 -0700 (PDT)
Message-ID: <77cb843a-d5fc-4a35-b0d7-2b0c7f2f24d3@gmail.com>
Date: Thu, 14 May 2026 12:02:08 +0300
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-rt-users@vger.kernel.org
From: =?UTF-8?Q?Ahmet_Cevdet_=C3=87elik?= <ahmetcevdet006@gmail.com>
Subject: VIS, a small Linux/x86_64 tool for CPU jitter, SMI evidence, and
 runtime placement reports
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

   Hi,

   My name is Ahmet Cevdet Celik. I am developing a small open-source
   Linux/x86_64 project called VIS:

   https://github.com/AhmetCevdetCelik/V-S

   VIS is an experimental deterministic performance evidence layer. It is
   not intended to replace existing Linux RT tools such as cyclictest,
   hwlatdetect, rtla, ftrace, or perf. My current goal is to build a small
   toolchain that measures what it can, reports what it cannot measure, and
   produces machine-readable evidence around CPU noise and runtime 
placement.

   Current components:

   - vis-jitter:
     RDTSCP-based CPU jitter measurement, with IA32_SMI_COUNT based
     rejection of SMI-contaminated measurement windows.

   - vis-doctor:
     System diagnosis and advisory reports. It inspects CPU topology,
     SMT, governor, isolation, HugePages, environment mode
     (bare metal / VM / container), MSR availability, RDTSCP support,
     and reports evidence quality.

   - vis-run:
     Reads a Doctor runtime policy, temporarily runs a workload under the
     selected CPU affinity profile, and emits a post-run attestation.

   - vis-compare:
     Runs the same workload under different runtime profiles and can
     capture user-defined workload metrics for comparison.

   The main idea is:

       critical workloads should not run on hardware blindly;
       the system should collect evidence about CPU noise, firmware-level
       interruptions, scheduler/runtime effects, and placement decisions.

   At this stage VIS is Linux/x86_64 only and very much experimental. It
   depends on Linux interfaces such as /proc, /sys, sched_setaffinity, and
   on x86 timing/MSR mechanisms for some measurements. I am aware that this
   limits the scope and that SMI/MSR evidence is not always available,
   especially in virtualized or restricted environments.

   I would appreciate technical feedback from the Linux RT community,
   especially on these questions:

   1. Is this kind of evidence/reporting layer useful next to existing
      tools such as cyclictest, hwlatdetect, rtla, ftrace, and perf?

   2. Is the current SMI-contaminated-window rejection approach technically
      reasonable, or is it too strict / misleading for noisy systems?

   3. Should VIS try to import or align with rtla/hwlat/perf data rather
      than implementing more sensors itself?

   4. What would be the most useful next step for making this relevant to
      real-time Linux users? For example:
      - better integration with rtla/hwlat,
      - cgroups/cpuset based runtime containment,
      - perf counter evidence,
      - or clearer report/schema design.

   I am not looking to make exaggerated claims. The project is early, and
   I would rather get criticism now than build in the wrong direction.

   Thanks for your time.

   Best regards,
   Ahmet Cevdet Celik

