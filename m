Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F13220687;
	Fri,  8 Aug 2025 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754686276; cv=none; b=U9YIYDsqcPHDpiqUL70bXAXKUOCLGb9HPEljno2zNKxMiWA1KJLwLiyru2wMENIKFL8tZgWgzh+RpKOg/pGJkdOU+YHs4smi7uzdUba4qOTChOZ5LFMZPCggSLFr2GUut2UXLXsDz1kYpzqjW3gJ/+GL3c8HaAIhTQGVTZzUu7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754686276; c=relaxed/simple;
	bh=31Ona4YptkLnY7hwH+W90Nq1bn4ZaSRBUysNTltRM2A=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=g71ZviTefZwXLCL31K8EqbVMIt567YD0swMY2rOM6TUWXkjSZtVTF86tOP+wo771euGKpXp6aKZ38dTW7bsJ56/uJThB8FMXD1F515xwftAGCWJlcT+82eJxL85qcV6QvhL397M09QhonuAi07u6vbK+fa83bJoo/eVuKihCR8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRe/8c4U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRe/8c4U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE49C4CEED;
	Fri,  8 Aug 2025 20:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754686275;
	bh=31Ona4YptkLnY7hwH+W90Nq1bn4ZaSRBUysNTltRM2A=;
	h=Subject:From:To:Date:From;
	b=jRe/8c4Uwk0FZoAjNCZhF0pgp23xPZP6MGovwClV0Y8cWyurw3EhBhNw9hPk4v/3v
	 UecrfdftDlh2gOR4n3UgQT5NvEGgpddDHPlq/eyx6LgdxtICKpUaFJZ08qY6/I/Zwj
	 RoK63Ph1DW4kTnmz5b9wJFxoAsRYdPQ6MB5zeo/+5KDWk47tCkcgV2M2MlaNbKj40w
	 aPw9UPcE1mkRe89Qjr10FRLiYW5VFWhFt+usM1N6yD2LNoVPh/o4dFV8K/1w9t/deI
	 gtBGOiXRj2wKEfpSqASLXavC0TSJJLfu8AZHMHI8ihWRpo7M5TIAdpzDubQnLEcgsG
	 qNWI3VeRlAfJg==
Message-ID: <4a0198d9416721bb02c027d7b273e5ca6bc41c3f.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.296-rt100
From: Tom Zanussi <zanussi@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users
 <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John
 Kacur <jkacur@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Daniel Wagner <wagi@monom.org>, Clark Williams
 <williams@redhat.com>,  "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Joseph Salisbury <joseph.salisbury@oracle.com>, Tom Zanussi
 <zanussi@kernel.org>
Date: Fri, 08 Aug 2025 15:51:13 -0500
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

I'm pleased to announce the 5.4.296-rt100 stable release.

This release is just an update to the new stable 5.4.296
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 39b17f7d3bb71d69a4ad560f8b80dd922961a5ae

Or to build 5.4.296-rt100 directly, the following patches should be applied=
:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.296.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.296-rt1=
00.patch.xz

Enjoy!

   Tom

