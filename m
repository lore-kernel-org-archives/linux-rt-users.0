Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921673D410E
	for <linux-rt-users@vger.kernel.org>; Thu,  2 Apr 2026 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123382; cv=pass; b=tqGdavoF68LCJ3RAqJU/5sppGKiyHHcjplX9aM9blTTKBNdBV/THMYz0dvCoHU1WBPnFfXoSO4+5S3hWqRyS+NPGqZVfgdKDLkAJyVOIk1DAE0x1er7Y1apiKqFcSgMzEZrm/l35Qf+7nZ7wI51KVtTocEfw9yqJt+tWIeZVfRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123382; c=relaxed/simple;
	bh=z5FpIBQQ03mUsmNHF2ialIHYPEm8eRXWyZLlR0AYPFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+9qit8mcNMrWiqavbWxUehUQ5K8iEoaTQdd791kHKcdJHLhQqbQm29aud2rEEamvVBmrULDDZhH4nnxriFnBZMk5Fq+YbW4VucASsOKnzAKZ71TXjIFUgdN9I3R9FsfkYelk35/ZdDiaHlZu+ZUjtalH1lQd8BQQoj3lb5E9eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWpDCS1V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOBaqdFG; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWpDCS1V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOBaqdFG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775123375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z5FpIBQQ03mUsmNHF2ialIHYPEm8eRXWyZLlR0AYPFg=;
	b=LWpDCS1VjflzmgDG/PxwXOMQq+9TmI6g72ySxcoGjYJx86B22ZGpBNNOGyczK0CLBpFoh4
	Z+boYVlLSfcLF2qNjIQDZH6tN3GhXS47XzQRCSPvdY9SQIbBadL5ecNnIqA5E3IremL6A8
	MDNxBAG1/5rJDanUEPB46P3Pd5oNAHU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-e_wyQQ1qNwaQYdAzXK1INg-1; Thu, 02 Apr 2026 05:49:34 -0400
