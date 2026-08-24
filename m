Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A499C405C35
	for <linux-rt-users@vger.kernel.org>; Mon, 24 Aug 2026 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576313; cv=none; b=gjGVJrXMtur3aMDdV1DFWoRg2s2WjJ93X+TCkT/YtqTORSjN9Wp+uo4mwAFD8vmuHg82SMN9N6H4o4v+lvBfHNmOszNDuizr2XqY6TBQ9Fe3iMOx04kTlLwxCMxNwEDhYdZVs3XNgx4K6N4d9vcR7lISQSL4M9wGZaswfe2oA8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576313; c=relaxed/simple;
	bh=zAOckE8KFMoMbmV2/jZ6rnTRp1PeJ74EXiF2+18+uiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDA26epPxB+HmqueWl+aVGfiaVrQZI290b4Nx/00tZn7sURMdjgrb1fBZKqxzZhyp7Cab+D0BYTsuzg95oqu546evOUE+vVJ1f4EhCiadC4Obu92n2DvWTTOvRQmD2Sp4N8d9nFHPYVcid3qiJrgQBiNRB0eAmvwEA+gyUM5FzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O1GrBLfL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zXgf9OAr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O1GrBLfL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zXgf9OAr"
Date: Mon, 24 Aug 2026 14:58:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787576310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20BzACl1BQ9LEDU7tPE2RUNRDZM6WwtJaYdUpcYZtJk=;
	b=O1GrBLfL9pImfdCBO6Q8Z74MjlvYgPfvlmoLqjeMqLi6hkZLMOnE0cR0h/M4/Ij1pFYZaS
	ImnOe5YpMS7teHk0Bwi5fNfd1DDAVAWsgcNqH2dQxOZjKIUdjwGmpaHGX5FIF0/pUrvhc/
	HIAMNv93yag9HIjx5t5sMdNPGan/qjfJsH4oX0pw+//uHPngMUW01ClUlM85U6XlghFA3W
	M3ntjCEZlO7fI7KPxCd79+ed59XulIIPe46DkNlXQry9EzgqAFK9iNpro1mIccje9q1aAS
	70Vsor7N2b2wpJAmMrvBLSp39QgH5snk2j1U5C14En+wsLXeAnmosCalnmqxkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787576310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20BzACl1BQ9LEDU7tPE2RUNRDZM6WwtJaYdUpcYZtJk=;
	b=zXgf9OArI37FDiCsAM+52qIGSH+85iNmN0QdRogpDRHeh+Q9fSYr3BcS+pOCGpAjKifyon
	qSQ4bj161zBo9fBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>,
	Lukas Beckmann <lbckmnn@mailbox.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH v3] clictest, cyclicdeadline: Exit with failure when
 breaktrace threshold is exceeded
Message-ID: <20260824125828.ZHILUhYM@linutronix.de>
References: <20260824101852.2237494-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260824101852.2237494-1-costa.shul@redhat.com>

On 2026-08-24 13:18:52 [+0300], Costa Shulyupin wrote:
> cyclictest and cyclicdeadline always exit 0 even when the latency
> threshold set by --breaktrace is exceeded, requiring test harnesses
> to parse output or json to detect a failed test.
> 
> Set ret to 2 when break_thread_id is set, indicating the breaktrace
> threshold was hit.  The exit code enables shell expressions like
> "cyclictest ... && echo PASS" and seamless integration with testing
> frameworks.  Also pass ret to rt_write_json() in cyclicdeadline so the
> JSON output reflects the failure.
> 
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
