Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.254.189.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794301489;
	b=0hQlTCorDfBRP8nmCCclmgLG3FtTSsPP2YDhf2z2qzRY6HMO/ISHna3xpLO1Zbws7D3Z
	 m9xB/UOA7rzhNpM0thBOUQevXWPUyhHW4N5JXVc0oVLn/6TtCmUgRxTo+pBhp0L8F0gjg
	 CeBUrCeJjxBbNBw30jkyQiW8v/OfW+GQSQfFTQjRhEirv0GGA1tAV/boPwcdWlkb0iDTH
	 tGiy8YGXi1Jtqc0szvUDW93cFdTfECotfqGWCMpdG5k7I/dhxrpcPF6M3493C9CDm4JDm
	 12HFz7fOONPQs7jHqYV6StM5NfnzS8cJmKr3/940Ik0s7GFVZ0RTlzhaRIW+ZpcmtsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301489;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:From:Content-Language:To:Subject:Content-Type:
	 Content-Transfer-Encoding;
	bh=Dw8jDsLfBGQSAKELoQtE3+wk1qdk3BHMYCMvjE+2m7g=;
	b=y1bPg0eUJaS0viNl+qfir9rkFhqvlhBn5lCJ9zmjiUs40lj3mprVyrGP0p6WK5ktdidZ
	 YSA5hbt6TNktulXFWmHwxKL/ljYO0tDdQl7RpMrub24ujGVYJVqXCIByU8IwILz5XHtA8
	 zSLKAoZTO+Ykax855I1FHJRss3jdrJnGs81oATs1DiunI+EV1+pD0cUwxt56h7SY4Yd49
	 YEhNezr/zFBj+jLQUE1ifYAf3cfFa/wE1uegzXS1ErzDOzeNJ2OF0CSp/2CR7nmRaP/3J
	 2a1Ws9GgZI/eT0KPbFeEu8yAvPGUZZT0mOqU5sX+sHzuQkpPJIcm1R7jjpJl4fStZrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=maurer.systems;
	spf=pass smtp.mailfrom=maurer.systems;
	dkim=pass header.d=maurer.systems header.i=@maurer.systems header.a=rsa-sha256 header.s=2021 header.b=dvOb3qyC;
	arc=none smtp.remote-ip=80.254.189.73
Received: from admin.maurer.systems (maurer.systems [80.254.189.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86792606A321
	for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2026 09:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86792606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maurer.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maurer.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=maurer.systems header.i=@maurer.systems header.a=rsa-sha256 header.s=2021 header.b=dvOb3qyC
Authentication-Results: OpenDMARC; dmarc=fail (p=quarantine dis=none) header.from=maurer.systems
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=maurer.systems;
	s=2021; t=1794301479;
	bh=Dw8jDsLfBGQSAKELoQtE3+wk1qdk3BHMYCMvjE+2m7g=;
	h=Date:From:To:Subject:From;
	b=dvOb3qyCst3bGBre74mNWKrNRlK+qyGssEMdF432Jce/gbSvdPYQ3GktftTsM+Mh6
	 vZshs9U02fqcl37l8lN9gergQGvbTw2oEZxLkxBamWQAvPRsbOQZbn1SByembKEbQf
	 KhD078TbkAV1VYFIQ3ypnZWc/P0YoMMavW+Z4whi14m5P2WTkh3HRvVjlNqdMtx7kh
	 dYm2zle/W2NBogTkeO6xUa9BxoVUUGCAuDAE8cxkPQ5qDdfEEf062J6xso/Y/+wmlJ
	 IyqN1qUXv+/9rS8ZIRKea3xlu7z1984RSFj364l0RCkCpYloNPtyLxRAJVfdpftIHD
	 3tN/mMj8NKong==
Received: from [IPV6:2a01:2a8:8108:e900:8c28:9433:3ce8:909e] (unknown [IPv6:2a01:2a8:8108:e900:8c28:9433:3ce8:909e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by admin.maurer.systems (Postfix) with ESMTPSA id 4C848480349
	for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2026 10:04:39 +0100 (CET)
Message-ID: <14a6b7b2-8b73-4905-9aad-c2bbdc78f4cd@maurer.systems>
Date: Tue, 10 Nov 2026 10:04:39 +0100
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Simon Maurer <dev@maurer.systems>
Content-Language: en-US
To: linux-rt-users@vger.kernel.org
Subject: Real-Time Inter-process Communication
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I'd like to introduce a project I've been working on: RTIPC, a real-time inter-process communication library with implementations in C11 and Rust. The C11 implementation also provides C++ and Python bindings.

The core is a bounded, single-producer/single-consumer, wait-free, zero-copy message queue backed by shared memory, with optional eventfd support for notification.

During the setup/configuration phase of a real-time system, the shared memory layout and the associated file descriptors (shared memory and eventfds) can be exchanged between processes over a Unix domain socket. RTIPC provides a built-in mechanism for this, but it can also be integrated with other Unix domain socket-based IPC mechanisms, such as D-Bus.

The library is intended for data exchange between real-time processes, as well as between real-time and non-real-time processes.

One feature worth highlighting is a wait-free force-push operation. It allows the producer to enqueue a new message even when the queue is full, by discarding the oldest message that has not yet been consumed. Since this significantly increases the complexity of the queue algorithm, I used SPIN/Modex for formal verification:
https://github.com/rtipc/message-queue

For data representation across different programming languages, I'd recommend using C-compatible structures. Most general-purpose languages provide some level of built-in support for C structs, making them a convenient choice for interoperability.

To ensure consistent structure definitions across languages, I also developed rtipc-compiler, an interface definition language that generates the corresponding C-compatible structure definitions and encodes structure metadata into a buffer. This metadata can then be used for runtime consistency checks between processes.

I'd be very interested in hearing your thoughts, particularly regarding the architecture and potential use cases. Feedback and suggestions are greatly appreciated!

Project: https://rtipc.github.io/

Best regards,
Simon
