Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CFE23B632
	for <linux-rt-users@vger.kernel.org>; Thu,  6 Nov 2025 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468522; cv=none; b=FKJGVgqxaS3pzCHR6H40kE2gmj13+TIXPf80vjoZP0Otejym3wgiNIMowLsQm7/Jg2RypugzZLLz3XSolYNvwsppKQhwnNToFJPt5ENCdKy7miA/noSEXtem6+RQi2R8T1Wo5CcqIBPXsBqHmOK1tMrdcUqZy9kPh94D2UQw4SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468522; c=relaxed/simple;
	bh=LUfPO9HbmTb3mPmzU0eODDXjH13azOWFBFf+jSi81Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ga2/PUHkW7AYyiLOJK8cLKP3hdoXkJdGldi8AVhIKtJpOUWsus7rkUFipxVIAam1EJ4c2iW+79aUZhTnDvaL63BeSpW3w6NqYL9J18WL2P4yukOk3Ey00JnWddMB6Bdu9w7yVlvfnqYXt+a+ArmAHxHpuAJaNy+/4iGtcJ+AQxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7jd/fg0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7jd/fg0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B823C4CEFB;
	Thu,  6 Nov 2025 22:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468522;
	bh=LUfPO9HbmTb3mPmzU0eODDXjH13azOWFBFf+jSi81Z0=;
	h=Date:From:To:Cc:Subject:From;
	b=c7jd/fg0UbMG7jgLIM2GjpoG98fgx13yH8nTWAj657QgWdVHcTdezToAVvcshfiCh
	 s/o3pVjpjkWD/4kbU2vhEMH7UfwR7yafegry3H0ieIuk/kJdDaVFWh9Jbt9SzZZtTc
	 TAQVAWPfhh84OPHemMBM/k5lUN2aA++prhZPtuEeh/5m2WjWuQLRBheRBO6Nhvpeae
	 Mgf/CpWNjU180RV29Be8/4ieDcPa9pX+UQOX1sfNHyQPN5+7pfU2j4DwPsXMuj04ij
	 +Lbxed8mNpn5lWbcWJqkF5MlRxCWchHeSxrBPidvcSAiVBV1vVm+xjjYL0GH/ocnzj
	 bcABD8VslP9fw==
Date: Thu, 6 Nov 2025 16:35:20 -0600
From: Clark Williams <clrkwllms@kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: <@stalld>
Subject: stalld version v1.25.1 released
Message-ID: <aQ0iqGHpAFS_dj-N@lysander>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I'm pleased to announce the release of stalld v1.25.1, now available
at kernel.org, GitLab, and GitHub.

Overview

This release contains critical bug fixes for BPF compilation on
older kernels and comprehensive test suite improvements.

On the subject of the test suite, you'll notice that I made pretty
heavy use of Anthropic's Claude Sonnet 4.5 to generate the
scripts. I would really appreciate some other folks Looking at the
test runner (tests/run_tests.sh), the helper functions
(tests/helpers/test_helpers.sh) and the individual test scripts. To
be clear, I didn't just tell Claude to generate them and then check
them in and say "Good to go!"; I spent around three weeks getting
things going. That said, I'd love to get into a good
argument^wdiscussion on the way the tests work and whether they're
worth running.

Key Fixes

BPF CO-RE Compatibility (Wander Lairson Costa)
- Fixed build failures on RHEL 8.x and older kernels (4.18) where
  thread_info struct lacks the cpu field 
- Introduced BPF CO-RE compatibility checks allowing single binary
  to work across kernel versions 
- Made BPF compilation verbose for easier debugging (Derek Barbosa)

Test Infrastructure

This release includes extensive test infrastructure (97 commits):
- 21 comprehensive tests covering all stalld functionality
- Matrix testing across backends (sched_debug, queue_track) and
  threading modes 
- Automated test discovery and helper library
- Configurable starvation generator for controlled testing

Test Validation

Full test suite executed on x86_64 and aarch64 architectures :
- x86_64 (Fedora 42, VM): sched_debug backend 100% pass rate (19/19 tests)
- aarch64 (RHEL 10, bare metal): sched_debug backend 100% pass rate (19/19 tests)

Minor test timing issues observed with queue_track backend in VM
 environments (2-4% failure rate) attributed to virtualization
 and/or architectural timing artifacts. Core functionality verified
 across both platforms. 

Download

- https://git.kernel.org/pub/scm/utils/stalld/stalld.git
- https://gitlab.com/rt-linux-tools/stalld
- https://github.com/clrkwllms/stalld

git tag: v1.25.1

Contributors

- Wander Lairson Costa
- Clark Williams
- Derek Barbosa

Full release notes: doc/RELEASE_NOTES_v1.25.1.md

Best regards,
Clark Williams

-- 
The United States Coast Guard
Ruining Natural Selection since 1790
