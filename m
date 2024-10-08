Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC23C1E0489
	for <linux-rt-users@vger.kernel.org>; Tue,  8 Oct 2024 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728416671; cv=none; b=nkPld0B1GU8OhicTB/oU6cmxsts7cBWuqM7foLHJLzBQ1FSo1L6IKHBBu3vS91L1kfZyKmUjktCjeTGYZu5P/3L7VYfs1uvFkeff2A6PXB4pvybFqr7cx2IAFRDBpGpwyE19gPDPVpxaQN3fKBFLslHI95FPCGcSI2/8q+3TNLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728416671; c=relaxed/simple;
	bh=9K4PsHqpFCECld6TfEp0WcKPyirsZKfOvo82l3uNp8M=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rUmSVC+OJE9yHAbQf/gQpAIQ8admKnX5mgdY6kuOIb7w26Ler3+u8ty1sI6HRkwfr/GzY2vM/IayC/rooSZ0FP5GGLjC319larn0stxfRMEsfllkIfkMLAVhIvKhzYHm1FUGVRJyDwPmg3p+QlOSo1QT80IMJol32jUleCnZVAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MmKE4xWc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmKE4xWc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728416668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRc3LmeH1cCCSz+Y5AAanApqLKutMc0tKQJRHKrIjM8=;
	b=MmKE4xWcxoH48x/k1Ea1k5zqsSZdW5Aits6MBztKUqNEPZQ8N4qMRsulaNEQP8i8KAta98
	A7gsi+TzfrYfz/F3dBAIkY0lr7z5r4nVe9O9dYGDnDQJiE+8lfNfQM+e21UOCiOrwXtrxG
	FGBtW3NfBD2dmZDlSvvYuxex8yva5b4=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-2vrFbC7BMMOZtFSUZx031A-1; Tue, 08 Oct 2024 15:44:27 -0400
X-MC-Unique: 2vrFbC7BMMOZtFSUZx031A-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a342620f50so52189465ab.3
        for <linux-rt-users@vger.kernel.org>; Tue, 08 Oct 2024 12:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728416666; x=1729021466;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRc3LmeH1cCCSz+Y5AAanApqLKutMc0tKQJRHKrIjM8=;
        b=PREL7oIHYsWDWgCVQqqipzD4zdWdcMOS19BZsxrG6VF+cL9BZcNKg4weC4/hb+u4wb
         kwrc6o4WZJ4phahaAnM6Dq7O5ZsRJUHdOXEHJtCSDAGevjIw7lgr3oSSL4Xhub9T7egW
         vj815Dy64f0IziKPYoMJno3zqDWT0zvpJ1wcVb8EoudOV9eJDdOc3Gbj/SvXSa7vxtgX
         3GiqrjyjMoxaXpciExUZEBLoxQsBcfuGzl1DhKFVe7fZcu8goKtgBcG6oLnP8TjIQcAN
         uAL+KkWwEhYC3+85MajXGOkhbx7lAvsRMAc1ZmwlfzLL0mjDRvjs6Ssa+//VXBFrn5z7
         cnrw==
X-Forwarded-Encrypted: i=1; AJvYcCUworCHWUX2wYv+usn6YhnW7rtaxpcKQNxUzPQRj0aTtfbqX0sbO4BgCsAYWmYfuXeh0hwsEYhv/f2i4o3sOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTcEyJcsEh9NHATZzr9obJ3aQ7IfrXcOc6P59hUgBTnHlLrUwx
	Du84aIQB2BdQKUMwutdIYiHBDv3vVtOUdnzWrQKSPl68GtgMk9BhaHuUHIYBTVW4GOSy0rQGcz1
	nGZFdVLJPjnscnwTX15N7izkSo6iAqpVTVFuPJI0odFdjvu/wM+C15s9upPMuRt98
X-Received: by 2002:a05:6e02:18cc:b0:39d:4ef6:b36d with SMTP id e9e14a558f8ab-3a397ce5a5cmr192545ab.7.1728416666718;
        Tue, 08 Oct 2024 12:44:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCZJIrg/eNnAcIcJJC/ksldWSqB8N865XdnFbKWU1SGlkSzaX1ULnqxWXX9hN9iTva3leinw==
X-Received: by 2002:a05:6e02:18cc:b0:39d:4ef6:b36d with SMTP id e9e14a558f8ab-3a397ce5a5cmr192315ab.7.1728416666284;
        Tue, 08 Oct 2024 12:44:26 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6eb358b0sm1769091173.29.2024.10.08.12.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 12:44:25 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5f125ed8-66bb-4654-b1da-b8db643b81d6@redhat.com>
Date: Tue, 8 Oct 2024 15:44:23 -0400
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Futex hash_bucket lock can break isolation and cause priority
 inversion on RT
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-rt-users <linux-rt-users@vger.kernel.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Juri Lelli <juri.lelli@redhat.com>
References: <ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.remote.csb>
 <20241008173859.GE17263@noisy.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20241008173859.GE17263@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/8/24 1:38 PM, Peter Zijlstra wrote:
> On Tue, Oct 08, 2024 at 04:22:26PM +0100, Juri Lelli wrote:
>> Does this report make any sense? If it does, has this issue ever been
>> reported and possibly discussed? I guess it’s kind of a corner case, but
>> I wonder if anybody has suggestions already on how to possibly try to
>> tackle it from a kernel perspective.
> Any shared lock can cause such havoc. Futex hash buckets is just one of
> a number of very popular ones that's relatively easy to hit.
>
> I do have some futex-numa patches still pending, but they won't
> magically sure this either. Userspace needs help at the very least.

Regarding the futex-numa patches, are you planning to get them merged 
soon? We have customers asking for that.

Cheers,
Longman

