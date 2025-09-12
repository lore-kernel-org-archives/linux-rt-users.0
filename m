Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9FB2765D2;
	Fri, 12 Sep 2025 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757713206; cv=none; b=WhqapwJu4ZaBYIA5fKmzraDlofdzTHKlFOnKiNY0rj6S0srzatSd1GTV2vfTI4wLbx+e1YePkvDo0Ez/I6/JwwXcVGi1nQsroXqYBO6UKjxBvn1zemUwl8RZTaPbnr29cOfgLXrwGPYhNn2n44CQ/b03Ock0tYloaEsHQNpzqkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757713206; c=relaxed/simple;
	bh=qL4PYKo6Hx/L+RXpXx9s9PHG3KAXexWrGCppzeQ8rvk=;
	h=From:Subject:Date:Message-ID:To; b=SZ7VDpq/jF+IFMeggc9WEZufYLJ6ikeRmpywpuxaVIXLfnm2CBptJT955e5F6NdOFBoEa+dWkREsmXf1NBfFWZ78lwkHuPj86joQL7VspD1aYKlKq6ainFM9tBbXJlyn83uYdWXsmCe5mHdjgJo17TbvCJpTkoczq+NSL8EX+sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D5BC4CEF1;
	Fri, 12 Sep 2025 21:40:05 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.106-rt61
Date: Fri, 12 Sep 2025 21:39:33 -0000
Message-ID: <175771317310.684554.7847419842462276329@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.106-rt61 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 19edbbe5afeca40033bbe613c627d51fc26ba346

Or to build 6.6.106-rt61 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.106.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.106-rt61.patch.xz


Enjoy!
Clark
