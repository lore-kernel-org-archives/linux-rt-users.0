Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22FA279791
	for <linux-rt-users@vger.kernel.org>; Mon, 19 May 2025 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664568; cv=none; b=FdRrWcbA4ZnaVWjqDHWA5iYLxQp//aXeuz1KstmVGoTVRQxUCS+TTu3Wcfjs1l2Kkqgv0ckuqt+ky+QZnjQt8J+HeLzn4NbGTkOw0VkdnTdZ40SQYGfS2uXPLxaX43Rp5pVQjh+YSZaSHIeOtD7nR34cSfM+AmUFWiKGtH6ilX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664568; c=relaxed/simple;
	bh=gGOOJfhDZ5SegqCN1QGtjb+q4IT91xtxsNde8Cw0vkQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iw8kb5pAOxC4wxQfIdTwJefORw1YJfE+aKg0UdT5QPm09Os0M+er4RxMbPnEDQRgyVUkPEQyJttj8tTk8UxAlv72v0qLFEu1/Mw0wIJS8W5VLhG0eT7gLMqwSGUtXgDJ2zgKA1muiAIY8qBGPcS9y8KhrX8H243p6ZUh78c9uLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bp/fQTIr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bp/fQTIr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747664565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gGOOJfhDZ5SegqCN1QGtjb+q4IT91xtxsNde8Cw0vkQ=;
	b=bp/fQTIrNq3PJOmGQfNPPovYOTAdMNTcOpeB4+0akTN4q+hfk2LOSBXHzNbm2xnwApgTbq
	ICqxSt2kzocsFh5U1+0nL6av/Erbv3jchKQ4uThfdc3BNxxelj1TjayIcgu1r3jtQO4Jy7
	JMbZE54RgHfQ98qLEGGZJpCZi5l0Xrk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-vnsAwd1iNLWfyjlfn1kX6A-1; Mon, 19 May 2025 10:22:44 -0400
X-MC-Unique: vnsAwd1iNLWfyjlfn1kX6A-1
X-Mimecast-MFC-AGG-ID: vnsAwd1iNLWfyjlfn1kX6A_1747664563
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43e9a3d2977so33493765e9.1
        for <linux-rt-users@vger.kernel.org>; Mon, 19 May 2025 07:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747664563; x=1748269363;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGOOJfhDZ5SegqCN1QGtjb+q4IT91xtxsNde8Cw0vkQ=;
        b=RBxrVL/wDWDnG0lNpQ0YtTXxW+zxXN5lhNUHw0jA+jJJjaSpIC9lYQrgPm1zY16esj
         /5v9IuKI1CAgl/hpioGVEBN1xMwHjXnyfBmHE45CZHoDfYvALh3yd2uEbUh1NzZABvUw
         pFtyzib68HWshHKdJY/X8v8cnFUSWkCo5ctK9tXpHbokDHl/+LqWRYmhwbu5e0+SaDMt
         YyAHMcvNaDE631sIco5G1ioG/DvZ6ivGTksvGoKA0BgPgX+Z1soB/d7wR8BujylU++nD
         acH7BVKLXBveVFWNE2QYj1OEDEx6RWN7uv7OoIPHehKghmLc/JYL+GqHDcSsKndRoSlr
         dU8w==
X-Forwarded-Encrypted: i=1; AJvYcCXSGTlpg1zTeXaMq6zfAvvr9qwDITZuqT9pPMaJ7XvY+yK6kzN3B2DuhCwKYF2Xcer573+aDFQaUXT3guc47w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn61RriFNw5eO0DYZNF6prfWQRfDIRyCsvp8g5+gNmvQaYj6/z
	mVLaZ55KXOcYOtrT6K/Q6c9+fjeQslrREebQHh7oX74xTzb3LWedyYFbf8qoo8QN1HH2Lqukzmh
	iydC71cOulbN3s7zFCVz3WxT5gCbFFSU22LwrPOG48iD0wCFZ9KXphiGK1t0aPad6o8At
X-Gm-Gg: ASbGncuxMY9qXu61gJidjpUCPpepDDROBLAxBq8oaareggz/UOquJYdXZdPxtz/I+Vr
	AcGbI1J7GPGdaXk0FILkMfMaZjWT+uxDIUY4KuEWZxiYXdz+eP2kzM8rvGs0zBCNpwaixPy0wOI
	q3uMRF+zOaZUmCwbns3UdECWiZn0LaDTkoyep0Z0VabeRNao/NnsKaxu2CqZ2cdpfyU4uTpJgXq
	/GzvdpWsprg0O5POqr4YJ70KukA1Celfyh81NPRC2vz3w2lhfgytVHxy8TUebQBI9R6jBEeiQtP
	C3+1KZ9bTo/XeXYU3ArICm92z1OLupWzRCqb5/fXg08c6Sie7e8LmIZtiqdg4mihQrQzWea0
