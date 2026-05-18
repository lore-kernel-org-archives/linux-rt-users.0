Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DD5338595
	for <linux-rt-users@vger.kernel.org>; Mon, 18 May 2026 20:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135244; cv=none; b=Xn2xxYXq6OqI/MmH++uhwza9CYkJJkrFWMU2+OkxwLHRsCyFePK9tu9cdRh+Y22TzM2KKFRmsWRd/u/8wYzyWKplKzH0UBp32JefG22FPtVDhghfIIT70TNr1Ah8TojoO5MmzO4MO0G2dCjOO8d3vZjz46SaNEKmVGQ8XoxR+q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135244; c=relaxed/simple;
	bh=Iv8A5JD7X1LACh5ziTA1WkfcR/zx+d6rX5oOrs6rbMU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IiwDpfo/o0LQWoWXLJQdEGuCVloR8NHrh95Coh0jfL9hB/1WSa00Rmt1sU//P367YxTcdRc0v01vs9WHFKxf3KFkDVUzZHP1LJFq5z3Xe79lcoRObIvF2e9fuqQfeklLX2IYTcHyaeKTfG/boQVtZHVGzodi23uh2/5eb1YpzdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLP6huUd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLP6huUd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8332CC2BCB7;
	Mon, 18 May 2026 20:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779135243;
	bh=Iv8A5JD7X1LACh5ziTA1WkfcR/zx+d6rX5oOrs6rbMU=;
	h=Date:From:To:Subject:From;
	b=jLP6huUdfGipgTT9BrqnjldcIjCaUVtww63rrfMvjq6FerUXLQ+5njE+YFkuGOzq1
	 DdjittE0Pf8J1LFO1xAKNZS/MthunwNK9pLbhSM+iGeW6V8aQ+FpcZIB//u4sCO0jV
	 VkQLix2211lpgBb+yvDGz6NRkssOK973u5Qzz0f6Ng5paMH/tPhluM2EoEgYQv5jDW
	 /ibsq09i8Yxwe6MmrvxaxnpN/6ryi/nmK5bdTAKDZt3BGiO+yqSUxJrU2dO+yGryHu
	 VFDUxOq8UyGjYW8Kw14OTPOO4hZ9fIydq6HTzsVll7heXiQl8P4jRFJ7KbJvmB5tGg
	 YsKS/PAq6esQw==
Date: Mon, 18 May 2026 15:14:02 -0500
From: Clark Williams <clrkwllms@kernel.org>
To: wander@redhat.com, debarbos@redhat.com, juri.lelli@redhat.com,
	marco.chiappero@suse.com, chris.friesen@windriver.com,
	luochunsheng@ustc.edu, luffyluo@tencent.com, davidlt@rivosinc.com,
	clrkwllms@kernel.org, williams@redhat.com,
	linux-rt-users@vger.kernel.org
Subject: [ANNOUNCE] stalld v1.27.1 released
Message-ID: <agtzCiGKGsQjwIK4@lysander>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I'm pleased to announce the release of stalld v1.27.1, now available
at kernel.org, GitLab, and GitHub.

Overview

This release includes two behavior changes to improve usability and
error handling, along with extensive test infrastructure improvements.

Behavior Changes

Syslog Logging Now Opt-In (Wander Lairson Costa)
- Syslog output is now disabled by default
- Use -s/--log_syslog to enable syslog logging
- systemd service file updated to preserve existing behavior
- Prevents unwanted syslog traffic when using verbose mode

Exit on Invalid CPU Affinity (Wander Lairson Costa)
- stalld now exits with an error on invalid -a/--affinity arguments
- Previously invalid affinity settings were silently ignored

Test Infrastructure (33 commits)

- Added event-driven helpers replacing fixed sleep delays
- New pass()/fail() functions for consistent reporting
- Improved test reliability and maintainability
- Fixed various test bugs and path issues

Upgrade Notes

If you run stalld manually (not via systemd) and rely on syslog
logging, add the -s flag to your command line. The systemd service
file already includes this flag.

Download

- https://git.kernel.org/pub/scm/utils/stalld/stalld.git
- https://gitlab.com/rt-linux-tools/stalld
- https://github.com/clrkwllms/stalld

git tag: v1.27.1

Contributors

- Wander Lairson Costa
- Clark Williams

Full release notes: doc/RELEASE_NOTES_v1.27.1.md

Best regards,
Clark Williams


-- 
The United States Coast Guard
Ruining Natural Selection since 1790
