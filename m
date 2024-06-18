Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FE415E5BB;
	Tue, 18 Jun 2024 19:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740517; cv=none; b=Okq7nOUWi/fSAVtLyS1WRP4suxpE+i9uc2qxs69OzJmZySKdZ1SrkG237NURp2/peIhNDdQs8wmgIHwISwmOWHphe/rnfY9r4efY6m7N2r7XEG3WGyOFwzxTs7Z46hc4sRjMMCzm9wPkKuILoVhw/nPrTx20CV65OGn0cYQfZvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740517; c=relaxed/simple;
	bh=a1ezqYyFWTWCsyRbayXF3irpI48AKB+/bJaZ3CHceTA=;
	h=From:Subject:Date:Message-ID:To; b=ptHZnzMyrQmg65cidq52HPRxe9CRwzecNE94ETigL0ReQT3+IPdwhX6iIrd1/g+lB0JGF8CXvJvtxVpocI17MLVYiZnqMobv07P9NlVkts468TrA+IwoAQKhn/r59tKjEeZXg/vvQkT8TjKbOKxFnya3fQsRT6TL3SxnNy2Gg/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ag+S2VHL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ag+S2VHL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3518DC3277B;
	Tue, 18 Jun 2024 19:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718740516;
	bh=a1ezqYyFWTWCsyRbayXF3irpI48AKB+/bJaZ3CHceTA=;
	h=From:Subject:Date:To:From;
	b=Ag+S2VHLkqJzcxR7LzXgLkAPyf2Nj9saEwA2mbqjyXmH6qitWEHVhIerTmCAK2NDy
	 /E26MN4f74p1XGLniVOfBfB58DCTot3ruASmr/fcAfxvM3/YWb3gkiFxVWD1M1dQpX
	 oy2y47hMsaxBdCtNG2eXAzgAFuv/MoPbX6yXQXeTAOwpSfVX93KxfUE6OB6ApjVaa7
	 xpl7kCoSRzO4elBfVzV401qtTf8vHjN/hEzTJXjrTnddFyGH5YjRbIaBSlSegf+gOd
	 1ZHrf/QfUk0R/ctV6XMQ+rwfKdUzAF1ZcaLMnd0OzTpwSAjq2OmosHA/S1WaW2+YC4
	 ZK8CcitvhFXdg==
From: Joseph Salisbury <jsalisbury@kernel.org>
Subject: [ANNOUNCE] 5.15.160-rt77
Date: Tue, 18 Jun 2024 19:54:54 -0000
Message-ID: <171874049478.5808.17334648388629498282@salisbury-p51>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>,jsalisbury@kernel.org
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.160-rt77 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 1671cc3c15cc3955367d7f7ab4e2759ac1c798e1

Or to build 5.15.160-rt77 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.160.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.160-rt77.patch.xz


Enjoy!
Joseph Salisbury
