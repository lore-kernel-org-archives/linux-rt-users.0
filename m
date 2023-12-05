Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Kw9ugRFt"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB5DA9;
	Tue,  5 Dec 2023 09:04:48 -0800 (PST)
Received: from canonical.com (1.general.jsalisbury.us.vpn [10.172.66.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DA3963FF90;
	Tue,  5 Dec 2023 17:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1701795886;
	bh=L3Hv3hhw1XNFiYnm+KfMClgCTUgvdYKgMHhrQDcGnsY=;
	h=From:Subject:Date:Message-ID:To;
	b=Kw9ugRFtyuC8g+dOZ3qEddvVOmywyGLBZH8KhRfX4H3iHYgVd6Gc1m271XwrJB3vZ
	 atGtw/8eZwyL6dlE8OI/xNmRyaeScY5tHu3aX8YS652asZtS5UBeUcMr2GzsUvrgXZ
	 Q7TC/aWSnRJjDPBZwLZFpV5Y1LMLdeZ2RAT/nZSJNcWpYO0Qu2Uf456lWx3R0hJWd4
	 WViVU2Mz9HUnacS8AHjKoTtqQYdTL/o31l3eZ7L8ErypCptsu3z3V+WkMzQ/DZmRgB
	 tWGVjVOCmyuNyd4arQ3gTTN6RzHl4Y8suoLoFvCbqDlPHnSAW8uEgQ9JgD3WCJStek
	 Uex5ttJ92xWgg==
From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [ANNOUNCE] 5.15.141-rt72
Date: Tue, 05 Dec 2023 17:00:32 -0000
Message-ID: <170179563245.1513973.4035707288173577889@jupiter.home.arpa>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.141-rt72 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: e9e280348657bf29b5f35e37e34e4da26821116c

Or to build 5.15.141-rt72 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.141.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.141-rt72.patch.xz


Enjoy!
Joseph Salisbury
