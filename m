Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B70878F2B;
	Fri, 19 Dec 2025 22:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766184112; cv=none; b=kFCa30DUxs75NzojWUFO/Ye1JqtryzjBUOmMEXDEBf5n2kHIvaLTu6ynSSbBElAKgKR/mluEISaY/EQMW/JpFiVO/r9bc85PtuVABGfFZoTYHAYb6JOzw6QmvcS68vQ2b4m43wXfL0xIyjbAfZLujD/4UJ8ZVSToumIzNwfT/e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766184112; c=relaxed/simple;
	bh=392zwtZ/s6z8FqtcnEugIg5pw/wJ3PJzR+u32Bm067E=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=kRfzCPFu/6x4uEaEEGIw4SDH6xCM6qsItkrBscWnY3XUsouwljVveWxyFKOm1rREV2hcrrQ6ygt6yQcRIXNfNT+U1EQbGRSZ9EXptFhQ8W+zNWx8IMqov1yt73uJRy9NPs6InmPNFOBnhbkimN3141Lc38hv+Pxxm4DgWdNxzg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rX5Qe7AL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rX5Qe7AL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBACC4CEF1;
	Fri, 19 Dec 2025 22:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766184111;
	bh=392zwtZ/s6z8FqtcnEugIg5pw/wJ3PJzR+u32Bm067E=;
	h=Subject:From:To:Date:From;
	b=rX5Qe7ALGwczdsWSvMPTZOhbMsezvJot+quZl/qMgZyupoamFZ87vxAfg7YCb6THa
	 MO6uHLPbkLLlMC3gdAxh8KPVkzhaeUwJd+oRYjHKOxHYJ/4GDa7sUox386V+lQpCii
	 vPX+lRAWh9AgcG3b8rdfvauiPmQXaLBagWvq/hVTsiL4Ms+Pd1mgpLphAQqi9YDzRa
	 We6WC28LvsROd+gsu0obBde7U05dRq0t5+TRPNAsLeqAkYxPfjW7YtBFD/zSTTDwBR
	 0hWiU4Rygo4dyE/H8Sw+mPboteWyKfnf4B+CrQeRl7ojJpagjz2o1Vh8Do5gdv8TgG
	 OlfxTgFRRtWQw==
Message-ID: <6c6f82df4569575b1da86c29504c5840d2c63ec5.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.302-rt104 (EOL)
From: Tom Zanussi <zanussi@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users
 <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John
 Kacur <jkacur@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Daniel Wagner <wagi@monom.org>, Clark Williams
 <williams@redhat.com>,  "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Joseph Salisbury <joseph.salisbury@oracle.com>, Tom Zanussi
 <zanussi@kernel.org>
Date: Fri, 19 Dec 2025 16:41:50 -0600
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello RT Folks!

I'm pleased to announce the 5.4.302-rt104 stable release.

This release is just an update to the new stable 5.4.302
version and no RT specific changes have been made.

NOTE: This is the final 5.4 stable-rt kernel. Because the upstream 5.4
stable kernel has reached end-of-life, so now has the 5.4 stable-rt
kernel, as expected.

If you're still using the 5.4 stable-rt kernel, you should probably
upgrade to a newer supported version.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 4214d1e5ba9a0b07119b2897c19fb75a69931017

Or to build 5.4.302-rt104 directly, the following patches should be applied=
:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.302.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.302-rt1=
04.patch.xz

Enjoy!

   Tom

