Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2442B17741;
	Mon, 23 Sep 2024 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727076692; cv=none; b=oplQwxXieN6n4SvL92xtUd4C54XnhsdZNWN+H3ig+XtnFVCpQZ+HrsLt0VDHA9s3spf2kX9TfA0XEf5XdMOp1RrB1XMwf5G5zqgy55JtyawMIkX4KJqcSgpJ0SNNHCp5G/rDZAftaZa8bhxEo9mmsVtiFCu6AlszRtihgk3lssM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727076692; c=relaxed/simple;
	bh=YOPrK/LQFNu1yTd7p8XEMFxAWFKnMsmN7u5aRla9zS0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fhJ07luihzImF1e6eW32HWlXhY9wI0kJbT3FUhm65VDpNDs69VURDB0HSS4QsuTOmvSC36S60XXA6Y6pnIbypfdq3wjsqXt/f4XP7y0FClRHl2eCK3+RxBet2I94mgNFDdAQOaWlhGNynwifjpTQghJp97MgcxOi3N0acP4MZQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=cRbvpk+F; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="cRbvpk+F"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D7B1BDB324;
	Mon, 23 Sep 2024 09:31:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1727076680; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=k4fe+L1YliAWTSVKJAMtXdF3NNuBlfyNCAN7rxxKt1I=;
	b=cRbvpk+FmASae5dX8/+3P80iX7vlauYLYeK5Me0QikOUc2OBXxp/AS9i44p2cTeqx5sYLa
	qvKAvkwDqK3luGrQgrLjsQfnCg+G4vMQGNz7+Pca85URM1hHXwmhUdpGSl6Q7iNNbfEMjH
	fD2olnuhuTZEe9L4fKRbJGe7tDGW6yGOjQq8BHABkzttdMxVHI+T/lVY6UqMnsmh0TpaAb
	PZF3j/BFpJYYS96YsJM5dFTuJe4m+suLoOv1KIqQn8Urnz6IMeUlQIWKz9XHV/Jht3rQE4
	t5wv3o7I+WVjbIKJY2wdLzEU66/4GOG1CmMYEWuFSoXmXzWWmjjBZJ6RvbNHBA==
Date: Mon, 23 Sep 2024 09:31:15 +0200
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Tom Zanussi <tom.zanussi@linux.intel.com>, Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.322-rt138
Message-ID: <172707659553.17516.8509354000862390767@beryllium.lan>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3

Hello RT-list!

I'm pleased to announce the 4.19.322-rt138 stable release. This is just
an update to the 4.19.322 stable release. No RT specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 27022b8669f4531defab96b62fddc6e2db7f04a9

Or to build 4.19.322-rt138 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.322.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.322-rt138.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.317-rt137:
---

Daniel Wagner (1):
      Linux 4.19.322-rt138
---
localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
diff --git a/localversion-rt b/localversion-rt
index 41b444e910ef..9f63718d5731 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt137
+-rt138
