Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C27C1F582F;
	Fri, 23 May 2025 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748035594; cv=none; b=gz9iSwN/mR47wqv5BS043oT8bBeyTgl/13nPGldZShV4aByi0UFmLT5RQTmFzY3dzsnHL347UUkjpK0LJVmGmS87jODMjlq3j2Nd2bGYOrTs1sCeXSHeETErpDNwGeiQCkchawRrifIF6dXVpRilkby9OiZuppiJAdNXZ3UE5Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748035594; c=relaxed/simple;
	bh=yW5i9tOGdIxs0IhrA0Hmi1ous7kRqD8vZyPP9v1q7jk=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=iYvynIYlUVkn5dA7BZ43n6CwLUMIHPJ+huy3dt0eCJo7j7/52/xyXnJ6A4p335sBWOGxr/NV6K8dniEdikf9cbsMTrDENI/xIfQLzIaUQCx/spswomPQ4EpW/bwd1sKu6jMLAypo4NczA9NB6sL4Ldpx4h3nex4xJGb1tN2GJ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cghMzfYH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cghMzfYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200C4C4CEE9;
	Fri, 23 May 2025 21:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748035594;
	bh=yW5i9tOGdIxs0IhrA0Hmi1ous7kRqD8vZyPP9v1q7jk=;
	h=Subject:From:To:Date:From;
	b=cghMzfYHT561kRuLRFIgNd1rFknERP6Xp1PqyzVzdKZLpVGDy87ce7OObKPHXxbxW
	 PGu/ke4bhcWcyFcrFUGwe48QikoYcC3lj95YVf3kZ58bqXL9uLNIV1pdxyoou1iHCL
	 9j4tIVJl5qwtizw78xUpfPTkTpmeCqS2gGfGnyQOcz4xHyhvKmZstaFGSPyKVdvAci
	 ePbm5iaopkPQ7aKcq/JhaR7Hp3oav4U4Wp3tMCOTkoI6fVyx30EZUn/B4ccHtfHte4
	 jDuuyW3P2Qz7a3S7tvVQRy/3/Az22Q2xr/3iDv+Lo/57CdYLxh+yRKrcsAv4yR1QXo
	 W1jSV2aGhvb9w==
Message-ID: <4421c5e1450b7264b85deaa913df35018601bb19.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.293-rt98
From: Tom Zanussi <zanussi@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users
 <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John
 Kacur <jkacur@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Daniel Wagner <wagi@monom.org>, Clark Williams
 <williams@redhat.com>,  "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Joseph Salisbury <joseph.salisbury@oracle.com>, Tom Zanussi
 <zanussi@kernel.org>
Date: Fri, 23 May 2025 16:26:32 -0500
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

I'm pleased to announce the 5.4.293-rt98 stable release.

This release is just an update to the new stable 5.4.293
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: b0414bb960796a924d2769a6f4010d98f19ddde8

Or to build 5.4.293-rt98 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.293.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.293-rt9=
8.patch.xz

Enjoy!

   Tom

