Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B682F5461;
	Fri, 31 Oct 2025 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761941386; cv=none; b=ES8w0c/9r1omX6cRM2o+nU+y9oe4FB529J2r8IzvU3cOoOWV7CpAjhPZT+5af0gDi3J7xlgFHdKIa4TYbFaXiwr0JiXBWS1y0C4ABG/59HxjbhlptYVm6GQF18tbfI+Ock1k07Pe9izI5h8VW9ofRW8YJO9/8h+xxEE1X7ZAzOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761941386; c=relaxed/simple;
	bh=upB3DJund/bUciie7q29SSc7KIzaZY4JOUoIM4LaizA=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=r1Dk12xYJh8h4gPOH1EoitYWvb1J3eVn34iP2GC2lYwgaF/KS3v+kIjNxc4DI4JDaaAl0l2nV7ZvF/RDE3falXOLafzqIn+0qJJ2SHL9v0KshQgbCcuhAzW2cFlIijaB6eItSJVJtCCG8ppVthNumiaW5I4uKh/DvrvSMAeeq84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHYjv/CL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHYjv/CL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204DFC4CEE7;
	Fri, 31 Oct 2025 20:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761941385;
	bh=upB3DJund/bUciie7q29SSc7KIzaZY4JOUoIM4LaizA=;
	h=Subject:From:To:Date:From;
	b=oHYjv/CL0IM5829SceJU15Tyz8nABR7m+bMkY0AUD1HgN47L1KGHFYt4Tc3nWK3uh
	 AruFX6UmQSdjX1BONULJTJmM2HvzIms3ou5QdBikEos6QOwS52wKmRGjqAK6O1I18L
	 E7zPnxUbod3F//kz5Kycn1oI9sV/ZY6PGuquSK1/j4H0hMvU9s2pTjv3oN0SFwHNcp
	 6i8GvYqq7egBsHWWtm6V6hzgZPaPHWUeDbzIilIq2jNarF4tMHR/iS7yLWMh47oXaW
	 zXkAIdjFrwpqXSX+6SnySZCUQI/wRAF5t91aXNjd/rSUmwJtf9OP+tlpIzecfTsLCA
	 aglZgxhP6c1ww==
Message-ID: <9fae13926ca3efe4aa8727647fb420bfefea5c9c.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.300-rt102
From: Tom Zanussi <zanussi@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users
 <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John
 Kacur <jkacur@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Daniel Wagner <wagi@monom.org>, Clark Williams
 <williams@redhat.com>,  "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Joseph Salisbury <joseph.salisbury@oracle.com>, Tom Zanussi
 <zanussi@kernel.org>
Date: Fri, 31 Oct 2025 15:09:44 -0500
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

I'm pleased to announce the 5.4.300-rt102 stable release.

This release is just an update to the new stable 5.4.300
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 1df03881b3ac9ac567f5f2c91d7ef05f9cdf5891

Or to build 5.4.300-rt102 directly, the following patches should be applied=
:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.300.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.300-rt1=
02.patch.xz

Enjoy!

   Tom