X-MC-Unique: e_wyQQ1qNwaQYdAzXK1INg-1
X-Mimecast-MFC-AGG-ID: e_wyQQ1qNwaQYdAzXK1INg_1775123374
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b844098869cso55512966b.2
        for <linux-rt-users@vger.kernel.org>; Thu, 02 Apr 2026 02:49:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775123373; cv=none;
        d=google.com; s=arc-20240605;
        b=UDXRAow2mqzh1F8FL32I3v8WPt3/1eq9pmM5NtI9xZbGWPJqtcXZQs1R4oHWjug4cp
         dSVi1tRCMCxG5W18XVb0n3TlYJ7JT4cFH9rYHHsKk9C5gi3Jl7BhKJOSEyDPxXDWUk6S
         fvTQyDzQfMF9+iAwkGLmGTytmoARHdjU2zYAbdojrT4ldxLYixCMQ+sIne4AHBWkXm9j
         ohCD1Gy9B5xAKL8TjQyaCaywrPz65xk2rII+l36hq6uasuYjQgK2tZVx2Og1YiMcPS0T
         UtHBEtIqF2QnGJgKK3WX0FFa4qDrDI34rBdxGeVVefBkESFTzibH5Jd81TZJbOnwMBLR
         pabw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z5FpIBQQ03mUsmNHF2ialIHYPEm8eRXWyZLlR0AYPFg=;
        fh=jPTSwIb2YXPXYBQrori4JuPOjwuHuEYu4g/48k4ftpw=;
        b=Zkj3TBE7bYXrSRyZNA8h3T81dlmAUQEdQ02ZtzYi3U+clRxI2Bf0Wm6evPQ47j7twO
         ehUzr/wocS45KumSrfTdp6peuVBYR2SKXPc1gqMDNw12zfi7OUiTDFVZ0fvOP7N2ZSrQ
         7fsicgu7StOe3yoVkMhzNXvNF0D4qdpCpxyphj7kwYlLJs8rF2Pmqq2q+DvL0DnbAoIZ
         NdZ1DwKtrgwWZQiaG6SJFj9N2tKtBQB9WIvjxDmyGRuI3Ix4NG5EWYo4ddR3/bAll9NB
         ljkGWjDXzNptbJkQQVeUhSgKrr67ruTYL8x7CQQoyFlZKAaU6TqLJUmloqussPZYimtK
         h7Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775123373; x=1775728173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5FpIBQQ03mUsmNHF2ialIHYPEm8eRXWyZLlR0AYPFg=;
        b=UOBaqdFGTixDkdR6S35LVJjoFbXZ5cM2ZGgDD2OKMOrb5dXOS99tH6hYnIB9FMO31j
         W3m4oqmXQVWZkuTX4oU5da+LG4bfp8WKh5eHuorBEOw8HPAKoN8YjguP2zEJs3Qy53Aa
         UHu6VA9+QkhuwqHdjW2qw0MTzGH4gBJX0z9TwXqAvhKZXNcU9G46DspqjGbdJYTwGqCe
         4aa0i/yIVs8EH5wAphwGc8TUHyce31EXOiCY9e5s1uuRmzpC/wHS0dJ8KIYvWi7E8E4W
         O5SxzTTb1PbFk7/YYfhnWTaEDCrrKlnaIOmuCVM8YBgEWRe0Vw1t92KGJb+aQZEJKkce
         MYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775123373; x=1775728173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z5FpIBQQ03mUsmNHF2ialIHYPEm8eRXWyZLlR0AYPFg=;
        b=fucEkpA0/UqrjYoo9m7QebI2UIN7syKVj+x97FFjsyNr562RRis1bkW+alcVFZ/gN0
         kqz9S27PX7dt1o7Gcyo/APxHLw7bux1syCr7WoY9c12cr5LBfQnZR4dpC7LuGVzFdsRa
         oY4jn7F3JVPOO7eYn0Ye7/8iUqYGedhxZPGm/TpY1omNpsfqjtJaoKB0x1kZST0hHisE
         yUuoYSef8FX+d6A64dMnuxpp8SSGTj7zyK4pT+jxhHKWg/94j/u2Lv4umchkNGer/66V
         ckznvK5bYW99s9RNyGSVk+8UC8oXJBO27bqnUVNhnHjjPCyuG4MOWcsa9jGbdzV+hgxz
         qTpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwcDnbYfhwi4r8kS5Y0kDMW4w07/PDAswxtZGhGsVKqNz7TmTavTajgEiF9YvkVCQkYjidlnT59NrrqSMNGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPhus1RTFqS+Xz58u9Roe4lLVhD823Sngc0wZCGPBEt5ArBhMc
	2uM1JC/E1TIUVZMIipPltxkJ7hm47ll/MwQ/4I+UBfzM8BTfGedjBw0z6c0uhTEO7V6vPXU8obi
	AATEAyBO95qbBY83HpZaTaBuJoeg7myRrnsKNbww8y8GaTpJnkjN0lwqNbci9Sh+2G7E8AmJQCD
	X2Gy/0u06DAjWie2pzRS5ysnRwbdHaj0C/mEoA/3s8TQJHxXSRsco=
X-Gm-Gg: ATEYQzwWaAoU5qEzcXNjVsfxlqdw0JMbXE/z0/YCU/DVoh38YkWj8ZeVfRSYoYwqpk4
	z4cHVrfi2lXJ2CEg7btpLaQLSkPw564BAoVBn6k1TznFE9zLNJc+UuOOqC+38oAqpFy7JOxo8Vf
	a8pE3vRGArW4p1j2IY8o1aDzNBdYWGVpmBgEEY4NbDNfRlCSzwKNEmIRLVaxuxYKnpjGSF7KVkM
	SI9Dw==
