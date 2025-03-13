Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1861F418B;
	Thu, 13 Mar 2025 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741896845; cv=none; b=BiAVz+bACox8mb+nsw1xaA7eYHYxjwxwFMokhlAyoJsHh9nKkLXfXFv9ir1l6Y9sfFUnfw3qE8fL/vDnlabcL+zlMccqgyvznvzCi5fngcTbTUcYMX9ZiOX8kNGEp8GrBGm8fhGhSUOncT5IpyxSml4XxhyaA59B11W73nmgj9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741896845; c=relaxed/simple;
	bh=d0438YSJjxB+9yjxJTjmg+eiSvzdjIpE7hGkOviNOms=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=fcCDaiuIXHv2kee7sULXPsX86TAv51vFNoUFuY8LAzrmW9u91llf+XHmcHOrJy6O6bmoq2NXAYPoIM8i4Hy5BnbANCDHN7o0O22ZjZ4Tebkay/lcRC+La5WfoEZSPfAeZUimTcul1V8pIFtgWrc5UdwxkScHxstOIMQUFvMxh7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+mqUpWm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+mqUpWm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAE0C4CEDD;
	Thu, 13 Mar 2025 20:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741896845;
	bh=d0438YSJjxB+9yjxJTjmg+eiSvzdjIpE7hGkOviNOms=;
	h=Subject:From:To:Date:From;
	b=T+mqUpWmB5SEeVW/xCXE5aIHMJALotmXU5xS95ibiidrIqNrudI8FuSdkRGjCifbl
	 ujLzY7/3IDgM5LbvR9igmdcB9zuaLQjN0MwnKZ74kpbaO2ZaaqH38Ep7Z2wky+qiFb
	 /58mjc265JEevFcjzYduXM6RKBtqagwWfhev64o/nzRQe48TjsYLPDdnX/yL99Wd3I
	 czZDlTXM+oN2Rc0f0nWt2YTV7kr+eRI/AGNd1lpbAlNqwR7LN+jjp2NKGMwpQLXqui
	 iO/t96ccCAQbnD2XNOp+SPC9emK3J6nviXTye83ATNXTcRvNBNhbTE2bXo9FyLvTVe
	 8FltKDD70kgiQ==
Message-ID: <c232ee2b77d601f5a6d41f4a96df99189aff2e4d.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.290-rt96
From: Tom Zanussi <zanussi@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users
 <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John
 Kacur <jkacur@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Daniel Wagner <wagi@monom.org>, Clark Williams
 <williams@redhat.com>,  "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Joseph Salisbury <joseph.salisbury@oracle.com>, Tom Zanussi
 <zanussi@kernel.org>
Date: Thu, 13 Mar 2025 15:14:03 -0500
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

I'm pleased to announce the 5.4.290-rt96 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 6ad55e55c574e9cdd1bce8ad3c5bb9dedc1c53ab

Or to build 5.4.290-rt96 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.290.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.290-rt9=
6.patch.xz


You can also build from 5.4.290-rt95 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.29=
0-rt95-rt96.patch.xz

Enjoy!

   Tom

