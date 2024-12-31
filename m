Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A742B182D9;
	Tue, 31 Dec 2024 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735670657; cv=none; b=G12AnXB3FJZKHiXuTHGlGaNqT3GbTrh3yEEHmsaWltFwFbl/PTXuwr4rj/dX6hdjc5IZfi30XdScWBRGKxgUw/WL1K1s+pL4tVIdf0Y/ybPL+YU2PXrZVXnfIo7P0bb4hrKHAB6Iy9OgTIrqAWWQKbfXLtJn+zzHvj2MMyQONi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735670657; c=relaxed/simple;
	bh=UThbonH4iDNDzjhBNTtJ5rq8p4QsMFaj4/6IYuZqyws=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=hkk1bNhjv4lSE91aYHcEsY+sdy6gzCLGGh5G1ocfX6zyU7va3xSWO4FsWzPuwD+AnM54V11avxSpRpza2mBN+td7N3g2c7RbMK1FS5fMIRmWFBHkiiiM2NUmMQXT1NDOfzMlqZLYex5drXGZEyDhswc2VYtxNoP/81Ftd9HWKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B13DiMP2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B13DiMP2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA17C4CED2;
	Tue, 31 Dec 2024 18:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735670657;
	bh=UThbonH4iDNDzjhBNTtJ5rq8p4QsMFaj4/6IYuZqyws=;
	h=Subject:From:To:Date:From;
	b=B13DiMP263VcCeYee0DW/GfifehNxaZIiNcopKf8Rr90swPLIQSE76cUGca+Hy6Yq
	 KE51lKP7TqpqYeva89YYRkA2KHlYwGhva5YCLKNo0js/sq/NIsx9OMGMdEAruAZfkw
	 yVeH6EhTvAXluvefATWCXgukNX2YAicuTaBkKEErmMO53dhDwIB8tbQay5TFJfV6rB
	 OZKh8USaMd2I73KHLhaWzOXaRhZ2VPEt1HfJncyOZHL3gvijPmGMOtq+3W8jvW/vWm
	 PwQI9tImJcU9tBLbYVKuzw9eN13UICrJt8GYHq+5+TbA8Evkk9JsaClWS/Ecnl+4YJ
	 dDkyV1L//l1XA==
Message-ID: <e8e340b779ad4f55f76c081b8c75ec0cb15d8c86.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.288-rt94
From: Tom Zanussi <zanussi@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users
 <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John
 Kacur <jkacur@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Daniel Wagner <wagi@monom.org>, Clark Williams
 <williams@redhat.com>,  "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 joseph.salisbury@oracle.com, josephtsalisbury@gmail.com,  Tom Zanussi
 <zanussi@kernel.org>
Date: Tue, 31 Dec 2024 12:44:15 -0600
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

I'm pleased to announce the 5.4.288-rt94 stable release.

This release is just an update to the new stable 5.4.288
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: b819878d2fbc68416286e0050242f6a1a559641e

Or to build 5.4.288-rt94 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.288.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.288-rt9=
4.patch.xz

Enjoy!

   Tom

