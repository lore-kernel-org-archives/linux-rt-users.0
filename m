Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B583D9DD7;
	Mon, 11 May 2026 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509320; cv=none; b=FLOgFh/oaGrDQG2MhiJKxi++oavGS0d14FrksrqQA5wQIfL7t8DJm8erC2Ju5PAWo9nWrk8dqVWE1iADNkfw25gXwqAkjC0Gi/+jg85N0jQKhO6cu/TFfe+Oh2837cDADsCT4xtRf+aZg57pJYZpBwrgi4jK/eeq1E8rBn70gBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509320; c=relaxed/simple;
	bh=UWwlvz/FBg65FNAhHu+MP/kqeZ/hILQT6+2DtYu8mYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzTWnHYnZXsyHACELya63EyzSK8RyaqCbPFF5Ol+hnTaQDtQ2mu0NHuSholkSimPVbK9+IfeSJZUNaHAcBx+df0wKdDEGvZDITZwkmQGp2Vxml20I7HQcppuHhH/VPpzZP04DMRNFS8PLCi2hZu1/HKbaH+wHKpFDaI4A7XWh50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6/mdimA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6/mdimA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF1DC2BCF7;
	Mon, 11 May 2026 14:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778509319;
	bh=UWwlvz/FBg65FNAhHu+MP/kqeZ/hILQT6+2DtYu8mYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S6/mdimA/Varc6IDGxnvDIUXKWhsf+TjpoEuSUKTty5eHbDf3BHRJ05RVz0nbrw2l
	 JKM2EUD5ZGAy4owhWqPD8rfRwXjNfr7v6AlMulsyuHNMZNZ53Y11hFAaN8Mf+l6s8u
	 qrUuKTtiINSIrMhG3O4u833YpyF5F3lHFk6WFM0X5HzPNcf3xfB1tL7jbicc/xSYko
	 TjW5/YrbyjUnZgS5EIRzR66K1m+Cy/rJwvWiO3G8Ks+1+2vLR6x1uMmkpKYfSIcIu1
	 dlQKOlFGBMMfqoYxy76aBvdh2medwWbFkRXd+98QUTyom97t9igqIgtvAKkIZOYmhz
	 wHXnwSgla+SIw==
From: Sasha Levin <sashal@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Lukas Beckmann <lbckmnn@mailbox.org>,
	Mike Galbraith <efault@gmx.de>
Subject: Re: [REGRESSION] 6.12.y: d66792919d4f (sched/deadline: Use revised wakeup rule for dl_server) causes latencies up to 50ms with PREEMPT_RT
Date: Mon, 11 May 2026 10:21:50 -0400
Message-ID: <20260511141441.stable-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <04657838-46d1-432d-95e1-eb73b930b032@mailbox.org>
References: <04657838-46d1-432d-95e1-eb73b930b032@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, May 10, 2026 at 10:57:46PM +0200, Lukas Beckmann wrote:
> I am reporting a regression which was introduced by d66792919d4f on 6.12.y.
> Since this commit, cyclictest reports latencies up to 50 milliseconds,
> on kernels with CONFIG_PREEMPT_RT=y.
[...]
> Is it possible to revert the commit?
>
> I can provide traces or help with testing if needed.

Thanks for the detailed report. Before I revert d66792919d4f from 6.12.y,
I'd like to confirm whether the underlying issue is the missing dl_server
rework chain on 6.12.y rather than the revised wakeup rule itself.

Mike's reply notes that his local 6.12-rt tree carrying the following
three commits in cannot reproduce, while the same tree without them
reproduces quickly:

  cccb45d7c429 ("sched/deadline: Less agressive dl_server handling")
  4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
  a3a70caf7906 ("sched/deadline: Fix dl_server behaviour")

d66792919d4f's upstream commit message explicitly says it relies on the
state established by a3a70caf7906, and none of the three are in 6.12.y.

Could you give those three commits a spin on top of 6.12.y (keeping
d66792919d4f in place) and see whether the latency goes away?

-- 
Thanks,
Sasha