X-Received: by 2002:a17:906:6207:b0:b98:2d0d:fc00 with SMTP id a640c23a62f3a-b9c13b0b08emr475389066b.24.1775123372908;
        Thu, 02 Apr 2026 02:49:32 -0700 (PDT)
X-Received: by 2002:a17:906:6207:b0:b98:2d0d:fc00 with SMTP id
 a640c23a62f3a-b9c13b0b08emr475385466b.24.1775123372331; Thu, 02 Apr 2026
 02:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22ffc044-4cc7-468c-b11d-9b838c92e82b@siemens.com> <20260401165841.532687-1-ionut.nechita@windriver.com>
In-Reply-To: <20260401165841.532687-1-ionut.nechita@windriver.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 2 Apr 2026 11:49:20 +0200
X-Gm-Features: AQROBzBJw-tLhM-lD_x8-woUH2LWxJHrMMtqB3L4YgOqRmMqBGl5_Aj9bKxBLJU
Message-ID: <CAP4=nvQehXtd2AEFzuRzcqfXOmU6U3LH9M-nQTvNkdCtAV8YTA@mail.gmail.com>
Subject: Re: [REGRESSION] osnoise: "eventpoll: Replace rwlock with spinlock"
 causes ~50us noise spikes on isolated PREEMPT_RT cores
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: jan.kiszka@siemens.com, crwood@redhat.com, florian.bezdeka@siemens.com, 
	namcao@linutronix.de, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, frederic@kernel.org, 
	vschneid@redhat.com, gregkh@linuxfoundation.org, chris.friesen@windriver.com, 
	viorel-catalin.rapiteanu@windriver.com, iulian.mocanu@windriver.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 1. 4. 2026 v 19:08 odes=C3=ADlatel Ionut Nechita (Wind River)
<ionut.nechita@windriver.com> napsal:
>
> Separate question: could eosnoise itself be improved to avoid this
> contention? For example, using one epoll instance per CPU instead of
> a single shared one, or using BPF ring buffer (BPF_MAP_TYPE_RINGBUF)
> instead of the per-cpu perf buffer which requires epoll.

Neither BPF ring buffers nor perf event buffers strictly require you
to use epoll. Just as a BPF ring buffer can be read using libbpf's
ring_buffer__consume() [1] without polling, perf_buffer__consume() [2]
can be used the same way for the perf event ringbuffer; neither of the
functions block. If you need to poll, BPF ring buffer also uses
epoll_wait() [3] so that won't make a difference (or is there another
way to poll it?)

[1] https://docs.ebpf.io/ebpf-library/libbpf/userspace/ring_buffer__consume=
/
[2] https://docs.ebpf.io/ebpf-library/libbpf/userspace/perf_buffer__consume=
/
[3] https://github.com/libbpf/libbpf/blob/master/src/ringbuf.c#L341

That being said, BPF ring buffer is not per-CPU and should allow
collecting data from all CPUs into one buffer.

> If the consensus is that the kernel side is working as intended and the t=
ool
> should adapt, I'd like to understand what the recommended pattern is
> for BPF observability tools on PREEMPT_RT.

The ideal solution is to aggregate data in BPF directly, not in
userspace, and collect them at the end of the measurement, when
possible. This is what rtla-timerlat does for collecting samples [4]
where it was implemented to prevent the collecting user space thread
from being overloaded with too many samples on systems with a large
number of CPU; polling on ring buffer is used to signal end of tracing
on latency threshold only, no issues have been reported with that. To
collect data about system noise, timerlat collects the events in an
ftrace ring buffer, and then analyzes the tail of the buffer (i.e.
what is relevant to the spike, not all data throughout the entire
measurement) in user space [5]. The same could be replicated in
eosnoise, i.e. collecting the data into a ringbuffer and only reading
the tail in userspace, if that suffices for your use case.

[4] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/tools/tracing/rtla/src/timerlat.bpf.c
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/tracing/rtla/src/timerlat_aa.c


Tomas

