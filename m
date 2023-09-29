Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FD16728D
	for <linux-rt-users@vger.kernel.org>; Fri, 29 Sep 2023 22:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B69C433C9;
	Fri, 29 Sep 2023 22:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696024843;
	bh=89jTrq1DyohzStlU5zc3Tha8Xsv29TxLnDk3KQTTdzE=;
	h=Subject:From:To:Date:From;
	b=MM/syiKFglXQ2lEg2hwnIyLOvfZzpDjt2OwuGkl2+VUgjORKteY3mcRFPB8Jsd10V
	 mMXHWo30aPjHxRI2nW6UCqH3p/oPymhziDnygYUjUBQPzEAcWFcPVFacORiRlWPNkt
	 3LLRLYiGTHvGn4edq36bHpWJnYumjkp0HSHMtLqvNTU63j2OUkAK0P1RfTl00GqMv5
	 QwdOHvaZWOcJpFprSoO5EGH2005kvg5clIc2CKb5g6HXcnNtl3bXfa+UcW5Xv8brNn
	 W9PAY7JfSSmM9Ij/+FEMYQfL8O4RMluwApUzIba5N7I8G0o+N095uYCUctAmksRroy
	 zUlX3KUM8s2TQ==
Message-ID: <666b831988329de027e63def44296a7b5a34149e.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.257-rt87
From: Tom Zanussi <zanussi@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users
 <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John
 Kacur <jkacur@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Daniel Wagner <wagi@monom.org>, Clark Williams
 <williams@redhat.com>,  "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Tom Zanussi <zanussi@kernel.org>
Date: Fri, 29 Sep 2023 17:00:37 -0500
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

I'm pleased to announce the 5.4.257-rt87 stable release.

This release is just an update to the new stable 5.4.257
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 78f7ec6fa8bdf48ab8fcbccef05f9cb882c124ce

Or to build 5.4.257-rt87 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.257.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.257-rt8=
7.patch.xz

Enjoy!

   Tom

