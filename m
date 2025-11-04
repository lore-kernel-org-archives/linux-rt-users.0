Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D881C7012
	for <linux-rt-users@vger.kernel.org>; Tue,  4 Nov 2025 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762286236; cv=none; b=PUUZ6VuTy2IFO5ojcm9nOL+s/9fXnkPtLEvaEludDYGYGkZR7aN8zv8tC4nMToGzQzPNbfMA5wLI+teKW1SgfMIEbeA7PO+zuueS9/XQ2VVfd21u/Pgi9SLxUHnwCh8Nf9btH9nnjsE0amw4Y1AYEfG7yGOC0XrTCZEYKwmgD/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762286236; c=relaxed/simple;
	bh=wGwTCyzB6K/LnQIiQ7k3yOnejZodbiXdnOpcubJD0C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozcx1DQZMEraRMQgC/BYcu4atAYfqp3K5ZQ2ufYquDqcBLOWWX9Ru0KshH4P6F5hBYaFEhFFEqbOfegdto+QSAu9OJlByjlDPUCB0Eb8e393H+kqGDdD1p1ryToOUFAizdQJkVl1Bmi4W56jygYIT+/nQGg2PBoHPYjk5zltBuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1188C4CEF7;
	Tue,  4 Nov 2025 19:57:15 +0000 (UTC)
Date: Tue, 4 Nov 2025 13:57:14 -0600
From: Clark Williams <williams@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: linux-rt-users@vger.kernel.org, Derek Barbosa <debarbos@redhat.com>,
	John Kacur <jkacur@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: Re: [PATCH] bpf: Add BPF CO-RE compatibility for older kernels
Message-ID: <aQpamuow4ucROOAK@lysander>
References: <20251104141144.31173-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104141144.31173-1-wander@redhat.com>

On Tue, Nov 04, 2025 at 11:11:44AM -0300, Wander Lairson Costa wrote:
> Introduce a `thread_info___legacy` struct to provide BPF CO-RE
> compatibility for older kernels (e.g., RHEL 8.x with 4.18) where the
> `thread_info` struct lacks the `cpu` field. This allows `bpf_core_field_exists()`
> checks to correctly determine the availability of this field at runtime,
> preventing build failures on such systems.
> 
> The `task_cpu` helper function is updated to utilize this new legacy
> struct when accessing the `cpu` field from `thread_info`, ensuring
> that the BPF program can adapt to different kernel versions.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Cc: Derek Barbosa <debarbos@redhat.com>
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Chunsheng Luo <luochunsheng@ustc.edu>

Applied to my devel branch along with the BPF verbose patch to the
Makefile. I'm assembling the v1.25.1 release which will be these two
changes and the current test-suite. Hopefully will go out today or
tomorrow.

Clark

-- 
The United States Coast Guard
Ruining Natural Selection since 1790
