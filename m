Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FB01DC98C
	for <linux-rt-users@vger.kernel.org>; Mon, 31 Mar 2025 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743413929; cv=none; b=dHR1qOfJ/HUx/kFLFG6BYLn3IPUMOtDVR4WQB72xJmzINGU0rEMQkKxfioBbXfemfW2S7RA3QjTKAj0gf9OVSXUZzBgLuS4XJN3NQFtv9hic6I6WYfTGfRWnU+KMVNEy4DIoPj4PULwzjiuWj0KCzgxH6qXE3ZwHYrppZk0jK6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743413929; c=relaxed/simple;
	bh=F2fXcyrlZZszs7UkFqBOeIDNh61kMgn5lcG8bZgx5DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ln37WwWxbpcGxhpiOajQIF3NyMrv6ptb4BR3jyUzUR86lRkjRgq6JDsHMyYC86sJ/8+bwtAjQCwNpuZhnjGPa8pTT8totUTKFpAeBFjrswpU8TqAeDic3+WnXyyj8Uhrg3tCGIVAdiuEAwLXtAteiOhjETYT9t2qHoSaZ2hp1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fa6Y4b6i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e+xKbBEj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fa6Y4b6i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e+xKbBEj"
Date: Mon, 31 Mar 2025 11:38:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743413925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/GTemmLic3X2KD59bsEfGn5zx36IH7iuPDHwa+cPNQ=;
	b=fa6Y4b6iTigamt8w8L9YYTiVsq2Pa+ozDta6p9EfXv0W7E3Q9XCpUuLprkuBgNyaYvhlwY
	RZYbMSgsVFWEg7N/105kpN7MQ46RYYGVOzQkVP2yXcS1dRpXdeYrqGGsIoK32igILBZ5gd
	rhTNGFC+WpIAHBo6yUSPMQRy+y2VyRR2lMwlhctBZLUp2EAXPo/GekR0WkBYAEXS5s3I7r
	okwJYBVq89wbo3BinzHpde1CObSqavLBB2KBZFmQZ1tf84+RAVo5xkyQR3KR1eF0Oy6yY3
	FCmjl8uioq2DKt2KP10kUyesLv8LBRRd3ZDVJhEMqdkcFjy4NVwWgKZ3oVhfyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743413925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/GTemmLic3X2KD59bsEfGn5zx36IH7iuPDHwa+cPNQ=;
	b=e+xKbBEj5aW12EdHETzGrYLcdV4nWn7WsHHsh4/Z7e39EvFKVxXD0NRLoiihKiKuAJ0cvw
	wgAS01PrvTI3fqDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ben Hutchings <benh@debian.org>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 5.10] rt: Fix buid issue in be2net
Message-ID: <20250331093844.B9DjnmBS@linutronix.de>
References: <Z-cGnAlIvThsPiH8@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Z-cGnAlIvThsPiH8@decadent.org.uk>

On 2025-03-28 21:29:16 [+0100], Ben Hutchings wrote:
> The problem described here is specific to v5.10-rt.
=E2=80=A6

Thank you for the report.

Luis is aware of it and handling it
	https://lore.kernel.org/all/Z9yuIpi8zjrTCkoB@uudg.org/

Sebastian