X-Received: by 2002:a05:6000:2907:b0:3a3:64b7:620b with SMTP id ffacd0b85a97d-3a364b7643cmr8161683f8f.20.1747664563260;
        Mon, 19 May 2025 07:22:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhm3Ek1ek9W5ZPiXPoMxMaNS8+WO85TNPGle0guQyL6BxmyaWcHjQ9mb2dbC9GE6/77M42Eg==
X-Received: by 2002:a05:6000:2907:b0:3a3:64b7:620b with SMTP id ffacd0b85a97d-3a364b7643cmr8161648f8f.20.1747664562806;
        Mon, 19 May 2025 07:22:42 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a7d6sm13030988f8f.30.2025.05.19.07.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:22:42 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Florian Bezdeka
 <florian.bezdeka@siemens.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Clark
 Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org, Joe Damato
 <jdamato@fastly.com>, Martin Karsten <mkarsten@uwaterloo.ca>, Jens Axboe
 <axboe@kernel.dk>, Frederic Weisbecker <frederic@kernel.org>, Ben Segall
 <bsegall@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Peter
 Zijlstra <peterz@infradead.org>, Josh Don <joshdon@google.com>, Ingo
 Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Xi Wang <xii@google.com>, Juri Lelli <juri.lelli@redhat.com>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>,
 Chengming Zhou <chengming.zhou@linux.dev>, Chuyi Zhou
 <zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>, Andreas
 Ziegler <ziegler.andreas@siemens.com>
Subject: Re: [PATCH] eventpoll: Fix priority inversion problem
In-Reply-To: <20250519094543.m4bNJP6X@linutronix.de>
References: <20250519074016.3337326-1-namcao@linutronix.de>
 <ae4985d3b157e31c667f532906cb6ff55633141b.camel@siemens.com>
 <20250519094543.m4bNJP6X@linutronix.de>
Date: Mon, 19 May 2025 16:22:40 +0200
Message-ID: <xhsmhbjroade7.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 19/05/25 11:45, Nam Cao wrote:
> On Mon, May 19, 2025 at 11:25:51AM +0200, Florian Bezdeka wrote:
>> Hi all,
>>
>> sorry for top-posting, but I think it makes sense in this case as I'm
>> trying to merge different workstreams, likely working on the same
>> problem showing up in different colors.
>>
>> Main goal is to make everybody aware of the other stream / patch
>> series.
>>
>> We have colleagues from Bytedance working on non-RT performance
>> optimizations related to CONFIG_CFS_BANDWIDTH at [1].
>>
>> This series came to light while searching for a solution for a RT
>> lockup, reported at [2].
>>
>> We heavily tested [1] during the last month on RT and can report
>> success now. In our tests we saw read-lock holder preemption only
>> within the epoll interface. It might be that [1] fixes more potential
>> issues in this regard.
>>
>> Today [3] (= the patch I'm replying to, see below) got posted.
>> Linutronix reworking the epoll infrastructure.
>>
>> I would love to learn how/if the combination, basically [1] and [3] fit
>> together.
>
> [1] fixes stall problem involving rw semaphore which epoll uses, but it
> doesn't fix the possible priority inversion with epoll
>
> [3] fixes priority inversion problem with epoll by stop using rw semaphore,
> but it doesn't do anything about rw semaphore
>
> So I propose we keep both.
>

FWIW I'm thinking the same.

[1] fixes the CFS throttling circular dependency on RT but also improves
tail latency when CFS throttling is in use (so not just for RT).
[3] is specific to epoll but gets rid of the rwsem which is a win overall.

I need to go get my reviewing hat back on and stare at both...

> Best regards,
> Nam
>
>> My understanding right now is, that [1] fixes a CFS issue, throttling
>> while holding a lock is not ideal on !RT - but might cause a critical
>> lockup on RT - while [3] is addressing a similar (RT) problem in epoll.
>>
>> Best regards,
>> Florian
>>
>> [1] https://lore.kernel.org/all/20250409120746.635476-1-ziqianlu@bytedance.com/
>> [2] https://lore.kernel.org/linux-rt-users/xhsmhttqvnall.mognet@vschneid.remote.csb/
>> [3] https://lore.kernel.org/linux-rt-users/20250519074016.3337326-1-namcao@linutronix.de/T/#u

