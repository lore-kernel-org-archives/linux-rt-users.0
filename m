Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24F130CDA5
	for <linux-rt-users@vger.kernel.org>; Tue, 11 Nov 2025 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872626; cv=none; b=sLQOo4aAUP+QQmpUCm6c4feMqXEDSLNAvc4/CQoNrPSkZ2Q928QJgRRaPU7XNjjn2zgd2nrddi/eoGiv/5ZekSt1TH7CASKsYRbQfK2TtVxArchCgF0A8ammzmC2ihqP7e/BdXUwydfmXvh9cOSOos5nhFpTfxw9ITIjQko3DlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872626; c=relaxed/simple;
	bh=JQSxMfCIfGh9t1a1I8I3HnyCT0DWrdHZtBr44gXHwr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEczxbsvY28iAMMlN0Ke+AZ5UxbCasuey6n1unppALDR3lZ2ek8spI2qFPy4YeBihW4uZPotlKfas0cjXQHlWB+BxBgDNMgBLdoEBtvpA6iBviy+otKHYIWa9jDwlDsAqg6A94v6rTUSVQeMdvWLWy4nJhN9DAiv/AVBX2No/IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZZK9Q+2E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KgNLUkdm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZZK9Q+2E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KgNLUkdm"
Date: Tue, 11 Nov 2025 15:50:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762872622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQSxMfCIfGh9t1a1I8I3HnyCT0DWrdHZtBr44gXHwr0=;
	b=ZZK9Q+2E53HODTjplQUGqDu6s56yGsV5b/btJ65dDvPEIBp4W/sUVzPDeyhRFOFlqK5NtC
	nVI+oPnSxOh/SqpgldiVbVo/Zo/l8gocnlu7+lYJj4uIHFUG+E5VQD6fRPIMI1/Znygx+d
	d3Q9O/4OemR+0L/HGEdP5MapwSUtIW3XF37qO+TkEpZE+Xds5FSCQjc51+bNfd0/y3Ek37
	k8GLwr760NgGluPHAyvyVe/9SzE0JuycfGiUd8wbI/SjV5t94QhhxfWs2F/xsjHVmIXGWQ
	b/ZVp3yp4pUv70U+jl7ZieJhKKlwie+7I5Wz5CCtXQnGKGJCnsRyQ5AM5OMmwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762872622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQSxMfCIfGh9t1a1I8I3HnyCT0DWrdHZtBr44gXHwr0=;
	b=KgNLUkdmGgh/dESKJVPYsHIZn4g0sH8ZUZhrJr56AhKvOn4070TJzdwodPA9QmDfgeNrvG
	JpsMR7P7xCj7NIAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Wander Lairson Costa <wander@redhat.com>
Cc: williams@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 0/3] Improve Makefile robustness and explicitness
Message-ID: <20251111145020.C7DI111V@linutronix.de>
References: <20251107161729.320087-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251107161729.320087-1-wander@redhat.com>

On 2025-11-07 13:17:25 [-0300], Wander Lairson Costa wrote:
> The first two patches add checks to conditionally use compiler flags
> -mno-omit-leaf-frame-pointer and -fcf-protection, preventing build
> failures on systems where they are not supported.

I don't know what this part of but shouldn't the Makefile just consume
what the buildsystem provided and not randomly strip CFLAGS?

Sebastian
