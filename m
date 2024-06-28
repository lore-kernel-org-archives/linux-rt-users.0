Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047354D8C5;
	Fri, 28 Jun 2024 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719600779; cv=none; b=olgZeIIxiNlZfHumJGIIJ1wwqIGoQjmx01DN4VRt0mKho+Aw/7TBfNPcgcQTJxSWmou5sVteiUHoZNB3zzhEAhPOlhol/8YooJ1Fh7xA64AR3nJxd10RGEQJfCp3nOTGznJVr3UmyDcEWQMmXEBiLew2/YHyPvs+/FhZTF8lgM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719600779; c=relaxed/simple;
	bh=ZNwzUKaa3y5SpI0XZ5LFMfIC83k5Pks4WRoj2iWKqAg=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=JEzpLNssOIDvyuYG0HqqSRLAFZCbU8oIu7XNAkVN2RqyU9rsnYm1s7t2kM0bC8RmGOfb5DQkMqiLrTFW599o/0BOs8MMgT1ENextjZmBoL7OSk4LvrMxwox4GWQECAVUNIdF/XSAregLXDuAnItVtJKtjkGt9seXBn8FZln1d2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgLPgag/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgLPgag/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4396C116B1;
	Fri, 28 Jun 2024 18:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719600778;
	bh=ZNwzUKaa3y5SpI0XZ5LFMfIC83k5Pks4WRoj2iWKqAg=;
	h=Subject:From:To:Date:From;
	b=NgLPgag/JClwSIBd5WIWZeGnwWsivjWAwWy9R952rono6RCfIHXpHur0xppRRAo0n
	 D4EJFCwT2iyaw5lj0Y+SDT6NF2Y6mgAcRPZiZLUkroQpCnANbrGaawlECe2w4s1crY
	 iCOcGPXxUZxXrq82I+aMXKSN3/AzPGMI6fY6M4GixZ1vSIRS8BTho2PkIJI+43CniD
	 pWwg7puQ6ecUxXsrc6dxHFsQ8l8g9mzJCLA8ZURt4wvQPmuzUHQNCIcxjq8+peEofw
	 bJUKjjzQF9GBa3Cexu+YFmJbvL3OaLUUtbQrvqes7rZHf1q061sQExBRf2eZ4ezNq9
	 TfWDRx1gwwDVw==
Message-ID: <c045566f90f40cbfd60c7e39f0175d5997b7e437.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.278-rt91
From: Tom Zanussi <zanussi@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users
 <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John
 Kacur <jkacur@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Daniel Wagner <wagi@monom.org>, Clark Williams
 <williams@redhat.com>,  "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Tom Zanussi <zanussi@kernel.org>
Date: Fri, 28 Jun 2024 13:52:56 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello RT Folks!

I'm pleased to announce the 5.4.278-rt91 stable release.

This release is just an update to the new stable 5.4.278
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 7779a526bf00deab50f6c3435b2049c3df943e02

Or to build 5.4.278-rt91 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.278.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.278-rt9=
1.patch.xz

Enjoy!

   Tom

