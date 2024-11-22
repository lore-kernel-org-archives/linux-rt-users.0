Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE481D79BB;
	Fri, 22 Nov 2024 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732314755; cv=none; b=VHjjckacO24teEP1zkzVU2kB1/WXEAT7G5gIBfMaVB0hftdGi8Et9vq0uOKqhb8RkD4Tno4rKux67evAl142dQAFPy3Rw9dd7Rsa7ACJ+KDLKsKSKgKpddScVO6naSsjVYwnYWYZK/k17Zteh/HlQEd+rblCFti14bzBQkO/a3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732314755; c=relaxed/simple;
	bh=tplzAKeYouc53qf55REz7Pii8ETAmnHAGvT0Hxhjvr8=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=Ewu86r6K5RVTPmhRJDHak68jmCWlTpCCPbEpbgALF7EopeuQ1HxpMNn/8ZHRNIVi9tsUUfILhLsaJqcpjxo/DCucIMsr20pDqyNP8szpyoxvDtqh6pu3mW+bHPkjiJQxMMjargiqCpKhzKncuvNpcVn9RKRbgcab3UClZCjvsLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Il5hSitg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Il5hSitg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59DBC4CED0;
	Fri, 22 Nov 2024 22:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732314754;
	bh=tplzAKeYouc53qf55REz7Pii8ETAmnHAGvT0Hxhjvr8=;
	h=Subject:From:To:Date:From;
	b=Il5hSitgyJX89Dz7Sru9iRkATfJSL4O84yDbMaTkE8cQ81gH63tAYupwf4lO37RhA
	 EycLAu3qijj+hfsgAV+2EJyuKBVM3oel936UKMuG3hQxmbRxnWCfXF3q8fNNEMP3W3
	 lyJHxDb1ht6PZBdqmwOmQE3t2WVHa/cjKFd1cUi/0ArRoMxv/QCpMmxWIZmZ63QDRo
	 jgfLn1v4YvAPArLzQJHYic2cvzPkOXvgHIPeUW7E7RfOG4h9P6E1AUctYL/Z/dVk1P
	 csSCb97m4roSk45oytjo6odIPjoVoK8oiPpL5qUYbYA3+H4Rc3XOdz75Whwx3iNHCe
	 VwyAv/yN5Y3tw==
Message-ID: <1f9ef532e9d0a5bbabfb8461c9528418b65e4c78.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.285-rt93
From: Tom Zanussi <zanussi@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users
 <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John
 Kacur <jkacur@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Daniel Wagner <wagi@monom.org>, Clark Williams
 <williams@redhat.com>,  "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 joseph.salisbury@oracle.com, josephtsalisbury@gmail.com,  Tom Zanussi
 <zanussi@kernel.org>
Date: Fri, 22 Nov 2024 16:32:32 -0600
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello RT Folks!

I'm pleased to announce the 5.4.285-rt93 stable release.

This release is just an update to the new stable 5.4.285
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 349db42235361e0e7e123a922cce97e6fd6cc592

Or to build 5.4.285-rt93 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.285.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.285-rt9=
3.patch.xz

Enjoy!

   Tom

