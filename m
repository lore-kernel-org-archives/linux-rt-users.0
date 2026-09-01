Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685832D7DE9
	for <linux-rt-users@vger.kernel.org>; Tue,  1 Sep 2026 06:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788243515; cv=none; b=hXsJXJJwG7da57PTU/6zN3h2qNcy8YCej5ScMJuKDTaWIKMZoOfYPwOnnn5fQ60r/yJJzqtKCjCp46n2dRvw+FYzPYJMNE+mf6li8Rwonn1qJG7WpQZsDCAm9NO7hvGLAWGnFwnBScdQRg7oPZ4aP6RQ3s4wDgOwqIoqLW1eVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788243515; c=relaxed/simple;
	bh=wzDkHC7qQzo0GcB0frFniVAEwoenYkLNRJ7pABB1tIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4Pdb54J9wr993FcLTNUscTA5+EUqYbCTM1e/NQkdERMD/ew8CjRU0+VM7mUjqshuCWo2jd47eXA+tgi075XCtjMGYSnrt5XRiQHqp7OUtEzrwyqIsqHEpWDjcVgEipnnxajiTbDXOcM2mfpkZKM9fBgiuyo17XiHqTM5UEyCdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EsSkv60k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=umuix511; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EsSkv60k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="umuix511"
Date: Tue, 1 Sep 2026 08:18:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788243512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzDkHC7qQzo0GcB0frFniVAEwoenYkLNRJ7pABB1tIg=;
	b=EsSkv60ksfOZtR3FHFg+C3NPtyhmDJ615+/reGT1qMT1uqIR4kybk6xX1EJRjX076WNABX
	ozRb1PnBcn6LfZUccXLISj3XZtN7sg19EC/5kL6jR4KJXKdx3jhfXZ4aIp3caZd0gIC7y1
	zM93flSgnPdhwkXrLMGA+gM2U90HVrwyVlVTc9Xkoa/dpOWlEY2mRS6BBOFAse6w1IO4cn
	435CkMh+jgpXGO7MiqaVaVYpxPkMV9zjfEvVSXpiUEcGiY3WAEZD2dS9DUvGVVfYhxPkTo
	lfhjRmq9AX0oNgCFVrO70SOi8yzoknD/Vmul/4wdhEHrkJfNfRNch36NCdTOzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788243512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzDkHC7qQzo0GcB0frFniVAEwoenYkLNRJ7pABB1tIg=;
	b=umuix511siVp86lcINgqM18qqwouazLTc4fDhCIUuyxxxJci7G+GyLZNcqwgnLVhHPOvRk
	ZRADKwVOtvBouqAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] cyclicdeadline: Fix potential path truncation in
 open_cpuset()
Message-ID: <20260901061830.EghXNoCZ@linutronix.de>
References: <20260831164810.65457-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260831164810.65457-1-jkacur@redhat.com>

On 2026-08-31 12:48:10 [-0400], John Kacur wrote:
> gcc -Wformat-truncation warns that the "%s/%s" format in open_cpuset()
> may be truncated because 'path' is unbounded:
=E2=80=A6
> Signed-off-by: John Kacur <jkacur@redhat.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
