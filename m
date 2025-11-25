Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2002D33ADBF
	for <linux-rt-users@vger.kernel.org>; Tue, 25 Nov 2025 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764100721; cv=none; b=Ri9YHIGvts2dwn2B0Z7tfXvECRRQY6ohmy2Qsb2oCsXHEfk32xPNqTDybqBhB6uYwMFZdMBmpZa/FWh7T7mObZQY7IrUrMrTxQpmf86uM4TlRyixpE35R4Fqbk07RZoI4OskvymbdhL/Yd9FE2+/4vy+lpk/qncDqTP/t3Br55c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764100721; c=relaxed/simple;
	bh=sHdtFJgZg1rFD6lNY87A34ukdUpvCtPlrKLMTK1JgPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxp/lcK9yei8gl+R+v6/tcisK7A8CtWAfeNqhjCMzv1GMCIx12sua27CVVPN9toVOf4zg1YwDLncL5iIPuVedksype/Uws7ROcJGm/iN/tv7H5KJno6MdvDlaSlH6B8YgxYOglZK7moO79ZKgWrPI17CZacr/4h22/D3voyYfVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D149C4CEF1;
	Tue, 25 Nov 2025 19:58:40 +0000 (UTC)
Date: Tue, 25 Nov 2025 13:58:39 -0600
From: Clark Williams <williams@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: linux-rt-users@vger.kernel.org, Derek Barbosa <debarbos@redhat.com>,
	John Kacur <jkacur@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: Re: [stalld v2 0/6] Improve Makefile portability and debugging
Message-ID: <aSYKbwsEORrJ9KVa@lysander>
References: <20251110132241.43685-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110132241.43685-1-wander@redhat.com>

On Mon, Nov 10, 2025 at 10:22:35AM -0300, Wander Lairson Costa wrote:
> This patch series improves the stalld build system to be more portable
> across different architectures and compiler toolchains while adding
> better debugging capabilities. The main motivation is to eliminate
> hard-coded compiler version checks that were brittle and could fail on
> non-standard toolchains or different architectures.
> 
> The changes replace minimum version checks with direct compiler feature
> detection tests, ensuring that compiler flags are only used when
> actually supported. This approach tests each flag by attempting to
> compile a minimal test program, making the build system resilient to
> variations in compiler implementations across architectures like x86_64,
> aarch64, s390x, i686, and powerpc. Additionally, the series adds build
> environment information output and cleans up redundant checks to improve
> maintainability.
> 
> The series also includes minor improvements to explicitly specify the
> test target invocation and exclude development environment metadata from
> version control.
> 
> Wander Lairson Costa (6):
>   Makefile: Conditionally add -mno-omit-leaf-frame-pointer
>   Makefile: Improve compiler flag detection for -fcf-protection
>   Makefile: Explicitly run the 'test' target in the tests directory
>   Makefile: Remove redundant GCC version check
>   Makefile: Print BPF tool versions for debugging
>   gitignore: Exclude Serena and Claude Code metadata
> 
>  .gitignore |  2 ++
>  Makefile   | 42 ++++++++++++++++++++++++------------------
>  2 files changed, 26 insertions(+), 18 deletions(-)
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Cc: Derek Barbosa <debarbos@redhat.com>
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Chunsheng Luo <luochunsheng@ustc.edu>

Ack for the series (note that I have this now in my devel branch, which
is based on v1.25.1)

Signed-off-by: Clark Williams <williams@redhat.com>
-- 
The United States Coast Guard
Ruining Natural Selection since 1790
