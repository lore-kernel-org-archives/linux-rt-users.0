Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417EB214A6C;
	Mon,  3 Mar 2025 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020031; cv=none; b=pC/pQOjlLcMhIXdwK1RLCiCHHoqks/T+h70W0dOxB/tE5zEADAzdBh/YVuz4jwVtr5p2DG+iXsoF60JcRBa9vB12TKI/2tKchlnIi5HPqNnTm5UxUhL89yHx3Fy4Q0O35uHQ1C3Oj/temHgoT6mpxW03bzWNevqTmT87Y+UwZRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020031; c=relaxed/simple;
	bh=2onDmEnG7b4m9VlHKZQrMnoF88q/5aHk4leZypcCBGY=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=gYuWUj3OG6LRefrhjLhsC3JvZRK58RqfTJNpDGP3ceYRjhJtMslcXnSVCEXBjHbi5Yec326Y4YHKG/+spv+G3cI+RuzitgxGd3e3voFdAHZ0JSiXWF/7iS5zCdzSGf3rdLC8QzDNxDhMSXsxIks21FryF52BrmOxnJOh8I989nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1Fiv2tX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1Fiv2tX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28239C4CED6;
	Mon,  3 Mar 2025 16:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741020031;
	bh=2onDmEnG7b4m9VlHKZQrMnoF88q/5aHk4leZypcCBGY=;
	h=Subject:From:To:Date:From;
	b=U1Fiv2tXc8uwoNR5/HhxpXtSgcZnJ3ZRlZaQIjXNT31zWHuvQpAnLdPiUwvb+2kEi
	 irLtYhjSxuSkNwddwT+9bEpL0GUWgf3y0El5mS8DRYGxhYJ9UcjZyDnBMPpUQ5KpqL
	 O9wL9xTOfSy9kLZLNaafO39OAXmcgqBKVuM2nOwHeV4u14k4qlwZ69qnYKPp6n7gEA
	 yoUcid3lUiK7pOvYhtIv8gMtP5hmQVblEbboaEXaNCPshNSMeOGlDtfl/ZSKI1AR6x
	 twLvsqDBgCHJtCgQku2UGiIlq1nlMVZl50Numk8IlxQ6LE7ET0l8bTDp5/6tTSRzSq
	 YPEiv9Llbbt1A==
Message-ID: <f37e9bcb58de3311782490bb7ea781622cfeb238.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.290-rt95
From: Tom Zanussi <zanussi@kernel.org>
To: "To: LKML" <linux-kernel@vger.kernel.org>, linux-rt-users
 <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John
 Kacur <jkacur@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Daniel Wagner <wagi@monom.org>, Clark Williams
 <williams@redhat.com>,  "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 joseph.salisbury@oracle.com, josephtsalisbury@gmail.com,  Tom Zanussi
 <zanussi@kernel.org>
Date: Mon, 03 Mar 2025 10:40:29 -0600
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

I'm pleased to announce the 5.4.290-rt95 stable release.

This release is just an update to the new stable 5.4.290
version and no RT-specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: d1512e95c4cc010f6750b8cb879cacd6780ba9de

Or to build 5.4.290-rt95 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.290.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.290-rt9=
5.patch.xz

Enjoy!

   Tom


