Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C82A932
	for <linux-rt-users@vger.kernel.org>; Sat, 25 Oct 2025 00:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761351071; cv=none; b=Sg0CNrK8cBaHy/9XybosJcHmCFHOLDlKnJtWNd+BnyrS74byGicd5VVUebFLCZ0VD72oLkbWJHxv90rOe/QiCQcmf65FEaGHpg8W/4B9vlAhlDTClzN8nTSdY0R52yPTtlQmKhY10v5rG2kBih5/ZHwgLiDhbw/aMNTJ4lqshGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761351071; c=relaxed/simple;
	bh=2uzTksFKLng+I8qyVmcXHlserGe/faTCzrVIh0VfXsU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nrbAg2Fb/DvPkLpqQq0Dfwsq0DaUsWQ7oF9tl9mm318VnKGcy0UCGI9jcg/UTRExcG4qBlLLVmo5o3u1gw/NQUJqfImGojRIJzUjMfRJeyZ0qBnBc510lTcSyglxW6g6dryOozCufg1yvfM0FNZ5JKDh24TVhIsDq3+P6RYAKx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIGJwrKb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIGJwrKb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B41C4CEF1;
	Sat, 25 Oct 2025 00:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761351071;
	bh=2uzTksFKLng+I8qyVmcXHlserGe/faTCzrVIh0VfXsU=;
	h=Date:From:To:Cc:Subject:From;
	b=VIGJwrKbSW6VlzdFySR4fUFwx6YQ7YgrEjYeEF0hxKxVFMdfZ+ZlyQjtt0GqEX4BM
	 4suXjo08gUhLd65K99Zz2yqptmH/hZlHGAizvsf8kEkY5nDcqYD0priRcxObUV016H
	 d2iZcrkjHWH2uKtKEs8xa+vPcx+JU7vkXS4uaVQWxzcVbyKqI2z/MnqFfMLBXrO/0V
	 A5LAROKYxADDRFQchnxqVn5likVZHY0sFc3jkHKJiJUg5so2IM+GpA6ytUMlcFEMml
	 POGaX0ezoUeyqrjCqse2wpCRC2Jup/RU3mxYirV5QxSkqM/Le6IVGQSDMgCS4bLBk6
	 3SWcuRyq8znag==
Date: Fri, 24 Oct 2025 19:11:09 -0500
From: Clark Williams <clrkwllms@kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: wander@redhat.com, debarbos@redhat.com, marco.chiappero@suse.com,
	chris.friesen@windriver.com, luochunsheng@ustc.edu,
	clrkwllms@kernel.org
Subject: stalld version v1.24.1 released
Message-ID: <aPwVnSoca8rS3Y-a@lysander>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

marco.chiappero@suse.com,chris.friesen@windriver.com,luochunsheng@ustc.edu,clrkwllms@kernel.org
Subject: stalld version v1.24.1 released

Hello RT users,

I just pushed the v1.24.1 update to stalld. This release has a few bug
fixes and some minor tweaks for logging and building. You can find
this update in the 'main' branch at:

     https://git.kernel.org/pub/scm/utils/stalld/stalld.git/
     https://github.com/clrkwllms/stalld
     https://gitlab.com/rt-linux-tools/stalld

Note that I consider the kernel.org tree as the gold standard. We keep
copies at github and gitlab mainly so that people familiar with the
PR/MR workflow style can submit changes. 

Derek Barbosa, with advice from Crystal Wood, tweaked the Makefile so
it wouldn't be so Red Hat-centric. We basically put all that in the
package build step where the specfile overrides CFLAGS and
LDFLAGS. There's now a help target in the Makefile and some compiler
version checks that hopefully will help other builders.

A segfault was found (and fixed) while running with the adaptive or
aggressive mains (rather than the default single-threaded main).

A new command line switch (-N/--no-idle-detect) was introduced to skip
the idle detection step in a processing iteration, mainly for testing
purposes but some of you might find it useful in production.

Some defensive checks were added to print_boosted_info. There is a bit
of debate on whether it's better to continue running or just crash
right there. Stay tuned...

I commented out a log message reported that idle detection had
detected no activity and so nothing was starving. Got tired of seeing
it in the log file.

A double-free was avoided by setting the cpu_info->starving vector to
NULL when it's been freed.

We rewrote the sched_debug backend parser that pulls info from the
debugfs file. The format changed in 6.12 and we missed that. We
unified the parsers and hopefully we'll be a bit more change-proof
there. Of course none of you saw this because you're all using the
modern super-cool queue_track BPF backend, right?

Finally I'm sure that you'll all noticed the notice in some of the
commit messages that I used the Claude AI to analyze bits of this
code. I've been working on a test-suite and using Claude to generate
most of it. While running, the test suite found the segfault and the
double free issues. So since I was already there with Claude, I
figured it should get some credit.

The test-suite isn't quite ready for prime time though, so I'll push a
branch named 'test-devel' up to the git repos if you want to play with
it, or even write some more tests!

In any case, I hope this release will be useful to you. Have a nice
day!

Clark
-- 
The United States Coast Guard
Ruining Natural Selection since 1790
