Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F09283FDC;
	Sat, 22 Aug 2026 02:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787367527; cv=none; b=Ua3r6o370K5/bFgBOxLQVSPSOK7InRXXQFDZLltIOgKnu4c9GzRoY701VNiJ8BJtvgvF1kIda8rGp0p19KnslPzXVJgsbDxJVEuZwZyF9GO7uqsaOFPD48CCVuIkznQacOKGT3K+tzk0Qi9IcuiDm7GxYORDya3QmwgtB4mhLP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787367527; c=relaxed/simple;
	bh=NHuzlsHgRXP24xZE2JI5/W4TbM76b8kiBS4ghBek1XI=;
	h=From:Subject:Date:Message-ID:To; b=h5tuwktLOjcgS/H8cqmSIpZN7f49Qe0ow6BH/wdeHO/mf1KH5ugN24Joqk8psUlDNg4W2hElHlbaXzRU+i4tVE8ug9VMN86EmtlH9C6/2X1ea+TY9QVfkMigHmYXPdqNdVsENr84+8QMXPISjQ93Y98ztjSf4GZtshWFZDFqlHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZGOeBDN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZGOeBDN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F77B1F000E9;
	Sat, 22 Aug 2026 02:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787367525;
	bh=6IvMmGnmLqdzhfCAtu8w1PvtcI4aVYgEqrxJ6e1tHxQ=;
	h=From:Subject:Date:To;
	b=GZGOeBDN2tn4tYC7PLV5JC0hdlsc5vq4YrX+3MEBCECvpMtYEV0N+A2RL1SpwKgk6
	 rYD1Bj0Ydi3QVEkixxVu9yQM8RbU3QVSvqHyozAc+HSonU9dmySuF/zwOrlZJSse4D
	 D8Jvo60hdfHp5FfCQaje7Q7vaXIOyI5V9ioJ6Id0Ii3aOyLhgKTPUqakerrIg1gJDU
	 Z/fFvf1ndkqjAEDiW0UQWitNj2w8Z1BTEp5MuR3Kq4ziqwDINA0l9tmR9v5WszENxL
	 kjHx7YGc8lpRojZUXIVxBHcc6jSs4p5+g1OOGm4NaMAPYdzSkIxPx60CFn08VNPa2b
	 OIBDBpHZe2q/Q==
From: Joseph Salisbury <jsalisbury@kernel.org>
Subject: [ANNOUNCE] 5.15.216-rt98
Date: Sat, 22 Aug 2026 02:56:21 -0000
Message-ID: <178736738171.117297.1530913086452151569@saturn>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.216-rt98 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 231935a3aa62d687980ca8d1aca8e31eaad1c1d5

Or to build 5.15.216-rt98 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.216.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.216-rt98.patch.xz


Enjoy!
Joseph Salisbury
